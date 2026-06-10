<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: charting-data, collaboration-and-sharing, drag-and-drop, entering-data, feedback, file-management, modality, managing-notifications, playing-audio, playing-haptics, playing-video, searching, undo-and-redo -->

Interaction behaviour is the HIG's stable layer — most pages last changed 2022–24 and survived Liquid Glass untouched (visual treatment lives on the component pages). Exception: searching (2026-06-08) is hot. <!-- src: searching -->

## charting-data
<!-- src: charting-data · changed: 2022-09-23 (added) · platforms: all · speed: stub -->
- Chart only to highlight insight; plain data belongs in a list/table people can scroll, search, sort.
- Keep charts simple with progressive disclosure for detail. Prefer common types (bar, line); novel types need teaching.
- Every chart needs accessibility labels for values and components — a headline doesn't substitute.
- Add descriptive text (title, annotations, optional summary headline); size charts for label legibility and interactivity.
- Same purpose → same type and style; same dataset → same colours/marks/annotations across small and expanded views.
- No platform deltas. Fetch for detail: charting-data

## collaboration-and-sharing
<!-- src: collaboration-and-sharing · changed: 2023-12-05 · platforms: iOS, iPadOS, macOS, visionOS, watchOS · speed: stub -->
- Use the system share sheet (iOS) / sharing popover (iPadOS, macOS) via a toolbar Share button (`ShareLink`); custom share UI is a flag.
- Permission summaries are one-line phrases: "Only invited people can edit".
- Show the Collaboration button as soon as collaboration starts, next to the Share button. Fixed popover anatomy: collaborator list + Messages/FaceTime buttons (top), essential custom items only (middle), management button, default title "Manage Shared File" (bottom).
- Custom sharing infrastructure must support universal links.
- Fetch for detail: collaboration-and-sharing

## drag-and-drop
<!-- src: drag-and-drop · changed: 2023-10-24 · platforms: iOS, iPadOS, macOS, visionOS · speed: stub -->
- Default semantics: same container → move; different container → copy; between apps → always copy. Option held at drop forces copy (checked at drop time, not drag start).
- Translucent drag image appears after ~3 points of movement, persists to drop. Valid destinations show an insertion point or highlight (exactly one at a time); invalid drops slide back to the source or fade out.
- Offer representations highest→lowest fidelity (PDF → PNG → JPEG); the destination takes the richest it accepts. Dropped content stays selected at the destination.
- Always provide non-drag alternatives (menu commands; accessibility drag/drop descriptors). Prefer undoable drops; otherwise confirm before completing.
- Fully supported on iPhone, not just iPad/Mac. macOS extras: multi-item count badge, pointer changes (copy/not-allowed), drag to Finder, clippings, background-selection drags.
- Drag-feedback state machine: checklists/review-flow.md. Fetch for detail: drag-and-drop

## entering-data
<!-- src: entering-data · changed: 2023-06-21 · platforms: all · speed: stub -->
- Never ask for what the system can supply (location, calendar, settings); prefill sensible defaults; prefer choices (picker/menu) over typing; accept paste and drag and drop.
- Every field gets a label or placeholder ("Email" / "username@company.com").
- Secure fields for sensitive data (`SecureField`); never prepopulate a password field — require entry or biometric/keychain auth (hard rule).
- Validate as values are entered, not on submit; number formatters for numeric fields; keep Next/Continue unavailable until required fields are filled.
- macOS only: expansion tooltip reveals truncated field values.
- Fetch for detail: entering-data

