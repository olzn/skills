<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: action-sheets, alerts, page-controls, panels, popovers, scroll-views, sheets, windows, gauges, progress-indicators, rating-indicators -->

# Components — presentation and status

Container choice (alert vs action sheet vs sheet vs popover vs panel vs window) lives in trees-containers.md; sections carry per-component rules only.

## action-sheets
<!-- src: action-sheets · changed: stable (no alert on record) · platforms: iOS, iPadOS, macOS, tvOS, watchOS — not visionOS · speed: stub -->
`confirmationDialog` — choices about an action people just initiated (unexpected problem → alert; deliberately revealed options → menu).
- Destructive choices: destructive (red) style AND placed at the top; any data-destroying choice requires Cancel at the bottom.
- Title fits one line; message only if needed; never let it scroll on iPhone.
- iPad: present as a popover from the source element, not a full-width bottom sheet.
- macOS has no bottom-sheet idiom — `confirmationDialog` presents as a dialog; never draw an iPhone-style action sheet in a macOS mock.
Fetch for detail: action-sheets

## alerts
<!-- src: alerts · changed: 2024-02-02 · platforms: all · speed: stub -->
Title + optional informative text + up to 3 buttons (more → action sheet/menu); optional text field; macOS adds the app icon, suppression checkbox, accessory view, Help button.
- Alert only for uncommon destructive actions that can't be undone — never common undoable deletions, never at app launch, never a pure FYI.
- Title: never "Error" or a raw code; ≤2 lines. Buttons: 1–2-word verbs ("Erase"); "OK" only in purely informational alerts; never "Yes"/"No"; Cancel is always titled "Cancel"; never explain buttons in body text.
- Placement: default button trailing (row) / top (stack); Cancel leading / bottom, never default. Destructive actions require Cancel.
- Destructive (red) style only for destruction people did NOT deliberately choose — Empty Trash's confirm button isn't red.
- 2024 refinements: no-default-button is sanctioned (forces reading); a single-button informational alert defaults to "Done", not "OK". Support Esc / Command-Period.
- macOS: `exclamationmark.triangle` badge sparingly — unexpected data loss only.
Fetch for detail: alerts

## page-controls
<!-- src: page-controls · changed: 2023-06-21 · platforms: iOS, iPadOS, tvOS, visionOS, watchOS — NOT macOS · speed: stub -->
Indicator dots for a flat, ordered page list. A page control in a macOS design is itself a flag — macOS pages via segmented controls or buttons.
- Centre horizontally, near the bottom. At most ~10 dots; never custom dot colours; at most TWO distinct indicator images (SF Symbols; no text or negative space).
- Background styles: automatic (visible during interaction; default), prominent (only when the control IS the primary navigation), minimal (passive display; no scrubbing).
- Don't animate transitions during scrubbing — animate taps only.
Fetch for detail: page-controls

## panels
<!-- src: panels · changed: stable (no alert on record) · platforms: macOS only · speed: stub -->
macOS-only floating windows (`NSPanel`) for supplementary controls about the active window or selection (Fonts, Colors, Inspector). iOS replacement: a nonmodal sheet or other modal view.
- Inspector (auto-updates with selection) → panel or trailing split-view pane (SwiftUI `inspector` — modern, under-recommended). Info window (fixed to one item) → regular window, not a panel.
- Title bar required; title is a title-style noun ("Fonts"); never the word "panel" in UI strings ("Show Fonts", not "Show Fonts Panel").
- Hide panels when the app is inactive, bring them forward on activation; none in the Window menu's documents list; no enabled minimize button.
- Prefer sliders/steppers over typing. HUD style only for media apps, content-obscuring cases, or control-free panels; one panel style per app mode.
Fetch for detail: panels

## popovers
<!-- src: popovers · changed: stable (no alert on record) · platforms: iOS, iPadOS, macOS, visionOS · speed: stub -->
Transient anchored view for a small amount of content; the arrow points at the revealing element, which the popover must not cover.
- iPhone/compact widths: effectively NO popovers — the same trigger must present a sheet; adapt by size class (web tooltips normalise these; the HIG forbids them).
- One at a time; never a popover from a popover; nothing layers above one except an alert; warnings are alerts, never popovers.
- Automatic close saves work; only explicit Cancel discards. Close/Done buttons only when there's save/discard ambiguity.
- macOS: popovers can detach into a panel when dragged — consider it; keep the detached panel visually similar.
Fetch for detail: popovers

