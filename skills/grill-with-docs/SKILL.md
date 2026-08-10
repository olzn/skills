---
name: grill-with-docs
description: Grilling session that challenges your plan against the existing domain model, sharpens terminology, and updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise. Use when the user wants to stress-test a plan against their project's language and documented decisions.
---

<what-to-do>

Interview the user relentlessly about every aspect of their plan until you reach a shared understanding. If no plan has been stated yet, ask for it first. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time, waiting for the user's feedback on each question before continuing.

If a question can be answered by exploring the codebase, explore the codebase instead.

</what-to-do>

<supporting-info>

## Domain awareness

Before proposing any term, detect the repo's existing canonical doc system — you are challenging against it, not against a blank page. Look for a root glossary (`CONTEXT.md` or an equivalent repo-wide glossary file), an established ADR directory, and per-directory agent or context docs that carry local conventions and invariants. Read what exists before the first question.

### File structure

Most repos have a single context:

```
/
├── CONTEXT.md
├── docs/
│   └── adr/
│       ├── 0001-event-sourced-orders.md
│       └── 0002-postgres-for-write-model.md
└── src/
```

If a `CONTEXT-MAP.md` exists at the root, the repo has multiple contexts. The map points to where each one lives:

```
/
├── CONTEXT-MAP.md
├── docs/
│   └── adr/                          ← system-wide decisions
├── src/
│   ├── ordering/
│   │   ├── CONTEXT.md
│   │   └── docs/adr/                 ← context-specific decisions
│   └── billing/
│       ├── CONTEXT.md
│       └── docs/adr/
```

Create files lazily, only when you have something to write. If no glossary exists anywhere, create a root `CONTEXT.md` when the first term is resolved. If no ADR home exists, create `docs/adr/` when the first ADR is needed.

### Don't fork the canon

Never create a competing `CONTEXT.md` or a parallel `docs/adr/` when the repo already has a canonical glossary or ADR home under another name — a second glossary forks the first. Extend the existing system instead. A decision that belongs to a wider system with its own owned docs routes through that system's owners as a separate change: flag it, don't quietly file it.

## During the session

### Challenge against the glossary

When the user uses a term that conflicts with the existing language in `CONTEXT.md` or any repo-wide glossary, call it out immediately. "Your glossary defines 'cancellation' as X, but you seem to mean Y. Which is it?"

### Sharpen fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term. "You're saying 'account'. Do you mean the Customer or the User? Those are different things."

### Discuss concrete scenarios

When domain relationships are being discussed, stress-test them with specific scenarios. Invent scenarios that probe edge cases and force the user to be precise about the boundaries between concepts.

### Cross-reference with code

When the user states how something works, check whether the code agrees. If you find a contradiction, surface it: "Your code cancels entire Orders, but you just said partial cancellation is possible. Which is right?"

### Update CONTEXT.md inline

When a term is resolved, update `CONTEXT.md` right there. Don't batch these up; capture them as they happen. Use the format in [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md).

`CONTEXT.md` should be totally devoid of implementation details. Do not treat `CONTEXT.md` as a spec, a scratch pad, or a repository for implementation decisions. It is a glossary and nothing else.

### Offer ADRs sparingly

Only offer to create an ADR when the decision passes the three-part test in [ADR-FORMAT.md](./ADR-FORMAT.md) — hard to reverse, surprising without context, the result of a real trade-off. If any part is missing, skip the ADR. Use the format in the same file.

## Closing the session

When grilling was entered from a larger planning or build workflow (the `build` skill, a `pre-build-review` no-go, your own planning loop), end by stating what the session settled — terms resolved, decisions recorded, questions still open — and hand back to the invoking workflow. Do not drift into implementation.

</supporting-info>

## Credits

Derived from and building on Matt Pocock's MIT-licensed skills ([github.com/mattpocock/skills](https://github.com/mattpocock/skills)): `grill-with-docs`, `grilling`, and `domain-modeling`; upstream licence in [LICENSE-upstream](./LICENSE-upstream).
