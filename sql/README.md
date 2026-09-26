# sql/

Data changes applied to the Supabase project behind the BodyTalk Protocol Navigator.
The app itself (`index.html`) reads everything from these tables, so a change here
needs no redeploy — only a reload of the reference data.

| File | What it does |
|---|---|
| `2026-09-20_brain_box.sql` | Creates Section 1 › Brain (`1.10`): 46 protocol nodes, 39 `dim_nervous_system` rows (`BR.*`) with sourced Anatomy/Function text, 39 empty `dim_note` rows (`CHART.*`) for the PaRama chart wording, and 78 links. Applied to production on 2026-09-20. |
| `2026-09-26_vivaxis_split.sql` | Splits 2.2.1 "Birth / Environmental / Body" into three child nodes (`2.2.1.1` Birth, `2.2.1.2` Environmental, `2.2.1.3` Body) under 2.2.1, same wording, each with its own `+`. In to production on 2026-09-26. |
| `2026-09-26_sessions_independent.sql` | Saved sessions no longer depend on the protocol tree: each `fact_session_step` keeps its own `protocol_name` (backfilled), and the foreign key `protocol_code → dim_protocol_node` is dropped. Nodes can be renamed, split or removed freely. Applied to production on 2026-09-26. |
| `brain-chart-notes-fill-in.sql` | One `update` per structure, in chart order, for pasting the PaRama chart wording into the `CHART.*` note bodies. Dollar-quoted, so apostrophes and line breaks paste as-is. |

`docs/brain-chart-study-key.html` is the standalone reference page: schematic figures
with the chart numbers, the same sourced text, and the full source list.

Sources for the Anatomy/Function text: OpenStax *Anatomy & Physiology* 13.2,
NCBI StatPearls chapters, and the individual papers named in each row.
The PaRama chart wording is not in these files; it is entered separately.


The edge function `protocol-data` is kept in `supabase/functions/protocol-data/index.ts`;
deploy that file when you change it.
