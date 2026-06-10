<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: boxes, collections, column-views, disclosure-controls, labels, lists-and-tables, outline-views, split-views, tab-views, charts, image-views, text-views, web-views -->

# Components — layout, organisation, and content

## boxes
<!-- src: boxes · changed: stable (pre-2025) · platforms: iOS, iPadOS, macOS, visionOS · speed: stub -->
Visually distinct group of related content. SwiftUI `GroupBox`, AppKit `NSBox`.
- Keep a box small relative to its containing view; never nest boxes — use padding and alignment for subgroups.
- Title optional: brief phrase, sentence-style capitalisation, no ending punctuation — except macOS settings panes, where the title takes a trailing colon.
- iOS groups via secondary/tertiary system background colours, not borders; a macOS-style bordered box with title above is a platform-idiom flag in an iOS mock.
Fetch for detail: boxes

## collections
<!-- src: collections · changed: stable (pre-2025) · platforms: iOS, iPadOS, macOS, tvOS, visionOS · speed: stub -->
`UICollectionView` / `NSCollectionView` — ordered, highly visual (ideally image-based) content in a row or grid.
- Use the standard row or grid layout whenever possible; predominantly textual cells belong in a list or table instead.
- Pad items so focus/hover effects stay visible and content never touches.
- iOS/iPadOS only: don't change the layout mid-viewing except in response to an explicit user action.
Fetch for detail: collections

## column-views
<!-- src: column-views · changed: stable (pre-2025) · platforms: macOS only · speed: stub -->
macOS-only (`NSBrowser`; Finder column view). iOS replacement: navigation stack on iPhone, split view on iPad — Miller-columns UI in an iOS design is non-native.
- Use for a deep hierarchy with frequent back-and-forth between levels when column sorting isn't needed (tables sort; column views don't). Not deprecated.
- Show the hierarchy's root in the first column; let people resize columns; consider a preview/info pane for a selected leaf item.
Fetch for detail: column-views

## disclosure-controls
<!-- src: disclosure-controls · changed: stable (pre-2025) · platforms: iOS, iPadOS, macOS, visionOS · speed: stub -->
Disclosure triangles show/hide a view or hierarchy; disclosure buttons show/hide functionality for one control (the macOS Save sheet expander). SwiftUI `DisclosureGroup` brings both to iOS/iPadOS — not macOS-only.
- Orientation is leading-edge-relative (RTL-aware): triangle points inward from the leading edge when collapsed, down when expanded. Button points down when collapsed, up when expanded.
- Maximum ONE disclosure button per view; place it near the content it reveals; give triangles a descriptive label ("Advanced Options").
- Most-used controls stay visible at the top of the disclosure hierarchy; advanced options hide by default — flag the inverted case.
Fetch for detail: disclosure-controls

## labels
<!-- src: labels · changed: stable (pre-2025) · platforms: all · speed: stub -->
Static, often copyable, never editable text. Small editable text → text field; long text → text view.
- Express text-importance hierarchy with the FOUR semantic label colours, never hardcoded greys: `label` / `secondaryLabel` / `tertiaryLabel` / `quaternaryLabel` (macOS: the `labelColor` family) = primary / supplemental / unavailable-item text / watermark. Hardcoded greys break Dark Mode and vibrancy on Liquid Glass materials.
- Prefer system fonts (Dynamic Type comes free); make useful text selectable (error messages, serial numbers, IP addresses).
Fetch for detail: labels

## lists-and-tables
<!-- src: lists-and-tables · changed: 2023 (stable) · platforms: all · speed: stub -->
- High-value check (models persistently get this wrong): an ⓘ button in a row is a detail disclosure button — it reveals more about the row ONLY and never navigates. Drill-down requires the chevron disclosure indicator.
- Never combine an A–Z index with trailing-edge row controls — they collide.
- Selection feedback by purpose: navigation lists keep the selected row persistently highlighted (critical in split views); option-picker lists highlight briefly then show a checkmark.
- iOS/iPadOS: grouped style; people enter an edit mode before selecting rows to edit. macOS: bordered style, clickable column-heading sort (re-click reverses), resizable columns, alternating row colours for large tables; hierarchical data → outline view, not a table.
- Column headings: nouns or short noun phrases, title-style capitalisation, no ending punctuation. A middle (centred) ellipsis can beat end-truncation.
- iOS 26 visuals shifted around this stable page: grouped lists now scroll edge-to-edge under floating glass bars with larger continuous corners — don't draw hard-edged iOS-12-style flat tables.
Fetch for detail: lists-and-tables

