<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: launching, onboarding, loading, managing-accounts, offering-help, ratings-and-reviews, settings, multitasking, going-full-screen, printing -->

First-run order: launch (instant, unbranded) → splash (only at onboarding start) → onboarding (optional, interactive; no permissions/ratings/legal) → delayed sign-in → engagement → system ratings prompt. <!-- src: launching, onboarding, managing-accounts, ratings-and-reviews -->

## launching
<!-- src: launching · changed: 2024-06-10 · platforms: all · speed: stub -->
- Launch screen (required iOS/iPadOS; none on macOS): a stripped clone of the first screen — same solid colour, match current orientation and appearance mode. No text (can't be localised); no logos/marketing art unless fixed in the first screen.
- Splash screen: glance-brief, never delaying. Was: flatly discouraged → Now: sanctioned, but only at onboarding start — or right after launch if no onboarding (since 2024-06-10).
- Restore previous state on relaunch — scroll position, window states/positions — not a root screen. On macOS, restoration carries the launch-quality burden.
- Budget: people "don't want to wait more than a couple of seconds".
- Trap: a launch screen mimicking pre-26 opaque bars flashes against a Liquid Glass first screen.
- Fetch for detail: launching

## onboarding
<!-- src: onboarding · changed: 2024-06-10 · platforms: all · speed: stub -->
- Fast, fun, optional. Teach through interactivity; prefer context-specific tips (TipKit) near the relevant UI over one intro flow. Was: welcome carousels → Now: contextual tips preferred (since 2023-09-12).
- Tutorials: skippable, never re-shown, findable later (help/settings).
- Banned in onboarding: ratings/purchase prompts, licensing/legal (the App Store displays agreements), system-gesture lessons, permission requests — unless the app can't function without the data; then show the benefit first.
- Postpone nonessential setup; ship sensible defaults; never let large downloads block the start. No iOS/macOS deltas.
- Fetch for detail: onboarding

## loading
<!-- src: loading · changed: 2025-06-09 · platforms: all · speed: stub -->
- Show something immediately — placeholder/skeleton, never a blank screen; let people do other things while content loads.
- Beyond "a moment or two" → progress indicator: determinate when duration is known, indeterminate when not. Long loads: hints/tips; gauge remaining time accurately.
- Was: resume-friendly in-app downloads at first run → Now: download large assets via Background Assets — after install, during updates, at nondisruptive times (since 2025-06-09).
- Every data-driven screen needs a designed loading state (routinely omitted in mocks). No iOS/macOS deltas.
- Fetch for detail: loading

## managing-accounts
<!-- src: managing-accounts · changed: none (stable) · platforms: all · speed: full -->
**Sign-in.**
- Require an account only when core functionality demands it; otherwise fully usable without one.
- Delay sign-in as long as possible — browse first, sign in at purchase.
- The sign-in view must briefly state the benefits of the requirement.
- Without Sign in with Apple, prefer a passkey; passwords are fallback, then require two-factor authentication.
- Was: email + password default → Now: passkey-first for non-SIWA auth.
- Name the method in the control: "Sign In with Face ID" — never generic "Sign In" for a specific method.
- Reference only methods on the current device (`LABiometryType`); no Face ID copy on Touch ID Macs.
- No in-app toggle for biometric auth — that's a system-level choice.
- Never use "passcode" for app account auth; people reserve it for device unlock and Apple services.
**Account deletion (tier 1 — App Review enforces, since 2022).**
- In-app account creation ⇒ must offer deletion, not mere deactivation — in-app, or a direct, easy-to-discover link (not buried in a privacy policy).
- Web and in-app deletion flows equally simple.
- Scheduled future deletion allowed only alongside immediate deletion.
- Say when deletion completes; notify when it finishes.
- Auto-renewable subscriptions: billing continues through Apple until cancelled, regardless of deletion — say so, help with cancellation/refunds, even if not bought in your app.
- Sign in with Apple accounts: revoke tokens on deletion.
**Deltas.** None.
**Reviewer checks.**
- Forced account before any value without core-functionality need.
- Missing benefit copy; generic button labels with biometric icons.
- "passcode" in account/auth copy.
- "Deactivate" without "Delete"; deletion entry undiscoverable.
- In-app biometric opt-in toggle.
- No SIWA and no passkey / no 2FA beside email+password.

## offering-help
<!-- src: offering-help · changed: 2023-12-05 · platforms: all · speed: full -->
- Match help to task: inline view for 1–2-step tasks, tutorial for multistep goals; easy to dismiss.
- Never explain standard components or system gestures — describe only what the element does in *your* app; for novel controls prefer animation/graphics over prose.
- Platform-correct language: never "click" on iPhone, never "tap" on Mac.
**Tips (TipKit — cross-platform).**
- Four forms: popover, inline, annotation-style inline (points at an element), hint-style (untethered).
- One or two sentences maximum; action-oriented; no promotional content.
- A feature needing more than three actions is too complicated for a tip.
- Eligibility rules target people who'd benefit; cadence example: 1 per 24 hours.
- Include the associated symbol, prefer the filled variant; don't repeat the same image in tip and target element.
- Tips may carry buttons (settings, learn-more).
- Was: coach marks / a help section → Now: structured TipKit tips with frequency and eligibility rules (since 2023).
**Tooltips (macOS + visionOS only — no hover on iPhone).**
- Describe only the indicated control; start with a verb ("Restore default settings"); don't repeat the control's name.
- 60–75 characters maximum (localisation expands text); fragments fine, articles omitted.
- Sentence case; omit the ending full stop on complete sentences.
- A control needing a long tooltip signals an over-complex interface — simplify instead.
**Deltas.** iOS help = tips + inline views. macOS adds hover tooltips and the menu-bar Help menu (see the-menu-bar).
**Reviewer checks.**
- "click" in iOS copy / "tap" in macOS copy.
- Tip over two sentences, promotional, unfilled symbol, or fronting a >3-action feature.
- Tooltip over 75 chars, Title Case, trailing full stop, or repeating the control name.
- Hover-dependent help on iOS screens.

## ratings-and-reviews
<!-- src: ratings-and-reviews · changed: 2023-09-12 · platforms: all · speed: stub -->
- Ask only after demonstrated engagement; never on first launch or during onboarding; never interrupting a task — natural stopping points only.
- At least a week or two between requests; the system caps the prompt at 3 displays per app per 365 days and suppresses repeat asks.
- Use the system prompt. Was: `SKStoreReviewController.requestReview()` → Now: `RequestReviewAction` (StoreKit, SwiftUI environment).
- Custom star dialogs and pre-screens ("Enjoying the app?" gates) are flags — trigger the system prompt.
- Identical on iOS, iPadOS, macOS.
- Fetch for detail: ratings-and-reviews

## settings
<!-- src: settings · changed: 2024-06-10 · platforms: all · speed: full -->
**Three-tier placement.**
1. Task-specific options stay in the screens they affect (show/hide, reorder, filter) — exiling them to settings "disconnects them from context".
2. General, infrequently changed options → custom in-app settings area.
3. Only the most rarely changed → system Settings app; if used, consider a deep-link button.
**Rules.**
- Defaults give the best experience to most people — auto-detect rather than ask.
- Minimise the number of settings; sprawl makes each one harder to find.
- Never duplicate systemwide settings (accessibility, scrolling, authentication methods) in-app.
- Command-Comma opens settings whenever a hardware keyboard is connected (any platform); games also honour Esc.
**macOS settings window spec.**
- Opened from the App menu → Settings… (required item; document-level options belong in the File menu). Never a settings button in the window toolbar.
- Toolbar of pane-switching buttons ("panes" is Apple's term): noncustomisable, always visible, active pane indicated.
- Window title = current pane name; single-pane windows: "App Name Settings".
- Dim (disable) the minimise and maximise buttons.
- Restore the most recently viewed pane on reopen.
**Corrections.** Was: "Preferences" / System Preferences → Now: "Settings" / System Settings everywhere, macOS included (since macOS 13); ⌘, unchanged; sections are still called panes.
**Deltas.** iOS: grouped-list settings screen (+ optional Settings bundle). macOS: the window spec above.
**Reviewer checks.**
- In-app duplicates of system settings (e.g. a text-size slider shadowing Dynamic Type).
- Single-task options (sort, filter, density) in global settings.
- macOS: settings in a main-window toolbar; pane window with customisable toolbar, wrong title, or enabled min/max buttons.

## multitasking
<!-- src: multitasking · changed: 2025-06-09 · platforms: iOS, iPadOS, macOS, tvOS, visionOS · speed: full -->
- Every app works well with multitasking (rare exceptions: some games); apps that don't feel broken.
- Be prepared to save and restore context at any moment.
- Pause attention-demanding activity (games, media) on switch-away; resume "as if they never left".
- Audio interruptions: pause indefinitely for primary interruptions (music, podcasts); duck or briefly pause for short ones (GPS directions), then restore.
- Finish user-initiated tasks (downloads, processing) in the background before suspending.
- Notify sparingly: completion notifications only for important, time-sensitive user-initiated tasks.
**Platform models.**
- iPhone: app switcher + Picture in Picture; otherwise one app at a time.
- iPadOS 26: apps run full screen or windowed — windows freely resizable and arranged, "behavior similar to macOS". System window controls handle tiling, full screen, minimise, close; the frontmost window shows coloured controls + drop shadow; multiple windows per app.
- Key iPad constraint: apps don't control multitasking configurations or learn which is in use — layouts must adapt to arbitrary window sizes.
- macOS: multitasking is the default; the system layers windows with shadows and states.
**Corrections (largest in this bucket).** Was: Split View / Slide Over / Stage Manager vocabulary and snap widths → Now: free-form resizable windows with macOS-style controls; the system, not the app, owns configuration (since 2025-06-09). Never propose "Slide Over widths" or "stages".
**Reviewer checks.**
- Fixed-canvas iPad mocks with no resize story.
- Hidden or restyled system window controls (iPadOS windowed, macOS traffic lights).
- Media/games without pause-on-background and resume states.
- Audio apps without a duck-vs-pause interruption spec.

## going-full-screen
<!-- src: going-full-screen · changed: 2025-06-09 · platforms: iOS, iPadOS, macOS · speed: full -->
- Offer full screen where it fits: games, media, in-depth distraction-free tasks. An iPhone/iPad/Mac-only pattern.
- Adjust layout proportions; don't programmatically resize the window; no jarring mode transitions.
- Keep essential controls reachable inside full screen.
- People choose when to exit — never auto-exit when an activity finishes or focus changes. Resume where people left off; games/slideshows auto-pause.
- Except in games, keep the Dock reachable (iPadOS/macOS). Games may defer the first bottom-edge swipe (iPadOS) or hide the Dock (macOS).
- Temporarily hiding toolbars/navigation to prioritise content is sanctioned — restore via a familiar action: tap, swipe down, or cursor to top of screen; keep controls visible when essential.
- With Liquid Glass, bars already float and shrink on scroll — full-screen hiding composes with that behaviour; it doesn't replace opaque bars.
**iOS/iPadOS.**
- Home Screen indicator auto-hides shortly after entry, reappears on bottom-edge interaction; one swipe exits.
- Keep default gesture behaviour; only where accidental exits are real, defer system gestures so exit needs two swipes (`preferredScreenEdgesDeferringSystemGestures`).
**macOS.**
- Use the system full-screen experience (`toggleFullScreen(_:)`) — it accommodates the camera housing automatically.
- Entry: green traffic-light button, View menu item, Control-Command-F. No custom window-mode menus; a games settings toggle is the sole exception.
- Games: don't change the display mode on entry.
**Reviewer checks.**
- No controls-revealed state or documented restore gesture in full-screen media/reading flows.
- Custom macOS full-screen toggle UI replacing the green button / ⌃⌘F.
- Top-centre content ignoring the camera-housing safe area on macOS.
- Critical touch targets in the iPhone Home-indicator region.

## printing
<!-- src: printing · changed: none (stable) · platforms: iOS, iPadOS, macOS, visionOS · speed: stub -->
- Standard locations: macOS → Print in the File menu (toolbar button optional, user-customisable); iOS/iPadOS → toolbar button opening an action sheet containing Print.
- Unavailable printing: dim the macOS menu item; remove the action from the iOS action sheet — note the asymmetry.
- Use the system print UI. macOS app-specific options go in a uniquely named custom print-panel category beside the system ones; advanced features behind a disclosure labelled "Advanced Options"; make option interdependencies clear; consider live preview and storing settings with the document.
- Custom dialogs replacing the system print panel are flags.
- Fetch for detail: printing
