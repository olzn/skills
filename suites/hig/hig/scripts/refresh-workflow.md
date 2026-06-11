# HIG suite refresh workflow

Agent-driven, human-supervised. Run in June (WWDC drop, ~2–3h), September (hardware + OS GA), December (x.2). Trigger: `versions.md` expiry passed, or `hig-whats-new.sh` reports changes.

## Standard refresh

Run from the repo: `suites/hig/`. Runtime scripts live in `hig/scripts/`; `validate.sh` lives in `scripts/` (repo-only).

1. **Diff:** `hig/scripts/hig-whats-new.sh` → changed slugs since snapshot + derived files needing review (from `src:` tags). Exit 2 = parse failure — fix the script before concluding anything.
2. **Re-read:** for each changed slug, `hig/scripts/hig-fetch.sh <slug>` and compare against its corpus section. Update the section under the build contract (`docs/research/hig/_build-contract.md`): exact values, slug anchors, two-speed rule, ≤80-line sections, update the section's `changed:` date.
3. **Propagate:** for every derived file the diff listed (checklists, trees, tables, corrections, adapters, doctrine): re-verify each claim tagged with a changed slug. Update or delete. Check `corrections.md` volatility-marked entries — a "hot" correction may itself now be wrong.
4. **Numbers:** if any hot component changed visually (tab bars, toolbars, sheets, buttons), re-run the runtime measurement (Workflow A in `docs/research/hig/_metrics.md` §12, ~10 min scripted) and update `tables/metrics.md`.
5. **Restamp:** `versions.md` — new snapshot date, recompute expiry dates; update every touched file's header comment.
6. **Validate:** `scripts/validate.sh` (budgets, headers, anchor integrity, inline-copy diffs, live smoke test).
7. **Smoke-test retrieval:** 3–4 subagent questions on changed topics ("how do iOS tab bars behave?") — answers must cite the new dates.

## Verification discipline (every refresh)

Audit patterns adapted from justinwetch/HIGAgentSkills' update process; their full-corpus audits found that structurally "validated" corpora can still hide source drift.

- **Disposition inventory.** Every slug in Apple's TOC and every existing corpus section gets exactly one classification per refresh: `unchanged` (alert-date precedes snapshot) · `update` · `new-distill` · `new-live-fetch-only` (niche — add it to index.md's live-fetch-only list, no corpus section) · `merged` · `renamed` · `removed-upstream`. Record the non-trivial ones in the refresh commit message. Silence is not a disposition — an unclassified new page is how coverage gaps are born.
- **Verification schema.** Every changed or new section gets one line from an independent re-read (a second agent or a later pass — never the editor in the same sitting): `slug | ACCEPTED / REVISE / NEEDS-SOURCE-REVIEW | P1 (could mislead) / P2 (affects real use) / P3 (minor) | evidence | fix`. `validate.sh` passing is structural only; it proves nothing about source fidelity.
- **Expansion rule.** Two or more REVISE verdicts in one corpus file → re-verify that file's remaining sections before closing the refresh. A routing error → check both sides of the route (index entry and section anchor).

## September flip (27 GA) — one-time structural pass

1. Confirm GA: `hig-whats-new.sh` + check Apple's release notes.
2. `grep -rn "promote on GA" hig/references/` — every delta block: verify the claim survived the beta (2025 precedent: beta guidance flip-flopped), then promote to baseline prose or delete.
3. `versions.md`: baseline → iOS 27.x / macOS 27.x; re-gate any newly-announced 28-era content.
4. Re-run runtime measurements (metrics are 26.2-simulator values; 27 may shift them).
5. Steps 5–7 above. Expect device-dimension rows in `layout` to change (new iPhones).

## If the ritual was skipped

The suite degrades safely-ish: expiry dates force staleness caveats onto volatile answers (see `versions.md` behaviour rules), but content silently rots beyond what caveats cover. Run the standard refresh; if more than two windows were missed, also re-verify the full hot-page list in `versions.md` regardless of what whats-new reports.
