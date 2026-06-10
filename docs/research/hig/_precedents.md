# Prior art: HIG knowledge for AI agents & HIG compliance automation

Research date: 2026-06-10 (during WWDC 2026 week). All repo stats verified via GitHub API today.

Scope: what already exists, how it works, what to copy, what to avoid — as input to our iOS/macOS HIG skill suite for a designer prototyping in HTML/Figma/SwiftUI.

---

## 1. Agent skills for Apple HIG (GitHub landscape)

The space exploded after Claude Skills launched (late 2025). ~15 public repos found; five matter.

### 1.1 justinwetch/HIGAgentSkills — best-in-class snapshot + routing ("apple-hig")

- 15 stars, pushed **2026-06-10** (today). Corpus captured **2026-06-09** — actively re-snapshotted, claims "Updated for OS 27 releases".
- **Architecture:** SKILL.md (3.6 KB) is a pure loading protocol; content lives in 156 `distilled/*.md` files (one per HIG page, 0.7–15 KB each, ~140K tokens total) plus an auto-generated `routing-index.md` (17.7 KB, 1,057 trigger keywords).
- **Four-tier loading protocol:**
  - Tier 1 (16 foundation files: accessibility, color, dark-mode, layout, materials, typography, sf-symbols, writing, etc.) — loaded on EVERY invocation.
  - Tier 2: platform files (`designing-for-ios`, `designing-for-macos`, ...) via platform detection.
  - Tier 3 (103 files): keyword trigger-map (e.g. "share sheet, uiactivityviewcontroller → activity-views"). Explicit word-boundary matching rule ("`AR` doesn't match 'tab bar'").
  - Tier 4 (30 niche files): on-demand only.
  - Plus one-hop expansion through each file's `related:` frontmatter.
- **Frontmatter schema per file:** `topic, tier, platforms, category, triggers, related` — the routing index is generated from frontmatter by script (`scripts/generate_routing_index.py`), so index never drifts from content.
- **Distillation method:** each HIG page compressed ~75% by word count, preserving exact measurements, API names, platform distinctions, and do/don't directives; each pass followed by an eval step ("file accepted only when the distilled version could answer the same design questions as the source"). Verification artifacts stored under `sources/apple-hig-2026-06-09/verification/`.
- **Quality check (materials.md):** fully Liquid Glass-current. Correct two-material model (Liquid Glass = controls/navigation layer; standard materials = content layer), `Glass.regular` vs `Glass.clear`, the 35%-opacity dimming-layer rule for clear glass over bright content, "don't use Liquid Glass in the content layer". This is the real, current HIG.
- **Distilled buttons.md** preserves: 44×44 pt min hit region (60×60 visionOS), role table (Normal/Primary/Cancel/Destructive), macOS push/square/help/image button subtypes, trailing-ellipsis rule, visionOS size grid (28/32/44/52/64 pt). Dense and citable.
- **Hard rules in SKILL.md worth copying verbatim in spirit:** "Cite exact values... Never approximate"; "Distinguish platforms... Never flatten to 'generally'"; "No invention. Every rule, measurement, and API name must trace to a loaded distilled file."
- **Weaknesses:** token floor ~33,600 tokens per invocation (tier-1 + routing index); typical query 34K–55K tokens. Enormous for a quick "is this button right?" question. Covers all 6 platforms (we only need 2). Single monolithic skill — no task-shaped entry points (generate vs audit vs review). Repo includes a separate runtime-zip packaging script because the repo carries raw captures not meant for install.

### 1.2 axiaoge2/Apple-Hig-Designer — most popular, generation-focused, and STALE

