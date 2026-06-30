# Ship: a delivery and loop suite for AI-assisted design engineering

Date: 2026-06-28
Status: Superseded by `docs/specs/2026-06-29-post-build-review-design.md` (cut to a single standalone skill as overengineered for a solo design engineer; kept for provenance)
Decision owner: olozano

## Problem

The current pipeline runs four skills in sequence.
`grill-with-docs` settles product and domain, terminology, CONTEXT.md and ADRs.
`paper-prototype` explores UI directions in Paper and makes the design call.
`pre-build-review` hardens the plan and gives a go or no-go.
`ui-craft` builds with structure and surface quality.

The pipeline is strong and deliberately front-loaded.
It runs from idea to a hardened plan to a quality build, and then it stops.
Everything the wider practice puts after "build" is unowned: running and checking the change, comparing the build against the direction that was chosen and the states that were promised, reviewing the diff, and handing the work off with evidence.
The gate that should sit before everything, deciding how much the AI may drive a given task, is also missing.

Separately, the user wants to adopt loop engineering: building small systems that find work, hand it out, check it, record what is done, and decide the next thing, with the writer split from the checker and the human owning verification and comprehension.
A loop is only as safe as its checker, and the missing post-build verification is exactly the checker a loop needs.
Closing the back of the funnel and enabling loops are therefore the same project.

## Goals

Close the back of the funnel: a post-build verification step, an evidence-carrying handoff, and a standing discovery loop.
Add the front gate that sets how much the AI may drive a task.
Make loops safe by giving them a real checker and keeping the human as the owner of verification and comprehension.
Keep the strong front of the funnel intact.
Route into existing skills rather than duplicate them, while remaining self-contained enough to run where those skills are absent.

## Non-goals

Do not rebuild the front of the funnel.
Do not loop the deciding: the design and product judgment, and the merge, stay human-led; the loops automate the mechanical work around them (discovery, building, checking, and value-preserving fixes), never the design call.
Do not duplicate rules that the `ui-craft` domain skills already own.
Do not grant the checker the power to edit; verification stays read-only.
Do not depend silently on Claude-Code-only machinery, since the suite installs to Codex as well.

## Design principles

Close the back, add loops, keep the front.
Route, do not duplicate, but degrade loudly and never silently.
The human owns verification and comprehension; the loop surfaces work and the human decides what merges.
Portable first: every skill has a self-contained core, and Claude-Code tools are optional accelerants used only when present.
Single-source the rules: one canonical check catalogue and one stage-ownership map, consumed by the loops, never restated.
Read-only checker: the agent that grades a change never built it and never edits it.
On a schedule, scans propose and humans dispose.

## Architecture overview

A new suite named `ship`, built on the `hig` template: flat sibling directories, a coordinator named for its territory, an `install.sh` and a `validate.sh`, and siblings that read shared files directly rather than receiving copies.
The coordinator is `ship`.
The Phase 1 members are `ship-verify`, `ship-handoff`, and `ship-scan`.

The coordinator owns the interactive front-gate classification and the interactive learning-harvest prompt.
The rules those rely on do not live only in the coordinator's instructions, because `ship-scan` runs out of context on a schedule and `ship-verify` runs in a fresh context, so neither can see them.
So the shared rules live as files inside the `ship` coordinator skill directory and are read by the sibling skills via `../ship/...`, exactly as `hig`'s siblings read `../hig/references/`: `ship/checks/catalogue.yaml` (every standing check, once), `ship/references/autonomy.md` (the autonomy baseline, the gate-to-autonomy modulation, the risky-surface list, and the harvest trigger), and `ship/references/stage-ownership.md` (the canonical concern-to-stage map).
Because `install.sh` copies whole skill directories, these files travel inside the `ship` skill directory to the target; there are no per-skill copies and no cmp step.

Two upstream skills gain durable output contracts so the back of the funnel has something to grade against.
`paper-prototype` gains one: a committed decision record.
`pre-build-review` gains two small ones: a persisted state and scope checklist, and a required code-reconnaissance artifact. It keeps its own self-contained routing list, so it still runs standalone.

Naming follows the `hig` precedent of an exact stem, which also clears three live collisions: a `verify` would shadow the built-in `/verify`, a `handoff` would overwrite an already-installed `handoff` skill in both `~/.codex/skills` and `~/.claude/skills`, and `discovery-loop` would overload the built-in `/loop`.

