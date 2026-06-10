<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: color-wells, combo-boxes, image-wells, pickers, segmented-controls, sliders, steppers, text-fields, toggles, virtual-keyboards, materials -->

# Components — selection and input
Bucket-wide: none of these pages was rewritten for Liquid Glass. These controls sit in the content layer with standard appearances — "Don't use Liquid Glass in the content layer"; the one exception (Materials page): controls with a transient interactive element (sliders, toggles) take on Liquid Glass only while a person activates them — never permanently. The 26-era visuals are system-drawn; do not invent metrics for them. <!-- src: materials -->
Control-choice decisions: trees-controls.md. Hit-target minima: owned by accessibility/layout, not these pages.

## color-wells
<!-- src: color-wells · changed: none logged · platforms: iOS, iPadOS, macOS, visionOS · speed: stub -->
- Tapping/clicking opens a colour picker. Prefer the system-provided color picker: consistent across apps; lets people save colours accessible from any app. APIs: `UIColorWell` + `UIColorPickerViewController` (iOS 14+), `NSColorWell`.
- The well must visibly update to the chosen colour after selection.
- macOS only: highlights on click to confirm it is active (flag a well without this); colours support drag and drop (well-to-well, picker-to-well).
- Fetch for detail: color-wells

## combo-boxes
<!-- src: combo-boxes · changed: none logged · platforms: macOS ONLY · speed: stub -->
- **macOS only** — explicitly not supported on iOS/iPadOS. A combo box in an iOS mock is a platform violation; use a text field with suggestions, a picker, or a pop-up button there.
- Text field + pull-down list: type a custom value or pick one; custom entries are NOT added to the list.
- Populate with a meaningful default from the list. Introductory label: title-style capitalization, ending with a colon. List items must not be wider than the field. API: `NSComboBox`.
- Fetch for detail: combo-boxes

## image-wells
<!-- src: image-wells · changed: none logged · platforms: macOS ONLY · speed: stub -->
- **macOS only.** iOS image selection goes through photo/document pickers, never wells.
- Editable image view; accepts a dragged-in image without prior selection.
- If an image is required and someone clears it, revert to a default image. If it supports copy/paste, the standard Edit-menu commands and shortcuts must work on it. API: `NSImageView` (editable).
- Fetch for detail: image-wells

## pickers
<!-- src: pickers · changed: 2023-06-05 · platforms: all · speed: full -->
Scrollable-list value choosers plus date pickers. Values and order follow device language/locale.

Rules:
- Pickers suit medium-to-long lists. Short list (≤ ~5) → pull-down button. Very large set (all contacts) → list or table.
- Predictable, logically ordered values — most are hidden until scrolled.
- Don't switch views to show a picker; display it in context, below or near the field being edited (bottom of window, or a popover).
- Minute wheel: 60 values (0–59) by default; custom intervals must divide evenly into 60 (15 yes, 20 yes, 25 no).

iOS/iPadOS date picker styles (exact terms): **Compact** (accent-colour button opening a modal calendar+time editor; tap outside to confirm) · **Inline** · **Wheels** (also accepts keyboard entry) · **Automatic** (system chooses). Modes: **Date** · **Time** · **Date and time** · **Countdown timer** (max 23 hours 59 minutes; NOT available in inline or compact styles). Use compact when space is constrained.

macOS: exactly two styles — **textual** (limited space, specific selections) and **graphical** (calendar browsing, date-range selection, clock face); `NSDatePicker`. Wheels are not a macOS idiom; generic value choice uses pop-up buttons.

Reviewer checks: countdown timer in compact/inline style, or above 23:59 → spec violation · minute interval not dividing 60 → violation · iOS wheels in a macOS mock → platform violation · picker on a separate screen → flag.

Stale priors:
- Was: wheels as the canonical date input. Now: automatic resolves to compact in most iOS contexts; wheels are one of four styles (since iOS 14).

## segmented-controls
<!-- src: segmented-controls · changed: 2023-06-21 · platforms: iOS, iPadOS, macOS, tvOS, visionOS · speed: full -->
Linear set of two-plus segments acting as buttons, for closely related choices affecting an object, state, or view.

Rules:
- Three behaviour types, never mixed in one control: single choice; multiple choice (**macOS only** — e.g. bold/italic/underline); momentary action set with no selection state (macOS Mail Reply/Reply all/Forward; `isMomentary`).
- Limits: no more than about 5 segments on iPhone; about 5–7 in a wide interface.
- Equal segment widths; similar-sized content per segment; text OR images, never a mix; labels = nouns or noun phrases, title-style capitalization.

