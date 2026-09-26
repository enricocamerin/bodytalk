# BodyTalk Protocol Navigator

Read this first in every session. It is the project's memory: keep it current.

## What this is

A single-page web app for navigating the BodyTalk protocol chart (sections,
nodes, dimensions, techniques) and recording sessions. UI text is in English;
the owner writes to Claude in Italian.

## Layout

| Path | What it is |
|---|---|
| `index.html` | The whole app: HTML, one `<style>` block, one `<script>` block. No framework, no build step, no npm. |
| `_headers` | Hosting cache rules (every path revalidates, so a new deploy shows up on reload). |
| `sql/` | Data migrations applied to the Supabase project. See `sql/README.md`. |
| `supabase/functions/protocol-data/index.ts` | Source of the edge function the app talks to. Deploy it (Supabase MCP `deploy_edge_function`, `verify_jwt: false`, the access code is checked inside) whenever it changes. |
| `docs/` | Standalone reference pages (e.g. `brain-chart-study-key.html`). |
| `.claude/skills/` | Project skills: `ship` (change → browser check → PR → merge → Netlify, without asking; written for this project), `frontend-design` (visual design guidance) and `webapp-testing` (Playwright checks). The last two are copied from github.com/anthropics/skills, Apache-2.0. |

## How the app works

- All reference data comes from the Supabase edge function
  `protocol-data` (`const API=` in `index.html`), gated by an access code
  sent as the `x-access-code` header. Data changes go in `sql/`, not in the HTML.
- `const BUILD = "..."` in `index.html` is shown in the header. **Change it on
  every change to `index.html`** so the owner can tell which version is loaded.
- CSS uses design tokens on `:root` (`--void`, `--card`, `--edge`, `--text`,
  `--em`, `--r`, ...). Reuse them instead of hard-coding colours.
- Fonts: Inter and IBM Plex Mono from Google Fonts.
- Text typed by the user goes through `esc()` before reaching `innerHTML`.
- Must work on a phone: respect reduced motion, keep visible keyboard focus.

## Rules from the owner

- Always cite sources for factual content (anatomy, function, protocol text).
  Never invent facts or attributions. Record the sources next to the data.
- The PaRama chart wording is entered by the owner, never written by Claude.
- Commit and push at the end of every piece of work; nothing is kept
  otherwise. Work lands on `main` through a pull request.
- **Don't ask, publish.** When a piece of work is done and checked: push,
  open the pull request, merge it into `main` yourself, then confirm the
  Netlify deploy. Netlify project `bodytalk-protocol-navigator`
  (site id `27ad126a-6ff8-44b6-a841-f0abfd0e0fc4`,
  https://bodytalk-protocol-navigator.netlify.app) deploys `main`
  automatically; check the new deploy is `ready` on the merge commit and
  tell the owner the live `BUILD`. The `ship` skill has the full steps.

## Starting a new session

1. `git log --oneline -10` on `main` to see where things stand.
2. Read the latest `sql/README.md` entries if the task touches data.
3. Update the "Current state" section below when you finish.

## Current state

- Build `orientation-tab`: qualifier tabs have a scope (`dim_qualifier_set`
  `only_under` / `not_under` / `show_empty`; `qualInScope` in `index.html`)
  and show on BodyTalk nodes only. Tentacle (11) shows only in Section 3;
  Orientation (12) shows everywhere else. **Open:** the Orientation items
  come from the owner's chart and are not entered yet (the tab shows an
  "awaiting" note). Add them as children `12.1`, `12.2`, … of node `12`.
- Edge function v23: `dim_protocol_node` (1136 rows) and the links are read
  page by page (`restAll`, 500 rows a page). PostgREST returns at most 1000
  rows per request, so above 1000 nodes the last-written rows (the ACIM
  domain among them) silently went missing. Any table that may grow past a
  few hundred rows must go through `restAll`. The header shows
  "BodyTalk · N nodes": N must equal `select count(*) from dim_protocol_node`.
- Build `four-domains`: the home page shows four domains, ACIM, BodyTalk,
  Healing Code, Access (level-1 nodes with non-numeric codes `ACIM`, `BT`,
  `HC`, `ACCESS`). BodyTalk holds the numeric protocol unchanged: the app
  treats numeric level-1 nodes as children of `BT` (`isDomain`, `inBodyTalk`,
  `upOf` in `index.html`). ACIM holds `ACIM.1` Text, `ACIM.2` Workbook for
  Students, `ACIM.3` Manual for Teachers, `ACIM.4` The Song of Prayer.
  `dim_protocol_node` has `link_url` and `sources`: a node with `link_url`
  shows "Read the original at …" and its card a small link.
  The four books hold all 788 official entries (chapters, sections, lessons
  1–365), each with its `+` and a link to its page on acim.org
  (`sql/2026-09-26_acim_books.sql`). Source: acim.org's own table of
  contents, `https://acim.org/we-api/en/toc` (JSON). acim.org answers 403
  to curl's default User-Agent: send a browser User-Agent. The environment
  "BodyTalk" needed its Network access changed from "Trusted" to allow it.
  Healing Code and Access are empty until the owner gives their content.
  Before it:
- Build `sessions-independent`: saved sessions no longer depend on the
  protocol tree. Each saved step keeps its own `protocol_name`; the foreign
  key from `fact_session_step.protocol_code` to `dim_protocol_node` is gone
  (`sql/2026-09-26_sessions_independent.sql`), so nodes can be renamed, split
  or removed freely. The Log shows the saved name. Node 2.2.1 "Birth /
  Environmental / Body" now holds three children, `2.2.1.1` Birth,
  `2.2.1.2` Environmental, `2.2.1.3` Body, each with its `+`. Before it:
- Build `plus-everywhere`: the microphone and all voice commands are gone.
  Every node page, down to the last leaf, has a `+` beside its title that
  adds that node to the formula; the top-level section cards have a `+` too.
  Before it:
- Build `formula-hide`: the formula can also disappear completely. The `×`
  at the right of the tray title bar hides it; a small "Formula n" pill
  (bottom left) brings it back open. Adding a step while hidden bumps the
  pill's count. Before it:
- Build `formula-fold`: the formula tray starts folded to a title bar
  ("Formula", step count, current step); tapping the title opens and closes it. While folded, adding a step
  bumps the count. Before it: `formula-tray` (PR #2: raised tray, emerald
  edge, current step filled) and `search-a11y`.
- Section 1 › Brain (`1.10`) data is in production; the `CHART.*` note bodies
  wait for the owner's chart wording (`sql/brain-chart-notes-fill-in.sql`).