## outline-views
<!-- src: outline-views · changed: stable (pre-2025) · platforms: macOS only · speed: stub -->
macOS-only (`NSOutlineView`). iOS replacement: lists (SwiftUI `OutlineGroup`/`children:`), split views, or navigation — there is no iOS outline-view page.
- Hierarchy lives in the FIRST column only; other columns hold attributes. Flat data → table instead.
- Multicolumn outlines always need headings (title-style nouns, no punctuation); sortable headings sort at each hierarchy level; let people resize columns.
- Honour Option-click to expand all subfolders; persist expansion state across sessions — a prototype that resets it is a flag.
Fetch for detail: outline-views

## split-views
<!-- src: split-views · changed: 2025-06-09 · platforms: all · speed: full -->
`NavigationSplitView` / `UISplitViewController` / `NSSplitViewController`. Manages adjacent panes, typically several hierarchy levels at once (sidebar → content → detail); selection in one pane drives the next.

Normative rules
- Persistently highlight the current selection in every pane that leads to the detail view.
- Consider drag and drop between panes for cross-hierarchy moves.
- iOS: prefer split views in a regular — not compact — width environment; in compact widths panes wrap, truncate, and become illegible. The system collapses to a navigation stack in compact.
- iPadOS: two or three vertical panes (Mail = 2, Keynote = 3). iPadOS 26 windows resize fluidly — navigation must stay logical at narrow, compact, and intermediate widths, not three snap points.
- macOS: a free-form pane manager — panes arrange vertically, horizontally, or both; dividers drag to resize; size limits and divider affordances are the designer's job.
  - Set reasonable minimum and maximum pane sizes so the divider never seems to vanish.
  - Consider letting people hide panes — and provide MULTIPLE ways to reveal a hidden pane (toolbar button AND menu command with keyboard shortcut).
  - Prefer the thin divider style: exactly 1 pt wide (`NSSplitView.DividerStyle`). Thicker only with a specific reason.

Reviewer checks
- iPhone-portrait mock with side-by-side panes → flag.
- Master–detail without persistent source-row highlight (iPad/macOS) → flag.
- macOS panes lacking min/max sizes, or able to collapse the divider away → flag.
- Hidden pane restorable by only one path (want toolbar + menu + shortcut) · divider over 1 pt unjustified → flag.
- iPad layout that breaks at intermediate window widths → flag.

Stale-prior corrections
- Was: iPad multitasking = fixed Split View/Slide Over snap points. → Now: iPadOS 26 windows resize fluidly like macOS; design for continuous width change. (since 2025-06-09)
- Was: sidebars are opaque full-height columns flush to the display edge. → Now: iOS/iPadOS 26 sidebars float as Liquid Glass panes, content scrolling beneath (treatment on sidebars/materials pages). (since 2025-06-09)
- The iOS/iPadOS considerations are new text — "prefer regular, not compact" is now explicit HIG.

## tab-views
<!-- src: tab-views · changed: stable (pre-2025) · platforms: macOS (and watchOS) only · speed: stub -->
macOS-only enclosed-pane component (`NSTabView`) — NOT the iOS bottom tab bar. iOS replacement: a segmented control for switching mutually exclusive panes in place; iOS bottom navigation is a tab bar (separate page, separate rules).
- Naming trap: SwiftUI `TabView` renders this component on macOS but a tab BAR on iOS — disambiguate by platform, never by API name.
- Avoid more than SIX tabs; beyond that switch to e.g. a pop-up-button view chooser (otherwise never use a pop-up button to switch panes — one click beats two).
- Tab labels: nouns or short noun phrases, title-style capitalisation. Controls in a pane affect that pane only.
- Inset the tab view with a margin of window body on all sides; edge-to-edge is "unusual".
Fetch for detail: tab-views

## charts
<!-- src: charts · changed: 2022-09 (stable) · platforms: all (platform-uniform) · speed: full -->
Swift Charts is the canonical stack — not Core Plot, not custom CALayer drawing. The charting-data pattern page covers when/where; this covers construction. Apple's anatomy vocabulary: mark (bar, line, point), plot area, scale, axis, ticks, grid lines, legend.

