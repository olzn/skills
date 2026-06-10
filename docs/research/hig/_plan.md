# HIG skill suite — working state

Goal: a skill (or suite) that keeps Oscar's iOS and macOS designs and prototypes aligned with Apple's HIG. Loop until proud; every decision must be defensible; offer non-skill alternatives.

## Loop state
- Iteration 1 (2026-06-10): context explored, research workflow done (wf_26b5c9bc-7e2, 15 agents, ~1.5M tokens → notes here).
- Iteration 2 (2026-06-10): gap-fill workflow launched (wf_30d485ce-9ec: system-experiences, design-principles, commerce/misc, metrics, provenance fixes + keyboard/dynamic-type tables); architecture spec written to docs/specs/2026-06-10-hig-suite-design.md (3 skills: hig / hig-build / hig-review; dated snapshot + live-fetch; 3-tier severity; medium adapters; D1–D8 decision record); judge panel launched (wf_7c5c546d-30f, 5 adversarial lenses).
- Iteration 3 (2026-06-10): judges synthesized (all 5 "needs-changes", core confirmed; 30+ repairs accepted — see spec v2 D9–D14: anti-prior descriptions, hig-build→hig-design rename, install-once shared refs, token budgets, src: annotations, refresh-workflow.md, thumbnail-only Figma adapter, candidates-not-findings scanner, two-speed corpus). Spec rewritten to v2. Build contract written (_build-contract.md). Build workflow launched (wf_664e7be1-bd2: 15 drafters + indexer). I wrote: 3 SKILL.mds + versions.md myself.
- Remaining at assembly: refresh-workflow.md, validate.sh, install.sh, README.md, learnings.md seeds, tables/metrics.md (gap-fill metrics agent still running), cross-skill edits (prototype @ ~/.claude/skills, ui-craft co-lead precedence line, surface-details reciprocal line), then subagent tests per spec D13 (keyword-free spec Qs, co-fire, negative web-app case, glassEffect debug entry, stale-snapshot, lookup budget), then commit + deliver.
- Iteration 4–5 (2026-06-10): build interrupted by transient spend limit (8/16 drafters died post-write); recovered manually (adapters figma+swiftui, index, tech split, script tests, budget trims). validate.sh 0/0. TDD tests: 3 RED baselines (framing-stale priors confirmed), 5 GREEN with-skill passes, 3 routing sims (2 pass; debug case routed to hig-design — correct, test expectation was wrong). REFACTOR: hig-review corpus-read discipline tightened; re-test passed (8 files, 1 corpus section via offset). Stale-snapshot fail-soft verified. Committed: 2510174 (research+spec), 8df7c3f (suite), 07cbe8c (boundaries+README). Suite installed to ~/.codex/skills.
- LOOP COMPLETE. Pending user decisions: prototype-skill one-liner (harness-denied, see spec §6 as-built deltas), optional /schedule refresh reminder, optional push to remote.
- Tasks #1–#6 track phases (TaskList).

## House conventions (extracted from repo/suites/ui-craft)
- Suite layout: `repo/suites/<suite>/` → coordinator skill dir + grouped domain skill dirs + install.sh + README.md + scripts/validate.sh.
- Coordinator (~1,300 words): core rules, orchestration protocol (classify → one lead skill → supporting only if they change the work), skill-selection table, common routes, boundary notes.
- Domain skills 1,000–3,500 words; numbered sections; decision rules ("ask: what's the cost if..."); "This skill decides X; sibling decides Y."
- Frontmatter descriptions: long, trigger-rich, third person, explicit "Does NOT cover X (use Y)" boundaries. No workflow summaries in descriptions (CSO rule).
- Each skill dir: SKILL.md + learnings.md (runtime notes, preserved by installer) + references/ (shared files copied in: design-philosophy, accessibility, composition, quality) + agents/openai.yaml (Codex compat).
- British prose ("colour", "behaviour") BUT Apple terms verbatim where they're proper nouns/component names.
- Attribution of sources in skill body.
- install.sh: POSIX sh, installs to ${CODEX_HOME:-~/.codex}/skills or TARGET_DIR, preserves learnings.md, handles legacy renames.

## User toolchain to integrate with
- Figma MCP (view_node, comments), prototype skill (HTML prototypes), agent-browser + before-and-after (screenshots), Nucleo icons MCP, ui-craft suite (web-platform rules — explicitly excludes native; HIG suite must complement, not overlap).

## Key early insights
- HIG was rewritten June 2025 (Liquid Glass, iOS 26/macOS Tahoe 26); WWDC 2026 is this week — currency is a first-class architecture concern. A major value-add: correcting the model's stale pre-2025 design priors.
- Apple HIG site is a JS shell; content reachable via JSON API (developer.apple.com/tutorials/data/...) — enables live-fetch verification paths in skills.
- ui-craft explicitly scopes itself to web ("Do not use for native mobile interface work") — the HIG suite fills that declared gap; boundaries between the suites must be written on both sides.
