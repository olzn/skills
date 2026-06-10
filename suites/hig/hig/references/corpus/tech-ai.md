<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: machine-learning, generative-ai -->

# Technologies — AI

## machine-learning
<!-- src: machine-learning · changed: 2026-06-08 (clarity edits; heuristics stable since pre-LLM era) · platforms: all, no deltas · speed: stub -->
Judgment framework for non-generative ML features; zero numbers. Generative cases → `generative-ai`. The distinctive tool is the **role framework** — classify before reviewing: 1) critical or complementary (critical ⇒ higher accuracy bar) · 2) private or public data · 3) proactive or reactive (proactive ⇒ far less tolerance for wrong) · 4) visible or invisible · 5) dynamic or static improvement.
Non-obvious rules: feedback options state consequences plainly ("Mute politics for a week", never bare "dislike") · prefer **guided corrections** over freeform · confidence in human concepts ("Because you listen to pop music", not "97% match"), with **a floor below which you show nothing** (especially proactive) · attribution factual, never emotional ("Because you've read nonfiction", NOT "love"). Fetch for detail: machine-learning

## generative-ai
<!-- src: generative-ai · changed: 2026-06-08 (refine results, feedback during generation, model choice) — NEW page 2025-06-09 · platforms: all, no deltas · speed: full -->
Zero prior: pre-2025 models don't know this page, the Foundation Models framework, or its Acceptable Use Requirements.
- *Control:* design for variance (same input ⇒ different outputs); allow **dismiss / revert / retry**; **clearly identify when and where you use AI**.
- *Inclusion:* **ask for personal/cultural characteristics rather than inferring them** (e.g. images of people); test with diverse users.
- *Fit:* **provide a non-AI fallback** (Genmoji vs regular emoji); the app must work when AI is unavailable or declined.
- *Transparency:* **never trick people into thinking AI output is human-authored**; align disclosure with regional regulations; set expectations up front (tutorial, starter suggestions).
- *Model choice (2026-06-08):* **on-device** = private, fast, offline; **server** = more capable — weigh privacy with capability; disclose what goes to servers and whether it trains the model; opt-out always; stricter for kids. **Foundation Models framework requires Apple Intelligence on a compatible device.**
- *Datasets:* know provenance, license everything, test for bias.
- *Inputs:* **diverse predefined example prompts**; say output may contain errors; don't request facts the model can't verifiably supply; never use output where hallucination could harm; **confirmation before significant/irreversible actions**.
- *Outputs (2026-06-08):* **Edit / Undo / Retry / Adjust near generated content**; coach better requests on blocked/poor output; red-team (out-of-scope, vague, sensitive, adversarial prompts); avoid replicating copyrighted content; design for latency — **specific status messages** ("Summarizing key themes from your notes", not "Processing…"); consider multiple distinct results.
- *Improvement:* voluntary, non-interruptive **thumbs-up/down + optional detail channel**; decouple model from UX; retest per model upgrade.
**Checks.** AI labelled · Edit/Undo/Retry adjacent · confirm before destructive/purchase actions · specific loading state · example prompts · non-AI path.
