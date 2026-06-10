# HIG suite — design

**Date:** 2026-06-10 · **Status:** v2 — revised after 5-lens adversarial judge panel (wf_7c5c546d-30f)
**Goal:** keep Oscar's iOS and macOS designs and prototypes aligned with Apple's Human Interface Guidelines.

## 1. Problem

Oscar designs and prototypes for Apple platforms in three media — HTML prototypes (the `prototype` skill), Figma (MCP connected), and some SwiftUI — and wants agent assistance that (a) builds native-correct designs from the start, (b) reviews existing designs/prototypes against the HIG, and (c) answers exact-spec questions. Three forces make this hard:

1. **Stale model priors.** The HIG was rewritten twice in 12 months (Liquid Glass at WWDC 2025; foundations rework + reintroduced Design Principles at WWDC 2026, June 8). Models — and the most popular community HIG skill — confidently teach iOS-7-era doctrine: opaque pinned bars, flat design, single-PNG icons. Correcting wrong priors matters as much as supplying right answers, **and wrong priors also suppress skill invocation**: the model "already knows" the answer, so it never looks (judge finding, critical).
2. **Volume.** ~115 iOS/macOS-relevant HIG pages; full corpus ≈ 140K tokens. It must be distilled, indexed, and loaded selectively under explicit token budgets.
3. **Churn.** ~8–13 dated HIG updates/year on a known rhythm (June drop, September hardware + OS GA, December x.2). Staleness must be *detectable* — in the corpus AND in everything derived from it.

## 2. Evidence base

15-agent research run + 5-agent gap-fill + 5-judge adversarial panel (all 2026-06-10; notes in `docs/research/hig/`, verdicts in workflow wf_7c5c546d-30f). Verified key facts:

- Apple's JSON content API works: `https://developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`. The `documentation/` variant 404s **with a 15KB HTML body** — fetch tooling must check status + shape, not output presence. There is **no JSON endpoint for the site-wide changelog**; the whats-new HTML page is server-rendered but brittle (double-space dates). Apple throttles naive fetchers.
- Prior-art gap confirmed: no tool combines Liquid-Glass-current content, designer-workflow entry points, checkable rules with deterministic recall, and a working refresh pipeline. Anti-patterns measured: 33K-token always-load floor (justinwetch); silently dead refresh pipeline (tmaasen); regex-only checking (orchard); stale doctrine in the most-starred skill (axiaoge2).
- App Review enforces a thin objective subset of the HIG; most violations never block approval. Severity claims must be consequence-anchored.
- Platform divergence is concentrated (4 visual-foundation areas, 4 interaction pages, inputs, platform-exclusive components); one shared rulebook with platform deltas beats parallel platform skills.
- The connected Figma MCP `view_node` returns **thumbnails only** — no geometry, no layer tree. Any "measure via Figma MCP" plan is fiction (judge finding, major).

## 3. Decision record

Decisions D1–D8 from v1 survived the panel with amendments; D9–D14 were added by it. Each notes its strongest rejected alternative.

### D1 — Vehicle: agent skill suite (not MCP, not CLAUDE.md, not a linter)
As v1: skills trigger on task phrasing, encode process and judgment, and pair with bundled scripts for determinism and currency. **Amended claim:** skills are not free until invoked — each description costs ~250 tokens in *every* session. Description count is a budgeted resource; this is itself an argument against a fourth skill.
Rejected: MCP server (freshness only, no judgment, server to run); CLAUDE.md reference (always-paid context, no depth); standalone linter (regex-able subset only — but see D12); folding into ui-craft (web-scoped by its own declaration; different refresh cadence).

