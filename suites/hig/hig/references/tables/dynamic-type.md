<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: typography -->

# Dynamic Type — full ramp (authoritative copy)

All values HIG-published (typography page; last change 2025-12-16, which added emphasized weights; untouched in the 2026-06-08 drop). Captured 2026-06-10 via the JSON API. Confidence: high. Other files inline subsets of these numbers marked `<!-- src: tables/dynamic-type.md -->`; this file is the source of truth.

- 11 text styles × 12 size steps: 7 standard (xSmall → xxxLarge; **Large is the default**) + 5 accessibility (AX1 → AX5).
- **Subhead** is the iOS/iPadOS name; macOS names the style **Subheadline**.
- **Emphasized weight** = the weight a style takes under symbolic traits: SwiftUI `bold()`, UIKit `traitBold` in `UIFontDescriptor`.
- **macOS does not support Dynamic Type** — it has one fixed text-styles table plus dynamic system-font variants (both below). SF Pro is the system font on iOS, iPadOS and macOS.
- iOS tables' footnote: "Point size based on image resolution of 144 ppi for @2x and 216 ppi for @3x designs."
- Tracking (letter-spacing) tables also exist on the typography page (65 rows per font) — not duplicated here; fetch slug `typography` if needed. Refresh note: in the JSON, the size tables live inside `tabNavigator` nodes (one tab per step), not plain `table` nodes — walk `tabs[].content`.
<!-- src: typography -->

## ios-dynamic-type-weights

Weights are constant across all 12 steps; only size and leading change.

| Style | Weight | Emphasized weight |
|---|---|---|
| Large Title | Regular | Bold |
| Title 1 | Regular | Bold |
| Title 2 | Regular | Bold |
| Title 3 | Regular | Semibold |
| Headline | Semibold | Semibold |
| Body | Regular | Semibold |
| Callout | Regular | Semibold |
| Subhead | Regular | Semibold |
| Footnote | Regular | Semibold |
| Caption 1 | Regular | Semibold |
| Caption 2 | Regular | Semibold |
<!-- src: typography -->

## ios-dynamic-type-standard

Cells are size/leading in pt. Leading is Apple-specified, not a ratio — never substitute a web-style 1.5 line-height.

| Style | xSmall | Small | Medium | Large (default) | xLarge | xxLarge | xxxLarge |
|---|---|---|---|---|---|---|---|
| Large Title | 31/38 | 32/39 | 33/40 | 34/41 | 36/43 | 38/46 | 40/48 |
| Title 1 | 25/31 | 26/32 | 27/33 | 28/34 | 30/37 | 32/39 | 34/41 |
| Title 2 | 19/24 | 20/25 | 21/26 | 22/28 | 24/30 | 26/32 | 28/34 |
| Title 3 | 17/22 | 18/23 | 19/24 | 20/25 | 22/28 | 24/30 | 26/32 |
| Headline | 14/19 | 15/20 | 16/21 | 17/22 | 19/24 | 21/26 | 23/29 |
| Body | 14/19 | 15/20 | 16/21 | 17/22 | 19/24 | 21/26 | 23/29 |
| Callout | 13/18 | 14/19 | 15/20 | 16/21 | 18/23 | 20/25 | 22/28 |
| Subhead | 12/16 | 13/18 | 14/19 | 15/20 | 17/22 | 19/24 | 21/28 |
| Footnote | 12/16 | 12/16 | 12/16 | 13/18 | 15/20 | 17/22 | 19/24 |
| Caption 1 | 11/13 | 11/13 | 11/13 | 12/16 | 14/19 | 16/21 | 18/23 |
| Caption 2 | 11/13 | 11/13 | 11/13 | 11/13 | 13/18 | 15/20 | 17/22 |
<!-- src: typography -->

## ios-dynamic-type-accessibility

Larger accessibility sizes (AX1 → AX5), size/leading in pt.

| Style | AX1 | AX2 | AX3 | AX4 | AX5 |
|---|---|---|---|---|---|
| Large Title | 44/52 | 48/57 | 52/61 | 56/66 | 60/70 |
| Title 1 | 38/46 | 43/51 | 48/57 | 53/62 | 58/68 |
| Title 2 | 34/41 | 39/47 | 44/52 | 50/59 | 56/66 |
| Title 3 | 31/38 | 37/44 | 43/51 | 49/58 | 55/65 |
| Headline | 28/34 | 33/40 | 40/48 | 47/56 | 53/62 |
| Body | 28/34 | 33/40 | 40/48 | 47/56 | 53/62 |
| Callout | 26/32 | 32/39 | 38/46 | 44/52 | 51/60 |
| Subhead | 25/31 | 30/37 | 36/43 | 42/50 | 49/58 |
| Footnote | 23/29 | 27/33 | 33/40 | 38/46 | 44/52 |
| Caption 1 | 22/28 | 26/32 | 32/39 | 37/44 | 43/51 |
| Caption 2 | 20/25 | 24/30 | 29/35 | 34/41 | 40/48 |
<!-- src: typography -->

## macos-text-styles

Fixed — no Dynamic Type on macOS. Apple's column is "Line height" here (iOS says "Leading"). Footnote: "Point size based on image resolution of 144 ppi for @2x designs."

| Text style | Weight | Size (pt) | Line height (pt) | Emphasized weight |
|---|---|---|---|---|
| Large Title | Regular | 26 | 32 | Bold |
| Title 1 | Regular | 22 | 26 | Bold |
| Title 2 | Regular | 17 | 22 | Bold |
| Title 3 | Regular | 15 | 20 | Semibold |
| Headline | Bold | 13 | 16 | Heavy |
| Body | Regular | 13 | 16 | Semibold |
| Callout | Regular | 12 | 15 | Semibold |
| Subheadline | Regular | 11 | 14 | Semibold |
| Footnote | Regular | 10 | 13 | Semibold |
| Caption 1 | Regular | 10 | 13 | Medium |
| Caption 2 | Medium | 10 | 13 | Semibold |
<!-- src: typography -->

## macos-dynamic-font-variants

Match text in standard controls with these instead of hard-coding.

| Dynamic font variant | API |
|---|---|
| Control content | `controlContentFont(ofSize:)` |
| Label | `labelFont(ofSize:)` |
| Menu | `menuFont(ofSize:)` |
| Menu bar | `menuBarFont(ofSize:)` |
| Message | `messageFont(ofSize:)` |
| Palette | `paletteFont(ofSize:)` |
| Title | `titleBarFont(ofSize:)` |
| Tool tips | `toolTipsFont(ofSize:)` |
| Document text (user) | `userFont(ofSize:)` |
| Monospaced document text (user fixed pitch) | `userFixedPitchFont(ofSize:)` |
| Bold system font | `boldSystemFont(ofSize:)` |
| System font | `systemFont(ofSize:)` |
<!-- src: typography -->

## reviewer-checks

- Body at Large (default) = **17/22** — fixed body text below 17 pt is the canonical iOS violation. Caption 2 (11 pt) is the smallest sanctioned default size.
- Layouts must survive AX5, where Body = 53 pt (3.1× the default).
- iOS Headline = Body size in Semibold; on macOS Headline is Bold 13 with Heavy emphasized — the only Heavy in the system.
- macOS deltas: Body is 13 pt (never apply the iOS 17 pt rule to Mac apps); Large Title is 26 pt, not 34; Caption 1 emphasizes to Medium; Caption 2's base weight is Medium; style name is Subheadline, not Subhead.
<!-- src: typography -->
