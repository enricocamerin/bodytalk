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
| `docs/` | Standalone reference pages (e.g. `brain-chart-study-key.html`). |
| `.claude/skills/` | Project skills: `frontend-design` (visual design guidance) and `webapp-testing` (Playwright checks). Copied from github.com/anthropics/skills, Apache-2.0. |

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
  tell the owner the live `BUILD`.

## Starting a new session

1. `git log --oneline -10` on `main` to see where things stand.
2. Read the latest `sql/README.md` entries if the task touches data.
3. Update the "Current state" section below when you finish.

## Current state

- Build `formula-hide`: the formula can also disappear completely. The `×`
  at the right of the tray title bar hides it; a small "Formula n" pill
  (bottom left) brings it back open. Voice: "nascondi/togli formula" hides,
  "mostra/apri formula" shows, "chiudi formula" folds. Adding a step while
  hidden bumps the pill's count. Before it:
- Build `formula-fold`: the formula tray starts folded to a title bar
  ("Formula", step count, current step); tapping the title (or saying
  "mostra/nascondi formula") opens and closes it. While folded, adding a step
  bumps the count. Before it: `formula-tray` (PR #2: raised tray, emerald
  edge, current step filled, mic above the tray) and `search-a11y`.
- Section 1 › Brain (`1.10`) data is in production; the `CHART.*` note bodies
  wait for the owner's chart wording (`sql/brain-chart-notes-fill-in.sql`).
