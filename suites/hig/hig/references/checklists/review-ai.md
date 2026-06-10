<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: generative-ai, machine-learning -->

# Review — AI features (generative rubric + ML triage)

Both source pages were updated 2026-06-08 (WWDC 2026) — hot; verify fine detail live before asserting. Guidance is platform-uniform ("no additional considerations" on every platform): no iOS/macOS forking. Findings here are tier 2 (feels broken) or tier 3 (feels non-native) — never claim rejection risk. Tag judgment findings with a design principle, usually Agency, Responsibility, or Purpose.

The `generative-ai` page did not exist before June 2025 and `machine-learning` defers generative cases to it — never conflate the two, and never answer from pre-2025 priors (they predate Apple Intelligence and the Foundation Models framework entirely).

## role-triage

Classify the feature on five axes before reviewing — the axes set the quality bar, they are not findings themselves:

1. **Critical or complementary** — can the app work without it? Critical ⇒ much higher accuracy/reliability bar, and graceful degradation stops being optional.
2. **Private or public data** — more sensitive data ⇒ worse consequences for errors; privacy work is mandatory either way.
3. **Proactive or reactive** — unrequested results get far less tolerance for being wrong. Proactive ⇒ raise the quality bar and require a confidence floor below which nothing is shown.
4. **Visible or invisible** — invisible features can't easily communicate reliability or collect feedback; ask how reliability is conveyed at all.
5. **Dynamic or static** — improves with use ⇒ the UI needs feedback/calibration loops; static ⇒ those loops are clutter.

<!-- src: machine-learning -->

Then route: the feature **creates or transforms content** → run generative-rubric **and** ml-patterns; it predicts, ranks, or classifies → ml-patterns only. <!-- src: machine-learning, generative-ai -->

## generative-rubric

T2 = feels broken · T3 = feels non-native.

- **T2 — Disclosure.** AI use is clearly identified when and where it occurs; flag generated content that could pass as human-authored with no label. Align disclosure with regional regulation. <!-- src: generative-ai -->
- **T2 — Revision controls.** Edit / Undo / Retry / Adjust controls sit adjacent to the generated content; corrections are acknowledged visibly. Flag output with no revision path. <!-- src: generative-ai -->
- **T2 — Confirmation before consequence.** A confirm step precedes significant or irreversible actions — no auto-deleting photos, no autonomous purchases. Flag any generative flow that commits without one. <!-- src: generative-ai -->
- **T3 — Specific loading copy.** Status messages name the work ("Summarizing key themes from your notes"), never "Processing…". Generative ≠ real-time: a designed loading experience or background generation must exist. <!-- src: generative-ai -->
- **T3 — Example prompts.** Open-ended inputs offer diverse predefined example prompts and set capability/limitation expectations up front (brief tutorial or curated starter suggestions). <!-- src: generative-ai -->
- **T2 — Non-AI fallback.** A non-AI path exists where possible (Genmoji alongside regular emoji; reading notifications alongside summaries), and the app still works when AI is unavailable or declined. The Foundation Models framework needs a compatible device with Apple Intelligence turned on — capability must be gated, never assumed. <!-- src: generative-ai -->
- **T3 — Feedback affordance.** Present but unobtrusive: thumbs-up/down plus an optional detailed channel; never interrupts the flow. <!-- src: generative-ai -->
- **T2 — On-device vs server is a deliberate, disclosed choice.** On-device = private, fast, offline; server = more capable. Process locally where possible; disclose what goes to servers and whether it trains the model; permission before using personal info; opt-out always available; stricter rules in kids' apps. <!-- src: generative-ai -->
- **T2 — Hallucination handling.** Requests are scoped so the model isn't asked for facts it can't verifiably supply; generated content is never used where a hallucination could cause harm; copy communicates that output may contain errors. <!-- src: generative-ai -->
- **T3 — Failure coaching.** Blocked or poor output coaches a better request (Image Playground's "Unable to use that description") and suggests examples — never a bare failure state. Red-team with out-of-scope, vague, sensitive, and adversarial prompts. <!-- src: generative-ai -->
- **T2 — Ask, don't infer.** Personal or cultural characteristics are asked for, not inferred (e.g. when generating images of people) — models favour common data, so stereotyping is a known failure mode. <!-- src: generative-ai -->
- **T3 — Multiple results.** Offer several meaningfully different results where choice helps. <!-- src: generative-ai -->

## ml-patterns

Apply to any ML-powered feature, generative or not.

- **Feedback** — always voluntary; options state consequences in plain language ("Suggest less pop music", "Mute politics for a week" — never a bare "dislike"); acted on immediately and persistently; icons may accompany text, never replace it. <!-- src: machine-learning -->
- **Implicit signals** — don't let personalisation kill exploration (filter bubble); withhold private or sensitive suggestions on shared devices; prioritise recent feedback; update predictions at the cadence of the person's mental model (typing = instant; song recommendations = not continuous). <!-- src: machine-learning -->
- **Calibration** — only when the feature can't work without it (Face ID); once, early, quick; explicit goal with visible progress; immediate help when stalled, never blame; cancellable without judgment; calibration data editable and deletable later. <!-- src: machine-learning -->
- **Mistakes and corrections** — corrective tools match consequence severity (a bad keyboard suggestion ≠ a missed flight); corrections use the same familiar controls the automation used (Photos auto-crop exposes the crop tool); prefer guided corrections (pick from alternatives) over freeform; corrections never excuse low-quality output. <!-- src: machine-learning -->
- **Multiple options** — diverse, one screen, no scrolling; most likely first, optionally preselected; differences described so options are distinguishable. <!-- src: machine-learning -->
- **Confidence** — never raw percentages unless people expect statistics (weather, sports, polls); translate to reasons ("Because you listen to pop music" beats "97% match") or semantic buckets ("high chance"); change presentation by threshold (ask for confirmation at low confidence); set a floor below which nothing shows — mandatory for proactive features. <!-- src: machine-learning -->
- **Attribution** — factual and objective, never emotional ("Because you've read nonfiction", not "Because you love nonfiction"); neither creepy-specific nor uselessly general; no jargon. <!-- src: machine-learning -->
- **Limitations** — set expectations up front for rare-but-serious limits; demonstrate how to get good results (placeholder examples à la Photos search, live coaching à la Memoji lighting hints); explain poor results; suggest alternatives instead of empty results; consider announcing when limitations are fixed. <!-- src: machine-learning -->

## sixty-second-screen

The minimum questions for any AI surface when time is short:

1. Which of the five roles is it — and if proactive + visible, where is the suppression floor?
2. Is AI use labelled, with Edit/Undo/Retry adjacent?
3. Is there a confirm step before anything irreversible?
4. Does the empty/failed state coach, and does a non-AI path exist?
5. Is feedback voluntary, consequence-labelled, and unobtrusive?

<!-- src: machine-learning, generative-ai -->
