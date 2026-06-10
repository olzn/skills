# HIG research — Components: System experiences (gap pages)

Bucket: controls (Control Center / Lock Screen / Action button), notifications (component page), status bars, App Shortcuts, snippets.
Source: Apple JSON content API (`developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`), fetched 2026-06-10 (mid-WWDC26 week). These are the System-experiences pages that fell through the earlier audit; `live-activities`, `widgets`, and `managing-notifications` (the *pattern* page) are covered in other notes files.

Currency map for this bucket (per-page change log):
- **app-shortcuts — 2026-06-08 (changed THIS WEEK)**: "Added guidance for adopting app schemas." Earlier: 2025-01-17 (streamlined), 2023-06-05 (new page).
- **snippets — 2026-06-08: NEW PAGE** (WWDC26). No pre-2026 model knows this HIG concept.
- **status-bars — no change-log table**, but the body was silently rewritten in the Liquid Glass era: it now references `ScrollEdgeEffectStyle` (SwiftUI) and `UIScrollEdgeEffect` (UIKit), both iOS 26 APIs.
- controls — 2024-06-10 (new page, iOS 18 era). No logged update since, but Platform considerations now include **macOS** with no extra considerations — a silent addition (macOS 26 Control Center).
- notifications — 2023-10-24 (watchOS double-tap guidance). Stable through the Liquid Glass rewrite.

Big picture: this bucket is about your app's presence *outside* its own windows. The common thread is **system-owned chrome, app-supplied content**: the system renders the container (control tile, notification banner, status bar, snippet card) and your job is symbols, titles, values, dialogue, and actions that survive redaction, hidden previews, audio-only delivery, and lock-state security. Almost everything here is built on App Intents / WidgetKit / UserNotifications, not in-app UI frameworks.

---

## Controls (Control Center / Lock Screen / Action button)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/controls
**Platforms:** iOS, iPadOS, macOS ("No additional considerations for iOS, iPadOS, or macOS"). NOT watchOS, tvOS, or visionOS.
**Change log:** June 10, 2024 — New page. (iOS 18 launch; macOS support added silently later — see stale corrections.)
**Frameworks:** WidgetKit (`ControlWidget`) + App Intents; `LockedCameraCapture` for locked-device capture.

**Purpose.** A control is a **button or toggle** that gives quick access to an app feature from Control Center, the Lock Screen, or the Action button. Control *buttons* perform an action, deep-link to a specific area of the app, or launch a camera experience on a locked device. Control *toggles* switch between two states (on/off). People add them by long-pressing an empty area of Control Center, customizing the Lock Screen, or configuring the Action button in Settings. Naming trap: this HIG page is NOT about generic UI controls (buttons/sliders) — it is exclusively the system-experience tile.

**Anatomy.** Symbol image + title + optional value. Symbol = SF Symbol or custom symbol representing what the control does; title = what the control relates to (e.g. the name of a light); value = state (e.g. on/off). Display varies by surface:
- **Control Center**: symbol; at larger tile sizes also title and value.
- **Lock Screen**: **symbol only**.
- **Action button** (iPhone): press-and-hold shows the symbol in the **Dynamic Island**, plus the value if present.

**Normative rules.**
- Offer controls for actions that deliver the most benefit **without launching the app**; launching a Live Activity from a control is the cited good pattern (progress without navigation).
- **Update controls** when someone interacts, when an action completes, **or remotely via push notification**; reflect in-progress state accurately.
- Symbol must convey the action on its own (Lock Screen drops title/value). **Toggles need a symbol per state** — e.g. `door.garage.open` / `door.garage.closed`.
- **Animate symbol state changes** (Symbols framework, `SymbolEffect`). For buttons with a duration: animate **indefinitely while the action runs, stop when complete**.
- **Tint color** from your brand: system applies it to a toggle's on-state symbol, and to the value+symbol shown in the Dynamic Island when the Action button runs the control.
- **Configuration at add time**: if the control needs setup (e.g. pick which light), prompt when first added (`promptsForUserConfiguration()`); reconfigurable any time.
- **Action button hint text**: shown on press (before press-and-hold executes); **construct with verbs** (`controlWidgetActionHint(_:)`).
- **Placeholder title/value** when content is situational — shown in the controls gallery and before Action button assignment.
- **Redaction when locked**: have the system redact title and value for personal/security-related info; optionally redact symbol state too (then title+value redact and the symbol shows its **off** state).
- **Require authentication for security-affecting actions** (`IntentAuthenticationPolicy`) — unlock-the-door, start-the-car class actions must require device unlock.

