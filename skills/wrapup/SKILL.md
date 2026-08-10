---
name: wrapup
description: Close out a feature worktree once its PR has merged — confirm the merge, verify the deploy where one applies, remove the worktree, and clean up branches; with --abandon, tear down a killed feature after showing exactly what is being discarded. Requires a merged PR or an explicit --abandon — a session ending while work is still in flight is your session-close workflow, and unfinished work someone must resume is the handoff skill. Triggers on "/wrapup", "the PR merged, tidy up", "clean up this worktree", "abandon this feature".
---

# Wrap up a feature worktree

Two modes. Default: after the PR merges. `--abandon`: the feature is dead
and its work is being discarded on purpose. Every guard below exists to
avoid deleting work *unintentionally*.

Constant: `$MAIN` — the primary checkout the worktree is attached to.
Resolve it from git, never assume a path:

```bash
MAIN=$(dirname "$(git rev-parse --path-format=absolute --git-common-dir)")
```

## Not this skill

| Situation | Use instead |
| --- | --- |
| Session ending, feature still in flight | Your session-close workflow |
| Unfinished work another session must resume | The `handoff` skill |
| Mid-work branch or stack sync | Your git tooling — no teardown involved |

A bare "wrap up" does not distinguish teardown from ending a session.
Route on evidence, not the phrase: no merged PR in the conversation and
no `--abandon` means this is not wrapup. When it stays ambiguous, ask —
the wrong guess here spends a teardown on a live feature.

## Ownership guard (both modes, before anything else)

Not every worktree holds your own branch — picking up a colleague's
branch for a review or a stacked pass is normal. Resolve ownership from
the worktree and the forge, not from the conversation:

```bash
gh pr view <number> --json author,headRefName,baseRefName
gh api user --jq '.login'
```

A PR authored by someone else, a branch that does not follow your own
naming, or a marker your bootstrap workflow left recording that this
worktree tracks a colleague's branch means **the remote side is someone
else's**. Teardown is then limited to `git worktree remove` and the
local `branch -D`. Never `gh pr close`, never
`git push origin --delete` — those target a colleague's live PR and
their branch. Say in the report which parts were skipped and why.

`--abandon` is the dangerous combination there: work pushed to their
branch is already out of your control, so the only thing left to
discard is theirs. Confirm the mode before running it.

## Process (default — merged)

