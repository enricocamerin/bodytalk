# sql/

Data changes applied to the Supabase project behind the BodyTalk Protocol Navigator.
The app itself (`index.html`) reads everything from these tables, so a change here
needs no redeploy — only a reload of the reference data.

| File | What it does |
|---|---|
| `2026-09-20_brain_box.sql` | Creates Section 1 › Brain (`1.10`): 46 protocol nodes, 39 `dim_nervous_system` rows (`BR.*`) with sourced Anatomy/Function text, 39 empty `dim_note` rows (`CHART.*`) for the PaRama chart wording, and 78 links. Applied to production on 2026-09-20. |
| `2026-09-26_vivaxis_split.sql` | Splits 2.2.1 "Birth / Environmental / Body" into three child nodes (`2.2.1.1` Birth, `2.2.1.2` Environmental, `2.2.1.3` Body) under 2.2.1, same wording, each with its own `+`. In to production on 2026-09-26. |
| `2026-09-26_sessions_independent.sql` | Saved sessions no longer depend on the protocol tree: each `fact_session_step` keeps its own `protocol_name` (backfilled), and the foreign key `protocol_code → dim_protocol_node` is dropped. Nodes can be renamed, split or removed freely. Applied to production on 2026-09-26. |
| `2026-09-26_four_domains.sql` | Home page with four domains: `ACIM`, `BT` (BodyTalk, holds the numeric protocol as before), `HC` (Healing Code), `ACCESS` (Access). ACIM holds four books, `ACIM.1` Text, `ACIM.2` Workbook for Students, `ACIM.3` Manual for Teachers, `ACIM.4` The Song of Prayer. Adds `link_url` and `sources` to `dim_protocol_node` for links to the originals. Chapter lists wait for acim.org access. Applied to production on 2026-09-26. |
| `2026-09-26_acim_books.sql` | All 788 entries of the four ACIM books under `ACIM.1`–`ACIM.4` (Text chapters and sections; Workbook parts, reviews and lessons 1–365; Manual for Teachers sections and Clarification of Terms; The Song of Prayer chapters and sections), each with `link_url` to its page on acim.org and `sources`. Titles and links come from the official table of contents (`https://acim.org/we-api/en/toc`, read 2026-09-26). Applied to production on 2026-09-26; the rows in the database match this file (same md5 over code, parent, name, level, order, tab label and link). |
| `2026-09-26_orientation_tab.sql` | Qualifier tabs get a scope (`only_under`, `not_under`, `show_empty` on `dim_qualifier_set`). Tentacle (11) shows only in Section 3; a new Orientation set (12) shows everywhere else, empty until the owner enters the chart's Orientation list. Applied to production on 2026-09-26. |
| `brain-chart-notes-fill-in.sql` | One `update` per structure, in chart order, for pasting the PaRama chart wording into the `CHART.*` note bodies. Dollar-quoted, so apostrophes and line breaks paste as-is. |

`docs/brain-chart-study-key.html` is the standalone reference page: schematic figures
with the chart numbers, the same sourced text, and the full source list.

Sources for the Anatomy/Function text: OpenStax *Anatomy & Physiology* 13.2,
NCBI StatPearls chapters, and the individual papers named in each row.
The PaRama chart wording is not in these files; it is entered separately.


The edge function `protocol-data` is kept in `supabase/functions/protocol-data/index.ts`;
deploy that file when you change it.
