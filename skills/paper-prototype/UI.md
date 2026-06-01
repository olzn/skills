# UI Prototype: Paper First

Use this when the question is **"what should this interface look, feel, or flow like?"**

Default to Paper via MCP before writing code. The canvas is the shared design surface: the user can inspect, rearrange, edit, delete, or combine ideas directly before anything is committed to the codebase.

This skill is most useful after `grill-with-docs`: product and domain decisions are settled enough that the remaining work is to explore interface direction.

## When this is the right shape

- "What should this page look like?"
- "Try a few designs for this flow."
- "I want to explore directions before committing."
- "Can we mock this up first?"
- Any time coding a throwaway route would prematurely lock the work into implementation details.

## When Paper is the wrong shape

Stop and say so when the question cannot be answered well on the Paper canvas, for example:

- business logic or state modelling
- persistence semantics
- live data density or loading behaviour
- real routing/navigation constraints
- responsive behaviour across breakpoints
- complex local state
- keyboard behaviour
- animation timing or gesture feel
- component API ergonomics
- implementation feasibility inside the existing component system

Recommend a logic prototype or code spike instead. Do not silently fall back to code for a UI-direction prompt unless the user approves.

## Process

### 1. Load Paper context

Before using other Paper tools in a session:

1. Call `get_guide({ topic: "paper-mcp-instructions" })`.
2. Call `get_basic_info`.
3. Call `get_selection` to understand user focus.
4. Before first typographic styling, call `get_font_family_info` for the intended font families.

If Paper MCP is not available, stop and tell the user. Do not silently fall back to code for a UI-direction question unless they approve.

### 2. Align with settled decisions

If this follows `grill-with-docs`, create a one-page Prototype Brief before touching Paper. Read the relevant `CONTEXT.md` and ADRs before creating anything. Extract:

- canonical terms
- user roles
- key states
- constraints
- non-negotiable product decisions
- open design questions

Capture the brief in lightweight form:

- goal
- non-goals
- settled decisions
- constraints
- core states
- open design questions
- good enough
- sources

State the brief and ask whether anything is wrong or missing. Use settled terms and constraints in the artboards. Do not re-litigate the domain model. If the brief exposes unresolved product or domain decisions, stop and return to `grill-with-docs`.

### 3. Calibrate fidelity

Before creating artboards, calibrate fidelity if the user has not specified it and the choice would materially change the prototype.

Use these levels:

- **Sketch:** rough boxes, labels, layout ideas, and fast comparison.
- **Structural:** clear hierarchy, real content shape, and visible state coverage, with plain visual treatment.
- **Product-realistic:** plausible app UI with credible components, spacing, density, and interaction affordances.
- **Polished:** presentation-quality visual direction with refined colour, typography, component treatment, and brand feel.
- **Implementation-adjacent:** close enough to guide code, with component, state, responsive, and interaction implications made explicit.

Match fidelity to the question. Use low fidelity for structure and flow decisions; use high fidelity only when visual language, perceived quality, component treatment, or implementation guidance is the question.

### 4. State the prototype contract

Write the contract before touching Paper:

- **Question:** one sentence.
- **Already decided:** the constraints that must carry through.
- **Still open:** what the variants are allowed to disagree about.
- **Fidelity:** sketch, structural, product-realistic, polished, or implementation-adjacent.
- **Exit condition:** what answer lets us stop.

Good:

> "Which layout best communicates workspace suspension as reversible but billing-relevant?"

Bad:

> "Make the settings page better."

### 5. Propose directions before drawing

Name the intended directions before creating them so the user can steer. Default to these three:

- **System-native:** closest to existing product patterns and component constraints.
- **Decision-forward:** organised around the user's primary decision or commitment.
- **High-leverage divergence:** a meaningfully different structure, flow, or interaction model.

Use 2 directions for small questions. Avoid more than 5.

### 6. Create distinct Paper directions

Each direction should be structurally different, not merely reskinned:

- different layout
- different hierarchy
- different flow
- different density
- different primary affordance
- different framing of the user's decision

Three card grids with different colours is not a prototype.

Use artboards or clearly named frames for each direction. Name them by the idea, not just A/B/C, for example:

- `A: Confirmation first`
- `B: Inline control panel`
- `C: Review and commit`

### 7. Work incrementally on the canvas

Use Paper MCP as a design tool, not as a one-shot renderer.

- Prefer small `write_html` calls: header, section, row, action group, etc.
- Use `duplicate_nodes`, `update_styles`, and `set_text_content` when faster than rewriting.
- Keep variants editable and understandable in the layer tree.
- Do not over-polish losing directions; make them good enough to judge.
- Keep prototype frames labelled as explorations, not implementation-ready UI.

After each direction or substantial change, call `get_screenshot` and check:

- spacing
- typography
- contrast
- alignment
- artboard fit
- whether the direction actually answers the question

Fix obvious issues before moving on.

### 8. Preserve user control

The user may change the canvas manually. Treat those edits as design feedback, not interference.

If the user combines parts of multiple directions, help consolidate the emerging winner into a clearer final artboard/frame.

Do not declare a winning direction unless the user chooses one or gives clear instruction.

### 9. Capture the answer

When a direction wins, record:

- which direction won
- what parts were kept or rejected
- why it answered the question
- interaction/state questions still unresolved
- what should be implemented next

Label the winning frame and add a short decision note on the Paper canvas. If the decision affects durable product or domain understanding, update `CONTEXT.md` or an ADR separately.

### 10. Translate only when asked

If the user wants code next, first create a design-engineering translation note:

- existing components that map to the direction
- new components likely needed
- values that should become tokens
- details that are visual only
- details that affect behaviour or state
- simplifications acceptable in production
- what should be prototyped in code before implementation

Use Paper MCP tools like `get_jsx`, `get_computed_styles`, `get_tree_summary`, screenshots, and node inspection to translate the chosen direction. Do not infer exact values from screenshots alone.

When validated behaviour is absorbed into production code, add normal tests around the production implementation. Do not test the throwaway Paper prototype.

## Stop Conditions

Stop prototyping when:

- the question is answered
- variants are converging
- the user has made a clear canvas edit that establishes direction
- the remaining uncertainty is implementation rather than design
- the prototype is becoming production work

## Anti-patterns

- **Starting with a throwaway route for a visual question.** That is implementation gravity too early.
- **Variants that differ only in colour or copy.** Real variants disagree about structure or flow.
- **Ignoring the domain language from grilling.** Pretty but semantically wrong is still wrong.
- **Choosing a winner for the user.** The agent proposes directions. The user owns the design call.
- **One giant HTML dump.** It is harder to review, edit, and repair.
- **Promoting prototype output directly to production.** Treat Paper as evidence, not final implementation.
