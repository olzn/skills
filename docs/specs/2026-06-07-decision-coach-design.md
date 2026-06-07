# Decision Coach — Design Spec

**Date:** 2026-06-07
**Status:** Approved design, pending spec review
**Location:** `skills/decision-coach/` (standalone skill in this repo)

## Purpose

A skill that coaches the user through a real decision and stress-tests their
reasoning, grounded in six decision-making books rather than generic advice. It
exists to make the user's *process* better — because process is the only part of
a decision they control — and to teach the underlying frameworks by naming their
source as it uses them.

## Source corpus

All material is distilled (ideas and frameworks, not verbatim text) from:

- **Thinking in Bets** — Annie Duke
- **How to Decide** — Annie Duke
- **Superforecasting** — Philip Tetlock & Dan Gardner
- **The Great Mental Models, Vol. 1–3** — Shane Parrish / Rhiannon Beaubien

The corpus collapses into **three functional layers** rather than six silos:

1. **Decision process (spine)** — Duke's two books, essentially one workbook.
2. **Forecasting / calibration toolkit** — Tetlock.
3. **Latticework of lenses** — Great Mental Models (decision-relevant subset).

## Design decisions (locked during brainstorming)

| Decision | Choice | Rationale |
|---|---|---|
| Primary job | Coach a live decision | User's stated primary use |
| Secondary job | Critique already-formed reasoning | User's stated secondary use |
| Architecture | One unified skill + on-demand reference files | Books overlap heavily; coaching one decision is a single coherent activity; a sub-skill router would force the user to know which to call. Modularity lives in reference files. |
| Activation | Explicit only | User invokes it; no surprise coaching |
| Model catalogue scope | Decision-relevant subset (~20–25) | Drop "explain-the-world" models (thermodynamics, surface area) that don't sharpen a decision |
| Placement | `skills/decision-coach/` in this repo, committed | User's call, made knowingly (repo is public) |
| Provenance | Light source attribution inline | Teaches lineage, signals grounding, avoids citation clutter |

## Architecture

```text
skills/decision-coach/
├── SKILL.md                          # lean coaching process; routes into references
└── references/
    ├── decision-process.md           # Duke toolkit + decision-journal template
    ├── forecasting.md                # Tetlock calibration toolkit + Ten Commandments
    ├── mental-models.md              # ~20–25 decision-relevant models
    └── biases-and-critique.md        # named biases + Critique-mode checklist
```

Progressive disclosure: `SKILL.md` holds the process and decides *when* to pull a
reference in; the heavy material lives in the reference files and loads only when
the situation calls for it.

## SKILL.md — the coaching process

Two entry modes, one shared engine.

- **Coach mode** (default): user brings a live decision → run the phases below,
  adaptively.
- **Critique mode**: user brings reasoning they've already formed → jump to
  Phase 3 (stress-test + bias sweep) and the calibration check, skip framing.

### Phase 0 — Frame & triage

1. Pin down the **actual decision** and the **goal/values** behind it (this is
   "Preferences" — what outcomes the user actually wants, and why).
2. **Triage how much the decision deserves** before investing effort:
   - Happiness Test — will this matter in a year? a month? a week? (Duke)
   - Is it reversible — a two-way door? a freeroll? a repeating option? (Duke)
   - Am I inside my circle of competence here? (GMM Vol 1)
   - Tetlock's triage: is this even in the "Goldilocks zone" where effort pays?
3. **Route**: low-stakes / reversible / close-call → fast path (only-option test,
   "when a decision is hard, it's easy", coin flip). Consequential and
   hard-to-reverse → full process below.

### Phase 1 — Map (deep path only)

1. Enumerate the **reasonable set of options**.
2. For the leading option(s), build the **decision tree** of possible outcomes —
   the full set that was reasonable *before* knowing how it turns out.
3. Run the **Three Ps** (Duke):
   - **Preferences** — rank outcomes by the user's goals/values.
   - **Payoffs** — size the upside and downside in the currency the user actually
     values (money, time, happiness, reputation, health).
   - **Probabilities** — likelihood of each outcome (handed to Phase 2).

### Phase 2 — Calibrate (forecasting layer)

1. **Outside view first** — base rates: "how often do things like this turn out
   X in situations like this?" Anchor here *before* the case specifics, because
   of anchoring. (Tetlock)
2. **Then inside view** — adjust for what's genuinely specific to this case.
3. **Fermi-ize** hard estimates — decompose into knowable sub-questions.
4. **Force numbers, not words** — bull's-eye estimate + range + shock test;
   be as granular as the problem genuinely supports.
5. Compare options by **expected value** where it clarifies (payoff × probability).

### Phase 3 — Stress-test (surface blind spots; also the Critique-mode entry)

