# HIG research notes — components-selection-input

> Bucket: Components > Selection and input — color wells, combo boxes, image wells, pickers, segmented controls, sliders, steppers, text fields, toggles, virtual keyboards. (Digit entry views is tvOS-only → out of scope. "Onscreen keyboards" is the **old name** of the Virtual keyboards page, renamed 2023-06-21 — same page, not a missing one.)
> Source: Apple JSON content API (`developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`), all 10 pages fetched 2026-06-10.
> Currency: **none of these pages changed at WWDC 2026** (2026-06-08). Per-page change logs: Virtual keyboards 2025-06-09 (only Liquid Glass-era edit in the bucket), Toggles 2024-03-29, Pickers / Segmented controls / Sliders / Text fields 2023; Color wells, Combo boxes, Image wells, Steppers have no change log (unchanged since the 2021-06 HIG restructure). The Liquid Glass visual redesign of these controls (iOS 26 / macOS Tahoe 26) is **not specced on these pages** — visuals come from the system frameworks and Apple's Figma/Sketch 26 UI kits; the cross-cutting rule lives on the Materials page (see "Bucket-wide" below).

---

## Bucket-wide facts (apply across all pages here)

- **Liquid Glass and the content layer.** Materials page (current, fetched 2026-06-10), exact language: *"An exception to this is for controls in the content layer with a transient interactive element like sliders and toggles; in these cases, the element takes on a Liquid Glass appearance to emphasize its interactivity when a person activates it."* General rule remains **"Don't use Liquid Glass in the content layer."** So: selection/input controls sit in the content layer with standard appearances; the system gives slider thumbs and switch knobs a momentary Liquid Glass treatment **during interaction only**. Prototypes should not render these controls as permanently glassy.
- **Control-selection decision tree** distilled from cross-references on these pages:
  - 2 opposing states → toggle (switch/checkbox). 2–5 mutually exclusive options with always-visible labels → radio buttons (macOS) or segmented control. >~5 mutually exclusive options → pop-up button. Short list of choices → pull-down/pop-up button, **not** a picker. Medium-to-long list → picker. Very large set → list or table (height-adjustable, can have an index). Free text + suggested values (macOS) → combo box. Incremental numeric nudges → stepper (paired with a value display). Continuous range → slider; wide range → slider + text field + stepper together.
- Minimum hit-target sizes (44×44 pt iOS, 28×28 pt macOS) are owned by the Accessibility/Layout pages, not these component pages — cross-reference, don't duplicate.

---

## Color wells

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/color-wells
**Platforms:** iOS, iPadOS, macOS, visionOS (not tvOS/watchOS). **Last change:** none logged (stable since 2021).

### Purpose
Governs the control that lets people adjust the color of text, shapes, guides, and other onscreen elements. Tapping/clicking a color well displays a **color picker** — either the system-provided one or a custom interface.

### Normative rules
- **Consider the system-provided color picker for a familiar experience.** It is consistent across apps, lets people **save a set of colors accessible from any app**, and gives a familiar cross-platform experience (iOS/iPadOS/macOS).
- APIs: `UIColorWell` + `UIColorPickerViewController` (UIKit), `NSColorWell` (AppKit).

### iOS vs macOS
- iOS/iPadOS: no additional considerations — tap opens the system color picker (a sheet).
- macOS only: the well **receives a highlight on click** to confirm it's active, then opens the color picker; after selection the well updates to show the new color. macOS color wells support **drag and drop** — colors can be dragged well-to-well and from the picker to a well.

### Reviewer checks
- Custom color-choosing UI where the system picker would do → flag (lose saved-colors feature and familiarity).
- A color swatch control that doesn't visibly update to the chosen color after selection → violation.
- macOS prototype: color well with no active/highlight state → flag.

### Stale-knowledge corrections
- None significant; page is pre-Liquid-Glass and unchanged. `UIColorWell` (iOS 14+) may be missing from older mental models that assume color pickers are macOS-only.

---

## Combo boxes

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/combo-boxes
**Platforms:** **macOS ONLY** (explicitly "Not supported in iOS, iPadOS, tvOS, visionOS, or watchOS"). **Last change:** none logged.

### Purpose
Governs the macOS control combining a text field with a pull-down button: people type a custom value or pick from a predefined list. Custom entries are **not** added to the list of choices.

