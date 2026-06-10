<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: launching, onboarding, loading, managing-accounts, ratings-and-reviews, privacy, multitasking, going-full-screen, drag-and-drop, undo-and-redo, modality, sheets, searching, playing-audio, playing-video, progress-indicators, feedback -->

# Review — flows and state machines

The checks a static screen cannot show: sequences, required states, interruptions, dismissal paths. Walk each flow end to end; if you only received statics, report which checks below were **not performed** — never imply they passed. Severity per item: **[2] feels broken · [3] feels non-native**. Rejection-tier flow rules (account deletion, marketing-notification opt-in, ratings-prompt caps, tracking screens) live in `review-compliance.md` — don't re-tier them here.

## first-run-choreography

Canonical order Apple enforces: **launch (instant, unbranded) → splash (only at onboarding start) → onboarding (optional, interactive) → delayed sign-in → engagement → system ratings prompt.** Check the flow's screen order against this before the per-step rules. <!-- src: launching, onboarding, managing-accounts, ratings-and-reviews -->

- [2] Flag any flow forcing account creation before delivering value, unless core functionality genuinely requires it — sign-in comes as late as possible (browse first, sign in at purchase). <!-- src: managing-accounts -->
- [2] Flag permission requests at launch or stacked into onboarding without core-function necessity — request at first use of the dependent feature, benefit shown first. <!-- src: privacy, onboarding -->
- [2] Flag onboarding with no skip affordance, or that re-presents on later launches; a tutorial stays findable later (help or settings area). <!-- src: onboarding -->
- [2] Flag relaunch paths landing at a root screen instead of restoring prior state — scroll position, window states and positions. <!-- src: launching -->
- [3] Flag a splash screen anywhere except the start of onboarding (or immediately after launch when there is no onboarding); it must read at a glance, never delay. <!-- src: launching, onboarding -->
- [3] Flag a launch screen that isn't a stripped clone of the first screen (text, logos, marketing art), and any launch or splash screen in a macOS flow. <!-- src: launching -->
- [3] Flag passive carousel onboarding where interactive teaching or contextual tips (TipKit) fit; flag lessons on system gestures. <!-- src: onboarding -->
- [3] Flag ratings or purchase prompts and licensing/legal screens inside onboarding; flag ratings asks before demonstrated engagement, mid-task, or via custom star dialogs and "Enjoying the app?" pre-screens — use the system prompt at a natural stopping point, at least a week or two between asks (prompt caps: review-compliance.md). <!-- src: onboarding, ratings-and-reviews -->
- [3] Flag a sign-in view without benefit copy explaining why the account is required. <!-- src: managing-accounts -->

## required-states

- [2] Every data-driven screen needs designed **loading, empty, and error** states. Loading: placeholder/skeleton immediately, never a blank screen, never a blocking modal spinner where background loading is plausible. Empty: a clear next step. Error: the reason plus the fix, near the problem. (Copy quality: review-copy.md.) <!-- src: loading, feedback -->
- [2] Flag a spinner where duration is knowable → determinate indicator; switch indeterminate → determinate once duration is known; never switch circular → bar mid-task. <!-- src: progress-indicators -->
- [2] Progress honesty: even pace (90% in five seconds then 10% in five minutes reads deceptive); indicators keep moving — stationary reads frozen, a stall needs an explanation; indicators are transient, gone on completion. Long operations offer Cancel; add Pause when cancelling loses work; confirm progress-losing cancellation via an alert. <!-- src: progress-indicators -->
- [2] Flag pull-to-refresh as the only freshness mechanism — automatic updates must continue. <!-- src: progress-indicators -->
- [2] Media and games need pause-on-switch-away and seamless resume states ("as if they never left"); switching can happen at any moment, so context is saved continuously. <!-- src: multitasking -->
- [2] Full-screen modes need both **controls-hidden** and **controls-revealed** states with a familiar restore action — tap, swipe down, or cursor to the top of the screen; essential controls stay reachable; never auto-exit full screen when an activity finishes or focus changes. <!-- src: going-full-screen -->
- [3] iPhone full screen: keep default Home-indicator behaviour; defer system gestures (two swipes to exit) only where accidental exits are demonstrably real; no critical targets in the indicator region. <!-- src: going-full-screen -->

## drag-lifecycle

Walk the five states — lift, drag, over a destination, drop, after. <!-- src: drag-and-drop -->

