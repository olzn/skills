<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: accessibility, pointing-devices, buttons, typography -->

# Accessibility sizes and ratios (authoritative copy)

The numeric backbone: targets, padding, type minima, contrast, text scaling. All values HIG-published; captured 2026-06-10. Primary page: accessibility (rewritten 2025-03-07; last change 2025-06-09; untouched in the 2026-06-08 drop). Other files inline subsets marked `<!-- src: tables/accessibility-sizes.md -->`; this file is the source of truth.

## control-targets

| Platform | Default control size | Minimum control size | Provenance |
|---|---|---|---|
| iOS, iPadOS | **44×44 pt** | **28×28 pt** | HIG accessibility 2025-06-09 |
| macOS | **28×28 pt** | **20×20 pt** | HIG accessibility 2025-06-09 |

Design to the default; below the minimum is a HIG violation. The Buttons page independently requires a hit region of at least **44×44 pt for buttons** (HIG buttons 2025-12-16) — for buttons specifically, 44×44 is the floor on iOS. <!-- src: accessibility, buttons -->

## hit-region-padding

| Element type | Clearance | Provenance |
|---|---|---|
| Bezeled (visible background) | ~**12 pt** around | HIG accessibility + pointing-devices |
| Bezel-less | ~**24 pt** around the visible edges | HIG accessibility + pointing-devices |

Spacing is as important as size — the same numbers appear on both pages. Adjacent bar buttons need contiguous hit regions (dead gaps make the iPadOS pointer flicker between buttons). <!-- src: accessibility, pointing-devices -->

## type-minima

For custom type styles; system text styles handle this for you.

| Platform | Default size | Minimum size | Provenance |
|---|---|---|---|
| iOS, iPadOS | **17 pt** | **11 pt** | HIG accessibility 2025-06-09 |
| macOS | **13 pt** | **10 pt** | HIG accessibility 2025-06-09 |

Thin-weight custom fonts: go larger than these. (tvOS/visionOS/watchOS values exist on the page; out of suite scope.) <!-- src: accessibility -->

## contrast-ratios

WCAG Level AA, as applied by Apple's Accessibility Inspector. APCA is named alongside WCAG as an accepted measure.

| Text size | Text weight | Minimum contrast ratio | Provenance |
|---|---|---|---|
| Up to 17 pt | All | **4.5:1** | HIG accessibility 2025-06-09 |
| 18 pt and up | All | **3:1** | HIG accessibility 2025-06-09 |
| All sizes | Bold | **3:1** | HIG accessibility 2025-06-09 |

If the app can't meet contrast by default, it must provide a higher-contrast scheme when the system **Increase Contrast** setting is on. If it supports Dark Mode, check contrast in **both** appearances. Prefer system-defined colors — they carry built-in accessible variants. Liquid Glass context: translucent materials demand contrast checks over varied content in both appearances, and Reduce Transparency/Increase Contrast swap materials for opaque variants — the design must not break when that happens. <!-- src: accessibility -->

## text-scaling

Support text enlargement of at least **200%** (watchOS: 140%), via Dynamic Type or custom UI. Text containers must survive 200% scaling without truncation. At AX5, Body = 53 pt — 3.1× the 17 pt default. Full ramp: `tables/dynamic-type.md`. <!-- src: accessibility, typography -->

## reviewer-thresholds

- iOS: flag interactive elements < 44×44 pt; hard-fail < 28×28. macOS: flag < 28×28; hard-fail < 20×20.
- Flag bezeled controls with < 12 pt clearance; bezel-less with < 24 pt from visible edges.
- Text below 11 pt (iOS) / 10 pt (macOS) = violation; below 17/13 = warn for primary content.
- Contrast-check every text/background and icon/background pair (4.5:1 up to 17 pt; 3:1 at 18 pt+ or bold); repeat in dark appearance if supported.
- Hard-coded hex where a semantic system colour exists = warn (loses Increase Contrast variants).
<!-- src: accessibility -->

## stale-prior-corrections

| You likely believe | Current guidance (since) |
|---|---|
| 44×44 pt is the single iOS rule | Default 44×44 / minimum 28×28 split (2025-03-07 rewrite) — recommend 44, but 28-pt controls are not automatic violations |
| macOS has no numeric target sizes | 28×28 default / 20×20 minimum now published (2025) |
| Dynamic Type specs live on the Accessibility page | Moved to Typography 2025-03-07; VoiceOver split into its own page |
| WCAG is the only sanctioned contrast measure | APCA now accepted alongside WCAG |
<!-- src: accessibility -->
