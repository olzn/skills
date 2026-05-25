---
name: paper-prototype
description: Build a throwaway prototype to answer one question before committing to a direction. Uses Paper via MCP first for UI/design questions, a tiny terminal app for logic/state questions, and code only when runtime behaviour is the thing being tested. Use when the user wants to prototype, sanity-check a data model or state machine, explore UI directions, mock up a flow, or says "prototype this", "try a few designs", "let me play with it".
---

# Paper Prototype

A prototype is **throwaway work that answers a question**. The question decides the shape.

## Pick a branch

Identify which question is being answered — from the user's prompt, the surrounding code, or by asking if the user is around:

- **"Does this logic / state model feel right?"** → [LOGIC.md](LOGIC.md). Build a tiny interactive terminal app that pushes the state machine through cases that are hard to reason about on paper.
- **"What should this look or feel like?"** → [UI.md](UI.md). Default to Paper via MCP: create 2–3 distinct artboard directions on the canvas before writing code.
- **"Will this work in the actual app/runtime?"** → make a minimal code spike near the real surface. Use this only when the question depends on live data, routing, responsiveness, complex state, animation, or implementation feasibility.

Getting this wrong wastes the prototype. If ambiguous and the user is not reachable, default to Paper for visual/interface uncertainty, terminal logic for domain/state uncertainty, and code only for runtime uncertainty. State the assumption before prototyping.

## If this follows grill-with-docs

Before prototyping, preserve the decisions already made:

1. Read the relevant `CONTEXT.md` and ADRs.
2. Use the project's canonical terms in the prototype.
3. Do not silently redefine domain boundaries that were already resolved.
4. Prototype the remaining product/design question, not the whole domain model again.

Keep this lightweight. This is context alignment, not a second grilling session.

## Rules that apply to all prototypes

1. **One question.** Write the question down before starting. If there are multiple questions, pick the one that blocks progress most.
2. **Throwaway from day one.** Name or place the artifact so it is obviously a prototype, not production.
3. **No persistence by default.** State lives in memory or on the Paper canvas. Persistence is only included if persistence is the thing being tested.
4. **Skip production polish.** No tests, no abstractions, no generalized architecture unless the prototype specifically tests architecture.
5. **Surface the state or direction.** Logic prototypes show state after every action. UI prototypes show multiple visible directions side-by-side or as clear variants.
6. **Capture the answer.** When the prototype has answered its question, record the decision somewhere durable: notes, issue, ADR, commit message, or nearby `NOTES.md`.
7. **Delete, absorb, or leave intentionally.** Do not leave stale prototype code in the repo. Paper artboards can remain as design history if useful, but mark the chosen direction clearly.

## When done

The answer is the only thing worth keeping from a prototype. Summarize:

- the question
- the chosen direction / learned constraint
- what should happen next

If the user is around, confirm the answer with them. If not, leave a concise note so the next pass can either delete the prototype or fold the validated decision into real work.
