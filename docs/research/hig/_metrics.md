# Numeric anchors for iOS 26-era prototyping fidelity

> Research date: **2026-06-10**. Scope: iOS (primary) + macOS Tahoe control metrics. Purpose: give HTML
> prototypes current numbers — the HIG **no longer publishes bar metrics**, and the model's pre-2025 priors
> (44pt nav bar, 49pt tab bar, 10pt grouped-list radius) are **wrong** for iOS 26.
>
> **Primary method:** runtime measurement of UIKit/SwiftUI defaults on the **iOS 26.2 simulator**
> (Xcode 26.5, build 17F42) on **iPhone 17 (402×874pt @3x)** and **iPhone 17 Pro Max (440×956pt @3x)**,
> via a throwaway instrumented app (view-hierarchy dump + `UICornerConfiguration` introspection +
> `sizeThatFits`), cross-checked against screenshots and community recreations. AppKit measured natively
> on **macOS Tahoe 26.5.1**. Workflow reproducible — see §12.

## Provenance & confidence legend

| Tag | Meaning |
|---|---|
| **HIG** | Published in the current HIG (page + alert date cited). Normative. |
| **RT** | Runtime-measured from Apple's frameworks on iOS 26.2 sim / macOS 26.5.1 (authoritative for "what the system actually renders"; could change in any OS release). |
| **CM** | Community-measured / third-party recreation (cited). Use only when RT/HIG absent. |
| Confidence: **high** = ≥2 independent sources or direct runtime read; **med** = single runtime context; **low** = inferred/unverified — do not present as fact. |

All values in **points (pt)** at default Dynamic Type (Large) and default text size. In HTML prototypes
1pt = 1 CSS px (use 402×874 or 440×956 viewports for iPhone 17 / 17 Pro Max).

---

## 1. Stale-knowledge corrections (pre-2025 prior → iOS 26 reality)

| Component | Stale prior | iOS 26 measured | Source |
|---|---|---|---|
| Navigation bar height | 44pt | **54pt** (standard title row) | RT, high |
| Large-title nav bar | 96.5pt (44+52.5) | **106pt** (54 + 52 large-title row) | RT, high |
| Tab bar | 49pt full-width bar docked to bottom (83pt incl. home area) | **Floating capsule, 62pt tall**, inset **21pt** from sides and bottom; width hugs content (full-width-minus-42pt with 4–5 tabs, shrinks with fewer) | RT + CM, high |
| Toolbar (bottom) | 44pt full-width bar | **No bar** — individual floating Liquid Glass platters, **48pt tall** (48×48 circle for icon, capsule for text), ~**28pt** from screen edges | RT, high |
| Bar buttons (top) | borderless 44pt-tall tappable text/icons | **44×44pt circular glass platters** (icon content 36×36 inside, 4pt padding), 16pt from edge | RT, high |
| Inset-grouped list corner radius | 10pt | **26pt** (`UICornerConfiguration .fixed(radius: 26.0)`) | RT, high |
| Default list row height | 44pt | **53pt** (1-line, default content config) | RT, high |
| Sheet corner radius | ~10–12pt | **38pt top corners**; bottom corners concentric with display (56–62pt); medium-detent sheets **float with 8pt margins** on all sides | RT, high |
| Search text field | 36pt rounded-rect | **44pt capsule** (corner radius 22) | RT, med |
| UISwitch | 51×31pt | **63×28pt** (SwiftUI `Toggle` 61×28) | RT, med |
| Tab bar labels | 10pt | **~11–12pt** (label box 12pt tall; Erik Kennedy reports 11pt SF) | RT + CM, med |
| Page indicators/dimensions pages in HIG | HIG used to publish bar heights | HIG publishes **no iOS bar metrics at all** now — only device dimensions, 44pt hit targets, and type tables | HIG, high |

---

## 2. Device anchors (iPhone 17 family)

- **HIG-published** (Layout page, alert 2025-09-09 "Added specifications for iPhone 17…"): full device
  dimensions table. Key entries: iPhone 17 Pro Max **440×956pt @3x**; iPhone 17 Pro **402×874pt @3x**;
  iPhone 17 **402×874pt @3x**; iPhone Air 420×912pt @3x (from same table). iPads: iPad Pro 13" 1032×1376pt @2x,
  iPad Pro 11" (5th/6th gen) 834×1210pt @2x. HIG, high.
