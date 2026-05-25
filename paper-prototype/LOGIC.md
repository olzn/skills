# Logic Prototype

Use this when the question is about **business logic, state transitions, data shape, or API feel** — the kind of thing that looks reasonable in discussion but only feels wrong once you push it through cases.

If the question is "what should this look or feel like?" use [UI.md](UI.md) and prototype in Paper first.

## When this is the right shape

- "Does this state machine handle the edge case where X then Y?"
- "Can this data model represent the weird case?"
- "I want to feel out the API before writing it properly."
- Anything where the user wants to press buttons and watch state change.

## Process

### 1. State the question

Before writing code, write down what state model and what question the prototype answers. One paragraph in a README, notes file, or comment is enough.

If this follows `grill-with-docs`, use the canonical terms from `CONTEXT.md`/ADRs.

### 2. Pick the host language

Use whatever the project already uses. Match existing tooling. Do not add a new package manager or runtime just for the prototype.

### 3. Isolate the logic behind a tiny interface

The throwaway terminal shell should be separate from the useful logic.

Good shapes include:

- a pure reducer: `(state, action) => state`
- an explicit state machine
- a small set of pure functions over a plain data type
- a class/module with a clear method surface when ongoing internal state is the question

Keep it pure: no I/O, no terminal code, no `console.log` for control flow.

### 4. Build the smallest interactive terminal shell

On every action, re-render a single clear frame:

1. Current state, pretty-printed and diff-friendly.
2. Keyboard shortcuts or commands.

Behaviour:

1. Initialize a single in-memory state object.
2. Read one keystroke or line at a time.
3. Dispatch to a handler.
4. Re-render the full state.
5. Loop until quit.

The whole frame should fit on one screen.

### 5. Make it runnable in one command

Use the project's task runner if one exists:

- `pnpm run prototype:<name>`
- `npm run prototype:<name>`
- `python path/to/prototype.py`
- `bun path/to/prototype.ts`

If there is no task runner, put the command at the top of the prototype file or README.

### 6. Capture the answer

When the prototype has done its job, record what it taught you. Then delete the shell or fold the validated logic into real code.

## Anti-patterns

- Adding tests.
- Wiring to the real database unless persistence is the question.
- Generalising for hypothetical future cases.
- Mixing terminal UI into the reducer/state machine.
- Shipping the terminal shell into production.