**Camera experiences on a locked device** (iOS 18+, `LockedCameraCapture`): a control can launch directly into the app's camera while locked; **anything beyond capture requires authenticating/unlocking**. Use the **same camera UI** in-app and in the locked experience (seamless transition when the person taps through to post/edit). Provide in-app instructions for adding the control.

**iOS vs macOS.** iPhone is the home platform — Lock Screen slots, Action button, and Dynamic Island are iPhone-only surfaces. macOS support means controls appear in the Mac's Control Center (and its menu-bar customization); the page declares no additional considerations, so the same symbol/title/value/tint rules carry over. Don't mock Lock Screen or Action button placement for a Mac design.

**Reviewer checks.**
- Toggle with a single symbol for both states → violation (needs on+off symbols).
- Control not interpretable from symbol alone → fails the Lock Screen surface.
- Control that merely opens the app with no immediate action value → flag.
- Sensitive title/value (home security state, health) with no lock-state redaction → violation.
- Security-affecting action with no authentication requirement → violation.
- Action button hint text that isn't a verb phrase → flag.
- Long-running action with no in-progress animation, or state left stale after completion / remote change → flag.
- Control needing configuration but no add-time prompt → flag.
- Locked camera control whose capture UI differs from the in-app camera → flag.

**Stale-knowledge corrections.** Pre-iOS 18 knowledge says third-party Control Center items are impossible, Lock Screen bottom controls are fixed to flashlight/camera, and the Action button only runs Shortcuts — all obsolete since iOS 18 (this page, June 2024). Controls are built with **WidgetKit + App Intents**, not UIKit, and are distinct from widgets despite sharing WidgetKit. macOS now hosts third-party controls (macOS 26 era) — older knowledge marks this iOS-only. visionOS/watchOS still unsupported.

---

## Notifications (component page)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/notifications
**Platforms:** all ("No additional considerations for iOS, iPadOS, macOS, tvOS, or visionOS"; watchOS has its own section).
**Change log:** October 24, 2023 — watchOS double-tap guidance. Otherwise stable; pre-dates Liquid Glass and survived it unchanged.
**Frameworks:** UserNotifications, UserNotificationsUI (`UNNotificationSound`, `hiddenPreviewsBodyPlaceholder`).

**Purpose.** Timely, high-value, glanceable information. This component page owns **anatomy, content writing, notification actions, and badging**. Consent flows, interruption levels (Passive/Active/Time Sensitive/Critical), Focus, and scheduling live on the `managing-notifications` *pattern* page — don't conflate. Consent is mandatory before sending anything.

**Anatomy.** Style varies by platform: (a) banner/view on the Lock Screen, Home Screen, Home View, or desktop; (b) **badge** on the app icon; (c) item in **Notification Center**. **Communication notifications** (calls, messages) get a distinct system interface: prominent contact image/avatar and group name **instead of** the app icon.

**Normative rules — behavior.**
- Concise and informative; people opted in for quick updates.
- **Never send multiple notifications for the same thing**, even unanswered — fills Notification Center, drives people to disable all your notifications.
- Don't send notifications instructing people to do tasks in your app — offer **notification actions** for simple tasks instead; instructions are forgotten once dismissed.
- **Errors are alerts, not notifications.** Using the wrong component confuses people.
- **Foreground handling:** banners don't appear while your app is frontmost, but the app receives the data — surface it discoverably and non-invasively (increment a badge, subtly insert into the current view; Mail just adds the message to the list).
- **No sensitive/personal/confidential content** — you can't predict who's looking at the screen.