- **Display corner radius: 62pt** on iPhone 17 and 17 Pro Max (`UIScreen` private `_displayCornerRadius`). RT, high.
  Feed this to "concentric" corner maths in prototypes.
- **Safe areas (portrait, iPhone 17 & 17 Pro Max): top 62pt, bottom 34pt** (home indicator). RT, high.
- Useful composite anchors (iPhone 17, portrait): content top inset under standard nav bar = **116pt**
  (62 safe + 54 bar); content bottom inset above floating tab bar = **83pt** (legacy 49+34 metric — UIKit still
  reports the old value via `adjustedContentInset` even though the visual is a floating capsule). RT, high.

## 3. Floating tab bar (iOS 26)

| Metric | Value | Source |
|---|---|---|
| Capsule height | **62pt** | RT (`_UITabBarPlatterView` 360×62 on 402pt screen); FabBar recreation hardcodes 62 (CM); high |
| Side inset | **21pt** each side (when ≥4 tabs; platter = screen−42pt) | RT + CM (FabBar 21pt; learnui.design "21pt on left, right, and bottom"); high |
| Bottom inset | **21pt** from screen bottom edge (capsule bottom sits 21pt above hardware edge, overlapping home-indicator area) | RT (874−853) + CM; high |
| Corner radius | capsule = **31pt** (height/2; radius driven by `UICornerConfiguration`, reads as NaN on the layer) | RT-derived, high |
| Per-tab item | 98×54pt touch targets, 4pt padding inside capsule | RT, med |
| Selection "lens" (liquid highlight) | 94–98×54pt capsule (radius 27) sliding behind selected tab | RT, med |
| Icon box / label | icon ~28pt-tall box at top; label 12pt-tall box at y=35 (≈11pt font) | RT, med |
| Fewer tabs | capsule shrinks to fit (2 tabs → 188pt wide, centred) | RT, med |
| With trailing accessory (e.g. search FAB) | separate circular platter, 8pt gap (`UIGlassContainerEffect.spacing` in FabBar recreation) | CM, low-med |
| UIKit legacy frame | `UITabBar.frame` still reports full-width ×83pt — don't trust the frame, trust the platter | RT, high |

HIG tab-bars page (alert 2026-06-08, "Updated terminology and art"): qualitative only — "a tab bar floats
above content at the bottom of the screen", items on a Liquid Glass background; can minimize on scroll with
an attached accessory (Music MiniPlayer pattern). The only number on the page (68pt height / 46pt from top)
is **tvOS-only** — do not apply to iOS. Canonical: https://developer.apple.com/design/human-interface-guidelines/tab-bars

## 4. Top navigation bar & toolbars

Top bar (iOS 26, iPhone, portrait — RT, high unless noted):
- Standard title row: **54pt** tall, sits directly below 62pt safe-area top. Title 17pt semibold, centred
  (label box ~20.7pt tall at y≈11.7).
- Large title: adds a **52pt** row below (total bar 106pt). Large-title label 34pt bold, 16pt leading margin,
  ~41pt line box (matches HIG Large Title 34/41).
- Bar buttons: each renders on a **44×44pt** circular glass platter (`PlatterView`), inner item 36×36 (4pt
  padding), **16pt** from screen edge. Text buttons become capsules of the same 44pt height. RT, high.
- There is **no opaque bar background**: scroll-edge effect (a `ScrollEdgeEffectView` blur/fade pocket ~171pt
  tall at top) replaces the old bar fill. Prototype as a gradient/progressive-blur mask, not a solid bar. RT, med.

Bottom toolbar (iOS 26 — replaces the 44pt `UIToolbar` strip; RT, high):
- Items render as **individual floating glass platters, 48pt tall**: icon-only = **48×48 circle**;
  text = capsule (e.g. "Done" ≈ 75.7pt wide). Inner button content 38pt with 5pt padding.
- Margins: **~28pt** from left/right screen edges and **28pt** from bottom edge (pixel-measured from
  screenshot: 28.7pt visible). Note this differs from the tab bar's 21pt.
- HIG toolbars page (alert 2025-12-16): no numbers, but a normative geometry rule — **"standard buttons,
  text fields, headers, and footers have corner radii that are concentric with bar corners"**; custom
  components must match. Reviewer check: capsule/platter corners must be concentric (child radius = parent
  radius − inset). Canonical: https://developer.apple.com/design/human-interface-guidelines/toolbars
