# sql/

Data changes applied to the Supabase project behind the BodyTalk Protocol Navigator.
The app itself (`index.html`) reads everything from these tables, so a change here
needs no redeploy — only a reload of the reference data.

| File | What it does |
|---|---|
| `2026-09-20_brain_box.sql` | Creates Section 1 › Brain (`1.10`): 46 protocol nodes, 39 `dim_nervous_system` rows (`BR.*`) with sourced Anatomy/Function text, 39 empty `dim_note` rows (`CHART.*`) for the PaRama chart wording, and 78 links. Applied to production on 2026-09-20. |
| `brain-chart-notes-fill-in.sql` | One `update` per structure, in chart order, for pasting the PaRama chart wording into the `CHART.*` note bodies. Dollar-quoted, so apostrophes and line breaks paste as-is. |

`docs/brain-chart-study-key.html` is the standalone reference page: schematic figures
with the chart numbers, the same sourced text, and the full source list.

Sources for the Anatomy/Function text: OpenStax *Anatomy & Physiology* 13.2,
NCBI StatPearls chapters, and the individual papers named in each row.
The PaRama chart wording is not in these files; it is entered separately.