- [2] Lift: a translucent drag image appears after ~3 points of movement and persists until the drop. <!-- src: drag-and-drop -->
- [2] Over destinations: exactly one cue at a time — insertion point or highlight only where the drop can be accepted; no feedback or a "not allowed" image (`circle.slash`) where it can't; the destination auto-scrolls when the drag nears its edges. <!-- src: drag-and-drop -->
- [2] Failed or invalid drop: the item slides back to its source or fades out — never a silent vanish. <!-- src: drag-and-drop -->
- [2] Semantics: same container → move; different container → copy; between apps → always copy; hardware-keyboard Option, checked **at drop time**, forces copy. <!-- src: drag-and-drop -->
- [2] After: dropped content stays selected at the destination; the drop is undoable, confirmed before completing, or reversible afterwards. <!-- src: drag-and-drop -->
- [2] Every drag-only feature has a non-drag path (menu command or button) — cross-check review-a11y.md. <!-- src: drag-and-drop -->
- [3] macOS extras: multi-item drags show a count badge; the pointer changes for copy / not-allowed; slow transfers show progress (placeholder at the drop location). <!-- src: drag-and-drop -->

## undo-visibility

- [2] Flag any editing or creation flow with no undo path, single-level undo, or arbitrary depth limits — undo runs back to a logical step (document open, last save). <!-- src: undo-and-redo -->
- [2] Undoing an offscreen change must scroll/highlight to reveal the result — otherwise people assume nothing happened and repeat the undo. <!-- src: undo-and-redo -->
- [2] Flag any repurposing of shake or the three-finger swipes (left = undo, right = redo). <!-- src: undo-and-redo -->
- [3] Label the target where knowable — "Undo Typing", not bare "Undo"; macOS: Undo/Redo at the top of the Edit menu with Command-Z / Shift-Command-Z; custom undo buttons only when necessary, standard system symbols, in a toolbar. <!-- src: undo-and-redo -->

## modality-dismissal

- [2] Every modal has an obvious dismiss affordance; any dismissal that would lose user-generated content is confirmed — gesture and button alike (iOS: via an action sheet). <!-- src: modality, sheets -->
- [2] One modal at a time: no sheet stacked on a sheet (close the first before presenting the second); an alert may appear above anything, but **never two alerts at once**. <!-- src: modality, sheets -->
- [2] No app-within-app: no tab bars or branching hierarchies inside a modal; one path through any subviews. <!-- src: modality -->
- [2] A sheet offering Done pairs it with Cancel (or Back mid-flow) — Done alone is restrictive or misleading; never Cancel + Done + Back together. <!-- src: sheets -->
- [3] Dismissal conventions: iOS/iPadOS = button in the top toolbar or swipe down; macOS = button in the sheet's content view. Title the modal's task so people keep their place. <!-- src: modality -->

## detent-behaviour

- [2] A resizable iPhone sheet includes a grabber (drag resizes, tap cycles detents, works with VoiceOver); swipe-to-dismiss is supported, with unsaved changes confirmed at swipe time via an action sheet. <!-- src: sheets -->
- [3] Medium detent (about half height) is for progressive disclosure; compose-style content is full-height only. iPad: page or form sheet centred over a dimmed surround, not edge-to-edge. macOS: no detents, button-only dismissal; the parent window dims while other windows stay usable. <!-- src: sheets -->

## search-interaction

- [2] The active scope is always visible — descriptive placeholder, scope bar, or title naming what's being searched. <!-- src: searching -->
- [2] Visible search history needs a clear-history affordance. <!-- src: searching -->
- [3] Recents appear before typing; suggestions and completions while typing. <!-- src: searching -->
- [3] One clearly identified global search; local search only as an addition for clearly distinct sections. Placement is version-sensitive — judge against trees-containers.md#search-placement and verify live (page edited 2026-06-08). <!-- src: searching -->

## audio-interruption

- [2] Primary interruptions (music, podcasts, audiobooks) pause indefinitely; short ones (GPS directions) duck or pause briefly, then restore. Resume logic distinguishes resumable (a call ends) from nonresumable (the person started another playlist); flag the session on deactivation so interrupted apps know they can resume. <!-- src: playing-audio, multitasking -->
- [2] Disconnecting headphones pauses playback immediately; rerouting is permitted. Silent mode silences nonessential audio (effects, soundtracks, feedback) — explicitly initiated media still plays. <!-- src: playing-audio -->
- [2] Never repurpose audio controls, and never hijack another app's audio without a clear playing context; Space on a connected keyboard plays/pauses video. <!-- src: playing-audio, playing-video -->