- The HIG `navigation-bars` page **no longer exists** (404 on the JSON API) — merged into Toolbars. High.

## 5. Standard layout margins

- **16pt** leading/trailing system minimum layout margins on 402pt-wide iPhones (17/17 Pro). RT, high.
- **20pt** on 440pt-wide iPhone 17 Pro Max. RT, high. (The classic 16/20 width split survives in iOS 26.)
- `readableContentGuide` on iPhone 17 portrait = full width minus 16pt margins (370pt). RT, med.
- HIG Layout page: no margin numbers for iOS; only qualitative "respect system-defined safe areas, margins,
  and guides" + "avoid full-width buttons … respect system-defined margins". The 60pt/80pt insets on the page
  are **tvOS-only**. Canonical: https://developer.apple.com/design/human-interface-guidelines/layout (alert 2025-09-09)

## 6. Lists & tables (inset-grouped, UIKit defaults)

All RT, high unless noted (iPhone 17; Pro Max variations in parentheses):
- Section side inset: **20pt** from screen edges on both 402pt and 440pt widths (constant, unlike margins).
- Corner radius of grouped sections: **fixed 26pt** (`.fixed(radius: 26.0)` top corners of first cell, bottom
  of last). Use 26px in HTML.
- Row height, 1-line default cell (17pt body text): **53pt** ≈ 22pt line + 15pt top/bottom cell padding.
- Row height, 2-line (title+subtitle): **73.3pt**.
- Section header: **38pt** tall, label ~13pt at y≈11.7, 16pt (20pt on Pro Max) leading inset within section.
- Cell content padding: leading 16pt (20pt Pro Max), trailing 8pt before accessory; separator inset 16pt
  (20pt Pro Max) from cell leading edge, full-bleed to trailing.
- Disclosure chevron: ~10.3×14pt, right-aligned at content trailing edge.
- SwiftUI `List` may differ by a point or two — measure if exactness matters (§12). low.
- HIG lists-and-tables page (alert 2023-06-21 — **pre-Liquid Glass**, oldest page in this set): no numbers.
  Canonical: https://developer.apple.com/design/human-interface-guidelines/lists-and-tables

## 7. Sheets

RT, high (iPhone 17, `UISheetPresentationController`):
- **Medium detent**: floats with **8pt margins** on all sides — frame (8, 415, 386, 451) on 402×874; extends
  to 8pt above the hardware bottom edge.
- **Large detent**: full width, top edge at safe-area top (y=62), runs to the screen bottom.
- Corner radii (from `UICornerConfiguration`): **top corners fixed 38pt** (both detents); **bottom corners
  concentric with the display** — 62pt at large detent (full-bleed), ~56.2pt at medium (floating, 8pt inset).
  For HTML: top radius 38px; bottom radius ≈ display radius (62) minus inset.
- Grabber: **36×5pt**, radius 2.5, centred, 5pt below sheet top.
- HIG sheets page (alert 2026-03-24, "Updated guidance for button placement"): detents defined qualitatively
  only (large = full height, medium ≈ half); close button top-trailing for sheets without explicit actions.
  No radius/inset numbers. Canonical: https://developer.apple.com/design/human-interface-guidelines/sheets

## 8. Buttons & standard controls (iOS)

Measured heights, UIKit `UIButton.Configuration` intrinsic = SwiftUI `sizeThatFits` (identical across
`.filled/.tinted/.gray/.plain/.glass/.glassProminent/.bordered/.borderedProminent`); RT, high:

| Size (`controlSize` / `buttonSize`) | Height | Notes |
|---|---|---|
| mini | **28pt** | |
| small | **28pt** | same as mini at default type size |
| regular / medium | **34.3pt** | |
| large | **50.3pt** | the "primary CTA" height |
| extraLarge (SwiftUI) | **50.3pt** | no taller than large for these styles at default type size |

- Default shape in iOS 26 is **capsule** (corner = height/2) for glass and filled styles; corner style is
  "dynamic"/concentric, layer radius reads 0/NaN.
