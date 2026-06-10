<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: widgets, live-activities, snippets -->

# System surface dimensions — widgets, Live Activities, Dynamic Island, snippets

**September-rot warning.** These tables track shipping iPhone hardware and rot every September: widget dimensions were corrected as recently as 2025-01-17; the Dynamic Island device list spans iPhone 14 Pro → 17 Pro Max incl. iPhone Air. New hardware (next expected 2026-09) adds screen classes absent from this snapshot. Past expiry (see `versions.md`), fetch before quoting: `scripts/hig-fetch.sh widgets` · `scripts/hig-fetch.sh live-activities`. **Never interpolate sizes for a screen class not listed.** <!-- src: widgets, live-activities -->

Units: pt. Values HIG-published (widgets 2025-12-16; live-activities 2025-12-16; snippets 2026-06-08).

## Widget families per device class
| Device | System family (small/medium/large/XL) | Accessory family | Other contexts |
|---|---|---|---|
| iPhone | small/medium/large — Home Screen + Today View | circular/rectangular/inline — Lock Screen (inline above clock, others below) | small also in StandBy + CarPlay |
| iPad | all four — Home Screen + Today View | small on Lock Screen | — |
| Mac | all four — desktop + Notification Center | none | vibrant/desaturated treatment when not in focus; no StandBy, no tinted/accented Home treatment |
<!-- src: widgets -->

## iOS widget sizes (portrait) — rows captured in this snapshot
| Screen (pt) | Small | Medium | Large | Circular | Rectangular | Inline |
|---|---|---|---|---|---|---|
| 430×932 | 170×170 | 364×170 | 364×382 | 76×76 | 172×76 | 257×26 |
| 393×852 | 158×158 | 338×158 | 338×354 | 72×72 | 160×72 | 234×26 |
| 375×812 | 155×155 | 329×155 | 329×345 | — | — | — |

Rows for current iPhone 17-family canvases (402×874 / 440×956 / 420×912) are NOT captured here — fetch the live page. iPad uses a canvas→device two-step scale (12.9″: small canvas 170×170 → device 160×160; XL canvas 795×378.5 → device 748×356) — fetch for the full table. macOS publishes no size table; Mac uses the same four families. <!-- src: widgets -->

## Widget layout constants
| Constant | Value |
|---|---|
| Standard margin | 16 |
| Tight-grouping margin | 11 (Lock Screen / Mac desktop use smaller system margins) |
| Minimum font size | 11pt; never rasterise text |
| Content corner radii | concentric with widget corner (ContainerRelativeShape) |
| Data-update animation | max 2 s |
| Inline accessory tap targets | exactly one |
<!-- src: widgets -->

## Live Activities / Dynamic Island
| Element | Dimensions |
|---|---|
| Dynamic Island corner radius | 44 (matches TrueDepth camera shape) |
| Compact element (leading or trailing) | 62.33×36.67 (430×932 screens) · 52.33×36.67 (393×852) |
| Minimal | width 36.67–45 × height 36.67 |
| Island total width, compact/minimal | 250 (Pro Max / Plus / Air) · 230 (regular / Pro) |
| Expanded & Lock Screen width | 408 (Max / Air) · 371 (regular) |
| Expanded & Lock Screen height | 84–160 — grow/shrink dynamically with content |
| Lock Screen standard margin | 14 |
| iPad Lock Screen | 500 × 84–160 (12.9″) · 425 × 84–160 (11″ class) |
| StandBy | minimal → tap → Lock Screen presentation scaled 2×; background auto-extended full-screen |
| macOS | menu bar only, via iPhone Mirroring — "Use the provided iOS dimensions"; no Mac-native authoring |
| CarPlay Dashboard | 240×78 · 240×100 · 170×78; test at 1920×720 / 900×1200 / 800×480; interactivity disabled |
| Animation | max 2 s; none on Always-On displays |

Concentricity rule: inner corner radius = outer radius − margin; never run content to the island edge. Compact backgrounds are not customisable (opaque black); Lock Screen background is. <!-- src: live-activities -->

## Live Activity durations
| Rule | Value |
|---|---|
| Suited to events lasting | ≤8 hours total |
| Lingers on Lock Screen / Mac menu bar / Smart Stack after end | up to 4 hours unless custom dismissal set |
| Adequate custom dismissal | 15–30 minutes in most cases |
<!-- src: live-activities -->

## Snippets (new page 2026-06-08 — no pre-WWDC26 model knows it)
| Spec | Value |
|---|---|
| Custom view max height | 400 |
| Structure | dialogue above · custom view middle · system buttons below |
| Confirmation buttons | Cancel + primary with customisable label (system default "Continue") |
| Result button | single Done |
<!-- src: snippets -->
