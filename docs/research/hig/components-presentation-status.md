# HIG research — Components: Presentation + Status

Bucket: action sheets, alerts, page controls, panels, popovers, scroll views, sheets, windows (Presentation); activity rings, gauges, progress indicators, rating indicators (Status).
Source: Apple JSON content API (`developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`), fetched 2026-06-10 (mid-WWDC26 week). 12 pages — all Presentation + Status pages in the index; activity-rings was missing from the hint list but is iOS-relevant and covered.

Currency map for this bucket (per-page `alert-date`):
- **scroll-views — 2026-06-08 (changed THIS WEEK)**: scroll edge effects guidance updated again (first added 2025-07-28).
- **sheets — 2026-03-24**: button placement (Cancel/Done/Back) guidance.
- **windows — 2025-06-09 (Liquid Glass rewrite)**: best practices added, iPadOS resizable windows.
- alerts — 2024-02-02; progress-indicators — 2023-09-12; page-controls — 2023-06-21; activity-rings — 2024-03-29.
- action-sheets, panels, popovers, gauges, rating-indicators — no change alert (stable, predate 2023 logs).

Big picture: this bucket is mostly **stable behavioural/judgment guidance** (when to use which container, button semantics, content rules) with three currency hotspots (scroll edge effects, sheet button placement, iPadOS windowing). Numeric specs are sparse — the checkable content is mostly structural (which buttons exist, where they sit, what's forbidden).

---

## Action sheets

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/action-sheets
**Platforms:** ios, ipados, macos, tvos, watchos (NOT visionOS). SwiftUI: `confirmationDialog`; UIKit: `UIAlertController.Style.actionSheet`.

**Purpose.** A modal view presenting choices related to an action *people initiate* (e.g. cancel a Mail draft → Delete Draft / Save Draft). Governs the choice between action sheet vs alert vs menu, and button composition.

**Normative rules.**
- **Action sheet vs alert:** use an action sheet — not an alert — for choices related to an *intentional* action. An alert is for unexpected problems/changes; it confirms/cancels but doesn't offer additional related choices.
- Use sparingly — they interrupt the current task.
- Title short enough for **a single line**; long titles truncate or force scrolling.
- Message only if necessary; title + action context should suffice.
- If a choice might destroy data, provide a **Cancel button at the bottom** of the action sheet. (SwiftUI confirmation dialog includes Cancel by default.)
- **Destructive choices: use the destructive style (red) AND place at the top** of the action sheet where most noticeable (`destructive` role in SwiftUI / `UIAlertAction.Style.destructive`).
- iOS/iPadOS: use an action sheet — **not a menu** — for action-related choices; menus are for things people deliberately reveal, action sheets appear in response to an action.
- iOS/iPadOS: **avoid letting an action sheet scroll** — more buttons = more effort, and scrolling risks accidental taps.

**iOS vs macOS.** iOS is the home platform (bottom-anchored sheet of buttons on iPhone). macOS supports the *functionality* via SwiftUI confirmation dialogs but the page says "No additional considerations for macOS" — on Mac it presents as a dialog; there is no distinct macOS action-sheet idiom. Designers should not draw an iPhone-style bottom action sheet in a macOS mock; use an alert-like confirmation dialog or a menu.

**Reviewer checks.**
- Bottom sheet of action choices triggered by a problem/system event (not a user action) → should be an alert.
- Destructive option present but not red, or not first/top in the list → violation.
- Destructive option present but no Cancel at the bottom → violation.
- Title wraps to 2+ lines → flag.
- More buttons than fit without scrolling (iPhone) → flag.
- Action sheet used where a menu fits better (user explicitly opened a list of options unrelated to a just-taken action) → flag.
- iPad: an action sheet should typically appear as a popover from its source element, not a full-width bottom sheet.

**Stale-knowledge corrections.** Older models treat action sheets as iOS-only; the HIG now lists macOS/tvOS/watchOS support via `confirmationDialog`. Destructive-at-top + Cancel-at-bottom is explicit current guidance. Not supported in visionOS at all. Page otherwise stable through the Liquid Glass rewrite — the rendering is now Liquid Glass material in iOS 26+, but no behavioural guidance changed.

---

## Alerts

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/alerts
**Platforms:** all. Last change 2024-02-02 ("Enhanced guidance for using default and Cancel buttons"). SwiftUI `alert`; UIKit `UIAlertController`; AppKit `NSAlert`.

**Purpose.** Modal view for critical information people need right away — problems, destructive-action warnings, confirmations of important user-initiated actions. Governs content (title/message/buttons), button semantics and placement.

**Normative rules — content.**
- All platforms: alert = **title + optional informative text + up to 3 buttons**. iOS/iPadOS/macOS/visionOS alerts may add a **text field**; macOS/visionOS may add an **icon and accessory view**; macOS may add a **suppression checkbox** ("Don't ask again") and a **Help button**.
- Use sparingly; never merely to provide information (find an in-context way instead, e.g. Mail's connection-unavailable indicator).
- **Don't alert for common, undoable destructive actions** (deleting an email/file) — alert only for *uncommon* destructive actions that *can't be undone*.
- **Never show an alert at app launch**; surface startup problems non-intrusively (cached/placeholder data + label).
- Title: clearly and succinctly describe the situation; never "Error" or "Error 329347 occurred"; **avoid titles wrapping past 2 lines**. Complete sentence → sentence case + end punctuation; fragment → title case, no end punctuation.
- Informative text only if it adds value; complete sentences, sentence case.
- Don't explain what buttons do; if you must, say *choose* (device-agnostic) and use the exact button title without quotes.
- Text field only if input is needed to resolve the situation (e.g. password).

**Normative rules — buttons.**
- 1–2 word titles, verbs/verb phrases tied to the alert text ("View All", "Reply", "Ignore"). **"OK" only in purely informational alerts**; never "Yes"/"No". Cancel button is always titled "Cancel". Sentence case, no end punctuation.
- **Avoid OK as the default button** unless purely informational — use a specific verb ("Erase", "Convert", "Clear", "Delete").
- Placement: most likely choice + **default button on the trailing side of a row / top of a stack**; **Cancel on the leading side of a row / bottom of a stack**.
- **Destructive style** only for destructive actions people *didn't deliberately choose* (an Empty Trash confirmation does NOT style Empty Trash destructive — pressing Return to confirm intent outweighs re-warning).
- If there's a destructive action, **include Cancel**; never make Cancel the default. To force reading, make **no** button default. A single-button default alert uses **Done**, not Cancel.
- Support alternate cancellation: Esc or **Command-Period** (iOS/iPadOS with keyboard, macOS, visionOS); exit to Home Screen (iOS/iPadOS).

**iOS vs macOS.**
- iOS/iPadOS: prefer action sheets for intentional-action choices; minimise alert scrolling at large Dynamic Type sizes (keep title short, message brief).
- macOS: automatically shows the **app icon** in the alert (replaceable with custom icon/symbol); supports suppression checkbox for repeating alerts, accessory view, Help button. Use `exclamationmark.triangle` caution badge **sparingly** — only for unexpected data loss, never for routine overwrite/empty-trash tasks.

**Reviewer checks.**
- More than 3 buttons → must be an action sheet/menu instead.
- Title "Error", a raw error code, or >2 lines → violation.
- "OK" button in a confirmation (non-informational) alert → violation; "Yes"/"No" buttons → violation.
- Cancel not leading (row) / not bottom (stack); default action not trailing/top → violation.
- Cancel styled as default → violation. Destructive action with no Cancel → violation.
- Deliberately-chosen destructive confirmation styled red → flag (over-warning).
- Alert shown at launch, or alert used for a purely informational FYI → violation.
- macOS alert mock missing the app icon → flag; repeated alert without suppression checkbox → suggest.
- Button explanations in body text ("Tap OK to…") → violation.

**Stale-knowledge corrections.** The 2024 refinement most models half-know: *no default button at all* is a sanctioned pattern to force reading; single-button default = "Done" not "OK"/"Cancel"; destructive style is about *unintended* destruction, not all deletion. Alerts in iOS 26+ render on Liquid Glass and (per Apple's WWDC25 materials) animate from the triggering context, but the HIG behavioural guidance is unchanged since Feb 2024.

---

## Page controls

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/page-controls
**Platforms:** ios, ipados, tvos, visionos, watchos — **NOT supported in macOS**. SwiftUI `PageTabViewStyle`; UIKit `UIPageControl`.

**Purpose.** The row of indicator dots representing pages in a flat, ordered list (e.g. Weather locations); governs dot count, placement, custom indicator images, background styles, scrubbing.

**Normative rules.**
- Dots are equidistant; solid dot = current page; clipped if too many fit. Use only for **ordered, flat (non-hierarchical, sequential)** page lists — for complex navigation use a sidebar/split view.
- **Center horizontally, position near the bottom** of the view/window.
- **Don't display more than ~10 dots** — more is uncountable at a glance; use a grid or other any-order arrangement for >10 peer pages.
- Custom indicator images: simple, clear; no negative space, text, or inner lines (muddy at tiny sizes); prefer SF Symbols. Change the *default* indicator image only when it adds meaning for all pages (e.g. `bookmark.fill` if every page is bookmarks). **Max two distinct indicator images** in one control (e.g. `location.fill` for current location in Weather + dots). **Don't color indicators** — let the system color them (custom colors hurt current-page contrast).
- iOS/iPadOS interactions: tap leading/trailing side of current dot = previous/next page; *scrubbing* (touch + drag) moves through pages; scrubbing past an edge jumps to first/last page. **Don't animate page transitions during scrubbing** (lag + visual flashes); animate only for taps.
- Background styles (iOS/iPadOS, translucent rounded-rect behind dots): **Automatic** — shows only during interaction; use when the control isn't the primary navigation. **Prominent** — always visible; only when the control IS the primary navigation. **Minimal** — never visible; only for passive position display; **don't support scrubbing with the minimal style** (no visual feedback).

**iOS vs macOS.** iOS/iPadOS only. A page control in a macOS design is itself a violation — macOS paging UIs use other affordances (segmented controls, buttons, etc.).

**Reviewer checks.**
- Page control in a macOS mock → violation.
- >10 dots → violation.
- Not horizontally centered / not near the bottom → violation.
- Dots in custom colors → violation. Three or more distinct indicator glyphs → violation.
- Used for hierarchical or unordered navigation → violation.
- Prominent background style on a control that isn't the screen's primary navigation → flag.

**Stale-knowledge corrections.** Page stable since 2023; nothing Liquid-Glass-specific. Models generally know this component; main blind spots are the named background styles (automatic/prominent/minimal) and the two-image maximum.

---

## Panels (macOS)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/panels
**Platforms:** macOS ONLY. AppKit `NSPanel`, `hudWindow`.

**Purpose.** Floating windows above app windows holding supplementary controls/options/info for the active window or current selection (Fonts, Colors, Inspector). Governs panel vs window vs sheet choice, titling, show/hide behaviour, HUD style.

**Normative rules.**
- Use for quick access to controls/info about the content being worked on (e.g. settings affecting the selected item).
- **Inspector vs Info window:** inspector (auto-updates with selection) → panel or a split-view pane; Info window (contents fixed to one item even when selection changes) → regular window, NOT a panel.
- Prefer **simple adjustment controls** (sliders, steppers); avoid controls requiring typing or selection.
- **Title bar required** (so people can position it); title = short noun / noun phrase in **title-style capitalization** ("Fonts", "Colors", "Inspector").
- **Show/hide rules:** when the app becomes active, bring all open panels to front; when the app is inactive, **hide all panels**.
- **Don't list panels in the Window menu's documents list** (show/hide commands in the Window menu are fine).
- **Avoid an enabled minimize button** on panels.
- Naming in UI/help: menu commands use the bare title ("Show Fonts"), never the word *panel*; in help docs prefer the title or "<Title> window" ("Fonts window").
- **HUD-style panels** (dark, translucent): prefer standard panels; use a HUD only (1) in media-oriented apps (movies/photos/slides), (2) when a standard panel would obscure essential content, (3) when you don't need controls (most system controls don't match HUD appearance; disclosure triangle is the exception). Maintain one panel style across app modes (don't switch HUD↔standard leaving full screen). Use colour sparingly in HUDs; keep HUDs small — never obscuring or competing with the content they adjust.

**iOS vs macOS.** macOS only. On other platforms, present supplementary content with a modal view (see Modality); on iOS the nearest equivalent is a nonmodal sheet.

**Reviewer checks.**
- Panel-like floating window in an iOS mock → violation (use sheet/popover).
- Panel without a title bar, or title in sentence case → violation.
- Minimize button visible on a panel → flag.
- Text-entry-heavy panel UI → flag (prefer sliders/steppers).
- HUD style in a non-media, control-heavy context → violation.
- "Panel" used as a word in UI strings or menu items ("Show Fonts Panel") → violation.

**Stale-knowledge corrections.** Stable page; no Liquid Glass changes. Note the modern alternative explicitly endorsed: inspectors as a trailing **split-view pane** (SwiftUI `inspector`), which many older models under-recommend versus floating panels.

---

## Popovers

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/popovers
**Platforms:** ios, ipados, macos, visionos (NOT tvOS/watchOS). SwiftUI `popover`; UIKit `UIPopoverPresentationController`; AppKit `NSPopover`.

**Purpose.** Transient view appearing above content, anchored by an arrow to the control/area that revealed it. Governs sizing, dismissal, stacking, and the compact-width prohibition.

**Normative rules.**
- For a **small amount** of information or functionality — a few related tasks (e.g. Calendar event editing); it disappears after interaction.
- Good for temporary content that would otherwise cost permanent space (sidebars, panels).
- **Arrow points as directly as possible to the revealing element**; popover shouldn't cover that element or essential nearby content.
- Close/Cancel/Done button **only for confirmation/guidance** (e.g. exit with vs without saving). Otherwise dismissal = click/tap outside or selecting an item. Multi-select popovers stay open until explicit dismissal or outside click/tap.
- **Always save work when a nonmodal popover closes automatically**; discard only on explicit Cancel.
- **One popover at a time**; never a cascade/hierarchy of popovers; close the open one before showing another.
- **Nothing displays on top of a popover except an alert.**
- Let people close one popover and open another with a single click/tap (esp. adjacent bar buttons).
- Size: just big enough for content + arrow; animate size changes smoothly (condensed↔expanded) so it doesn't look like a new popover.
- Never the word *popover* in help docs.
- **Never use a popover for a warning** — use an alert.
- **iOS/iPadOS: avoid popovers in compact size classes** — reserve for wide (regular-width) views; in compact, present a sheet instead. Layout must adapt dynamically by size class.

**iOS vs macOS.**
- iPhone (compact width): effectively **no popovers** — same trigger should produce a sheet. iPad regular width: popovers fine.
- macOS: popovers can be **detachable** — dragging one turns it into a panel that persists onscreen; consider supporting this, and keep the detached panel visually similar to the popover to maintain context.

**Reviewer checks.**
- Popover drawn on an iPhone-width screen → violation (should be a sheet).
- Arrow missing or pointing away from / popover covering its source control → violation.
- Two popovers open at once, or popover spawning a popover → violation.
- Anything but an alert layered above a popover → violation.
- Warning/error content inside a popover → violation.
- Close button present without a save/discard ambiguity to resolve → flag.
- Oversized popover (lots of empty space, or near-full-screen) → flag.

**Stale-knowledge corrections.** Stable page (no alert-date). In iOS 26+ popovers render in Liquid Glass and (per WWDC25 system behaviour) can flow out of glass controls, but the rules above are unchanged. The compact-width rule predates and survives Liquid Glass — models sometimes wrongly allow iPhone popovers because web tooltips normalise them.

---

## Scroll views

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/scroll-views
**Platforms:** all. **Updated 2026-06-08 (this week): scroll edge effects.** Change log: 2026-06-08 scroll edge effects updated; 2026-03-24 Look to Scroll (visionOS); 2025-07-28 scroll edge effects added.

**Purpose.** Scrolling containers and their indicators; since 2025, also the **scroll edge effect** — the system treatment separating floating bars from scrolling content. Governs gestures, nesting, paging, auto-scroll, zoom, and edge effects.

**Normative rules.**
- Scroll view itself has no appearance; translucent *scroll indicator* appears once scrolling begins and signals position (beginning/middle/end).
- **Support default scrolling gestures and keyboard shortcuts** everywhere; custom scrolling must keep the **elastic** (bounce) behaviour people expect.
- **Make scrollability apparent**: show partial content at the view's edge to signal more content in that direction.
- **Never nest same-orientation scroll views** (unpredictable, hard to control). Horizontal-inside-vertical (or vice versa) is fine.
- Page-by-page scrolling: page size typically the view's current height/width; optionally subtract an overlap unit (a line of text, row of glyphs, part of a picture) to preserve context. (`PagingScrollTargetBehavior`.)
- **Automatic scrolling** only when relevant content left the viewport: search match selected offscreen, typing starts at an offscreen insertion point, pointer drags a selection past the edge, or acting on an offscreen selection. Scroll **only as much as necessary** — if part of a selection is visible, don't scroll the rest in.
- Zoom: set sensible **min/max scale** limits.

**Scroll edge effects (iOS, iPadOS, macOS — Liquid Glass era).**
- A *scroll edge effect* visually separates floating elements (toolbars etc.) from the scrolling content behind them. Styles: **automatic** (default), **hard**, **soft** (`ScrollEdgeEffectStyle` / `UIScrollEdgeEffect.Style` / `NSScrollEdgeEffectStyle`).
- **Prefer the automatic style.** It gives a more opaque separation for top toolbars with many controls, for text outside Liquid Glass controls, and for pinned table headers. If you choose soft, you must test legibility across contexts.
- **Only use a scroll edge effect when a scroll view sits behind floating interface elements.** "Scroll edge effects aren't decorative… they exist to ensure controls stay visually distinct." They don't block or darken like overlays.
- **One scroll edge effect per view.** In split-view layouts on iPad/Mac, each pane may have its own — but keep their **heights consistent** to maintain alignment.
- Custom bars: you may need to add the effect manually if your interface's top layer needs extra clarity.

**iOS vs macOS.**
- macOS terminology: scroll indicator = **scroll bar**. Panels may use **small or mini scroll bars** when space is tight — and then *all* controls in that panel must use the same size.
- iOS/iPadOS: in page-by-page mode, consider showing a **page control**, and **don't show a scroll indicator on the same axis** as the page control (redundant controls).
- Scroll edge effects apply to iOS, iPadOS, and macOS alike.

**Reviewer checks.**
- Same-orientation nested scroll views → violation.
- Content that scrolls but gives no visual hint (no partial content at edges, nothing cut off at fold) → flag.
- Floating toolbar/header over scrolling content with no scroll edge effect, or with a decorative gradient/overlay doing that job → flag (use the system effect, prefer automatic).
- Two stacked edge effects in one view, or split-view panes with mismatched edge-effect heights → violation.
- Page-style horizontal scroller showing both a page control and a horizontal scroll indicator → violation.
- Custom scroll physics without elastic bounce → violation.
- HTML prototypes: `overflow: hidden` clipping content with no scroll affordance; non-rubber-banding custom scrollers; fixed headers with hard `border-bottom` instead of an edge-effect-like treatment → flag for fidelity.

**Stale-knowledge corrections.** **Biggest currency item in this bucket.** Pre-2025 models know nothing of scroll edge effects — they'll assume the old translucent-blur-under-bars model or suggest opaque bars with hairline separators. Current model: content scrolls edge-to-edge under floating Liquid Glass bars, and the *scroll edge effect* (automatic/hard/soft) is the sanctioned separation mechanism — not shadows, not gradient scrims, not opaque bars. The June 2026 update (this week) clarified: automatic > soft as default, effects are functional not decorative, one per view, consistent heights across panes. Also note `NSScrollEdgeEffectStyle` exists — this applies to **macOS** too, not just iOS.

---

## Sheets

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/sheets
**Platforms:** all. **Updated 2026-03-24: button placement.** SwiftUI `sheet`; UIKit `UISheetPresentationController`; AppKit `presentAsSheet`.

**Purpose.** A view for a **scoped task closely related to the current context** (supply info, complete a simple task, then return to the parent). Governs modal/nonmodal anatomy, standard buttons, detents/grabber (iOS), and per-platform presentation.

**Normative rules — anatomy & buttons.**
- macOS/tvOS/visionOS/watchOS sheets are **always modal**. iOS/iPadOS sheets can be **modal or nonmodal** (nonmodal example: Notes' text-format sheet — interact with parent while sheet stays up).
- Standard buttons: **Cancel** (or Close) dismisses without saving; **Done** dismisses after completing/saving; **Back** goes to a previous step/parent view in a multi-step flow — it never dismisses the sheet.
- **If you provide Done, always pair it with Cancel** (or Back in a multi-step flow). Done alone implies completing the task is the only exit — "restrictive or misleading".
- **Avoid showing all three (Cancel, Done, Back) together.**
- **One sheet at a time from the main interface.** If an action in a sheet leads to another sheet, close the first before showing the second (optionally restore the first after).
- For complex/prolonged flows, prefer alternatives: iOS/iPadOS full-screen modal style (`UIModalPresentationStyle.fullScreen`) for video/photo/camera/multistep editing; macOS: a new window or full-screen mode (self-contained tasks like document editing → separate window).
- Nonmodal supplementary content: iOS/iPadOS nonmodal sheet; macOS **panel**; visionOS split view.

**Normative rules — iOS/iPadOS specifics.**
- Single-view sheets: **Cancel on the leading edge of the top toolbar; Done on the trailing edge.** Multi-step flows: placement can vary across steps.
- Resizable sheets rest at **detents**: system **large** (full height) and **medium** (≈ half of full height); custom detents allowed. Large is automatic; adding medium enables both; specifying only medium prevents full-height expansion.
- iPhone: **consider the medium detent for progressive disclosure** (share-sheet pattern: most relevant items visible at medium, scroll/expand for more). Skip medium when content needs full height (Messages/Mail compose are full-height only).
- **Include a grabber** in a resizable sheet (drag to resize; tap to cycle detents; works with VoiceOver).
- **Support swipe-to-dismiss**; if there are unsaved changes when the swipe begins, confirm via an **action sheet**.
- iPad: **prefer page or form sheet presentation styles** — default-sized, centered over a dimmed background.

**Normative rules — macOS specifics.**
- A macOS sheet is a **cardlike rounded-corner view floating on top of its parent window**, document-modal: parent dims and is blocked until dismissal, but **other app windows must remain accessible** (people expect to interact with other windows before dismissing a sheet; bring parent + its panels forward when the sheet opens).
- Present at a **reasonable default size**; resizing usually unnecessary but worth supporting when content benefits.
- **Repeated input-observe-result loops → use a panel, not a sheet** (e.g. find-and-replace).

**iOS vs macOS (side by side).**
| | iOS/iPadOS | macOS |
|---|---|---|
| Modality | modal or nonmodal | always modal (to its window) |
| Presentation | card from bottom (iPhone); page/form sheet centered + dimmed (iPad) | card attached to/floating over parent window, parent dimmed |
| Resize | detents (large/medium/custom), grabber | freeform resize optional, no detents |
| Dismissal | swipe down + buttons | buttons only |
| Scope of blocking | app screen | parent window only — other windows stay usable |

**Reviewer checks.**
- Done present without Cancel/Back → violation (2026 rule). Cancel + Done + Back all visible → violation.
- iOS sheet: Cancel not top-leading / Done not top-trailing → violation.
- Resizable iPhone sheet with no grabber → violation.
- Sheet stacked on a sheet → violation.
- Long multistep editing flow inside a sheet → flag (full-screen modal or, on macOS, a window).
- macOS find/replace-style repeat-interaction UI in a sheet → violation (panel).
- iPad sheet drawn full-screen edge-to-edge with no dimmed surround → flag (use page/form sheet).
- Compose-style content shown at medium detent → flag (needs full height).

**Stale-knowledge corrections.** The March 2026 button rules are new: *pair Done with an escape route* and *never all three buttons* — older models often produce Done-only sheets. Medium detent ≈ half height ("about half") and tap-grabber-to-cycle are post-iOS-15 details models usually know, but pairing rules and the swipe-dismiss-confirmation-via-action-sheet pattern are commonly missed. On macOS, sheets still attach to their parent window in the classic way — Liquid Glass didn't change sheet behaviour, only material rendering (iOS 26 sheets at smaller detents are inset Liquid Glass cards that become more opaque/edge-to-edge at full height — rendering detail from WWDC25, not on this page).

---

## Windows

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/windows
**Platforms:** ipados, macos, visionos — **NOT iOS** (no window concept exposed), not tvOS/watchOS. **Updated 2025-06-09 (Liquid Glass): best practices + resizable iPadOS windows.**

**Purpose.** Windows as containers: primary vs auxiliary, when to open new windows, macOS window anatomy/states, iPadOS windowing. (In-window layout → Layout page.)

**Normative rules — general.**
- Two conceptual types: **primary** window (main navigation + content) and **auxiliary** window (one dedicated task/area, no app-wide navigation, typically has a close button for ending the task).
- **Windows must adapt fluidly to different sizes** (multitasking/multiwindow).
- **Open new windows at the right moments**: great for multitasking/context preservation (Mail Compose opens a window so message + mailbox are both visible); excessive windows = clutter; don't open new windows as default behaviour without reason.
- Offer "open in new window" as an **option** — via context menu or File menu (`OpenWindowAction`).
- **Never create custom window UI** — no custom frames or window controls, and don't replicate the system look; imperfect copies make the app feel broken.
- User-facing term is **"window"** — never *scene* (implementation term).

**Normative rules — macOS.**
- Anatomy: **frame** (above the body; holds window controls + toolbar; rarely also a bottom bar below body content) + **body**. Drag frame to move; drag edges to resize.
- Three states: **Main** (frontmost window; one per app), **Key** (a.k.a. *active window*; accepts input; one onscreen at a time; usually = main, but a floating panel can be key instead; clicking the Dock icon makes only the most recently accessed window key), **Inactive** (not foreground).
- System appearance differences: key window's close/minimize/zoom controls are **coloured**; main-but-not-key and inactive windows show them **gray**; inactive windows don't use Materials (no colour pull-through from beneath) so they look subdued/farther away. Panels like Colors/Fonts become key only when you click their title bar or a keyboard-input component.
- **Custom windows must reproduce the system-defined state appearances** — with system components it's automatic; custom implementations must do this work.
- **Bottom bars: avoid critical info/actions there** (window bottoms often get pushed offscreen). If used, only small content tied to the window/selection (e.g. Finder status bar: item count, selection count, free space). More info → use an **inspector** (trailing split-view pane).

**Normative rules — iPadOS (clarifies adaptive behaviour).**
- Two user-selectable modes (Multitasking & Gestures settings): **Full screen** (switch via app switcher) and **Windowed** (free resize/reposition, multiple windows onscreen, system remembers size/placement across launches).
- **Window controls sit at the leading edge of the toolbar when windowed** — leading toolbar buttons must **move inward** when controls appear, never be overlapped/hidden.
- Consider gestures to spawn windows (e.g. pinch a Notes item into a window).

**iOS vs macOS.** iOS: page not applicable — a designer placing macOS-style traffic lights or floating windows in an iPhone mock is wrong by definition. macOS: full window-state system above. iPadOS now sits in between (Mac-like windowing, leading-edge window controls).

**Reviewer checks.**
- Custom-drawn window chrome (nonstandard traffic lights, custom title bars replicating system look) → violation.
- Mock showing key and inactive windows with identical control colours/material → flag (states must differ).
- Critical actions in a bottom bar → violation.
- iPad windowed mock: toolbar buttons flush at leading edge colliding with window controls → violation.
- The word "scene" in user-facing copy → violation.
- App that opens a new window for every interaction → flag.
- Info window implemented as auto-updating inspector or vice versa (cross-check with Panels) → flag.

**Stale-knowledge corrections.** Rewritten June 2025. iPadOS free-form windowing (with persistent size/placement and Mac-style window controls in the toolbar) is new — older models assume Split View/Slide Over multitasking as iPad's model. The primary/auxiliary terminology is the current framing. macOS Tahoe windows have larger corner radii and Liquid Glass toolbars (Materials/Toolbars pages), but window-state semantics (main/key/inactive) are unchanged.

---

## Activity rings (Status; not in hint list but in index)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/activity-rings
**Platforms:** ios, ipados, watchos — **NOT macOS**. HealthKit `HKActivityRingView`. Last change 2024-03-29 (specific colours listed).

**Purpose.** The Apple Move/Exercise/Stand rings; governs when third-party apps may show them and the strict visual-integrity rules.

**Normative rules.**
- Display only when relevant (health/fitness apps, esp. those writing to HealthKit) — e.g. workout metrics screens, post-workout summaries.
- **Only** for Move/Exercise/Stand data; never replicate/modify rings for other data; never show Move/Exercise/Stand in another ring-like element.
- One person's data only; label/photo/avatar must make whose-rings obvious.
- Visual integrity (hard rules): **never change ring colours** (no filters/opacity changes); **always on a black background**; prefer enclosing in a circle via corner radius of the enclosing view (not a circular mask); keep black visible around the outermost ring (thin black stroke if needed; no gradient/shadow/effects); scale appropriately; adapt the surrounding UI to the rings, never the rings to the UI.
- Associated labels/values use the matching colours — **Move: RGB 250, 17, 79; Exercise: RGB 166, 255, 0; Stand: RGB 0, 255, 246** (extracted from the page's swatch alt text).
- **Minimum outer margin ≥ the distance between rings**; nothing may crop/obstruct/encroach on margin or rings.
- Differentiate any other ring-like elements (padding, lines, labels, colour, scale).
- No redundant notifications duplicating the system's Activity updates; no ring element inside notifications.
- **Never decorative; never branding** (not in app icons or marketing).
- iOS shows all three rings with an Apple Watch paired; **Move ring only** (step/workout approximation) without.

**iOS vs macOS.** iOS/iPadOS + watchOS only; never in macOS designs.

**Reviewer checks.**
- Ring-like progress element using Apple's three-ring stack or its colours for non-Activity data → violation.
- Rings on non-black background, recoloured, masked, with shadows/gradients, or cropped margins → violation.
- Rings in an app icon, marketing art, label, or background graphic → violation.
- Rings for multiple people without per-person attribution → violation.
- Move/Exercise/Stand labels in colours other than the specified RGBs → violation.

**Stale-knowledge corrections.** The exact RGB values and the "Move-ring-only when unpaired" iOS behaviour are 2024 additions models may not have. The rest is long-standing trademark-style protection.

---

## Gauges (Status)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/gauges
**Platforms:** ios, ipados, macos, visionos, watchos (not tvOS). SwiftUI `Gauge`; AppKit `NSLevelIndicator`.

**Purpose.** Displaying one numerical value within a range, on a circular or linear path; plus macOS level indicators.

**Normative rules.**
- Anatomy: circular or linear path mapping the current value to a point. **Standard** style = indicator marking the value's location; **capacity** style = fill stopping at the value. **Accessory** variant mimics watchOS complications — for iOS Lock Screen widgets and anywhere echoing complication appearance.
- **Write succinct labels for the current value AND both endpoints of the range** — VoiceOver reads visible labels; not every style displays all labels.
- Consider a **gradient fill to communicate meaning** (e.g. red→blue for hot→cold).
- macOS additionally has **level indicators** (`NSLevelIndicator`) conveying **capacity, rating, or (rarely) relevance**. Capacity style is discrete (segments) or continuous; **use continuous for large ranges** (segments get uselessly small). Default fill is **green**; change fill colour at significant levels (very low/very high/past middle) or use the **tiered** state for a colour sequence in one indicator. Relevance style = shaded horizontal bar (e.g. search-result relevance).

**iOS vs macOS.** Gauge component is cross-platform with no iOS-specific notes; macOS layers the separate level-indicator family on top (capacity/rating/relevance) — those are macOS-only idioms.

**Reviewer checks.**
- Gauge without value/endpoint labels (or with labels VoiceOver can't make sense of) → flag.
- Discrete segmented capacity indicator over a large range → flag (use continuous).
- Level indicators (segmented capacity bars) in iOS mocks → flag (macOS idiom; use Gauge).
- Gauge used for task progress → flag (use a progress indicator; gauges show a value in a range, not completion of an operation).

**Stale-knowledge corrections.** Page from 2022, stable. Accessory variant ties to iOS 16 Lock Screen widgets — known to most models. No Liquid Glass changes.

---

## Progress indicators (Status)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/progress-indicators
**Platforms:** all. Last change 2023-09-12. SwiftUI `ProgressView`; UIKit `UIProgressView`/`UIActivityIndicatorView`/`UIRefreshControl`; AppKit `NSProgressIndicator`.

**Purpose.** Determinate (progress bars, circular progress) and indeterminate (activity indicators/spinners) feedback for ongoing operations; iOS refresh controls.

**Normative rules.**
- Two types: **determinate** (well-defined duration; bar fills leading→trailing, circular fills clockwise) and **indeterminate** (*activity indicator* / *spinner*; animated). All progress indicators are **transient** — visible only while the operation runs.
- **Prefer determinate** whenever duration is knowable (lets people decide to wait/retry/abandon).
- **Report progress accurately and evenly** — 90% in five seconds then 10% in five minutes "can even feel deceptive"; even out the pace.
- **Keep indicators moving** — stationary = people assume stalled/frozen; if a process stalls, explain the problem and what to do.
- **Switch indeterminate → determinate** as soon as duration becomes known. **Never switch circular → bar** (shape/size jump disrupts the UI).
- Optional description: accurate, succinct; **avoid vague terms like "loading" or "authenticating"** — they seldom add value.
- **Consistent location** across screens/platforms so people can reliably find operation status.
- **Allow halting**: Cancel button if interruption is side-effect-free; add **Pause** too if cancelling loses work (e.g. partial download). If cancelling loses progress, confirm via an **alert** with resume option.
- macOS only: **prefer a spinner for background operations or constrained spaces** (e.g. inside a text field, next to a button); macOS also supports an **indeterminate progress bar**. **Don't label a spinner** (it appears in response to user action; label unnecessary).
- iOS/iPadOS **refresh control**: specialised activity indicator, hidden until people drag down a (typically) table view; **still perform automatic periodic updates** — never make pull-to-refresh the only freshness mechanism. Optional short title only if it adds value (e.g. Podcasts' "last updated" time) — never instructions on how to refresh.

**iOS vs macOS.**
- Refresh control: iOS/iPadOS only.
- Indeterminate progress *bar*: macOS only (iOS indeterminate = spinner only).
- macOS spinner labelling prohibition; macOS spinner-for-background-tasks preference.

**Reviewer checks.**
- Spinner where duration is knowable (file upload with known size, conversion) → violation (use determinate).
- Indicator that switches circular↔bar mid-task → violation.
- Caption "Loading…"/"Authenticating…" → flag (vague).
- Long operation with no Cancel (and no Pause when cancellation loses work) → flag.
- Pull-to-refresh present but no automatic refresh strategy → violation.
- Refresh-control title explaining the gesture ("Pull to refresh") → violation.
- macOS spinner with a text label → violation.
- Persistent/decorative progress element that stays after completion → violation (transient).
- Progress bar filling right→left in LTR locales → violation (fills leading→trailing).

**Stale-knowledge corrections.** Stable since 2023; no Liquid Glass changes. Models generally know this area; commonly missed specifics: the explicit ban on circular→bar transitions, the anti-"loading" copy rule, and Pause-in-addition-to-Cancel when cancellation destroys partial work.

---

## Rating indicators (Status)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/rating-indicators
**Platforms:** macOS ONLY. AppKit `NSLevelIndicator.Style.rating`.

**Purpose.** Horizontal row of symbols (stars by default) communicating a ranking level in macOS.

**Normative rules.**
- **No partial symbols** — the value rounds to whole symbols only.
- Symbols are always equidistant; they don't expand/shrink to fit the component's width.
- **Make rankings easy to change inline** in ranked lists — no separate editing screen.
- Custom symbol instead of the star: only if its rating purpose stays clear (the star is the recognised ranking symbol).

**iOS vs macOS.** macOS-only component. iOS rating UIs (e.g. App Store stars) fall under the **Ratings and reviews** pattern page, not this component. Cross-link: Gauges' macOS level indicator has a rating style — same underlying control.

**Reviewer checks.**
- Half-star / fractional-star display in a macOS rating control → violation.
- Stars that stretch or change spacing with container width → violation.
- Rating editable only via a separate edit screen → flag.
- Reviewer should NOT flag iOS star ratings against this page (different scope).

**Stale-knowledge corrections.** None — stable 2022 page. The trap is scope: models over-apply it to iOS, where display of aggregate ratings (with fractional stars in App Store style) is governed by the Ratings and reviews pattern instead.

---

## Cross-cutting observations for skill design

1. **Container-choice decision tree is the core value.** Alert vs action sheet vs sheet vs popover vs panel vs window is a single interlocking decision system spread across six pages: alert = unexpected/critical; action sheet = choices about a just-taken action; sheet = scoped subtask; popover = transient small content anchored to a control (regular width only); panel = persistent supplementary tools (macOS); window = parallel context (macOS/iPadOS). A reviewer skill should encode this as one tree, not six page summaries.
2. **Width class drives presentation on Apple platforms**: same trigger → popover on iPad/Mac, sheet on iPhone. HTML/Figma prototypes that hardcode one presentation across sizes violate this.
3. **Few numbers, many structural invariants.** Checkable rules are mostly button placement/pairing (Cancel leading + Done trailing; Done never alone; never Cancel+Done+Back), counts (≤3 alert buttons, ≤10 page dots, ≤2 indicator images, 1 popover, 1 sheet, 1 edge effect per view), and named styles (automatic/hard/soft; automatic/prominent/minimal).
4. **Currency hotspots vs stable core**: scroll edge effects (updated this week) and sheet button pairing (Mar 2026) and iPadOS windowing (Jun 2025) are the stale-knowledge dangers; the other nine pages are stable 2022-2024 guidance a model mostly knows.
5. **Status components are about honesty**: accurate/even progress, no vague copy, no fake spinners, transiency. These map directly to prototype-reviewable checks.
