# Decision Coach Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a standalone, explicitly-invoked skill that coaches a user through a real decision (and critiques already-formed reasoning), grounded in six decision-making books.

**Architecture:** One lean `SKILL.md` holding a 5-phase coaching process, plus four on-demand reference files (Duke's decision process, Tetlock's forecasting toolkit, a 24-model mental-models catalogue, and a biases/critique checklist). Progressive disclosure: SKILL.md decides *when* to load each reference.

**Tech Stack:** Markdown only. YAML frontmatter (`name`, `description`) matching the repo's existing skill convention (`skills/prototype/SKILL.md`). No build, no runtime, no tests framework — verification is structural (frontmatter parses, required content present, cross-links resolve).

**Source material:** The frameworks for every file come from the distilled corpus produced during brainstorming (Duke × 2, Tetlock, Great Mental Models 1–3). Each task below lists the exact named frameworks/models/biases that file MUST contain, so it is fully specified without re-reading the books.

**Provenance rule (applies to every file):** when guidance uses an idea, name its source lightly inline — e.g. "(Duke's premortem)", "(Tetlock's outside view)", "(GMM: inversion)". No formal citations, no verbatim book text.

**Spec:** `docs/specs/2026-06-07-decision-coach-design.md`

---

## File Structure

```text
skills/decision-coach/
├── SKILL.md                          # Task 1–2: frontmatter + 5-phase process
└── references/
    ├── decision-process.md           # Task 3: Duke toolkit + journal template
    ├── forecasting.md                # Task 4: Tetlock toolkit + Ten Commandments
    ├── mental-models.md              # Task 5: the 24 decision-relevant models
    └── biases-and-critique.md        # Task 6: biases + Critique-mode checklist
README.md                             # Task 7: add to "Standalone Skills" list
```

One responsibility per file. SKILL.md is the interface and router; each reference is an independently-usable lookup.

---

## Locked content decisions

**The 24 mental models** (Task 5), grouped by job:

- **Diagnose the situation (8):** map ≠ territory · circle of competence · probabilistic thinking (base rates / Bayesian / fat tails) · bottlenecks · multiplying by zero (weakest link) · regression to the mean · scale (nonlinearity) · margin of safety
- **Generate options (4):** first principles · inversion · equivalence (many paths to one result) · global vs. local maxima
- **Pressure-test consequences (6):** second-order thinking · thought experiment · compounding · feedback loops · asymmetry / optionality (capped downside, large upside) · diminishing returns
- **Interpret people, causes & incentives (6):** Occam's razor · Hanlon's razor · incentives · reciprocity · correlation ≠ causation · necessity vs. sufficiency

**The named biases** (Task 6): resulting · hindsight / memory creep · motivated reasoning · self-serving bias · confirmation bias · scope insensitivity · sunk cost · anchoring · overconfidence · availability / recency · status-quo bias · the wrong-side-of-maybe fallacy.

---

### Task 1: Scaffold skill directory and SKILL.md frontmatter

**Files:**
- Create: `skills/decision-coach/SKILL.md`
- Create: `skills/decision-coach/references/` (directory, via the files in later tasks)

- [ ] **Step 1: Create the skill directory and SKILL.md with frontmatter + skeleton**

Create `skills/decision-coach/SKILL.md` starting with exactly this frontmatter (the `description` enforces explicit-only activation — it describes the skill and triggers on deliberate invocation / decision-coaching requests, and explicitly says it does NOT auto-fire):

```markdown
---
name: decision-coach
description: Coach a real decision to a better outcome, or stress-test reasoning you've already formed, using the frameworks from Annie Duke (Thinking in Bets, How to Decide), Philip Tetlock (Superforecasting), and Shane Parrish's Great Mental Models. Use when explicitly invoked — "use decision-coach", "help me decide X", "stress-test my thinking on Y", "coach me through this choice", "what mental model applies here". Runs a 5-phase process — frame & triage, map, calibrate, stress-test, decide & protect — and adapts depth to the stakes. Does NOT auto-activate on every mention of a choice; engage it deliberately.
---

# Decision Coach

<!-- body added in Task 2 -->
```

