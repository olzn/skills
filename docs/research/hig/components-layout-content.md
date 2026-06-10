# HIG research — Components: Layout and organization + Content

> Bucket: components-layout-content. Read 2026-06-10 from Apple's JSON content API (`https://developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`).
> Pages covered (13, all iOS/macOS-relevant): boxes, collections, column-views, disclosure-controls, labels, lists-and-tables, outline-views, split-views, tab-views (Layout and organization) + charts, image-views, text-views, web-views (Content). `lockups` is tvOS-only — excluded.
> Currency: only **split-views** carries a Liquid Glass-era alert (2025-06-09, "Added iOS and iPadOS platform considerations"). All other pages in this bucket have change logs ending 2022–2023 or none — their component-level guidance survived the Liquid Glass rewrite unchanged. Liquid Glass effects on these components (floating glass sidebars/bars, content scrolling under bars, concentric corners) live on OTHER pages (Materials, Layout, Sidebars, Tab bars, Toolbars) and are flagged here only as cross-cutting corrections.

---

## Boxes

**URL:** https://developer.apple.com/design/human-interface-guidelines/boxes
**Platforms:** ios, ipados, macos, visionos (NOT tvOS/watchOS). SwiftUI `GroupBox`, AppKit `NSBox`.

**Purpose.** A box creates a visually distinct group of logically related information and components, via a visible border or background color, optionally with a title.

**Normative rules.**
- **Prefer keeping a box relatively small in comparison with its containing view.** As box size approaches window/screen size it stops communicating grouping and crowds other content.
- **Don't nest boxes to define subgroups** — use padding and alignment to communicate additional grouping within a box; nested boxes make the interface feel "busy and constrained."
- Title is optional; provide a succinct introductory title only if it clarifies contents (also helps VoiceOver users predict content).
- Title style: **brief phrase, sentence-style capitalization, no ending punctuation** — EXCEPT in a (macOS) settings pane, where you **append a colon** to the title.

**iOS vs macOS.**
- iOS/iPadOS: by default a box uses the **secondary and tertiary background colors** (`secondarySystemBackground` / `tertiarySystemBackground` family) — grouping by background fill, not border.
- macOS: by default displays the **box's title above it** (the NSBox bordered-group-box look).

**Reviewer checks.**
- Box (visually bordered/filled group) nearly as large as its window or screen → flag.
- Box inside a box → flag; suggest padding/alignment instead.
- Box title in Title Case or ending with a period → flag (sentence case, no ending punctuation; colon allowed only in settings panes).
- iOS mock using a macOS-style bordered box with title above instead of a background-filled group → platform-idiom flag.

**Stale-knowledge corrections.** None major; this page predates Liquid Glass and was not rewritten. Note iOS grouping is background-color-based (post-iOS 13 semantic background colors), not the bordered boxes older material implies.

---

## Collections

**URL:** https://developer.apple.com/design/human-interface-guidelines/collections
**Platforms:** ios, ipados, macos, tvos, visionos (NOT watchOS). `UICollectionView` / `NSCollectionView`.

**Purpose.** A collection manages an ordered set of content (ideally image-based) in a customizable, highly visual layout — horizontal row or grid by default.

**Normative rules.**
- **Use the standard row or grid layout whenever possible.** Avoid custom layouts that confuse or draw undue attention to themselves.
- **Consider a table instead of a collection for text** — scrollable lists are simpler and more efficient for textual information.
- **Make items easy to choose:** use adequate padding around images so focus/hover effects stay easy to see and content doesn't overlap.
- Default interactions: tap to select, touch and hold to edit, swipe to scroll. Custom gestures are permitted "when necessary."
- **Consider animations as feedback** for insert/delete/reorder (standard animations exist; custom allowed).

**iOS vs macOS.** macOS: no additional considerations. iOS/iPadOS only: **use caution with dynamic layout changes** — avoid changing the layout while people are viewing/interacting unless in response to an explicit user action.

**Reviewer checks.**
- Grid/collection whose cells are predominantly text → suggest list/table.
- Collection cells with images touching each other (no padding for hover/focus states) → flag.
- Bespoke non-row/non-grid layout without justification → flag.

**Stale-knowledge corrections.** None; page is stable. (Compositional layout / grids remain the norm in the Liquid Glass era.)

