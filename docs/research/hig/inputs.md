# HIG research notes — inputs

> Bucket: Inputs section (iOS/macOS-relevant pages) plus Siri (Technologies — assigned to this bucket).
> Source: Apple JSON content API (`developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`), fetched 2026-06-10.
> Skipped as other-platform-only: Digital Crown (visionOS/watchOS), Eyes (visionOS), Remotes (tvOS).
> Currency snapshot: **Siri was rewritten 2026-06-08 (WWDC26, "Revised for Siri AI")** — the only inputs-bucket page that changed this week. Liquid Glass-era (2025-06-09) changes: Keyboards (game key bindings moved out), Game controls (touch controls + controller UI mapping updated). Everything else is stable 2023–2024 content — the Inputs section was largely UNTOUCHED by the Liquid Glass rewrite; input behaviour didn't change, surfaces did.

---

## Gestures

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/gestures
**Platforms:** all. **Last change:** 2024-09-09 (visionOS system overlays; organizational updates). Renamed from "Touchscreen gestures" 2023-06-21.

### Purpose
Governs all gesture input — on a touchscreen, in the air (visionOS), or on input devices with a touch surface (trackpad, mouse, remote, game controller). Defines the standard gesture vocabulary every platform shares and the rules for adding custom gestures.

### Normative rules
- **Give people more than one way to interact.** Never assume a person can perform a specific gesture — voice, keyboard, and Switch Control users exist. Every gesture-driven task needs an alternative.
- **Respond to gestures consistently with expectations.** Tap activates/selects. Don't repurpose familiar gestures (tap, swipe) for app-unique actions; don't invent a unique gesture for a standard action (activating a button, scrolling).
- **Handle gestures as responsively as possible** — provide feedback during the gesture that predicts its result and communicates the extent/type of movement required.
- **Indicate when a gesture isn't available** — a locked draggable object or unavailable button must look visibly different, or people think the app froze.
- **Custom gestures only when necessary** — for specialized, frequent tasks not covered by existing gestures (games, drawing apps). A custom gesture must be: discoverable; straightforward to perform; distinct from other gestures; **not the only way to perform an important action**.
- **Shortcut gestures supplement, never replace, standard affordances.** E.g. edge-swipe-back may accelerate navigation, but the Back button in the top toolbar must still exist.
- **Don't conflict with system gestures** (Home indicator edge swipe, Control Center pulls, etc.). Games/immersive experiences may *defer* the system gesture (require a second swipe) but not remove it.

**Standard gestures (specifications table)** — supported across platforms, with common actions:

| Gesture | iOS/iPadOS | macOS | Common action |
|---|---|---|---|
| Tap | ● | ● | Activate a control; select an item |
| Swipe | ● | ● | Reveal actions and controls; dismiss views; scroll |
| Drag | ● | ● | Move a UI element |
| Touch (or pinch) and hold | ● | — (not listed for macOS) | Reveal additional controls or functionality |
| Double tap | ● | ● | Zoom in; zoom out if already zoomed |
| Zoom (pinch) | ● | ● | Zoom a view; magnify content |
| Rotate | ● | ● | Rotate a selected item |

**iOS/iPadOS extra expected gestures:**

| Gesture | Action |
|---|---|
| Three-finger swipe left / right | Undo / redo |
| Three-finger pinch in / out | Copy selected text / paste |
| Four-finger swipe (iPadOS only) | Switch between apps |
| Shake | Undo; redo |

- Simultaneous multi-gesture recognition: appropriate mainly in games (joystick + fire buttons); unlikely useful in non-game apps.

### iOS vs macOS
- **iOS:** touchscreen is the primary input; the extra three-finger/shake gestures above are user expectations.
- **macOS:** people interact **primarily via keyboard and mouse**; standard gestures apply on Magic Trackpad / Magic Mouse / touch-surface controllers. There is no macOS-specific gesture list on this page — it lives on Pointing devices (trackpad gesture table).

### Reviewer checks
- Any swipe/long-press/drag-only action in a prototype: is there a visible button or menu equivalent? (Flag swipe-to-delete with no Edit mode/button, gesture-only navigation with no Back button.)
- Tap used for anything other than activate/select → flag.
- Custom gesture introduced → is it taught somewhere, and is it redundant with a visible control?
- Draggable/locked/disabled states visually distinct from active states?
- Custom gestures near screen edges that collide with system edge swipes (Home indicator, Notification Center, Control Center) → flag.
- Game prototypes: are simultaneous touches supported where two controls must be used at once?

### Stale-knowledge corrections
- Page renamed from "Touchscreen gestures" (June 2023) — it now covers all gesture inputs, all platforms, not just touch.
- No Liquid Glass changes here: gesture vocabulary is unchanged in iOS 26. But Liquid Glass introduced gesture-adjacent surface behaviour elsewhere (tab bars that minimize on scroll, scroll edge effects) covered on component pages, not here.
- watchOS double tap (hand gesture) and visionOS direct/indirect gestures exist but are out of scope.

