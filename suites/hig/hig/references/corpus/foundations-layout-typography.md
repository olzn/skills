<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: layout, typography -->

# Foundations — layout & typography

## layout
<!-- src: layout · changed: 2025-09-09 · platforms: iOS, iPadOS, macOS · speed: full -->

**Layer model — the load-bearing correction.** Content fills the screen or window edge to edge; controls and navigation (tab bars, toolbars, sidebars) are floating Liquid Glass elements on a separate functional layer above it. Content must scroll beneath bars — never stop above a tab bar or beside a sidebar. The transition between content and the control area is a **scroll edge effect**, never an opaque bar background. Where content doesn't span the window, use a background extension view (`backgroundExtensionEffect()` / `UIBackgroundExtensionView`) to fill behind sidebars and inspectors.
- Was: content sandwiched between opaque navigation and tab bars. → Now: edge-to-edge content under floating glass; scroll edge effects replace bar backgrounds (since 2025-06-09).

**Rules.**
- Group with negative space, background shapes, colour, materials, separators; keep content and controls clearly distinct; give controls breathing room.
- Place important items top and leading (flips under RTL); align sibling elements; indentation + alignment express hierarchy; progressive disclosure for the rest.
- Adapt to: screen sizes, orientations, Dynamic Island and camera controls, external displays, Display Zoom, resizable iPad windows, Dynamic Type changes, locale (RTL, text length). Respect safe areas, layout guides, margins.
- Test the largest and smallest layouts first; scale artwork when adapting, never change its aspect ratio.
- Keep text within the readability-constrained width from the predefined layout guides.

**iOS.**
- **Avoid full-width buttons** — inset from screen edges within system margins; any full-width control must harmonise with hardware corner curvature and safe areas. (Post-2025 rule; edge-to-edge pill CTAs are a stale pattern.)
- Support both orientations where possible (landscape-only must work in both rotations); games prefer full-bleed; hide the status bar only for immersive experiences.
- Size classes: iPhone portrait = compact width × regular height; landscape = regular × compact on Max/Plus/Air models, compact × compact on regular-size iPhones; iPad = regular × regular in both orientations.

**iPadOS.** Windows resize freely down to a minimum size. Design full-screen first and defer switching to compact layouts as long as possible; hide tertiary columns (inspectors) first as width shrinks; test at system tiling sizes (halves, thirds, quadrants); consider the convertible tab bar (`sidebarAdaptable`) that switches between tab bar and sidebar.

**macOS.** Avoid controls or critical information at the bottom of a window — people push window bottoms offscreen. Keep content out of the camera-housing area (`NSPrefersDisplaySafeAreaCompatibilityMode`). Free window resizing is the default condition; no size classes.

**Device dimensions (pt, portrait) — fetch, don't bake.** These values rot every September with new hardware. Verify before asserting: `scripts/hig-fetch.sh layout`. Snapshot of 2026-06-10:

| Device | Points | Scale |
|---|---|---|
| iPhone 17 Pro Max | 440×956 | @3x |
| iPhone 17 Pro / iPhone 17 (default flagship canvas) | 402×874 | @3x |
| iPhone Air | 420×912 | @3x |
| iPhone 16 | 393×852 | @3x |
| iPhone 16e | 390×844 | @3x |
| iPhone SE (4.7″) | 375×667 | @2x |
| iPad Pro 13″ | 1032×1376 | @2x |
| iPad Pro 11″ | 834×1210 | @2x |
| iPad Air 11″ | 820×1180 | @2x |
| iPad mini 8.3″ | 744×1133 | @2x |

UIKit scale ≠ native scale on some devices; the full table lives on the layout page.

**Reviewer checks.**
- Content area stops at a bar edge (hard edge above a tab bar / beside a sidebar) instead of extending beneath the glass layer → flag.
- Opaque rectangular bar backgrounds instead of scroll edge effects → flag.
- iOS: buttons spanning full screen width; controls inside Dynamic Island / status-bar / home-indicator safe areas; 375×667-era artboards (default canvas is 402×874).
- macOS: primary actions or status information pinned to the window's bottom edge.
- Text blocks wider than the readable-width guide; misaligned siblings; layout breaks at compact width, landscape, or largest Dynamic Type.

