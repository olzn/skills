---
name: prototype
description: Generate N different HTML implementations of a UI feature, preview them, and iterate a few times, a fast "show me the options" loop for exploring what a feature could look like. Default N is 5. Use when the user wants to prototype a UI, explore or compare designs for a feature, says "prototype this", "try a few designs", "explore some options for X", "what could this look like", or hands over a feature with no spec. Surfaces a quiet recommendation inside the preview but does NOT collapse to one winner, do research, implement, verify, or open a PR; those are layered on at prompt time, or handed to /verify and /code-review.
---

# Prototype

`prototype` answers one question, **what could this look like?**, with `N`
previewable HTML takes you can click through. It explores and quietly flags a
favourite. It does **not** collapse to one option, research, implement, verify, or
ship. When a direction wins, hand the build off (`/verify`, `/code-review`); the
HTML here is throwaway.

## Inputs

- **Feature** (required): what you're prototyping, however loosely phrased
  ("prototype the autocomplete dropdown", "try a few designs for the empty state").
- **N** (optional, **default 5**): how many implementations to generate. Honour an
  explicit count ("prototype 3 options...").

If the feature is genuinely unclear, ask one tight question. Otherwise proceed.

## Generate

Produce `N` **self-contained, single-file HTML** files (inline CSS/JS, no build
step, openable directly in a browser), each a genuinely *different* implementation
of the feature. Three rules keep the set useful:

1. **Anti-wallpaper guard.** Variants must differ *structurally* (layout,
   hierarchy, interaction model), not be the same thing recoloured. If it helps,
   name the single axis they vary along (density, hierarchy, mood, disclosure) and
   state it, so the comparison means something.
2. **Respect existing conventions.** Before generating, glance at the project for
   design tokens, component conventions, and a `CONTEXT.md`. Match them so the
   options feel like they belong in *this* product, not generic demos.
3. **Stress-content the previews.** Populate with realistic *and* edge-case content:
   long strings, empty and error states, narrow widths, keyboard focus. The point
   of a real preview is to surface problems a static mockup hides, while you're
   still choosing.

## Preview

Emit one small `index.html` gallery that links to (or embeds) all `N` files, so
there is a single surface to look through. Print the file paths too, so they can be
opened directly or via whatever one command the project already uses.

## Quietly mark the recommendation

Form an opinion and surface it **understated**, inside the artifact, never as a
loud prose verdict:

- A small, low-key marker on the favoured variant in the gallery (e.g. a muted
  "Claude's pick" dot/badge) and **one** short line of rationale in small,
  low-contrast text.
- **Do not** add a banner or modal, and **do not** reorder the pick to the front. It
  must be ignorable. The user is the design lead; this is a nudge, not a decision.
- If the user would rather not see it, omit it.

## Iterate

Refine on request; a few passes is normal. The user drives and owns the decision.
Never auto-collapse to the recommended option; only consolidate when the user
chooses one or edits toward it.

## Scope

That's the whole skill. Heavier steps (researching patterns first, implementing the
winner for real, opening a PR with a screenshot) stay **at prompt time** when the
user asks for them, exactly as a person would layer them on. They are deliberately
not baked in. For building and shipping a chosen direction, use `/verify` and
`/code-review`. The recommendation is the single opinion this skill expresses, and
it expresses it quietly.