---

## Keyboards

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/keyboards
**Platforms:** ios, ipados, macos, tvos, visionos (not watchOS). **Last change:** 2025-06-09 — game-specific key-bindings guidance moved to Game controls.

### Purpose
Governs physical keyboard input: standard system keyboard shortcuts, custom shortcut design, modifier-key conventions, and Full Keyboard Access. (Onscreen keyboards are a separate Components page: `virtual-keyboards`.)

### Normative rules
- Terminology: a *keyboard shortcut* = primary key + one or more modifiers (Control, Option, Shift, Command). A single-key game shortcut = *key binding* (guidance now on Game controls page).
- **Support Full Keyboard Access** (iOS, iPadOS, macOS, visionOS) — keyboard-only navigation/activation of windows, menus, controls, system features. Test by enabling it in Settings > Accessibility.
- **iPadOS caveat (Important aside):** iPadOS supports keyboard *navigation* in text fields, text views, sidebars (and APIs for collection/custom views), but **avoid supporting keyboard navigation for controls** (buttons, segmented controls, switches) — let Full Keyboard Access handle control activation instead.
- **Don't repurpose standard keyboard shortcuts.** Only redefine one if its action is meaningless in your app (e.g. no text editing → Command-I may become Get Info).
- **Custom shortcuts only for the most frequently used app-specific commands** — too many makes the app feel hard to learn.
- **Modifier usage conventions:** Command = preferred main modifier. Shift = secondary modifier complementing a related shortcut. Option = sparingly, for less-common/power commands. **Avoid Control as a modifier** — the system uses it heavily (focus movement, screenshots).
- **Modifier key listing order (exact):** Control, Option, Shift, Command.
- **Don't add Shift to the upper character of a two-character key.** Help = Command–Question mark, NOT Shift-Command-Slash.
- **Expected modifier behaviours:** Command-drag moves items as a group; Shift-drag-resize constrains aspect ratio; held arrow key moves selection by the app's smallest unit until released.
- Localization: it's usually safe to use Command alone; avoid extra modifiers with characters not present on all keyboards (e.g. Option-5 types "{" on a French keyboard). If you must use a non-Command modifier, prefer pairing it only with alphabetic characters. The system localizes and RTL-mirrors shortcuts automatically.
- **Don't add a modifier to an existing shortcut for an unrelated command** (Shift-Command-Z must mean Redo, nothing else).

**Standard shortcuts every app must respect (high-frequency subset; full table on page is ~100 rows, macOS-centric):**