**Stale priors.**
- Was: bar-height/margin tables on this page. → Now: navigation-bar layout folded into the Toolbars component page; don't cite 44 pt nav-bar / 49 pt tab-bar heights as HIG-published (since 2025-06-09).
- This page no longer publishes a minimum tap-target size — the 44×44 pt rule lives on the Accessibility and Buttons pages (see foundations-people.md#accessibility).
- The iPhone 17 family and iPhone Air (420×912) post-date most model knowledge; 393×852 / 390×844 are no longer the flagship default.

## typography
<!-- src: typography · changed: 2025-12-16 · platforms: iOS, iPadOS, macOS · speed: full -->

**Minima.** Default / minimum text sizes: iOS and iPadOS **17 pt / 11 pt**; macOS **13 pt / 10 pt** <!-- src: tables/accessibility-sizes.md -->. Thin custom fonts need larger sizes. Prefer Regular, Medium, Semibold, Bold; avoid Ultralight, Thin, Light. Minimise the number of typefaces; build hierarchy with weight, size, colour.

**System fonts.** San Francisco family (SF Pro, SF Compact, SF Mono, script variants; rounded cuts) plus New York, the companion serif. Both ship as variable fonts with **dynamic optical sizes** — continuous interpolation. Never embed system fonts; access via API (`Font.Design.default`, `.serif` → NY). NY is native on iOS, Mac Catalyst-only on macOS.
- Was: "SF Pro Text vs SF Pro Display, switch at 20 pt". → Now: dynamic optical sizes interpolate continuously; discrete cuts only for tools without variable-font support.

**Text styles — iOS/iPadOS at Large (the default Dynamic Type size).** Full 12-step ramp (xSmall→xxxLarge + AX1–AX5) and tracking tables: `tables/dynamic-type.md`. Headline values, copied from that table: <!-- src: tables/dynamic-type.md -->

| Style | Size/Leading (pt) | Weight (emphasized) |
|---|---|---|
| Large Title | 34/41 | Regular (Bold) |
| Title 1 | 28/34 | Regular (Bold) |
| Title 2 | 22/28 | Regular (Bold) |
| Title 3 | 20/25 | Regular (Semibold) |
| Headline | 17/22 | Semibold (Semibold) |
| Body | 17/22 | Regular (Semibold) |
| Callout | 16/21 | Regular (Semibold) |
| Subhead | 15/20 | Regular (Semibold) |
| Footnote | 13/18 | Regular (Semibold) |
| Caption 1 | 12/16 | Regular (Semibold) |
| Caption 2 | 11/13 | Regular (Semibold) |

Body across the 12 steps: 14, 15, 16, **17 (Large, default)**, 19, 21, 23; AX1–AX5 = 28, 33, 40, 47, **53**. Point sizes assume 144 ppi @2x / 216 ppi @3x mockups. <!-- src: tables/dynamic-type.md -->

**macOS built-in text styles (fixed — macOS has no Dynamic Type).** <!-- src: tables/dynamic-type.md -->

| Style | Size/Line height (pt) | Weight (emphasized) |
|---|---|---|
| Large Title | 26/32 | Regular (Bold) |
| Title 1 | 22/26 | Regular (Bold) |
| Title 2 | 17/22 | Regular (Bold) |
| Title 3 | 15/20 | Regular (Semibold) |
| Headline | 13/16 | Bold (Heavy) |
| Body | 13/16 | Regular (Semibold) |
| Callout | 12/15 | Regular (Semibold) |
| Subheadline | 11/14 | Regular (Semibold) |
| Footnote | 10/13 | Regular (Semibold) |
| Caption 1 | 10/13 | Regular (Medium) |
| Caption 2 | 10/13 | Medium (Semibold) |

**Dynamic Type rules (iOS/iPadOS).**
- Layouts must adapt to all sizes including the Larger Accessibility Text Sizes; Body at AX5 is 53 pt — 3.1× the default.
- Minimise truncation: show as much text at the largest accessibility size as at the largest standard size; allow multi-line labels (`numberOfLines`).
- At AX sizes switch inline layouts to stacked layouts and reduce column counts (`isAccessibilityCategory`); keep hierarchy positions stable.
- Meaningful interface icons grow with text (SF Symbols do automatically).
- Scale the content people care about — tab titles or game hit-damage numbers may stay fixed.
- Leading is a specified point value, not a ratio — don't substitute web-style 1.5 line-height.
- Use built-in text styles for Dynamic Type support; modify via symbolic traits (bold trait; loose/tight leading — avoid tight leading on 3+ lines).

**Custom fonts.** Must be legible at the platform minima and respond to Dynamic Type and the Bold Text accessibility setting. Recommended split: custom font for headlines, system font for body and captions.

**Tracking.** Running apps auto-track per point size; mockups need manual tracking from the page's tables (SF Pro: +6/1000 em at 11 pt, 0 at 12 pt, −26 at 17 pt, decaying to ~0 by 80 pt; SF Pro Rounded looser, +22 at 17 pt; NY negative from 16 pt). Full 65-row tables: fetch the typography slug.

**iOS vs macOS.**
- Dynamic Type exists on iOS/iPadOS only; macOS text styles are fixed point sizes (the dynamic system-font variant APIs — `menuFont`, `menuBarFont`, `titleBarFont`, `toolTipsFont`, `userFont` etc. — match control text instead).
- Body: 17 pt vs 13 pt. Headline: iOS Semibold 17; macOS **Bold 13**, emphasizing to Heavy — the only Heavy in the system.
- The macOS ramp bottoms out by weight, not size (Footnote, Caption 1, Caption 2 all 10 pt; Caption 2 base weight Medium).
- Style naming: Subhead (iOS) vs Subheadline (macOS); column naming: Leading (iOS) vs Line height (macOS).
- 17 pt body in a macOS window is the telltale of an unported iOS design.

**Reviewer checks.**
- Any text below 11 pt (iOS) / 10 pt (macOS); body text deviating from 17 pt (iOS) / 13 pt (macOS) without rationale.
- Ultralight/Thin/Light weights, especially at small sizes; more than two typeface families; tight leading on 3+ lines.
- Ramp deviating from the text-style tables without rationale (e.g. 15 pt "body" on iOS).
- iOS design lacking a larger-text variant: does the layout stack at AX sizes? labels multi-line? icons scale with text? truncation at large sizes?
- HTML/Figma: SF Pro silently substituted by another sans; tracking left at 0 where the tables require adjustment (visible at 17 pt body and display sizes).

**Stale priors.**
- Was: emphasis = "make it bold". → Now: emphasized weight is style-specific — Bold for titles, Semibold for body/captions on iOS, Heavy for macOS Headline (since 2025-12-16).
- Was: Dynamic Type tables on the Accessibility page. → Now: moved to typography — cite that slug (since 2025-03-07).
- The Large-default values themselves are long-stable — memorised numbers are mostly right here; the additions are the emphasized-weight column and the table reorganisation.