### Normative rules
- **Populate the field with a meaningful default value from the list** — it doesn't have to be the first item, but it should refer to the hidden choices (an empty default is allowed but discouraged).
- **Use an introductory label**: **title-style capitalization, ending with a colon** (standard macOS label convention).
- **Provide relevant choices** — the list should contain the most likely values; typing is the escape hatch.
- **List items must not be wider than the text field** — otherwise the field truncates them, hurting readability.
- API: `NSComboBox` (AppKit).

### iOS vs macOS
- macOS-only component. On iOS the equivalent need is met with a text field plus suggestions, a picker, or a pop-up button — never a combo box. (Text fields page: "Consider using a combo box if you need to pair text input with a list of choices" — macOS section only.)

### Reviewer checks
- Any combo box in an iOS mock → platform violation.
- macOS combo box: empty default value → flag; missing introductory label or label without colon/title case → flag; list items wider than field → flag.

### Stale-knowledge corrections
- None — but models sometimes hallucinate combo boxes (web `<select>` with typeahead) into iOS designs; the HIG is explicit it doesn't exist there.

---

## Image wells

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/image-wells
**Platforms:** **macOS ONLY**. **Last change:** none logged.

### Purpose
Governs the editable image view: after selecting an image well people can copy/paste/delete its image, or drag a new image in **without selecting it first** (e.g. contact photo wells).

### Normative rules
- **Revert to a default image when necessary** — if the well requires an image and someone clears it, redisplay the default.
- **If it supports copy and paste, the standard Edit-menu items (and standard keyboard shortcuts) must work** — people expect Cut/Copy/Paste/Delete to operate on the well.
- API: `NSImageView` (AppKit, editable configuration).

### iOS vs macOS
- macOS-only. On iOS, image selection goes through photo pickers / document pickers, not wells.

### Reviewer checks
- macOS image well that can be left empty when an image is required → flag missing default-image fallback.
- Prototype with an image well but no Edit-menu integration story → flag.

### Stale-knowledge corrections
- None; stable page.

---

## Pickers

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/pickers
**Platforms:** all. **Last change:** 2023-06-05 (watchOS).

### Purpose
Governs scrollable-list value choosers (one or more wheels/lists) and **date pickers**, which add calendar views and numeric-keypad entry. Values shown and their order **depend on device language/locale** (dates: device location).

### Normative rules
- **Consider a picker for medium-to-long lists.** Short list → use a **pull-down button** instead (a picker "adds too much visual weight to a short list"). Very large set → **list or table** (adjustable height; tables can have an index for fast section targeting).
- **Use predictable, logically ordered values** — many values are hidden until scrolled; people must be able to predict them (e.g. alphabetized countries).
- **Avoid switching views to show a picker** — display it in context, **below or in proximity to the field being edited**; typically at the bottom of a window or in a popover.
- **Minute granularity:** a minute wheel has 60 values by default (0–59); you may increase the interval only to values that **divide evenly into 60** (e.g. quarter-hour: 0, 15, 30, 45).

#### iOS/iPadOS date pickers — styles (exact terms)
- **Compact** — button showing editable date/time in the **app's accent color**; opens a **modal view** with calendar-style editor + time picker; people make multiple edits, then **tap outside the view to confirm**.
- **Inline** — time-only: button + wheels; date/time: an inline calendar view.
- **Wheels** — scrolling wheels; also accepts entry from built-in or external keyboards.
- **Automatic** — system picks the style per platform and mode.

#### iOS/iPadOS date pickers — modes (exact terms)
- **Date** (months / days / years), **Time** (hours / minutes / optional AM-PM), **Date and time**, **Countdown timer** (hours+minutes, **max 23 hours 59 minutes**; **not available in inline or compact styles**).
- **Use a compact date picker when space is constrained.**

### iOS vs macOS
- iOS/iPadOS: four styles × four modes as above; touch, keyboard, or pointer input.
- macOS: exactly **two styles** — **textual** (limited space; people make specific selections) and **graphical** (browsing a calendar, **selecting a range of dates**, or clock-face look). API `NSDatePicker`. Wheels-style pickers are not a macOS idiom; generic value selection on macOS uses pop-up buttons or `Picker` (SwiftUI) rendered as pop-up.