| Shortcut | Action |
|---|---|
| Command-A / Shift-Command-A | Select all / deselect all |
| Command-C, Command-X, Command-V | Copy, cut, paste |
| Command-Z / Shift-Command-Z | Undo / redo |
| Command-S / Shift-Command-S | Save / duplicate (Save As) |
| Command-N, Command-O, Command-W, Command-Q | New, open, close window, quit |
| Command-F / Command-G / Shift-Command-G | Find / find next / find previous |
| Command-P | Print |
| Command-Comma | **App settings window (macOS convention)** |
| Command-Period or Esc | Cancel current operation |
| Command-H / Option-Command-H | Hide app / hide others |
| Command-M | Minimize window |
| Command-B / I / U | Bold / italic / underline |
| Command-T / Option-Command-T | Fonts window / toggle toolbar |
| Control-Command-F | Enter full screen |
| Command-Question mark | App Help menu |
| Command-Tab / Shift-Command-Tab | Cycle open apps |
| Command-Grave (`) | Cycle windows of frontmost app |
| Shift-Command-3 / 4 | Screen capture (full / selection) |
| Tab / Shift-Tab | Navigate controls forward / backward |
| Control-Tab / Control-Shift-Tab | Next / previous group of controls |
| Shift-Arrow, Option-Shift-Arrow, Shift-Command-Arrow | Extend selection by character / word / semantic unit (line, document) |

### iOS vs macOS
- **macOS:** keyboard is a primary, always-present input; the full standard-shortcut table is a hard expectation; Command-Comma opens Settings; menu bar items display the shortcuts.
- **iOS/iPadOS:** physical keyboard is optional but common on iPad; same shortcut conventions apply when connected (discoverable via the hold-Command shortcut HUD on iPad); Full Keyboard Access is the accessibility path; keyboard navigation is for text/content areas, not controls.
- No platform-considerations text exists for iOS/macOS specifically ("no additional considerations") — the standard tables ARE the guidance.

### Reviewer checks
- macOS prototype: every menu command of frequent use has a shortcut; standard shortcuts mapped to their standard meanings (esp. Command-Comma → Settings, Command-W ≠ quit, Command-Z = undo).
- Shortcut strings rendered in UI: modifiers listed in Control-Option-Shift-Command order; symbols ⌃⌥⇧⌘; no "Shift-Command-/"-style mistakes for upper characters.
- Custom shortcuts: do any collide with the standard table? Is Control used as a modifier? → flag.
- SwiftUI prototypes: `.keyboardShortcut` present on primary actions; settings reachable via Command-Comma (`Settings` scene on macOS gives it free).
- iPad designs: does keyboard navigation reach text fields/lists but not hijack buttons/toggles (Full Keyboard Access territory)?

### Stale-knowledge corrections
- June 2025: game key-binding guidance moved OUT of this page to Game controls — cite Game controls for games.
- The standard-shortcut table still lists legacy rows (Dashboard F12, window drawers, Eject-key combos) — Apple hasn't pruned them; don't treat those as evidence of current features, but the alphabetic command rows remain authoritative.
- visionOS shows a flat shortcut interface when holding Command — irrelevant to iOS/macOS but explains the "descriptive shortcut titles" rule (`discoverabilityTitle`).

---

## Pointing devices

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/pointing-devices
**Platforms:** ios, ipados, macos, visionos. **Last change:** 2023-06-21 (stable).

### Purpose
Governs trackpad/mouse interaction: macOS standard clicks, trackpad gestures, and pointer styles; the iPadOS adaptive-pointer system (content effects, accessories, magnetism, hit regions).

### Normative rules (cross-platform)
- **Be consistent responding to mouse/trackpad gestures** — systemwide gestures (e.g. "Swipe between pages") must behave identically in your app.
- **Never redefine systemwide trackpad gestures** (Dock, Mission Control reveals), even in games; users can customize them in System Settings.
- **Consistent experience across input types** — touch, pointer, keyboard must produce the same result for the same action (e.g. Option-drag duplicates whether dragging by touch or pointer).
- **Pointer can reveal auto-minimizing/fading controls** — hover over a minimized toolbar or full-screen video reveals controls; moving away hides them.

### iPadOS pointer system (the bulk of the page)
- Default pointer = circle; transforms contextually (I-beam over text areas).
- **Three content effects** — match to element type:
  - **Highlight**: pointer becomes a translucent rounded rectangle behind the control + gentle parallax. Default for bar buttons, tab bars, segmented controls, edit menus. **Use for small elements with transparent backgrounds.**
  - **Lift**: pointer fades out; element scales up with shadow below and specular highlight on top. Default for app icons and Control Center buttons. **Use for small elements with opaque backgrounds.**
  - **Hover**: element gets custom scale/tint/shadow; pointer shape unchanged. **Use for large elements.**
- **Hit regions:** add **~12 pt padding around bezeled elements; ~24 pt around the visible edges of bezel-less elements** (same numbers as the Accessibility page — one rule, two pages).
- **Contiguous hit regions for adjacent bar buttons** — gaps make the pointer flicker back to its default shape between buttons.
- **Specify the corner radius for nonstandard lift-effect shapes** (e.g. circular elements) so the pointer animates into the element's shape (`roundedRect(_:radius:)`).
- **Pointer magnetism**: applied by default to lift- and highlight-effect elements and text areas; NOT applied to hover elements (would feel like losing control). Hit region begins attracting before visual contact; flicks snap to the most likely target's center.
- **Pointer accessories** (small indicator glyphs, e.g. resize arrows): keep images clear and simple; use accessory transitions to signal state changes (e.g. `plus` → `circle.slash` when add becomes unavailable).
- Custom pointers: prefer system effects for standard-behaving elements; use effects consistently across the app; no gratuitous/decorative effects; keep custom shapes simple; **avoid instructional text attached to the pointer**; custom annotations (e.g. X/Y values, image dimensions à la Keynote) are fine.
- Hover-effect physics: reserve **scale** for elements with room to grow (not table rows); little-space elements → tint only; **never shadow without scale** (shadow implies elevation, elevation implies scale).
- Multiple selection: iPadOS 15+ pointer band-selection (drag rectangle) is default in non-list collection views; custom views need `UIBandSelectionInteraction`.
- Distinguish pointer from finger input **only if it adds value** (e.g. pointer-precision seek in a video scrubber).

### macOS specifics
**Standard clicks/gestures (customizable by users):** Primary click (select/activate), Secondary click (contextual menus — mouse or trackpad), Scroll, Smart zoom (two-finger double-tap), Swipe between pages, Swipe between full-screen apps, Mission Control, Lookup/data detectors (force click / three-finger tap, trackpad), Tap to click (trackpad), **Force click** (Quick Look/lookup; variable pressure for pressure-sensitive controls), Pinch zoom, Rotate, Notification Center (edge swipe from trackpad), App Exposé, Launchpad, Show Desktop.

**Standard pointer styles (AppKit `NSCursor`)** — use the semantically correct one: Arrow; Closed hand (dragging content position); Contextual menu (shown with Control pressed); Crosshair (precise rectangular selection); Disappearing item (drop will remove the dragged reference); Drag copy (Option held during drag); Drag link (Option-Command during drag); Horizontal I-beam (text selection/insertion); Open hand (content can be repositioned); Operation not allowed (can't drop here); Pointing hand (URL link); Resize down/left/right/up/left-right/up-down; Vertical I-beam.

### iOS vs macOS
- **iOS:** "No additional considerations" — pointer support exists (e.g. AssistiveTouch) but the adaptive pointer system is iPadOS.
- **iPadOS:** pointer *adapts to content* (effects, magnetism); it augments touch, never replaces it.
- **macOS:** pointer is fixed-shape and semantic (cursor styles signal available operations); gestures are user-customizable system behaviours; force click and secondary click are expected interactions.

### Reviewer checks
- macOS prototype: cursor styles correct per context (pointing hand only for links; I-beam over editable text; not-allowed during invalid drop; Option-drag shows drag-copy cursor). Secondary click reveals a context menu on content objects.
- iPad-adaptive design (or HTML prototype simulating it): bar buttons use highlight-style hover; app-icon-like opaque tiles use lift; large cards use hover with tint; table rows never scale on hover; no shadow-without-scale hover states.
- Hit regions: interactive elements have ≥12 pt (bezeled) / ≥24 pt (bezel-less) padding; adjacent toolbar buttons have contiguous hit regions (no dead gaps).
- Hover reveals: auto-hiding toolbars/controls respond to pointer hover.
- Anything that styles or animates the pointer itself decoratively → flag.

### Stale-knowledge corrections
- Page is pre-Liquid Glass (2023) and was NOT rewritten — pointer behaviour carried into iOS 26/macOS Tahoe unchanged. But Liquid Glass buttons/toolbars are now floating glass surfaces; the highlight/lift semantics still apply to them.
- Models may not know pointer **accessories** and **band selection** (iPadOS 15+) or the no-magnetism-on-hover rule.

---

## Focus and selection

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/focus-and-selection
**Platforms:** **ipados, macos, tvos, visionos — NOT iOS, not watchOS.** **Last change:** 2023-10-24 (clarified focus vs visionOS hover effect).

### Purpose
Governs the focus system: how keyboard/remote/controller users move a visible focus indicator between components, and how focus relates to selection.

### Normative rules
- Focusing an item often selects it; the exception is when auto-selection would cause a distracting context shift (opening a new view) — then selection needs a separate action.
- **Rely on system-provided focus effects**; create custom ones only if absolutely necessary.
- **Never move focus without user interaction.** Exception: if the focused item disappears while the user is navigating with a discrete directional device (keyboard/remote/controller), move focus to a nearby item one step away; otherwise just hide the focus indicator.
- **Support focus only where the platform expects it:** on iPadOS and macOS, Full Keyboard Access covers controls — apps need focus support only for *content* elements (list items, text fields, search fields), NOT for buttons, sliders, toggles. (tvOS is the opposite: everything must be focusable.)
- **Visual conventions:** focused list items = white text on an accent-color background highlight; unfocused = standard text on gray highlight (`UICollectionView` / `NSTableView` give this for free).
- **Use a focus ring for text/search fields; use a row highlight in lists and collections.** A ring is acceptable on a cell-filling item like a photo.
- iPadOS focus model (similar on macOS): *focus groups* = app areas (sidebar, grid, list). **Tab moves between focus groups; arrow keys move directionally within a group.** Focus moves through groups in reading order (leading→trailing, top→bottom); wrap a vertical stack as a single focus group if focus must run down before moving trailing. Each group has a *primary item* that receives focus when the group does (raise an item's priority to make it primary — `UIFocusGroupPriority`).
- iPadOS focus appearances: the **halo** (focus ring) — customizable outline, can match rounded corners/Bézier shapes, can be repositioned if occluded (`UIFocusHaloEffect`); the **highlighted** appearance (text in accent color) — automatic with content configurations, technically not a focus effect.

### iOS vs macOS
- **iOS: the focus system does not exist.** No focus rings on iPhone designs (Full Keyboard Access on iOS provides its own system-drawn indication; apps don't design for it).
- **macOS:** focus ring around the focused text/search field is a core convention; keyboard focus moves per the standard shortcuts (Tab, Control-F-keys); selection highlight uses the accent color.
- **iPadOS:** the halo/focus-group system above (iPadOS 15+).

### Reviewer checks
- macOS/iPadOS prototype: text and search fields show a focus ring when active; lists show full-row accent highlight for the focused/selected row; white text on accent highlight.
- Tab order in HTML prototypes mirrors focus groups: Tab jumps between regions (sidebar → content), arrows move within a list — not Tab-through-every-row.
- Buttons/toggles in iPad/macOS designs should NOT carry custom focus rings (that's Full Keyboard Access's job).
- Any flow where focus jumps programmatically (after load, after dismiss) without user action → flag.
- iPhone design showing focus rings → flag (wrong platform idiom).

### Stale-knowledge corrections
- Models often assume iOS has the same focus system as iPadOS — it doesn't; the page explicitly lists "Not supported in iOS."
- The visionOS look-at *hover effect* is NOT a focus effect (explicit 2023-10-24 clarification).
- No Liquid Glass rewrite; in macOS Tahoe the focus ring conventions are unchanged.

---

## Action button

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/action-button
**Platforms:** ios, watchos. **Last change:** 2023-09-12 (added iOS guidance).

### Purpose
Governs supporting the hardware Action button (supported iPhone models and Apple Watch Ultra): exposing app functions the user can assign to it.

### Normative rules
- Users assign the button's function in Settings; assigning an App Shortcut makes pressing the button run it (same as invoking via Siri or Spotlight).
- **Expose a set of your app's essential functions as App Shortcuts** for the button. **Don't offer an "open my app" action** — the system already provides that (icon, widgets do this job).
- **Label rules (exact):** short label per action, shown in Settings; **title-style capitalization; begins with a verb; present tense; no articles or prepositions; maximum three words.** Example: "Start Race", not "Started Race" or "Start the Race".
- **Let the system teach the button** — don't build in-app content repeating the Settings configuration guidance.
- **iOS-specific:** let people use actions **without leaving their current context** — prefer Live Activities and snippets over launching the app (e.g. "Set Timer" prompts for a duration and starts a Live Activity; it never opens the Clock app).

### iOS vs macOS
- iOS (and watchOS) only; **not supported on iPadOS or macOS**. macOS has no equivalent.

### Reviewer checks
- App Shortcut action labels: ≤3 words, verb-first, present tense, no articles/prepositions, title-style caps.
- No App Shortcut that merely opens the app.
- Action flows designed as overlays/Live Activities/snippets rather than full app launches.
- No in-app onboarding screens explaining how to configure the Action button → flag as redundant.

### Stale-knowledge corrections
- Pre-2023 models know the Action button only from Apple Watch Ultra; it's been on iPhone since iPhone 15 Pro (Sept 2023) and the guidance is App Shortcuts-based.
- "Snippets" referenced here became a full HIG page at WWDC26 — Action button actions can now surface interactive snippets.

---

## Camera Control

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/camera-control
**Platforms:** ios only. **New page:** 2024-09-09 (iPhone 16 hardware).

### Purpose
Governs the Camera Control hardware (iPhone 16 / 16 Pro): the light-press overlay that extends from the bezel, and the slider/picker controls apps put in it.

### Normative rules
- Interaction model: light press opens the overlay; light double-press shows available controls; sliding a finger on the Camera Control adjusts the selected control's value.
- **Two control types only:** *slider* (continuous range, e.g. contrast) and *picker* (discrete options, e.g. grid on/off). System-standard zoom and exposure controls can optionally be included.
- **SF Symbols only — custom symbols are NOT supported.** Pick symbols from the Camera & Photos section of SF Symbols. Symbols represent the control, not its current state.
- **Keep control names short** — labels follow Dynamic Type; long names obscure the viewfinder.
- **Include units/symbols with slider values** (EV, %, or custom string — `localizedValueFormat`).
- **Define prominent values for sliders** — most-chosen or evenly spaced values the slider lands on more easily (`prominentValues`).
- **Make space for the overlay** — it occupies the screen edge adjacent to the Camera Control in portrait AND landscape; keep app UI out of those regions; maximize viewfinder and let the overlay appear over it.
- **Don't duplicate controls** — when the overlay shows a slider, the same control shouldn't also sit in your onscreen UI.
- **Enable/disable controls per camera mode** (disable video controls in photo mode); the control set is fixed at runtime — you can't add or remove controls dynamically. The system remembers the last-used control per app.
- **Support launch from anywhere** via a locked camera capture extension (Lock Screen, Home Screen, inside other apps — `LockedCameraCapture`).

### iOS vs macOS
- iOS only; not iPadOS, not macOS.

### Reviewer checks
- Camera UI prototypes: clear margin along the Camera Control edge (both orientations) for the overlay; no app controls there.
- Overlay control mockups: SF Symbols (no custom glyphs), short Dynamic Type labels, units on slider values.
- Same setting not shown simultaneously in overlay and on-screen UI.

### Stale-knowledge corrections
- This page postdates many training sets (Sept 2024). Models may not know Camera Control exists at all, or may conflate it with the Action button. Slider/picker, SF-Symbols-only, and the fixed-at-runtime control set are the load-bearing facts.

---

## Apple Pencil and Scribble (brief — iPadOS only)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/apple-pencil-and-scribble
**Platforms:** ipados only. **Last change:** 2024-05-07 (Apple Pencil Pro squeeze + barrel roll).

### Purpose
Governs Apple Pencil input (drawing, hover, double tap, squeeze, barrel roll) and Scribble handwriting-to-text. Included briefly because its Scribble rules constrain text-field design in any iPad-capable layout.

### Normative rules (the ones that affect general design)
- **Mark immediately on contact** — no mode/button before drawing. Controls must respond to Pencil too (a Pencil-dead button reads as broken).
- Pencil senses tilt (altitude), force (pressure), orientation (azimuth), barrel roll; map pressure to continuous properties (opacity, brush size).
- **Hover:** preview the mark; never initiate actions from hover; preview a mid-range value, not min/max.
- **Double tap / squeeze (Pencil Pro):** respect the user's system setting; never bind to destructive or content-modifying actions; squeeze = single discrete action, show its result (e.g. contextual menu) near the Pencil tip. **Barrel roll only modifies marking behaviour, never navigation/UI.**
- **Scribble rules that constrain text-field design** (Scribble works in all standard text components except password fields, by default):
  - Don't require tap/selection before writing into a field.
  - **Hide placeholder text the moment writing begins**; avoid autocompletion suggestions overlapping handwriting.
  - **Keep the field stationary while writing** — no move/resize/autoscroll mid-writing; delay layout changes until the writer pauses.
  - **Give enough space to write** — enlarge fields before writing starts or at pauses, never during.
- Custom drawing: PencilKit canvas auto-adapts colors to Dark Mode — disable that when marking up fixed content (PDF, photo). In compact environments the tool picker loses undo/redo — provide toolbar buttons and/or support the standard 3-finger undo/redo gesture.
- Design for left- and right-handed use — controls must not be obscured by either hand; consider repositionable controls.

### iOS vs macOS
- Neither: iPadOS only. Relevant to this skill suite only when iPhone designs scale up to iPad, or for iPad-adaptive HTML prototypes.

### Reviewer checks (iPad-adaptive designs)
- Text fields: no placeholder collision, no autoscroll/move-on-focus patterns that would break Scribble.
- Drawing surfaces: no mode-switch required to make first mark; controls reachable by Pencil.

### Stale-knowledge corrections
- Squeeze and barrel roll (Apple Pencil Pro, May 2024) postdate older training data. PaperKit now appears in developer references alongside PencilKit.

---

## Siri

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/siri
**Platforms:** all. **Last change: 2026-06-08 — "Revised for Siri AI" (WWDC26, this week).**

### Purpose
Governs integrating app actions and content with Siri — now framed entirely around **Siri AI** (Apple Intelligence-powered Siri), the App Intents framework, and app schema domains. Defines how to expose functionality, write Siri response dialogue, and the editorial rules around the Siri brand.

### Normative rules
**Architecture (current terminology — get this right):**
- People reach Siri by voice, **swiping down from the Dynamic Island**, or **in the Siri app** (new).
- The system has no built-in awareness of an app; the app exposes **actions ("intents")** and **content ("entities")** via the **App Intents** framework. These feed Siri, Spotlight, and Shortcuts.
- **App schema domains** = preset templates for functionality the system already understands (email, music, photos…); adopting them buys natural conversation and deeper contextual handling for free.
- Context sharing: annotate onscreen views/content with app entities so Siri understands "add *this* photo…"; donate entities to the on-device Spotlight index; donate user actions as intents so Siri can anticipate future ones.
- **App Shortcuts** are the path for custom actions outside the schema domains. Custom **snippets** (e.g. a playback control snippet) can enhance schema responses; optional properties may not always render (responses can be non-visual).

**Behaviour rules:**
- Identify the app's most popular actions and the contexts where they occur (hands-free, specific devices) to prioritize what to expose.
- **Use familiar terms** for content/actions (track vs song vs podcast — pick what users recognize).
- **Offer relevant content** to Spotlight (recents, favorites, bookmarks, wishlists) — not the whole catalog, except for categories like email/messaging where full access is appropriate.
- **Don't advertise** — no ads, marketing, or IAP pitches in Siri-delivered content.
- **Only provide a custom response if built-in responses don't meet your needs.**

**Response-writing rules:**
- Clear and descriptive dialogue; customize follow-up questions ("Which soup?" beats "Which one?").
- **As succinct as possible** — people hear responses repeatedly; no filler, no humor (it grates on repetition).
- **Responses must work audibly AND visually**, and the voice response must stand alone without visual elements.
- **Inclusive phrasing** — avoid gendered pronouns ("Who should I send it to?" not "What's his or her name?").
- Ask an open-ended question when a full option list is too long to read aloud.
- **Device-independent wording** (requests can start on one device and complete on another).
- **Omit the app name from responses** — the system provides attribution.
- Respect parental controls; no offensive language (responses may be spoken aloud near others).
- **Enhance error responses with specifics** ("Sorry, we're out of chicken noodle soup" not "Sorry, we can't complete your order").

**Editorial rules:**
- **Refer to Siri by name, never pronouns** (no she/him/her).
- **Never impersonate Siri**, reproduce its functionality, or fake an Apple-sourced response. Reserved phrases (e.g. "Call 911", "Hey Siri") are off-limits.
- Localizing "Hey Siri": translate only "Hey"; **Siri is an Apple trademark and is never translated** (page includes the full 40-locale approved-translations table, e.g. fr "Dis Siri", es "Oye Siri", ko "Siri야", zh_CN "嘿Siri").

### iOS vs macOS
- Guidance is platform-uniform (all platforms). iOS-specific entry points: Dynamic Island swipe, Siri app. macOS exposes the same App Intents through Siri, Spotlight, and Shortcuts on the Mac.

### Reviewer checks
- Any UI or copy that impersonates Siri, shows a fake Siri response, or uses "Hey Siri" in copy → flag.
- Siri response copy in flows: app name present (→ remove), gendered pronouns, humor/filler, device-specific wording, visual-only information in a voice response → flag.
- Feature specs: are key app actions modeled as App Intents/App Shortcuts (with schema domains where one exists), not as custom voice UI?
- Copy referencing Siri: "Siri" by name, untranslated.

### Stale-knowledge corrections — HIGH PRIORITY
- **Rewritten 2026-06-08.** Pre-2026 model knowledge is wrong in structure: SiriKit custom intents, the "Add to Siri" button (removed June 2023), Siri watch-face guidance, and "donate shortcuts" phrasing are gone. Current vocabulary: **Siri AI, Apple Intelligence, App Intents, intents/entities, app schema domains, snippets, Siri app, onscreen-content awareness**.
- Siri can now act on onscreen content ("Make this black and white") and chain follow-ups ("…and email it to Josh") — design actions assuming contextual, conversational invocation from anywhere in the system.
- Snippets (interactive mini-views in Siri responses) are a new WWDC26 HIG component page; Siri responses can embed them.

---

## Game controls

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/game-controls
**Platforms:** ios, ipados, macos, tvos, visionos. **Last change:** 2025-06-09 — updated touch-control best practices, controller-to-UI mapping, visionOS spatial controllers. (Renamed from "Game controllers", 2024-06-10.)

### Purpose
Governs game input: virtual touch controls (iOS/iPadOS), physical game controllers, and game keyboard key bindings (moved here from Keyboards in June 2025).

### Normative rules
**Virtual touch controls (iOS/iPadOS — `TouchController` framework):**
- Prefer direct interaction with game objects over virtual buttons where possible (tap the object instead of a selection button).
- Place virtual buttons within layout guides/safe areas; **don't overlap the Home indicator or Dynamic Island**; frequent buttons near the thumb; secondary controls (menus) at the top of the screen; avoid the circular regions players expect for movement/camera input.
- **Sizes: frequently used controls minimum 44×44 pt; less important controls (e.g. menus) minimum 28×28 pt.**
- **Always include visible and tactile press states** — a visual effect readable under a finger (e.g. glow) + sound + haptics.
- **Symbols depict the action** (weapon graphic for attack); never abstract shapes or controller-style names (A, X, R1) as artwork.
- Show/hide controls contextually (e.g. hide movement controls until the screen is touched) to reduce UI over game content.
- Combine multi-button mechanics into one control (touch-and-hold for the charged variant; one control for walk/sprint).
- **Movement on the left half, camera on the right half** of the screen; maximize both input areas; **dynamic thumbstick** (appears where the thumb lands) over a static one; direct-touch camera panning over a virtual right stick.

**Physical controllers:**
- Always provide a fallback to the platform's default input (touchscreen on iPhone/iPad, **keyboard + trackpad/mouse on every Mac**). Only tvOS/visionOS may require a controller ("Game Controller Required" App Store badge); even then, detect absence and prompt gracefully.
- Auto-detect paired controllers; match onscreen glyphs/labels to the *connected* controller's labeling scheme; prefer SF Symbols for controller elements over text; with multiple controllers, match the active one per player.
- **Controller-to-UI mapping (outside gameplay, all platforms):** A = activates a control; B = cancels/returns to previous screen; left/right shoulder = navigate left/right between screens or sections; thumbsticks and D-pad = move selection; Menu = opens settings or pauses; Home/logo = reserved for the system; X, Y, triggers = unassigned.

**Keyboards (game key bindings):**
- **Prioritize single-key commands** (I = Inventory, M = Map, Space = main action).
- Test comfort on an Apple keyboard — remap Control-based bindings to Command (next to Space, easy from WASD).
- Cluster related commands on physically nearby keys (around WASD; number row for inventory).
- **Let players customize key bindings** — expected by default.

### iOS vs macOS
- iOS/iPadOS: virtual touch controls + the size/placement rules above.
- macOS: no virtual controls; keyboard+mouse is the default input that must always work; key-binding guidance applies most strongly here.

### Reviewer checks
- Game mockups: virtual controls ≥44×44 pt (frequent) / ≥28×28 pt (secondary); nothing over the Home indicator/Dynamic Island; movement left / camera right; menus top; press states designed.
- Button artwork using "A"/"X"/"R1" labels → flag.
- Controller UI navigation spec: B = back, Menu = pause; no game binding on the Home button.
- macOS games: playable with keyboard+mouse alone; bindings customizable.

### Stale-knowledge corrections
- Renamed and re-scoped twice recently: "Game controllers" → "Game controls" (2024), absorbed Keyboards' key-binding guidance and gained the TouchController framework + dynamic-thumbstick guidance (June 2025). Older models won't know `TouchController` or the 44/28 pt virtual-control numbers.

---

## Gyroscope and accelerometer (brief)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/gyro-and-accelerometer
**Platforms:** all. **No change log** (stable).

### Purpose
Governs use of device-motion data (Core Motion).

### Normative rules
- **Use motion data only for tangible user benefit** (fitness feedback, gameplay) — never collect it just to have it.
- **Permission copy is mandatory**: the first access triggers a system permission request that includes your purpose string — you must explain why.
- **Outside active gameplay, avoid motion-based direct manipulation of the interface** — hard to replicate precisely, physically challenging for some, battery cost.

### iOS vs macOS
- "No additional considerations" for either; in practice iOS hardware; Macs lack these sensors (macOS listed because the page is platform-generic).

### Reviewer checks
- Any tilt/shake-driven UI control outside a game → flag. Shake-to-undo is fine (system standard, see Gestures).
- Feature spec using motion data: purpose string written and benefit articulated?

### Stale-knowledge corrections
- None — page is stable and matches long-standing guidance.

---

## Nearby interactions (brief)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/nearby-interactions
**Platforms:** ios, ipados, watchos — **not macOS**. **Last change:** 2023-06-21 (renamed from "Spatial interactions").

### Purpose
Governs Ultra Wideband (U1/NearbyInteraction) proximity experiences — distance/direction between devices (e.g. HomePod handoff, AirTag finding).

### Normative rules
- Requires user permission; APIs use random, session-scoped device identifiers (privacy).
- Ground interactions in physical-world metaphors (bring-close to transfer); use **distance, direction, and context** to rank suggestions (e.g. share sheet suggesting the closest faced contact).
- **Feedback sharpens with proximity** (AirTag arrow → pulsing circle) and must be **continuous**; combine visual + audio + haptic, choosing per context (visual while looking at the screen; audio/haptics while looking at the environment).
- **Never the only way to perform a task** — alternatives required.
- Device usage: encourage **portrait orientation** (landscape degrades accuracy) — via implicit visual feedback, not explicit instructions; the sensor's field of view ≈ the Ultra Wide camera's (outside it you may get distance but not direction); warn about intervening bodies/objects in onboarding content.
- iOS provides distance + direction; watchOS distance only (and foreground-only).

### iOS vs macOS
- iOS yes; **macOS unsupported** — never spec a UWB feature for Mac.

### Reviewer checks
- UWB feature flows: continuous proximity feedback designed; non-UWB fallback path exists; portrait-first layouts.

### Stale-knowledge corrections
- Page renamed from "Spatial interactions" (June 2023) — "spatial" now belongs to visionOS vocabulary; use "nearby interactions".

---

## Cross-page synthesis (inputs bucket)

**Numeric specs to hard-code in a checklist:**
- Hit-region padding: **~12 pt around bezeled elements, ~24 pt around bezel-less** (pointing devices; mirrors Accessibility).
- Virtual game controls: **44×44 pt min frequent, 28×28 pt min secondary** (matches the Accessibility control sizes: iOS default 44, min 28; macOS default 28, min 20).
- Action button labels: **≤3 words**, verb-first, present tense, title-style caps.
- Modifier order: **Control, Option, Shift, Command**.

**The recurring meta-rule of the whole section:** *no input method may be the only way* — every gesture, motion, UWB, Pencil, or hardware-button path needs a visible onscreen alternative. This single rule generates most reviewer checks.

**Platform input models in one line each:**
- iOS: touch-first; no focus system; hardware extras (Action button, Camera Control) are App-Intents-mediated shortcuts into app functions.
- macOS: keyboard+pointer-first; standard shortcut table and semantic cursor styles are hard conventions; focus ring on fields, accent highlight in lists.
- iPadOS (adaptive reference): touch + adaptive pointer (highlight/lift/hover) + focus groups + Pencil/Scribble.
