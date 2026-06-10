<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: materials, color, dark-mode, app-icons, icons, sf-symbols, motion, typography, layout, tab-bars, toolbars, sidebars, search-fields, searching, buttons, menus, the-menu-bar, context-menus, edit-menus, pop-up-buttons, home-screen-quick-actions, focus-and-selection, multitasking, ratings-and-reviews, siri, onboarding, offering-help, managing-accounts, loading, settings, writing, design-principles -->

# Corrections — stale priors a pre-2025 model asserts with confidence

The HIG was rewritten twice in 12 months (Liquid Glass, WWDC 2025; foundations rework, WWDC 2026). Each row: the confident wrong answer vs current guidance. **Volatility: hot = re-verify with a live fetch before asserting; stable = safe from the snapshot.** Never teach the left column.

## Visual system

| You likely believe | Current guidance (since) | src | volatility |
|---|---|---|---|
| Apple's aesthetic is flat, minimal design | Depth is the norm: Liquid Glass refraction, specular highlights, translucency on the floating functional layer (2025-06-09) | materials | stable |
| Materials (ultraThin→thick) are a styling choice anywhere in the UI | Standard materials are content-layer only; Liquid Glass owns the control/navigation layer; never glass in the content layer (2025-06-09) | materials | stable |
| Liquid Glass ≈ stronger frosted blur | A distinct refractive, adaptive material with regular/clear variants and a 35%-opacity dimming rule for clear over bright media — not a blur level (2025-06-09) | materials | stable |
| Bars need solid/dark backgrounds (barTintColor) | Bars are glass and adapt via the material; the scroll edge effect — not a bar background or hairline — separates bar from content (2025-06-09) | materials, dark-mode, toolbars | stable |
| System colour hexes are stable (#007AFF = systemBlue) | Values changed 2025-06-09, published as images only, "may fluctuate from release to release" — use Color/UIColor/NSColor APIs | color | hot |
| Single-appearance apps can skip dark-variant colours | Even single-appearance apps must supply light + dark colours for Liquid Glass adaptivity (2025-12-16) | color | stable |
| Tint bar buttons freely with tintColor | Colour on glass = emphasis only: tint the background of the one primary action; symbols/text default monochromatic; never tint multiple control backgrounds (2025-12-16) | color, toolbars | stable |
| App icon = flat PNG, pre-rounded squircle, grid of export sizes; macOS may be freeform | One 1024×1024 px square unmasked layered source assembled in Icon Composer; system masks concentric with UI and device bezel; six appearances (default, dark, clear light/dark, tinted light/dark); macOS uses the same square layout — no overhang (2025-06-09; refined 2026-06-08) | app-icons | hot |
| "Apple-standard 0.3 s ease-in-out" | The HIG publishes no duration/easing numbers; motion guidance is qualitative + system-supplied — never invent values | motion | stable |
| SF Pro Text/Display switch at 20 pt | Variable fonts with dynamic optical sizes interpolate continuously; discrete cuts only for tools without variable-font support | typography | stable |
| Symbol names from ≤2024 (doc.on.doc, doc.text.magnifyingglass) | Renamed: document.on.document (Copy), document.on.clipboard (Paste), text.page.badge.magnifyingglass (Find); canonical action→symbol table added 2025-06-09; SF Symbols 8 beta is out — verify names live | icons, sf-symbols | hot |

## Bars, navigation, search

| You likely believe | Current guidance (since) | src | volatility |
|---|---|---|---|
| iOS tab bar = opaque full-width bar pinned to the bottom edge | Floats above content on Liquid Glass; can minimise on scroll, carry an attached accessory (Music's MiniPlayer), and include a trailing search tab (2025-07-28; terminology 2026-06-08) | tab-bars | hot |
| iPad tab bars sit at the bottom; tab bar vs sidebar is an either/or choice | Top-positioned since iPadOS 18; adaptable sidebar style (`sidebarAdaptable`) gives both; customisable, default ≤5 tabs | tab-bars, sidebars | stable |
| Tab bars are iOS-only; Macs use sidebars/segmented controls | Tab bars are supported on macOS via the same model ("no additional considerations") | tab-bars | stable |
| "Navigation bars" is a component | Page gone — 301-redirects to Toolbars (2025-06-09); the top bar is a toolbar ("a navigation-specific toolbar is sometimes called a navigation bar") | toolbars | stable |
| Toolbars = edge-pinned strips; bordered bar buttons are fine | Items float in glass groupings with concentric corner radii; borderless symbols; exactly one `.prominent` action, trailing; ≤3 groups; overflow is system-managed (2025-06-09; 2025-12-16) | toolbars | hot |
| 44 pt nav bar / 49 pt tab bar are HIG-published | Apple no longer publishes bar metrics; only provenance-marked estimates exist — see `tables/metrics.md` | layout, toolbars | stable |
| Content lays out between opaque top and bottom bars | Content is edge-to-edge beneath floating bars; scroll edge effects replace bar backgrounds; background extension views fill behind sidebars/inspectors (2025-06-09) | layout | stable |
| iOS search is pinned under a large title at the top (UISearchController) | Prefer bottom placement for reach, or a search tab with two co-equal styles — standard tab and button appearance (2026-06-08). Press claims of an iOS 27 "search re-integration reversal" are unsupported by the HIG — don't assert them | search-fields, searching | hot |
| macOS sidebars are translucent material in opaque chrome; sidebar icons went monochrome in 26, colour returns in 27 | Sidebars float on Liquid Glass with a background extension effect; icons use the app accent colour by default and must follow the user's macOS system accent; fixed colours sparingly (e.g. Mail's VIP). The monochrome→colour flip-flop is press narrative, not HIG (2026-06-08) | sidebars | hot |

## Components, menus, input

| You likely believe | Current guidance (since) | src | volatility |
|---|---|---|---|
| A flat 44 pt minimum applies to every target everywhere | Buttons: hit region ≥44×44 pt incl. surrounding space (iOS and macOS pointer). Control-size tables split default/minimum: iOS 44/28 pt, macOS 28/20 pt — don't flatten into one number | buttons, accessibility | stable |
| 3D Touch / peek-and-pop | Dead; invocation is touch-and-hold; previews via UIContextMenuInteraction | context-menus, home-screen-quick-actions | stable |
| UIMenuController black edit bubble | UIEditMenuInteraction (iOS 16+): horizontal menu, chevron expands to vertical; keyboard/pointer reveal opens the vertical style directly | edit-menus | stable |
| UIPickerView wheels for short option lists | Pop-up buttons (inline value pickers) replaced wheels and detail-screen pushes for small option sets | pop-up-buttons | stable |
| Menu-item icons are an ad-hoc choice | Icons sparing and purposeful; within one group, icons on all items or none; use the standard-icons table (2025-07-28; 2026-06-08) | menus, icons | hot |
| The menu bar is macOS-only, 22 pt tall | Exists on iPadOS since 2025-06-09 (hidden until revealed, centred, no Apple menu or extras); macOS menu bar height is 24 pt | the-menu-bar | stable |
| Dim-vs-hide for unavailable menu items is interchangeable | Regular menus dim, never hide; context menus hide, never dim (macOS Cut/Copy/Paste may dim) (2023-12-05) | menus, context-menus | stable |
| iOS has the same focus system as iPadOS | It doesn't — the focus system explicitly excludes iOS; no focus rings on iPhone designs | focus-and-selection | stable |

## Platform, lifecycle, frameworks

| You likely believe | Current guidance (since) | src | volatility |
|---|---|---|---|
| iOS 18 → iOS 19; macOS 15 → 16 | Year-based since 2025: iOS 18 → 26 → 27; macOS Sequoia 15 → Tahoe 26 → Golden Gate 27. iOS 19–25 never existed | versions.md | stable |
| Liquid Glass is opt-in (UIDesignRequiresCompatibility) | The opt-out is temporary — removed in Xcode 27; never recommend it as a strategy (press/tooling-sourced, version-gated) | versions.md | hot |
| Split View / Slide Over / Stage Manager define iPad multitasking | Terminology gone (2025-06-09): iPadOS 26 has free-form resizable windows, macOS-style window controls, system tiling; apps get no indication of configuration — design for arbitrary sizes | multitasking | stable |
| SKStoreReviewController.requestReview() | RequestReviewAction; system caps 3 prompts/365 days; ≥1–2 weeks between asks; never during onboarding | ratings-and-reviews | stable |
| SiriKit custom intents, "Add to Siri" button, donated shortcuts | Page rewritten 2026-06-08 for Siri AI: App Intents, intents/entities, app schema domains, snippets, the Siri app; "Add to Siri" button removed June 2023 | siri | hot |
| Onboarding = multi-page welcome carousel | TipKit contextual tips preferred (2023); tutorials optional and skippable; splash screens sanctioned only at onboarding start (2024-06-10) | onboarding, offering-help | stable |
| Email + password is the default auth | Sign in with Apple, else passkey-first; passwords are fallback + 2FA; in-app account creation mandates account deletion (not deactivation) | managing-accounts | stable |
| Block first run on a big download | Background Assets: schedule large downloads in the background post-install/update (2025-06-09) | loading | stable |
| Full-width pill CTAs are the iOS pattern | Avoid full-width buttons; inset from system margins, harmonise with hardware corner curvature (2025-06-09) | layout | stable |
| Design canvas is 375×667 or 390×844 | Default flagship canvas 402×874 pt; iPhone 17 Pro Max 440×956; iPhone Air 420×912 @3x — September hardware rotates these | layout | hot |

## Naming and copy

| You likely believe | Current guidance (since) | src | volatility |
|---|---|---|---|
| "Preferences…" on macOS | "Settings…" everywhere since macOS 13 (2022); ⌘, unchanged; sections are still called panes | settings, the-menu-bar | stable |
| "My…"/"Your…" label prefixes are house style | Possessives sparingly: "Favorites", not "Your Favorites"; if used, one perspective app-wide; avoid "we" entirely (2025-12-16) | writing | stable |
| Clarity/Deference/Depth (or the six pre-2023 principles) | Obsolete. Canonical since 2026-06-08: eight principles — Purpose, Agency, Responsibility, Familiarity, Flexibility, Simplicity, Craft, Delight (see `doctrine.md`) | design-principles | stable |
