# HIG research — Patterns: interaction & data

Bucket: patterns-interaction. Fetched 2026-06-10 from Apple's JSON content API (`developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`). 14 pages: charting data, collaboration and sharing, drag and drop, entering data, feedback, file management, modality, managing notifications, playing audio, playing haptics, playing video, searching, undo and redo, live-viewing apps.

**Currency overview:** unlike the visual-design chapters, most of these patterns pages were NOT rewritten for Liquid Glass — their last-change alerts date 2023–2024 (modality 2023-12-05, drag and drop 2023-10-24, file management 2024-06-10, haptics 2024-05-07). Interaction behaviour is the *stable layer* of the HIG. The one exception is **Searching**: updated 2025-06-09 (Liquid Glass reorganisation) and again **2026-06-08 — during WWDC 2026, two days ago** ("Updated terminology and refined best practices"). Search placement is the actively moving target in this bucket.

---

## 1. Charting data

**URL:** https://developer.apple.com/design/human-interface-guidelines/charting-data
**Platforms:** all. Page added 2022-09-23, unchanged since.
**Purpose:** when and how to use charts to communicate data; defers component-level chart anatomy to the *Charts* component page.

### Normative rules
- Use a chart only to **highlight important information about a dataset** — if you only need to provide data (no analysis/insight), use a list or table people can scroll, search, and sort instead.
- **Keep a chart simple**; let people choose when to reveal additional details (levels of detail, subsets, progressively more capable chart versions). Don't pack maximum data in.
- **Every chart must be accessible**: accessibility labels describing chart values and components, plus accessibility elements for interacting with the chart. A descriptive headline does NOT replace accessibility labels.
- **Prefer common chart types** (bar, line) — people already know how to read them. Novel chart types require teaching (Apple's example: Activity rings introduced by animating each ring individually).
- **Add descriptive text**: titles, subtitles, annotations; optionally a headline/summary sentence (Weather's "Chance of light rain in the next hour" above the hourly forecast).
- **Match chart size to functionality**: large enough to read labels/annotations and support intended interactivity; small charts only for glanceable info or previews of an expandable larger chart.
- **Consistency across multiple charts**: same purpose → same type and style. Deviate only to signal a meaningful difference.
- **Continuity across views of the same dataset**: same chart type, colours, marks, annotations, layout, descriptive text between the small and expanded versions (Health Trends example).

### iOS vs macOS
None — page explicitly states "No additional considerations" for any platform.

### Reviewer checks
- Chart present but conveys no insight (raw data dump) → suggest list/table.
- Multiple charts of the same kind styled differently, or same dataset shown with different colours/marks across views.
- Chart with no title/annotation/summary text.
- Dense chart with no progressive-disclosure mechanism (no detail toggle, no expandable view).
- Tiny chart carrying labels/annotations too small to read; interactive chart without room to interact.
- Novel chart type with no onboarding/explanation.

### Stale-knowledge corrections
None — page is stable since 2022 and survived the Liquid Glass rewrite untouched. (Component-level chart specs live on the *Charts* page, a different bucket.)

---

## 2. Collaboration and sharing

**URL:** https://developer.apple.com/design/human-interface-guidelines/collaboration-and-sharing
**Platforms:** ios, ipados, macos, visionos, watchos (not tvOS). Last change 2023-12-05.
**Purpose:** integrating with the system share sheet / sharing popover, Messages collaboration, and the system Collaboration button.

### Normative rules
- **Place the Share button in a convenient location, like a toolbar.** SwiftUI: `ShareLink` opens the system share sheet.
- Works with CloudKit, iCloud Drive, or custom infrastructure; **custom collaboration infrastructure must also support universal links**.
- Customise the share sheet/popover to offer your supported file-sharing types; "send copy" support: CloudKit → pass file + collaboration object; iCloud Drive → default; custom → include a file or plain-text representation in the collaboration object.
- **Write succinct permission-summary phrases** — exact example wording: "Only invited people can edit", "Everyone can make changes". The system shows the summary in a button that reveals the sharing options.
- **Keep custom sharing options minimal and grouped** so they're understandable at a glance (who can access, edit vs read, whether collaborators can invite others).
- **Prominently display the Collaboration button as soon as collaboration starts**, typically placed **next to the Share button**. It identifies the content as shared and shows who's sharing.
- Collaboration popover has a fixed three-section anatomy: **top = collaborator list + communication buttons (Messages/FaceTime), middle = your custom items, bottom = collaboration-management button**. Add custom actions only if essential.
- The management button is titled **"Manage Shared File"** by default; customise the title if it helps. CloudKit provides the management view; otherwise build your own.
- Consider posting collaboration event notifications in Messages (content change, membership change, mention) with a universal link to the relevant view.

### iOS vs macOS
- iOS 16: system **share sheet**; iPadOS 16 and macOS 13: equivalent **sharing popover**. Same anatomy and behaviour; different presentation container. Otherwise "no additional considerations."

### Reviewer checks
- Custom share UI instead of the system share sheet/popover → flag.
- Share button buried (not in a toolbar or equally convenient spot).
- Shared content with no visible Collaboration button, or Collaboration button far from the Share button.
- Permission summary text that is long or vague (should be a one-line phrase like Apple's examples).
- Collaboration popover stuffed with custom actions (middle section should hold only essentials).

### Stale-knowledge corrections
- Messages collaboration + system Collaboration button shipped iOS 16/macOS 13 (2022) — models with older priors may not know the three-section collaboration popover anatomy or the permission-summary-button pattern.
- Page predates Liquid Glass and was not revised for it; behavioural guidance unchanged.

---

## 3. Drag and drop

**URL:** https://developer.apple.com/design/human-interface-guidelines/drag-and-drop
**Platforms:** ios, ipados, macos, visionos (NOT tvOS/watchOS). Last change 2023-10-24.
**Purpose:** the full source→destination drag lifecycle: move-vs-copy semantics, feedback states, drop handling.

### Normative rules — semantics
- Terminology: **source**, **destination**, **drag image**, **flocking**, **spring loading**, **background selection**, **clipping** (macOS).
- Default move/copy logic: **same container → move; different container → copy; between apps → always copy.** Before changing defaults, prefer the behaviour least likely to cause frustration or data loss.
- **Support drag and drop throughout the app** — people try it everywhere; system text fields/views give it free.
- **Always offer alternative ways** to accomplish the same action (menu commands for copy/move; on iOS/iPadOS use `accessibilityDragSourceDescriptors` / `accessibilityDropPointDescriptors` for assistive tech).
- **Support multi-item drag** where sensible. macOS additionally allows multi-item drags gathered across several apps; iPadOS allows adding items to an in-progress drag.
- **Prefer undoable drag-and-drop**; if not undoable, ask for confirmation before completing (Finder's write-only-folder example) or provide a reversal path (Photos lets people cancel after dropping into a shared stream).
- **Offer multiple representations of the dragged content ordered highest→lowest fidelity** (example order: PDF vector → lossless PNG with transparency → lossy JPEG; or native chart object → image of chart). Destination picks the richest it accepts.
- **Consider spring loading** (activating buttons/segmented controls by dragging content over them): on Mac with Magic Trackpad, activation by force click while holding the content; on iPad, by hovering while holding.

### Normative rules — feedback (the densest checkable state machine in this bucket)
- **Display a drag image as soon as people drag a selection about 3 points.** Make it a translucent representation; keep it visible until drop.
- Optionally morph the drag image to predict the result (photo expanding to its drop size); use **flocking** to visually group multi-item drags; avoid a constantly/radically changing drag image.
- **Show whether a destination can accept the content**: insertion point or container highlight only when it can accept; no feedback or an explicit "not allowed" image (SF Symbol `circle.slash`) when it can't. Highlight only while content is over the destination; with multiple possible destinations, cue exactly one at a time.
- **Failed/invalid drop feedback**: item slides back to source (if visible) or scales up and fades out ("evaporates").
- **Auto-scroll the destination** when dragging within a scrolling container; stop when the drag leaves the container (system text views do this by default).
- **Pick the richest version of dropped content your app can accept**; extract only the relevant portion when appropriate (Mail keeps only name + email when a contact is dropped on a recipient field).
- **Check the Option key at drop time** (hardware keyboard): Option held at drop forces same-container copy instead of move; Option released before drop → move.
- **Show progress for slow transfers** (progress indicator; placeholder at drop location in collections/lists/tables; the system can alert for time-consuming inter-app transfers).
- **Show task feedback** when a drop initiates an action (e.g. printing).
- **Text styling on drop**: keep original attributes if destination supports the same styles, otherwise apply the destination's style.
- **Selection state after drop**: dropped content stays selected in the destination; on same-container move the original disappears; on same-container copy, deselect the remaining original; on cross-container drag, deselect in the source.

### iOS vs macOS
| | iOS/iPadOS | macOS |
|---|---|---|
| Input | touch gestures, pointing devices, full keyboard access | pointing device, full keyboard access, VoiceOver |
| Multi-drag | iPadOS: add items to an in-progress drag (flocking feedback); accept multiple simultaneous drops | multi-item selection may span several apps; show a **badge** (small filled oval with count) during multi-item drags, updating it if the destination accepts only a subset |
| Extras | spring loading via hover-while-holding (iPad) | drag to Finder (export as openable file, e.g. Calendar `.ics`; or a **clipping** — unrelated to the Clipboard); drag a **background selection** from an inactive window without activating it; drag unselected items from inactive windows without disturbing the selection; change **pointer** to copy / drag link / disappearing item / operation-not-allowed; let people **select and drag in a single motion**; spring loading via force click (Magic Trackpad) |
| Cross-device | Universal Control drags between Mac and iPad | same |

### Reviewer checks
- Drag interactions with no translucent drag image, or drag image appearing late.
- No visual distinction between valid and invalid drop targets; multiple destinations highlighted simultaneously.
- No failure animation for invalid drops (item just vanishes).
- Move/copy semantics inverted (e.g. cross-app drag that moves).
- Drag-only features with no menu/button alternative (accessibility fail).
- Drops that can't be undone with no confirmation or reversal path.
- macOS prototypes: multi-item drag without a count badge; no pointer change on copy.
- Post-drop: dropped content not selected at destination.

### Stale-knowledge corrections
- Stable page (2023). The numbers and behaviours above (3-point threshold, Option-at-drop-time, badge ovals) predate and survived Liquid Glass.
- Models sometimes assume drag and drop is iPad/macOS-only — it's fully supported on iPhone since iOS 15 (within app) and the HIG treats iOS as a first-class platform here.

---

## 4. Entering data

**URL:** https://developer.apple.com/design/human-interface-guidelines/entering-data
**Platforms:** all. Last change 2023-06-21.
**Purpose:** minimising and easing data entry in forms and fields; defers field anatomy to *Text fields* and *Virtual keyboards*.

### Normative rules
- Two governing strategies: **pre-gather as much information as possible**, and **support all available input methods**.
- **Get information from the system whenever possible** — never ask people to type what you can read from settings or obtain by permission (location, calendar).
- **Be clear about the data you need**: placeholder prompt in the field (exact example: "username@company.com") or an introductory label ("Email"); prefill reasonable defaults to reduce decisions and speed entry.
- **Use a secure text-entry field** for sensitive data (obscures input with a filled-circle symbol per character; `SecureField`).
- **Never prepopulate a password field.** Always require entry, or biometric/keychain authentication. (Hard rule; cross-ref *Managing accounts*.)
- **Offer choices instead of text entry** when possible — picker, menu, or other selection component beats typing even when a keyboard is handy.
- **Let people provide data via drag and drop or paste.**
- **Dynamically validate field values** — verify as soon as entered, feedback as soon as a problem is detected, never make people fix a long form retroactively. For numeric data use a **number formatter** (restricts input to numerics; can format as decimals/percentage/currency).
- **Gate progression on required data**: e.g. keep a Next/Continue button unavailable until required fields are filled.

### iOS vs macOS
- macOS only: **expansion tooltip** — appears when the pointer rests on a field whose text is clipped/truncated, showing the full value (also applies to iOS/iPadOS apps running on a Mac). Otherwise no platform differences.

### Reviewer checks
- Form asks for data the system can supply (location, calendar, name, current settings) → flag.
- Text fields with neither label nor placeholder.
- Free-text input where a finite option set exists (should be picker/menu).
- Password/sensitive fields not obscured; prepopulated password field (hard fail).
- Validation only on submit (no inline validation), generic post-hoc error pages.
- Continue/Next button enabled while required fields are empty.
- Numeric fields accepting arbitrary text.
- macOS: truncated field values with no expansion tooltip.

### Stale-knowledge corrections
None substantive — guidance stable since 2023; unchanged through Liquid Glass.

---

## 5. Feedback

**URL:** https://developer.apple.com/design/human-interface-guidelines/feedback
**Platforms:** all. No change-log alert (stable page).
**Purpose:** matching the significance of information to the delivery mechanism (passive status vs interruptive alert); the umbrella page over alerts, haptics, sounds.

### Normative rules
- Feedback communicates four things: **current status; success/failure of a task; warning about negative consequences; opportunity to correct a mistake**.
- Core principle: **match the significance of the information to the way it's delivered**. Passive display for status; interruption only when avoidable harm (e.g. data loss) is at stake.
- **Make all feedback accessible** — use multiple channels (colour, text, sound, haptics) so it survives silenced devices, looking away, VoiceOver.
- **Integrate status feedback into the interface near the items it describes** (Mail's last-update line + unread count in the mailbox toolbar) rather than forcing action or context switch.
- **Alerts only for critical — and ideally actionable — information.** Alerts lose impact when overused (cross-ref *Alerts* component page).
- **Warn on unexpected, irreversible data loss; do NOT warn when data loss is the expected result** (Finder doesn't confirm every file deletion).
- **Confirm completion only for significant actions** (Apple Pay success). People expect success; they primarily need to know about failure.
- **When a command can't be carried out, say so and explain why** (Maps: can't route between identical start/end).

### iOS vs macOS
None — divergence is watchOS-only (avoid indeterminate progress indicators there; out of scope).

### Reviewer checks
- Alert used for non-critical info (status updates, confirmations of expected success, tips) → should be passive/inline.
- Confirmation dialog on an expected, recoverable action (e.g. confirming every delete that goes to a trash) → flag as over-warning.
- No warning before unexpected irreversible destruction.
- Success toasts/alerts on routine actions → reserve for significant ones.
- Status shown only via colour (no text/symbol redundancy) → accessibility fail.
- Error states that say a command failed without a reason.

### Stale-knowledge corrections
None — page stable through Liquid Glass. (Visual treatment of alerts/toasts changed with Liquid Glass materials, but that's the *Alerts*/components bucket; the decision logic here is unchanged.)

---

## 6. File management

**URL:** https://developer.apple.com/design/human-interface-guidelines/file-management
**Platforms:** all (document browsing UIs only on iOS/iPadOS/macOS/visionOS). Last change 2024-06-10 (added document launcher guidance).
**Purpose:** document-based app behaviours: creating/opening/saving files, the iOS/iPadOS document launcher, file provider extensions, macOS save dialogs and Finder integration, Quick Look.

### Normative rules — common
- People browse files outside apps: **Finder** on Mac; **Files app** on iPhone/iPad/Vision Pro. (watchOS/tvOS have no document browsing.)
- **Use menus and keyboard shortcuts** for New/Open: iPadOS surfaces them in the Command-key shortcuts interface; macOS in the menu-bar **File menu**. **Always include an Add (+) button** for creating documents regardless of keyboard availability.
- Custom file browser: must still let people reach **the rest of the file system**, not just your preferred folder; respect people's Finder/Files mental model.
- **Avoid explicit save actions**: autosave periodically while editing, on close, and on app switch. "Help people be confident that their work is always preserved unless they cancel or delete it."
- **Hide file extensions by default but let people show them**; reflect the choice consistently in every open/save interface.
- **Quick Look**: use a Quick Look viewer to preview file types your app can't open; implement a **Quick Look generator** for custom file types so Finder/Files/Spotlight can preview them.

### iOS/iPadOS only
- **Document launcher** (iOS 18/iPadOS 18+, `DocumentGroupLaunchScene`): full-screen graphical launch experience for document apps. Anatomy: **title card** (app title + two app-specified buttons) + **background image** + **accessories** (images around/behind/in front of the title card) + **sheet containing a file browser** with optional custom toolbar controls.
  - **Primary button typically creates a new document**; secondary offers options (Numbers example: "Start Writing" / "Choose a Template").
  - Background must be clearly distinct from title card and accessories — solid colour, gradient, or pattern; avoid complex distracting imagery.
  - Accessories may create depth but must never obscure the app name or either button; avoid clutter; test across screen sizes/orientations.
  - **Use animation sparingly** — gentle, repeating, subtle (breathe/sway), per *Motion* guidance.
- **File provider app extension**: show only context-appropriate documents (PDF editor loads your extension → list only PDFs); show modification dates/sizes/local-vs-remote where useful; let people pick a destination directory (and create subdirectories) when exporting/moving; **never add a custom top toolbar** (the hosting modal already has one — a second is confusing and steals space).

### macOS only
- **Use the default file browser unless you have an important reason** for a custom one.
- Open interface conveniences: "open recent", filter criteria, multi-select open; **customise the Open button title to the task** (e.g. "Insert").
- **Save interface**: lets people change name, format, location; default new-document title is **"Untitled"**; default to a logical save location; provide format choice if multiple formats are supported; the Save dialog accepts a **custom accessory view** for app-specific options (Mail's "include attachments" example).
- **Finder Sync extension** (apps syncing local/remote files): sync-status badges in Finder, custom contextual-menu items, custom toolbar buttons.
- **Autosave-off handling** (user enables "Ask to keep changes when closing documents" in Desktop & Dock settings): show unsaved-changes state via **a dot in the window close button and next to the document name in the Window menu**; present a save dialog on close/quit/logout/restart. **When autosave is ON, showing those dots is wrong** (implies a needed action). Either way you may append **"Edited" to the title-bar document title**, removing it as soon as the autosave or explicit save occurs.

### iOS vs macOS
Biggest divergence in this bucket. iOS/iPadOS: Files app, document launcher, file provider extensions, no user-visible save model at all. macOS: Finder, File menu, open/save dialogs and their customisation, autosave toggle handling, Finder Sync, "Untitled"/"Edited"/close-button-dot conventions.

### Reviewer checks
- Any explicit "Save" requirement in an iOS flow (beyond export) → flag; autosave is the platform expectation.
- Document app without an Add (+) button for new documents.
- macOS document mock missing File-menu commands or using a custom file browser without justification.
- File extensions force-shown, or shown inconsistently between open and save UIs.
- Document launcher mocks: accessories overlapping title-card text/buttons; busy background; heavy animation.
- File-provider-extension UI with its own top toolbar.
- macOS: "Edited" suffix or close-button dot shown while autosave is on.

### Stale-knowledge corrections
- **Document launcher is iOS 18/iPadOS 18+ (June 2024)** — absent from pre-2024 training data. It's now the canonical launch pattern for document-based iOS apps.
- Otherwise stable; macOS save-dialog conventions are decades-old and survived Liquid Glass.

---

## 7. Modality

**URL:** https://developer.apple.com/design/human-interface-guidelines/modality
**Platforms:** all. Last change 2023-12-05 ("Enhanced guidance for in-depth modal experiences and clarified guidance on multiple modal views").
**Purpose:** when to present content modally and how to keep modal experiences dismissible, focused, and shallow. Defers component anatomy to *Sheets*, *Alerts*, *Popovers*, *Action sheets*, *Activity views*.

### Normative rules
- Definition: modality "presents content in a separate, dedicated mode that **prevents interaction with the parent view and requires an explicit action to dismiss**."
- Legitimate uses: ensure critical info is received/acted on; confirm or modify the most recent action; perform a **distinct, narrowly scoped task** without losing context; provide an immersive experience or focus for a complex task.
- Component mapping: alerts on all platforms; context-specific options via activity views, sheets, confirmation dialogs/action sheets; distinct tasks via **sheets or popovers** on iOS/iPadOS/macOS — iPadOS/macOS may instead use a **separate window**.
- **Present content modally only when there's a clear benefit.**
- **Keep modal tasks simple, short, and streamlined.** If too complicated, people lose track of the suspended task, especially when the modal obscures the previous context.
- **Avoid an "app within your app."** A view hierarchy inside a modal makes people forget how to get back; if subviews are necessary, provide **a single path through the hierarchy** and avoid buttons that could be mistaken for the dismiss button.
- **Full-screen modal style** suits in-depth content or complex multistep tasks (video, photos, camera, document markup, photo editing) because it minimises distraction.
- **Always give an obvious way to dismiss**, following platform conventions (see below).
- **Confirm before dismiss when closing could lose user-generated content** — regardless of whether dismissal is via gesture or button; e.g. an iOS action sheet with a save option.
- **Title the modal's task** (or add descriptive text) so people keep their place.
- **One modal at a time**: let people dismiss the current modal before presenting another. Stacked/simultaneous modals create clutter and cognitive load. Exception: **an alert can appear on top of everything — but never display more than one alert at the same time.**

### iOS vs macOS
- Dismissal conventions: **iOS/iPadOS (and watchOS): button in the top toolbar or swipe down.** **macOS (and tvOS): button in the main content view** (e.g. Cancel/Done in the sheet body).
- macOS and iPadOS can use a separate window where iOS would use a sheet.
- Otherwise the page states "no additional considerations" per platform.

### Reviewer checks
- Sheet stacked on sheet, or modal presented over another modal (other than a single alert) → flag.
- Two alerts visible simultaneously → hard fail.
- Modal containing tab bars or multi-branch navigation ("app within app").
- Modal with no visible dismiss affordance; iOS sheet whose Close/Done is not in the top toolbar; macOS sheet whose buttons aren't in the content view.
- Editing flow in a modal with a content-discarding dismiss path and no confirmation.
- Untitled modal views performing non-obvious tasks.
- Modality used for content that doesn't need focus (a detail view that should be a navigation push).

### Stale-knowledge corrections
- Guidance text is pre-Liquid Glass (2023) and unchanged: the modality decision logic is stable. What changed in 2025 is the *rendering* (sheets and alerts use Liquid Glass material, sheet corner radii/inset look) — that lives in the component pages, not here.
- Models with old priors sometimes treat full-screen modals as discouraged; current guidance explicitly endorses **full-screen modal style for in-depth/multistep tasks**.
- The "one modal at a time / never two alerts" rule was *clarified* in Dec 2023 — older material is vaguer about stacking.

---

## 8. Managing notifications

**URL:** https://developer.apple.com/design/human-interface-guidelines/managing-notifications
**Platforms:** all. No recent alert; content reflects the iOS 15+ Focus/interruption-level model.
**Purpose:** permission, Focus integration, interruption levels, and the rules for marketing notifications.

### Normative rules
- **You need permission before sending ANY notification.** People can change the decision and silence all notifications in settings (government alerts excepted in some locales).
- Focus model: a **Focus** filters notifications during a reserved activity (sleeping, working, reading, driving); **delivery scheduling** lets people defer alerts into a summary. People choose contacts/apps that **break through** a Focus. A notification delayed by Focus is still *available* (Notification Center) as soon as it arrives — only the alert is delayed.
- Two notification classes: **communication notifications** (direct person-to-person: calls, messages — adopt SiriKit intents, `INSendMessageIntent`, so Siri can customise behaviour; alert timing is determined by the *sender*) and **noncommunication notifications** (everything else; you must assign an interruption level).
- **Four system-defined interruption levels** (noncommunication), verbatim definitions:
  - **Passive** — viewable at leisure (restaurant recommendation).
  - **Active** (default) — appreciated on arrival (sports score update).
  - **Time Sensitive** — directly impacts the person, requires immediate attention (account security issue, package delivery).
  - **Critical** — urgent health/safety, extremely rare, typically governmental/public agencies or health/home apps. **Requires an entitlement.**
- Behaviour matrix (verbatim from the page):

| Interruption level | Overrides scheduled delivery | Breaks through Focus | Overrides Ring/Silent switch (iPhone/iPad) |
|---|---|---|---|
| Passive | No | No | No |
| Active | No | No | No |
| Time Sensitive | Yes | Yes | No |
| Critical | Yes | Yes | Yes |

- **Build trust by accurately representing urgency** — misclassified urgency trains people to disable your notifications.
- **Time Sensitive only for events happening now or within an hour.** The system tells people how Time Sensitive works on first use and periodically offers to turn it off for your app.
- Marketing notifications (three hard rules, App Review-relevant):
  - **Don't send marketing/promotional content unless people explicitly agree** to receive it.
  - **Never use Time Sensitive for marketing.**
  - **Get explicit opt-in via an alert/modal/interface describing what you'll send, AND provide an in-app settings screen where people can change the choice.**

### iOS vs macOS
None stated (watchOS-only divergence: iPhone settings mirror to Watch; per-notification Mute 1 Hour / Turn off Time Sensitive options). Note: the Ring/Silent column applies to iPhone/iPad only — macOS has no equivalent; macOS notification *sounds mix with other audio by default* (stated on the Playing audio page).

### Reviewer checks
- Onboarding that requests notification permission before establishing value/context (cross-ref privacy/onboarding bucket) or sends notifications pre-permission.
- Any marketing/promo notification design without a separate explicit opt-in UI and an in-app notification-settings screen → hard fail.
- Notification mocks labelled Time Sensitive for non-immediate content (sales, digests) → hard fail.
- Critical level used by a non-health/safety app.
- Notification settings screen missing from apps that send informational/marketing notifications.

### Stale-knowledge corrections
- The interruption-level + Focus model is iOS 15 (2021) — old enough for most models, but the **marketing-notification opt-in + in-app management requirement** is often missed; it's firm HIG language ("you must").
- The HIG still says "Ring/Silent switch" even though recent iPhones replaced it with the Action button — keep Apple's terminology.
- Page unchanged through Liquid Glass; Notification *appearance* (glass material, grouping) changed but lives elsewhere.

---

## 9. Playing audio

**URL:** https://developer.apple.com/design/human-interface-guidelines/playing-audio
**Platforms:** all. Last change 2023-06-21.
**Purpose:** how app sound must respond to silence, volume, rerouting, and interruptions; choosing an audio session category.

### Normative rules
- **Silence semantics**: in silent mode the device plays only audio people explicitly initiate (media playback, alarms, audio/video messaging); nonessential audio (keyboard clicks, sound effects, game soundtracks, audible feedback) must be silenced.
- **Volume semantics**: system volume governs all sound regardless of adjustment method; the only exception is the iPhone **ringer volume** (separately adjustable in Settings). **Never adjust the overall system volume; adjust relative, independent in-app levels** to achieve your mix.
- **Headphones**: connecting reroutes sound automatically without interruption; **disconnecting pauses playback immediately**.
- **Permit rerouting of audio** (stereo, car, Apple TV) unless there's a compelling reason not to.
- **Use the system-provided volume view** (`MPVolumeView`: volume slider + reroute control; slider appearance is customisable).
- **Choose the audio category that fits your use of sound** (verbatim table):

| Category | Meaning | Silent switch | Mixes | Background |
|---|---|---|---|---|
| Solo ambient | Sound nonessential, silences other audio (game with soundtrack) | Responds | No | No |
| Ambient | Sound nonessential, doesn't silence others (game allowing other-app music) | Responds | Yes | No |
| Playback | Sound essential (audiobook, language app) | Ignores | Maybe | Can play |
| Record | Sound recorded (note-taking recorder) | Ignores | No | Can record |
| Play and record | Records and plays, possibly simultaneously (calls, audio messaging) | Ignores | Maybe | Can record and play |

- "Don't make people stop listening to music from another app if you don't need to."
- **Respond to audio controls (Control Center, headphone buttons) only when it makes sense** — if actively playing, in a clear audio context, or connected via Bluetooth/AirPlay; otherwise don't hijack and halt another app's audio.
- **Never repurpose audio controls** (consistent meaning everywhere); if a control isn't supported, don't respond to it.
- **Custom player controls only for commands the system doesn't support** (custom skip increments, related content like a sports score).
- **Flag your session on deactivation** so interrupted apps know they can resume (`notifyOthersOnDeactivation`).
- Interruption handling: decide per interruption whether to resume automatically — an incoming call is **resumable**; someone starting a new playlist is **nonresumable**. A media app checks the interruption type before resuming; a game can resume its soundtrack unconditionally (its audio wasn't an explicit user choice).
- Recording privacy example: a VoIP app must end the call when an iPad Smart Folio closes (mic muted); restarting the session on reopen would unmute without the person's knowledge.

### iOS vs macOS
- iOS/iPadOS: use the system **sound services** for short sounds and vibrations; Ring/Silent switch semantics apply.
- macOS: **notification sounds mix with other audio by default**; no silent switch.

### Reviewer checks
- In-app volume slider that sets system volume, or custom volume UI instead of `MPVolumeView` → flag.
- Game/app design that blocks or stops other-app music without need (wrong category choice).
- Sound effects/keyboard-click-type feedback that would play in silent mode.
- Custom playback controls duplicating system-supported commands.
- Play/pause/skip controls with nonstandard meanings.
- Designs where disconnecting headphones implies playback continues on speaker.

### Stale-knowledge corrections
- Stable page. Note again: "Ring/Silent switch" remains the HIG term despite Action-button hardware.
- The five-category table is the canonical decision tool; models often paraphrase it loosely — encode verbatim.

---

## 10. Playing haptics

**URL:** https://developer.apple.com/design/human-interface-guidelines/playing-haptics
**Platforms:** all. Last change 2024-05-07 (Apple Pencil Pro guidance).
**Purpose:** when and how to play haptic feedback; system patterns vs custom haptics.

### Normative rules
- Built-in haptics: iPhone components (switches, sliders, pickers) play system haptics automatically; Apple Watch Taptic Engine pairs haptics with audible tones; Mac with **Force Touch trackpad** can play haptics during drags or on force click. External devices: game controllers (iPadOS/macOS/tvOS/visionOS), **Apple Pencil Pro**, some trackpads on certain iPads.
- **Use system-provided haptic patterns according to their documented meanings.** If the documented use case doesn't fit, use a generic pattern or create a custom one — never repurpose a standard pattern to mean something else.
- **Be consistent**: build a clear causal relationship between each haptic and its trigger (same pattern for failure must not also signal success).
- **Complement, don't replace, other feedback**: match haptic intensity/sharpness to the accompanying animation; optionally synchronise sound with haptics.
- **Avoid overuse** — occasional feels right, frequent becomes tiresome; "the best haptic experience is one that people may not be conscious of, but miss when it's turned off." User-test the balance.
- **Prefer short haptics tied to discrete events in apps** (long-running haptics are a game-flow thing; on Apple Pencil Pro continuous haptics make holding the pencil unpleasant).
- **Make haptics optional** (a setting to turn off/mute) and ensure the app works fully without them.
- **Haptic vibration can disrupt camera, gyroscope, or microphone** — check interactions with those features.
- Custom haptics building blocks: **transient events** (brief, compact — taps/impulses, e.g. the Flashlight button tap) and **continuous events** (sustained vibration, e.g. the lasers message effect); both parameterised by **sharpness** (soft/rounded/organic ↔ crisp/precise/mechanical) and **intensity** (strength). Can vary dynamically with input/context; can include audio (Core Haptics).

### iOS vs macOS
- **iOS (supported iPhones)**: standard components play system haptics by default; `UIFeedbackGenerator` offers three predefined categories — **Notification** (outcome of a task: deposit, vehicle unlock), **Impact** (physical metaphor: view snapping into place, collision thud), **Selection** (value changes while manipulating a UI element).
- **macOS (Magic Trackpad/Force Touch only, and only for drag operations or force clicks)** — three patterns:

| Pattern | Use |
|---|---|
| Alignment | dragged item aligns (shape snapping, scale-to-fit, reaching min/max or start/end of a scrubber) |
| Level change | discrete pressure levels (pressing deeper on fast-forward changes speed) |
| Generic | anything else |

### Reviewer checks
(Mostly prototype/spec review rather than static screens.)
- Haptic specified for both a success and a failure outcome using the same pattern.
- Haptics on high-frequency events (every scroll tick, every keypress in an app context).
- No user setting to disable haptics; functionality that depends on feeling a haptic.
- Standard pattern repurposed (e.g. "error" haptic on success).
- macOS designs invoking haptics outside drag/force-click contexts (unsupported).
- Haptics specified during camera capture or audio recording.

### Stale-knowledge corrections
- Apple Pencil Pro haptics (May 2024) post-date some training data.
- Stable otherwise; unchanged through Liquid Glass.

---

## 11. Playing video

**URL:** https://developer.apple.com/design/human-interface-guidelines/playing-video
**Platforms:** all. Last change 2023-09-12.
**Purpose:** using the system video player, aspect-ratio playback modes, PiP audio hygiene, TV-app integration.

### Normative rules
- **Use the system video player** for a familiar experience; if a custom player is truly required, mirror the system player's behaviour and interface — "a custom experience that diverges slightly... can cause frustration."
- Playback modes (system default chosen by aspect ratio):
  - **Full-screen (aspect-fill)**: video scales to fill, may edge-crop. Default for **wide video: 2:1 through 2.40:1** (`resizeAspectFill`).
  - **Fit-to-screen (aspect)**: whole frame visible, letterbox/pillarbox as needed. Default for **standard video (4:3, 16:9, up to 2:1) and ultrawide (above 2.40:1)** (`resizeAspect`).
- **Always deliver video at its original aspect ratio — never embed letterbox/pillarbox padding in the frame.** Embedded padding breaks system scaling, shrinks the image in both modes, and breaks edge-to-edge contexts like PiP on iPad.
- Provide additional metadata (image, title, description) when it adds value, without obscuring playback (`externalMetadata`).
- **Support expected input regardless of device**: pressing **Space on a connected keyboard must play/pause** on Mac, iPhone, iPad (and Vision Pro/Apple TV).
- **Avoid mixed audio across mode switches** (e.g. PiP + full-screen game): handle secondary audio correctly (`silenceSecondaryAudioHintNotification`).
- TV-app integration (applies to iOS/iPadOS/macOS/tvOS apps distributing via the TV app):
  - Transition: TV app fades to black and skips your launch screen — **present your own black screen immediately**, then content.
  - **Show the chosen content immediately** — no splash screens, detail screens, or intro animations between transition and playback.
  - **Never ask whether to resume playback — resume automatically**, from the previous end time for long clips.
  - Multiple profiles: switch automatically to the profile in the playback request; if unspecified, ask once before playback.
  - Loading: **avoid loading screens if content loads quickly; if loading exceeds 2 seconds, show a black screen with a centered activity spinner and nothing else**; start playback as soon as enough content has loaded, keep loading in the background; keep any branding minimal on the black background.
  - Exiting playback: keep people in your app on a **contextually relevant screen** — detail view for what they just watched with a resume option (or content menu/main menu); prepare the exit view as soon as playback starts in case of immediate exit.

### iOS vs macOS
None — "No additional considerations for iOS, iPadOS, or macOS." (tvOS: translucent SDR overlays, image-retention caution, **minimum 0.5-second delay before pausing media to show an interactive overlay**; visionOS: 160 px-wide scrub thumbnails, no auto-start of immersive playback; watchOS: clips ≤ 30 s, H.264 High Profile 160 kbps ≤ 30 fps, 208×260 px portrait / 320×180 px 16:9, 64 kbps HE-AAC audio — out of scope but noted for completeness.)

### Reviewer checks
- Custom video player chrome that diverges from system player layout/behaviours.
- Video assets or mocks with baked-in letterboxing/pillarboxing → hard fail (breaks PiP and scaling).
- Resume-playback confirmation dialogs → flag (auto-resume).
- Splash/branded loading screens before video; loading screens that aren't black-with-centered-spinner.
- Prototypes that don't map Space to play/pause when a keyboard is present.

### Stale-knowledge corrections
- Stable page; numbers above (2:1/2.40:1 thresholds, 2 s, 0.5 s) are current.

---

## 12. Searching

**URL:** https://developer.apple.com/design/human-interface-guidelines/searching
**Platforms:** all. **Updated 2026-06-08 — during WWDC 2026** ("Updated terminology and refined best practices"); previously rewritten 2025-06-09 for the Liquid Glass reorganisation. The most current page in this bucket.
**Purpose:** in-app search behaviour and placement, plus systemwide (Spotlight) integration. Component specifics (scope bars, tokens) live on *Search fields*.

### Normative rules
- People expect a **search field** for in-app search; personalise with **recent searches, search suggestions, completions, or corrections**.
- **If search is important, give it a primary position.** Current canonical examples (post-Liquid Glass): **Notes — search field in the bottom toolbar alongside other important actions; Photos and Apple TV — search is a dedicated tab in the tab bar.**
- **Make content searchable through a single location.** One clearly identified global search; local search is acceptable as an addition for clearly distinct sections (iOS Music: search acts as a filter on the current view within songs/albums).
- **Clearly display the current scope**: descriptive placeholder text, a **scope bar**, or a title (Mail always shows which mailbox you're searching).
- **Provide suggestions**: recents before typing; predictive suggestions while typing (`searchSuggestions(_:)`).
- **Privacy**: consider before displaying search history where others might see it; if shown, provide a way to clear it.
- Systemwide search (Spotlight, iOS/iPadOS/macOS):
  - Index your content with descriptive **metadata** so Spotlight finds it without opening the app.
  - Custom file types → supply a **Spotlight File Importer plug-in** (`CSImportExtension`) describing their metadata.
  - You can use Spotlight *inside* your app for advanced file search (e.g. a button that searches based on the current selection, results in a custom view).
  - **Prefer the system open/save views** — they include built-in systemwide search/filter.
  - Implement a **Quick Look generator** for custom file types so Spotlight and other apps can preview documents.

### iOS vs macOS
Page states no additional platform considerations. In practice (examples given are iOS-flavoured): iOS placement = bottom toolbar search field or dedicated search tab; macOS search lives in the toolbar search field plus Spotlight/Finder integration — but the page leaves macOS specifics to the *Search fields* and *Toolbars* component pages.

### Reviewer checks
- iOS app with search rendered as a pre-iOS-26 top-of-list navigation-bar search bar → flag for Liquid Glass-era placement (bottom toolbar or dedicated tab), then verify against the live page given the 2026-06-08 churn.
- Multiple competing search entry points with no single global search.
- Search UI with no scope indication (no placeholder/scope bar/title saying what's being searched).
- No recents/suggestions in the search experience.
- Search history displayed with no clear-history affordance.

### Stale-knowledge corrections — IMPORTANT, highest churn in bucket
- **Pre-2025 priors are wrong here.** Old convention: search field at the top, embedded in/under the navigation bar, often revealed by pull-down. Liquid Glass (iOS 26) moved canonical search to **bottom-aligned placements** — a bottom toolbar search field (Notes) or a **dedicated search tab** (Photos, Apple TV), with iOS 26's floating tab bar separating the search tab from the other tabs.
- **WWDC 2026 (this week) churned this again**: the page's terminology/best-practices were edited 2026-06-08, and external reporting indicates iOS 27 re-integrates the search tab with the other tabs (reversing iOS 26's split-search look). Skills must treat search placement as version-sensitive and prefer live verification of this page plus *Search fields* and *Tab bars*.
- The 2025 rewrite moved general search-field guidance from this page to *Search fields* — when models cite "Searching" for scope-bar/token details, the canonical source is now the component page.

---

## 13. Undo and redo

**URL:** https://developer.apple.com/design/human-interface-guidelines/undo-and-redo
**Platforms:** ios, ipados, macos, visionos (NOT tvOS/watchOS). Stable page.
**Purpose:** predictable, multi-level undo/redo with visible results.

### Normative rules
- People try undo repeatedly until something visibly changes; they often can't remember which action is targeted — so **predictability and visible results are the core duties**.
- **Help people predict the result**: on iPhone, the shake-to-undo alert can describe the pending operation and offer perform/cancel; menu items should carry result labels, e.g. **"Undo Typing", "Redo Bold"**.
- **Show the results**: if the undone change is offscreen, scroll/highlight to reveal it (e.g. scroll to a restored paragraph) — otherwise people think nothing happened and repeat the undo.
- **Let people undo multiple times** — no artificial limits; expectation is undo of *every* action back to a logical step (opening a document, last save).
- **Consider batch revert**: undo a group of related incremental adjustments at once, or revert everything since open/save.
- **Provide undo/redo buttons only when necessary**; the system-supported routes are the default (Edit menu on macOS, keyboard shortcuts on Mac/iPad, shake on iPhone, three-finger swipes). If buttons are warranted, **use the standard system-provided symbols and put them in a toolbar**.

### iOS vs macOS
- **iOS/iPadOS:** don't redefine the standard gestures — **three-finger swipe** (left = undo, right = redo) and **shake** on iPhone. The shake alert title automatically prefixes **"Undo " or "Redo " (with trailing space)**; you supply only **a brief additional word or two** describing the operation — e.g. "Undo Name", "Redo Address Change".
- **macOS:** undo/redo at the **top of the Edit menu**; standard shortcuts **Command-Z** (undo) and **Shift-Command-Z** (redo) are mandatory expectations.

### Reviewer checks
- Editing/creation app with no undo path at all → flag.
- macOS mock whose Edit menu lacks Undo/Redo at the top, or with nonstandard shortcuts.
- Generic menu labels "Undo"/"Redo" in a document app where the operation is knowable → suggest "Undo Typing"-style labels.
- Custom undo buttons not using system symbols or placed outside a toolbar.
- Single-level undo, or undo that stops at arbitrary limits.
- Prototypes that repurpose three-finger swipe or shake for anything else.

### Stale-knowledge corrections
None — stable page; shake-to-undo and three-finger gestures both remain documented in 2026.

---

## 14. Live-viewing apps (brief)

**URL:** https://developer.apple.com/design/human-interface-guidelines/live-viewing-apps
**Platforms:** all (in practice tvOS-centric; iOS/macOS-relevant for streaming/TV apps). Stable page.
**Purpose:** live-content (vs video-on-demand) apps: instant playback, liveness indication, EPG, cloud DVR.

### Normative rules (condensed)
- **Feature live content in the first tab**; minimise app-open-to-playback time. **One tap — or none — to start playback** (e.g. a Watch Now button on featured content that vanishes into full-screen playback).
- **Make live content look live**: distinguishable from VOD at a glance — badge, symbol, or sash; a "Live" collection row; consider a progress indicator showing how much of the in-progress content remains.
- Secondary actions (record, restart, download, favourite) in **the same order everywhere** (e.g. Watch, Start Over, Record, Favorite). Playback is always the primary action.
- **Content footer** (channel browsing during playback): subtle darkening for legibility; badge/tint the currently playing thumbnail; categories must match the EPG; symmetric invoke/dismiss gestures (swipe up to invoke → swipe down to dismiss).
- **Instant visual feedback on channel change** (confirms arrival + masks stream loading).
- **Audio matches context**: keep playing while browsing within the live context; stop when leaving the live tab.
- **EPG**: current program/channel/time easy to spot with instant return to playback; effortless paging/scrolling/jumping; My Channels/Favorites group; familiar categories (Movies, TV Shows, Kids, Sports, Popular); allow browsing without leaving playback (PiP/background).
- **Cloud DVR**: start/stop recording from the info panel while streaming; record future programs from a detail view with episode-vs-series options; fine-grained recording rules (only new episodes, specific teams); playback/delete/settings inside the DVR area; storage management options (auto-overwrite oldest/watched).

### iOS vs macOS
None stated.

### Reviewer checks
- Live and VOD content visually identical (no live badge/sash).
- Live content buried (not first tab; > 1 tap to playback).
- Action ordering inconsistent between screens.
- EPG categories diverging from content-footer categories.

### Stale-knowledge corrections
None — stable niche page.

---

# Cross-page synthesis for skill design

## Hard numeric specs in this bucket (complete list)
| Spec | Page |
|---|---|
| Drag image appears after ~3 pt of drag movement | Drag and drop |
| Aspect-fill default for 2:1–2.40:1 video; aspect (fit) for ≤2:1 and >2.40:1 | Playing video |
| Loading screen only if load > 2 s; black + centered spinner | Playing video (TV-app integration) |
| ≥ 0.5 s pause delay before interactive overlays (tvOS) | Playing video |
| Time Sensitive = happening now or within 1 hour | Managing notifications |
| Undo alert prefix "Undo "/"Redo " + 1–2 word description | Undo and redo |
| Cmd-Z / Shift-Cmd-Z; Edit-menu top placement | Undo and redo |
| watchOS video: H.264 High Profile, 160 kbps ≤30 fps, 208×260 / 320×180 px, 64 kbps HE-AAC | Playing video (out of scope) |
| visionOS scrub thumbnails 160 px wide | Playing video (out of scope) |

## Verbatim decision tables worth encoding
1. **Notification interruption levels** — 4 levels × (scheduled-delivery override / Focus breakthrough / Ring-Silent override) + entitlement rule for Critical.
2. **Audio session categories** — 5 categories × (silent switch / mixing / background).
3. **macOS trackpad haptic patterns** — Alignment / Level change / Generic; iOS `UIFeedbackGenerator` Notification / Impact / Selection.

## Hard-fail compliance rules (App Review-adjacent)
- Permission before any notification; explicit opt-in + in-app management screen for marketing notifications; never Time Sensitive for marketing; Critical needs an entitlement.
- Never prepopulate a password field.
- Never show two alerts at once.
- Never adjust system volume; never repurpose audio controls or standard gestures (shake, three-finger swipe).
- Never embed letterbox/pillarbox padding in video frames.

## Where iOS and macOS actually diverge
Concentrated in 4 pages: **file management** (Files/document launcher/no save model vs Finder/save dialogs/autosave-off conventions), **drag and drop** (macOS-only: Finder export, clippings, background selections, badges, pointers), **undo/redo** (shake + 3-finger swipe vs Edit menu + shortcuts), **modality dismissal** (top-toolbar button/swipe-down vs button in content view). The other 10 pages are explicitly platform-uniform.

## Currency map
- Stable through Liquid Glass: charting data, collaboration, drag and drop, entering data, feedback, modality, notifications, audio, haptics, video, undo/redo, live-viewing.
- Post-2024 additions: document launcher (iOS 18), Apple Pencil Pro haptics.
- **Actively churning: Searching** (rewritten 2025-06-09, edited again 2026-06-08 during WWDC26; search placement moved bottom-ward in iOS 26 and is reportedly being re-integrated with tab bars in iOS 27). Treat search placement as version-sensitive; prefer live fetch.