- [ ] **Step 2: Verify the frontmatter parses and matches convention**

Run:
```bash
cd skills/decision-coach && \
head -1 SKILL.md | grep -qx '\-\-\-' && echo "frontmatter opens OK" && \
grep -q '^name: decision-coach$' SKILL.md && echo "name OK" && \
grep -q '^description: ' SKILL.md && echo "description OK"
```
Expected: three OK lines.

- [ ] **Step 3: Commit**

```bash
git add skills/decision-coach/SKILL.md
git commit -m "feat(decision-coach): scaffold skill with frontmatter"
```

---

### Task 2: Write the SKILL.md coaching process

**Files:**
- Modify: `skills/decision-coach/SKILL.md` (replace the `<!-- body added in Task 2 -->` placeholder)

- [ ] **Step 1: Write the full body**

Replace the placeholder with a body containing these sections, in order. Keep it lean — this is the router; detail lives in references. Each phase must tell the coach *which reference to load when*.

1. **What this is / two modes.** One short paragraph. Then:
   - **Coach mode** (default): user brings a live decision → run all phases adaptively.
   - **Critique mode**: user brings already-formed reasoning → jump to Phase 3 + the calibration check; skip framing. Point to `references/biases-and-critique.md`.

2. **How to run it.** A 4–6 line note that the coach asks questions, one focal thing at a time, names its sources lightly, and **throttles depth to stakes** (Phase 0 can short-circuit to a one-line answer).

3. **Phase 0 — Frame & triage.** Bullet steps:
   - State the actual decision and the goal/values behind it (Preferences).
   - Triage effort: Happiness Test (matters in a year/month/week?); reversible — two-way door / freeroll / repeating option?; inside your circle of competence?; Tetlock's "is this in the Goldilocks zone?".
   - Route: low-stakes/reversible/close-call → fast path (only-option test; "when a decision is hard, it's easy"; coin flip). Consequential + hard-to-reverse → continue. *Load `references/decision-process.md` for the speed framework.*

4. **Phase 1 — Map** (deep path). Enumerate options; build the decision tree of reasonable outcomes; run the **Three Ps** (Preferences, Payoffs, Probabilities). *Reference: decision-process.md.*

