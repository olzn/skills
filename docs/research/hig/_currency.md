# Apple Design Guidance — Currency Snapshot (as of June 10, 2026)

Research date: **2026-06-10** (mid-WWDC26 week, keynote was June 8). Scope: iOS + macOS.
Purpose: establish exactly where Apple's design guidance stands today, how fast it moves,
and what that means for baking vs. live-fetching HIG content in skills.

---

## Provenance corrections (2026-06-10 audit)

A completeness audit found two press-sourced WWDC26 claims in this file (and in
`_practice.md`) that are **contradicted or unsupported by the live HIG**. Both were
re-verified on 2026-06-10 against the JSON API (sidebars, searching, search-fields,
tab-bars pages). The original text below is annotated, not deleted.

**1. "iOS 26 made sidebar icons monochrome; iOS 27 restores colour (active state)"**
(appears in §2 *Liquid Glass refinements* and §7 item 9).
What the live HIG actually says — Sidebars page, change log **2026-06-08** ("Updated
guidance for sidebar icon colors"): *"By default, sidebar icons use your app's accent
color."* In macOS, icons must follow the user-chosen system accent colour; fixed colours
are allowed *sparingly* to clarify meaning (e.g. Mail's yellow VIP icon). The page
contains **no monochrome-era narrative, no reversal, and no iOS 26 vs iOS 27
distinction**. The "flipped twice" story is press coverage of system-app visuals, not a
documented HIG rule.

**2. "iOS 27 re-integrates the search tab with the other tabs"** (echoed in §2's
"search-as-tab in iOS refined"; encoded strongly in `_practice.md`).
What the live HIG actually says — Searching page (**2026-06-08**): *"In apps that use tab
bars, like Photos and Apple TV, search is a dedicated tab"*; or a search field in a
bottom toolbar (Notes). Search-fields page (**2026-06-08**, "refined guidance for search
as a tab in iOS"): a search tab has **two sanctioned styles** — *standard tab* (rendered
uniformly with the other tabs, opens a search landing page) and *button appearance*
(rendered as a **separate button** that immediately focuses the field). Tab-bars page
(**2026-06-08**): *"A tab bar can include a dedicated search tab at the trailing end."*
Both integrated and separated presentations are **current, co-equal options chosen per
use case** — there is no "reversal of the split-search pattern".

**Rule going forward:** press-sourced claims (MacRumors, Cult of Mac, Engadget, 9to5Mac,
AppleInsider, etc.) must be **version-gated** ("press reports that iOS 27 will…; not
reflected in the HIG as of YYYY-MM-DD") and must **never be encoded as HIG doctrine**.
Only statements traceable to a live HIG page — cited with that page's change-log date —
may be written as normative rules for the skills.

---

## 1. State of play

| Thing | Current status (June 10, 2026) |
|---|---|
| Shipping OS | iOS 26.x (26.2 shipped Dec 2025), macOS Tahoe 26.x |
| Announced at WWDC26 | **iOS 27**, iPadOS 27, **macOS 27 "Golden Gate"**, watchOS 27, tvOS 27, visionOS 27 — dev betas out now, public release fall 2026 (~September) |
| Design language | **Liquid Glass, retained and refined** — no new design language at WWDC26; second-generation refinements instead |
| HIG | Substantially rewritten June 2025 for Liquid Glass; last updated **June 8, 2026** (18+ pages touched) |
| SF Symbols | **7 (stable)**, 7,000+ symbols; **SF Symbols 8 beta** (June 8, 2026) |
| Icon Composer | Stable v1 (ships with Xcode); **Icon Composer 2 beta** (June 8, 2026) |
| New design tool | **Pass Designer** — crafting/previewing Wallet passes (June 8, 2026) |
| OS versioning | Apple uses year-based numbering since 2025: 18 → **26** → **27**. There was never an iOS 19–25. |

**Critical adoption fact:** the `UIDesignRequiresCompatibility` Info.plist opt-out (Xcode 26)
is being **removed in Xcode 27** — Liquid Glass becomes effectively mandatory for apps built
with the iOS 27 SDK. Skills must never recommend the opt-out as a strategy.

---

## 2. WWDC26 design announcements (June 8, 2026)

### Liquid Glass refinements in iOS 27 / macOS 27
- **User transparency slider** in Settings — anywhere from "ultra clear to fully tinted".
  Replaces the binary Clear/Tinted toggle introduced in iOS 26.1. Design consequence:
  interfaces must remain legible across the *whole* opacity range, not two states.
- **More uniform refraction** and improved contrast/readability (direct response to
  documented accessibility criticism, incl. Nielsen Norman Group findings on translucent
  elements over busy backgrounds).
- **Sidebars extend edge-to-edge** to the window edge; refraction effects continue
  *beneath* the sidebar instead of cutting off at its boundary. **Sidebar icons retain
  their color** again (active state) — reverses the iOS 26 all-monochrome sidebar look.
  **[⚠ PROVENANCE CORRECTION 2026-06-10: the icon-colour-reversal sentence is
  press-sourced and unsupported by the live HIG — the Sidebars page (2026-06-08) says
  icons use the app accent colour by default, with no monochrome→colour narrative. See
  "Provenance corrections" at top.]**
- **Uniform frosted toolbar** restored across app tops in macOS 27 — improves button
  legibility / separation from content.
- **Consistent corner radius across all apps in macOS 27** — applied automatically by the
  system, including third-party apps, no developer work.
- Updated **window shapes** and **menu bar icons** (macOS).
- **App icons gain additional Liquid Glass refraction layers** baked into icon artwork —
  sharper, more defined.

### HIG changes published June 8, 2026
- **Design principles** page *reintroduced* (had been absent for years). Eight named
  principles: **Purpose, Agency, Responsibility, Familiarity, Flexibility, Simplicity,
  Craft, Delight** — each with a one-line imperative (e.g. Craft: "Care about every
  detail."; Delight: "Make it human.").
- **Snippets** — NEW page. Compact views shown in response to actions via Siri, Spotlight,
  or Shortcuts, built with App Intents. Two types: **confirmation** (Cancel + primary
  button, default label "Continue") and **result** (single Done button). Max custom-view
  height **400 pt**.
- **Siri** — revised for **Siri AI** (the rebuilt assistant announced at WWDC26).
- **App Shortcuts** — guidance for adopting app schemas.
- **Menus** — updated guidance for menu item icons.
- **Sidebars** — sidebar icon colors + new "adaptable sidebar style".
- **Scroll views** — updated scroll edge effect guidance.
- **App icons** — refined Liquid Glass guidance.
- **Search fields / Searching** — terminology updates; search-as-tab in iOS refined.
- **Tab bars** — updated terminology and art.
- **Generative AI** — guidance for refining results and feedback during generation.
- **Apple Pay / Wallet** — updated for iOS 27 + Pass Designer.

### Non-design but design-adjacent
- Siri AI (system-wide context, no more ChatGPT handoff) — touches HIG via Siri + Snippets.
- iOS 27 has no separate marketing name; macOS 27 is "Golden Gate".

---

## 3. Liquid Glass — current canonical guidance (HIG Materials page, fetched 2026-06-10)

Liquid Glass = "a dynamic material that unifies the design language across Apple
platforms". Core mental model: **two layers** —
1. **Content layer** — app content; uses *standard materials* (ultraThin/thin/regular/thick).
2. **Functional layer** — controls + navigation (tab bars, toolbars, sidebars) made of
   Liquid Glass, *floating above* content; content scrolls and "peeks through" beneath.

Checkable rules (exact HIG language):
- **"Don't use Liquid Glass in the content layer."** Exception: transient interactive
  elements (sliders, toggles) take on a Liquid Glass appearance *while a person activates
  them*.
- **"Use Liquid Glass effects sparingly"** on custom controls — system components get it
  automatically; limit custom use to the most important functional elements.
- Two variants: **regular** and **clear**.
  - *Regular*: default; blurs + adjusts luminosity of background; use for text-heavy
    components (alerts, sidebars, popovers) or whenever legibility is at risk. Most system
    components use it.
  - *Clear*: highly translucent; **only over visually rich backgrounds** (photos, video).
  - With clear over bright content: **add a dark dimming layer of 35% opacity**. Skip the
    dimming layer if content is sufficiently dark or AVKit playback controls provide one.
- **Scroll edge effects** blur/reduce opacity of background content under bars to preserve
  legibility at screen edges.
- Appearance varies with system settings: user's Liquid Glass preference (Clear/Tinted in
  26.1; full slider in 27), Reduce Transparency, Increase Contrast. Designs must survive all.

### Concentricity (new geometry doctrine since June 2025)
- Toolbars: "standard buttons, text fields, headers, and footers have corner radii that are
  **concentric with bar corners**. If you need to create a custom component, ensure that its
  corner radius is also concentric with the bar's corners."
- App icons: system masking produces rounded corners "that precisely match the curvature of
  other rounded interface elements throughout the system **and the bezel of the physical
  device itself**". Never pre-mask layers.
- Dev-side: SwiftUI `ConcentricRectangle` / container-concentric corner APIs (iOS 26+).
- macOS 27 extends this: system-enforced consistent corner radius across all apps.

### Bars and controls (current shape of things)
- **Tab bars (iOS)**: float above content at the bottom on a Liquid Glass background; can
  **minimize on scroll** (`TabBarMinimizeBehavior`); support an attached **accessory view**
  (e.g. Music's MiniPlayer) that moves inline when minimized; can include a **dedicated
  search tab at the trailing end**. NOT pinned full-width bars anymore.
- **Toolbars**: items separated into floating Liquid Glass groupings ("bubbles"/capsules),
  no longer pinned to bezels; default **monochromatic** item appearance — avoid coloring
  toolbar items similarly to content-layer backgrounds.
- **Standard materials still exist** for the content layer: `ultraThin`, `thin`, `regular`
  (default), `thick`, with vibrancy levels — labels: `label`/`secondaryLabel`/
  `tertiaryLabel`/`quaternaryLabel` (avoid quaternary on thin/ultraThin); fills:
  `fill`/`secondaryFill`/`tertiaryFill`; one `separator` level. macOS adds behind-window vs
  within-window blending.

### App icons (current spec, fetched 2026-06-10)
- **Layered**: background layer + 1+ foreground layers; system applies specular highlights,
  refraction, translucency dynamically. Build in any tool, assemble in **Icon Composer**.
- Layout: **1024×1024 px square, unmasked** (system masks to rounded rect). Color spaces:
  sRGB, Display P3, Gray Gamma 2.2.
- **Six appearances** on iOS/iPadOS/macOS: default, dark, **clear light, clear dark, tinted
  light, tinted dark**. System auto-generates variants you don't provide. Alternate icons
  need their own variant set.
- Rules: prefer vector layers (SVG/PDF); avoid soft/feathered edges; vary layer opacity for
  depth; background = solid color or gradient in Icon Composer; do NOT bake in shadows,
  speculars, bevels, blurs; text only when essential; illustrations over photos; no Apple
  hardware replicas.

---

## 4. Liquid Glass revision timeline (volatility evidence)

| Date | Event |
|---|---|
| 2025-06-09 | WWDC25: Liquid Glass announced; HIG rewritten; Icon Composer ships; SF Symbols 7 beta; Sketch UI kits day-one |
| Summer 2025 betas | Public legibility backlash; transparency dialed back in beta 3, partially restored in beta 4 |
| 2025-07-28 | HIG: tab bars LG guidance, scroll edge effects, menu icons, SF Symbols 7 draw/gradients |
| 2025-08-20 | Figma design kits arrive (visionOS, watchOS) — Figma lags Sketch by ~2 months |
| 2025-09-09/15 | HIG materials/motion/layout updates; iOS 26 + macOS Tahoe 26 ship |
| 2025-11-03 | **iOS 26.1**: Settings → Display & Brightness → Liquid Glass → **Clear / Tinted** toggle |
| 2025-12 | **iOS 26.2**: Lock Screen clock transparency slider; finer LG controls (tint intensity, background blur, reflections) |
| 2025-12-16 | HIG: Color, Buttons, Toolbars, Tab bars all re-updated for LG |
| 2026-03-26 | AppleInsider: compatibility-mode removal confirmed-ish; "Liquid Glass will be mandatory in iOS 27" |
| 2026-06-08 | **WWDC26**: iOS 27/macOS 27 Golden Gate; transparency slider; uniform refraction; edge-to-edge sidebars; macOS corner-radius unification; frosted toolbars; icon refraction layers; Icon Composer 2 beta; SF Symbols 8 beta |

Takeaway: Liquid Glass has been *revised four times in 12 months*, each time in the
direction of **more user control and more legibility**. Specific opacity/behavior details
are volatile; the two-layer model, variants, and concentricity doctrine have been stable.

---

## 5. Official design resources (developer.apple.com/design/resources/, fetched 2026-06-10)

- **Figma** (Apple Design Resources publisher on Figma Community):
  - iOS & iPadOS **26** UI Kit (last updated ~April 3, 2026)
  - macOS **26** UI Kit, watchOS 26, visionOS 26
  - iOS **27** App Icon Template (Figma/PS/Illustrator/Sketch) — available now
  - **No iOS 27 / macOS 27 Figma UI kits yet** — expect ~Aug 2026 based on 2025 lag
- **Sketch** (day-one for new OS): iOS & iPadOS **27** UI Kit, macOS **27** UI Kit
  (plus 26 versions still listed)
- **Fonts**: SF Pro (iOS/macOS system font), SF Compact (watchOS), SF Mono, New York
  (serif), SF Arabic/Armenian/Georgian/Hebrew
- **SF Symbols app**: v7 stable (7,000+ symbols, 9 weights, 3 scales, draw on/off
  animations, gradient rendering, Magic Replace, 4 rendering modes: Monochrome,
  Hierarchical, Palette, Multicolor). **v8 beta**: semantic search, new symbols, draw
  annotation guide points (Ultralight/Regular/Black), Variable Draw; targets the 27 OSes;
  requires macOS Sonoma+
- **Icon Composer**: included with Xcode + standalone download; requires macOS Sequoia+;
  Icon Composer **2 beta** adds Liquid Glass layering for iPhone/iPad/Mac/Watch from one design
- **Pass Designer**: new (June 2026), Wallet pass design/preview
- **Product bezels**: iPhone 17 family, iPad Pro (M5), MacBook Pro M5, etc. (Sept 2025 batch)
- Technology templates (Figma + Sketch): Apple Pay, Sign in with Apple, Live Activities,
  Messages, Siri & Shortcuts, Tap to Pay, TipKit, Wallet, App Clips

---

## 6. HIG change log mechanics + churn rate

### Where change information lives
1. **Site-wide design change log**: https://developer.apple.com/design/whats-new/ — dated
   entries (guidance / resource / video / article types). The HIG's own "What's new" link
   now points here (it's *outside* the HIG tree).
2. **Per-page change logs**: every HIG page ends with a "Change log" table (date + change
   summary) — present in the page JSON. This enables cheap per-page staleness checks.

### The JSON content API (verified working 2026-06-10)
```
https://developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json
```
- Returns DocC-style JSON (`primaryContentSections` → nested `inlineContent`); the public
  HTML pages are an empty JS shell, so this API is the only scriptable route.
- The `documentation/` path variant does NOT work; the `design/` variant does (slug casing
  flexible). Root TOC: `.../human-interface-guidelines.json` → `references` +
  `topicSections`.
- Page text extraction: walk `primaryContentSections` for `heading`/`text`/`table`/
  `unorderedList` nodes. (~50-line python script suffices; see extraction script pattern in
  this research run.)

### Update cadence (from the change log)
2025 entries: Jan 7, Jan 17, Feb 4, Mar 7, Apr 9, May 6, **Jun 9 (WWDC drop, ~30 pages)**,
Jul 28, Aug 20, Sep 9, Sep 12, Dec 4, Dec 16. 2026 entries so far: Mar 24, **Jun 8 (WWDC
drop, ~18 pages)**.

Pattern: **one massive drop at WWDC (June)** → follow-up waves in **late July**,
**September** (new hardware specs + .0 ship), **mid-December** (aligned with x.2), plus
scattered minor updates. Roughly **8–13 dated updates per year**, but most touch a handful
of pages.

### Per-page churn (sampled change logs)
| Page | Updates in last 24 months | Character |
|---|---|---|
| Tab bars | Jul 2025, Dec 2025, Jun 2026 | HOT — 3 revisions in 12 months |
| Toolbars | Jun 2025, Dec 2025 | hot (was dormant 2023–2025) |
| Buttons | Jun 2025, Dec 2025 | hot |
| Color | Jun 2025, Dec 2025 | hot |
| App icons | Jun 2025, Jun 2026 | hot |
| Layout | Mar 2025, Jun 2025, Sep 2025 | device-spec additions every Sept |
| Typography | Mar 2025, Dec 2025 | moderate (Dynamic Type additions) |
| Materials | Jun 2025, Sep 2025 | rewrote once, now settling |
| Design principles | reintroduced Jun 2026 | stable by nature |

### Current HIG structure (post-2025 rewrite, fetched 2026-06-10)
- **Getting started**: design-principles, designing-for-{ios, ipados, macos, tvos,
  visionos, watchos}, designing-for-games
- **Foundations** (18): accessibility, app-icons, branding, color, dark-mode, icons,
  images, immersive-experiences, inclusion, layout, materials, motion, privacy,
  right-to-left, sf-symbols, spatial-layout, typography, writing
- **Patterns** (25): charting-data … workouts (incl. searching, modality, loading,
  onboarding, settings, undo-and-redo)
- **Components** (8 category pages): content, layout-and-organization, menus-and-actions,
  navigation-and-search, presentation, selection-and-input, status, system-experiences
- **Inputs** (13), **Technologies** (29: incl. generative-ai, siri, apple-pay, wallet…)

---

## 7. Stale-model-knowledge corrections (pre-2025 assumptions that are now WRONG)

1. **Flat design is over.** Depth, refraction, translucency, specular highlights are the
   system norm. "Minimal flat" recommendations are pre-2025 thinking.
2. **App icons are not flat single PNGs.** They're layered compositions assembled in Icon
   Composer with SIX appearance variants (default/dark/clear-light/clear-dark/tinted-light/
   tinted-dark). Pre-rounding corners was always wrong; now masking is concentric with the
   device bezel.
3. **iOS tab bars are not pinned, full-width, opaque bars.** They float, minimize on
   scroll, carry accessories, and may include a trailing search tab.
4. **Toolbars are not edge-pinned opaque strips.** Items live in floating glass capsule
   groups with concentric corner radii and scroll edge effects.
5. **The four-materials model (ultraThin→thick) is now content-layer-only**; Liquid Glass
   owns the navigation/control layer.
6. **macOS and iOS share one design language now** — fewer platform exceptions than older
   guidance implied; macOS 27 even system-enforces corner radii.
7. **Version numbers**: iOS 18 → iOS 26 → iOS 27. macOS: Sequoia 15 → Tahoe 26 → Golden
   Gate 27. Never reference iOS 19–25.
8. **The HIG structure changed**: "What's new" is external; "Getting started" section is
   new; Design principles page is back (8 principles) after years of absence.
9. **Sidebar icon treatment flipped twice**: colorful (pre-26) → monochrome (26) → color
   returns for active state (27). Volatile — don't hard-code.
   **[⚠ PROVENANCE CORRECTION 2026-06-10: the "flipped twice" timeline is press-sourced
   and not supported by the live HIG. Current doctrine (Sidebars, 2026-06-08): icons use
   the app accent colour by default; respect the user's macOS system accent colour; fixed
   colours sparingly for meaning. Keep only the "don't hard-code" conclusion. See
   "Provenance corrections" at top.]**
10. **Liquid Glass opt-out is temporary** — gone in Xcode 27. Compatibility mode is not a
    valid recommendation.

---

## 8. Beta-period caveat (important for the next ~3 months)

iOS 27 / macOS 27 guidance captured this week is **beta-era**. Apple revised Liquid Glass
during the 2025 beta cycle (beta 3 vs beta 4 transparency flip-flop) and again at 26.1 and
26.2. Anything 27-specific (slider behavior, sidebar color rules, corner radius
enforcement) may shift before the fall 2026 public release. The 26.x guidance is the stable
shipping baseline until ~September 2026.

---

## Sources
- https://developer.apple.com/design/whats-new/ (change log, fetched 2026-06-10)
- HIG JSON API: materials, app-icons, tab-bars, toolbars, layout, design-principles,
  snippets, getting-started, foundations, etc. (fetched 2026-06-10)
- https://developer.apple.com/design/resources/ (fetched 2026-06-10)
- https://developer.apple.com/sf-symbols/ (fetched 2026-06-10)
- https://www.macrumors.com/2026/06/08/apple-announces-liquid-glass-improvements/
- https://www.macrumors.com/2026/06/08/apple-announces-macos-golden-gate/
- https://www.cultofmac.com/news/liquid-glass-changes-ios-27-macos-27
- https://www.engadget.com/2189698/everything-announced-at-apples-wwdc-2026-keynote/
- https://www.macrumors.com/2025/10/20/ios-26-1-liquid-glass-toggle/ (26.1 toggle)
- https://www.techlicious.com/blog/apple-liquid-glass-lock-screen-adjustment-notification-screen-flash11/ (26.2)
- https://appleinsider.com/articles/26/03/26/stop-holding-out-hope-liquid-glass-will-be-mandatory-in-ios-27
- https://www.donnywals.com/opting-your-app-out-of-the-liquid-glass-redesign-with-xcode-26/
