import "jsr:@supabase/functions-js/edge-runtime.d.ts";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SERVICE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

const CORS = {
  "access-control-allow-origin": "*",
  "access-control-allow-headers": "authorization, x-client-info, apikey, content-type, x-access-code",
  "access-control-allow-methods": "GET, POST, DELETE, OPTIONS",
};

async function rest(path: string, init?: RequestInit) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/${path}`, {
    ...init,
    headers: {
      apikey: SERVICE_KEY,
      Authorization: `Bearer ${SERVICE_KEY}`,
      "content-type": "application/json",
      Prefer: "return=representation",
      ...(init?.headers ?? {}),
    },
  });
  const text = await res.text();
  if (!res.ok) throw new Error(`${res.status} ${text}`);
  return text ? JSON.parse(text) : null;
}

/* PostgREST returns at most 1000 rows per request: read big tables page by page */
async function restAll(path: string, pageSize = 500) {
  const out: unknown[] = [];
  for (let offset = 0; ; offset += pageSize) {
    const sep = path.includes("?") ? "&" : "?";
    const page = await rest(`${path}${sep}limit=${pageSize}&offset=${offset}`);
    out.push(...(page ?? []));
    if (!page || page.length < pageSize) return out;
  }
}

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...CORS, "content-type": "application/json; charset=utf-8", "cache-control": "no-store" },
  });
}

async function sha256(s: string) {
  const buf = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(s));
  return Array.from(new Uint8Array(buf)).map((b) => b.toString(16).padStart(2, "0")).join("");
}
function same(a: string, b: string) {
  if (a.length !== b.length) return false;
  let d = 0;
  for (let i = 0; i < a.length; i++) d |= a.charCodeAt(i) ^ b.charCodeAt(i);
  return d === 0;
}
let cachedHash: string | null = null;
async function accessHash() {
  if (cachedHash) return cachedHash;
  const rows = await rest("app_access?select=code_hash&id=eq.1");
  cachedHash = rows?.[0]?.code_hash ?? null;
  return cachedHash;
}
async function authorised(req: Request, url: URL) {
  const supplied = req.headers.get("x-access-code") ?? url.searchParams.get("code") ?? "";
  if (!supplied) return false;
  const want = await accessHash();
  if (!want) return false;
  return same(await sha256(supplied), want);
}

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: CORS });

  const url = new URL(req.url);
  const action = url.searchParams.get("action") ?? "reference";

  try {
    if (!(await authorised(req, url))) {
      return json({ error: "unauthorised", need_code: true }, 401);
    }

    if (action === "check") return json({ ok: true });

    if (action === "reference") {
      const [nodes, nervous, planets, organs, matrix, tentacles, technique, acim, notes, images, quals, keywords, entries, links] =
        await Promise.all([
          restAll("dim_protocol_node?select=*&order=code"),
          rest("dim_nervous_system?select=*"),
          rest("dim_planet?select=*"),
          rest("dim_organ_component?select=*"),
          rest("dim_matrix?select=*"),
          rest("dim_tentacle?select=*"),
          rest("dim_technique_step?select=*"),
          rest("dim_acim_lesson?select=*"),
          rest("dim_note?select=*"),
          rest("dim_image?select=*&order=sort_order"),
          rest("dim_qualifier_set?select=*"),
          rest("dim_keyword?select=*&order=sort_order"),
          rest("dim_entry_point?select=*"),
          restAll("protocol_dimension_link?select=protocol_code,dimension_table,dimension_code&order=protocol_code,dimension_table,dimension_code"),
        ]);
      return json({ nodes, nervous, planets, organs, matrix, tentacles, technique, acim, notes, images, quals, keywords, entries, links });
    }

    if (action === "sessions") {
      const device = url.searchParams.get("device");
      if (!device) return json({ error: "missing device" }, 400);
      const rows = await rest(
        `fact_session?select=id,session_date,title,notes,created_at,fact_session_step(id,parent_id,kind,is_branch,step_no,group_no,protocol_code,protocol_name,note)&device_id=eq.${encodeURIComponent(device)}&order=created_at.desc`,
      );
      return json({ sessions: rows });
    }

    if (action === "save" && req.method === "POST") {
      const body = await req.json();
      const { device_id, title, notes, session_date, steps } = body;
      if (!device_id || !Array.isArray(steps) || steps.length === 0) {
        return json({ error: "device_id and at least one step are required" }, 400);
      }
      /* sessions keep their own copy of each node name: they do not depend on the tree.
         Older app builds send no name, so fill it from the tree when it is missing. */
      const missing = [...new Set(steps.filter((s: any) => s.kind !== "parcel" && !s.protocol_name && s.protocol_code).map((s: any) => String(s.protocol_code)))];
      const names: Record<string, string> = {};
      if (missing.length) {
        const rows = await rest(`dim_protocol_node?select=code,name&code=in.(${missing.map((c) => '"' + c.replace(/"/g, "") + '"').join(",")})`);
        (rows ?? []).forEach((r: any) => { names[r.code] = r.name; });
      }
      const created = await rest("fact_session", {
        method: "POST",
        body: JSON.stringify([{
          device_id,
          title: title ?? null,
          notes: notes ?? null,
          session_date: session_date ?? new Date().toISOString().slice(0, 10),
        }]),
      });
      const sessionId = created[0].id;
      const idMap: Record<string, string> = {};
      const remaining = [...steps];
      let guard = 0;
      while (remaining.length && guard++ < 60) {
        const ready = remaining.filter((s: any) => !s.parent_tmp || idMap[s.parent_tmp]);
        if (!ready.length) break;
        const payload = ready.map((s: any) => ({
          session_id: sessionId,
          parent_id: s.parent_tmp ? idMap[s.parent_tmp] : null,
          kind: s.kind ?? "step",
          is_branch: !!s.is_branch,
          formula_no: s.formula_no ?? 1,
          step_no: s.step_no,
          group_no: s.group_no ?? null,
          protocol_code: s.kind === "parcel" ? null : s.protocol_code,
          protocol_name: s.kind === "parcel" ? null : (s.protocol_name ?? names[s.protocol_code] ?? null),
          note: s.note ?? null,
        }));
        const rows = await rest("fact_session_step", { method: "POST", body: JSON.stringify(payload) });
        ready.forEach((s: any, i: number) => { idMap[s.tmp] = rows[i].id; });
        for (const s of ready) remaining.splice(remaining.indexOf(s), 1);
      }
      return json({ ok: true, session_id: sessionId });
    }

    if (action === "delete" && req.method === "POST") {
      const { session_id, device_id } = await req.json();
      if (!session_id || !device_id) return json({ error: "missing ids" }, 400);
      await rest(
        `fact_session?id=eq.${encodeURIComponent(session_id)}&device_id=eq.${encodeURIComponent(device_id)}`,
        { method: "DELETE" },
      );
      return json({ ok: true });
    }

    return json({ error: "unknown action" }, 400);
  } catch (e) {
    return json({ error: String(e) }, 500);
  }
});