5. **Phase 2 — Calibrate.** Outside view first (base rates), then inside view; Fermi-ize hard estimates; force numbers not words (bull's-eye + range + shock test); compare by expected value where useful. *Load `references/forecasting.md`.*

6. **Phase 3 — Stress-test** (also the Critique-mode entry). Premortem + backcast; apply 2–3 fitting lenses from `references/mental-models.md`; run the bias sweep from `references/biases-and-critique.md`.

7. **Phase 4 — Decide & protect.** Satisfice + only-option test; precommit (Ulysses contract); hedge the downside; write down what would change your mind; **journal the decision now** (template in decision-process.md) so it's judged on process, not outcome.

8. **A one-line reminder** that adaptivity is faithful to the sources (Duke's time-vs-accuracy trade-off; Tetlock's triage), not a shortcut.

- [ ] **Step 2: Verify all phases, both modes, and all four references are wired in**

Run:
```bash
cd skills/decision-coach && \
for s in "Coach mode" "Critique mode" "Phase 0" "Phase 1" "Phase 2" "Phase 3" "Phase 4" \
  "Three Ps" "premortem" "references/decision-process.md" "references/forecasting.md" \
  "references/mental-models.md" "references/biases-and-critique.md"; do \
  grep -qi "$s" SKILL.md && echo "OK: $s" || echo "MISSING: $s"; done
```
Expected: every line starts with `OK:`.

- [ ] **Step 3: Commit**

```bash
git add skills/decision-coach/SKILL.md
git commit -m "feat(decision-coach): write 5-phase coaching process"
```

---

### Task 3: references/decision-process.md (Duke)

**Files:**
- Create: `skills/decision-coach/references/decision-process.md`

- [ ] **Step 1: Write the file**

A standalone lookup for the Duke layer. Must include, each with a 2–4 line explanation and a usable prompt/question, sourced lightly to Duke:

- **Resulting** and the **decision-quality vs. outcome-quality matrix** (Earned Reward / Bad Luck / Dumb Luck / Just Deserts).
- **Decision multiverse / decision tree** and **counterfactuals** (the tree is identical whether the result was good or bad).
- **The Three Ps** in detail: Preferences, Payoffs (size up/downside in the currency you value), Probabilities.
- **Speed framework**: Happiness Test; freeroll; only-option test; "when a decision is hard, it's easy"; two-way door (reversibility); decision stacking; options in parallel; the **stopping rule** ("is there affordable info that would change my mind?").
- **Premortem** (assume failure — split skill vs. luck reasons) + **backcast** (assume success) + the **decision exploration table**.
- **Precommitment / Ulysses contracts**, **category decisions**, the **Dr. Evil game**.
- **Hedging**; **tilt** + tilt inventory; **decision hygiene** (quarantine your opinion & the outcome; solicit input independently/anonymously).
- **A reusable decision-journal template** (fenced block the user can copy): decision · goal/values · options · tree + probabilities · chosen option + why · what would change my mind · review date.

- [ ] **Step 2: Verify required frameworks and the journal template are present**

Run:
```bash
cd skills/decision-coach/references && \
for s in "Resulting" "Bad Luck" "Dumb Luck" "Three Ps" "Happiness Test" "freeroll" \
  "only-option" "two-way door" "stopping rule" "Premortem" "backcast" "Ulysses" \
  "Dr. Evil" "tilt" "decision hygiene" "decision-journal"; do \
  grep -qi "$s" decision-process.md && echo "OK: $s" || echo "MISSING: $s"; done && \
  grep -q '```' decision-process.md && echo "OK: journal template fenced block"
```
Expected: all `OK:`.

- [ ] **Step 3: Commit**

```bash
git add skills/decision-coach/references/decision-process.md
git commit -m "feat(decision-coach): add Duke decision-process reference"
```

---

### Task 4: references/forecasting.md (Tetlock)

**Files:**
- Create: `skills/decision-coach/references/forecasting.md`

- [ ] **Step 1: Write the file**

Standalone lookup for the calibration layer. Must include, each with explanation + usable prompt, sourced lightly to Tetlock:

- **Outside view → inside view** (base rates first, because of anchoring), with the core question "how often do things like this turn out X in situations like this?".
- **Fermi-izing** (decompose into knowable sub-questions; "what would have to be true for yes? for no?").
- **Granular probabilities**; **bull's-eye estimate + range + shock test**; force numbers, not vague verbiage.
- **Calibration vs. resolution** and the **Brier score** idea (judge against a benchmark, on a level playing field).
- **Updating in small increments** — navigate between under-reaction (ego / belief perseverance) and over-reaction (the dilution effect); rebuild from scratch when the premise collapses.
- **Fox vs. hedgehog**; **active open-mindedness** ("beliefs are hypotheses to be tested, not treasures to be guarded").
- **Scope sensitivity** (does your number move if the time frame/threshold changes?).
- **The wrong-side-of-maybe fallacy** (a single outcome can't falsify a probability).
- **The Ten Commandments** as a compact checklist (triage; decompose; balance inside/outside; balance under/over-reaction; look for clashing causal forces; distinguish degrees of doubt; balance under/over-confidence; learn from errors without hindsight bias; bring out the best in others; master the error-balancing bicycle; and the bonus — don't treat them as rigid commandments).

- [ ] **Step 2: Verify required frameworks present**

Run:
```bash
cd skills/decision-coach/references && \
for s in "outside view" "inside view" "base rate" "Fermi" "shock test" "Brier" \
  "small increment" "hedgehog" "open-mind" "scope" "wrong-side-of-maybe" "Ten Commandment"; do \
  grep -qi "$s" forecasting.md && echo "OK: $s" || echo "MISSING: $s"; done && \
  test "$(grep -c '^[0-9]' forecasting.md)" -ge 10 && echo "OK: ten commandments enumerated"
```
Expected: all `OK:`.

- [ ] **Step 3: Commit**

```bash
git add skills/decision-coach/references/forecasting.md
git commit -m "feat(decision-coach): add Tetlock forecasting reference"
```

---

### Task 5: references/mental-models.md (the 24)

**Files:**
- Create: `skills/decision-coach/references/mental-models.md`

- [ ] **Step 1: Write the file**

Four `##` sections matching the four jobs (Diagnose · Generate · Pressure-test · Interpret). Under each, every model from the locked list gets a `###` entry in this exact shape:

```markdown
### <Model name>
- **What it is:** <2–3 lines>
- **Reach for it when:** <the trigger situation>
- **The question it forces:** "<a single concrete question>"
```

The 24 entries (and their forcing-questions must be decision-usable, not academic):
- Diagnose: map ≠ territory; circle of competence; probabilistic thinking (base rates / Bayesian / fat tails); bottlenecks; multiplying by zero; regression to the mean; scale; margin of safety.
- Generate: first principles; inversion ("what would guarantee failure — am I doing any of it?"); equivalence; global vs. local maxima.
- Pressure-test: second-order thinking ("and then what?"); thought experiment; compounding; feedback loops; asymmetry / optionality; diminishing returns.
- Interpret: Occam's razor; Hanlon's razor; incentives ("what's the person rewarded for vs. what they value?"); reciprocity; correlation ≠ causation; necessity vs. sufficiency.

End with a 2-line note: pick 2–3 lenses that fit; don't run all 24.

- [ ] **Step 2: Verify all 24 models present with the three-part shape**

Run:
```bash
cd skills/decision-coach/references && \
test "$(grep -c '^### ' mental-models.md)" -eq 24 && echo "OK: 24 model headings" && \
test "$(grep -c '\*\*What it is:\*\*' mental-models.md)" -eq 24 && echo "OK: 24 'What it is'" && \
test "$(grep -c '\*\*The question it forces:\*\*' mental-models.md)" -eq 24 && echo "OK: 24 forcing-questions" && \
for s in "territory" "circle of competence" "bottleneck" "multiplying by zero" \
  "regression to the mean" "margin of safety" "first principles" "inversion" \
  "second-order" "compounding" "feedback loop" "Occam" "Hanlon" "incentive" \
  "necessity"; do \
  grep -qi "$s" mental-models.md && echo "OK: $s" || echo "MISSING: $s"; done
```
Expected: all `OK:` and the three counts equal 24.

- [ ] **Step 3: Commit**

```bash
git add skills/decision-coach/references/mental-models.md
git commit -m "feat(decision-coach): add 24-model mental-models catalogue"
```

---

### Task 6: references/biases-and-critique.md

**Files:**
- Create: `skills/decision-coach/references/biases-and-critique.md`

- [ ] **Step 1: Write the file**

Two sections.

**`## Named biases`** — each from the locked list as a `###` entry: a one-line **tell** (how it shows up) + a one-line **corrective question**. Biases: resulting; hindsight / memory creep; motivated reasoning; self-serving bias; confirmation bias; scope insensitivity; sunk cost; anchoring; overconfidence; availability / recency; status-quo bias; the wrong-side-of-maybe fallacy.

**`## Critique-mode checklist`** — a numbered, sequenced set of probes to run against reasoning the user has already formed, e.g.: (1) Are you judging this by the decision or the outcome (resulting)? (2) Put a number on each key belief — would you bet it? (3) What's the base rate / outside view? (4) Premortem: assume it failed — why? (5) What evidence would change your mind, and have you looked for it (motivated reasoning / confirmation)? (6) Whose perspective is missing? (7) Does your confidence move when the scope/time frame changes? (8) Are you inside your circle of competence? Each probe names its source lightly.

- [ ] **Step 2: Verify biases and checklist present**

Run:
```bash
cd skills/decision-coach/references && \
test "$(grep -c '^### ' biases-and-critique.md)" -ge 12 && echo "OK: >=12 bias entries" && \
grep -qi "Critique-mode checklist" biases-and-critique.md && echo "OK: checklist section" && \
for s in "resulting" "hindsight" "motivated reasoning" "self-serving" "confirmation" \
  "scope insensitivity" "sunk cost" "anchoring" "overconfidence" "status-quo" \
  "wrong-side-of-maybe"; do \
  grep -qi "$s" biases-and-critique.md && echo "OK: $s" || echo "MISSING: $s"; done
```
Expected: all `OK:`.

- [ ] **Step 3: Commit**

```bash
git add skills/decision-coach/references/biases-and-critique.md
git commit -m "feat(decision-coach): add biases and critique checklist"
```

---

### Task 7: Register in README and final cross-link check

**Files:**
- Modify: `README.md` (add to the "Standalone Skills" bulleted list)

- [ ] **Step 1: Add the skill to the README "Standalone Skills" list**

Add this bullet under "## Standalone Skills" in `README.md`, following the existing format:

```markdown
- [`decision-coach`](skills/decision-coach/) - Coach a real decision through a 5-phase process (frame & triage, map, calibrate, stress-test, decide & protect) or stress-test already-formed reasoning, grounded in Annie Duke, Philip Tetlock, and Shane Parrish's Great Mental Models. Explicitly invoked; adapts depth to the stakes.
```

- [ ] **Step 2: Verify every SKILL.md reference link resolves to a real file**

Run:
```bash
cd skills/decision-coach && \
for f in references/decision-process.md references/forecasting.md \
  references/mental-models.md references/biases-and-critique.md; do \
  grep -q "$f" SKILL.md && test -f "$f" && echo "OK: $f" || echo "BROKEN: $f"; done && \
cd ../.. && grep -q 'skills/decision-coach/' README.md && echo "OK: README registered"
```
Expected: four `OK: references/...` lines + `OK: README registered`.

- [ ] **Step 3: Commit**

```bash
git add README.md
git commit -m "docs: register decision-coach in README"
```

---

## Self-Review

**Spec coverage:**
- Two modes (Coach / Critique) → Task 2 (SKILL.md), Task 6 (critique checklist). ✓
- 5-phase process → Task 2. ✓
- Unified skill + 4 reference files → Tasks 1–6. ✓
- Explicit-only activation → Task 1 (description wording) + verified. ✓
- Decision-relevant subset, ~20–25 models → Task 5 locks 24. ✓
- Provenance / light attribution → stated as a global rule + per-file. ✓
- Adaptivity → Phase 0 routing in Task 2. ✓
- README registration → Task 7. ✓
- Non-goals (no suite, no explain-the-world models, no auto-activation, no verbatim text) → respected throughout. ✓

**Placeholder scan:** No "TBD/TODO" in tasks. Each file task carries a concrete content checklist drawn from the distilled corpus; the deferred model list is now locked to 24. ✓

**Type/name consistency:** File paths are identical across SKILL.md wiring (Task 2), each create task (3–6), and the final cross-link check (Task 7): `references/decision-process.md`, `references/forecasting.md`, `references/mental-models.md`, `references/biases-and-critique.md`. Phase names (Frame & triage / Map / Calibrate / Stress-test / Decide & protect) are consistent between spec, SKILL.md, and README. ✓

**Note on verification style:** because this skill is prose, "tests" are `grep`/count structural checks confirming each required framework, model, and section is present. They catch omissions, not quality — quality comes from faithfulness to the distilled corpus, reviewed between tasks.
