---
name: ship
description: Change, check and publish the BodyTalk Protocol Navigator (index.html) end to end, without asking the owner. Use for any change to the app, from a one-line fix to a new feature, and whenever the owner says "pubblica", "pull", "push", "metti online" or "Netlify".
---

# Ship a change to the BodyTalk Protocol Navigator

The owner wants finished work online, not questions. Run every step below
without asking for confirmation; stop only if a step fails and cannot be fixed.

## 1. Start from the latest `main`

```bash
git fetch origin main
git checkout -B <working-branch> origin/main   # if the branch's last PR is already merged
```

Read `CLAUDE.md` ("How the app works", "Rules from the owner", "Current state").

## 2. Make the change in `index.html`

- One file: HTML, one `<style>`, one `<script>`. No framework, no build, no npm in the repo.
- Reuse the CSS tokens on `:root` (`--void`, `--card`, `--edge`, `--edge-2`, `--text`,
  `--text-2`, `--text-3`, `--em`, ...). No hard-coded colours when a token exists.
- Text typed by the user goes through `esc()` before `innerHTML`.
- Phone first: 390px wide must work, visible keyboard focus (`:focus-visible`),
  respect `prefers-reduced-motion`.
- Every card and every node page, down to the last leaf, keeps its `+`
  (`.c-add` → `addPick(code,event)`).
- Data changes go in `sql/` (see `sql/README.md`), never in the HTML.
- Factual content (anatomy, function, protocol text) needs a cited source next
  to the data. The PaRama chart wording comes from the owner only.
- **Bump `const BUILD = "..."`** to a short new name describing the change.

## 3. Check it in a real browser

The real data needs the access code, so mock the tree. Playwright is not in the
repo; install `playwright-core` in the scratchpad and use the preinstalled Chromium:

```js
const {chromium}=require('playwright-core');
const exe=require('child_process').execSync('ls -d /opt/pw-browsers/chromium-*/chrome-linux/chrome | head -1').toString().trim();
const b=await chromium.launch({executablePath:exe});
const p=await b.newPage({viewport:{width:390,height:800}});
const errs=[]; p.on('pageerror',e=>errs.push(e.message));
await p.route('**/functions/v1/**',r=>r.abort());
await p.goto('file:///home/user/bodytalk/index.html');
await p.evaluate(()=>{ unlockUI();
  TREE=[{code:'1',name:'Switching',level:1},{code:'1.1',name:'Sub A',level:2},{code:'1.1.1',name:'Leaf',level:3}];
  TREE.forEach(n=>byCode[n.code]=n); render(); renderTray(); });
// click through the change, take screenshots, print errs (must be empty)
```

Look at the screenshots yourself before going on.

## 4. Record it

- Update "Current state" in `CLAUDE.md` (new `BUILD`, what changed, in a few lines).
- Commit with a clear message and the attribution lines the session asks for,
  then `git push -u origin <working-branch>`.

## 5. Publish (don't ask)

1. Open a pull request into `main` (`mcp__github__create_pull_request`).
2. If the PR has check runs, wait for them to pass; fix and push if red.
3. Merge it (`mcp__github__merge_pull_request`, method `merge`,
   `expectedHeadSha` = the full 40-char head SHA).
4. Netlify deploys `main` by itself. Project `bodytalk-protocol-navigator`,
   site id `27ad126a-6ff8-44b6-a841-f0abfd0e0fc4`,
   https://bodytalk-protocol-navigator.netlify.app. Confirm with
   `mcp__Netlify__netlify-project-services-reader` (`get-project`) then
   `mcp__Netlify__netlify-deploy-services-reader` (`get-deploy-for-site`):
   `state` must be `ready` and `commit_ref` must be the merge commit.
   (Plain `curl` to netlify.app is blocked by the sandbox proxy.)

## 6. Tell the owner (in Italian)

What changed, in plain words; the live `BUILD` name; the site link; anything
you could not check.