1. **Premortem** — assume it failed; list why (split skill vs. luck reasons).
2. **Backcast** — assume it succeeded; list how.
3. Apply **2–3 fitting mental-model lenses** chosen for the situation
   (from `mental-models.md`): inversion ("what guarantees failure?"),
   second-order thinking ("and then what?"), find-the-zero / bottleneck,
   margin of safety, regression to the mean, the razors, etc.
4. **Bias sweep**: resulting, hindsight, motivated reasoning, self-serving bias,
   scope insensitivity, sunk cost, confirmation, the wrong-side-of-maybe fallacy.

### Phase 4 — Decide & protect

1. Compare options and **satisfice** — pick "good enough" rather than chasing the
   maximum (paralysis). Only-option test to break ties. (Duke)
2. **Protect the decision from your future self**: precommit (Ulysses contract),
   hedge the downside, and write down *what would change your mind* (stopping
   rule).
3. **Journal the decision now** — the choice, the reasoning, the probabilities,
   the tree — so it can later be judged on *process, not outcome*, defeating
   hindsight bias. Use the decision-journal template.

### Adaptivity (a feature, not a shortcut)

Phase 0 can route a trivial or reversible decision straight to a one-line answer.
Only consequential, hard-to-reverse decisions earn the full treatment. This
self-throttling *is* the source material's teaching (Duke's time-vs-accuracy
trade-off; Tetlock's triage commandment), so honoring it keeps the skill faithful.

## Reference files — contents

### `references/decision-process.md` (Duke)

Resulting & the decision-quality vs. outcome-quality matrix; the decision
multiverse / tree; counterfactuals; the Three Ps in detail; the speed framework
(Happiness Test, freeroll, only-option test, two-way door, decision stacking,
parallel options, the stopping rule); premortem + backcast + decision exploration
table; precommitment / category decisions / Dr. Evil game; hedging; tilt &
decision hygiene; **a reusable decision-journal template**.

### `references/forecasting.md` (Tetlock)

Outside view → inside view; base rates; Fermi-izing; granular probabilities;
bull's-eye + range + shock test; calibration vs. resolution and the Brier idea;
updating in small increments (under- vs. over-reaction); fox vs. hedgehog; active
open-mindedness; scope sensitivity; **the Ten Commandments** as a checklist.

### `references/mental-models.md` (GMM, decision-relevant subset)

~20–25 models, each formatted as **what it is · when to reach for it · the
question it forces**, grouped by job:

- **Diagnose the situation**: map ≠ territory, circle of competence, bottlenecks,
  multiplying-by-zero, regression to the mean, base rates / probabilistic
  thinking, scale, equilibrium.
- **Generate options**: first principles, inversion, equivalence (many paths to
  the same result), global vs. local maxima.
- **Pressure-test**: second-order thinking, margin of safety, compounding,
  feedback loops, thought experiment, fat tails / antifragility.
- **Interpret people & causes**: Occam's razor, Hanlon's razor, incentives,
  reciprocity, correlation ≠ causation, necessity vs. sufficiency.

(Final list to be fixed during planning; target 20–25.)

### `references/biases-and-critique.md`

Named biases (resulting, hindsight / memory creep, motivated reasoning,
self-serving bias, confirmation bias, scope insensitivity, sunk cost, anchoring,
overconfidence, availability/recency, status-quo bias, the wrong-side-of-maybe
fallacy) — each with a one-line tell and the corrective question. Plus the
**Critique-mode checklist**: a sequenced set of probes to run against reasoning
the user has already formed.

## Frontmatter & conventions

Follow the repo's existing skill convention (`name`, `description` YAML
frontmatter + markdown body, as in `skills/prototype/SKILL.md`). The `description`
must make activation **explicit-only**: it should describe *what the skill does*
and trigger on deliberate invocation and decision-coaching requests, not fire
automatically on every mention of a choice. Add the skill to `README.md` under
"Standalone Skills".

## Non-goals (YAGNI)

- No six-skill suite / router.
- No "explain-the-world" mental models that don't sharpen a decision.
- No automatic / proactive activation.
- No verbatim book text or heavy citation apparatus.
- No external tooling, scripts, or installers beyond what the repo already has.

## Success criteria

1. Invoking the skill on a real decision produces a structured walk-through that
   visibly draws on the three layers and names its sources.
2. Critique mode takes already-formed reasoning and surfaces concrete biases /
   blind spots with corrective questions.
3. The skill adapts depth to stakes (trivial decisions don't get the full
   treatment).
4. Reference files are faithful to the source frameworks and usable as
   standalone lookups.
5. Frontmatter keeps activation explicit-only; skill is listed in `README.md`.