### D2 — Three skills split by workflow: `hig`, `hig-design`, `hig-review`
- **`hig`** — coordinator + spec lookup + currency. *This deviates from the house ui-craft pattern* (pure router): lookup is too thin for a fourth skill and "what does the HIG say about X" is natively coordinator-shaped. Structure consequence: routing table first, lookup protocol second, so routed-through tasks stop reading early. Carries a **top-20 numbers crib** (tap targets with default/min split, type minima, contrast ratios, key bar metrics with provenance) so the most common lookups resolve at hop zero.
- **`hig-design`** *(renamed from hig-build)* — design, prototype, adapt, implement, or fix Apple-native UI. Oscar is a designer; canonical phrasings are design/prototype/mock; "build" collides with compile/scaffold and with frontend-design's description. Includes iOS↔macOS adaptation and SwiftUI implementation/fix support.
- **`hig-review`** — audit against the HIG: severity-tiered, citation-backed findings, per-medium verification limits, principle-tagged judgment findings.
Rejected: single mega-skill (1,024-char description cap can't carry all triggers); taxonomy split (proven failure in precedent); platform split (duplicates ~75%); fourth skill for adaptation or macOS (routing ambiguity, description tax — all five judges concurred).

### D3 — Content: dated distilled snapshot + live-fetch escape hatch, with a designed failure contract
As v1, hardened by the currency judge:
- `hig-fetch.sh <slug>`: checks HTTP status AND jq-validates `.primaryContentSections` before rendering; non-zero exit with a one-line reason; slug 404 triggers a root-TOC re-fetch to detect renames; real User-Agent + backoff.
- `hig-whats-new.sh`: primary source = whats-new HTML scrape with a **hard parse assertion** (zero dated-changelog tables found = loud FAIL, never "no changes"); fallback = `customMetadata` alert-date probes of the ~10 known hot slugs (cheap JSON); cross-references changed slugs against `src:` annotations (D11) to name **derived files needing review**, not just changed pages.
- **Fail-soft network rule:** if fetch is unavailable (Codex sandbox, denied permission), proceed on the snapshot and say so: "per snapshot dated 2026-06-10; live verification unavailable here." Never fall through silently; never answer bare from a known-expired snapshot.
- `versions.md` carries **machine-comparable expiry dates** from Apple's cadence (next expected: 2026-09, 2026-12, ~2027-06). Past expiry → run whats-new or attach an explicit staleness caveat to volatile answers. A "stale snapshot" scenario is part of the pre-deploy tests (D13).
- iOS/macOS 27 content is encoded as **delimited delta blocks** tagged "promote on 27 GA" so September's baseline flip is mechanical promote-and-restamp, not a rewrite. 26.x is the encoded baseline (the 2025 beta cycle's flip-flops prove betas shouldn't be).

### D4 — Corpus: ~17 area files, two-speed, with enforced lookup mechanics
**Two-speed rule (exclusion principle):** full distillation only where the model's priors are wrong or absent — the 46 pages changed since 2025, all numeric specs, all stale-prior corrections. Stable judgment pages (modality, drag-and-drop, undo, feedback — untouched since 2022–24) get 5–15-line rules-only stubs + fetch pointer. The corpus does not re-teach what the model already knows; judgment lives in the decision trees and checklists.
**Lookup mechanics (mandatory, not aspirational):** slug-exact section headers (`## tab-bars`); index entries give file + anchor; the hig SKILL.md spells out the two-step with a worked example (`grep -n "^## tab-bars" … → Read offset/limit`); per-page sections capped ~30–80 lines so a partial read costs 0.4–1K tokens.
**Corpus files (~17):** foundations-identity (app icons/branding/SF Symbols/icons/images) · foundations-appearance (color/dark-mode/materials/motion) · foundations-layout-typography · foundations-people · patterns-lifecycle · patterns-interaction · components-menus-actions · components-nav-search · components-layout-content · components-presentation-status · components-selection-input · components-system-experiences (widgets/Live Activities/controls/notifications/status bars/app shortcuts/snippets/always-on) · inputs · platforms (designing-for-iOS/macOS/iPadOS-brief, Catalyst) · tech-ai (ML/generative-AI/Siri AI) · tech-commerce (Apple Pay/Wallet/IAP/SIWA/Tap to Pay) · tech-services (iCloud/App Clips/games-stub).
Rejected: per-page files (~115 — triple maintenance surface, loses bucket-wide shared corrections; degrade better under lazy reads but lose under the mandated mechanics); uniform-depth distillation (ignores measured value concentration).

### D5 — Severity model: three consequence-anchored tiers
1. **Rejection risk** (objectively enforced: privacy screens, SIWA/Apple Pay brand specs, account deletion, ratings caps, minimum-functionality, marketing-notification rules) · 2. **Feels broken** · 3. **Feels non-native**.
**Rules:** never claim Apple will reject for tiers 2–3. The three tiers are stated **inline in hig-review's SKILL.md** (~120 words — process, not reference; avoids making doctrine.md an always-load). Tier-2/3 judgment findings carry a **design-principle tag** (the 8 Apple-canonical principles) so critique reads as Apple's vocabulary, not taste; "Maintain your craft" legitimises flagging pre-Liquid-Glass conventions as craft violations.

### D6 — Medium adapters: HTML, Figma, SwiftUI — honest about verification limits
- **html.md** — split into a labelled **pre-generation constraint sheet** (safe-area env vars, viewport-fit, CSS token sheet, component geometry) and **post-generation checklist**. Required output: an **emulate-or-waive declaration** per prototype (swipe-back, rubber-banding, sheet detents, scroll-edge effects, Dynamic Type, dark mode, glass legibility — each: emulated / explicitly waived) so the prototype states what it does and doesn't claim. Carries the cross-suite precedence rule (D9).
- **figma.md** — rewritten around thumbnail-only reality: `view_node` output is reviewed under the same screenshot protocol as agent-browser captures; **all numeric checks live on the cannot-verify list for this medium**; measurement fallback = ask for inspector values or a declared-scale export; findings tagged "estimated from render — confirm in Figma inspector". Notes the upgrade path if a Dev-Mode-grade MCP is ever connected. Points to Apple's official iOS 26 Figma kit for component comparison.
- **swiftui.md** — glassEffect/GlassEffectContainer pitfalls, contentShape hit areas, simulator-vs-hardware caveat, recommend `performAccessibilityAudit` XCUITests rather than re-implementing a11y checks.

### D7 — Integrity rules (unchanged, now with provenance machinery)
Exact values, never approximate; never flatten platforms; every rule traces to a corpus section (URL + change date) or live fetch; unpublished numbers carry provenance (kit-derived/community-measured) + confidence; press-sourced claims version-gated, never doctrine; uncertainty explicit. **Single-source numbers:** each value lives once (tables/ or its corpus section); checklists may inline the small hot subset, marked with `src:` so validate.sh can mechanically diff inlined copies against their source — self-sufficient checklists *and* one source of truth.

### D8 — Naming: `hig` / `hig-design` / `hig-review`, suite dir `suites/hig/`
"HIG" is what the user types; `apple-hig` adds nothing description keywords don't already (the description must spell out "Apple Human Interface Guidelines" regardless) and costs invocation ergonomics. Distinct prefix (not `-craft`) signals external-authority alignment and the ui-craft boundary. hig-review claims **only Apple-marked phrasings** ("is this HIG compliant", "review my iOS app", "does this feel native", "would Apple reject this") — unmarked "audit my prototype" is deliberately left to ui-craft/interface-craft (over-trigger on web work would be the mirror-image failure).

### D9 — Routing contract *(new — routing judge)*
- **Anti-prior clause in all three descriptions:** "model priors on Apple's current design system are stale (Liquid Glass era) — never answer Apple design-spec questions from memory."
- **Debug/fix entry:** volatile API symbols (`glassEffect`, `GlassEffectContainer`, `scrollEdgeEffect`, `tabViewBottomAccessory`, "Liquid Glass") seeded in hig and hig-design descriptions — high-precision, cheap triggers for tasks phrased with no HIG/Apple framing.
- **Cross-skill edits (3 lines, on the surfaces that actually route):**
  1. `prototype` SKILL.md (~/.claude/skills): "If the feature targets iOS/iPadOS/macOS native idiom, load hig-design's constraint sheet before generating — this is constraint-loading, not deferred research."
  2. ui-craft coordinator: co-lead with precedence, not exclusion — "HTML prototypes imitating native Apple UI: ui-craft owns web mechanics, the hig suite owns native idiom and metric values; on conflict, HIG wins for native-targeting prototypes."
  3. surface-details (highest-collision domain skill): one reciprocal line for native iOS/macOS values.
- **Prototype composition contract:** load guidance once, generate all N options under it, **one combined post-gen checklist pass** across options (not N passes); variation happens within the idiom (grouping, density, copy, disclosure), never across interaction models.

### D10 — Token budgets, enforced *(new — token judge)*
Per-file caps (validate.sh, tokens ≈ bytes/4): corpus area ≤3.5K · composite checklist ≤2.5K · adapter ≤2K · index ≤1.5K (one line per slug, no URLs, no synonym lists) · doctrine ≤2K. Per-flow targets: lookup ≤4K loaded references · review ≤12–15K · design ≤10–12K. Composite screen checklists (review-screen-ios/-macos) are self-sufficient — they inline the hot numeric subset (D7 mechanism) so a standard screen audit loads SKILL.md + one checklist + one adapter + targeted corpus sections only. decision-trees split per decision family (containers-presentation · controls-selection) so one question never pays for six trees.

### D11 — Maintenance is a shipped artifact, not a README aspiration *(new — currency judge)*
- `scripts/refresh-workflow.md`: the agent-driven refresh procedure (whats-new → fetch changed slugs → re-distill affected sections under D7 → consult `src:` map for derived files → restamp → validate → smoke tests). Converts an estimated 10–14h manual June refresh into a supervised ~2–3h session. Includes the named **September 27-GA flip procedure** (promote delta blocks, demote 26.x, restamp versions.md).
- **`src:` slug annotations on every claim in derived artifacts** (corrections, trees, checklists, tables, adapters) — machine-greppable, lets whats-new name stale derived files; corrections.md entries additionally carry volatility markers (sidebar icon treatment flipped twice in 24 months — some corrections expire).
- validate.sh includes a live smoke test of one known slug so endpoint/markup drift surfaces at refresh time.
- Optional: a scheduled reminder (user's choice — `/schedule`) for the June/Sept/Dec windows.

### D12 — Scan scripts: ship one thin scanner, candidates-not-findings *(new — judges split 2–1, tie-break)*
`scripts/hig-scan.sh` (SwiftUI + HTML patterns, grep/awk only): emits rule-ID-tagged candidate lines explicitly marked "candidates, not findings", with positive compliance markers to suppress false positives. Severity and judgment stay entirely in the model. Tie-break rationale: the content judge's objection (re-importing the rejected linter) is answered by framing — D1 rejected *regex-only* checking; the proven lightscape pattern (~70% recall layer under model judgment) is precisely what the research said to adopt, and a script's compact deterministic table replaces 8–12 noisy ad-hoc Grep round-trips (2–5K tokens) per code audit.

### D13 — Pre-deploy tests (writing-skills TDD, reference-skill variant)
Baseline (RED) → with-skill (GREEN) → loophole-closing (REFACTOR), with these mandatory scenarios: keyword-free spec questions ("how tall is the tab bar on iPhone?" — a zero-skill confident answer = FAIL); co-fire ("prototype an iOS settings screen" → prototype + hig-design); negative ("audit my prototype" on a web app must NOT fire hig-review); debug entry ("fix this glassEffect bug"); stale-snapshot behaviour (expired versions.md → caveat attached); lookup cost (one number resolves within budget).

### D14 — Install once, reference by sibling path *(new — token judge)*
All shared references live under `hig/references/` (the coordinator's dir) — **one copy in the repo, one copy installed**. hig-design and hig-review contain only SKILL.md + learnings.md and read `../hig/references/…` (install.sh co-locates the three dirs in one flat skills root for both Codex and Claude Code; validate.sh asserts the sibling paths resolve). Single versions.md = single snapshot date. Rejected: ui-craft-style per-skill copies (3× grep noise from a skills-root `grep -r`, triplicated versions.md undermining D3) — a justified deviation from the house installer pattern, documented in the suite README.

## 4. Layout

```text
suites/hig/
├── hig/                          # SKILL.md (router → lookup protocol → currency protocol, top-20 crib), learnings.md
│   └── references/               # single shared set (D14)
│       ├── doctrine.md           # Liquid Glass two-layer model · platform character · 8 principles + violation mapping
│       ├── corrections.md        # stale-priors table with volatility markers · src: annotations
│       ├── trees-containers.md   # container/presentation choice · bars doctrine · search placement (version-gated)
│       ├── trees-controls.md     # control choice · platform availability matrix · menu types
│       ├── adaptation.md         # sequenced port process: inventory → Catalyst translation → macOS-completeness → review handoff
│       ├── checklists/           # review-screen-ios · review-screen-macos · review-flow (first-run/drag/undo/loading state machines) · review-copy · review-a11y · review-liquid-glass · review-compliance (tier-1 only) · review-ai (genAI rubric) · review-system-surfaces
│       ├── tables/               # dynamic-type · accessibility-sizes · keyboard-shortcuts-macos · cursors-macos · sf-symbols-actions · system-surface-dims · brand-buttons · notifications-matrix · audio-haptics · metrics (provenance-marked)
│       ├── adapters/             # html.md · figma.md · swiftui.md
│       ├── corpus/               # ~17 two-speed area files, slug-anchored sections
│       ├── index.md              # slug → file#anchor (+ checklist pointer), ≤1.5K tokens
│       └── versions.md           # snapshot date · baseline 26.x · expiry dates · 27 delta-block registry
├── hig-design/                   # SKILL.md + learnings.md
├── hig-review/                   # SKILL.md + learnings.md
├── scripts/                      # hig-fetch.sh · hig-whats-new.sh · hig-scan.sh · validate.sh · refresh-workflow.md
├── install.sh                    # house pattern + sibling-path note; preserves learnings.md
└── README.md                     # install · boundaries · maintenance ritual + September flip
```

**Cross-skill edits shipped alongside (D9):** one line each in `prototype` (installed copy), `ui-craft/SKILL.md`, `surface-details/SKILL.md`.

## 5. Risks (updated)

| Risk | Mitigation |
|---|---|
| Lookup bypassed by confident stale priors | anti-prior clauses (D9) + keyword-free trigger tests (D13) + top-20 crib making the skill the cheap path |
| Snapshot stale, ritual skipped | expiry dates drive behaviour (caveats attach automatically) + refresh-workflow.md + smoke test + optional schedule |
| Derived artifacts rot invisibly | `src:` annotations + whats-new cross-reference (D11) |
| Fetch tooling breaks silently | status+shape validation, loud parse assertions, fail-soft rule (D3) |
| September 27 flip is structural | delta blocks + named flip procedure (D3, D11) |
| Token bloat | enforced per-file/per-flow budgets (D10) |
| Routing collisions (prototype, ui-craft, interface-craft) | co-lead precedence + 3 cross-skill lines + Apple-marked review phrasings + negative tests |
| Figma over-promising | thumbnail-only adapter, numeric checks on cannot-verify list (D6) |

## 6. As-built deltas (recorded 2026-06-10, post-build)

- Corpus is 18 files, not 17: `tech` split into `tech-ai.md` + `tech-commerce.md` to hold the per-file budget without cutting App-Review-grade commerce content.
- Runtime scripts live at `hig/scripts/` (inside the coordinator skill dir) so relative paths are identical in repo and installed layouts; `scripts/validate.sh` stays repo-only.
- The build workflow was interrupted by a transient account spend limit: 8 of 16 drafters died **after** writing their files but before reporting. Recovered by hand: verified all outputs for truncation (none), wrote `adapters/figma.md` + `adapters/swiftui.md` + `index.md` directly, tested all three scripts live (fetch 200/404 paths, whats-new parse + `src:` cross-reference, scanner on seeded fixtures in `hig/scripts/test-fixtures/`).
- The D9 edit to the installed `prototype` skill was **denied by the harness** (out of declared task scope) — the one-line addition is documented in the delivery report for Oscar to apply. The ui-craft and surface-details boundary lines landed in the repo masters.
- validate.sh passes 0/0; the suite was installed to `~/.codex/skills/` (hig, hig-design, hig-review).

## 7. Resolved questions

1. **Fourth skill for adaptation/macOS?** No — all five judges. Adaptation = sequenced process file inside hig-design; port phrasings in its description.
2. **Granularity?** Area files win *only with* mandated lookup mechanics + two-speed depth (D4); under v1's unspecified mechanics, per-page would have been cheaper.
3. **Grep scripts?** One thin candidates-not-findings scanner (D12).
4. **Name?** `hig` kept; `hig-build` → `hig-design`.
5. **Metrics source?** Kit-derived baked values with per-row provenance + confidence; Figma-MCP renders verify, never source; runtime-only fails HTML/SwiftUI/lookup media.
