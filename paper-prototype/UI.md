# UI Prototype — Paper-first

Use this when the question is **"what should this look or feel like?"**

Default to Paper via MCP before writing code. The canvas is the shared design surface: the user can inspect, rearrange, edit, delete, or combine ideas directly before anything is committed to the codebase.

If the question is about logic/state rather than interface direction, use [LOGIC.md](LOGIC.md). If the question depends on runtime behaviour, use a small code spike instead.

## When this is the right shape

- "What should this page look like?"
- "Try a few designs for this flow."
- "I want to explore directions before committing."
- "Can we mock this up first?"
- Any time coding a throwaway route would prematurely lock the work into implementation details.

## When to prototype in code instead

Use code only when the question cannot be answered well on the Paper canvas, for example:

- live data density or loading behaviour
- real routing/navigation constraints
- responsive behaviour across breakpoints
- complex local state
- animation timing or gesture feel
- implementation feasibility inside the existing component system

Even then, consider starting in Paper for visual direction, then moving the chosen direction into a code spike.

## Process

### 1. Load Paper context

Before using other Paper tools in a session:

1. Call `get_guide({ topic: "paper-mcp-instructions" })`.
2. Call `get_basic_info`.
3. Call `get_selection` to understand user focus.
4. Before first typographic styling, call `get_font_family_info` for the intended font families.

If Paper MCP is not available, stop and tell the user. Do not silently fall back to code for a UI-direction question unless they approve.

### 2. State the question

Write the prototype question in one sentence.

Good:

> "Which layout best communicates workspace suspension as reversible but billing-relevant?"

Bad:

> "Make the settings page better."

If this follows `grill-with-docs`, use the canonical terms from `CONTEXT.md`/ADRs and do not re-litigate already settled domain decisions.

### 3. Create 2–3 distinct directions

Default to **3 directions**. Use 2 for small questions. Avoid more than 5.

Each direction should be structurally different, not merely reskinned:

- different layout
- different hierarchy
- different flow
- different density
- different primary affordance
- different framing of the user's decision

Three card grids with different colours is not a prototype.

Use artboards or clearly named frames for each direction. Name them by the idea, not just A/B/C, for example:

- `A — Confirmation-first`
- `B — Inline control panel`
- `C — Review and commit`

### 4. Work incrementally on the canvas

Use Paper MCP as a design tool, not as a one-shot renderer.

- Prefer small `write_html` calls: header, section, row, action group, etc.
- Use `duplicate_nodes`, `update_styles`, and `set_text_content` when faster than rewriting.
- Keep variants editable and understandable in the layer tree.
- Do not over-polish losing directions; make them good enough to judge.

After each meaningful section or direction, call `get_screenshot` and check:

- spacing
- typography
- contrast
- alignment
- artboard fit
- whether the direction actually answers the question

Fix obvious issues before moving on.

### 5. Let the user edit directly

The user may change the canvas manually. Treat those edits as design feedback, not interference.

If the user combines parts of multiple directions, help consolidate the emerging winner into a clearer final artboard/frame.

### 6. Capture the answer

When a direction wins, record:

- which direction won
- what parts were kept or rejected
- why it answered the question
- what should be implemented next

If the user wants code next, use Paper MCP tools like `get_jsx`, `get_computed_styles`, `get_tree_summary`, screenshots, and node inspection to translate the chosen direction. Do not infer exact values from screenshots alone.

## Anti-patterns

- **Starting with a throwaway route for a visual question.** That is implementation gravity too early.
- **Variants that differ only in colour or copy.** Real variants disagree about structure or flow.
- **Ignoring the domain language from grilling.** Pretty but semantically wrong is still wrong.
- **One giant HTML dump.** It is harder to review, edit, and repair.
- **Promoting prototype output directly to production.** Treat Paper and prototype code as evidence, not final implementation.
