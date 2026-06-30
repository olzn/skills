# Post-build Review

Date: 2026-06-29
Status: Draft for review
Supersedes: `2026-06-28-ship-suite-design.md` (the "ship" suite, cut as overengineered for a solo design engineer)

## Purpose

A small read-only gate after implementation, the mirror of `pre-build-review`.
Its job is to confirm a built change actually matches the intent that was set, that it runs and is accessible, and to produce the evidence a reviewer needs, before the change is handed off.
It reviews and reports; it never edits.

## Where it fits

`grill-with-docs` then `paper-prototype` then `pre-build-review` then build with `ui-craft` then **`post-build-review`** then the PR.
It closes the two gaps the pipeline has after "build": nothing verifies the build against the chosen direction and the promised states, and nothing assembles the handoff evidence.

## Inputs

Whatever the change can be checked against, inspected from the repo rather than asked for where possible:

- the diff or the built change
- the chosen Paper direction (the labelled winning frame and its decision note) when present
- the `pre-build-review` verdict and its `Missing states` list when present
- `CONTEXT.md`, ADRs, and canonical terms
- the `ui-craft` quality bar, when that suite is installed (its `references/quality.md` and `references/accessibility.md`)
- nearby code and existing components

When the Paper direction or the state list is not written down, reconstruct the expected intent and states and say so; do not block on their absence.

## Workflow

1. Reconstruct in two to four sentences what the change was meant to do.
2. Run the checks: lint, typecheck, tests, build. Record pass or fail with the output.
3. Where there is a route or a Storybook story, run the build and check for console errors, axe violations, contrast, visible focus, and keyboard reachability.
4. Compare against intent: does the build match the chosen Paper direction (layout, hierarchy, spacing, type, colour roles, material differences only, never pixels), and does it cover the states the plan promised (empty, loading, error, disabled, long content, no data)?
5. Check craft and the obvious responsive and accessibility misses against the `ui-craft` bar.
6. Note any change to a risky surface (auth, permissions, API, routing, data). If present, do not approve; flag for an engineer and a security pass.
7. Decide the verdict and assemble the handoff evidence.

## Output

Lead with the verdict, mirroring `pre-build-review`:

- `Pass`: ready to hand off.
- `Pass with notes`: mergeable after the listed non-blocking fixes.
- `Fail`: return to an earlier stage first.

Then the useful detail:

- `Checks`: commands run and their results.
- `Intent match`: material differences from the chosen direction.
- `State coverage`: states covered and missing.
- `Accessibility and responsive`: concrete findings.
- `Risky surfaces`: anything touching auth, permissions, API, routing, or data.
- `Handoff evidence`: a ready-to-paste PR block (what changed, design reference, what was tested, reviewer focus, known risks).
- `Next step`: the single next action.

Each finding names the stage that owns it, so a `Fail` returns to the right place: intent to `paper-prototype`, states or scope to `pre-build-review`, domain or terms to `grill-with-docs`, craft to `ui-craft`.

## Rules

Read-only: it reviews and reports, it never fixes.
Run the checks rather than assert them; lead with evidence.
Be direct; prefer concrete scenarios to abstract warnings.
Intent and craft notes are advisory; do not gate on subjective taste.
Do not invent design direction.
If the change touches a risky surface, or you cannot personally explain it, escalate rather than approve.

## When to use

After a build or a meaningful change, before opening or finalising a PR, especially after `ui-craft`.
Not before implementation (that is `pre-build-review`), and not for design exploration (that is `paper-prototype`).

## Deliberately out of scope

Recorded so the cut is intentional, to be revisited only when this single skill proves itself and the specific pain is felt:

- a standing scheduled discovery loop, a triage queue, and per-project scan config
- a shared check catalogue and an auto-fix autonomy policy
- Codex portability contracts and committed upstream artifacts
- wiring `deepsec` into the workflow; run it by hand if a change is security-sensitive
- any loop automation: build and trust this checker by hand first, and automate only once you would trust it unattended
