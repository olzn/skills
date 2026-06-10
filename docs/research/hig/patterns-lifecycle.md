# HIG research notes — Patterns: app lifecycle (patterns-lifecycle)

Bucket: launching, onboarding, loading, managing-accounts, offering-help, ratings-and-reviews, settings, multitasking, going-full-screen, printing.
Source: Apple JSON content API (`https://developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`), fetched 2026-06-10.
Currency snapshot: none of these 10 pages changed at WWDC26 (2026-06-08). Most recent alerts: `multitasking`, `going-full-screen`, `loading` = 2025-06-09 (Liquid Glass / iPadOS 26 wave); `launching`, `onboarding`, `settings` = 2024-06-10; `offering-help` = 2023-12-05; `ratings-and-reviews` = 2023-09-12; `managing-accounts`, `printing` = no alert. This bucket is mostly flow/behaviour guidance, largely stable across the Liquid Glass rewrite — the two exceptions (multitasking, going full screen) changed because of iPadOS 26 windowing, not visual style.

---

## Launching

URL: https://developer.apple.com/design/human-interface-guidelines/launching
Platforms: all. Alert 2024-06-10 ("Added guidance on displaying a splash screen").

**Purpose.** Governs the window from app open → first screen ready: launch speed, launch screens, splash screens, state restoration. Apple defines launching precisely: "begins when someone opens your app or game, includes an initial download, and ends when the first screen is ready." Onboarding comes *after* launching — it is not part of the launch experience.

**Apple's three distinct concepts (do not conflate):**
- **Launch screen** — system-displayed static placeholder shown the instant the app starts, replaced quickly by the first screen. Required on iOS/iPadOS/tvOS; **not used on macOS** (nor visionOS/watchOS). Purely perceptual: makes launch feel instant.
- **Splash screen** — an optional branded graphic. If used, show it *at the beginning of the onboarding flow*; if there's no onboarding, show it as soon as launching completes. Display "just long enough for people to absorb the information at a glance" — never feel like it's delaying the experience.
- **First screen** — actual UI.