- **121 stars** (by far the most), 7 forks, MIT, created 2025-12-12, pushed 2026-02-17.
- **Architecture:** one big SKILL.md (12.8 KB) + REFERENCE.md (36 KB) + `resources/` with copy-paste artifacts: `design-tokens.css` (21 KB), `components.jsx` (22 KB), `ui-patterns.md` (31 KB). Targets **HTML/CSS/React output** — i.e., exactly our designer's HTML-prototyping use case.
- **What it gets right:** ships exact values inline — iOS type scale (caption2 11 → largeTitle 34, body 17), full system color hex tables light+dark (e.g. systemBlue #007AFF/#0A84FF), label opacity stacks (rgba(60,60,67,.6) etc.), 8pt spacing grid, 44pt targets, concentric-radius rule (inner + padding = outer), tab bar 49px + safe area, sheet detents, alert width 270px, `prefers-color-scheme` and `prefers-reduced-motion` blocks. A CSS-token sheet like this is the single highest-leverage artifact for HTML prototyping.
- **What it gets wrong (stale + invented):**
  - Teaches "Clarity, Deference, Depth" as "The Four Pillars" — that's the iOS 7–era principle set; the current HIG's themes are **Hierarchy, Harmony, Consistency** (post-Liquid Glass rewrite).
  - "Glass effects optional — only when user explicitly requests; default solid backgrounds" — directly contradicts iOS 26+/macOS 26+ where Liquid Glass is the system-default control/navigation layer.
  - Includes non-Apple patterns presented as HIG ("hover glow" box-shadow, spring cubic-bezier overshoot as default), old teal #5AC8FA, SF Pro Display/Text threshold framing (SF Pro is variable with optical sizing now).
  - No per-claim sourcing; no capture date; no refresh mechanism. **This is the cautionary tale: the most-starred HIG skill confidently teaches a superseded design language.**

### 1.3 lightscape-jm/swiftui-hig-audit — the audit-workflow pattern

- 2 stars, pushed 2026-03-06. SKILL.md (16 KB) + 22 numbered rule files (`rules/01-accessibility.md` … `22-macos-specifics.md`, 15–42 KB each, "190+ rules") + two slash commands (`/hig-audit`, `/hig-fix`) + `hig-coverage.md` map.
- **Pipeline worth copying wholesale:**
  1. Discover & classify .swift files (view / viewmodel / theme / model / app), with explicit exclusions (Tests/, .build/, Pods/...).
  2. **Resolve design tokens first** — read the theme directory, build a lookup of spacing/color/font definitions, because "fixing a theme file can eliminate dozens of downstream violations". (Directly transferable to auditing a CSS tokens file or Figma variables before auditing screens.)
  3. **Layer 1 grep scan** — a table of regex → rule-ID mappings (`.onTapGesture` → ACC-04, `Font.system(size:` without `relativeTo:` → TYP-01, `NavigationView` → NAV-01, `Color(red:` → CLR-04, `.repeatForever` → MOT-03...), plus **positive compliance markers** (`.accessibilityLabel(`, `@ScaledMetric`, `Image(decorative:`) to suppress false positives. Claims ~70% of issues caught here.
  4. Layer 2: read flagged files in batches of 3–5, apply full rules.
  5. Report to `docs/hig-reports/YYYY-MM-DD-[scope].md` with severity table (critical/warning/info), rule IDs, file:line, fix snippet, and effort tag (quick-fix / moderate / architectural).
- Notably: SKILL.md says it is self-sufficient for auditing — `rules/` files are consulted only for unusual patterns. So the 22 big files are mostly dead weight per-invocation; good instinct (deep files as fallback), but the SKILL.md itself is 16 KB.
- Accepts CLI-style args (scope, `--category`, `--severity`, `--platform`). WCAG 2.1 AA mapped alongside HIG.

### 1.4 zanwei/human-interface-guidelines-skill — hybrid: local index + live fetch

- 1 star, pushed 2026-02-21. SKILL.md (3 KB) + `references/hig_catalog.md` (36.6 KB: every page title + abstract) + `references/hig_section_map.md` (16.9 KB hierarchy) + `scripts/search_hig.py` (keyword search over local catalog) + `scripts/fetch_hig_page.py` (14 KB — **fetches Apple's DocC JSON live and renders it to Markdown**, same JSON endpoint we verified).
- Pattern: keep only the *index* local; fetch authoritative page content on demand. Output format scaffold (User goal → Recommended pattern → Platform notes → Accessibility → Edge cases → HIG URLs) and review-finding format (Findings / Severity / Suggested fix / HIG citations) are good shapes.
- Weakness: every content question costs a network fetch + JSON-rendering of un-distilled prose; no numeric specs available offline; fetch script breaks if Apple changes the API. But as an **escape hatch alongside a distilled snapshot**, this is the right freshness valve.

### 1.5 CaioRodolfo/apple-hig-skills — the only multi-skill *suite* precedent

- 0 stars, 2026-02-05. Six skills (`apple-hig-foundations`, `-components`, `-inputs`, `-patterns`, + 2 more), each SKILL.md (~4–5.5 KB) + `references/*.md` grouped by HIG category cluster (e.g. components → content.md, menus-and-actions.md, navigation-and-search.md; 5–11 KB each). Also ships `.skill` zip bundles.
- Lesson: the suite split **mirrors Apple's documentation taxonomy, not user tasks**. A designer asking "audit this prototype" needs slices of foundations + components + patterns simultaneously, so the taxonomy split forces multi-skill loading or misses content. Our suite should split by *workflow* (build / audit / platform-adapt), not by HIG chapter.

### 1.6 Others, briefly

- **Ksanbal/apple-hig-codex-skill** (1★, 2026-04): "portable across Codex, Claude Code, OpenCode" — cross-runtime portability is a stated user need; keep our skills free of Claude-only assumptions where cheap.
- **eudresfs/mobile-hig-audit** (0★): frames audits around "minimizing App Store rejection" — a motivating frame worth borrowing for severity labels (e.g. "rejection-risk" tier).
- **ebuntario/apple-hig**, **drugnotes/apple-hig-ios-skill**, **jacoblewisau/design-hig-principles**, **yhongm/apple-higDesign-skill** (notably its description cites the current "Hierarchy/Harmony/Consistency" principles), **JuanMarchetto/ios-glass-ui-skill** (glass-material-only niche skill): all single-file or small reference packs, nothing architecturally new.
- **gabrielleti/apple-dev-docs-and-principles** (0★): Claude skill + marketplace plugin combining HIG + App Store Review guidelines + *live* developer.apple.com docs.
- **vabole/apple-skills** (Apple dev skills for Claude Code/Codex, "iOS 26+, Liquid Glass"): not HIG-specific but has the best **refresh pipeline** seen: `scripts/apple-docs/` TypeScript renderers (`render-hig.ts`, `render-reference.ts`, `fetch.ts`) pull Apple DocC JSON and regenerate skill markdown, driven by a GitHub Actions workflow (`apple-docs-update.yml`) + version-bump workflow. Cautionary counter-note: it also ships absurd single files (`appintents-overview.md` = **814 KB**; several 50–300 KB "index" files) — generated content with no distillation step blows any context budget.
- **neonwatty blog (Claude Code Skills Tutorial, iOS HIG workflow testing):** tested a two-skill pair — `ios-workflow-generator` (interactive, AskUserQuestion-driven scenario refinement, user approval gates) + `ios-workflow-executor` (systematic checklist verification). On a real app it caught exactly the violations our designer will produce in HTML prototypes: **hamburger menu instead of tab bar, HTML `<select>` instead of iOS picker, visible row action buttons instead of swipe-to-reveal, centered modal instead of bottom sheet, Material-style FAB**. Key conclusion: "give it a checklist" — explicit anti-pattern tables beat open-ended review prompts; separate interactive generation from systematic execution.

---

## 2. MCP servers exposing Apple docs / HIG

### 2.1 kimsungwhee/apple-docs-mcp — the category leader

- **1,303 stars**, npm `@kimsungwhee/apple-docs-mcp`, pushed 2026-03-17. Live queries against **Apple's official JSON API** (same DocC endpoints), plus WWDC video/transcript search (2014–2025), framework indexes, beta/deprecation tracking.
- Implementation details that matter: "Smart UserAgent Pool — intelligent UserAgent rotation with automatic failure recovery" → Apple evidently throttles/blocks naive scripted fetching at volume; our low-volume curl use is fine, but a refresh pipeline should set a real UA and back off.
- Strengths: always-current, huge scope. Weaknesses for our use: API-developer-oriented (symbols, frameworks), not design-rule-oriented; requires server setup; answers are raw doc text, not checkable rules; an MCP dependency makes a skill non-portable.

### 2.2 tmaasen/apple-dev-mcp (a.k.a. apple-hig-mcp) — the staleness cautionary tale

- 18 stars; npm `apple-dev-mcp` last published **2025-07-21 (v2.1.9)**; repo last pushed 2025-08-01. **Pre-generated static snapshot** of "113+ HIG sections", advertised as "auto-updated every 4 months via GitHub Actions".
- The update automation evidently died: the snapshot predates iOS 26 GA (Sept 2025) and the Liquid Glass HIG rewrite, so everything it serves about materials/navigation/toolbars is now wrong-by-default. Listed on lobehub, mcpservers.org, mcpmarket — directories keep recommending it regardless. **Lesson: a snapshot without a *working* refresh pipeline is worse than live fetch, because it keeps answering confidently after going stale; popularity listings won't warn users.**

### 2.3 sophiacave/orchard-hig — deterministic HIG rules as MCP

- 0 stars, pushed 2026-06-07. Python MCP server, 4 tools (`hig_check_file`, `hig_check_code`, `hig_suggest`, `hig_rules`), **22 regex-based rules over SwiftUI source**, 52 tests, Smithery-packaged.
- Rule set is a good minimal checklist: A1 missing `.accessibilityLabel()` on interactive elements; A2 hard-coded `.font(.system(size:))`; A3 fixed frames without `@ScaledMetric`; A4 animation without Reduce Motion check; T1 frame < 44pt on interactive; C1 hard-coded colors; C2 color-only state; D1 UIColor in SwiftUI; D2 hard-coded white/black backgrounds; S1 deprecated `NavigationView`; L1 safe-area ignoring; L2 non-standard spacing; **G1 opaque backgrounds where glass materials apply (iOS 26+); G2 custom toolbar backgrounds overriding Liquid Glass** — the only tool found encoding Liquid Glass as lint rules.
- Weaknesses: line-based regex → false positives/negatives (it even hedges with "may need"); "within 5 lines" context windows; no SwiftSyntax parsing. Confirms: deterministic layer is valuable for recall + speed, but needs a model-judgment layer on top (exactly lightscape's two-layer design).

### 2.4 Others

- **bbssppllvv/apple-docs-mcp-server** (8★, Aug 2025): local semantic-search index over 16K+ Apple docs + WWDC transcripts — embedding-index approach; heavyweight to maintain, stale since capture.
- **jabbertones-cloud/wwdc-mcp-server** (2026-05): local-first, hybrid SQLite FTS5 + Ollama semantic search over WWDC sessions, tutorials, HIG, Swift Evolution; 15 tools.
- **blas0/apple-rag-docs-free**: self-hostable RAG over Apple docs + WWDC transcripts (reverse-engineered from a paid one — there's a small commercial market here).
- **joshspicer/apple-developer-docs-mcp** (7★), **justindal/Apple-Docs-MCP**, **attentiondotnet/apple-docs-mcp**: more live-fetch wrappers; the pattern is commoditized.

### 2.5 Apple's JSON content API (verified working today)

- `https://developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json` → returns DocC JSON (`primaryContentSections[].content[]` with `paragraph/inlineContent`, plus `references` map, `hierarchy.paths`). Verified live with `buttons.json` on 2026-06-10.
- The `tutorials/data/documentation/design/...` variant returns the HTML shell (dead for HIG).
- Both zanwei's and vabole's fetchers and kimsungwhee's MCP all build on this endpoint — it is de-facto stable but unofficial/undocumented; treat as best-effort with graceful failure.

---

## 3. Non-AI tooling (linters, test APIs, Figma)

### 3.1 Code-side

- **SwiftLint**: exactly **two** accessibility rules, both opt-in/off by default — `accessibility_label_for_image`, `accessibility_trait_for_button`. A 2021 issue (realm/SwiftLint#3484) asking for build-failing a11y enforcement went nowhere. → There is **no real HIG linter in the mainstream Swift toolchain**; the gap our suite fills is real.
- **Xcode 15+ / XCUITest**: `performAccessibilityAudit(for:_:)` on `XCUIApplication` runs Apple's own automated audit (contrast, Dynamic Type clipping, element descriptions, traits, hit region) inside UI tests; filterable by `XCUIAccessibilityAuditType`. This is Apple's sanctioned runtime check — a SwiftUI-audit skill should *recommend adding this test* rather than re-implement those checks statically.
- **Accessibility Inspector** (ships with Xcode): manual/interactive audits, used as ground truth.
- **AccessLint** (accesslint.app, commercial): build-time iOS a11y analysis, 25 rules for SwiftUI + UIKit, WCAG-mapped — closest commercial analog to orchard-hig's approach, also rule-ID + severity shaped.
- **GTXiLib / AccessibilitySnapshot**: Google/Square OSS for runtime a11y assertion & snapshot diffing — runtime-only, maintenance varies.
- Nothing found that lints *design* conformance (navigation patterns, component choice, spacing) — only accessibility. HIG-as-lint beyond a11y is effectively unoccupied territory outside the AI-skill repos above.

### 3.2 Figma side

- **Apple's official Design Resources now ship as a Figma UI kit**: "iOS and iPadOS 26" (Figma Community file `1527721578857867021`), fully rebuilt for Liquid Glass — components, templates, styles, **updated control sizes, new layouts and corner radii, refreshed system colors**. Sketch kit released alongside (June 9, 2025 wave). A macOS kit exists in the same resources program. → For Figma work, the skill should direct the designer to build *from the official kit* and audit against kit component names/sizes rather than re-derive geometry.
- Community Liquid Glass kits abound (Control Center kits, icon/button kits) — quality varies; prefer the official kit.
- **Stark** (contrast/a11y checks), generic "Design Lint" plugins exist; none are HIG-specific. No Figma plugin found that audits a file against HIG rules. (Our Figma leverage is via MCP `view_node` screenshots + checklist review, not an existing plugin.)

---

## 4. How Anthropic's official skills handle large reference corpora (anthropics/skills)

Examined `skills/pptx` and `skills/docx` (the doc-heavy exemplars among 17 official skills):

- **Three-level progressive disclosure:** (1) SKILL.md body is a *router* with a Quick Reference table ("Task → Guide"); (2) task-specific reference files loaded only when that task arises (`editing.md` 6.9 KB, `pptxgenjs.md` 12.8 KB — "Read editing.md for full details"); (3) scripts + data consumed without ever entering context.
- **The big-corpus trick:** docx/pptx bundle ~900 KB of ISO/ECMA **XSD schemas** — never read by the model. They exist solely so `scripts/office/validate.py` (deterministic validator, 32 KB base.py) can check produced XML. **Reference mass goes behind executable tooling, not into context.** For us: a full HIG snapshot can live in the skill directory for grep/scripted lookup without any always-load cost.
- **Deterministic scripts for fragile operations:** unpack/pack/clean/thumbnail — anything where model improvisation fails. Equivalent for us: a `fetch_hig_page` script, a contrast-ratio calculator, a token-grep audit script.
- **Trigger-maximalist descriptions:** pptx's description enumerates every noun and verb that should activate it ("deck," "slides," "presentation," any .pptx mention "regardless of what they plan to do with the content afterward"). Both lightscape and the official skills converge on this: descriptions should list concrete casual phrasings ("is this HIG compliant", "make it feel native").
- **Opinionated taste baked in:** pptx SKILL.md includes "Don't create boring slides" + concrete palette tables and visual-motif rules — official skills don't just expose facts, they impose defaults. Our generation skill should similarly impose Apple-correct defaults (e.g. "tab bar, not hamburger") rather than neutrally describing options.
- SKILL.md sizes: pptx 9.2 KB, docx 20 KB — they tolerate a meaty entry file when the workflow itself is the content, but keep *reference* material out of it.

---

## 5. Synthesis: what to copy / what to avoid

**Copy:**
1. justinwetch's distillation discipline (75% compression preserving numbers/API names/platform splits; eval pass per file; capture-date stamping; frontmatter-driven generated routing index; "no invention / cite exact values / never flatten platforms" rules).
2. lightscape's two-layer audit (grep table with rule IDs + compliance markers → targeted deep read), token-resolution-first step, severity+effort report format, slash-command entry points.
3. zanwei/vabole's live-fetch escape hatch on the verified DocC JSON endpoint, as freshness valve and citation source — with graceful failure.
4. Anthropic's router-SKILL.md + task-routed reference files + scripts-over-context for bulk data; trigger-maximalist descriptions; baked-in opinionated defaults.
5. neonwatty's web→iOS anti-pattern checklist (hamburger/FAB/centered-modal/HTML-select/visible-row-actions) as a first-class table for the HTML-prototype use case.
6. axiaoge2's deliverable format — a ready-to-paste CSS custom-properties token sheet — but regenerated with current (Liquid Glass-era) values and per-value sourcing.

**Avoid:**
1. Always-load tier floors of 30K+ tokens (justinwetch) — route by task, keep the always-cost near the SKILL.md alone.
2. Splitting the suite by Apple's doc taxonomy (CaioRodolfo) instead of by designer workflow.
3. Snapshot-without-working-refresh (tmaasen: dead npm + dead Actions across a design-language transition = confidently wrong forever). Every snapshot file needs a capture date; the suite needs a refresh script and a "verify currency" step.
4. Unsourced confident specifics and pre-2025 doctrine (axiaoge2's Clarity/Deference/Depth, glass-as-opt-in) — our skills must explicitly mark old-vs-current deltas because the *most popular* prior art (and base-model priors) teach the old world.
5. Regex-only compliance checking (orchard) as the whole answer — use it as recall layer under model judgment.
6. Generated mega-files (vabole's 814 KB references) — generation pipelines need a distillation/size budget.
7. All-six-platforms coverage — iOS + macOS only keeps the corpus a fraction of the 140K-token full-HIG size.

**Gap confirmed:** nothing found combines (a) current Liquid Glass-era content, (b) designer-workflow entry points (HTML prototype / Figma / SwiftUI), (c) checkable rule IDs with a deterministic recall layer, and (d) a working refresh pipeline. Each exists separately in prior art; none together.
