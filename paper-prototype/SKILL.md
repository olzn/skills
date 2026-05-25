---
name: paper-prototype
description: Create Paper-first UI prototype directions, especially after grill-with-docs has settled product and domain decisions. Use when the user wants to explore interface directions, mock up a flow, compare visual or interaction approaches, turn product decisions into editable Paper artboards, or says "prototype this", "try a few designs", "explore directions", or "let me play with it". Do not use for business-logic or state-machine prototyping unless the user explicitly asks for Paper output.
---

# Paper Prototype

Paper prototypes are **throwaway UI explorations that answer one design question**.

The main job is to turn settled product/domain decisions into 2 to 3 editable Paper directions so the user can make the design call before implementation.

## Default Workflow

Use [UI.md](UI.md) for the full workflow.

Start in Paper when the open question is about:

- layout or information hierarchy
- flow shape
- visual framing
- density
- affordances
- how product decisions should appear in the interface

Do not jump to code for a UI-direction question. The canvas is the shared decision surface.

## Post-Grilling Gate

When this follows `grill-with-docs`, preserve the decisions already made before touching Paper:

1. Read the relevant `CONTEXT.md` and ADRs.
2. Extract canonical terms, user roles, key states, constraints, non-negotiable product decisions, and open design questions.
3. Use those terms and constraints in the prototype.
4. Prototype only the remaining interface question. Do not re-litigate the product model or silently redefine domain boundaries.

Keep this lightweight. This is alignment, not a second grilling session.

## Prototype Contract

Before creating artboards, state:

- **Question:** what are we trying to learn?
- **Medium:** Paper by default.
- **Fidelity:** sketch, structural, visual, interactive, or implementation-adjacent.
- **Exit condition:** what answer lets us stop?

If the remaining uncertainty is business logic, state modelling, persistence, live data, routing, responsiveness, animation feel, keyboard behaviour, component API ergonomics, or implementation feasibility, say so directly. Recommend the appropriate prototype shape instead of forcing Paper to answer a question it cannot answer.

## User Control

The agent proposes directions. The user owns the design decision.

Do not collapse variants into a final direction unless the user chooses one or gives clear instruction. If the user edits the Paper canvas, treat those edits as design feedback and consolidate around them.

## When done

The answer is the only thing worth keeping from a prototype. Summarise:

- the question
- the chosen direction or remaining uncertainty
- what was kept and rejected
- what should happen next

Label the winning Paper frame and add a concise decision note on the canvas. If the work affects durable product/domain decisions, update `CONTEXT.md` or an ADR separately.