### Reviewer checks
- Picker used for ≤ ~5 options → recommend pull-down/pop-up button.
- Picker for huge data sets (e.g. all contacts) → recommend list/table.
- Picker presented on a separate screen instead of in-context (bottom of window / popover / under the field) → flag.
- Unordered or unpredictable wheel values → flag.
- Countdown timer shown in compact/inline style, or > 23:59 → spec violation.
- macOS mock using iOS wheels → platform violation.
- Minute intervals like 20-minute steps are OK (divides 60); 25-minute steps → violation.

### Stale-knowledge corrections
- Models trained pre-iOS 14 default to **wheels** for all date input; current default ("automatic") resolves to **compact** in most iOS contexts, and HIG actively recommends compact when space-constrained. Wheels are now one style among four, not the canonical look.
- Page predates Liquid Glass; the iOS 26 visual treatment (glass modal, capsule buttons) comes from the system, not from new rules here.

---

## Segmented controls

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/segmented-controls
**Platforms:** iOS, iPadOS, macOS, tvOS, visionOS (not watchOS). **Last change:** 2023-06-21.

### Purpose
Governs the linear set of two-or-more segments, each functioning as a button, used for closely related choices affecting an object, state, or view — and, on macOS, also multi-select or momentary-action button groups.

### Normative rules
- **Three behavior types** (don't mix in one control): single choice (e.g. Keynote text alignment), **multiple choice — macOS only** (e.g. Keynote bold/italic/underline font attributes), and **momentary action set** with no selection state (e.g. macOS Mail Reply / Reply all / Forward; APIs `isMomentary` / `momentary`).
- **Keep control types consistent within a single control** — never assign actions to some segments of a selection control or show selection state in an action control.
- **Limit segments: no more than about 5–7 in a wide interface; no more than about 5 on iPhone.**
- **Keep segment widths equal** and icon/title widths consistent; segments usually equal width.
- **Prefer either text or images, not a mix, within one control.**
- **Use content of similar size in each segment** (equal widths look bad when one segment's content fills it and another's doesn't).
- **Segment labels: nouns or noun phrases, title-style capitalization.** A text-labeled segmented control needs no introductory text.
- Segments can have text labels beneath them, or one label beneath the whole control.

### iOS vs macOS
- iOS/iPadOS: use to **switch between closely related subviews** (example: Calendar's New Event sheet switching Event/Reminder). For separate app sections use a **tab bar** instead. No multi-select on iOS.
- macOS: may add **introductory text**, per-segment labels below icon segments, and a **tooltip for each segment**. For view switching **in the main window area use a tab view, not a segmented control** — segmented controls switch views only in **toolbars or inspector panes**. Supports multi-select and momentary modes. **Consider supporting spring loading** (Magic Trackpad: drag items over a segment + force click to activate without dropping).

### Reviewer checks
- > 5 segments on iPhone, > 7 anywhere → flag.
- Mixed icons and text across segments of one control → flag.
- Visibly unequal segment widths (without strong reason) → flag.
- Multi-select segmented control in an iOS mock → platform violation.
- Segmented control used as primary app navigation on iOS → should be a tab bar.
- Segmented control switching main-window content on macOS → should be a tab view.
- Verb labels on selection-type segments → flag (nouns/noun phrases).

### Stale-knowledge corrections
- Old iOS muscle memory uses segmented controls in navigation bars as quasi-tabs everywhere; the Liquid Glass era pushes app-level section switching firmly to (floating, minimizable) tab bars — the segmented control's remit is *closely related subviews* only.
- iOS 26 renders segmented controls with capsule-shaped glass selection indicators — appearance comes from the system; no new HIG specs for it on this page.

---

## Sliders

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/sliders
**Platforms:** iOS, iPadOS, macOS, visionOS, watchOS (not tvOS). **Last change:** 2023-06-21.

### Purpose
Governs the horizontal (or vertical/circular) track with a **thumb** for adjusting between a minimum and maximum value; the track between the minimum and the thumb **fills with color**; optional **left/right icons** illustrate min/max meaning.

### Normative rules
- **Direction is fixed by convention:** horizontal — minimum on the **leading** side, maximum on the **trailing** side; vertical — minimum at the **bottom**, maximum at the **top**. (E.g. 0% leading → 100% trailing.)
- **Customize appearance only if it adds value** — customizable: track color, thumb image and tint color, left/right icons (e.g. small-image icon left, large-image icon right for an image-size slider).
- **Supplement wide-range sliders with a text field and stepper** so people can see and type exact values, and increment in whole numbers.
- **iOS/iPadOS: don't use a slider to adjust audio volume.** Use a **volume view** (includes a volume-level slider plus an output-device control / AirPlay route picker).

#### macOS-only specs
- Sliders may have **tick marks** for pinpointing values; in circular sliders tick marks render as evenly spaced dots around the circumference.
- **Linear slider thumb = narrow lozenge shape**; **circular slider thumb = small circle**.
- **Choose style by data shape:** horizontal slider for fixed start/end ranges (e.g. opacity 0–100%); **circular slider when values repeat or continue indefinitely** (e.g. rotation 0–360°; an animation app counting spins — 1440° = 4 spins).
- **Give live feedback while dragging** (e.g. Dock icons scale live with the Size slider in Dock settings).
- **Introduce with a label**: title-style capitalization, ends with a **colon**.
- **Use tick marks to increase clarity and accuracy**; add labels to ticks where needed — usually labeling **only the minimum and maximum** suffices; nonlinear scales (e.g. Energy Saver) need **periodic labels**; provide a **tooltip showing the thumb's value on hover**.

### iOS vs macOS
- iOS: no tick marks, no circular style, volume-view rule applies.
- macOS: tick marks, circular sliders, labels-with-colon, hover tooltips, live feedback emphasis.

### Reviewer checks
- Horizontal slider with max on the leading side (in LTR) → violation.
- Volume control drawn as a bare slider in iOS → violation (must be volume view with route control).
- Wide-range slider (e.g. 0–10,000) with no companion text field/stepper → flag.
- macOS slider for a cyclical value (angle/rotation) drawn linear → suggest circular.
- macOS slider label missing colon or using sentence case → flag.
- Tick-marked slider where every tick is labeled unnecessarily → flag (min/max usually enough).

### Stale-knowledge corrections
- iOS 26 redesigned the slider's look (thicker track, thumb that stretches with Liquid Glass while dragged) and the Materials page codifies that **a slider takes on a Liquid Glass appearance only while a person activates it** — a model assuming the thin pre-2025 track + static circular thumb, or one rendering sliders permanently glassy, is wrong on both ends. The slider page itself was NOT rewritten; don't invent numeric specs for the new look.
- "Don't use a slider for volume" predates 2025 but is among the most-violated rules in prototypes — keep it.

---

## Steppers

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/steppers
**Platforms:** iOS, iPadOS, macOS, visionOS (not tvOS/watchOS). **Last change:** none logged.

### Purpose
Governs the **two-segment control** for increasing/decreasing an incremental value. A stepper **doesn't display a value** — it must sit **next to a field that displays its current value**.

### Normative rules
- **Make the affected value obvious** — the stepper itself shows nothing, so adjacency/labeling must make clear what changes.
- **Pair with a text field when large value changes are likely** — steppers suit small changes (a few taps/clicks); for widely varying values give both (example: number of copies on a print screen = stepper + text field).
- APIs: `UIStepper` (UIKit), `NSStepper` (AppKit).

### iOS vs macOS
- iOS/iPadOS: no additional considerations.
- macOS only: **for large value ranges, consider supporting Shift-click** to change the value by more than the default increment (e.g. **10× the default**).

### Reviewer checks
- Stepper rendered with no adjacent visible value → violation (it never shows its own value).
- Stepper as the only input for a value that can vary widely (e.g. quantity 1–999) → flag, pair with text field.
- Stepper used where a slider/picker fits better (continuous range, long list) → flag.

### Stale-knowledge corrections
- None; stable page. (Visual: iOS steppers have been the gray rounded "− | +" pill since iOS 13; older models drawing bordered blue steppers are out of date.)

---

## Text fields

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/text-fields
**Platforms:** all. **Last change:** 2023-06-05.

### Purpose
Governs the rectangular single-line area for entering/editing **small, specific pieces of text** (name, email). Larger amounts of text → **text view**.

### Normative rules
- **Show a hint (placeholder) to communicate purpose** — e.g. "Email", "Password" — but because placeholder text **disappears when typing starts**, also include a **separate label** describing the field.
- **Always use a secure text field for sensitive data** (passwords). API: `SecureField` (SwiftUI).
- **Match field width to the anticipated quantity of text** — size signals expected input length.
- **Evenly space multiple fields; stack vertically when possible; use consistent widths** to group (e.g. first/last name share one width; address/city another) so each input visually pairs with its label.
- **Tab order must flow logically** — the system usually handles it; don't break it.
- **Validate at the contextually right time:** digits-only field → alert on non-digit entry; **email address → validate when people switch to another field**; **new username or password → validate before people can switch to another field**.
- **Use a number formatter for numeric data** (restricts to numeric values; can format decimals/percent/currency) — but **never assume presentation; formatting varies by locale**.
- **Line-break behavior:** default **clips** text beyond bounds; alternatives — wrap at character or word level, or **truncate with ellipsis at beginning, middle, or end**.
- **Consider an expansion tooltip** (pointer hover) showing the full clipped/truncated text — behaves like a regular help tag (macOS-relevant).
- **iOS/iPadOS (+tvOS/visionOS): show the appropriate keyboard type** for the content (see Virtual keyboards).

### iOS vs macOS
- iOS/iPadOS only:
  - **Display a Clear button at the trailing end** so people can erase input without repeatedly tapping Delete.
  - **Images/buttons inside the field:** **leading end = indicate the field's purpose** (icon), **trailing end = additional features** (e.g. system Bookmarks button).
- macOS only: **consider a combo box** when pairing text input with a list of choices; expansion tooltips are a pointer idiom.

### Reviewer checks
- Password/secret field shown with visible characters → violation (secure field required).
- Placeholder used as the only label on a form → flag (label disappears on typing).
- Form fields of random widths / uneven vertical spacing → flag.
- Long-input use case (message body, notes) drawn as a single-line text field → should be a text view.
- iOS text field for email/number/URL with the default keyboard in the mock → flag wrong keyboard type.
- iOS field with trailing icon used for "purpose" and leading icon for an action → ends are swapped, flag.
- Missing Clear button on iOS fields where users enter/redo queries → flag.

### Stale-knowledge corrections
- The "placeholder is not a label" rule is old but still the #1 form mistake; current HIG keeps it.
- iOS 26 renders text fields with a higher-radius, glassier focus treatment — system-provided; no new metrics published on this page. Search-specific fields are governed by the separate Search fields page (different bucket), which DID get 2026 updates.

---

## Toggles

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/toggles
**Platforms:** all. **Last change:** 2024-03-29 (enhanced macOS switch guidance; checkbox title clarification; radio button artwork).

### Purpose
Governs the control for choosing between **a pair of opposing states** (on/off) with distinct appearances per state. Styles: **switch** and **checkbox** (macOS also defines **radio buttons** here for related behavior); all platforms additionally support **buttons that behave like toggles** (`ToggleStyle`).

### Normative rules
- **Use a toggle only to manage the state of something** — for choosing from a list of items use a different component (e.g. pop-up button).
- **Clearly identify what the toggle affects** — usually surrounding context suffices; macOS often adds a label describing the controlled state.
- **State differences must be obvious and NOT color-only** — add/remove a color fill, show/hide the background shape, or change inner details (checkmark/dot). Color-only state fails for people who can't perceive the difference.

#### iOS / iPadOS
- **Use the switch style ONLY in a list row.** No label needed there — the row content provides context.
- **Outside a list, use a button that behaves like a toggle, not a switch** (example: Phone app's recents filter button — blue highlight when active, removed when inactive). API: `changesSelectionAsPrimaryAction`.
- **Avoid a label explaining the toggle-button's purpose** — the icon plus the two background appearances should communicate it.
- **Change the default green switch color only if necessary**; an accent color is OK if it keeps **enough contrast with the uncolored (off) appearance**.

#### macOS
- Supports **switch + checkbox styles, plus radio buttons**.
- **Use switches, checkboxes, and radio buttons in the window body, NOT the window frame** — never in a toolbar or status bar.
- **Switches:** prefer for **settings you want to emphasize** — a switch has more visual weight than a checkbox, so it should control *more* functionality (e.g. turn a whole group of settings on/off). **In a grouped form, consider a mini switch per row** (mini switch height ≈ buttons/other controls → consistent row heights); hierarchy = regular switch for the primary setting, mini switches for subordinates (`GroupedFormStyle`, `ControlSize`). **In general, don't replace an existing checkbox with a switch.**
- **Checkboxes:** small square button — empty = off, **checkmark = on, dash = mixed**; title on the **trailing** side (titleless allowed in editable checklists). Use checkboxes (not switches) **for hierarchies of settings** — leading-edge alignment + indentation shows dependencies. **A governing checkbox must show the mixed state** when its subordinates differ (`allowsMixedState`). Introduce a checkbox group with a label whose **baseline aligns with the first checkbox**.
- **Radio buttons:** small circular button + label, **typically in groups of 2–5**, mutually exclusive. Selected = filled circle, deselected = empty; mixed (dash) exists but is rarely useful — prefer a checkbox for mixed state. **More than about 5 options → use a pop-up button instead.** **Single on/off setting → prefer a checkbox** (rare exception: a pair of radio buttons when the two states aren't obvious opposites). **Horizontal layouts: measure the longest label and use that spacing consistently.**
- **More than two mutually exclusive options → radio buttons, not checkboxes.** Multiple selectable options in a set → checkboxes, not radio buttons.

### iOS vs macOS (summary table)
| Need | iOS | macOS |
|---|---|---|
| On/off in a list/form row | Switch (no label) | Mini switch (grouped form) or checkbox |
| On/off elsewhere | Toggle-style button (icon, background changes) | Checkbox (default) or switch if emphasized |
| Mutually exclusive 2–5 options | Segmented control / picker | Radio buttons |
| Mixed/partial state | — (not an iOS idiom) | Checkbox with dash |
| Placement constraint | — | Body only; never toolbar/status bar |

### Reviewer checks
- iOS switch floating outside a list row → violation (use a toggle button).
- Checkbox or radio button in an iOS mock → platform violation (web/macOS idioms leaking in).
- macOS switch/checkbox/radio in a toolbar or status bar → violation.
- Parent checkbox over differing children without a mixed (dash) state → violation.
- Radio group with > 5 options → use pop-up button.
- Toggle states distinguished by hue only (same shape/fill/inner mark) → accessibility violation.
- Checkbox title on the leading side → flag (trailing is standard).
- A macOS settings panel where every single row uses full-size switches → flag (checkboxes or mini switches; switches are for emphasis).

### Stale-knowledge corrections
- **macOS switches are now first-class** (System Settings-style grouped forms, mini switch guidance added 2024-03-29). Models trained on pre-Ventura material assume "switches are iOS-only; macOS = checkboxes" — half-wrong: checkboxes remain the default, but switches are sanctioned for emphasized/group settings, with the explicit caveat *don't convert existing checkboxes*.
- The **mini switch** concept (matching grouped-form row height) post-dates most training data.
- iOS toggle-style buttons (`changesSelectionAsPrimaryAction`, SwiftUI `ToggleStyle` buttons) are the modern replacement for ad-hoc "active state" buttons — older models reach for UISwitch everywhere.
- iOS 26 gives switch knobs a Liquid Glass treatment **during interaction** (Materials page) — not a permanent glass look.

---

## Virtual keyboards

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/virtual-keyboards
**Platforms:** iOS, iPadOS, tvOS, visionOS, watchOS — **NOT macOS**. **Last change:** 2025-06-09 (custom controls above keyboard + Liquid Glass; watchOS availability). **Renamed from "Onscreen keyboards" 2023-06-21.**

### Purpose
Governs the system virtual keyboards on devices without physical keyboards, plus the two customization mechanisms: **custom input views** (replace the system keyboard *within your app*) and **custom keyboards** (app extensions installed system-wide).

### Normative rules
- **Choose a keyboard matching the content type** — e.g. numbers-and-punctuation keyboard for numeric data; email keyboards include **"@" and a period, even ".com"**. Setting a **semantic content type** lets the system auto-pick the keyboard and refine autocorrect. APIs: `keyboardType(_:)`, `textContentType(_:)` (SwiftUI); `UIKeyboardType`, `UITextContentType` (UIKit).
- **Customize the Return key when it clarifies the action** — e.g. a **Search** Return key when the field initiates search. APIs: `submitLabel(_:)` (SwiftUI), `UIReturnKeyType` (UIKit).
- **A virtual keyboard doesn't support keyboard shortcuts.**
- **Custom input views** (in-app replacement, e.g. Numbers' numeric/formula keypad):
  - Must make sense in context — people must understand why they can't get the system keyboard back inside your app.
  - **Play the standard keyboard sound** on key taps (`playInputClick()`); respects the global Settings > Sounds toggle.
- **Custom keyboards** (app extension; iOS/iPadOS/tvOS):
  - Work in any app once enabled in Settings, **except secure text fields and phone number fields** (system blocks them there).
  - **Provide an obvious switch mechanism** equivalent to the **Globe key** (which replaces the dedicated Emoji key when multiple keyboards are installed).
  - **Don't duplicate system-provided keys** — on some devices the Emoji/Globe and **Dictation** keys automatically appear *beneath* the keyboard, outside your control.
  - **Offer a tutorial in the app, not inside the keyboard itself.**
  - Right scope test: build a custom keyboard only for **system-wide** input innovation (novel input method, unsupported language); in-app needs → custom input view instead.

#### iOS/iPadOS layout integration (2025-06-09, Liquid Glass era)
- **Use the keyboard layout guide** (`UIKeyboardLayoutGuide`; SwiftUI `ToolbarItemPlacement`) so the keyboard feels integrated and important UI stays visible when the keyboard is up.
- **Input accessory views above the keyboard** (e.g. Numbers' calculation controls): controls must be **relevant to the current task**; **"If other views in your app use Liquid Glass, or if your view looks out of place above the keyboard, apply Liquid Glass to the view that contains your controls"**; **a standard toolbar automatically adopts Liquid Glass**; position with the keyboard layout guide and **standard padding**.

### iOS vs macOS
- Entirely an iOS/iPadOS concern; **not supported in macOS** (hardware keyboards; the macOS Accessibility Keyboard is a system feature, not a design surface). macOS keyboard guidance (shortcuts, focus) lives on the separate **Keyboards** page (Inputs section, different bucket).

### Reviewer checks
- iOS mock with an email/phone/URL/numeric field showing the default QWERTY keyboard → flag wrong keyboard type.
- Search field whose keyboard shows a plain "return" key → suggest Search return key.
- Custom accessory bar above the keyboard drawn as an opaque flat strip while the rest of the app uses Liquid Glass → flag (should adopt Liquid Glass; standard toolbar gets it free).
- Keyboard overlapping the focused field or critical actions in a scrolled state → flag (keyboard layout guide misuse).
- Custom keyboard concept that exists only for one app's needs → should be a custom input view.
- Custom keyboard mock including its own emoji/globe/dictation keys → flag duplication.

### Stale-knowledge corrections
- **Page name:** older models cite "Onscreen keyboards" — the page has been "Virtual keyboards" since June 2023 (slug `virtual-keyboards`).
- **The accessory-view Liquid Glass rule is new (2025-06-09)** — the only Liquid Glass-specific normative text in this entire bucket. Pre-2025 models render input accessory bars as flat gray `UIToolbar` strips; current guidance wants glass consistency.
- watchOS now has a real virtual keyboard on larger screens (noted for completeness; out of scope).

---

## Cross-page synthesis for the skill suite

1. **Component availability matrix is the highest-value artifact.** Hard platform walls: combo boxes and image wells are macOS-only; virtual keyboards, the switch-in-list-row pattern, and the Clear button are iOS-only; checkboxes/radio buttons are macOS-only idioms. iOS mocks containing checkboxes/combo boxes (web habits) are the most common class of violation.
2. **This bucket is ~80% "which control for which job" decision rules** with a small set of hard numbers: ≤5 segments on iPhone / 5–7 wide; radio groups 2–5, >5 → pop-up; minute intervals must divide 60; countdown ≤ 23:59; Shift-click stepper = 10× increment. A decision tree + short numeric checklist covers it.
3. **Pairing/adjacency rules are mechanically checkable on static screens:** stepper requires adjacent value display; wide-range slider requires text field + stepper; placeholder requires a persistent label; password requires secure entry; macOS labels require title case + colon.
4. **None of these component pages got the Liquid Glass rewrite** (latest content edits 2023–2024 except Virtual keyboards 2025). Visual truth for the 26-era look lives in Apple's UI kits and the Materials page; the one cross-cutting rule to enforce is *controls are content-layer, glass only transiently on activation (sliders/toggles)* plus *keyboard accessory views adopt Liquid Glass*.