- **HIG-normative (Buttons page, alert 2025-12-16): minimum hit region 44×44pt** ("a button needs a hit
  region of at least 44x44 pt"). The only published size table on that page (Mini 28 / Small 32 / Regular 44 /
  Large 52 / Extra large 64) is **visionOS-only** — do not quote it for iOS (a tempting trap: the numbers look
  plausible). Canonical: https://developer.apple.com/design/human-interface-guidelines/buttons
- Other controls (RT, med): `UISegmentedControl` 32pt tall; `UISwitch` 63×28 (SwiftUI Toggle 61×28);
  SwiftUI `TextField(.roundedBorder)` 34pt.

## 9. Search fields

- Standalone `UISearchBar`: overall **64pt**; the visible **capsule field is 44pt tall** (radius 22 =
  capsule via `UICornerConfiguration .capsule`), 8pt side insets within the bar, 10pt top/bottom; text 17pt
  body; magnifier icon ~20.7×19.3 at x=12. RT, med (one context; nav-stacked variant collapses to 0pt until
  active so couldn't be measured inactive).
- In a nav bar (stacked placement) the field gets 16pt side margins (370pt wide on 402). RT, low-med.
- HIG search-fields page (alert 2026-06-08, "Updated terminology and refined guidance for search as a tab in
  iOS"): no numbers. iOS 26 pattern: search can be a dedicated tab role — the tab bar morphs into a search
  field/FAB. Canonical: https://developer.apple.com/design/human-interface-guidelines/search-fields

## 10. Navigation title & key type sizes (HIG-published, current)

Typography page (alert 2025-12-16, "Added emphasized weights…"), iOS/iPadOS Dynamic Type **Large (default)**
table — unchanged numerically from pre-26 but now includes emphasized weights. HIG, high:

| Style | Weight | Size / Leading | Emphasized |
|---|---|---|---|
| Large Title | Regular | **34 / 41** | Bold |
| Title 1 | Regular | 28 / 34 | Bold |
| Title 2 | Regular | 22 / 28 | Bold |
| Title 3 | Regular | 20 / 25 | Semibold |
| Headline | Semibold | **17 / 22** | Semibold |
| Body | Regular | **17 / 22** | Semibold |
| Callout | Regular | 16 / 21 | Semibold |
| Subhead | Regular | 15 / 20 | Semibold |
| Footnote | Regular | 13 / 18 | Semibold |
| Caption 1 / 2 | Regular | 12 / 16, 11 / 13 | Semibold |

Nav bar usage (RT-confirmed): standard title = 17pt semibold (Headline); large title = 34pt bold.
macOS built-in text styles (same page): Large Title **26/32**, Title 1 22/26, Title 2 17/22, Title 3 15/20,
Headline 13/16 bold, **Body 13/16**, Callout 12/15, Subheadline 11/14, Footnote 10/13, Caption 10/13.
Canonical: https://developer.apple.com/design/human-interface-guidelines/typography

## 11. macOS Tahoe 26.5.1 control metrics (AppKit `fittingSize`, RT)

| Control | mini | small | regular | large | extraLarge |
|---|---|---|---|---|---|
| Push button height | 16 | 20 | **24** | 28 | 36 |
| Rounded text field height | 19 | 22 | **24** | 24 | 24 |

- `NSSearchField` 24pt; `NSSegmentedControl` 24pt; `NSPopUpButton` 24pt; checkbox 16pt; `NSSwitch` 54×24.
  RT, high (heights); widths content-dependent.
- `NSTableView`/`NSOutlineView` default row height: **24pt**. System font: regular 13pt, small 11, mini 9. RT, high.
- Title bar (titled window, no toolbar): **32pt**. RT, med.
- Title bar + toolbar measured **66pt** offscreen with an empty `NSToolbar` — **low confidence** (never
  rendered onscreen; typical unified toolbar is nearer 52pt). Verify visually before relying on it.
- macOS Liquid Glass toolbar capsule padding/grouping: **no reliable number found** — measure per §12 or
  screenshot a system app (Finder/Safari on Tahoe) and pixel-measure.

## 12. No-reliable-number list + runtime measurement workflows

**Explicitly unverified / no reliable public number:**
- Tab bar "minimized" (scrolled) state dimensions; tab-bar accessory (MiniPlayer) metrics.
- Toolbar inter-group spacing with >2 bottom items (HIG only says "aim for a maximum of three" groups).
- iPad-specific bar metrics (top-aligned tab bar/toolbar coexistence) — not measured this pass.
- macOS Tahoe toolbar item capsule sizes (see §11).
- Exact glass blur/refraction parameters — Apple does not expose them; treat as material, not numbers.

**Workflow A — UIKit/SwiftUI runtime extraction (what produced the RT numbers; ~10 min, fully scripted):**
1. Write a single-file UIKit app exercising the component (tab controller, nav stack, inset-grouped table,
   sheet, buttons). Build with `xcrun -sdk iphonesimulator swiftc -parse-as-library -target
   arm64-apple-ios26.0-simulator main.swift -o App.app/App` + a minimal Info.plist (**must include
   `UILaunchStoryboardName`**, even empty — without it the app runs letterboxed at 320×480 and metrics are wrong).
2. `xcrun simctl boot <udid> && xcrun simctl install <udid> App.app && xcrun simctl launch --console-pty
   <udid> <bundle-id>` — `print()` output lands on the pty.
3. In-app, after a ~2s layout delay: recursively dump subview class names + frames; read
   `view.cornerConfiguration` (iOS 26 `UICornerConfiguration` — `layer.cornerRadius` reads 0/NaN for
   glass/concentric corners, the configuration's description shows `.fixed(radius:)`/`.capsule`); read
   `UIScreen.value(forKey: "_displayCornerRadius")`; `UIHostingController(rootView:).sizeThatFits(in:)` for
   SwiftUI control sizes; `systemMinimumLayoutMargins`, `adjustedContentInset` for layout anchors.
4. Cross-check visually: `xcrun simctl io <udid> screenshot shot.png`, then pixel-measure with PIL
   (@3x px ÷ 3 = pt) — used here to confirm toolbar platter 48pt/28pt margins.

**Workflow B — Apple Figma kit measurement (designer-grade source, not yet executed):**
The official "iOS and iPadOS 26" kit is Figma Community file **1527721578857867021** (fully overhauled
July 2025: "Liquid Glass controls and views, updated control sizes, layouts, and corner radii"). Community
files can't be read via API directly: duplicate the kit into the user's Figma account, then use the Figma MCP
(`mcp__figma__add_figma_file` with the duplicated file URL, `mcp__figma__view_node` on component frames) to
read exact component dimensions. Use to settle any RT-vs-design discrepancy (the kit is design-truth, the
runtime is engineering-truth; they occasionally disagree by a point).

**Workflow C — AppKit:** native `swift script.swift` reading `fittingSize` per `controlSize` (no simulator
needed). Window/toolbar metrics need an onscreen window to be trustworthy.

## 13. HIG pages consulted — currency log (JSON API, fetched 2026-06-10)

| Page | Alert date | Alert text | Numbers for iOS? |
|---|---|---|---|
| Layout | 2025-09-09 | iPhone 17 family specs added | Device dimensions only |
| Tab bars | 2026-06-08 | Updated terminology and art | None (68pt figure is tvOS) |
| Toolbars | 2025-12-16 | Updated guidance for Liquid Glass | None; concentric-corner rule |
| Sheets | 2026-03-24 | Updated guidance for button placement | None |
| Buttons | 2025-12-16 | Updated guidance for Liquid Glass | 44×44pt hit region; size table is visionOS-only |
| Search fields | 2026-06-08 | Search-as-tab guidance | None |
| Lists and tables | 2023-06-21 | visionOS additions (stale page) | None |
| Typography | 2025-12-16 | Emphasized weights added | Full type tables (iOS table is in a `tabNavigator` JSON block, not a plain table — extractors must walk `tabs[].content[]`) |

Community sources: FabBar (github.com/ryanashcraft/FabBar — `Constants.swift`: barHeight 62, padding 21,
icon 18pt/medium, label 10pt); learnui.design iOS 26 guidelines (updated 2026-04-22: 21pt tab insets, 11pt
labels, 34/17pt titles, 44pt targets); unionst/union-tab-view (itemHeight 58 + 4pt padding variant — shows
community values scatter ±4pt, prefer RT).

**Caveats:** all RT values are iOS 26.2-simulator behaviour at default settings; iOS 27 (beta, ships ~Sept
2026) may shift them — re-run Workflow A against the iOS 27 SDK before trusting these post-release. Values
marked med/low were measured in one context only. Nothing in this file is invented; anything Apple doesn't
publish and we didn't measure is in the §12 no-number list.