## scroll-views
<!-- src: scroll-views · changed: 2026-06-08 · platforms: all · speed: full -->
Edge effects added 2025-07-28, refined 2026-06-08; pre-2025 separation priors are wrong.

Normative rules
- Keep default gestures and keyboard shortcuts; custom scrolling keeps the elastic bounce people expect.
- Make scrollability apparent: partial content cut off at the view's edge.
- Never nest same-orientation scroll views; cross-orientation is fine.
- Auto-scroll only when relevant content left the viewport, and only as much as necessary.
- Page-by-page: page size = view height/width, optionally minus an overlap unit. Zoom: set min/max scale limits.

Scroll edge effects (iOS, iPadOS, macOS)
- Separate floating bars from content scrolling beneath. Styles: automatic (default), hard, soft — `ScrollEdgeEffectStyle` / `NSScrollEdgeEffectStyle` (yes, macOS too).
- Prefer automatic: more opaque for control-dense toolbars, text outside Liquid Glass controls, pinned table headers. Soft obliges legibility testing.
- Functional, not decorative — only where a scroll view sits behind floating elements; never dims or blocks like an overlay.
- ONE effect per view; split-view panes may each have one, heights kept consistent. Custom bars may need it added manually.

iOS vs macOS
- macOS: scroll indicator = scroll bar; small/mini bars allowed in panels — all panel controls then match that size.
- iOS/iPadOS: page-by-page mode may add a page control — never with a same-axis scroll indicator.

Reviewer checks
- Same-orientation nesting · no elastic bounce · no hint of more content at the fold → flag.
- Floating bar separated by gradient scrim, shadow, or hard border instead of the system edge effect → flag; prefer automatic.
- Stacked edge effects in one view · mismatched effect heights across panes · page control plus same-axis indicator → flag.
- HTML prototypes: `overflow: hidden` with no scroll affordance, non-rubber-banding scrollers → fidelity flags.

Stale-prior corrections
- Was: opaque or blurred bars with hairline separators, scrims, shadows. → Now: content scrolls edge-to-edge beneath floating Liquid Glass bars; the scroll edge effect is the sanctioned separation. (since 2025-07-28)
- Was: style freely. → Now: automatic preferred over soft; functional not decorative; one per view; consistent pane heights. (since 2026-06-08)

## sheets
<!-- src: sheets · changed: 2026-03-24 · platforms: all · speed: full -->
A scoped task closely related to the current context — complete it, return to the parent.

