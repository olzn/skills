---
name: post-build-review
description: Run a post-implementation review that checks a built change against the intent that was set. Run lint, typecheck, tests, and build; confirm the result matches the chosen design direction and covers its promised states (empty, loading, error, disabled, long content, and partially complete data); check accessibility and responsive behaviour; flag any risky surface; and assemble the handoff evidence a reviewer needs. Read-only: it reviews and reports, it never edits. Use after a build or a meaningful change, after ui-craft and before opening or finalising a PR, especially when the user asks to verify, review, sign off, or sanity-check a built change before handoff.
---

# Post-build Review

## Overview

Use this as a small gate after implementation, the read-only mirror of `pre-build-review`.
Its job is to confirm a built change matches the intent that was set, that it runs and is accessible, and to produce the evidence a reviewer needs before handoff.
It reviews and reports; it never edits.

Do not turn this into a redesign.
Check the build against the intent, run the checks, name what is off, and decide whether it is ready to hand off.

## Inputs

Use whatever the change can be checked against, inspected from the repo rather than asked for where possible:

- the diff or the built change
- the chosen Paper direction (the labelled winning frame and its decision note) when present
- the `pre-build-review` verdict and its `Missing states` list when present
- `CONTEXT.md`, ADRs, and canonical terms
- the `ui-craft` quality bar, when that suite is installed (its `references/quality.md` and `references/accessibility.md`)
- nearby code and existing components

When the Paper direction or the state list is not written down, reconstruct the expected intent and states and say so; do not block on their absence.

## Workflow

1. Reconstruct in 2 to 4 sentences what the change was meant to do.
2. Run the checks: lint, typecheck, tests, build. Record pass or fail with the output.
3. Where there is a route or a Storybook story, run the build and check for console errors, axe violations, contrast, visible focus, and keyboard reachability.
4. Compare against intent: does the build match the chosen Paper direction (layout, hierarchy, spacing, type, colour roles, material differences only, never pixels), and does it cover the states the plan promised (empty, loading, error, disabled, long content, and partially complete data)?
5. Check craft and the obvious responsive and accessibility misses against the `ui-craft` quality bar where available.
6. Note any change to a risky surface (auth, permissions, API, routing, data). If present, do not approve; flag for an engineer and a security pass.
7. Decide the verdict and assemble the handoff evidence.

## Output

Lead with the verdict, mirroring `pre-build-review`:

- `Pass`: ready to hand off.
- `Pass with notes`: mergeable after the listed non-blocking fixes.
- `Fail`: return to an earlier stage first.

Then provide only the useful detail:

- `Checks`: commands run and their results.
- `Intent match`: material differences from the chosen direction.
- `State coverage`: states covered and missing.
- `Accessibility and responsive`: concrete findings.
- `Risky surfaces`: anything touching auth, permissions, API, routing, or data.
- `Handoff evidence`: a ready-to-paste PR block (what changed, design reference, what was tested, reviewer focus, known risks).
- `Next step`: the single next action.

Each finding names the stage that owns it, so a `Fail` returns to the right place: intent to `paper-prototype`, states or scope to `pre-build-review`, domain or terms to `grill-with-docs`, craft to `ui-craft`.

## Rules

- Read-only: it reviews and reports, it never fixes.
- Run the checks rather than assert them; lead with evidence.
- Be direct; prefer concrete scenarios to abstract warnings.
- Intent and craft notes are advisory; do not gate on subjective taste.
- Do not invent design direction.
- If the change touches a risky surface, or you cannot personally explain it, escalate rather than approve.
