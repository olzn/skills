<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: layout, tab-bars, toolbars, sheets, buttons, search-fields, lists-and-tables, typography -->

# Component metrics (provenance-marked)

**Apple publishes almost none of these numbers.** The HIG stopped publishing iOS bar metrics; these values are runtime-measured (RT) from iOS 26.2 simulator / macOS Tahoe 26.5.1, or community-measured (CM). They are engineering-truth for "what the system renders", not HIG normative values — present them with provenance, never as "the HIG says". Full method + re-measurement workflows: `docs/research/hig/_metrics.md` in the source repo (§12). Re-measure after iOS 27 GA (~Sept 2026).

Units: pt. In HTML prototypes 1pt = 1 CSS px (use 402×874 iPhone 17 / 440×956 17 Pro Max viewports).

## Stale prior → iOS 26 reality (the trap table)

| Component | Your stale prior | iOS 26 measured | Provenance |
|---|---|---|---|
| Navigation bar | 44pt opaque bar | **54pt** title row, no opaque fill — scroll-edge effect instead | RT high |
| Large-title nav | 96.5pt | **106pt** (54 + 52 large-title row; 34pt bold, 16pt leading) | RT high |
| Tab bar | 49pt full-width docked | **floating capsule 62pt tall**, 21pt inset from sides + bottom, radius 31, hugs content width | RT+CM high |
| Bottom toolbar | 44pt strip | **no bar** — individual glass platters **48pt** tall (48×48 circles / capsules), ~28pt from edges | RT high |
| Top bar buttons | borderless 44pt text | **44×44pt circular glass platters**, 16pt from edge | RT high |
| Inset-grouped list radius | 10pt | **26pt** fixed | RT high |
| List row (1-line) | 44pt | **53pt** (2-line 73pt; section header 38pt; section side inset 20pt) | RT high |
| Sheet corners | ~10–12pt | **top 38pt; bottom concentric with display** (62pt full-bleed; ~56pt at floating medium detent, 8pt margins) | RT high |
| Search field | 36pt rounded rect | **44pt capsule** (radius 22) | RT med |
| UISwitch | 51×31 | **63×28** (SwiftUI Toggle 61×28) | RT med |

## Anchors and controls

| Metric | Value | Provenance |
|---|---|---|
| iPhone 17 / 17 Pro canvas | 402×874pt @3x · 17 Pro Max 440×956 · Air 420×912 | HIG (layout, 2025-09-09) |
| Display corner radius (concentricity maths) | 62pt (iPhone 17 family) | RT high |
| Safe areas portrait | top 62pt · bottom 34pt | RT high |
| Content inset under standard nav bar | 116pt (62+54) | RT high |
| System layout margins | 16pt (402pt-wide) · 20pt (440pt-wide) | RT high |
| Button heights (all styles, default type) | mini/small 28 · regular 34 · large/XL 50 — capsule-shaped | RT high |
| Button hit region minimum | **44×44pt — HIG-normative** (buttons, 2025-12-16) | HIG |
| Segmented control 32pt · rounded-border TextField 34pt | | RT med |
| Tab bar labels | ~11pt (12pt box) | RT+CM med |
| Sheet grabber | 36×5pt, radius 2.5 | RT high |
| macOS push button (mini→XL) | 16 / 20 / **24** / 28 / 36 · text/search/popup/segmented all 24 · NSSwitch 54×24 · table row 24 · title bar 32 | RT high |

## Traps

- The Buttons page size table (Mini 28/Small 32/Regular 44/Large 52/XL 64) is **visionOS-only** — plausible-looking, wrong for iOS. The tab-bars 68pt figure is **tvOS-only**. <!-- src: buttons, tab-bars -->
- `UITabBar.frame` still reports full-width×83pt — trust the platter view, not the frame. <!-- src: tab-bars -->
- Toolbars rule (HIG-normative): child corner radii must be **concentric** with bar corners (child radius = parent radius − inset). <!-- src: toolbars -->

## No reliable number exists — measure, don't guess

Minimized (scrolled) tab bar dims · tab-bar accessory (MiniPlayer) · toolbar inter-group spacing >2 groups · iPad bar coexistence metrics · macOS Tahoe toolbar capsule padding · glass blur/refraction parameters. Measurement workflows (simulator script ≈10 min; Apple Figma kit 1527721578857867021 duplicated + Figma MCP; AppKit fittingSize script): `docs/research/hig/_metrics.md` §12.
