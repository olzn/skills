<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: designing-for-ios, designing-for-macos, designing-for-ipados, mac-catalyst, design-principles -->

# Platforms — device character and porting

Apple's principle for multi-platform work: "Approach every platform with intention. Your software should feel polished and at home wherever it runs" — a straight port of one platform's idioms onto another is a principle violation, citable as such; "Maintain your craft / keep your interface current" is the Apple-sanctioned basis for flagging pre-Liquid-Glass conventions as craft violations, not taste. <!-- src: design-principles -->

## designing-for-ios
<!-- src: designing-for-ios · changed: stable (no 2025–26 alert) · platforms: iOS · speed: full -->
The iPhone device character — the assumptions every iOS design decision rests on. Numeric rules live in Layout/Typography pages.
**Device characteristics (Apple's framing).** Medium-size high-resolution display · held in one or both hands, portrait/landscape, viewing distance "no more than a foot or two" · inputs: Multi-Touch gestures, virtual keyboards, voice, gyro/accelerometer, personal data, spatial interactions · usage: bursts (1–2 min) AND long sessions (1 h+), frequent app switching is normal.
**System features apps should integrate:** Widgets, Home Screen quick actions, Spotlight, Shortcuts, Activity views.
**Best practices.**
1. Limit onscreen controls; make secondary details/actions discoverable with minimal interaction (progressive disclosure over toolbar clutter).
2. Adapt seamlessly to orientation, Dark Mode, Dynamic Type — user choices, not edge cases.
3. Key controls where hands reach: **middle or bottom of the display**. "Especially important": support **swipe-to-go-back** and swipe actions on list rows.
4. With permission, use platform capabilities to avoid manual data entry (Apple Pay, biometric auth, location).
**Reviewer checks.** Primary actions in the bottom half? Critical control pinned top-left that's used constantly → flag. Screen exposing everything at once instead of leaning on menus/swipes → flag. Light + dark variants present; type in Dynamic Type styles, not fixed px? Full-width horizontal carousels blocking the back swipe → flag. Asking users to type what the platform can supply (address, payment, login) → flag.
**Was → Now.** iOS 18/19 ≠ current: iOS jumped 18 → **26** (June 2025, Liquid Glass); WWDC 2026 brought the iOS 27 generation. The page itself is stable, but everything it links to (layout, Materials, toolbars) was rewritten for Liquid Glass — flat, opaque-bar iOS 7–18 aesthetics are no longer the system look.

## designing-for-macos
<!-- src: designing-for-macos · changed: stable (no 2025–26 alert) · platforms: macOS · speed: full -->
The Mac device character — the contrast document to designing-for-ios.
**Device characteristics.** Large high-resolution display, often multiple (incl. iPad via Sidecar) · stationary, viewing distance **1–3 feet** · inputs: physical keyboards, pointing devices, game controls, Siri — any combination · usage: minutes-to-hours of deep concentration, many apps open, smooth active/inactive transitions expected.
**System features apps should integrate:** the menu bar, file management, going full screen, Dock menus.
**Best practices.**
1. Use the large display to show **more content in fewer nested levels with less modality** — density kept comfortable.
2. Windows: resizable, hideable, movable; support full-screen mode.
3. **The menu bar carries ALL the commands** people need in the app — not a subset.
4. Support high-precision input (pixel-perfect selection/editing).
5. Handle **keyboard shortcuts** and keyboard-only work styles.
6. Support **personalisation**: customisable toolbars, configurable window views, user-chosen colours and fonts.
**The structural contrast (synthesis of both pages).**

| Dimension | iOS | macOS |
|---|---|---|
| Viewing distance | ≤1–2 ft | 1–3 ft |
| Reach priority | bottom/middle of screen | none — top-down flow, important things at top |
| Command surface | in-UI controls, gestures | menu bar (exhaustive) + toolbar + context menus |
| Navigation depth | drill-down acceptable | flatter, fewer nested levels, less modality |
| Keyboard | virtual, optional | physical, primary; shortcuts mandatory |
| Personalisation | system-level (Dark Mode, Dynamic Type) | also app-level (toolbars, fonts, window layouts) |
| Session shape | bursts + long sessions, heavy switching | long sessions, many apps concurrently |

**Reviewer checks.** Bottom tab bar or hamburger menu in a Mac design → wrong idiom (sidebar/menu bar). Every visible action has a plausible menu-bar home + keyboard shortcut? Content forced into a phone-width column on a wide window → violates "more content, fewer levels". Modal sheet where a Mac shows an inline panel or second window → flag. Toolbar a bespoke fixed strip rather than customisable standard items → flag.
**Was → Now.** Sonoma/Sequoia (14/15) ≠ current: **macOS Tahoe 26** (2025), 2026 successor at WWDC26. macOS 26 adopted **Liquid Glass** — translucent toolbars/sidebars, concentric corner radii, layered app icons; macOS and iOS share one design language while keeping separate interaction idioms.

## designing-for-ipados
<!-- src: designing-for-ipados · changed: stable · platforms: iPadOS · speed: stub -->
iPad sits between iPhone and Mac: large display + touch + optional keyboard/trackpad/Apple Pencil. Matters here because (a) adaptive iOS layouts must scale to iPad size classes and (b) Catalyst ports start from the iPad app.
- Viewing distance ~3 ft; people combine touch + keyboard + Pencil in one session.
- Elevate content; **minimise modal interfaces and full-screen transitions**; controls reachable "but not in the way".
- Adapt to orientation, multitasking (Split View, Slide Over, resizable windows since iPadOS 26), Dark Mode, Dynamic Type — and "transition effortlessly to running in macOS". iPadOS 26 also gained a **menu bar** (see `the-menu-bar`) — iPad keeps converging toward Mac conventions.
- Adaptive check for any iOS design: at regular width, does the single column become split view/multi-column, or just stretch?
Fetch for detail: designing-for-ipados

## mac-catalyst
<!-- src: mac-catalyst · changed: 2023-05-02 · platforms: iPadOS, macOS · speed: full -->
Turning an iPad app into a Mac app — and in practice the HIG's only explicit **iOS→macOS translation table**, reusable for any cross-platform port even outside Catalyst.
**Suitability.** Good candidates already support drag and drop, keyboard navigation + shortcuts, multitasking, multiple windows (scenes). Unsuitable if essential features need gyro/accelerometer/rear camera, HealthKit/ARKit, or are primarily marking/handwriting/navigation.
**Idiom choice (exact numbers).**
- Default "Scale Interface to Match iPad" (**iPad idiom**): renders at **77%** on macOS; iPadOS 17 pt body becomes **13 pt** — the native macOS body baseline.
- **Mac idiom**: 100% rendering, more Mac-like controls, better graphics performance — requires a full layout audit; use text styles (not fixed sizes) or text renders too large; consider a separate asset catalog; appearance customisations limited to what macOS controls support.
**Navigation translation.**
- iPad **tab bar → macOS sidebar (split view) or segmented control**; sidebar preferred, segmented control only for genuinely flat hierarchies. Keep tab-level destinations in the macOS **View menu** regardless.
- Add **Next/Previous buttons** alongside swipe gestures for paging. iPad split views (primary/supplementary/content) map naturally to Mac.
**Input translation (automatic).** tap→click; touch-and-hold→click-and-hold; pan→click-drag; pinch/rotate→trackpad pinch/rotate (delivered to the view under the pointer).
**Layout translation.**
- Adopt **top-down flow**: most important actions/content near the top of the window.
- **Relocate buttons from side and bottom edges** to the toolbar — the reach rationale doesn't apply on Mac.
- Split single columns into multiple; show an **inspector next to content instead of a popover**; reflow side-by-side on resize (regular-width/regular-height size classes).
- Primary controls go in the window toolbar AND their commands in menu-bar menus.
**Menus.** Mac users expect **every object to have a context menu** and **all commands in the menu bar** (Apple: "contextual menu" is the traditional Mac term).
**Reviewer checks (generic iOS↔macOS port review).** Tab bar surviving into the Mac design · buttons hugging bottom/side window edges · popover used as a persistent inspector · body text speced at 17 pt on Mac (native is 13 pt) · content objects without context menus · toolbar control without a menu-bar command → flag.
**Was → Now.** Page stable (2023), but: Apple's current strategic path is SwiftUI multiplatform, Catalyst still documented — the translation rules remain valid design guidance either way. The icon advice here ("lifelike rendering style") is superseded by the 2025-06-09 `app-icons` Liquid Glass layered-icon system — follow the newer page for icon construction.