Anatomy and buttons (all platforms)
- Always modal except iOS/iPadOS, which also allow nonmodal sheets (Notes' text-format sheet stays up while you edit).
- Standard buttons: Cancel (or Close) dismisses without saving; Done dismisses after saving; Back returns a step and never dismisses.
- Providing Done? ALWAYS pair it with Cancel (or Back in a multi-step flow) — Done alone is "restrictive or misleading". Never show Cancel, Done, AND Back together.
- One sheet at a time; close the first before showing a second.
- Complex/prolonged flows leave the sheet: iOS → full-screen modal style; macOS → a window or full-screen mode.

iOS/iPadOS
- Single-view sheets: Cancel at top-LEADING, Done at top-TRAILING (multi-step placement may vary by step).
- Detents: system large (full height) and medium (about half); custom allowed. Large is automatic; adding medium enables both; only-medium prevents full-height expansion.
- iPhone: medium detent suits progressive disclosure (share-sheet pattern); compose-style content is full-height only.
- Resizable sheets include a grabber: drag resizes, tap cycles detents, VoiceOver-compatible.
- Support swipe-to-dismiss; unsaved changes → confirm via an action sheet.
- iPad: prefer page or form sheet — default-sized, centred over a dimmed background, not edge-to-edge.

macOS
- A cardlike view over its parent window; the parent dims and blocks but OTHER app windows stay usable. No detents; buttons-only dismissal; reasonable default size.
- Repeated input-observe-result loops (find-and-replace) → a panel, not a sheet.

Reviewer checks
- Done without Cancel/Back · all three buttons together → flag (2026 rule). Cancel not top-leading / Done not top-trailing (iOS) → flag.
- Resizable iPhone sheet with no grabber · sheet stacked on a sheet · compose content at a medium detent → flag.
- Long multistep flow in a sheet (→ full-screen modal; macOS window) · find/replace UI in a macOS sheet (→ panel) · iPad sheet with no dimmed surround → flag.

Stale-prior corrections
- Was: a Done-only sheet is acceptable. → Now: Done must pair with Cancel or Back; never all three. (since 2026-03-24)
- Rendering (WWDC25, iOS 26+, not on this page): smaller detents are inset Liquid Glass cards, growing opaque/edge-to-edge at full height. Behaviour rules unchanged.

## windows
<!-- src: windows · changed: 2025-06-09 · platforms: iPadOS, macOS, visionOS — NOT iOS · speed: full -->
No window concept on iPhone — traffic lights or floating windows in an iPhone mock are wrong.

Normative rules
- Primary windows carry main navigation + content; auxiliary windows one dedicated task (no app-wide navigation; a close button ends it).
- Adapt fluidly to size changes. Open new windows at the right moments (Mail Compose preserves context), never by default; offer "open in new window" as an option (`OpenWindowAction`).
- Never create custom window UI — no custom frames or controls, no replicas of the system look.
- User-facing term is "window", never "scene".

macOS
- States: main (frontmost; one per app), key (accepts input; usually = main, but a panel can be key), inactive. Key window controls are coloured, others grey; inactive windows drop Materials. Custom implementations must reproduce these appearances.
- Bottom bars: no critical info or actions (bottoms get pushed offscreen); small selection-tied content (Finder status bar); more → an inspector.

iPadOS
- User-selectable modes: full screen, or windowed (free resize/reposition, multiple windows, size/placement remembered).
- Window controls sit at the LEADING edge of the toolbar when windowed — leading toolbar buttons move inward, never overlapped.

Reviewer checks
- Custom window chrome · key and inactive windows with identical control colours/material · critical actions in a bottom bar → flag.
- "Scene" in user-facing copy · a new window per interaction · iPad toolbar buttons colliding with window controls → flag.

Stale-prior corrections
- Was: iPad multitasking = Split View/Slide Over. → Now: iPadOS free-form windowing with persistent size/placement and Mac-style leading window controls. (since 2025-06-09)
- Window-state semantics unchanged; macOS 26 radii and glass toolbars live on the materials/toolbars pages.

## gauges
<!-- src: gauges · changed: stable (2022 page) · platforms: iOS, iPadOS, macOS, visionOS, watchOS · speed: stub -->
SwiftUI `Gauge`: one value within a range on a circular or linear path. Standard style = indicator at the value; capacity = fill stopping there; accessory variant echoes watchOS complications (Lock Screen widgets).
- A gauge shows a value in a range, never task progress — that's a progress indicator.
- Label the current value AND both endpoints (VoiceOver reads visible labels); a gradient fill can carry meaning (red→blue).
- macOS adds level indicators (`NSLevelIndicator`): capacity (continuous for large ranges), rating, relevance; default fill green, recolour at significant levels or use the tiered state. Segmented capacity bars are a macOS idiom — on iOS use Gauge.
Fetch for detail: gauges

## progress-indicators
<!-- src: progress-indicators · changed: 2023-09-12 · platforms: all · speed: stub -->
Determinate (bar fills leading→trailing; circular fills clockwise) or indeterminate (activity indicator/spinner). All are transient — gone when the operation ends.
- Prefer determinate whenever duration is knowable; switch indeterminate → determinate once known; NEVER switch circular → bar mid-task.
- Report progress accurately and evenly (a front-loaded 90% "can even feel deceptive"); keep indicators moving — stationary reads as frozen.
- Avoid vague captions ("loading", "authenticating"). Allow halting: Cancel when side-effect-free; add Pause when cancelling loses work; confirm progress-losing cancellation via an alert.
- iOS refresh control: pull-to-refresh must never be the ONLY freshness mechanism — keep automatic updates; never caption with instructions ("Pull to refresh").
- macOS: prefer a spinner for background operations and tight spaces; never label a spinner; macOS alone has an indeterminate progress bar (iOS indeterminate = spinner only).
Fetch for detail: progress-indicators

## rating-indicators
<!-- src: rating-indicators · changed: stable (2022 page) · platforms: macOS only · speed: stub -->
macOS-only (`NSLevelIndicator.Style.rating`): a row of equidistant stars (or a custom symbol whose rating purpose stays clear).
- No partial symbols — values round to whole stars; symbols never stretch or respace with container width.
- Make rankings editable inline in ranked lists, not via a separate editing screen.
- Scope trap / iOS replacement: iOS star ratings (App Store style, fractional stars allowed) belong to the ratings-and-reviews pattern page — don't flag iOS fractional stars here.
Fetch for detail: rating-indicators