Marks
- Choose by message: bars compare categories / part-to-whole / sums over time; lines show change over time (slope = magnitude); points show individual values, relationships, outliers, clusters. Combine types when it clarifies (points on a line).

Axes
- Fixed range when min/max are intrinsically meaningful (battery 0–100%); dynamic when values vary widely and marks should fill the plot area.
- Bar charts generally need a ZERO lower bound — height comparison only works from zero. Line charts may take a nonzero lower bound when differences live far from zero (heart rate).
- Familiar tick sequences only: 0, 5, 10 — never 1, 6, 11. Tune grid-line density to the use case; interactive charts can run fewer grid lines and lighter labels.

Descriptive content and behaviour
- Summarise the main message in the title/subtitle — never make people derive the takeaway. Data most prominent; descriptions and axes recede.
- Compact widths: maximise plot-area width — shortest Y-axis labels, units in the title; long category labels may sit inside the plot area if they don't obscure data.
- Never gate critical information behind interaction; interaction reveals additional detail only.
- Marks too small to hit → expand the hit target to the whole plot area; let people scrub to reveal values.
- Keyboard/Switch Control: a logical focus path (e.g. along the X axis); large datasets move focus among subsets, not every point.
- Animate mark/axis changes AND announce them non-visually (UIKit/AppKit accessibility notifications).
- Align the chart's leading edge with surrounding views (grid-line labels on their trailing side; Y axis moved to the trailing side).

Colour
- Never rely on colour alone to differentiate series — add shapes or patterns; separate contiguous coloured areas (separators between stacked-bar segments).

Accessibility (chart-specific)
- Swift Charts supplies a default Audio Graphs implementation and a default accessibility element per mark/group; customise with a chart title and descriptive summary.
- Label each important/interactive element, not one image-style label; choose per-mark vs per-group by chart purpose.
- Label writing: include context (date/location); no subjective terms (rapidly, almost); no ambiguous formats ("June 6" not "6/6", "60 minutes" not "60m"); describe what data represents, never its appearance (no colours); consistent axis order.
- Hide visible axis/tick labels from assistive technologies — VoiceOver gets values via accessibility labels and Audio Graphs.

iOS vs macOS — none ("No additional considerations"); compact-width rules apply equally to iPhone and narrow Mac windows.

Reviewer checks
- Nonzero-baseline bar chart (heights lie) · zero-forced line chart that flattens variation → flag.
- Hue-only series differentiation · stacked bars without segment separators → flag.
- Unfamiliar tick interval · missing message-summarising title · critical value only on hover/drag → flag.
- Long Y labels or per-tick units in compact widths · misaligned leading edge · tiny marks without a plot-area scrub target → flag.

## image-views
<!-- src: image-views · changed: stable (pre-2025) · platforms: all · speed: stub -->
- An image view is typically NOT interactive. Tappable/clickable image → a system button displaying the image; editable image on macOS → an image well; never bolt behaviours onto a bare image view.
- Interface glyphs: prefer an SF Symbol or template icon over a bitmap (vector, recolourable, takes the accent colour).
- Text over images needs contrast work — shadow, scrim, or background layer behind the text.
- Animated sequences: one consistent, prescaled image size (avoids per-frame system scaling).
Fetch for detail: image-views

## text-views
<!-- src: text-views · changed: stable (pre-2025) · platforms: all · speed: stub -->
- Choice rule: text view = long, editable, or specially formatted text. Small + uneditable → label; small + editable → text field.
- Adopt Dynamic Type; no fixed font sizes on body text; test with accessibility settings (bold text).
- iOS/iPadOS: match the keyboard type to the content — a generic keyboard for emails/numbers/URLs is a flag. No macOS equivalent.
- Make useful text selectable (errors, serial numbers, IP addresses).
Fetch for detail: text-views

## web-views
<!-- src: web-views · changed: stable (pre-2025) · platforms: iOS, iPadOS, macOS, visionOS · speed: stub -->
`WKWebView` embeds web content in-app (e.g. Mail rendering HTML messages). Guidance is platform-uniform.
- Back/forward behaviours are OFF by default — if people will visit multiple pages, enable them and provide controls.
- Avoid building a browser: brief in-context web access is fine; replicating Safari (address bar, tabs) is "unnecessary and discouraged", and the page notes it as an App Review consideration.
- A native SwiftUI `WebView` shipped in iOS 26/macOS 26; the HIG page still names only WKWebView — guidance unchanged.
Fetch for detail: web-views