1. **Confirm the merge.** `gh pr view <number> --json state,mergedAt`.
   Not `MERGED` → report and stop; nothing below is safe. (Feature
   dropped rather than merged → that's `--abandon`, not a bypass.)

2. **Deploy check (when the merge ships a deployable service).** Verify
   the merge actually deployed before declaring done, using your
   project's health endpoint or deploy-status tooling — e.g. a health
   endpoint that reports the running SHA, confirmed with
   `git merge-base --is-ancestor <merge-sha> <running-sha>` after
   `git fetch origin`. Never report a merge as live on the strength of
   the merge alone. Skip only when nothing deploys from this change.

3. **Guard the worktree.** Before removing, from the worktree: working
   tree clean (`git status --porcelain` empty) and no local commits
   ahead (`git log --oneline origin/<branch>..HEAD` empty). Either
   non-empty → surface what's there and stop; never `--force` the
   removal.

   Both checks can pass on a worktree that still refuses to delete.
   `git worktree remove` deregisters first and deletes second, so a
   failure ("Directory not empty") strands a directory git no longer
   tracks. Two causes, neither visible to `status`:

   - **Live processes rooted in the worktree**:
     `ps -eo pid,comm,args | grep "<worktree-path>" | grep -v grep`.
     Dev servers, file watchers, and language servers race the
     recursive delete. Discount matches that merely *mention* the path
     in their arguments — a global daemon that once took the path as an
     argument is a standing false positive; confirm a real holder with
     `lsof -a -d cwd -p <pid>`.
   - **Gitignored build artefacts** (dependency dirs, caches):
     `git status --porcelain` never reports them;
     `git status --porcelain --ignored` does.

   A manual wrapup invocation pre-authorises stopping this worktree's
   own per-worktree dev services — the user invokes it on finished,
   merged work. Stop them directly and name them in the report. That
   authority is scoped to services rooted in the worktree being torn
   down, on a manual invocation. Reached any other way (chained from
   another skill, an autonomous loop), or for any process that is not
   part of this worktree's services: report the holder, hand the user
   the paste-ready line, and wait.

   Holders this session spawned itself (helper binaries, children of a
   finished sub-task) are yours to kill once their work is done.
   Recover a half-failed removal with `rm -rf "$WT"` then
   `git -C "$MAIN" worktree prune`.

4. **Sync trunk**: `git -C "$MAIN" pull --ff-only origin <default-branch>`.
   Always name the refspec — on a large remote a bare `pull` fetches
   every ref and can hang for minutes. Failure is a warning, not a
   stop; teardown does not depend on it.

5. **Remove — or arm the reaper if this session lives inside the
   worktree.** Resolve the path from git, not from convention —
   worktrees live wherever they were created:

   ```bash
   WT=$(git -C "$MAIN" worktree list --porcelain \
     | awk -v b="branch refs/heads/<branch>" '/^worktree /{p=$2} $0==b{print p}')
   ```

   Session outside the worktree → remove directly:

   ```bash
   git -C "$MAIN" worktree remove "$WT"
   git -C "$MAIN" branch -D <branch>   # -D: squash merges break ancestry
   ```

   Delete the branch with plain git. If you use stacked-branch tooling,
   keep its sync commands out of teardown — they typically restack
   every tracked branch in the repo, far beyond this cleanup's scope.

   Session inside the worktree (cwd under it) → removing your own cwd
   breaks every later command, so write a marker and hand the deletion
   to a detached reaper: it waits for this session's process to exit,
   then removes worktree and branch on its own.

   ```bash
   SESSION_PID=$PPID               # the harness process — the tool's own shell is ephemeral
   ps -p "$SESSION_PID" -o comm=   # must name your agent-harness binary, not a shell
   BRANCH=<branch>
   MARKER_DIR="$(git -C "$MAIN" rev-parse --path-format=absolute --git-common-dir)/pending-cleanup"
   mkdir -p "$MARKER_DIR"
   MARKER="$MARKER_DIR/${BRANCH//\//-}"
   printf 'branch=%s\npid=%s\nguards=passed\n' "$BRANCH" "$SESSION_PID" > "$MARKER"
   (nohup bash -c '
     PID=$1 MAIN=$2 WT=$3 BRANCH=$4 MARKER=$5
     kill -0 "$PID" 2>/dev/null || exit 1   # dead pid at spawn = wrong pid; never reap
     while kill -0 "$PID" 2>/dev/null; do sleep 15; done
     sleep 5
     FORCE=""; grep -q "^mode=abandon$" "$MARKER" && FORCE="--force"
     git -C "$MAIN" worktree remove $FORCE "$WT" \
       && git -C "$MAIN" branch -D "$BRANCH" \
       && rm -f "$MARKER"
   ' _ "$SESSION_PID" "$MAIN" "$WT" "$BRANCH" "$MARKER" \
     >/dev/null 2>&1 &)   # subshell double-fork — macOS has no setsid
   ```

   The `ps` check is a precondition, not decoration: if it names
   anything other than your harness binary the pid is wrong, and the
   reaper would delete the worktree seconds from now instead of after
   the session ends. Don't arm it — report manual cleanup instead. The
   marker doubles as the breadcrumb if the reaper dies (reboot, crash):
   sweep `pending-cleanup/` at your next bootstrap, or clean up by hand.

6. **Close the ledger.** If you keep a workstream log or running memory
   for this feature, write its final state — outcome, merged PR,
   lessons worth keeping — and stop treating it as live.

7. **Report** the teardown as it actually happened: PR merged (+ deploy
   status if checked), and "worktree removed, branch `<name>` deleted"
   only if those commands ran and succeeded — otherwise "reaper armed —
   cleanup runs itself when this session closes", or what still holds
   the worktree and the line the user needs to run. Never report a
   branch cleaned on the strength of having run a sync command.

## Process (--abandon — feature killed)

Discards work by design, so the guards invert: instead of refusing on
dirty/ahead state, show it and make the user own the loss.

1. **Show what's being discarded**, all three, even when empty:
   `git status --porcelain` (uncommitted),
   `git log --oneline origin/<branch>..HEAD` (unpushed),
   `git diff origin/<default-branch>...HEAD --stat` (the branch's whole
   delta vs trunk).

2. **Explicit confirmation (hard stop).** Present the summary and wait
   for an unambiguous yes to "permanently discard this". Never proceed
   on the original "--abandon" alone — the user asked before seeing the
   inventory.

3. **Close the PR** if one is open **and it is yours** (§ Ownership
   guard): `gh pr close <number> --comment "Abandoned."` — an open PR
   for a deleted branch confuses reverts and incident response. Someone
   else's PR is never closed here; report it as left open.

4. **Tear down.** Resolve `$WT` per default step 5.

   Session outside the worktree:

   ```bash
   git -C "$MAIN" worktree remove --force "$WT"
   git -C "$MAIN" branch -D <branch>
   git push origin --delete <branch>   # only if the branch was pushed
   ```

   The remote delete is the line the ownership guard forbids on a
   colleague's branch. Drop it there; the first two still run.

   Session inside it → arm the reaper per default step 5, but the
   marker must carry `mode=abandon` — the reaper gates `--force` on
   that literal line, and an abandoned worktree is dirty by definition,
   so without it every removal attempt fails and the worktree strands
   while the report claims cleanup is under way. `guards=passed` and
   `mode=abandon` are mutually exclusive — this mode never writes the
   former:

   ```bash
   printf 'branch=%s\npid=%s\nmode=abandon\n' "$BRANCH" "$SESSION_PID" > "$MARKER"
   ```

   Same validated-pid check and `nohup` spawn as default step 5.

5. **Report**: what was discarded (commit count + diffstat), PR closed
   (if any), worktree and branches removed. If you keep a workstream
   log, record why the feature died and whether that was knowable
   earlier — the one lesson this mode reliably produces.