## The spine

`ship` is a superordinate, soft-routing coordinator, not a peer quality domain like `ui-craft` or `hig`.
Its first lines and its description state that it sequences grill, paper, pre-build, ui-craft, verify, and handoff, and that it orchestrates those skills rather than replacing them or their coordinators.
This keeps a build prompt from being caught by both `ship` and `ui-craft`.

The sequence is grill, then paper, then pre-build, then ui-craft, then verify, then handoff, with the front gate applied at entry.

The spine is soft.
At entry the coordinator resolves each routed target (grill, paper, pre-build, ui-craft, the built-ins, and superpowers) and names any that are absent rather than producing a dangling step.
The "when present" treatment that the first draft gave only to superpowers now applies uniformly to every routed dependency.

### The loop plumbing, per platform

The coordinator runs the loop differently depending on what is present, and states both paths explicitly rather than hiding behind "when present".

On Claude Code it dispatches through superpowers: hand-out and the fresh checker via `subagent-driven-development`, the stopping condition via `verification-before-completion`, `ship-verify` dispatched as a specialised reviewer via `requesting-code-review` (fed only the design rubric: the Paper decision, the pre-build state list, grill's terms and ADRs, and the `ui-craft` bar), and the merge, PR and branch flow via `finishing-a-development-branch`.

On Codex, where superpowers is absent, the coordinator carries the minimal loop itself: a fresh `codex exec` or a separate session that did not build the code, with the Pass, Pass-with-notes or Fail verdict as the verifiable stopping condition.
This Codex fallback is written into the coordinator's SKILL.md, not left implicit.

### The front gate

The front gate classifies the task green, amber, or red, and sets how much the AI may drive.
The classification step is interactive and lives in the coordinator; the rule it applies lives in `ship/references/autonomy.md` so `ship-scan` can apply the same modulation out of context.

Green applies the value-preserving auto-fix set and lets the per-change loop proceed autonomously to a ready-to-merge PR.
Amber applies formatting fixes only, reports every substantive fix, and pauses the loop for human review before handoff.
Red applies no auto-fix; it stops, keeps the AI as assistant rather than implementer, and escalates to a human engineer and, when present, the built-in `/security-review`.

The risky surfaces that trigger red live in `ship/references/autonomy.md`, seeded from the user's CLAUDE.md values (API calls, auth, permissions, database logic, routing) and overridable per project.
They are not read from CLAUDE.md at runtime, since that file is a Claude-Code, user-private file absent on Codex.

## Upstream contracts

These amendments are what make `ship-verify`'s intent and state checks real.
Without a durable artifact, "intent match against the chosen Paper frame" and "state coverage against the pre-build list" have no ground truth, because a Paper canvas is not addressable from a fresh session and a chat bullet list is not persisted.

`paper-prototype` gains a committed decision record as a hard exit condition.
At the point where it records the winning direction, it writes to a fixed convention path, `docs/design-decisions/<feature-slug>.md`, three things: an exported PNG of the winning frame, the decision note it already produces (which direction won, what was kept and rejected, and why it answered the question, including the interaction and state questions left unresolved), and the translation note (component mapping, values that should become tokens, and which details are behavioural rather than visual).
`ship-verify` grades against this committed record only, never a live canvas lookup, so it works even where the Paper MCP is absent.

`pre-build-review` gains two amendments.
First, a persisted, identified state and scope checklist written to a fixed convention path, `docs/change-contracts/<feature-slug>.md`, as a named deliverable in its Output section: each entry has a stable id, and the document carries a scope and non-goals block.
This is the per-change "contract": scope and non-goals, the missing-states list, known risks, and pointers to the chosen Paper decision record and the relevant ADRs and terms.
It is per-change content plus links, not a restatement of CONTEXT.md.
Second, its currently-conditional code inspection becomes a required reconnaissance step that emits a short artifact (reusable components found, conventions to follow, integration points, migration risks), feeding both the build plan and `ship-verify`'s no-duplicate-components check.
It keeps its own self-contained backward-only routing list, so it still runs standalone: `pre-build-review` routes to grill or paper, or keeps the issue in the build plan.
The canonical concern-to-stage map lives in `ship/references/stage-ownership.md` as the superset, adding the downstream targets (`pre-build-review`, `ui-craft`) that only `ship-verify` can route to; the two are kept consistent, the small documented duplication being the cost of `pre-build-review`'s independence.

The durable carriers of intent stay where they are.
grill's CONTEXT.md and ADRs, and paper's committed decision record, are referenced by pointer, never copied.
`ship-verify` locates a change's contract deterministically: the coordinator passes the contract path (keyed by the feature slug or branch) for a per-change run, and `ship-scan` globs `docs/change-contracts/` for its whole-repo sweep; the contract in turn holds the pointer to the paper decision record, so a fresh session has one fixed entry point.
The `<feature-slug>` is derived from the working branch name, with a user-supplied slug as the standalone fallback, so `paper-prototype` and `pre-build-review` independently write to and resolve the same pair of files without a coordinator threading the value; `pre-build-review` links the paper decision record by resolving `docs/design-decisions/<same-slug>.md`.
`ship-handoff` renders this same contract into the PR, so intent is authored once and travels by pointer through verify and handoff.

## ship-verify

A read-only checker, run in a context that did not build the change, that grades the change against the committed contract and reports a verdict with routed findings.
It never holds an editor.
This matches the repo's own reviewers (`pre-build-review`, `hig-review`) and the read-only built-in `/verify`.

Independence is defined by capability, not by tool.
The guarantee is a fresh context with no build memory, driven by the written checklist.
That guarantee is identical in Codex and Claude Code.
Where a subagent-dispatch mechanism exists (superpowers on Claude Code, a fresh `codex exec` on Codex), the coordinator may automate the fresh checker; that is an accelerant, not the definition.
Independence is enforced by the invocation contract, not by runtime self-detection: the coordinator always dispatches `ship-verify` in a fresh session or subagent, which is the guarantee.
A loaded skill cannot reliably sense prior build memory, so a user invoking `ship-verify` by hand is responsible for running it in a fresh context; the SKILL.md states this and offers the explicit "self-review only; independent verification unavailable here" label to apply when it is knowingly run inline.

### Tiers

The tiers are cut on two honest axes: static-versus-running-app, and deterministic-versus-judged.

Tier 1 is the static gate: headless, no app, deterministic, and it gates.
It is lint, typecheck, tests and build all green; no undeclared risky-file edits (the touched files diffed against the plan); the change stayed in scope; and every static catalogue check (hardcoded values where a token exists, arbitrary Tailwind values, single icon library, `eslint-plugin-jsx-a11y`, the tabindex lint rule and a stylelint check for outline removed without a paired focus-visible style, the statically detectable frontend-security greps below, and variant validity when the variant registry resolves).
This is the cheap, on-push band.

Tier 2 is the run-and-observe gate: it needs a booted app or a Storybook story, it is deterministic, and it gates.
It is no new console errors, axe-core violations, computed-contrast failures in both themes, and the confirmation that every required state from the contract actually renders.
Where the change has no route, story or harness to run, these return Not-Applicable, declared, never a silent pass.
This tier reuses the built-in `/verify` and `agent-browser` when present, and falls back to a direct app or Storybook boot otherwise.

Tier 3 is agent-judged and advisory: it routes home and yields Pass-with-notes, never a Fail.
It is intent match against the committed Paper decision, the quality of the states (is the empty or error state well designed, as distinct from whether it renders), canonical-term use against grill's ADRs, the subjective craft signals that `ui-craft`'s `references/quality.md` calls beauty, hierarchy and rhythm, and the semantic checks no tool can make (a component that re-implements an existing one, tab order following visual order, colour used as the sole signal, and live-interaction accessibility: focus-visible behaviour, focus trap and return, scroll-to-first-invalid).

Intent match reads the captured decision, not a screenshot, and never compares pixels, because the fidelity Paper produces is deliberately low.
It must not raise a finding on any dimension that `paper-prototype` recorded as unresolved, or that Paper treats as out of scope (responsive, keyboard, animation timing, component API, data density); those belong to pre-build and ui-craft.

### Verdict and gating

The verdict is Pass, Pass-with-notes, or Fail, and it is the loop's stopping condition.
A Fail is any Tier 1 or Tier 2 violation, which includes a missing required state, an undeclared risky-file edit, or a scope violation.
Pass-with-notes is a clean Tier 1 and Tier 2 with Tier 3 advisory findings that route home but do not stop the loop.
Pass is clean throughout.

The verdict vocabulary is a deliberate, documented fork, not an accident: `pre-build-review` answers "ready to build?" (Go, Go with changes, or No-go) and `ship-verify` answers "ready to merge?" (Pass, Pass-with-notes, or Fail).
The two ternaries mirror each other and are recorded as related terms in the suite glossary.
The name `ship-verify` was preferred over the mirror name `post-build-review` because the exact-stem `hig` precedent is collision-free and keeps the suite internally consistent; the rejection of the mirror name is deliberate, not an oversight.

### Routing and finding format

Each finding is tagged by the stage that owns it, using the canonical concern-to-stage map in `ship/references/stage-ownership.md`, read as a sibling rather than from the coordinator's instructions.
Routing is separate from gating: every design finding routes home by owning stage whether it gates as a Fail (Tier 1 or Tier 2) or carries as an advisory note (Tier 3). Intent goes to paper, states or scope to pre-build, domain or terms to grill, craft to ui-craft. The one exception is a behavioural Fail, which returns to the builder rather than a design stage, as described next.
A behavioural Fail (a red test or build error from Tier 1, or a console error from Tier 2) is not a design-stage fault and does not route to craft; it returns the failing evidence to the builder for a fix-and-re-verify pass, using `systematic-debugging` when present and a short methodical fallback otherwise.

Each finding is rendered in one line, reusing the owning-stage tag: `[owning-stage] what is wrong, with the exact value / expected: <spec> / source: <catalogue rule | Paper decision | pre-build id | grill ADR> / fix: <concrete fix>`.
The `[owning-stage]` is one of the four spine stages (paper, pre-build, grill, ui-craft); a craft finding routing to ui-craft additionally names the specific ui-craft domain skill (for example `system-components` or `surface-details`), read from `ui-craft`'s existing per-line skill tags in `accessibility.md`, so stage and skill are never conflated.
The enforcement tiers (Tier 1 binary gate, Tier 2 machine gate, Tier 3 triage) are kept; `hig-review`'s consequence-severity tiers are not adopted, because they answer "how bad is it" rather than "how is it enforced".

### Rules versus harness

`ship-verify` owns the harness, not the rules.
Its checks are entries in `ship/checks/catalogue.yaml`, whose rule content is single-sourced from the owning skills, and whose owning-skill field is sourced from `ui-craft`'s `accessibility.md` cross-reference at build time rather than asserted here.
That cross-reference is the authority for which skill owns each rule, and a single rule may carry more than one owner (focus trap and return, for instance, is tagged for both `system-patterns` and `system-components`), so the spec does not restate those mappings, which would only drift from the file.
Design-specific checks (token, variant, icon-library, axe, focus, contrast, colour-alone) stay verify-owned, because `/code-review` and `/simplify` do not cover them; only the thin duplicate-component or efficiency sliver may be delegated to `/code-review` or `/simplify` when present, never depended on, with the Tier 3 semantic duplicate-component check as the self-contained fallback.

Findings carry a teaching register: each one explains, in the repo's own vocabulary, why it matters, which is how the human's comprehension is served by the same loop that serves verification.

## ship-handoff

A thin composer, not a capability.
Its unique contribution is the evidence structure: design-reference pointer, state-coverage summary, what was tested, reviewer focus, and known risks.
It assembles that from `ship-verify`'s verdict and the committed contract.

For visual evidence it calls the existing `before-and-after` skill when present, with an `agent-browser` or screenshot fallback for Codex.
For the what-tested section it consumes `ship-verify`'s own verdict, which is cross-platform, not the Claude-only built-in `/verify`.
For any session-continuation document it defers to the existing built-in `handoff`, which it must never overwrite.
Its branch-and-PR core is portable, using `git` and the `gh` CLI directly so it works from CI or cron on either platform; on Claude Code it may build on `requesting-code-review` and `finishing-a-development-branch` as accelerants.

It owns the evidence structure and the PR assembly, and does not duplicate `before-and-after`'s screenshot capture.

## ship-scan

The standing discovery loop.
It is independently activatable, because its value is always-on, out-of-band scanning that should not be gated behind the coordinator.

Its deterministic core ships as POSIX shell or Node scripts, following the two-layer pattern in `hig`'s `scripts` (a cheap grep or lint recall pass, then a model judgment pass).
This core runs in both Codex and Claude Code, from CI or cron.
Scheduling is pinned to portable substrate: a git pre-push hook for the on-push cadence (which `/loop` and `/schedule` cannot do anyway, since it is event-driven) and cron or CI for daily and weekly.
`/loop` and `/schedule` are optional Claude-side conveniences that call the same scripts, never the required mechanism.

It reads the same `ship/checks/catalogue.yaml` and `ship/references/autonomy.md` as `ship-verify`, so the two loops share one rule set and one autonomy baseline.

### What runs when

Findings are split by fixability and by what they need to run.
Static checks (the Tier 1 catalogue entries) run on push, cheaply, with no app.
Rendered-DOM accessibility (axe-core and computed contrast in both themes) runs as a daily or weekly sweep against a booted app or one rendered Storybook story per component, never as a push or diff gate, because it needs a rendered DOM.
The growth set runs as a standing whole-repo sweep with triage: missing-state coverage, terminology drift, responsive overflow, and live-interaction accessibility (focus-visible on keyboard nav, focus trap and return, scroll-to-first-invalid, tab order versus visual order, driven by `agent-browser`).
Where a project has CI, `ship-scan` emits the stylelint and `eslint-plugin-jsx-a11y` config so the static checks block for free on the diff; it does not assume that infrastructure exists.

### Disposition of fixes

This is one rule, to remove the contradiction in the first draft.
On a schedule, scans propose and humans dispose.
A mechanical, value-preserving fix found on a schedule is applied on a branch and emitted as a batched, reviewable PR through `ship-handoff`, and never auto-merged to a protected branch.
The periodic digest summarises what is in those open PRs and the triage inbox; it is a summary, not a separate no-human-gate path.
The cron's only terminal states are "PR opened for review" and "finding in the inbox".
Interactive per-change auto-fix-and-continue is the only place a fix lands without a separate review step, and that is allowed because a human is present at the point of change.

### Triage sink and state

The triage sink is pluggable.
For product work it is Linear, as chosen.
For the skills repo and other contexts it defaults to a local digest, honouring the standing "no Linear ticket" rule there.
Clean runs self-archive, so the inbox only ever shows live work.

Per-project scan config lives as a committed `.ship-scan.json` at the target repo root, read at runtime, with a defined schema: `activeChecks` (catalogue ids to run), `thresholds`, `ignore` (path globs), and `growthPromotions` (checks moved into the scheduled growth set).
The globally installed skill directory never stores mutable per-project state, because the installer's `rm -rf` would destroy it.
`learnings.md` stays for cross-project lessons only.

## The check catalogue

`ship/checks/catalogue.yaml` lives in the `ship` coordinator skill directory and is the single source for every standing, scannable check, read by `ship-verify` and `ship-scan` via `../ship/checks/catalogue.yaml` (the `hig` sibling model), with no per-skill copies.
Each entry carries an id, a category, the owning skill, a pointer to the source rule (the owning skill's file and the rule line), the detector or command, a severity, a tier (T1 static, T2 run-and-observe, or T3 judged), a cadence-eligibility (push, daily, weekly), an auto-fixable flag, and, where relevant, a registry prerequisite and a degrades-to-tier field.

The per-change checks owned by `ship-verify` directly (not catalogue entries, because they are not standing scans) are the gates (build, tests and typecheck passing, scope adherence, the risky-file diff) and one per-change advisory (intent match against the chosen decision, which is Tier 3 and never gates).
So the catalogue is the single source for every standing check, and `ship-verify` adds the per-change-only checks on top.

The rule content stays in the owning skills; the catalogue holds only the executable harness (which tool enforces each rule, the threshold, the tier, the owning skill).
The owning-skill field is kept honest by a `validate.sh` check that asserts each entry's owning skill matches the per-line skill tag at its source pointer; `ui-craft`'s `accessibility.md` already carries those tags (tab order `system-components`, focus `system-components` and `surface-details`), so the check fails on drift and the field cannot silently diverge from the source.

Variant validity is a registry-dependent deterministic check, not a plain entry.
Its detector extracts the project's CVA config (or the project's existing finite-variant mechanism for non-CVA projects) to build the allowed-variant set.
When that registry resolves, the check runs as a Tier 1 machine gate.
When it does not resolve, it neither passes silently nor hard-fails; it degrades to a Tier 3 finding routed to `system-components` and `system-naming`.

## The autonomy policy

Authored once in `ship/references/autonomy.md` and read directly by the coordinator, `ship-verify`, and `ship-scan`.
It is named the autonomy baseline, not "the middle path", to avoid colliding with `decision-coach`'s existing term in the same repo.
It holds the auto-fixable set, the gate-to-autonomy modulation, the risky-surface list, and the harvest trigger, so every skill that needs a rule reads it from one place rather than from the coordinator's instructions.

The checker never auto-fixes.
Auto-fix authority belongs only to writer steps: the `ui-craft` build loop and a dedicated `ship-scan` fixer.
After any auto-fix a fresh read-only `ship-verify` pass runs; the agent that applied the fix is never the agent that grades it.

The auto-fixable set is defined by a hard test, not by feel: only edits whose output is provably value-preserving under every active theme and state.
By default that admits one thing: formatting and whitespace.
A hardcoded-value to existing-token swap is admitted only when the raw value maps to exactly one existing token with no semantic ambiguity, and the token resolves to the same value in every active theme; a multi-candidate or semantically ambiguous match, or a dark-mode-divergent token, is routed, not auto-applied.
This narrowly-constrained swap is a deliberate choice: it follows the value-preserving auto-fix line and consciously overrides the stricter alternative of removing all token swaps, the trade-off recorded here so it is on the record rather than silent.
Everything that infers intent, meaning, or a canonical-term choice is a reported finding routed to its owning skill.
Variant-string normalisation routes to `system-naming`, because alias handling is naming-owned.
Alt-text routes to `surface-copy` for the words and `surface-details` for the decorative-versus-meaningful decision; at most an empty placeholder alt may be inserted, flagged for human review, never auto-written descriptive text.
A hardcoded colour with semantic ambiguity routes to `surface-colour` and `system-tokens`.
This removes a contradiction in the first draft, where "no invented variant strings" was both a finding and an auto-fix.

The front gate modulates this per task: green applies the full value-preserving set and lets the loop run to a PR, amber applies formatting only and pauses for human review, red applies nothing and escalates.
Because green carries the full set and the autonomous run while amber carries formatting only and a human checkpoint, the two are genuinely distinct.
Trust may graduate per area as a clean-run track record accrues, carried in the per-change contract.

## Security

The risky-file list lives in `ship/references/autonomy.md`, seeded from the CLAUDE.md values and overridable per project, and is used by the red gate and `ship-verify`'s undeclared-edit guard.
A red classification stops the AI from driving and escalates to a human engineer and the built-in `/security-review` when present.

`deepsec` (the external `vercel-labs/deepsec` CLI) is an optional, deliberately-run deep audit, not a bundled dependency and not an escalation target the suite wires up.
It is appropriate for a periodic team-level audit or a diff-mode pass on a security-sensitive change, run on trusted input given it is itself a shell-access agent with prompt-injection risk.
The suite names it as an option in documentation; the concrete in-suite escalation is the human engineer plus `/security-review` when present.

The frontend security surface the design engineer genuinely owns is a set of statically detectable Tier 1 catalogue entries (greps, no app needed): `dangerouslySetInnerHTML` and XSS, secrets in the client bundle, unsafe `postMessage`, open redirects, and `target="_blank"` without `rel="noopener"`.
These run in `ship-scan` on push and in `ship-verify` Tier 1.

## Comprehension

Verification covers "the human owns verification"; comprehension is the other half of the thesis and was missing.
Phase 1 serves it cheaply through `ship-verify`'s teaching register, where each finding explains why it matters in the repo's own terms by pointing at the owning skill's vocabulary.
A standalone tutor skill ("explain this change or this area to me as a design engineer") may be added later beside the suite, like `decision-coach`, if the register proves insufficient.
This is kept separate from any agent-facing code-orientation step, which is handled by `pre-build-review`'s new reconnaissance artifact rather than a new `orient` skill.

## The learning loop

The harvest gets a forcing function rather than an append-on-appearance nudge, because a prompt to append to `learnings.md` reproduces the failure it claims to fix (the coordinator-tier `learnings.md` files already sit largely unused).
The trigger rule lives in `ship/references/autonomy.md` so `ship-scan` can apply it out of context, while the coordinator owns the interactive prompt.
It steals `decision-coach`'s review-date pattern: a scheduled checkpoint that reads, grades, promotes durable findings, and prunes stale ones, wired to `ship-scan`'s recurrence detection so a repeated drift is what triggers a learning, not a per-change prompt.

## Loop architecture

Two loops share one autonomy baseline and one catalogue.
The per-change loop is build, then a fresh-context `ship-verify`, then writer auto-fix of the value-preserving set under the gate's modulation, then a fresh re-verify, then handoff.
This loop deliberately includes building and the mechanical fix; what stays human-led is the design call and the merge, per the non-goals.
The standing loop is `ship-scan` on portable scheduling, surfacing findings to the pluggable sink and proposing fixes as reviewable PRs.

The building blocks loop engineering names are mostly already present: skills, MCP connectors, worktrees, sub-agents, scheduling, and markdown or Linear as external state.
What the suite adds is the design-domain checker, the catalogue, the contracts, and the spine.

## Conventions and tooling

Base the `install.sh` and `validate.sh` structure on `hig`: flat sibling skill directories copied into the target, the sibling-reference resolution check, and a `chmod +x` step generalised across every skill that ships scripts, since `ship-verify` and `ship-scan` will not run otherwise.
The shared files (`checks/catalogue.yaml`, `references/autonomy.md`, `references/stage-ownership.md`) live inside the `ship` coordinator skill directory and travel with it on install, read by siblings via `../ship/...`, so they reach the target without a suite-root copy step that `hig`-style installers do not perform.
Include the per-skill `agents/openai.yaml` manifest that `ui-craft` uses (display name, short description, default prompt), because the suite must be Codex-invocable and the `hig` base alone does not provide it.
`validate.sh` asserts what the suite owns: name equals folder, `agents/openai.yaml` present, `learnings.md` present, the sibling references (`../ship/checks/catalogue.yaml`, `../ship/references/autonomy.md`, `../ship/references/stage-ownership.md`) resolve, each catalogue entry's owning-skill field matches its source tag, and shipped scripts are executable.
It adds one new check: a reserved-name denylist that fails on any skill name whose full name exactly equals a known built-in or plugin skill (verify, handoff, before-and-after, loop, schedule, code-review, simplify, prototype, run, init, review, security-review); the match is exact-equality on the whole name, not substring, so `ship-verify` and `ship-handoff` pass while a bare `verify` or `handoff` fails.
There is no cmp step, because the sibling-read model keeps a single copy of each shared file.
External spine targets are a coordinator runtime presence check, not a `validate.sh` assertion, mirroring how the repo already handles cross-suite references.

User-facing surfaces stay plain.
Loop engineering and cognitive surrender are design rationale only, and may be named once in a SKILL.md grounding line, following the `decision-coach` precedent.
They never appear as a skill name, a gate label, a section heading, or anything shown to the user; the loop is written as plain imperative steps, and the stance is rendered as "the human owns verification and comprehension".

## Build order

Phase 1: the `ship` coordinator (with the interactive gate and harvest, and the three shared files: catalogue, autonomy, stage-ownership), `ship-verify`, `ship-handoff`, `ship-scan`, and the upstream amendments to `paper-prototype` (one) and `pre-build-review` (two).
Phase 2, only if earned: promote the gate or a tutor skill to their own units.

Within Phase 1, the three shared files and the upstream contracts come first, because `ship-verify` and `ship-scan` depend on them.

## Open prerequisites

`grill-with-docs` is an empty directory in this repo though the skill runs from somewhere.
The recommendation is to vendor its real content into `skills/grill-with-docs/` so the spine's first stage is version-controlled, but it is flagged rather than blocking; until then the coordinator treats grill as a present-or-absent routed stage like the others.

Install ownership of the routed skills (grill, paper, pre-build, ui-craft) stays separate: the README publishes a prerequisite list and the coordinator preflight resolves each, rather than the suite bundling other install units.

## Risks and failure modes

Cognitive surrender: mitigated by the read-only checker, the human merge gate, scheduled-fixes-as-PRs, and report-not-fix on everything judged.
Token cost: mitigated by a deterministic-first catalogue, agent-judged work rationed to the growth set, and `deepsec` kept to deliberate external escalation.
Drift: mitigated by the single catalogue and single stage-ownership map, both read directly by siblings.
False pass on visual intent: mitigated by the writer-checker split, grading against a committed decision rather than a screenshot, and keeping intent match advisory.
Codex inertia: mitigated by portable cores, loud preflight, the per-platform loop map, and a portable in-suite source for the risky-surface list.

## What changed in revision 2

The verification pass against all 58 review findings confirmed 51 fully addressed and 7 partial, plus a set of internal contradictions, all now resolved here.
The tiers were re-cut so the static checks (including the static security greps and the variant registry check) have a real home in Tier 1, the run-and-observe checks sit in Tier 2, and only the judged checks are advisory Tier 3, which also fixes the catalogue's tier field and the gating model.
The autonomy policy, the catalogue, the gate modulation, the risky-surface list and the harvest trigger were moved into two shared sibling files, because `ship-scan` runs out of context and the coordinator-only placement was incoherent.
The scheduled-fix disposition was reduced to one rule (apply on a branch, emit a batched PR, never auto-merge), removing the blocker contradiction.
The gate gradient was redefined so green and amber genuinely differ, after the auto-fix set was tightened to formatting plus unambiguous token swaps.
The risky-surface list was moved into the portable suite rather than read from the Claude-only CLAUDE.md.
`deepsec` was reclassified as an optional external CLI rather than an undefined escalation target.
The catalogue adopted the `hig` single-file sibling-read model, dropping the `ui-craft` cmp step that only works with per-skill copies.
The per-platform loop plumbing, the verdict-vocabulary reconciliation, the finding-line format, and the owning-skill attribution were all made explicit.

## What changed in revision 3

A second verification pass (57 of 58 findings addressed) caught contradictions the rev-2 rewrite introduced or left, all resolved here.
The shared files were relocated from an uninstalled suite root into the `ship` coordinator skill directory, read by siblings via `../ship/...`, matching how `hig` actually ships shared references, and the stage-ownership map joined them as a third shared file.
`pre-build-review` keeps its own self-contained routing list rather than pointing at the coordinator, so it still runs standalone; the coordinator map is the canonical superset, which drops the routing amendment and leaves `pre-build-review` with two amendments.
Routing was separated from gating, so a Tier 3 advisory finding routes home without being a Fail.
The contract artifacts gained fixed paths (`docs/design-decisions/<slug>.md`, `docs/change-contracts/<slug>.md`) and a deterministic discovery mechanism for the fresh-context checker.
The catalogue's owning-skill single-sourcing gained real machinery (a source pointer plus a `validate.sh` drift check), the false claim that `ui-craft`'s file needs a new tag was dropped, and owning-stage was distinguished from owning-skill.
`ship-handoff` gained a portable `git` and `gh` PR core so the scheduled propose-as-PR disposition works on Codex.
The reserved-name check was pinned to exact-equality, the lint package corrected to `eslint-plugin-jsx-a11y`, the per-project scan config given a name and schema, the console-error tier corrected to Tier 2, building added to the looped scope in the non-goals, and the retained token swap documented as a deliberate trade-off.

## What changed in revision 4

A third verification pass returned 57 of 58 findings addressed with only localized issues, fixed here; the single remaining gap is the deliberately-documented token-swap trade-off, left as-is for the owner to confirm or flip.
The catalogue's owning-skill source was pinned to the tagging line (`ui-craft`'s `accessibility.md` for accessibility rules), the `validate.sh` check now asserts membership among that line's tags so multi-owner rules and the real focus attribution (`system-patterns` for trap and return) are handled, which removes the previously unbuildable drift check.
Intent match is stated as a per-change advisory, never a gate.
The feature-slug derivation (the branch name, or a user-supplied slug standalone) was specified so the paper and pre-build artifacts link without a coordinator.
Verify independence was reframed as an invocation contract rather than runtime self-detection.
Smaller corrections: behavioural Fails route to the builder as a stated exception, the `pre-build-review` verdict is correctly ternary, the inaccurate `hig-review` one-line-format attribution was dropped, the Tier 1 focus check was pinned to a stylelint outline rule, and the external review-finding numbers were removed from the autonomy note.