---

## Column views

**URL:** https://developer.apple.com/design/human-interface-guidelines/column-views
**Platforms:** **macOS only** (`NSBrowser`). Explicitly not supported in iOS/iPadOS — Apple says use a split view for hierarchical content on iPad/visionOS.

**Purpose.** A column view (a.k.a. _browser_) lets people view and navigate a data hierarchy via a series of vertical columns; each column = one hierarchy level; parent items show a triangle icon; selecting a parent fills the next column with its children (Finder column view is the canonical example).

**Normative rules.**
- Use when there is a **deep hierarchy with frequent back-and-forth navigation between levels** and you **don't need column sorting** (a table provides sorting; a column view doesn't).
- **Show the root level of the hierarchy in the first column** so people can scroll back to the start.
- **Consider showing a preview/info pane for a selected leaf item** (Finder shows preview + creation date, modification date, file type, size).
- **Let people resize columns** — especially important when item names exceed default column width.

**iOS vs macOS.** macOS-exclusive component. On iPadOS, the equivalent need is met by a split view; on iPhone, by drill-down navigation (navigation stack).

**Reviewer checks.**
- Column/browser ("Miller columns") UI in an iOS design → flag as non-native; recommend split view (iPad) or navigation stack (iPhone).
- macOS column view with fixed-width, non-resizable columns → flag.
- Hierarchy whose root is not in the first column → flag.

**Stale-knowledge corrections.** None; stable page. Models sometimes assume NSBrowser is deprecated — it remains current HIG guidance for deep file-like hierarchies.

---

## Disclosure controls

**URL:** https://developer.apple.com/design/human-interface-guidelines/disclosure-controls
**Platforms:** ios, ipados, macos, visionos. SwiftUI `DisclosureGroup` (all four); AppKit `NSButton.BezelStyle.disclosure` (triangle) and `.pushDisclosure` (button).

