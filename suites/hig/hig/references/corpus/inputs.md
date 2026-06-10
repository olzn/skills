<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: gestures, keyboards, pointing-devices, focus-and-selection, action-button, camera-control, apple-pencil-and-scribble, siri, gyro-and-accelerometer, nearby-interactions -->

# Inputs
Meta-rule: no input method may be the only way — every gesture, motion, UWB, Pencil, or hardware-button path needs a visible alternative. <!-- src: gestures, nearby-interactions -->
Input models: iOS = touch-first, NO focus system. macOS = keyboard+pointer-first; standard shortcuts and semantic cursors are hard conventions. iPadOS = touch + adaptive pointer + focus groups + Pencil/Scribble. Largely untouched by Liquid Glass — behaviour didn't change, surfaces did. Exception: Siri, rewritten 2026-06-08.

## gestures
<!-- src: gestures · changed: 2024-09-09 · platforms: all · speed: stub -->
All gesture input. Was "Touchscreen gestures" — renamed, all-platform scope since 2023-06-21; vocabulary unchanged in iOS 26. The non-obvious rules:
- Every gesture-driven task needs a visible alternative (voice, keyboard, Switch Control users); shortcut gestures supplement, never replace, standard affordances — edge-swipe-back never removes the Back button.
- Never repurpose familiar gestures for app-unique actions; never invent a unique gesture for a standard action. Unavailable targets must look visibly different or the app reads as frozen.
- Games may defer a system gesture (second swipe required), never remove it.
- iOS expectations beyond the basics: three-finger swipe = undo/redo; three-finger pinch = copy/paste; four-finger swipe = app switching (iPadOS); shake = undo/redo.
- Hot check: swipe-to-delete with no Edit-mode equivalent.
- Fetch for detail: gestures

## keyboards
<!-- src: keyboards · changed: 2025-06-09 · platforms: iOS, iPadOS, macOS, tvOS, visionOS · speed: full -->
Physical keyboards: shortcuts, modifiers, Full Keyboard Access. (Onscreen: see virtual-keyboards.)

Rules:
- The standard shortcut table is a hard macOS expectation — rows live in tables/keyboard-shortcuts-macos.md; reference, don't restate. Redefine a standard shortcut only if its action is meaningless in your app; custom shortcuts only for the most frequent app commands.
- Modifiers: Command = main; Shift = secondary, complements a related shortcut; Option = sparingly; AVOID Control (system-owned). Listing order, exact: Control, Option, Shift, Command (⌃⌥⇧⌘).
- No Shift for the upper character of a two-character key: Help = Command–Question mark, NOT Shift-Command-Slash.
- Never reuse an existing shortcut plus a modifier for an unrelated command (Shift-Command-Z = Redo only).
- Localisation: Command alone is safe; avoid non-Command modifiers with characters missing on some keyboard layouts.
- Support Full Keyboard Access; test via Settings > Accessibility.
- iPadOS caveat: keyboard navigation for text fields/views, sidebars, collections — NOT for controls; Full Keyboard Access handles those.

macOS menu items display their shortcuts; the same conventions apply on iPad with a keyboard attached (hold Command for the shortcut HUD).
Reviewer checks: standard shortcuts with non-standard meanings (diff tables/keyboard-shortcuts-macos.md) · modifiers out of ⌃⌥⇧⌘ order · custom shortcut colliding with the table, or using Control · missing `.keyboardShortcut` on primary actions · iPad keyboard navigation hijacking controls.

Stale priors:
- Was: game key bindings here. Now: on game-controls (since 2025-06-09). Apple's table still lists legacy rows (Dashboard, Eject) — not current features.

## pointing-devices
<!-- src: pointing-devices · changed: 2023-06-21 · platforms: iOS, iPadOS, macOS, visionOS · speed: full -->
Cross-platform: systemwide trackpad gestures behave identically in your app — never redefine them, even in games; same action, same result across touch/pointer/keyboard.

iPadOS adaptive pointer:
- Content effects: **Highlight** (translucent rounded rect; small transparent-background elements — bar buttons, segmented controls) · **Lift** (scales with shadow; small opaque elements — app icons) · **Hover** (custom scale/tint/shadow; large elements).
- Hit regions: ~12 pt padding around bezeled elements, ~24 pt around bezel-less edges (mirrors the Accessibility page). Adjacent bar buttons need contiguous hit regions — gaps make the pointer flicker.
- Magnetism: automatic for lift/highlight and text; NOT for hover. Specify the corner radius for nonstandard lift shapes.
- Hover physics: scale only with room to grow (never table rows); tight spaces = tint only; never shadow without scale.
- Accessories (resize arrows): simple glyphs; no instructional text on the pointer.

