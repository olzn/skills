# HIG research notes — platforms-tech

> Researched 2026-06-10 from Apple's JSON content API (`https://developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`). Bucket: platform overview pages (Designing for iOS / macOS, iPadOS for adaptivity) + iOS/macOS-relevant Technologies pages (Mac Catalyst, Widgets, Live Activities, App Clips, iCloud, Sign in with Apple, Machine learning, Generative AI) + triage of remaining Technologies pages.
> Currency: Generative AI and Machine learning pages were updated **2026-06-08 (this week, WWDC 2026)**. Widgets and Live Activities were rewritten **2025-12-16**. The Wallet page alert references **iOS 27** — confirming WWDC 2026 shipped an iOS 27 generation. VoiceOver (Technologies) is covered in `foundations-people.md`; Multitasking in `patterns-lifecycle.md`.

---

## Designing for iOS

**URL:** https://developer.apple.com/design/human-interface-guidelines/designing-for-ios
**Platforms:** ios. No 2025-26 change alert (stable page).

**Purpose.** Defines the device character of iPhone — the assumptions every iOS design decision should rest on. Short, principle-level; the numeric rules live in Layout/Typography/etc.

**Device characteristics (Apple's exact framing).**
- *Display:* medium-size, high-resolution.
- *Ergonomics:* held in one or both hands; portrait/landscape switching; viewing distance "no more than a foot or two".
- *Inputs:* Multi-Touch gestures, virtual keyboards, voice; gyroscope/accelerometer; personal data; spatial interactions.
- *App interactions:* burst usage (1–2 minutes) AND long sessions (1 hour+); frequent app switching is normal.
- *System features apps should integrate:* **Widgets, Home Screen quick actions, Spotlight, Shortcuts, Activity views**.

**Normative rules (best practices).**
1. Limit the number of onscreen controls; make secondary details/actions discoverable with minimal interaction (progressive disclosure over toolbar clutter).
2. Adapt seamlessly to appearance changes: device orientation, Dark Mode, Dynamic Type. These are user choices, not edge cases.
3. Place key controls where hands reach: **middle or bottom of the display**. "Especially important": support **swipe-to-go-back** and swipe actions on list rows.
4. With permission, use platform capabilities to avoid manual data entry (Apple Pay, biometric auth, location).

**iOS vs macOS.** This page is the iOS half of a deliberate contrast pair — see Designing for macOS below for the side-by-side.

**Reviewer checks.**
- Primary actions reachable in the bottom half of the screen? Anything critical pinned top-left that's used constantly?
- Control count per screen: does the screen lean on menus/swipes for secondary actions, or expose everything at once?
- Does the design exist in both light and dark variants? Does the type spec use Dynamic Type styles rather than fixed px?
- Are back-swipe and list-row swipe gestures plausible in the prototype (no full-screen-width horizontal carousels blocking the back swipe)?
- Is the design asking users to type something the platform could supply (address, payment, login)?

**Stale-knowledge corrections.**
- Version numbering: iOS jumped 18 → **26** (June 2025, Liquid Glass) and WWDC 2026 brought the iOS 27 generation. A model assuming "iOS 18/19 is current" is two design languages behind.
- The page itself is pre-Liquid-Glass-stable, but everything it links to (Layout, Materials, toolbars) was rewritten for Liquid Glass — flat, opaque-bar iOS 7–18 aesthetics are no longer the system look.

---

## Designing for macOS

**URL:** https://developer.apple.com/design/human-interface-guidelines/designing-for-macos
**Platforms:** macos. No 2025-26 change alert.

**Purpose.** Defines the device character of the Mac; the contrast document to Designing for iOS.

**Device characteristics.**
- *Display:* large, high-resolution; multiple displays incl. iPad (Sidecar) extension.
- *Ergonomics:* stationary, desk/table, viewing distance **1–3 feet**.
- *Inputs:* physical keyboards, pointing devices, game controls, Siri — any combination.
- *App interactions:* minutes to hours of deep concentration; multiple apps open; smooth active/inactive state transitions expected.
- *System features apps should integrate:* **the menu bar, file management, going full screen, Dock menus**.

**Normative rules (best practices).**
1. Use the large display to show **more content in fewer nested levels with less modality** — but keep density comfortable.
2. Windows: let people resize, hide, show, move; support full-screen mode.
3. **Menu bar carries ALL the commands** people need in the app — not a subset.
4. Support high-precision input (pixel-perfect selection and editing).
5. Handle **keyboard shortcuts** and keyboard-only work styles.
6. Support **personalization**: customizable toolbars, configurable window views, user-chosen colours and fonts.

**iOS vs macOS — the structural contrast (synthesis of the two pages).**
| Dimension | iOS | macOS |
|---|---|---|
| Viewing distance | ≤1–2 ft | 1–3 ft |
| Reach priority | bottom/middle of screen | none — top-down flow, important things at top |
| Command surface | in-UI controls, gestures | menu bar (exhaustive) + toolbar + context menus |
| Navigation depth | drill-down acceptable | flatter, fewer nested levels, less modality |
| Keyboard | virtual, optional | physical, primary; shortcuts mandatory |
| Personalization | system-level (Dark Mode, Dynamic Type) | also app-level (toolbars, fonts, window layouts) |
| Session shape | bursts + long sessions, heavy app switching | long sessions, many apps concurrently |

**Reviewer checks.**
- Mac design with a tab bar at the bottom or hamburger menu → wrong platform idiom (use sidebar/menu bar).
- Does every visible action have a plausible menu-bar home and keyboard shortcut?
- Is content forced into a phone-width column on a wide window? Under-use of space violates "more content, fewer levels".
- Modal sheets used where a Mac would show an inline panel or second window?
- Is the toolbar customizable-looking (standard items) or a bespoke fixed strip?

**Stale-knowledge corrections.**
- macOS version: **macOS Tahoe 26** (2025), with a 2026 successor at WWDC this week; models often think Sonoma/Sequoia (14/15) is current.
- macOS 26 adopted **Liquid Glass** too — translucent material toolbars/sidebars, concentric corner radii, layered app icons. Pre-2025 "Aqua/Big Sur flat" assumptions about chrome are stale; macOS and iOS now share one design language while keeping separate interaction idioms.

---

## Designing for iPadOS (brief — adaptivity only)

**URL:** https://developer.apple.com/design/human-interface-guidelines/designing-for-ipados
**Platforms:** ipados (out of core scope; relevant as the bridge between the other two).

**Purpose.** iPad sits between iPhone and Mac: large display + touch + optional keyboard/trackpad/Apple Pencil. Matters to this skill suite mainly because (a) adaptive iOS layouts must scale to iPad size classes and (b) Mac Catalyst ports start from the iPad app.

**Adaptivity-relevant rules.**
- Viewing distance ~3 ft; people combine multiple input modes (touch + keyboard + Pencil) in one session.
- Elevate content; **minimize modal interfaces and full-screen transitions**; position controls reachable "but not in the way".
- Adapt to orientation, **multitasking modes** (Split View, Slide Over, resizable windows since iPadOS 26), Dark Mode, Dynamic Type — and "transition effortlessly to running in macOS".
- System features: Multitasking, Widgets, Drag and drop. iPadOS 26 also gained a **menu bar** (see `the-menu-bar`, updated 2025-06-09) — iPad keeps converging toward Mac conventions.

**Reviewer check (adaptive).** Any iOS design should have an answer for regular-width size classes: does the single column become split view / multi-column, or does it just stretch?

---

## Mac Catalyst

**URL:** https://developer.apple.com/design/human-interface-guidelines/mac-catalyst
**Platforms:** ipados, macos. Last change 2023-05-02 (stable).

**Purpose.** Governs turning an iPad app into a Mac app — and is, in practice, the HIG's only explicit **iOS→macOS translation table**. Valuable to the skill suite even for non-Catalyst work (e.g. designing the same feature for both platforms).

**Normative rules.**
*Prerequisites / suitability:*
- Good candidates already support: drag and drop, keyboard navigation + shortcuts, multitasking (Split View/Slide Over/PiP), multiple windows (scenes).
- Unsuitable if essential features need gyroscope/accelerometer/rear camera, HealthKit/ARKit, or are primarily marking/handwriting/navigation.

*Idiom choice (exact numbers):*
- Default = "Scale Interface to Match iPad" (**iPad idiom**): everything renders at **77%** in macOS; iPadOS 17pt baseline body text becomes **13pt** on Mac (13pt is the native macOS body baseline). Slightly less detailed text/graphics.
- **Mac idiom**: 100% rendering, more Mac-like controls, better performance for graphics-heavy apps — but requires a full layout audit. Rules: adjust font sizes (100% rendering makes text too large unless you use text styles, not fixed sizes); consider a separate asset catalog; appearance customizations limited to ones macOS controls support.

*Navigation translation:*
- iPad **tab bar → macOS sidebar (split view) or segmented control**. Sidebar preferred; segmented control only for genuinely flat hierarchies.
- Keep tab-level destinations accessible from the macOS **View menu** regardless.
- Add **Next/Previous buttons** in addition to swipe gestures for paging.
- iPad split views (2–3 columns: primary / supplementary / content pane) map naturally to Mac.

*Input translation (automatic):* tap→click; touch-and-hold→click-and-hold; pan→click-drag; pinch/rotate→trackpad pinch/rotate (sent to the view under the pointer, not under each touch).

*Layout translation:*
- Adopt **top-down flow**: most important actions/content near the top of the window.
- **Relocate buttons from side and bottom edges** — the iPhone/iPad reach rationale doesn't apply on Mac; move them to the toolbar.
- Split a single column into multiple columns; show an **inspector next to content instead of a popover**; use regular-width/regular-height size classes and reflow side-by-side on resize.
- Move primary controls into the window toolbar AND list their commands in menu-bar menus.

*Menus:* Mac users expect **every object to have a context menu** and **all commands in the menu bar**. (Apple notes "contextual menu" is the traditional Mac term.)

*App icon:* create a macOS-specific icon version ("lifelike rendering style" — note this wording predates the 2025 Liquid Glass layered-icon guidance in `app-icons`; follow the newer page for actual icon construction).

**Reviewer checks (also usable as a generic iOS↔macOS port review).**
- Tab bar surviving into the Mac design → flag; expect sidebar/segmented control.
- Buttons hugging bottom/side edges of a Mac window → flag; expect toolbar placement.
- Popover used for a persistent inspector on Mac → flag.
- Body text speced at 17pt on Mac → flag (native Mac body is 13pt; 17 is the iOS baseline).
- Missing context menus on content objects in a Mac design → flag.
- Every toolbar control should have a corresponding menu-bar command.

**Stale-knowledge corrections.**
- None major (2023 page), but note Apple's current strategic stance: SwiftUI multiplatform is the favoured path; Catalyst still documented. The translation rules remain valid design guidance either way.
- The icon advice here ("lifelike rendering") is superseded in spirit by the 2025-06-09 `app-icons` Liquid Glass layered icon system.

---

## Widgets

**URL:** https://developer.apple.com/design/human-interface-guidelines/widgets
**Platforms:** ios, ipados, macos, watchos, visionos. **Updated 2025-12-16** ("Updated guidance for all platforms, and added guidance for visionOS and CarPlay").

**Purpose.** Governs WidgetKit widgets: glanceable, periodically-refreshed app content placed on Home Screen / Lock Screen / desktop / Notification Center / StandBy / CarPlay.

**Anatomy — sizes and contexts (iOS/macOS-relevant).**
- **System family:** small, medium, large (+ extra large on iPad/Mac/Vision Pro).
  - iPhone: small/medium/large on Home Screen + Today View; small also in **StandBy and CarPlay**.
  - iPad: small/medium/large/XL on Home Screen + Today View; small also on Lock Screen.
  - Mac: all four on **desktop and Notification Center**.
- **Accessory family** (Lock Screen, iPhone+iPad): accessory circular, accessory rectangular, accessory inline (inline renders above the clock; circular/rectangular below). Functionally equivalent to watch complications — Apple says design them in tandem with complications.

**Rendering modes / appearances (the 2024–2025 system — biggest stale-model trap).**
- Home Screen widget appearances people can pick: **light, dark, clear, tinted**.
  - *Clear*: system desaturates the widget, adds translucency + highlights + **Liquid Glass material**.
  - *Tinted*: system desaturates and applies the user's tint colour.
- Three rendering modes:
  - **fullColor** — system family widgets, all platforms.
  - **accented** — system removes your background, splits the view hierarchy into an **accent group and a primary group**, tints each a solid colour (white on iPhone/iPad/Mac). Drives tinted + clear appearances. Mac Home contexts: per Apple's table, accented is **Not supported on Mac**.
  - **vibrant** — Lock Screen (iPhone/iPad), StandBy low light, **Mac desktop**: content desaturated, pixel opacity drives the blurred-material effect; brightness = contrast. Design rule: full-opacity content; **white/light grey for primary, darker greys for secondary; opaque greyscale values, not white at partial opacity**.
- StandBy: small widget scaled up, background removed; below an ambient-light threshold rendered monochrome **red-tinted** (Night Mode). Don't use background colours in StandBy.
- CarPlay: same small widget, background removed, scaled to the CarPlay widgets grid; demand large text/glanceability. Supporting StandBy ≈ supporting CarPlay.

**Normative rules.**
- One idea, tied to the app's main purpose; **replicating the app icon adds no value**.
- Prefer dynamic content that changes through the day; stale-looking widgets get removed.
- Offer multiple sizes only when each adds value; **don't stretch a small layout into a large one**; better one right-sized widget than all sizes.
- Balance density: glanceable essentials + a second layer for the longer look.
- Branding: small logo top-right corner at most; brand colour/typeface OK if it doesn't overpower content.
- Don't mirror the widget's look inside the app (confuses behaviour expectations).
- Signed-out states: tell people sign-in adds value ("Sign in to view reservations").
- Updates: periodic, NOT real-time (that's Live Activities); let the **system** refresh dates/times; show last-updated text if users check more often than you can refresh; **animations for data updates max 2 seconds**.
- Interactivity (since iOS 17): buttons and toggles allowed; everything else launches the app via **deep link straight to the relevant content**; avoid app-like layouts; inline accessory widgets get exactly **one tap target**.
- Margins: standard **16pt**; tight grouping margins **11pt**; Lock Screen / Mac desktop use smaller system margins. Match content corner radii concentrically to the widget's corner via ContainerRelativeShape.
- Text: system font + text styles + SF Symbols preferred; **minimum 11pt font**; never rasterize text (VoiceOver + scaling); Dynamic Type supported Large→AX5; custom font for big display text only, SF Pro for small text.
- Colour: don't encode meaning in colour alone (tinted/clear modes desaturate everything); full-colour images that opt out of desaturation only for media content (album art) and smaller than the widget.
- Gallery: realistic preview (simulated data if real data is slow); placeholder = static components + semi-opaque shapes; description starts with an action verb, no "This widget shows…", sentence-style capitalization; group all sizes under ONE description; Add button colour can be branded.

**Specifications (exact, pt).** iOS widget sizes by screen (portrait): e.g. 430×932 → small 170×170, medium 364×170, large 364×382, circular 76×76, rectangular 172×76, inline 257×26; 393×852 → 158×158 / 338×158 / 338×354 / 72×72 / 160×72 / 234×26; 375×812 → 155×155 / 329×155 / 329×345. iPad uses a canvas→device two-step scale (e.g. 12.9": canvas 170×170 → device 160×160 small; XL 795×378.5 canvas / 748×356 device). No published macOS table — Mac uses the same families. Full tables on the page; a skill should link/fetch rather than embed all rows.

**iOS vs macOS differences.**
- Mac: desktop + Notification Center only; no Lock Screen accessory widgets, no StandBy, no tinted/accented Home Screen treatment (vibrant on desktop instead — desktop widgets get the vibrant/desaturated treatment when not in focus).
- iPhone/iPad widgets can be placed on a Mac via Continuity (not in this page but true since macOS 14) — design once, runs there.
- Interactivity exists on both; deep links open the app on the respective platform.

**Reviewer checks.**
- Widget mock provided in all four appearances (light/dark/clear/tinted)? Does it survive desaturation — is meaning carried by text/shape, not colour?
- Background present? It must be a removable group (StandBy/CarPlay/accented strip it).
- Margins ≈16pt (or 11pt for tight groups)? Content corner radii concentric with widget corners?
- Any text under 11pt? Any rasterized/in-image text?
- Tap targets: is the whole widget a link to the right deep location? Buttons/toggles big enough and few enough?
- Is it just an app-icon clone or static brand tile? Flag.
- Gallery description copy: verb-first, ≤ one sentence-ish, no self-reference.

**Stale-knowledge corrections.**
- **Widgets are interactive now** (buttons/toggles, iOS 17+). Old guidance "widgets are not mini-apps, tapping anywhere opens the app" is half-true at best.
- **Tinted/accented (iOS 18) and clear/Liquid Glass (iOS 26) appearances exist**; designs must be authored as accent/primary groups and survive full desaturation. Pre-2024 models know nothing of this.
- Widgets live on the **macOS desktop** (macOS 14+), not just Notification Center; on **iPhone Lock Screen** (iOS 16+), **iPad Lock Screen** (17+), **StandBy** (17+), **CarPlay** (2025).
- Old "widget gallery" knowledge (pre-iOS 18 dims) — dimension tables were corrected as recently as 2025-01-17.

---

## Live Activities

**URL:** https://developer.apple.com/design/human-interface-guidelines/live-activities
**Platforms:** ios, ipados, **macos**, watchos. **Updated 2025-12-16** ("Updated guidance for all platforms, and added guidance for macOS and CarPlay").

**Purpose.** Governs glanceable real-time tracking of a bounded task/event (delivery, match, workout) shown in the Dynamic Island, Lock Screen, StandBy, Mac menu bar, watch Smart Stack, CarPlay Dashboard.

**Anatomy — four required presentations + derived contexts.**
- **Compact** — Dynamic Island when it's the only Live Activity: two elements, leading + trailing of the TrueDepth camera, designed to read as ONE piece of information (consistent colour/typography across the gap).
- **Minimal** — when multiple Live Activities are active: one attached + one detached bubble (circular or oval).
- **Expanded** — shown on touch-and-hold of compact/minimal; enlarged version that preserves relative element placement.
- **Lock Screen** — banner at bottom of Lock Screen; on no-Dynamic-Island devices also the alert banner over Home Screen/apps. Layout similar to expanded but NOT a notification clone.
- Derived: **StandBy** (minimal → tap → Lock Screen presentation scaled 2×, custom background auto-extended full-screen), **CarPlay Dashboard** (system merges compact leading+trailing into one view; interactivity disabled), **Mac menu bar** (compact/minimal/expanded; click launches **iPhone Mirroring**), **watch Smart Stack**.

**Normative rules.**
- For tasks with a defined beginning and end; best **≤8 hours** total.
- Glanceable essentials only; tap → app deep-linked to the exact related screen (both compact elements must link to the SAME screen).
- **No ads or promotions. No sensitive info** (visible to bystanders; show innocuous summary or redact, let people opt in to showing details).
- Match the app's visual identity in light AND dark; logo mark **without container, never the full app icon**.
- Text: **medium weight or heavier** for key info; small text sparingly.
- Layout: only use the space the content needs; **dynamically grow/shrink the Lock Screen/expanded height** as info availability changes; consistent margins; **concentric corner radii** (outer radius − margin = inner radius; ContainerRelativeShape); don't run content to the Dynamic Island edge — use inset container shapes or a thick separator line; in compact, keep content snug against the TrueDepth camera, no padding against it, balanced widths leading/trailing (shorten units to balance).
- Colours: compact/minimal/expanded backgrounds are NOT customizable (black, opaque); Lock Screen background IS customizable — ensure contrast incl. Always-On reduced luminance; tint the **key line** (outline around the Dynamic Island shown on dark backgrounds) to match content; verify the auto-generated **dismiss button** colour (`activitySystemActionForegroundColor`).
- Animation: system + custom, **max 2 seconds**; no animations on Always-On displays; animate elements to new positions rather than remove/re-add; numeric content transitions for scores/counters.
- Interactivity: prefer **a single interactive element**; only essential, once-or-pause/resume actions (playback, workout); buttons cost information space; CarPlay deactivates them.
- Lifecycle: start at expected moments (can be automatic); provide in-app controls to stop following (else users disable Live Activities globally); offer an **App Shortcut** to start it (e.g. via Action button); update ONLY when content changes; **alerts** (screen lights up + expanded presentation) only for must-see updates; never duplicate updates with push notifications; **one Live Activity rotating multiple events** beats several concurrent ones; end immediately when the event ends — system removes it from Dynamic Island/CarPlay at once, but it lingers on Lock Screen/Mac menu bar/Smart Stack **up to 4 hours** unless you set a custom dismissal: **15–30 minutes is adequate in most cases**.
- Workflow rule (Apple's words): "**Start with the iPhone design, then refine it for other contexts.**"

**Specifications (exact, pt).**
- Dynamic Island corner radius **44pt**, matching TrueDepth camera shape.
- Compact element: 62.33×36.67 (430×932 screens) / 52.33×36.67 (393×852). Minimal width 36.67–45 × 36.67.
- Expanded & Lock Screen: width 408 (Max/Air) or 371 (regular), height **84–160** range.
- Dynamic Island total width: compact/minimal **250pt** (Pro Max/Plus/Air) or **230pt** (regular/Pro); expanded 408/371pt. (Table covers iPhone 14 Pro → iPhone 17 Pro Max.)
- iPad Lock Screen: 500×84–160 (12.9"), 425×84–160 (11" class).
- **macOS: "Use the provided iOS dimensions."**
- Lock Screen standard margin **14pt**.
- CarPlay sizes: 240×78, 240×100, 170×78; test at Smart Display Zoom resolutions 1920×720 / 900×1200 / 800×480.

**iOS vs macOS differences.** Live Activities **start on iPhone/iPad only**; on Mac they surface automatically in the **menu bar** of a paired Mac, and clicking opens the app via iPhone Mirroring. There is no Mac-native authoring; the Mac rendering uses iOS dimensions. (So for a macOS design review: a "Live Activity" mock that lives anywhere but the menu bar is wrong.)

**Reviewer checks.**
- Are all four presentations designed (compact pair, minimal, expanded, Lock Screen)? Most mocks only show one.
- Compact: leading/trailing balanced widths, snug to camera, single readable unit of info, both sides linking to one destination?
- Corner concentricity: inner radii = outer − margin? Content bleeding to the island edge?
- Lock Screen: 14pt margins; not a notification look-alike; dark/light/Always-On variants present; dismiss-button contrast.
- Any ad-like, promotional, or sensitive content? Hard flag.
- More than one button/toggle? Question it. Any interactivity expected in CarPlay? Flag (deactivated).
- Stated duration of the tracked event > 8h? Wrong tool.
- Text weights below medium for primary info? Flag.

**Stale-knowledge corrections.**
- **Mac menu bar + CarPlay Dashboard support are Dec 2025 additions** — pre-2025 models don't know Live Activities appear on the Mac at all (mechanism: iPhone Mirroring, macOS 15+, formalized in HIG 2025-12-16).
- Interactive buttons/toggles (iOS 17+), watch Smart Stack (2024), StandBy — all post-2022; the original Live Activities (iOS 16) were passive and iPhone-only.
- The "Dynamic Island" device list now spans iPhone 14 Pro → 17 Pro Max incl. **iPhone Air** (new 2025 device class) — all current iPhones have it; "notch devices" are the legacy path.

---

## App Clips (brief)

**URL:** https://developer.apple.com/design/human-interface-guidelines/app-clips
**Platforms:** ios, ipados (NOT macOS). Updated 2025-06-09 ("Updated guidance to include demo App Clips").

**Purpose.** Governs lightweight, instantly-launched app slices (no App Store install) for in-the-moment tasks AND — new in 2025 — **demo experiences** of full apps/games. Includes the brand/print rulebook for App Clip Codes.

**Normative rules (design).**
- Complete the task or demo **inside** the App Clip; never gate completion behind installing the full app.
- Essential features only; **linear, focused UI — no tab bars, complex navigation, or settings**; minimal screens/forms.
- Launch instantly: include all assets, **no splash screens**, avoid post-launch downloads; keep binary small.
- **No ads; not marketing-only.** Avoid web views — native or nothing (link to website instead).
- Avoid requiring an account up front; if needed, offer **Sign in with Apple**; support **Apple Pay** for payment.
- App Clip → full app transition must be seamless (no re-login).
- Privacy: no background ops; don't rely on local data persisting (system deletes inactive clips); store login state off-device.
- Recommending the app: use the system App Clip card + banner; show an **SKOverlay** only at task completion / natural pause; never nag, never via push.
- Notifications: allowed **up to 8 hours after launch** without permission; ask explicitly only for longer; task-related only.

**App Clip card specs:** image **1800×1200 px** PNG/JPEG, no transparency; prefer photography/graphics, avoid UI screenshots and **avoid text in the image** (not localizable); title ≤ **30 characters**; subtitle ≤ **56 characters**; action verb is exactly one of **View / Play / Open** (View = media/informational, Play = games, Open = everything else).

**App Clip Code specs (brand-compliance hard rules):** always use generated codes (App Store Connect / generator CLI), never modify, no filters/glows/shadows/gradients, never rotate, never animate or dim; badge with App Clip logo when clear space allows (never logo on its own; no logo variant on disposable/gambling/drinking items); print minimum **3/4 inch (1.9 cm) diameter**; digital minimum **256×256 px** (PNG/SVG); NFC tag ≥ **35 mm** (printed NFC code ≥1.37 in); scanning-distance-to-size ratio ≤ **20:1**, ideally **10:1**; cylindrical surfaces: width ≤ **1/6 of circumference**; clear space = gap between centre glyph and circular code; adjacent QR codes must not be larger; matte finishes, ≥600 ppi raster / ≥300 dpi print; sRGB→CMYK with media-relative intent, Delta E tolerance 2.5; Type 5 NFC tags.

**iOS vs macOS.** iOS/iPadOS only — a "Mac App Clip" does not exist; flag any such concept.

**Reviewer checks.** Tab bar or settings screen in an App Clip flow → flag. Account wall before value → flag. Card copy over 30/56 chars, text baked into card art, wrong action verb → flag. Any modified/recoloured-beyond-spec App Clip Code, or one smaller than minimums → flag.

**Stale corrections.** Demo App Clips (try-before-buy game/app demos) are a 2025 expansion; older models believe App Clips must be single real-world tasks only. (Size-limit folklore: don't quote a hard MB cap from memory; guidance now just says "ensure your App Clip is small".)

---

## iCloud (brief)

**URL:** https://developer.apple.com/design/human-interface-guidelines/icloud
**Platforms:** all. Updated 2025-06-09 (game-save sync via GameSave framework).

**Purpose.** Behavioural rules for apps whose content syncs through iCloud. Core principle: **transparency** — people never think about where content lives; it's just "the latest version, everywhere".

**Normative rules.**
- iCloud works automatically; if offering a choice at all, it's a single first-launch option: all data in iCloud, or none. **Never ask per-document.**
- Keep content current, but for very large documents let people control download timing; indicate when a newer version exists; subtle feedback if a download takes more than a few seconds.
- Respect paid storage: store user-created content only, never regenerable resources; keep the Documents folder lean (it's backed up).
- iCloud unavailable → **no alert**; unobtrusive note that changes won't sync.
- Sync app state too (last page read, settings people want on all devices — not context-specific ones).
- **Deleting = deleting everywhere: warn + confirm.**
- Conflicts: auto-resolve where possible; otherwise an unobtrusive, early, easy version-picker.
- Search results include iCloud content.
- Games: prefer the **GameSave** framework (2025) for cross-device save data with built-in conflict alerts.

**iOS vs macOS.** None — "No additional considerations" for any platform.

**Reviewer checks.** Per-document "keep in iCloud?" prompts; alert dialogs for offline iCloud; delete flows without an everywhere-warning; sync spinners blocking UI.

---

## Sign in with Apple (brief)

**URL:** https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple
**Platforms:** all + web + non-Apple platforms. Stable since 2022.

**Purpose.** Flow guidance for SIWA plus the button compliance spec (system and custom buttons). App Review enforces the button rules.

**Normative rules (flow).**
- Ask for sign-in only in exchange for explained value; **delay sign-in as long as possible**; commerce apps: account creation AFTER purchase (guest checkout; reuse Apple Pay name/email).
- Support linking existing accounts to SIWA (match by shared email, or suggest in account settings).
- Welcome immediately on completion; show sign-in method in settings ("Using Sign in with Apple").
- Data: minimize; mark required vs optional; **never ask for a password**; **never ask for a personal email when a private relay address was shared** (surface the relay address in-app; or point to Settings > **Apple Account** > Sign in with Apple; or use order number/phone).
- Display the data you collected (e.g. greet by the shared name) — transparency.

**Button rules (system-provided).**
- Three titles only: **Sign in with Apple / Sign up with Apple / Continue with Apple** (watchOS: "Sign in").
- Three appearances: **white** (on dark), **white with outline** (on white/light only — never on dark), **black** (on light — never on black/dark).
- **At least as large as other sign-in buttons; never below the scroll fold.**
- Min size **140×30 pt**; min surrounding margin **1/10 of button height**; corner radius adjustable from square to capsule.

**Custom button rules.** Apple-supplied logo artwork only (never redraw); logo height = button height, no cropping, no added vertical padding; black or white only for logo+title; title font free-ish BUT proportions fixed: **title size = 43% of button height** (height = 233% of font size); title-to-trailing-edge margin ≥ **8% of button width**; logo-only buttons 1:1, maskable to circle/rounded-rect; PNG assets only at 44pt height (iOS default/recommended button height) — vectors otherwise.

**iOS vs macOS.** Same rules; white-outline style is iOS/macOS/web (not tvOS/watchOS). watchOS uses dark-grey fill, irrelevant here.

**Reviewer checks.** SIWA button smaller than Google/Facebook buttons or below fold → flag. Black button on dark background / outline button on dark → flag. Custom Apple logo or recoloured logo → hard flag. Title text other than the three approved strings → flag. Password field in a SIWA flow, or "enter your real email" after relay → hard flag.

**Stale corrections.** Settings path now "Settings > **Apple Account** > …" — "Apple ID" was renamed **Apple Account** in 2024; models still saying "Apple ID" are out of date. Also remember the App Review rule (guideline 4.8): apps with third-party sign-in must offer a privacy-equivalent option (SIWA qualifies) — policy context, not HIG text.

---

## Machine learning

**URL:** https://developer.apple.com/design/human-interface-guidelines/machine-learning
**Platforms:** all. **Updated 2026-06-08** (minor clarity edits this week).

**Purpose.** Design framework for ML-powered features (non-generative): how to characterize the feature's role and apply UX patterns for data in/out. Essentially 100% judgment heuristics, zero numeric specs. Apple's canonical examples: Face ID, QuickType, Siri Suggestions, Photos auto-crop, News suggestions.

**The role framework (use to classify any AI feature before reviewing it).** Five axes:
1. **Critical or complementary** — can the app work without it? Critical ⇒ accuracy/reliability bar is much higher.
2. **Private or public data** — more sensitive data ⇒ worse consequences for errors; privacy always mandatory.
3. **Proactive or reactive** — proactive (unrequested) results get far less tolerance for being wrong; raise the quality bar and the data requirements.
4. **Visible or invisible** — invisible features can't easily communicate reliability or collect feedback.
5. **Dynamic or static** improvement — dynamic ⇒ needs calibration/feedback loops in the UI.

**Pattern rules (condensed dos/don'ts).**
- *Explicit feedback:* request only when necessary; always voluntary; options must state consequences in plain language ("Suggest less pop music", "Mute politics for a week" — never bare "dislike"); act immediately and persist; icons may accompany text, never replace it.
- *Implicit feedback:* favoriting/social reactions ARE implicit (they serve the user's goals, not your questionnaire); secure it; disclose cross-app flows; don't let it kill exploration (filter-bubble warning); combine multiple signals; withhold private/sensitive suggestions (shared devices!); **prioritize recent feedback**; update predictions on the cadence of the user's mental model (typing = instant; song recs = not continuous); expect UI changes to shift the feedback signal; beware confirmation bias.
- *Calibration:* only when the feature can't work without it (Face ID); explain value (what it does, not how it works); collect the minimum; once only, early; quick and easy; explicit goal + progress (Face ID tick marks); immediate help when stalled, never blame the user; confirm success; cancellable anytime without judgment; let people edit/delete calibration data later.
- *Mistakes:* anticipate; match corrective tools to consequence severity (bad keyboard suggestion ≠ missed flight); make frequent/predictable mistakes easy to correct; be extra careful in proactive features; don't magnify mistakes with wrong attributions.
- *Corrections:* familiar, in-UI mechanisms (Photos auto-crop exposes the same crop controls); instant value + persistence; corrections of corrections; **prefer guided corrections (pick from alternatives) over freeform**; never use corrections to excuse low-quality output.
- *Multiple options:* prefer diverse options (Maps' no-tolls/scenic/highway routes); not too many (one screen, no scrolling); most likely first, optionally preselected; make options distinguishable (describe differences); learn from selections.
- *Confidence:* verify confidence correlates with quality before surfacing it; translate to human concepts — "Because you listen to pop music" beats "97% match"; semantic buckets ("high chance/low chance") or ranking instead of raw numbers; numeric confidence only where users expect statistics (weather, sports, polls); actionable phrasing ("This is a good time to buy"); change presentation by threshold (Photos asks for confirmation at low face-recognition confidence); **set a floor below which you show nothing**, especially for proactive features.
- *Attribution:* expresses the basis for a result ("Because you've read mysteries"); factual and objective, never emotional ("Because you've read nonfiction", NOT "Because you love nonfiction"); not too specific (creepy) or too general (useless); no jargon.
- *Limitations:* set expectations up front for rare-but-serious limits; demonstrate how to get good results (placeholder text à la Photos search "Photos, People, Places…", live coaching à la Memoji lighting hints, suggest alternatives instead of empty results); explain poor results; consider announcing when limitations are fixed.

**iOS vs macOS.** None — explicitly "No additional considerations" for any platform.

**Reviewer checks (rubric, not checklist).** For any AI-ish feature in a design: Which of the 5 roles is it? Proactive + low-confidence + visible ⇒ where's the suppression threshold? Is feedback voluntary and consequence-labelled? Is there a correction path with the same controls the automation used? Are confidences raw percentages (flag) or actionable language? Does the empty/failed state coach the user?

**Stale corrections.** Page now opens by deferring generative cases to the separate **Generative AI** page (2025) — older models conflate the two. Examples updated to current systems (Image Playground). Otherwise this page's heuristics predate and survived the LLM era — they're Apple's 2019 "ML design patterns" matured, still current as of this week's edit.

---

## Generative AI

**URL:** https://developer.apple.com/design/human-interface-guidelines/generative-ai
**Platforms:** all. **New page 2025-06-09; updated 2026-06-08 (this week):** added guidance for letting people refine results and providing feedback during generation; updated model-type choice guidance.

**Purpose.** Design rules for features that create/transform content with generative models (text, images, game dialog). Complements (doesn't replace) Machine learning.

**Normative rules.**
- *Responsibility & control:* design for real-world variance (same input ⇒ different outputs); people stay in charge — honor in-scope requests, allow **dismiss / revert / retry**; **clearly identify when and where you use AI**.
- *Inclusion:* models favor common data ⇒ stereotype risk; **ask for personal/cultural characteristics rather than inferring them** (e.g. when generating images of people); test with diverse users.
- *Fit:* offer generative features only where they bring specific value; **provide a non-AI fallback where possible** (Genmoji vs regular emoji; summaries vs reading notifications); the app must still work when AI is unavailable or declined.
- *Transparency:* **never trick people into thinking AI output is human-authored**; align disclosure with regional regulations; set capability/limitation expectations up front (brief tutorial, curated starter suggestions for open-ended prompts).
- *Privacy / model choice (updated this week):* **on-device models** = private, fast, offline; **server-based** = more capable — weigh privacy alongside capability; process locally where possible, minimize what's shared, disclose what goes to servers and whether it trains the model; permission before using personal info; opt-out always available; kids' apps have stricter rules; note **Foundation Models framework requires a compatible device with Apple Intelligence turned on** (capability-gating is a design constraint).
- *Datasets:* know provenance, license everything, allow time to test for bias/misinformation.
- *Inputs:* offer **diverse predefined example prompts**; communicate that output may contain errors; scope requests to minimize hallucination — don't request factual info unless the model verifiably has it; never use generated content where a hallucination could harm; **confirmation before significant/irreversible actions** (no auto-deleting photos, no autonomous purchases).
- *Outputs (updated this week):* put **Edit / Undo / Retry / Adjust controls near generated content**; acknowledge corrections visibly; on blocked/poor output, coach better requests (Image Playground: "Unable to use that description") and suggest examples; red-team your own feature (out-of-scope, vague, sensitive, adversarial prompts); avoid replicating copyrighted content (curated prompts, style exclusions); design for latency — generative ≠ real-time: loading experience or background generation; **status messages must be specific** ("Summarizing key themes from your notes", not "Processing…"); consider offering multiple meaningfully different results.
- *Continuous improvement:* voluntary feedback, non-interruptive placement, **thumbs-up/down plus optional detailed channel**; decouple model from UX so models can be swapped; plan retesting/prompt-engineering per base-model upgrade.

**iOS vs macOS.** None — "No additional considerations" on all platforms.

**Reviewer checks.** Any generated content surface: is AI use labelled? Are Edit/Undo/Retry adjacent? Is there a confirm step before destructive/purchasing actions? Loading state specific or generic? Example prompts for open-ended inputs? Feedback affordance present but unobtrusive? Non-AI path available?

**Stale corrections.** This page **didn't exist before June 2025** — a pre-2025 model has no knowledge of Apple's official generative-AI design stance, the Foundation Models framework (on-device Apple Intelligence LLM, WWDC 2025), or Acceptable Use Requirements for it. The 2026-06-08 update (refine-during-generation, model-type guidance) is days old; expect models to be unaware. "Apple Intelligence" branding (2024) post-dates many models' priors about "Siri intelligence".

---

## Other Technologies pages — triage (abstract-level only, not deep-read)

These remain iOS/macOS-relevant but are niche for a designer's day-to-day; the skill should know they exist and fetch the JSON when one becomes relevant. Slug → platforms → one-liner (+ alert if 2025-26):

- `airplay` (all) — wireless media streaming UX; standard system AirPlay UI, route pickers.
- `always-on` (ios, watchos) — Always-On display states; iPhone Lock Screen/StandBy reduced-luminance rendering. Relevant to widget/Live Activity contrast rules above.
- `apple-pay` (ios, ipados, macos, visionos, watchos; **updated 2026-06-08** "latest Apple Pay appearance and capabilities") — payment-sheet and Apple Pay button brand rules (button specs comparable in strictness to SIWA's). High App-Review stakes; deep-read before any checkout design.
- `augmented-reality` (ios, ipados, visionos) — AR session UX, coaching overlays.
- `carekit` / `researchkit` / `healthkit` (ios, ipados[, watchos]) — health-data UX, consent, care plans.
- `carplay` (ios) — car UI; mostly template-driven; Live Activities/widgets guidance above covers the dashboard overlap.
- `game-center` (all; updated 2025-06-09 — Apple Games app, Game Overlay, challenges; activity preview image specs).
- `homekit` (all) — home accessory naming + Siri/Home app integration.
- `id-verifier` (ios) — reading mobile IDs in person.
- `imessage-apps-and-stickers` (ios, ipados) — sticker sizes and iMessage app UX.
- `in-app-purchase` (all) — purchase/subscription UX, offer codes, restore purchases placement.
- `live-photos` (ios, ipados, macos, tvos, visionos) — playback affordances, badge usage, never strip motion silently.
- `maps` (all; updated 2024-12-18, place cards) — MapKit display etiquette, annotation design.
- `nfc` (ios, ipados) — scanning UX phrasing ("Hold your iPhone near…").
- `photo-editing` (ios, ipados, macos) — Photos extension behaviour (non-destructive edits).
- `shareplay` (ios, ipados, macos, tvos, visionos) — shared-activity session UX; group activities naming.
- `shazamkit` (all) — audio matching UX.
- `siri` (all; **updated 2026-06-08 "Revised for Siri AI"**) — likely substantially new content post-WWDC-2026; deep-read required before designing any voice/assistant integration. Pairs with App Intents/App Shortcuts (covered elsewhere: `app-shortcuts` updated 2026-06-08 with "app schemas").
- `tap-to-pay-on-iphone` (ios; updated 2025-01-17) — merchant-side contactless UX + brand marks.
- `wallet` (ios, ipados, macos, visionos, watchos; **updated 2026-06-08 for iOS 27 and the new Pass Designer app**) — pass design with exact image dimension specs. Note: alert text confirms "**iOS 27**" naming.

---

## Cross-page synthesis for skill design

1. **This bucket contains the HIG's only explicit cross-platform translation table** (Mac Catalyst): tab bar→sidebar, bottom-edge buttons→toolbar, popover→inline inspector, 17pt→13pt body (77% scale), every command→menu bar + shortcut, every object→context menu. Reusable as a generic "port iOS design to macOS" checklist even outside Catalyst.
2. **Spec density is bimodal.** Widgets/Live Activities/App Clips/SIWA are numbers-and-hard-rules (dimension tables, 16/11/14pt margins, 11pt min font, 2s animation cap, 8h/4h/15–30min lifecycle numbers, 140×30pt buttons, 30/56-char copy limits); platform pages and ML/GenAI are pure judgment. A reviewer skill needs both a lookup-table mode and a rubric mode.
3. **System-experience surfaces (widgets, Live Activities) are where stale model knowledge is most dangerous**: interactivity, tinted/clear Liquid Glass appearances, macOS desktop widgets, Mac menu-bar Live Activities, StandBy/CarPlay are all 2023–2025 additions; a model with 2023 priors will produce designs that miss required rendering modes entirely.
4. **Design-once-adapt-everywhere is Apple's prescribed workflow** for these surfaces ("Start with the iPhone design, then refine for other contexts") — the skill should mirror that ordering rather than treating each platform as a fresh start.
5. **Brand-compliance rules (SIWA buttons, App Clip Codes, and by extension Apple Pay buttons) are App-Review-enforced** — a reviewer should classify violations as blockers, distinct from advisory HIG style guidance.
6. **AI guidance is platform-uniform and current to this week** — generative-ai and machine-learning both carry 2026-06-08 alerts and explicit "No additional platform considerations". Reviewing AI features needs no iOS/macOS forking, but DOES need the role framework (critical/complementary, proactive/reactive…) as a triage step.
7. **Terminology currency traps**: "Apple Account" (not "Apple ID"), iOS 26/27 + macOS Tahoe 26 (not 18/19/15), "Apple Intelligence", "Foundation Models framework", "Liquid Glass", "clear appearance", "accented/vibrant rendering modes", "iPhone Air", "Pass Designer". Using old terms in generated copy is itself a detectable defect.