**Purpose.** Disclosure controls reveal and hide information/functionality related to specific controls or views. Two kinds: **disclosure triangles** (show/hide a view or list hierarchy, e.g. Finder list view, Keynote export advanced options) and **disclosure buttons** (show/hide functionality tied to one specific control, e.g. macOS Save sheet's expand button next to the Save As field).

**Normative rules.**
- **Use a disclosure control to hide details until they're relevant.** Most-used controls at the top of the disclosure hierarchy (always visible); advanced functionality hidden by default.
- **Disclosure triangle orientation:** points **inward from the leading edge when content is hidden**, points **down when content is visible** (this is the RTL-aware formulation — "leading," not "right").
- **Disclosure button orientation:** points **down when content is hidden**, **up when content is visible**.
- **Provide a descriptive label for a disclosure triangle** indicating what is disclosed/hidden (e.g. "Advanced Options").
- **Place a disclosure button near the content it shows/hides** — clear spatial relationship to the expanded choices.
- **Use no more than ONE disclosure button in a single view.** Multiple disclosure buttons "add complexity and can be confusing."

**iOS vs macOS.** macOS: native home of both control types (AppKit bezel styles). iOS/iPadOS: available via SwiftUI `DisclosureGroup` only — same semantics. No divergent rules.

**Reviewer checks.**
- More than one disclosure button in one view → flag.
- Chevron/triangle pointing the wrong way for state (collapsed triangle must point toward leading edge, not down; expanded points down) → flag.
- Disclosure triangle without a text label, or with a vague label → flag.
- Disclosure button far from the content it expands → flag.
- Advanced/rare options visible by default while common controls are buried → inverted disclosure hierarchy, flag.

**Stale-knowledge corrections.** Models trained on pre-2020 material may believe disclosure triangles are macOS-only; `DisclosureGroup` brings them to iOS/iPadOS/visionOS. Orientation language is now leading-edge-relative (RTL-aware), not "points right."

---

## Labels

**URL:** https://developer.apple.com/design/human-interface-guidelines/labels
**Platforms:** all. SwiftUI `Label`/`Text`, UIKit `UILabel`, AppKit `NSTextField` with `isEditable = false`.

**Purpose.** A label is a static piece of text people can read and often copy, but not edit — inside buttons (Edit/Cancel/Send), list items, or views introducing a control.

**Normative rules.**
- **Use a label for small amounts of uneditable text.** Editable small text → **text field**. Large amounts of text (editable or not) → **text view**.
- **Prefer system fonts.** Labels support Dynamic Type by default; custom fonts/styles must remain legible.
- **Use the system's FOUR semantic label colors to communicate relative importance** (exact mapping):

  | Level | Example usage | iOS/iPadOS/tvOS/visionOS | macOS |
  |---|---|---|---|
  | Label | Primary information | `label` | `labelColor` |
  | Secondary label | Subheading / supplemental text | `secondaryLabel` | `secondaryLabelColor` |
  | Tertiary label | Text describing an unavailable item or behavior | `tertiaryLabel` | `tertiaryLabelColor` |
  | Quaternary label | Watermark text | `quaternaryLabel` | `quaternaryLabelColor` |

- **Make useful label text selectable** — error messages, locations, IP addresses, serial numbers should be selectable/copyable.

**iOS vs macOS.** Identical guidance; only API names differ (table above). macOS labels are `NSTextField` instances with editing off.

**Reviewer checks.**
- Hierarchy of text importance expressed with hardcoded grays/opacities instead of the 4 semantic label colors → flag (breaks Dark Mode + vibrancy on materials).
- Error messages / IDs / addresses rendered as non-selectable text → flag.
- Custom display font on functional UI text without a legibility justification → flag.
- Text that looks editable (boxed) but is a static label, or vice versa → component-choice flag.

**Stale-knowledge corrections.** In the Liquid Glass era, semantic label colors matter MORE: labels frequently sit on translucent materials where vibrant semantic colors adapt automatically and fixed hex grays fail. The 4-level system (not 3) is the canonical hierarchy.

---

## Lists and tables

**URL:** https://developer.apple.com/design/human-interface-guidelines/lists-and-tables
**Platforms:** all. SwiftUI `List`/`Table`, UIKit `UITableView`, AppKit `NSTableView`.

**Purpose.** Lists and tables present data in one or more columns of rows; support grouping, hierarchy, selecting, adding, deleting, reordering. Lists often express an app's overall navigation hierarchy (iOS Settings); multicolumn sortable tables serve productivity data (Mail on iPadOS/macOS inside a split view).

**Normative rules.**
- **Prefer displaying text in a list or table.** Items varying widely in size, or many images → use a **collection** instead.
- **Let people edit/reorder when it makes sense.** iOS/iPadOS: people must **enter an edit mode** before selecting table items for editing.
- **Selection feedback must match purpose:** navigation lists **persistently highlight** the selected row (clarifies path, esp. in split views); option-picker lists highlight **briefly** then show a **checkmark** image.
- **Keep item text succinct** to minimize truncation/wrapping; for long content show titles only and push content to a detail view.
- **Middle (centered) ellipsis** can beat end-truncation because it preserves both beginning and end of the string.
- **Column headings (multicolumn tables): nouns or short noun phrases, title-style capitalization, no ending punctuation.** Single-column tables without a heading need a label/header for context.
- **Choose the platform-appropriate style:** iOS/iPadOS **grouped** style (headers, footers, extra space between groups); macOS **bordered** style with **alternating row backgrounds** for large tables. (SwiftUI `ListStyle`; row layout via `UIListContentConfiguration`.)

**iOS vs macOS.**
- iOS/iPadOS (+visionOS):
  - **Info button in a row = "detail disclosure button" — it reveals more information about the row ONLY; it does NOT support navigation.** Drill-down navigation must use the **disclosure indicator** accessory (chevron, `UITableViewCell.AccessoryType.disclosureIndicator`).
  - **Never combine an index** (vertical A–Z jump strip at trailing edge) **with trailing-edge row controls** like disclosure indicators — they collide.
  - Edit mode required before selecting items to edit.
- macOS:
  - **Clickable column-heading sort**: click a heading to sort by that column; clicking the already-sorted heading **reverses sort direction**.
  - **Let people resize columns.**
  - **Consider alternating row colors in multicolumn tables** (track rows across a wide table).
  - **Use an outline view, not a table, for hierarchical data** on macOS.

**Reviewer checks.**
- Row with an ⓘ info button used as the tap target to navigate deeper → flag (must be a chevron disclosure indicator; ⓘ only shows details).
- A–Z index plus chevrons/controls on the same trailing edge → flag.
- Navigation list that doesn't keep the selected row highlighted while its detail is shown (iPad/macOS split views) → flag.
- Option list that persists highlight instead of showing a checkmark → flag.
- Column headings with ending punctuation, sentence case, or verb phrases → flag (title-style nouns).
- macOS table mock without resizable columns or without sort affordance on headings where sorting has value → flag.
- Hierarchical data shown in a flat macOS table → suggest outline view.
- Text-heavy data in a collection grid, or image-heavy varied-size data in a list → component-choice flag.

**Stale-knowledge corrections.** Page text itself is pre-Liquid Glass (last change 2023) and remains in force. But on iOS 26, system list visuals changed around it: grouped lists sit beneath floating Liquid Glass bars, content scrolls under toolbars/tab bars edge-to-edge, and section shapes use larger continuous corner radii — don't reproduce the old hard-edged iOS 12-style flat grouped tables in new mocks. The detail-disclosure vs disclosure-indicator distinction is old but models persistently get it wrong — treat as a high-value check.

---

## Outline views

**URL:** https://developer.apple.com/design/human-interface-guidelines/outline-views
**Platforms:** **macOS only** (`NSOutlineView`; SwiftUI `OutlineGroup`). Not supported in iOS/iPadOS.

**Purpose.** An outline view presents hierarchical data in a scrolling list of cells organized into columns and rows; parent containers carry disclosure triangles; ≥1 column holds the primary hierarchy, extra columns hold attributes (size, modification date). Often the leading pane of a split view (Finder list view).

**Normative rules.**
- **Use a table (not an outline view) for non-hierarchical data.**
- **Expose the hierarchy in the FIRST column only**; other columns display attributes of the items in the primary column.
- **Column headings: nouns/short noun phrases, title-style capitalization, no punctuation, no trailing colon. Always provide headings in a multicolumn outline view.** Single-column outline views without headings need a contextual label.
- **Consider sortable column headings:** clicking the primary column heading sorts **at each hierarchy level** (top-level folders sorted, then items within each folder); clicking an already-sorted heading reverses direction.
- **Let people resize columns.**
- **Make expand/collapse easy:** clicking a folder's disclosure triangle expands only that folder; **Option-click expands all of its subfolders** (standard Finder behavior to honor).
- **Retain people's expansion choices** — persist expanded/collapsed state across sessions and redisplay it.
- **Editable cells:** single click edits a cell's contents; double click can do something different (e.g. open the file). Support reorder/add/remove where useful.
- **Consider a centered (middle) ellipsis** for truncating cell text instead of clipping.
- **Consider alternating row colors in multicolumn outline views.**
- **Consider a toolbar search field** when the outline view is the window's primary feature.

**iOS vs macOS.** macOS-exclusive. On iOS, hierarchical lists are built with `List` + `OutlineGroup`/`children:` but the HIG routes iOS hierarchy through lists, split views, or navigation — there is no iOS outline-view page.

**Reviewer checks.**
- Disclosure triangles appearing in a non-first column → flag.
- Outline view used for flat data → flag (use table).
- Missing column headings in a multicolumn outline → flag; heading capitalization/punctuation per rule.
- Prototype that resets expansion state on revisit → flag (persist state).
- End-truncated long filenames where middle-ellipsis would disambiguate → suggest.

**Stale-knowledge corrections.** None; stable page. Note the Option-click expand-all convention is normative ("make it easy… for example") and worth implementing in HTML prototypes of macOS UIs.

---

## Split views

**URL:** https://developer.apple.com/design/human-interface-guidelines/split-views
**Platforms:** all. SwiftUI `NavigationSplitView` (+ macOS `VSplitView`/`HSplitView`), UIKit `UISplitViewController`, AppKit `NSSplitViewController`.
**ALERT 2025-06-09:** "Added iOS and iPadOS platform considerations" — this page WAS touched in the Liquid Glass rewrite.

**Purpose.** A split view manages multiple adjacent panes of content (tables, collections, images, custom views), typically showing multiple hierarchy levels at once: selecting in the primary pane drives the secondary pane; optionally a tertiary pane. Commonly hosts a sidebar in the leading pane. Rarely, panes hold supplementary functionality (Keynote: slide navigator + presenter notes + inspector around the canvas).

**Normative rules.**
- **Persistently highlight the current selection in each pane that leads to the detail view** — clarifies pane relationships and keeps people oriented.
- **Consider drag and drop between panes** as a cross-hierarchy move affordance.
- iOS: **prefer split views in a regular — not compact — width environment.** In compact (iPhone portrait), multiple panes wrap/truncate and become illegible and hard to use.
- iPadOS: **two or three vertical panes** (Mail = 2, Keynote = 3). **Account for narrow, compact, and intermediate window widths — iPad windows are fluidly resizable** (iPadOS 26 windowing); navigation between panes must stay logical at every width.
- macOS:
  - Panes may be arranged **vertically, horizontally, or both**; dividers support drag-to-resize.
  - **Set reasonable minimum and maximum pane sizes** so the divider always stays visible (too-small panes make the divider seem to vanish).
  - **Consider letting people hide panes** (e.g. hide navigator/notes while editing in Keynote).
  - **Provide MULTIPLE ways to reveal hidden panes** — e.g. toolbar button AND menu command WITH keyboard shortcut.
  - **Prefer the thin divider style: exactly 1 point wide.** Use thicker dividers only with a specific reason (e.g. strong linear table rows on both sides making a thin divider hard to see). `NSSplitView.DividerStyle`.

**iOS vs macOS.**
- iOS/iPadOS: split view = navigation construct (sidebar → content → detail), regular-width only; panes are vertical; system manages collapse to a navigation stack in compact widths.
- macOS: split view = free-form pane manager (any orientation, user-resizable, hideable panes, divider styles). Pane-size limits and divider affordances are designer responsibilities.

**Reviewer checks.**
- iPhone-portrait (compact) mock showing two side-by-side panes → flag.
- iPad/macOS master-detail where the source row isn't persistently highlighted → flag.
- macOS split view with no stated min/max pane sizes, or panes that can collapse the divider away → flag.
- Hidden pane restorable by only one path (e.g. only a toolbar button) → flag; need toolbar + menu + shortcut.
- Divider drawn thicker than 1 pt without justification → flag.
- iPad layout that breaks when window is resized to intermediate widths → flag (fluid resizing is the iPadOS 26 norm).

**Stale-knowledge corrections.**
- iOS/iPadOS considerations are NEW (June 2025) — older models won't know "prefer regular not compact" is now explicit HIG text.
- **iPadOS 26 windowing:** windows are fluidly resizable like macOS; the old fixed Split View/Slide Over multitasking model is obsolete — design split views to survive continuous width changes, not three snap points.
- In iOS/iPadOS 26 Liquid Glass, sidebars hosted in split views render as floating glass panes with content scrolling beneath — visual treatment comes from the Sidebars/Materials pages, but split-view prototypes should not draw opaque full-height sidebar columns flush to the display edge in iOS-style mocks.

---

## Tab views

**URL:** https://developer.apple.com/design/human-interface-guidelines/tab-views
**Platforms:** **macOS (and watchOS)** ONLY. NOT supported in iOS/iPadOS — the page explicitly says: for similar functionality on iOS/iPadOS, **use a segmented control instead**. AppKit `NSTabView`; SwiftUI `TabView` (on macOS renders a tab view; on iOS the same API renders a tab BAR — different HIG page).

**Purpose.** A tab view presents multiple mutually exclusive panes of content in the same area, switched via a tabbed control (think System Settings-style grouped panes, NOT iOS bottom tab bars).

**Normative rules.**
- **Use for closely related areas of content** — strong visual enclosure implies the panes are similar/related.
- **Controls within a pane must affect content only in that pane.** Panes are mutually exclusive and fully self-contained.
- **Label every tab with what its pane contains:** generally **nouns or short noun phrases** (verb phrases occasionally OK), **title-style capitalization**.
- **Don't use a pop-up button to switch panes** — a tabbed control needs one click vs. two and shows all choices at once. Exception: a pop-up button is reasonable when there are **too many panes to show as tabs**.
- **Avoid more than SIX tabs** in a tab view; ≥6 is overwhelming and creates layout issues — switch to e.g. a pop-up-button view chooser.
- Anatomy: **tabbed control sits on the top edge of the content area.** You may **hide the tabbed control** when switching panes programmatically; a hidden-control content area can be borderless (solid or transparent), bezeled, or line-bordered.
- **Inset the tab view, leaving a margin of window-body area on all sides** — clean look, leaves room for unrelated controls. Extending tab view to window edges is "unusual."

**iOS vs macOS.** Completely divergent: macOS-only component. iOS equivalent for switching mutually exclusive content panes within a screen = **segmented control**; iOS bottom navigation = **tab bar** (separate page, separate rules). Models and designers routinely conflate all three.

**Reviewer checks.**
- More than 6 tabs → flag.
- Tab labels that are sentences, sentence-case, or end-punctuated → flag (title-style nouns).
- Pop-up button used as the pane switcher with ≤6 panes → flag.
- Control in pane A that changes state shown in pane B → flag.
- macOS tab view bleeding to window edges → flag as unusual; expect inset with margin.
- iOS mock using a macOS-style boxed tab view → suggest segmented control; iOS bottom-bar "tab view" should be reviewed under tab-bars rules instead.

**Stale-knowledge corrections.** SwiftUI naming trap: `TabView` on iOS = tab bar (navigation chrome, Liquid Glass floating bar in iOS 26), `TabView`/`NSTabView` on macOS = this enclosed-pane component. Skills must disambiguate by platform, not API name.

---

## Charts

**URL:** https://developer.apple.com/design/human-interface-guidelines/charts
**Platforms:** all. Swift Charts is the canonical framework. Companion pattern page: [Charting data](https://developer.apple.com/design/human-interface-guidelines/charting-data) (covered in the patterns bucket — when/where to use charts; this page = how to construct them).

**Purpose.** Organize data in a chart to communicate a few key insights with clarity. Defines canonical anatomy vocabulary: **mark** (visual representation of a data value; mark types: bar, line, point), **plotting**, **plot area**, **scale** (maps data values to position/color/height), **axis**, **ticks**, **grid lines**, **labels**, **accessibility labels**, titles/subtitles/annotations, **legend** (describes non-positional properties like color/shape categories).

**Normative rules — marks.**
- **Choose mark type by message:** bars = compare categories / part-to-whole / sums over time (e.g. daily step totals); lines = change over time, slope shows magnitude of change/trends; points = individual values, relationships between two properties, outliers and clusters.
- **Combine mark types when it adds clarity** (points on a line to highlight individual values within a trend).

**Normative rules — axes.**
- **Fixed vs dynamic axis range:** fixed when min/max are intrinsically meaningful (battery 0–100%); dynamic when values vary widely and marks should fill the plot area (Health Steps' Y upper bound tracks the period's max).
- **Lower bound by mark type:** bar charts generally want a **zero** lower bound (bar-height comparison only works from zero); line charts may need a **nonzero** lower bound when differences live far from zero (heart-rate resting vs active would be obscured by a zero baseline).
- **Use familiar tick sequences:** 0, 5, 10… is instantly parseable; 1, 6, 11… forces people to compute the interval.
- **Tune grid line density and label weight to the use case** — too many grid lines overwhelm; too few prevent value estimation; interactive charts can use fewer grid lines + lighter label colors.

**Normative rules — descriptive content & behavior.**
- **Write titles/labels that explain the chart before people view it** (critical for VoiceOver and cognitive accessibility).
- **Summarize the chart's main message in title/subtitle** (Weather: next-hour precipitation summary) — don't make people derive the takeaway.
- **Visual hierarchy: data most prominent; descriptions and axes recede.**
- **Compact environments: maximize plot-area width** — shortest possible Y-axis labels; move units to the title; long category labels can go inside the plot area when they don't obscure data.
- **Don't gate critical information behind interaction.** Interaction (e.g. Stocks' draggable vertical indicator) is for additional detail only.
- **Marks too small to hit with finger/pointer → expand the hit target to the whole plot area** and let people scrub to reveal values.
- **Keyboard / Switch Control navigation:** provide a logical path (e.g. along the X axis) via accessibility APIs (`accessibilityRespondsToUserInteraction(_:)`), or for large datasets let focus move among **subsets** of values rather than every point.
- **Announce changes:** animate mark/axis changes AND signal them non-visually (UIKit `UIAccessibility.Notification` / AppKit `NSAccessibility.Notification`).
- **Align the chart's leading edge with surrounding views.** Tricks: put each vertical grid-line label on its trailing side; move the Y axis to the trailing side so tick labels don't protrude past the leading edge; anchor orphan labels with a tick.

**Normative rules — color.**
- **Never rely on color alone** to differentiate data; supplement with shapes or patterns (Health blood pressure uses two point-mark shapes plus colors).
- **Add visual separation between contiguous colored areas** — separators between stacked bar segments.

**Normative rules — accessibility (chart-specific).**
- Swift Charts gives a default **Audio Graphs** implementation + a default accessibility element per mark/group; customize with a chart title and descriptive summary.
- **A chart needs an accessibility label per important/interactive element, not one image-style label** — decide per chart purpose whether to label each mark (Health Steps: per-bar) or summarize groups (Maps cycling elevation: per route segment). A miniature chart inside a button can take a single high-level label.
- Accessibility-label writing rules: include context (date/location) with values; **no subjective terms** (rapidly, gradually, almost); **no ambiguous formats/abbreviations** ("June 6" not "6/6", "60 minutes"/"60 meters" not "60m"); describe what data **represents, not what it looks like** (never describe series colors); refer to axes in a **consistent order** (e.g. always X first).
- **Hide visible axis/tick text labels from assistive technologies** — VoiceOver users get values via accessibility labels and Audio Graphs; visible tick labels are redundant noise for them.

**iOS vs macOS.** "No additional considerations for iOS, iPadOS, macOS" — the guidance is platform-uniform (only watchOS gets a glanceability carve-out). Compact-width rules apply to iPhone and narrow iPad/macOS windows alike.

**Reviewer checks.**
- Bar chart with nonzero baseline → flag (bar heights become lies); line chart forced to zero baseline that flattens meaningful variation → flag.
- Two data series distinguished only by hue → flag; require shape/pattern second channel.
- Stacked bars without separators between segments → flag.
- Tick sequence not a familiar interval (5s, 10s, 100s…) → flag.
- Chart without a message-summarizing title/subtitle → flag.
- Critical value visible only on hover/drag → flag.
- Compact-width chart with long Y-axis labels eating plot width / units repeated on every tick → flag.
- Chart leading edge misaligned with sibling content → flag.
- Interactive chart with tiny marks and no plot-area-wide scrub target → flag.

**Stale-knowledge corrections.** Page is from Sept 2022 and stable. Swift Charts + Audio Graphs are the canonical stack — models with older knowledge may suggest Core Plot or custom CALayer charts; don't. The anatomy vocabulary (mark/plot area/scale) is exact Apple terminology to reuse in skill prose.

---

## Image views

**URL:** https://developer.apple.com/design/human-interface-guidelines/image-views
**Platforms:** all. SwiftUI `Image`, UIKit `UIImageView`, AppKit `NSImageView`.

**Purpose.** An image view displays a single image (or an animated sequence) on a transparent or opaque background; supports stretch, scale, size-to-fit, pin. **Typically not interactive.**

**Normative rules.**
- **Use an image view only when the primary purpose is to display an image.** Interactive image → configure a system **button** to display the image; do NOT bolt button behaviors onto an image view.
- **For interface icons, prefer an SF Symbol or template/interface icon over an image view.** SF Symbols are vector, render in any color/opacity, and (like template icons) take the user-chosen accent color.
- Formats: PNG, JPEG, PDF (see Images foundation page).
- **Take care overlaying text on images:** ensure contrast; consider a text shadow or background layer behind the text.
- **Animated sequences: use one consistent image size, prescaled to the view** — avoids per-frame system scaling; equal size and shape perform best.

**iOS vs macOS.**
- iOS/iPadOS: no additional considerations.
- macOS only:
  - **Editable image needs an _image well_** (image view supporting copy, paste, drag, Delete-key clearing).
  - **Clickable image needs an _image button_**, not an image view.

**Reviewer checks.**
- Tappable/clickable bare image (no button semantics) → flag.
- Bitmap icons where an SF Symbol exists → flag.
- Text composited on a photo with no shadow/scrim/background layer → flag for legibility.
- macOS avatar/artwork pickers implemented as plain image views → suggest image well.

**Stale-knowledge corrections.** None major; stable page. SF Symbols preference is long-standing but worth enforcing — symbol library is now 6,000+ glyphs and the default for all glyph needs.

---

## Text views

**URL:** https://developer.apple.com/design/human-interface-guidelines/text-views
**Platforms:** all. SwiftUI `Text`(+`TextEditor`), UIKit `UITextView`, AppKit `NSTextView`.

**Purpose.** A text view displays multiline, styled text, optionally editable. Any height; scrolls when content exceeds the view. Defaults: leading-edge alignment, system label color. iOS/iPadOS: keyboard appears when an editable text view is selected.

**Normative rules.**
- **Component choice rule:** text view = long, editable, or specially-formatted text. Small + uneditable → **label**; small + editable → **text field**.
- **Keep text legible:** multiple fonts/colors/alignments allowed but readability is paramount; **adopt Dynamic Type**; test with accessibility settings (e.g. bold text) on.
- **Make useful text selectable** (error messages, serial numbers, IP addresses).
- iOS/iPadOS: **show the appropriate keyboard type for the content** (the system offers several types; match input semantics — see Virtual keyboards page).

**iOS vs macOS.** macOS: no additional considerations (no keyboard-type concept). iOS: keyboard-type rule above.

**Reviewer checks.**
- Multiline editable area on iOS with a generic keyboard for emails/numbers/URLs → flag.
- Long-form text in a label that truncates → flag (use text view).
- Fixed font sizes on body text (no Dynamic Type) → flag.
- Non-selectable diagnostic text → flag.

**Stale-knowledge corrections.** None; stable page.

---

## Web views

**URL:** https://developer.apple.com/design/human-interface-guidelines/web-views
**Platforms:** ios, ipados, macos, visionos (NOT tvOS/watchOS). WebKit `WKWebView`.

**Purpose.** A web view loads and displays rich web content (embedded HTML, websites) directly inside an app (e.g. Mail rendering HTML messages).

**Normative rules.**
- **Support forward and back navigation when appropriate.** The behaviors exist but are OFF by default; if people will visit multiple pages, enable them AND provide corresponding controls.
- **Avoid using a web view to build a web browser.** Brief in-context website access is fine; replicating Safari's functionality is "unnecessary and discouraged" (also an App Review consideration).

**iOS vs macOS.** None — guidance is identical across supported platforms.

**Reviewer checks.**
- In-app web view flows spanning multiple pages without back/forward controls → flag.
- App design that recreates browser chrome (address bar, tabs) around a web view → flag.

**Stale-knowledge corrections.** WWDC 2025 introduced a native SwiftUI `WebView` (iOS 26/macOS 26) alongside `WKWebView`; the HIG page still references only WKWebView, but SwiftUI prototypes can now use the native view. Guidance content unchanged.

---

## Cross-cutting synthesis for skill design

**Component-selection decision table (the core normative content of this bucket).** Most rules here are "use X, not Y, when Z":
- Small static text → label; small editable → text field; long/styled/editable → text view.
- Text rows → list/table; image-heavy or size-varying items → collection.
- Flat data (macOS) → table; hierarchical data (macOS) → outline view; deep hierarchy + frequent level-hopping, no sorting needed (macOS) → column view; hierarchy navigation (iOS/iPadOS) → split view / navigation stack.
- Mutually exclusive panes: macOS → tab view (≤6 tabs); iOS → segmented control; many panes → pop-up button.
- Interactive image → (image) button, never bare image view; editable image (macOS) → image well; interface glyph → SF Symbol.
- Row detail-info → ⓘ detail disclosure button; row drill-down → chevron disclosure indicator. Never confuse.

**Hard numeric/exact specs in this bucket (few but absolute):**
- macOS split-view thin divider = **1 pt**; prefer it.
- Tab views: **max 6 tabs**; **1 disclosure button max per view**.
- **4** semantic label colors with exact API names per platform.
- Disclosure triangle: leading-pointing = collapsed, down = expanded; disclosure button: down = collapsed, up = expanded.
- Capitalization: **sentence-style** for box titles (+ trailing colon only in settings panes); **title-style, no punctuation** for table/outline column headings and tab labels.

**Pages that got Liquid Glass updates:** only split-views (2025-06-09). The rest of this bucket is stable pre-2025 guidance still in force — Liquid Glass corrections for these components come from Materials/Layout/Sidebars/Tab bars/Toolbars pages (other buckets).