macOS: standard clicks/gestures are user-customisable (secondary click, smart zoom, page/app swipes, Mission Control, force click…). The pointer is fixed-shape and semantic — correct `NSCursor` per context; style list in tables/cursors-macos.md (reference, don't restate). Pointing hand = links only; I-beam = editable text; operation-not-allowed during invalid drop. Secondary click reveals contextual menus on content; hover may reveal auto-minimising controls.

Reviewer checks: semantically wrong macOS cursor (diff tables/cursors-macos.md) · missing secondary-click menus · effects mismatched to element type, rows scaling, shadow-without-scale · hit padding under ~12/~24 pt, dead gaps between bar buttons · decorated pointers.

Stale priors:
- Not rewritten for Liquid Glass — behaviour unchanged in iPadOS/macOS 26; highlight/lift semantics apply to floating glass bars too. Accessories, band selection, and no-magnetism-on-hover are absent from older priors.

## focus-and-selection
<!-- src: focus-and-selection · changed: 2023-10-24 · platforms: iPadOS, macOS, tvOS, visionOS (NOT iOS) · speed: full -->
A visible indicator moved by keyboard/remote/controller, and its relation to selection.
- iOS has NO focus system — the page lists it as not supported. Focus rings on an iPhone design are a wrong-platform idiom.
- Rely on system focus effects; never move focus without user interaction (sole exception: the focused item disappears mid-navigation — move one step to a nearby item).
- On iPadOS/macOS, add focus support for CONTENT only (list items, text/search fields) — not buttons/sliders/toggles; Full Keyboard Access covers controls. (tvOS is the opposite.)
- Visuals: focused list item = white text on accent-colour highlight; unfocused selected = grey highlight (system views give this free). Focus ring on text/search fields; row highlight in lists; a ring is fine on a cell-filling item (photo).
- Focus groups (iPadOS; similar on macOS): Tab moves BETWEEN groups (sidebar → grid → list) in reading order; arrows move WITHIN a group; each group has a primary item taking initial focus (`UIFocusGroupPriority`). The halo can match custom shapes (`UIFocusHaloEffect`).

Reviewer checks: iPhone focus rings · active text field without a focus ring · Tab-through-every-row in HTML prototypes (Tab = between regions, arrows = within) · custom focus rings on controls · programmatic focus jumps.

Stale priors:
- Was: iOS shares iPadOS's focus system. Now: explicitly unsupported on iOS. The visionOS look-at hover effect is NOT a focus effect (clarified 2023-10-24); conventions unchanged in macOS Tahoe.

## action-button
<!-- src: action-button · changed: 2023-09-12 · platforms: iOS, watchOS (NOT iPadOS/macOS) · speed: stub -->
Hardware Action button (on iPhone since iPhone 15 Pro — newer than many priors; Apple Watch Ultra). Users assign a function in Settings; an assigned App Shortcut runs on press.
- Expose essential functions as App Shortcuts; never a bare "open my app" action (the system provides that). No in-app onboarding repeating Settings configuration.
- Label rules, exact: title-style capitalization · verb-first · present tense · no articles or prepositions · maximum three words ("Start Race", not "Start the Race").
- iOS: actions run without leaving the current context — prefer Live Activities and snippets (a WWDC26 page) over launching the app ("Set Timer" starts a Live Activity, never opens Clock).
- Fetch for detail: action-button

## camera-control
<!-- src: camera-control · changed: 2024-09-09 (new page) · platforms: iOS only · speed: stub -->
Camera Control hardware (iPhone 16 family; new page 2024-09-09, absent from many priors — don't conflate with the Action button). Light press opens an overlay from the bezel; double-press shows the controls; sliding adjusts the selected one.
- Two control types only: slider (continuous) and picker (discrete). SF Symbols only — custom symbols NOT supported (Camera & Photos section); symbols represent the control, not its state.
- Short names (Dynamic Type; long names obscure the viewfinder); units with slider values (EV, %); define prominent values sliders land on easily.
- The overlay occupies the screen edge adjacent to the Camera Control in portrait AND landscape — keep app UI out of those regions; never show the same control in overlay and onscreen UI at once.
- The control set is fixed at runtime (enable/disable per mode; never add/remove). Support launch from anywhere via `LockedCameraCapture`.
- Fetch for detail: camera-control

## apple-pencil-and-scribble
<!-- src: apple-pencil-and-scribble · changed: 2024-05-07 · platforms: iPadOS only · speed: stub -->
iPadOS only — relevant when designs scale to iPad. Scribble constrains ANY text field in an iPad-capable layout (all standard text components except password fields):
- No tap/selection before writing; hide placeholder the moment writing begins; no autocomplete overlapping handwriting.
- Keep the field stationary while writing — no move/resize/autoscroll; enlarge fields before writing or at pauses, never during.
Pencil: mark immediately on contact (no mode switch); controls must respond to Pencil; hover previews, never initiates; double tap/squeeze (Pencil Pro, 2024) respect the user's setting, never destructive; barrel roll modifies marking only; design for either hand.
- Fetch for detail: apple-pencil-and-scribble

## siri
<!-- src: siri · changed: 2026-06-08 (Revised for Siri AI) · platforms: all · speed: full -->
Rewritten at WWDC26 around Siri AI (Apple Intelligence-powered Siri). SEVERE stale-prior risk: pre-2026 knowledge is wrong in structure, not detail.

Architecture (current vocabulary):
- Entry points: voice, swiping down from the Dynamic Island, the Siri app (new).
- The system has no built-in awareness of an app: apps expose actions ("intents") and content ("entities") via the App Intents framework — feeding Siri, Spotlight, and Shortcuts.
- App schema domains = preset templates for functionality the system already understands (email, music, photos…); adopting one buys natural conversation free. App Shortcuts = custom actions outside schema domains.
- Annotate onscreen views with app entities so Siri understands "add this photo…"; donate entities to the Spotlight index and user actions as intents so Siri anticipates.
- Custom snippets (interactive mini-views; a WWDC26 component page) can enhance responses; responses can be non-visual.
- Siri acts on onscreen content ("Make this black and white") and chains follow-ups ("…and email it to Josh") — design for conversational invocation from anywhere.

Behaviour: expose the most popular actions first; familiar terms (track vs song); offer Spotlight relevant content (recents, favourites), not whole catalogues — except categories like email/messaging; no ads or in-app purchase pitches; custom responses only when built-in ones fall short.

Response writing: succinct — no filler, no humour (it grates on repetition); customise follow-ups ("Which soup?" beats "Which one?"); must work audibly AND visually, voice standing alone; no gendered pronouns; device-independent wording; omit the app name (the system attributes); errors carry specifics, not generic apologies; long option lists → open-ended question.

Editorial: refer to Siri by name, never pronouns; never impersonate Siri or fake an Apple-sourced response; reserved phrases ("Call 911", "Hey Siri") off-limits; localising "Hey Siri" translates only "Hey" — Siri is an Apple trademark, never translated (approved table on the page).

Reviewer checks: copy impersonating Siri, faking a response, or using "Hey Siri" · response copy with app name, gendered pronouns, humour, device-specific wording, or visual-only information · key actions not modelled as App Intents/App Shortcuts · "Siri" translated or pronouned.

Stale priors (HIGH PRIORITY):
- Was: SiriKit custom intents, the "Add to Siri" button (removed 2023-06), Siri watch-face guidance, "donate shortcuts". Now: all gone — Siri AI, App Intents, intents/entities, app schema domains, snippets, the Siri app, onscreen-content awareness (since 2026-06-08). The Mac exposes the same App Intents via Siri, Spotlight, Shortcuts.

## gyro-and-accelerometer
<!-- src: gyro-and-accelerometer · changed: none logged · platforms: all (hardware: iOS in practice) · speed: stub -->
- Use motion data only for tangible user benefit (fitness, gameplay) — never speculatively. First access triggers a system permission request with your purpose string; explain why.
- Outside active gameplay, avoid motion-based direct manipulation of UI (imprecise, physically demanding, battery cost). Shake-to-undo is the sanctioned exception (see gestures).
- Fetch for detail: gyro-and-accelerometer

## nearby-interactions
<!-- src: nearby-interactions · changed: 2023-06-21 · platforms: iOS, iPadOS, watchOS (NOT macOS) · speed: stub -->
- Ultra Wideband proximity (NearbyInteraction): NOT supported on macOS — never spec a UWB feature for Mac. Permission required; identifiers random, session-scoped.
- Feedback sharpens with proximity and must be continuous (AirTag arrow → pulsing circle); combine visual/audio/haptics. Never the only way to perform a task.
- Encourage portrait via implicit feedback (landscape degrades accuracy). iOS gives distance + direction; watchOS distance only.
- Was: "Spatial interactions". Now: "Nearby interactions" — "spatial" belongs to visionOS (since 2023-06-21).
- Fetch for detail: nearby-interactions