iOS vs macOS:
- iOS/iPadOS: switch between closely related subviews (Calendar's Event/Reminder sheet). Separate app sections → tab bar. No multi-select.
- macOS: may add introductory text, labels under icon segments, per-segment tooltips; multi-select and momentary modes; consider spring loading. Main-window view switching uses a tab view — segmented controls switch views only in toolbars or inspector panes.

Reviewer checks: over the segment limits, mixed icons+text, unequal widths, or verb labels → flag · multi-select on iOS → platform violation · primary app navigation on iOS → should be a tab bar · main-window view switching on macOS → should be a tab view.

Stale priors:
- Was: segmented controls as quasi-tabs in navigation bars. Now: app-level section switching belongs to the floating, minimising tab bar (see tab-bars); the remit here is closely related subviews only. The iOS 26 capsule glass indicator is system-drawn; no specs published here.

## sliders
<!-- src: sliders · changed: 2023-06-21 · platforms: iOS, iPadOS, macOS, visionOS, watchOS · speed: full -->
Track with a thumb between minimum and maximum; the track fills with colour up to the thumb; optional end icons illustrate min/max.

Rules:
- Direction is fixed by convention: horizontal — minimum leading, maximum trailing; vertical — minimum at the bottom.
- Customise (track colour, thumb image/tint, end icons) only when it adds value.
- Wide-range sliders: add a text field and stepper so people can see and type exact values.
- iOS/iPadOS: never a bare slider for audio volume — use a volume view (volume slider + AirPlay route control).

macOS only:
- Tick marks for pinpointing values; label usually only minimum and maximum; nonlinear scales need periodic labels; tooltip with the thumb's value on hover.
- Thumbs: linear = narrow lozenge; circular = small circle. Horizontal for fixed ranges (opacity 0–100%); circular when values repeat or continue indefinitely (rotation; 1440° = 4 spins).
- Live feedback while dragging (Dock's Size slider). Introductory label: title-style capitalization, ending with a colon.

Reviewer checks: maximum on the leading side (LTR) → violation · iOS volume drawn as a bare slider → violation (among the most-violated rules in prototypes) · wide range with no text field/stepper → flag · macOS cyclical value drawn linear, label missing its colon, or every tick labelled → flag.

Stale priors:
- Was: thin track, static circular thumb — or, over-corrected, a permanently glassy control. Now: iOS 26 draws a thicker track and the thumb takes on Liquid Glass only while dragged (Materials-page rule, since 2025-06-09). No numbers published for the new look — don't invent them.

## steppers
<!-- src: steppers · changed: none logged · platforms: iOS, iPadOS, macOS, visionOS · speed: stub -->
- A stepper never displays its own value — it must sit next to a field showing it; no adjacent visible value = violation.
- Suits small increments only. Widely varying values → pair with a text field (print-copies pattern).
- macOS only: for large ranges, consider Shift-click changing the value by more than the default increment (e.g. 10× the default).
- APIs: `UIStepper`, `NSStepper`.
- Fetch for detail: steppers

## text-fields
<!-- src: text-fields · changed: 2023-06-05 · platforms: all · speed: stub -->
Single-line entry for small, specific text; anything longer → text view. The non-obvious rules:
- Placeholder text disappears on typing — always pair it with a separate persistent label. Sensitive data → secure text field (`SecureField`), always.
- Match field width to expected input; consistent grouped widths, even spacing, vertical stacking; don't break system tab order.
- Validation timing: digits-only field → alert on non-digit entry; email → validate when people switch away; new username/password → validate BEFORE they can switch away.
- Numeric data → number formatter; presentation varies by locale.
- iOS/iPadOS only: Clear button at the trailing end; in-field icons — leading = the field's purpose, trailing = additional features. Show the matching keyboard type (see virtual-keyboards).
- macOS: consider a combo box when pairing input with a list of choices.
- Hot checks: visible password characters · placeholder as the only label · long-form content in a single-line field · icon ends swapped on iOS.
- Fetch for detail: text-fields

## toggles
<!-- src: toggles · changed: 2024-03-29 · platforms: all · speed: full -->
A pair of opposing states. Styles: switch and checkbox; macOS also defines radio buttons here; all platforms support buttons that behave like toggles (`ToggleStyle`).

Rules (all platforms): a toggle manages the state of something — choosing from a list needs another component. Make what it affects unmistakable. State differences must NOT be colour-only — add/remove a fill, show/hide the background shape, or change inner details (checkmark/dot).

iOS/iPadOS:
- Switch style ONLY in a list row (no label — the row provides context).
- Outside a list: a button that behaves like a toggle, not a switch (`changesSelectionAsPrimaryAction`); no explanatory label — icon plus the two background appearances communicate.
- Change the default green switch colour only if necessary; keep contrast with the off appearance.

macOS:
- Switches, checkboxes, radio buttons go in the window body, NEVER the window frame (no toolbars or status bars).
- Switches: for settings you want to emphasise — more visual weight, so they should control more (e.g. a whole group). Grouped forms: regular switch for the primary setting, mini switches per subordinate row. Don't replace existing checkboxes with switches.
- Checkboxes: empty = off, checkmark = on, dash = mixed; title trailing. Use for hierarchies of settings (indentation shows dependency); a governing checkbox MUST show the mixed state when subordinates differ (`allowsMixedState`).
- Radio buttons: groups of 2–5, mutually exclusive; more than ~5 → pop-up button; single on/off → prefer a checkbox; multiple selectable options → checkboxes, not radios.

Reviewer checks: iOS switch outside a list row → violation (toggle button instead) · checkbox/radio in an iOS mock → platform violation · macOS toggle in a toolbar or status bar → violation · parent checkbox with no mixed state over differing children → violation · hue-only state difference → accessibility violation · every row of a macOS settings panel using full-size switches → flag (switches are for emphasis).

Stale priors:
- Was: "switches are iOS-only; macOS = checkboxes". Now: macOS switches are first-class for emphasised/group settings, with mini-switch guidance — but checkboxes remain the default and existing ones shouldn't be converted (since 2024-03-29).
- Was: ad-hoc "active state" buttons, or UISwitch everywhere. Now: toggle-style buttons are the sanctioned non-list toggle on iOS.

## virtual-keyboards
<!-- src: virtual-keyboards · changed: 2025-06-09 · platforms: iOS, iPadOS, tvOS, visionOS, watchOS (NOT macOS) · speed: full -->
System keyboards plus custom input views (in-app replacement) and custom keyboards (system-wide extensions). Not a macOS surface — hardware keyboards: see keyboards (inputs.md).

Rules:
- Match the keyboard to the content type (numbers-and-punctuation for numeric data; email keyboards add "@", ".", ".com"). Set a semantic content type so the system auto-picks and refines autocorrect: `keyboardType(_:)`/`textContentType(_:)`, `UIKeyboardType`/`UITextContentType`.
- Customise the Return key when it clarifies the action (Search key for a search field): `submitLabel(_:)`, `UIReturnKeyType`. A virtual keyboard doesn't support keyboard shortcuts.
- Use the keyboard layout guide (`UIKeyboardLayoutGuide`; SwiftUI `ToolbarItemPlacement`) so important UI stays visible with the keyboard up.
- Input accessory views above the keyboard (2025-06-09 — the bucket's only Liquid Glass normative text): keep controls relevant to the current task; apply Liquid Glass to the containing view if the rest of the app uses it or the view looks out of place — a standard toolbar adopts it automatically.
- Custom input views: must make sense in context; play the standard keyboard click (`playInputClick()`, respects the Sounds setting).
- Custom keyboards: work everywhere once enabled EXCEPT secure text and phone number fields; provide an obvious switch mechanism equivalent to the Globe key; don't duplicate system keys (Emoji/Globe and Dictation can appear beneath the keyboard automatically); tutorial in the app, never the keyboard. Build one only for system-wide input innovation; in-app needs → custom input view.

Reviewer checks: email/phone/URL/numeric field mocked with the default QWERTY keyboard → flag · plain "return" key on a search field → flag · opaque flat accessory strip in a Liquid Glass app → flag · keyboard overlapping the focused field or critical actions → flag · custom keyboard serving one app's needs → custom input view.

Stale priors:
- Was: page named "Onscreen keyboards". Now: "Virtual keyboards", slug virtual-keyboards (since 2023-06-21).
- Was: accessory bars as flat grey `UIToolbar` strips. Now: accessory views adopt Liquid Glass for consistency (since 2025-06-09).