**Normative rules — content.**
- Title shows at top. Communication notifications auto-title with the **sender's name**; noncommunication notifications fall back to your **app name** if you provide no title.
- Title: brief, glanceable, **title-style capitalization, no ending punctuation**. Use the title slot for real information (headline, event name, email subject). If your best title is generic ("New Document"), provide none and let the app name show.
- Body: **complete sentences, sentence case, proper punctuation; don't truncate yourself** — the system truncates when needed.
- **Hidden previews**: when people hide previews, the system shows only your icon + the default title "Notification". Supply `hiddenPreviewsBodyPlaceholder` text that describes without revealing — "Friend request", "New comment", "Reminder", "Shipment". **Sentence-style capitalization** for this text.
- **Never put your app name or icon in the content** — the system shows a large app icon at the leading edge automatically (communication: contact image badged with a small app icon).
- Sound: optional differentiator; custom sounds must be **short, distinctive, professionally produced**; never the sole carrier of important info; **you cannot programmatically add a vibration** to accompany the sound.

**Normative rules — actions.**
- The expanded detail view holds **up to four buttons** for acting without opening the app (Calendar's Snooze).
- Actions = common, time-saving tasks; labels are **short, title-case** phrases describing the result; no app name, no extraneous words, localization-safe length.
- **No action that merely opens the app** — tapping the notification already does that; a duplicate button clutters and confuses.
- **Prefer nondestructive actions.** Destructive ones get the system's distinct destructive appearance and require enough context to avoid accidents.
- Give each action an **SF Symbol interface icon**, displayed on the **trailing** side of the action title.

**Normative rules — badging.**
- A badge is a small filled oval whose number = **count of unread notifications, nothing else**. Never weather, dates/times, stock prices, scores.
- Badging can be turned off per-app — **never the only channel** for essential information.
- Keep counts current: clear as soon as notifications are addressed. **Gotcha: setting the badge count to zero removes all of the app's notifications from Notification Center.**
- **Never build custom UI that mimics a badge** — people who disabled badges will be frustrated by a fake one.

**iOS vs macOS.** Content/action/badge rules are identical; the page declares no platform deltas for iOS or macOS. Differences are environmental: macOS banners appear at the desktop's top-right and there's no Lock Screen stack equivalent; badge appears on the Dock icon. watchOS specifics (short look/long look, double tap) are out of scope here, but one cross-cutting rule leaks back: **double tap on Apple Watch triggers the first nondestructive action**, so order actions with the most common nondestructive one first — payloads are shared with the paired Watch even if you only design for iPhone.

**Reviewer checks.**
- Error message delivered as a notification → should be an alert.
- Repeat/reminder notifications for the same unaddressed event → violation.
- App name in title or body text → violation (system already shows the icon/name).
- Title with terminal punctuation, or body in fragments/all-caps → flag.
- No hidden-previews placeholder for an app sending personal content → flag.
- More than 4 actions; destructive action listed first; an "Open app" action → violations.
- Badge used as a counter for anything but unread notifications; custom badge-mimicking UI → violations.
- In-app banner replicating the system notification while the app is foreground → flag (prefer subtle in-context surfacing).
- Sensitive details (codes, balances, health data) in the visible payload → violation.

**Stale-knowledge corrections.** Communication-notification styling (avatar instead of app icon) is granted by the system when intents are donated — don't fake avatars in payload imagery. The page never mentions interruption levels or Focus; reviewers citing "Time Sensitive" rules should source them from `managing-notifications`. Pre-2021 knowledge of "Notification Center widgets" (Today extensions) is long dead. The zero-badge-clears-Notification-Center side effect is current and frequently missed.

---

## Status bars

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/status-bars
**Platforms:** iOS, iPadOS only. **Not supported in macOS**, tvOS, visionOS, watchOS. (macOS naming trap: Apple's "menu bar extras"/status items are a different component; never apply this page to Mac.)
**Change log:** none published — but the body now prescribes `ScrollEdgeEffectStyle` (SwiftUI) and `UIScrollEdgeEffect` (UIKit), iOS 26 APIs, so the page was silently rewritten for Liquid Glass. Resources still list `UIStatusBarStyle` / `preferredStatusBarStyle`.

**Purpose.** The system strip along the screen's upper edge showing device state: time, cellular carrier, battery. Your app controls only its backdrop and visibility.

**Normative rules.** (The whole page is three rules.)
- **Obscure content under the status bar.** Its background is transparent by default; content showing through hurts readability and — worse — visible controls behind it look tappable but aren't. **Prefer a scroll edge effect** (blurred view) behind the status bar (`ScrollEdgeEffectStyle`, `UIScrollEdgeEffect`). Never imply content behind it is interactive.
- **Consider temporarily hiding it for full-screen media** (Photos hides it, with other chrome, during full-screen browsing) for immersion.
- **Avoid permanently hiding it.** Without it people must leave your app to check the time or Wi-Fi. Restore via a simple, discoverable gesture — Photos uses a single tap.

**iOS vs macOS.** iOS-only component. The closest macOS analogue (menu bar) is covered under menus/menu-bar notes; there is zero shared guidance.

**Reviewer checks.**
- Buttons/controls scrolling visibly beneath a transparent status bar → violation (unreachable-looking interactivity).
- Opaque painted rectangle or custom gradient/blur hack behind the status bar instead of a scroll edge effect → flag (Liquid Glass-era correction).
- Status bar hidden for the app's entire lifetime → violation.
- Full-screen photo/video playback with status bar still visible → flag (consider hiding).
- Hidden status bar with no single-gesture way back → violation.

**Stale-knowledge corrections.** Pre-2025 versions of this page focused on choosing a light/dark status-bar *style* to coordinate with content and on hiding rationale; the current page replaces the styling discussion with one Liquid Glass directive — **blur via scroll edge effect, don't restyle or underpaint**. Old advice to place a solid background bar or to match status bar color to a navigation bar color is obsolete: in iOS 26 content scrolls edge-to-edge and the scroll edge effect supplies legibility. `preferredStatusBarStyle` still exists for content-color control but the HIG no longer leads with it.

---

## App Shortcuts

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/app-shortcuts
**Platforms:** iOS, iPadOS, visionOS, watchOS. **Not supported in tvOS.** **macOS: App Shortcuts are NOT supported** — but App Intents actions do work in the Mac Shortcuts app for user-built custom shortcuts.
**Change log:** **June 8, 2026 — "Added guidance for adopting app schemas"** (this week, WWDC26). January 17, 2025 — updated and streamlined. June 5, 2023 — new page.
**Frameworks:** App Intents (`AppShortcutPhrase`, `SiriTipUIView`, `init(full:supporting:systemImageName:)`; responses via snippets and `LiveActivityIntent`).

**Purpose.** An App Shortcut exposes key app functions/content throughout the system: **Siri, Spotlight, the Shortcuts app, the Action button (iPhone/Apple Watch), Apple Pencil squeeze**. Zero-setup: available the moment installation finishes (journaling app's "new entry" works before first launch). Each App Shortcut bundles one or more App Intents actions (home-security example: lights off + doors locked = one "good night" shortcut). **Hard cap: 10 App Shortcuts per app.** Distinct from user-built custom shortcuts, which people compose themselves in the Shortcuts app from your App Intents actions.

**NEW 2026-06-08 — app schemas decision rule.** "To surface common types of app functionality throughout the system, **consider adopting app schemas instead**." Apps in common domain areas adopt **App schema domains** (App Intents) to make actions and content available to **Apple Intelligence**; on supported devices Siri and other system experiences then surface app features contextually **without individual App Shortcuts**. App Shortcuts remain the tool for **unique features or custom content in areas not covered by app schemas**. Reviewer framing: if the action is a commodity domain operation (the kind schemas cover), schema adoption beats hand-rolling an App Shortcut; App Shortcuts are for the long tail. (Dev docs: "App schema domains", "Apple Intelligence and Siri AI", "Making actions and content discoverable by Apple Intelligence".)

**Normative rules.**
- Offer App Shortcuts for the app's **most common and important tasks**; best when completable without leaving the current context, though opening the app is fine for multistep tasks.
- **At most one optional parameter** per App Shortcut — "Start [morning, daily, sleep] meditation". Option values must be **predictable and familiar** (no list is visible when speaking).
- **Ask for clarification** when the parameter is missing ("Start meditation" → suggest the most recent or time-appropriate type; offer a likely default plus a short list of alternatives).
- **Keep voice phrases simple** — if it sounds complicated aloud, it's too hard to remember/say. Two-parameter phrases ("Start [sleep] meditation with [nature sounds]") are explicitly the anti-pattern; gather extra info in a follow-up step.
- **Make them discoverable in-app**: occasional tips when people perform the corresponding action (`SiriTipUIView`).
- **Responses:** snippets for static information or dialog options (weather, order confirmation); **Live Activities** for info that stays relevant and changes over time (timers, countdowns shown until the event completes).
- **Audio-only devices** (AirPods, HomePod): people may hear but not see — put **all critical information in the full dialogue text**.

**Editorial guidelines (Apple's own heading).**
- Activation phrase **must include the app name**, kept brief; natural variants allowed and encouraged — Keynote accepts "Create a Keynote" and "Add a new presentation in Keynote". Creative app-name usage is fine.
- Terminology: **"App Shortcuts" and the "Shortcuts" app are title case, Shortcuts always plural.** Individual user-built shortcuts are lowercase "shortcut" ("Run a shortcut by asking Siri").

**iOS/iPadOS specifics.** App Shortcuts surface in **Spotlight**: the Top Hit area when people search for the app, or the Shortcuts area below it. Each carries an **SF Symbol** representing its function or a **preview image** of the directly linked item. **Order by importance** — your order sets initial presentation in Spotlight and the Shortcuts app; the system then re-prioritizes by individual usage.

**iOS vs macOS.** macOS is the explicit outlier: no App Shortcuts surface exists on Mac. Ship App Intents actions anyway — Mac users get them via the Shortcuts app. A Mac design review should reject any "App Shortcut in Spotlight" mock; an iOS review should expect symbol + phrase + ordering decisions.

**Reviewer checks.**
- Phrase without the app name → violation.
- Phrase encoding two+ parameters → violation (split or follow up).
- More than 10 App Shortcuts defined → violation.
- "App shortcuts"/"shortcuts app" lowercase, or "Shortcut" app singular → editorial violations.
- Parameterized shortcut with no default/clarification flow → flag.
- Critical info only in the snippet visual, absent from full dialogue → audio-device violation.
- Commodity-domain action implemented as an App Shortcut where an app schema domain exists (2026+) → flag for schema adoption.
- No in-app discoverability tip for a flagship shortcut → flag.
- Default ordering not importance-ranked (most generally useful first) → flag.

**Stale-knowledge corrections.** Pre-2022/2023 mental models — SiriKit custom intents, user-recorded "Add to Siri" phrases, shortcut donation — are obsolete: App Shortcuts are **developer-defined, zero-setup, app-name-mandatory phrases** on App Intents. The 2026 app-schemas layer is brand new: pre-WWDC26 knowledge (including 2024-era "Assistant Schemas") doesn't know the "app schema domains" framing or the "schemas first, App Shortcuts for the rest" decision rule. Apple Pencil squeeze and Apple Watch Action button as invocation surfaces are also post-2023 additions. macOS still has no App Shortcuts in 2026 — models often wrongly assume parity.

---

## Snippets (NEW page, WWDC26)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/snippets
**Platforms:** iOS, iPadOS, macOS. Not supported in tvOS, visionOS, or watchOS.
**Change log:** **June 8, 2026 — New page.**
**Frameworks:** App Intents (`ConfirmationActionName`; dev article "Displaying static and interactive snippets").

**Purpose.** Compact views shown in response to an action taken through **Siri, Spotlight, or the Shortcuts app** — the visual result/confirmation layer of an app intent (check the weather, update progress toward a goal, confirm an order). Presented by including a snippet with an App Intent.

**Two types.**
- **Confirmation snippet** — lets people confirm or cancel an action; may include options that affect the result.
- **Result snippet** — presents information (possibly the outcome of a confirmation); no further action required.
- Rule: an app intent that displays a snippet **always shows a result; the confirmation step is optional**.

**Anatomy (three elements).**
1. **Dialogue** — the app intent dialogue Siri speaks. The system includes the dialogue text by default, placed **above the custom view**.
2. **Custom view** — visually communicates the snippet's information; **may contain buttons** that modify the snippet's content, get more information, or take another action (this is the "interactive snippet" capability).
3. **System-provided buttons** — confirmation snippet: a secondary **Cancel** plus a **primary button with a customizable label**, under the custom view. Result snippet: a single **Done** button that dismisses.

**Normative rules.**
- **Ensure legibility:** sufficient contrast between custom content and the **system-provided background in both light and dark appearances**; keep consistent margins within the view.
- **Keep content concise; custom views no taller than the 400-point maximum height.** Account for Dynamic Type — fonts draw at various sizes per the person's preferred text size. Need more detail in a result? **Deep-link into the app** instead of growing the view.
- **Primary button label (confirmation):** pick a descriptive verb from the `ConfirmationActionName` set or supply a custom one — "Order" beats "OK"/"Proceed". **System default if unspecified: "Continue".**
- **Communicate purpose visually; prefer omitting the dialogue text from the visual representation.** Spoken dialogue is essential off-screen; on screen, the custom view should carry the information without duplicating the sentence.

**iOS vs macOS.** Supported on both with no platform deltas declared ("No additional considerations for iOS, iPadOS, or macOS"). The same 400pt/contrast/labeling rules apply to Spotlight- and Siri-invoked snippets on the Mac.

**Reviewer checks.**
- Custom view exceeding 400pt height → violation.
- Confirmation primary button labelled OK/Proceed/Continue-by-laziness when a specific verb exists → flag.
- Dialogue sentence rendered inside the custom view (duplicating the system-placed dialogue) → flag.
- Custom Cancel/Done/confirm buttons inside the custom view duplicating the system-provided ones → violation.
- Contrast not checked against the system background in dark appearance; hardcoded light-mode colors → violation.
- Fixed-height layouts that clip at larger Dynamic Type sizes → flag.
- Result snippet stuffed with secondary detail instead of deep-linking → flag.

**Stale-knowledge corrections.** This page did not exist before 2026-06-08 — pre-WWDC26 models have no HIG "Snippets" component and will misread the term as code snippets or SiriKit's old custom-intent UI (Intents UI extensions), which is the deprecated ancestor. Interactive snippets (buttons inside the view) arrived with the iOS 26 App Intents wave; the HIG formalized the design rules at WWDC26. Snippets are a first-class macOS component too. The numeric spec to remember: **400pt max height**; the structural spec: dialogue above, custom view middle, system buttons below (Cancel + custom-label primary, or lone Done).

---

## Cross-page observations for skill design

- **System renders, app supplies**: all five pages forbid recreating system chrome (fake badges, fake status-bar backgrounds, duplicate Done/Cancel buttons, faked communication avatars). A reviewer skill can generalize: "in system experiences, never draw what the system draws."
- **Lock-state security triad** (controls page): redact when locked, authenticate security actions, capture-only camera while locked. Unique to controls; high-severity checks.
- **Voice/audio parity** (app-shortcuts + snippets): critical info must exist in spoken dialogue, and visual snippets shouldn't duplicate the dialogue. These two pages are designed as a pair — App Shortcuts respond *with* snippets or Live Activities.
- **Numeric specs in this bucket**: 10 App Shortcuts max; 1 optional parameter per shortcut; 4 notification action buttons max; 3 notification anatomy styles; 400pt snippet max height; 2 control symbol states for toggles. Everything else is structural/editorial.
- **Currency hotspots**: app schemas (2026-06-08) and snippets (2026-06-08) are the two WWDC26 deltas; status-bars carries an unlogged Liquid Glass rewrite (scroll edge effect); controls carries an unlogged macOS expansion.
