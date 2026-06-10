<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: widgets, live-activities, controls, notifications, status-bars, app-shortcuts, snippets, always-on -->

# Components — system experiences

**System-owned chrome, app-supplied content** — content must survive redaction, hidden previews, audio-only delivery, lock-state security. Never draw what the system draws (badges, status-bar backgrounds, Done/Cancel buttons, contact avatars).

## widgets
<!-- src: widgets · changed: 2025-12-16 · platforms: iOS, iPadOS, macOS (+watchOS, visionOS, CarPlay) · speed: full -->
**Contexts.** System family small/medium/large (+XL iPad/Mac); iPhone small also in StandBy + CarPlay; iPad adds Lock Screen small; Mac: all four, **desktop + Notification Center only**. Accessory family (iPhone/iPad Lock Screen): circular / rectangular / inline (renders above the clock).
**Rendering modes (stale-prior trap).** Appearances: light, dark, clear, tinted. Modes: **fullColor** (system family, all platforms) · **accented** (background removed, hierarchy split into accent + primary groups, each tinted solid white; drives tinted + clear; not in Mac Home contexts) · **vibrant** (Lock Screen, StandBy low light, Mac desktop: desaturated; pixel opacity drives the blur; opaque greyscale only — light primary, darker secondary, never white at partial opacity). Clear adds translucency + Liquid Glass material. StandBy/CarPlay: background removed, scaled, large glanceable text; StandBy Night Mode monochrome red — no background colours.
**Rules.**
- One idea tied to the app's purpose; an app-icon replica adds no value; don't stretch a small layout into a large one; branding = small logo top-right at most.
- Updates periodic, not real-time (that's Live Activities); system refreshes dates/times; data-update animations **max 2 s**.
- Interactivity (iOS 17+): buttons/toggles only; all else deep-links to the exact content; inline accessory = exactly **one tap target**.
- Margins **16 pt** standard, **11 pt** tight grouping; radii concentric with the widget corner (ContainerRelativeShape).
- Text: system font + text styles + SF Symbols; **min 11 pt**; never rasterise text; Dynamic Type Large→AX5.
- Never encode meaning in colour alone (tinted/clear desaturate); opt-out only for media images smaller than the widget.
- Signed-out: say what sign-in adds.
Size tables → `tables/system-surface-dims.md`. Mac delta: no Lock Screen accessories/StandBy/tinted; desktop widgets take vibrant treatment when unfocused.
**Checks.** All four appearances + survives desaturation · removable background group · 16/11 pt margins, concentric radii · no text <11 pt or rasterised · not a brand tile · deep link lands right.
**Was → Now.** Passive tap-to-open → interactive (iOS 17). Full-colour only → tinted/accented (iOS 18) + clear/Liquid Glass (iOS 26); author as accent/primary groups. Mac Notification Center only → desktop (macOS 14+); Lock Screen (iOS 16+), StandBy (17+), CarPlay (2025-12-16).

## live-activities
<!-- src: live-activities · changed: 2025-12-16 · platforms: iOS, iPadOS, macOS (+watchOS, CarPlay) · speed: full -->
Real-time tracking of a bounded task/event; best **≤8 h**. Apple's workflow: start with the iPhone design, then refine for other contexts.
**Four required presentations.** **Compact** (Dynamic Island, sole activity: leading + trailing elements reading as ONE piece of information — consistent colour/typography across the gap, both sides deep-linking to the SAME screen, snug to the camera, widths balanced) · **minimal** (multiple activities: one attached + one detached bubble) · **expanded** (touch-and-hold) · **Lock Screen** (bottom banner; NOT a notification clone; margin **14 pt**). Derived: StandBy (Lock Screen presentation 2×), CarPlay Dashboard (compact pair merged; no interactivity), Mac menu bar, watch Smart Stack.
**Rules.**
- **No ads/promotions; no sensitive info** (bystander-visible — innocuous summary, opt-in detail).
- Identity in light AND dark; logo mark without container, **never the full app icon**; key info **medium weight or heavier**.
- Grow/shrink Lock Screen/expanded height dynamically; concentric radii (inner = outer − margin); never run content to the island edge.
- Compact/minimal/expanded backgrounds fixed (black); Lock Screen background customisable — check contrast incl. Always-On reduced luminance; tint the key line; verify the auto-generated dismiss button colour.
- Animation **max 2 s**; none on Always-On; move elements rather than remove/re-add.
- Prefer **one interactive element**, essential actions only.
- Lifecycle: in-app stop-following controls (else people disable Live Activities globally); update only on content change; alerts only for must-see updates; never duplicate via push; one activity rotating events beats several; end immediately — lingers on Lock Screen/menu bar/Smart Stack **up to 4 h** unless custom dismissal (**15–30 min adequate**).
Dimensions (island widths, presentation sizes, 44 pt island radius, CarPlay) → `tables/system-surface-dims.md`; macOS uses the iOS dimensions.
**iOS vs macOS.** Start on iPhone/iPad only; surface on the Mac **menu bar** (click opens iPhone Mirroring) — a Mac mock anywhere else is wrong.
**Checks.** All four presentations designed · compact balanced, one destination · concentric radii, no edge-bleed · Lock Screen 14 pt + dark/light/Always-On variants + dismiss contrast · ads/sensitive content (hard flag) · >1 button · event >8 h (wrong tool) · primary text below medium.
**Was → Now.** Passive iPhone-only (iOS 16) → interactive (17+), Smart Stack (2024), StandBy, **Mac menu bar + CarPlay (2025-12-16)**. All current iPhones (14 Pro → 17 Pro Max incl. iPhone Air) have the Dynamic Island.

## controls
<!-- src: controls · changed: 2024-06-10 (macOS added silently later) · platforms: iOS, iPadOS, macOS · speed: full -->
A button or toggle for quick access from **Control Center, the Lock Screen, or the Action button** (WidgetKit `ControlWidget` + App Intents — not UIKit; NOT generic UI controls). Anatomy: symbol + title + optional value — Lock Screen shows **symbol only**; Action button shows symbol (+ value) in the Dynamic Island.
**Rules.**
- Offer actions valuable **without launching the app**; open-the-app-only control → flag.
- Symbol carries the action alone; **toggles need a symbol per state** (`door.garage.open`/`.closed`). Animate state changes; durations animate while running. Update on interaction, completion, or **remotely via push**.
- System applies your tint to a toggle's on-state symbol and the Action-button island display.
- Needs setup? Prompt at add time; supply placeholder title/value. Action button hint text: **verb phrases**.
- Lock-state triad: redact title/value for personal/security info when locked (optionally symbol state too); **authenticate security-affecting actions** (`IntentAuthenticationPolicy`); locked camera (`LockedCameraCapture`) = capture only, same UI as in-app.
**iOS vs macOS.** Lock Screen, Action button, Dynamic Island are iPhone-only; macOS hosts controls in its Control Center/menu-bar customisation.
**Checks.** Single-symbol toggle · sensitive value unredacted · security action unauthenticated · non-verb hint · no progress animation · missing add-time prompt.
**Was → Now.** Third-party Control Center/Lock Screen/Action button items impossible → possible since iOS 18 (2024-06-10); iOS-only → macOS too (macOS 26 era, silent addition).

## notifications
<!-- src: notifications · changed: 2023-10-24 · platforms: all · speed: stub -->
Component page (anatomy, content, actions, badging); interruption levels/consent/Focus live on `managing-notifications` — cite levels from there. Non-obvious rules:
- **Errors are alerts, not notifications.** Never send multiple notifications for the same thing. **Never put the app name/icon in content** (the system shows the icon).
- **Communication notifications** (granted via donated intents) show contact avatar instead of the app icon — never fake avatars in payload imagery.
- Hidden previews: supply `hiddenPreviewsBodyPlaceholder` describing without revealing ("Friend request").
- Actions: **max 4 buttons** in the expanded view; labels name the result; no "open app" action; nondestructive **listed first** (Watch double tap triggers it; payloads reach the paired Watch regardless).
- Badge = **unread count, nothing else**; gotcha: **badge count zero removes all the app's notifications from Notification Center**; never mimic a badge in custom UI.
Identical rules iOS/macOS. Fetch for detail: notifications

## status-bars
<!-- src: status-bars · changed: unlogged (silent Liquid Glass rewrite) · platforms: iOS, iPadOS only · speed: full -->
System strip at the top edge; you control only backdrop and visibility. **Not a macOS component** — Mac menu bar extras are unrelated.
- **Obscure content beneath it** (transparent by default): **prefer a scroll edge effect** (`ScrollEdgeEffectStyle`/`UIScrollEdgeEffect`), never an opaque painted bar or custom blur hack; controls visible behind it look tappable but aren't.
- Hiding for full-screen media is fine; never permanently; restore via one gesture (Photos: single tap).
**Checks.** Controls scrolling beneath it · painted background · hidden app-lifetime or no one-gesture restore.
**Was → Now.** Pick light/dark bar styles, match bar colour → (iOS 26) content runs edge-to-edge; the scroll edge effect supplies legibility; the HIG no longer leads with `preferredStatusBarStyle`.

## app-shortcuts
<!-- src: app-shortcuts · changed: 2026-06-08 (app schemas guidance) · platforms: iOS, iPadOS, watchOS, visionOS — NOT macOS, tvOS · speed: full -->
Expose key functions via Siri, Spotlight, the Shortcuts app, the Action button, Apple Pencil squeeze. Zero-setup — live once installation finishes; each bundles one or more App Intents actions. **Hard cap: 10 per app.**
**NEW 2026-06-08 — app schemas rule.** For common functionality, "consider adopting app schemas instead": app schema domains (App Intents) expose actions/content to **Apple Intelligence**, which surfaces them contextually. App Shortcuts = unique features outside schema coverage; commodity-domain App Shortcut where a schema exists → flag for schema adoption.
**Rules.**
- Most common, important tasks. **At most one optional parameter** — "Start [morning, daily, sleep] meditation"; values predictable (no list is visible when speaking); two-parameter phrases are the named anti-pattern — follow up instead; missing parameter → clarify with a likely default + short list.
- Phrases simple — complicated aloud = too hard to say. In-app tips at the matching action (`SiriTipUIView`).
- Responses: **snippets** for static info; **Live Activities** for info changing over time. Audio-only devices (AirPods/HomePod): all critical info in the full dialogue text.
**Editorial.** Phrase **must include the app name** ("Create a Keynote"; variants encouraged). "App Shortcuts"/the "Shortcuts" app title case, Shortcuts always plural; user-built = lowercase "shortcut".
**iOS vs macOS.** Spotlight shows an SF Symbol or preview image per shortcut; declared order = initial ranking, usage re-prioritises. **No App Shortcuts surface on macOS** — reject Mac "App Shortcut in Spotlight" mocks; ship App Intents anyway (Mac Shortcuts app uses them).
**Checks.** Phrase missing app name · two+ parameters · >10 shortcuts · lowercase "app shortcuts"/singular "Shortcut app" · no clarification flow · critical info only visual.
**Was → Now.** SiriKit intents + recorded "Add to Siri" phrases → developer-defined, zero-setup, app-name-mandatory phrases on App Intents (2023+). No schemas concept → "schemas first, App Shortcuts for the long tail" (2026-06-08).

## snippets
<!-- src: snippets · changed: 2026-06-08 (NEW page — zero prior) · platforms: iOS, iPadOS, macOS · speed: full -->
Compact views shown in response to an action through **Siri, Spotlight, or the Shortcuts app** — the visual result/confirmation layer of an App Intent (priors misread this as code snippets or the deprecated SiriKit Intents UI).
**Two types.** **Confirmation** (confirm/cancel; options may affect the result) and **result** (information only); an intent always shows a result, confirmation is optional.
**Anatomy (stacked).** 1) **dialogue** Siri speaks (text placed above the custom view); 2) **custom view** — may contain buttons (interactive snippets); 3) **system buttons**: confirmation = Cancel + primary with customisable label, result = lone Done.
**Rules.**
- **Custom view max height 400 pt**; account for Dynamic Type; more detail → deep-link into the app, don't grow the view.
- Contrast against the **system background in light and dark**; consistent margins; no hardcoded light-mode colours.
- Confirmation primary label: descriptive verb from `ConfirmationActionName` or custom — "Order" beats "OK"/"Proceed"; unspecified default **"Continue"**.
- Communicate purpose visually; **omit the dialogue sentence from the custom view**.
No platform deltas; first-class on macOS.
**Checks.** View >400 pt · lazy OK/Proceed label · dialogue duplicated in the view · custom buttons duplicating system Cancel/Done · dark-mode contrast unchecked · clipping at large Dynamic Type.

## always-on
<!-- src: always-on · changed: 2023-09-12 · platforms: iOS (iPhone Pro models), watchOS · speed: stub -->
On iPhone, Always On governs **Lock Screen widgets and Live Activities** (plus notifications) in the dimmed idle state — not in-app UI, despite the watch-flavoured name.
- Hide sensitive info (balances, health); redact notification content too.
- Dim nonessential content (strip row backgrounds, dim secondary text, replace rich images); keep the key thing legible.
- Consistent layout across the transition — components become unavailable-looking, never disappear; updates infrequent and subtle; motion finishes gracefully to rest, never stops instantly.
Flag: no dimmed-state variant · unredacted personal data · disappearing elements · ticking animation. Fetch for detail: always-on
