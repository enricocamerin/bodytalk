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

## Starting a new session

1. `git log --oneline -10` on `main` to see where things stand.
2. Read the latest `sql/README.md` entries if the task touches data.
3. Update the "Current state" section below when you finish.

## Current state

- Build `formula-tray` (PR #1): the formula tray at the bottom is a raised
  panel with an emerald edge, a "Formula" title with a step count, the current
  step filled in emerald, a pop-in when a step is added, and the mic floating
  above the tray. Before it: `search-a11y` (node search, back-button history,
  keyboard access).
- Section 1 › Brain (`1.10`) data is in production; the `CHART.*` note bodies
  wait for the owner's chart wording (`sql/brain-chart-notes-fill-in.sql`).