**Normative rules.**
- "Launch instantly" — people "don't want to wait more than a couple of seconds."
- Launch screen must be **nearly identical to the first screen** — same solid colour if the first frame is a solid colour; must match the device's **current orientation and appearance mode** (light/dark).
- **No text on the launch screen** (it can't be localized), even if the first screen shows text.
- **Don't advertise** on the launch screen: no logos, no splash-screen look, no "About"-window look, unless the branding element is a fixed part of the first screen.
- **Restore previous state** on restart: granular — scroll position to most recent location, windows in the same state and location people left them.
- iOS/iPadOS: launch in the device's current orientation if both are supported; if single-orientation, launch in that orientation and let people rotate. Landscape-only must work for both left and right rotations.

**iOS vs macOS.** iOS: launch screen required, orientation rules apply. macOS: no launch screen at all ("macOS, visionOS, and watchOS don't require launch screens"); state restoration (window positions/states) carries the launch-quality burden instead.

**Reviewer checks.**
- iOS prototype has a launch-screen frame? It must be a stripped clone of the first screen: no text layers, no logo (unless persistent in first screen UI), no marketing art, both light and dark variants if app supports both.
- Flag any "splash screen" frame positioned between launch and first screen *outside* an onboarding flow.
- macOS prototype showing a launch/splash screen → flag (not a macOS pattern).
- Flow diagrams: cold-start path must land users where they left off (saved scroll position, reopened windows), not at a root screen.

**Stale-knowledge corrections.**
- 2024 guidance *added* the splash-screen concept with rules; older HIG flatly discouraged splash screens with no sanctioned placement. Now sanctioned but only at onboarding start.
- Models may remember `LaunchScreen.storyboard`; current developer path is the Xcode launch-screen Info.plist configuration, but the design rule (clone of first screen) is unchanged.
- Page predates Liquid Glass alerts but the "first screen" now typically has Liquid Glass chrome — a launch screen mimicking pre-26 opaque bars will flash visibly against a floating-toolbar first screen.

---

## Onboarding

URL: https://developer.apple.com/design/human-interface-guidelines/onboarding
Platforms: all. Alert 2024-06-10 ("Clarified different approaches to onboarding and added a guideline on displaying a splash screen").

**Purpose.** Governs first-run education. Framing rule: "Ideally, people can understand your app or game simply by experiencing it, but if onboarding is necessary, design a flow that's **fast, fun, and optional**." Occurs strictly after launching completes.

**Normative rules.**
- **Teach through interactivity** — let people safely perform the task, not view instructional material.
- **Prefer context-specific tips over a single onboarding flow** (TipKit). Display instructions *near* the UI area they refer to.
- Prerequisite onboarding flows: brief, enjoyable, no memorization load.
- Separate tutorial: make it **optional/skippable**; never re-present on subsequent launches; keep it findable later (help, account, or settings area).
- Onboarding teaches *your app only* — never how to use the system or device.
- Splash screen (if any): brief, glanceable, at flow start (see Launching).
- **Don't let large downloads hinder onboarding** — bundle enough content that people can start immediately.
- **No licensing/legal in onboarding** — let the App Store display agreements; if unavoidable, integrate without disrupting flow.
- **Postpone nonessential setup/customization**; ship sensible defaults.
- Permission requests: integrate into onboarding *only if the app can't function without the data*, and use the moment to show why + benefits; otherwise request at first use of the dependent feature (cross-ref Privacy → Requesting permission).
- **No ratings or purchase prompts during onboarding** — wait for engagement.

**iOS vs macOS.** None — page explicitly says "No additional considerations" for any platform. Identical guidance both platforms.

**Reviewer checks.**
- Count onboarding screens; flag long passive carousels (walls of swipe-through cards) — Apple prefers interactive teaching or contextual tips.
- Skip affordance present on tutorial entry? Re-shown-on-every-launch flows → violation.
- Permission dialogs (notifications, location, tracking) inside onboarding → flag unless core-functionality justification is shown on screen first.
- Ratings prompt, paywall, or T&C/EULA screens inside onboarding → flag.
- Onboarding copy explaining system gestures ("swipe up to go home") → flag.
- "Sign in to continue" as first onboarding screen → cross-check Managing accounts (delay sign-in).

**Stale-knowledge corrections.**
- Since 2023-09 the HIG's preferred onboarding instrument is **TipKit contextual tips**, not multi-page intro carousels; older model priors over-index on welcome-slideshow patterns.
- Splash screen at onboarding start is now explicitly sanctioned (2024-06-10) — older guidance read as a blanket prohibition.

---

## Loading

URL: https://developer.apple.com/design/human-interface-guidelines/loading
Platforms: all. Alert 2025-06-09 ("Revised guidance for storing downloads to reflect downloading large assets in the background").

**Purpose.** Governs content/asset loading behaviour. Thesis: "The best content-loading experience finishes before people become aware of it."

**Normative rules.**
- **Show something as soon as possible** — placeholder text, graphics, or animations while content loads; replace as content arrives. Blank screen = perceived breakage.
- **Let people do other things while content loads** (background loading; e.g., game loads next level while player views a menu).
- Unavoidably long loads: give people something interesting (gameplay hints, tips, feature intros). **Gauge remaining time accurately** so placeholder content is neither cut off nor repeated.
- **Download large assets in the background** (Background Assets framework): schedule downloads immediately after installation, during updates, or other nondisruptive times — improves install and launch time.
- Progress communication: loading taking "more than a moment or two" needs a progress indicator. **Determinate** when duration is known, **indeterminate** when not (exact Apple terms; cross-ref Progress indicators component page).
- Games may use custom loading views matching their style instead of standard indicators.

**iOS vs macOS.** None — "No additional considerations for iOS, iPadOS, macOS, tvOS, or visionOS." (watchOS-only note: avoid loading indicators entirely; irrelevant here but shows the spectrum.)

**Reviewer checks.**
- Any screen state that is blank-while-loading → flag; require skeleton/placeholder state in the design.
- Loading state present but blocking (modal spinner over whole UI) where background loading is plausible → flag.
- Spinner used where duration is knowable (file size, byte counts) → should be a determinate progress bar; progress bar with fake/unknown progress → should be indeterminate.
- Prototypes: check a designed loading state exists at all for every data-driven screen (designers commonly omit it).

**Stale-knowledge corrections.**
- 2025-06-09 revision: the old "store downloads where you can resume them" framing was replaced by **Background Assets** scheduled background downloads (post-install/update). Models may suggest in-app blocking downloads at first run; current guidance says front-load via Background Assets.

---

## Managing accounts

URL: https://developer.apple.com/design/human-interface-guidelines/managing-accounts
Platforms: all. No alert (stable page).

**Purpose.** Governs sign-up, sign-in, authentication terminology, and (App Store-mandated) account deletion.

**Normative rules — sign-in.**
- Require an account **only if core functionality requires it**; otherwise fully usable without one.
- **Delay sign-in as long as possible** — e.g., a shopping app lets people browse freely, requiring sign-in only at purchase. Forced sign-in before anything useful → abandonment.
- Sign-in view must **explain the benefits** of the account requirement, briefly and friendly.
- If not using **Sign in with Apple** on iOS/iPadOS/macOS/visionOS, **prefer a passkey**. Passwords only as fallback, then require two-factor authentication.
- **Name the authentication method in the control**: "Sign In with Face ID", never generic "Sign In" when a specific method is invoked.
- Reference only methods available on the current device (no Face ID copy on Touch ID Macs; check `LABiometryType`).
- **No in-app setting for opting into biometric auth** — that's a system-level choice; in-app duplication is redundant/confusing.
- **Never use the term "passcode"** for app account auth — passcode means device unlock / Apple services in user vocabulary.

**Normative rules — account deletion (compliance-grade).**
- If people can create an account in-app, you **must** let them **delete** it (not just deactivate) — in-app, or via a direct, easy-to-discover link to the deletion webpage (not buried in Privacy Policy / ToS).
- Deletion flow parity: in-app and web flows equally simple.
- Scheduled future deletion allowed (e.g., after subscription period) but must be offered **alongside immediate deletion**.
- Tell people when deletion will complete; **notify when finished**.
- With in-app purchases: explain that **auto-renewable subscription billing continues through Apple until cancelled, regardless of account deletion**; user must cancel separately or request a refund; provide cancellation/management help. Deletion support is required even if the subscription wasn't purchased in your app.
- Legal-retention carve-out (e.g., digital health records): clearly describe what must be retained and the required process.
- Sign in with Apple accounts: revoke tokens on deletion (REST API "Revoke tokens").

**iOS vs macOS.** None — "No additional considerations for iOS, iPadOS, macOS, or visionOS." (tvOS/watchOS sections exist; out of scope.)

**Reviewer checks.**
- First-run flow forces account creation before any value → flag unless core functionality genuinely requires it.
- Sign-in screen present? Must contain benefit copy; check button labels name the method ("Continue with Face ID", "Sign in with Apple") — generic labels with biometric icons → flag.
- Word "passcode" anywhere in account/auth copy → flag.
- Settings/account area: account deletion entry point exists and is discoverable; "Deactivate" without "Delete" → violation.
- In-app biometric opt-in toggle in settings → flag.
- If Sign in with Apple is absent but email/password is offered: passkey option present? 2FA mentioned?

**Stale-knowledge corrections.**
- **Passkey-first** is current doctrine for non-SIWA auth; older models default to email+password forms.
- Account deletion is an enforced App Store requirement (since 2022) with detailed HIG rules — older priors treat it as optional good practice.

---

## Offering help

URL: https://developer.apple.com/design/human-interface-guidelines/offering-help
Platforms: all. Alert 2023-12-05 ("Included visionOS in guidance for creating tooltips").

**Purpose.** Governs contextual help: inline help views, tutorials, **tips** (TipKit, transient feature-education views) and **tooltips** (macOS pointer-hover descriptions, "help tags" in user documentation).

**Normative rules — general.**
- Match help type to task complexity: inline view for 1–2-step tasks; tutorial for complex/multistep goals. Relate help to "the precise action or task people are doing right now"; easy to dismiss/avoid.
- Platform-correct language and imagery: never "click" on iPhone, never "tap" on Mac; no game-controller imagery for Siri Remote users; help content must be inclusive (cross-ref Inclusion).
- **Don't explain standard components or patterns** — describe only what the element does in *your* app. Unique controls/nonstandard input: orient quickly, **prefer animation or graphics over lengthy description**.

**Normative rules — tips (TipKit; iOS-centric but cross-platform).**
- Tip = "small, transient view that briefly describes how to use a feature."
- Four sanctioned forms: **popover tip** (preserves content flow), **inline tip** (keeps surrounding info visible), **annotation-style inline tip** (points at a specific UI element), **hint-style tip** (not tied to specific UI).
- Feature requiring **more than three actions is too complicated for a tip**.
- Length: **one or two sentences**; direct, action-oriented; **no promotional content** (anything that advertises, sells, or is off-context).
- Eligibility rules (parameter-/event-based) so tips reach only people who'd benefit; multi-tip apps set display frequency at a reasonable cadence — Apple's example: **once every 24 hours**.
- Tip iconography: include the associated symbol, **prefer the filled variant**; don't repeat the same image in both the tip and the UI element it points at.
- Tips may carry **buttons** linking to settings or learn-more/setup flows.

**Normative rules — tooltips (macOS + visionOS only).**
- Trigger: pointer hover (macOS, incl. iPhone/iPad apps on Mac); look-at or hover (visionOS).
- Describe **only** the control indicated — not nearby controls, not larger tasks.
- Explain the action/task, often starting with a verb ("Restore default settings", "Add or remove a language from the list").
- **Don't repeat the control's name** in its tooltip.
- Length cap: **60–75 characters max** (localization expands text). Sentence fragments OK; articles omitted.
- **Sentence case**; omit ending punctuation for complete sentences (unless app style requires it).
- Context-sensitive tooltips encouraged (different text per control state).
- If a control needs a long tooltip, the interface is probably too complex — simplify instead.

**iOS vs macOS.** Sharp divergence: tips (TipKit) are the cross-platform mechanism; **tooltips exist only on macOS/visionOS** (no hover on iPhone). iOS help = tips + inline views; macOS adds hover tooltips and the menu-bar **Help menu** (cross-ref the-menu-bar#Help-menu).

**Reviewer checks.**
- Help copy audit: "click" in iOS copy / "tap" in macOS copy → flag. (High-yield automated text check.)
- Tip mock: >2 sentences, promotional phrasing, unfilled symbol variant, or describing a >3-step feature → flag.
- macOS prototype: interactive toolbar/controls without tooltip annotations → note; tooltip text >75 chars, Title Case, repeats control name, or ends with period → flag.
- Tooltips designed for iOS screens (hover-dependent help) → flag.
- Help content explaining standard system components → flag.

**Stale-knowledge corrections.**
- **TipKit** (2023) and its four tip types + frequency/eligibility rules postdate many priors; old answer "make a help section / coach marks" is superseded by structured tips.
- Apple's user-facing term for tooltip is "help tag" in documentation; HIG uses "tooltip" — use Apple terms precisely.

---

## Ratings and reviews

URL: https://developer.apple.com/design/human-interface-guidelines/ratings-and-reviews
Platforms: all. Alert 2023-09-12 (artwork only — content stable).

**Purpose.** Governs when/how to request App Store ratings & reviews in-app.

**Normative rules.**
- Ask only **after demonstrated engagement** (completed level / significant task). **Never on first launch or during onboarding.** Premature asks invite negative reviews.
- **Don't interrupt tasks or gameplay** — ask at natural breaks/stopping points.
- Don't pester: **allow at least a week or two between requests**, and only after additional engagement.
- **Prefer the system-provided prompt** (`RequestReviewAction`, StoreKit): consistent, nonintrusive; one tap/click to rate or dismiss; user can opt out globally. The system **limits display to 3 occurrences per app per 365-day period** and suppresses if feedback was already given.
- Resetting the summary rating on a new version: weigh "reflects current version" against fewer total ratings (which discourages downloads).
- People can always rate in the App Store regardless of prompts.

**iOS vs macOS.** None — explicit "No additional considerations" for all platforms. The system prompt exists on iOS, iPadOS, and macOS alike.

**Reviewer checks.**
- Any custom-designed rating dialog (custom stars UI asking for App Store rating) → flag: use the system prompt.
- Rating prompt placed in onboarding/first-launch flow → violation.
- "Rate us" gating patterns (e.g., prompt before allowing continue) or pre-prompt filters ("Enjoying the app? → yes → store / no → feedback form") → flag as interruption/pestering risk; system prompt should be triggered without custom pre-screens.
- Flow logic (if visible): trigger tied to engagement milestone, not timer-on-launch.

**Stale-knowledge corrections.**
- Numeric guardrails worth pinning: **3 prompts / 365 days**, **≥1–2 weeks between requests** — models often omit or misstate these.
- API is `RequestReviewAction` (SwiftUI environment) — older priors say `SKStoreReviewController.requestReview()`.

---

## Settings

URL: https://developer.apple.com/design/human-interface-guidelines/settings
Platforms: all. Alert 2024-06-10 ("Reorganized some guidance into new topics and added game-specific examples").

**Purpose.** Governs where settings live (in-task options vs in-app settings area vs system Settings app) and what belongs in each tier.

**Three-tier placement model (exact framing):**
1. **Task-specific options** — adjust in place, in the screens they affect (show/hide parts of a view, reorder a collection, filter a list). Moving them to a settings area "disconnects [them] from context."
2. **General settings** (custom in-app settings area) — general, **infrequently changed** options: window configuration, game-saving behaviour, keyboard mappings, account-related options.
3. **System-provided Settings app** — only the **most rarely changed** options; if you add some, consider a button in your UI that deep-links there.

**Normative rules.**
- **Default settings should give the best experience to the most people** — e.g., auto-detect device performance rather than asking; people ideally adjust nothing before enjoying the app.
- **Minimize the number of settings** — too many makes the app less approachable and individual settings hard to find.
- Expected access paths: **Command-Comma (,)** opens settings when a hardware keyboard is connected (any platform); games: **Esc** key.
- **Don't ask for setup info you can detect** (connected controllers, Dark Mode state).
- **Never duplicate systemwide settings** (accessibility accommodations, scrolling behaviour, authentication methods) in your own settings — implies system settings may not apply and confuses scope.

**macOS-specific (custom settings window — detailed spec):**
- Opened via App menu → Settings (item is **required in the App menu**; document-level options go in the **File menu** instead). Never put a settings button in the window toolbar (wastes space for frequent commands).
- Settings window structure: toolbar with buttons switching between **panes** (Apple's term) of related settings.
- **Dim (disable) the minimize and maximize buttons** of the settings window.
- Toolbar in settings window: **noncustomizable**, always visible, always indicates the active pane button.
- **Window title = currently visible pane name**; single-pane windows: "App Name Settings".
- **Restore the most recently viewed pane** on reopen.

**iOS vs macOS.** iOS: in-app settings screen (usually a grouped list reachable from a tab/profile) + optional Settings-app bundle (Settings.bundle) for rarely changed options. macOS: dedicated settings *window* with pane toolbar, App-menu item, ⌘, shortcut, dimmed min/max buttons. The structural spec exists only for macOS.

**Reviewer checks.**
- Settings screen audit: any toggle duplicating a system setting (e.g., in-app "reduce motion", in-app Face ID opt-in, custom text-size slider that shadows Dynamic Type) → flag.
- Options that affect a single task (sort order, filters, view density) living in a global settings screen → flag, move inline.
- Settings list length sanity check — many screens of options on first release → "minimize settings" note.
- macOS settings window mock: pane toolbar present, fixed, active state shown; title matches pane; min/max controls shown disabled; opened from App menu in flow.
- macOS: settings button in main-window toolbar → flag.

**Stale-knowledge corrections.**
- **"Settings", not "Preferences"** — macOS renamed System Preferences → System Settings (macOS 13) and app menus now read "Settings…"; the HIG uses Settings everywhere including macOS. Models trained on older material habitually write "Preferences" (the ⌘, shortcut is unchanged).
- "Preference panes"/PreferencePanes framework is legacy; the design term for sections is still **panes**, but the user-facing word is Settings.

---

## Multitasking

URL: https://developer.apple.com/design/human-interface-guidelines/multitasking
Platforms: ios,ipados,macos,tvos,visionos (not watchOS). Alert 2025-06-09 ("Reorganized guidance in platform considerations, and added guidance for multitasking with multiple windows in iPadOS").

**Purpose.** Governs how apps behave when people switch among apps/windows: state saving, pausing, audio interruptions, background task completion, and per-platform multitasking models.

**Normative rules.**
- "Every app needs to work well with multitasking" (rare exceptions: some games; visionOS Full Space apps). Apps that don't allow it feel broken.
- Always be **prepared to save and restore context** — switching can happen at any time.
- **Pause activities requiring attention or active participation** on switch-away (games, media viewing); resume seamlessly on return "as if they never left."
- **Audio interruptions**: pause indefinitely for primary interruptions (music, podcasts, audiobooks); temporarily duck volume or pause for short interruptions (e.g., GPS directions), restoring volume/playback after.
- **Finish user-initiated tasks in the background** (downloads, video processing) — complete before suspending if no further input is needed.
- **Notifications sparingly**: notify on completion of important/time-sensitive user-initiated tasks only; never for routine/secondary completions.

**Platform models (iOS vs iPadOS vs macOS).**
- **iOS (iPhone):** multitasking = app switcher + **Picture in Picture** (video/FaceTime over another app). One app at a time otherwise.
- **iPadOS (iPadOS 26 model — clarifies adaptive behaviour):** apps run **full screen** (switch via app switcher) *or* **windowed** — windows are **resizable**, freely arranged, "behavior similar to macOS." System provides **window controls** for tiling configurations, entering full screen, minimizing, closing. Frontmost window identified by **coloured window controls + drop shadow** on windows behind. Apps also support **multiple open windows of the same app**. PiP floats above everything. Key constraint: **"Apps don't control multitasking configurations or receive any indication of the ones that people choose"** — so layouts must adapt gracefully to arbitrary sizes (cross-ref Layout, Windows).
- **macOS:** multitasking **is the default**; multiple apps and windows always. System applies drop shadows/visual effects to layer windows and distinguish window states (cross-ref Windows → macOS window states).

**Reviewer checks.**
- iPad designs: do layouts specify behaviour at arbitrary window sizes (not just the old 1/3–1/2–2/3 Split View snap widths)? Fixed-canvas iPad mocks with no resize story → flag.
- Media/game designs: pause-on-background state designed? Resume state?
- Designs that hide or restyle system window controls (iPadOS windowed / macOS traffic lights) → flag.
- Notification triggers in flows: completion notifications only for significant user-initiated tasks.
- Audio apps: behaviour spec for interruption (duck vs pause) present?

**Stale-knowledge corrections (biggest in this bucket).**
- **Split View, Slide Over, and Stage Manager terminology is gone from this page.** The 2025-06-09 rewrite (iPadOS 26) describes free-form, resizable windows with macOS-like window controls and system tiling. Models will still propose "support Slide Over width" or "Stage Manager stages" — current guidance is: design for continuously resizable windows; the system, not the app, owns configuration.
- iPad windows now show **macOS-style window controls (coloured when frontmost) and drop shadows** — pre-2025 priors have no such concept on iPad.

---

## Going full screen

URL: https://developer.apple.com/design/human-interface-guidelines/going-full-screen
Platforms: ios,ipados,macos only. Alert 2025-06-09 ("Updated guidance for hiding toolbars and navigation controls, and deferring Home Screen indicator gestures in full-screen iOS and iPadOS apps and games").

**Purpose.** Governs full-screen modes that expand a window to fill the screen, hide system controls, and create a distraction-free environment. Explicitly an iPhone/iPad/Mac-only pattern (tvOS/watchOS are full screen by default; visionOS uses immersion instead).

**Normative rules.**
- Offer full screen when it fits: games, media viewing (video, slideshows), in-depth tasks benefiting from no distractions.
- In full screen, **adjust layout proportions but don't programmatically resize the window**; keep changes subtle, no jarring transitions between modes; keep essential content prominent.
- **Keep essential features/controls accessible** inside full screen (e.g., media playback controls persistently available or easy to reveal).
- **Except in games, let people reveal the Dock** in full-screen iPadOS/macOS. Games may defer the first bottom-edge swipe (iPadOS) or hide the Dock (macOS `hideDock`).
- **Resume where people left off** after switching away (games/slideshows auto-pause).
- **People choose when to exit** — never auto-exit full screen when an activity finishes or focus changes.
- **Temporarily hiding toolbars and navigation controls** to prioritize content is sanctioned (full-screen photos, document reading) — but restoration must use a familiar gesture/action: **tap, swipe down, or moving the cursor to the top of the screen**; keep controls visible when essential for navigation/tasks.

**iOS/iPadOS-specific.**
- **Home Screen indicator**: auto-hides shortly after entering the app; reappears on bottom-screen interaction; one swipe exits. **Retain default behaviour whenever possible**; if accidental exits occur, defer system gestures so exit requires **two swipes instead of one** (`preferredScreenEdgesDeferringSystemGestures`).

**macOS-specific.**
- **Use the system-provided full-screen experience** (`toggleFullScreen(_:)`) — it automatically accommodates hardware like the **camera housing** (notch) on some Macs.
- Entry affordances: the window's **Enter Full Screen button** (green traffic light), **View menu item**, or **Control-Command-F**. **Avoid a custom menu of window modes**; games may add a settings toggle for full screen.
- Games: **don't change the display mode** when going full screen (no performance benefit; users own their display mode).

**iOS vs macOS side by side.** iOS/iPad: full screen is about hiding chrome + managing the Home-indicator edge gesture; no window concept on iPhone. macOS: full screen is a window state with standard entry points (green button / View menu / ⌃⌘F) and system-managed safe areas (camera housing); Dock access must survive except in games.

**Reviewer checks.**
- Full-screen media/reading designs: is there a designed "controls revealed" state and a documented restore gesture (tap/swipe-down/cursor-to-top)?
- macOS mock with custom full-screen toggle UI replacing the green button / ⌃⌘F → flag (custom window-mode menus disallowed; game toggle is the exception).
- macOS full-screen art ignoring camera-housing safe area (content at top-centre edge) → flag.
- iPhone full-screen designs placing critical touch targets in the Home-indicator region → flag (conflicts with edge gesture).
- Flows where finishing a video/game auto-returns to windowed mode → flag.

**Stale-knowledge corrections.**
- 2025-06-09 update formalized **hide-toolbars-to-prioritize-content** and the **two-swipe deferral** spec. With Liquid Glass, toolbars/tab bars already float over content and shrink on scroll — full-screen hiding now composes with that system behaviour rather than replacing opaque bars.
- macOS camera-housing (notch) accommodation is part of system full screen — pre-2021 priors don't know it exists.

---

## Printing

URL: https://developer.apple.com/design/human-interface-guidelines/printing
Platforms: ios,ipados,macos,visionos. No alert (stable page).

**Purpose.** Governs integration of system print functionality and custom print options.

**Normative rules.**
- **Make printing discoverable in standard locations**: macOS → **Print item in the File menu** (optionally a Print toolbar button, but make it an *optional customizable* toolbar item); iOS/iPadOS → toolbar button opening an **action sheet** containing Print.
- **Present printing only when possible**: nothing printable on screen or no printers → **dim** the macOS File-menu Print item; **remove** the Print action from the iOS action sheet; dim or hide custom print buttons.
- Offer relevant options (page range, copies, double-sided) via the **system-provided view** when the printer supports them.

**macOS-only (print panel & page setup).**
- App-specific print options → **custom category in the print panel**, named uniquely (e.g., your app name), alongside system categories (Layout, Paper Handling, Media & Quality). Example: Keynote's presenter notes / slide backgrounds / skipped slides.
- Document-specific page settings → optional **page setup dialog** (page size, orientation, scaling); don't reimplement system-provided options (orientation, reverse order).
- Make option **interdependencies clear** (double-sided ⟂ transparencies).
- **Separate advanced features** behind a disclosure control, labelled **"Advanced Options"**.
- Consider live **preview** of setting effects (e.g., thumbnail updating with tone control).
- Consider **storing modified print settings with the document** (at minimum until the document closes).

**iOS vs macOS.** iOS: print is a share/action-sheet action, options come from the system print UI; nothing custom beyond that. macOS: full File-menu integration, custom print-panel categories, page setup dialog, advanced-options disclosure — all the depth is macOS-side.

**Reviewer checks.**
- macOS document-app mock: File menu contains Print (⌘P implied); print unavailable states shown dimmed not hidden (menu item) — iOS: unavailable Print removed from the action sheet (not dimmed). Note the asymmetry: dim on macOS menus, remove on iOS action sheets.
- Custom print dialogs replacing the system print panel → flag.
- macOS print panel mock with app options mixed into system categories instead of a named custom category → flag.
- Advanced print options inline rather than behind an "Advanced Options" disclosure → flag.

**Stale-knowledge corrections.** None significant — page is stable and matches long-standing convention. (Only meta-note: iOS print is reached through action sheets / share sheet; models sometimes invent a dedicated print icon location.)

---

## Cross-page synthesis for skill design

- **Canonical lifecycle order Apple enforces:** Launch (instant, no branding) → optional splash (only at onboarding start) → onboarding (optional, interactive, no permissions/ratings/legal unless essential) → delayed sign-in → engagement → ratings prompt (system, 3/365 days). A reviewer can validate an entire first-run flow against this single ordering rule.
- **Numeric/exact specs in this bucket (the complete list):** tooltip 60–75 chars; tip ≤2 sentences; tip-able feature ≤3 actions; tip cadence example 1/24h; ratings ≥1–2 weeks apart, system cap 3/365 days; ⌘, settings shortcut; Esc for game settings; ⌃⌘F full screen; two-swipe Home-indicator deferral; "couple of seconds" launch budget. Everything else is judgment-call/flow guidance.
- **Most-checkable rules are copy rules:** click vs tap, "passcode" ban, auth-method-named buttons, sentence-case no-period tooltips, "Settings" not "Preferences", "Advanced Options" label.
- **State-coverage rules:** every data screen needs a loading/placeholder state; media/games need pause+resume states; full screen needs controls-hidden and controls-revealed states; settings windows need per-pane restoration. Good fit for a "required states" checklist per screen type.
- **iOS vs macOS divergence is concentrated**: launching (launch screen vs none), offering-help (tips vs tooltips+Help menu), settings (screen vs pane-window spec), printing (action sheet vs File menu/print panel), full screen (home indicator vs green button/⌃⌘F). Onboarding, loading, accounts, ratings are platform-identical.
- **Stale-prior hotspots:** iPadOS 26 windowing replacing Split View/Slide Over/Stage Manager; "Settings" naming; TipKit over carousels; passkey-first auth; Background Assets; `RequestReviewAction`.