## feedback
<!-- src: feedback · changed: none (stable) · platforms: all · speed: stub -->
- Match significance to delivery: passive, in-context status near the items it describes; interruption only when avoidable harm is at stake.
- Alerts only for critical, ideally actionable information — overuse kills impact.
- Warn on unexpected irreversible loss; do NOT confirm expected loss (Finder doesn't confirm every deletion). Confirm completion only for significant actions (Apple Pay).
- When a command fails, say so and say why; people expect success and need to hear about failure.
- Feedback must survive silenced devices and VoiceOver — multiple channels, never colour alone.
- No iOS/macOS deltas. Fetch for detail: feedback

## file-management
<!-- src: file-management · changed: 2024-06-10 · platforms: all · speed: stub -->
- Avoid explicit save: autosave while editing, on close, on app switch — an explicit Save step in an iOS flow is a flag. Always include an Add (+) button for new documents; New/Open also live in menus/shortcuts (macOS File menu, iPadOS shortcuts).
- Hide file extensions by default, let people show them, reflect the choice in every open/save interface. Custom browsers must still reach the whole file system.
- Was: document browser as launch UI → Now: document launcher (iOS/iPadOS 18+, `DocumentGroupLaunchScene`, since 2024-06-10): title card with two buttons (primary typically creates a document), distinct calm background, accessories never obscuring the name or buttons, sparing animation.
- File provider extension: context-appropriate documents only; never add a custom top toolbar — the hosting modal has one.
- macOS: default file browser unless there's a real reason; save dialog with default title "Untitled" and optional accessory view; unsaved-changes dots (window close button, Window menu) ONLY when autosave is off; "Edited" title-bar suffix allowed either way until the next save.
- Quick Look generator for custom file types (system-wide previews).
- Biggest iOS/macOS divergence in the bucket. Fetch for detail: file-management

## modality
<!-- src: modality · changed: 2023-12-05 · platforms: all · speed: stub -->
- Modal only with clear benefit: critical info, confirm/modify the last action, a distinct narrowly scoped task, or immersive focus. Full-screen modal style is endorsed for in-depth multistep tasks — not discouraged.
- Keep modal tasks short and shallow; no "app within your app" (no tab bars or branching hierarchies; one path through any subviews).
- One modal at a time; an alert may appear on top of anything, but never two alerts at once.
- Always give an obvious dismiss; title the modal's task; confirm any dismissal that would lose user-generated content, whatever the route.
- Dismiss conventions: iOS/iPadOS button in the top toolbar or swipe down; macOS buttons in the sheet's content view. iPadOS/macOS may use a separate window instead.
- Fetch for detail: modality

## managing-notifications
<!-- src: managing-notifications · changed: none (stable; iOS 15 model) · platforms: all · speed: stub -->
- Permission is required before sending ANY notification. Focus defers the alert, not availability — Notification Center gets it on arrival; people choose who breaks through.
- Communication notifications (adopt SiriKit intents, e.g. `INSendMessageIntent`) vs noncommunication — the latter carry one of four interruption levels: Passive, Active (default), Time Sensitive, Critical (entitlement required; urgent health/safety only).
- Per-level override/breakthrough matrix: tables/notifications-matrix.md (single source — don't restate values).
- Time Sensitive only for events happening now or within an hour; the system periodically offers to revoke it. Misrepresented urgency trains people to switch you off.
- Marketing notifications (tier 1 — App Review enforces): explicit prior opt-in via a dedicated alert/modal/interface describing what you'll send, PLUS an in-app settings screen to change the choice; never Time Sensitive for marketing.
- Keep the HIG term "Ring/Silent switch" (iPhone/iPad-only matrix column) even on Action-button hardware; macOS has no silent switch (see playing-audio).
- Fetch for detail: managing-notifications

## playing-audio
<!-- src: playing-audio · changed: 2023-06-21 · platforms: all · speed: stub -->
- Silent mode silences nonessential audio (effects, soundtracks, feedback); explicitly initiated audio (media, alarms, calls) plays.
- Never adjust system volume — mix relative in-app levels; use the system volume view (`MPVolumeView`). Disconnecting headphones pauses playback immediately; permit rerouting.
- Choose the audio session category from the five-row table (silent switch × mixing × background): tables/audio-haptics.md. Don't silence another app's music needlessly.
- Respond to audio controls only in a clear audio context; never repurpose them; custom controls only for commands the system lacks. Flag your session on deactivation (`notifyOthersOnDeactivation`); resume after a resumable interruption (call), not a nonresumable one (new playlist).
- macOS: no silent switch; notification sounds mix with other audio by default.
- Fetch for detail: playing-audio

## playing-haptics
<!-- src: playing-haptics · changed: 2024-05-07 · platforms: all · speed: stub -->
- Use system haptic patterns by their documented meanings; never repurpose one; keep cause→haptic consistent.
- Complement other feedback, matching animation intensity/sharpness; avoid overuse — the best haptics "people may not be conscious of, but miss when it's turned off".
- Short haptics tied to discrete events in apps; make them optional; the app must work fully without them. Haptics can disrupt camera, gyroscope, and microphone.
- iOS `UIFeedbackGenerator` categories (Notification/Impact/Selection) and macOS Force Touch trackpad patterns (Alignment/Level change/Generic — drag and force-click contexts only): tables/audio-haptics.md.
- Apple Pencil Pro haptics exist (since 2024-05-07); avoid continuous haptics there.
- Fetch for detail: playing-haptics

## playing-video
<!-- src: playing-video · changed: 2023-09-12 · platforms: all · speed: stub -->
- Use the system video player; if custom is unavoidable, mirror system behaviour — slight divergence frustrates.
- System playback mode by aspect ratio: aspect-fill (fills screen, may edge-crop) is the default for 2:1–2.40:1 video; aspect (fit, letter/pillarboxed) for ≤2:1 and >2.40:1.
- Never bake letterbox/pillarbox padding into the frame — it breaks system scaling and PiP (hard fail).
- Space on a connected keyboard must play/pause (Mac, iPad, iPhone).
- TV-app entry: present black immediately, then content — no splash or intros; resume automatically, never ask; loads over 2 seconds show a black screen with a centred spinner only.
- No iOS/macOS deltas. Fetch for detail: playing-video

## searching
<!-- src: searching · changed: 2026-06-08 · platforms: all · speed: full -->
**HOT — edited 2026-06-08 during WWDC26, after a 2025-06-09 Liquid Glass rewrite. Re-verify searching, search-fields, tab-bars live before asserting placement.**
- People expect a search field; personalise it — recents before typing, predictive suggestions/completions/corrections while typing (`searchSuggestions(_:)`).
- If search is important, give it a primary position. Canonical placements (2026-06-08): a search field in the bottom toolbar beside key actions (Notes), or a dedicated search tab in the tab bar (Photos, Apple TV).
- Make content searchable through a single, clearly identified global search; local search only as an addition for clearly distinct sections.
- Always show the current scope: descriptive placeholder, scope bar, or title.
- Visible search history needs privacy thought and a clear-history affordance.
- Systemwide: index content with descriptive metadata so Spotlight finds it; custom file types ship a Spotlight File Importer (`CSImportExtension`) and a Quick Look generator; prefer system open/save views.
**Corrections.**
- Was: search field at the top, in/under the navigation bar, pull-down to reveal → Now: bottom-aligned placements — bottom-toolbar field or dedicated search tab (since 2025-06-09; reaffirmed 2026-06-08).
- Was: search-field anatomy (scope bars, tokens) lived here → Now: on search-fields (since 2025-06-09) — cite the component page.
- search-fields (2026-06-08) defines two co-equal search-tab styles: standard tab (uniform with other tabs, opens a search landing page) and button appearance (visually separated, focuses the field immediately).
- **Version-gated press claim, NOT doctrine:** press reports iOS 27 re-integrates the search tab with the other tabs. Not reflected in the HIG as of 2026-06-10 — tab-bars (2026-06-08) still allows "a dedicated search tab at the trailing end". Never flag a design against the press claim; verify live first.
**Deltas.** Page states none; macOS search lives in the toolbar search field plus Spotlight/Finder — detail on search-fields and toolbars.
**Reviewer checks.**
- Top-of-list navigation-bar search in an iOS 26 design → flag for bottom toolbar or search tab, then confirm against the live page.
- Multiple entry points with no global search; no scope indication; no recents/suggestions; history with no clear affordance.

## undo-and-redo
<!-- src: undo-and-redo · changed: none (stable) · platforms: iOS, iPadOS, macOS, visionOS · speed: stub -->
- Predictability + visible results: label the target ("Undo Typing", "Redo Bold"); scroll/highlight to reveal offscreen reversals, or people repeat the undo.
- Multi-level undo with no artificial limits — back to a logical step (document open, last save); consider batch revert.
- Don't redefine the standard routes: iPhone shake (the alert auto-prefixes "Undo "/"Redo " — supply only a word or two) and three-finger swipe left/right (undo/redo); macOS Edit-menu top items with Command-Z / Shift-Command-Z.
- Custom buttons only when necessary: standard system symbols, in a toolbar.
- Fetch for detail: undo-and-redo
