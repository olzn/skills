<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: toolbars, buttons, menus, the-menu-bar, context-menus, edit-menus, pop-up-buttons, pull-down-buttons, activity-views, dock-menus, home-screen-quick-actions -->

## toolbars
<!-- src: toolbars · changed: 2025-12-16 · platforms: all · speed: full -->
**Absorbs the former Navigation bars page**: `navigation-bars` 301-redirects to `toolbars` (since 2025-06-09; verified 2026-06-10). "In iOS, a navigation-specific toolbar is sometimes called a navigation bar" — not a distinct component. Holds: view title · navigation controls + search fields · actions. Toolbars act on content; tab bars navigate.

Rules:
- **Reduce toolbar backgrounds and tinted controls** (Liquid Glass core rule); separate bar from content with a **scroll edge effect** (`ScrollEdgeEffectStyle`), never a fill or hairline. Default **monochromatic** items; avoid item colours similar to the content behind.
- Control corner radii in bars: **concentric with the bar's corners**, custom components included.
- **Borderless SF Symbols** for actions — no outlined-circle icons; text labels only where symbols fail (Edit).
- Exactly **one `.prominent` action** (Done, Submit), on the **trailing** edge.
- **Max three groups**, consistent across platforms: **leading** (back control, sidebar toggle, title, optional document menu — not customisable) · **centre** (common controls; user-customisable on macOS/iPadOS; **auto-collapses into the system overflow menu** — never hand-build overflow) · **trailing** (always visible: inspectors, search field, More menu, primary action; More only if needed).
- Fixed space between adjacent text-labelled items (`UIBarButtonItem.SystemItem.fixedSpace`).
- Title every window, **under 15 characters**, never the app name; may stay empty when redundant.
- **Standard Back/Close symbols, never the words "Back" or "Close"**; custom versions behave identically app-wide.

iOS vs macOS: iOS — essentials only, rest to More; large title transitions to standard on scroll (`prefersLargeTitles`). iPadOS — toolbar and tab bar can coexist at the top. macOS — toolbar lives in the window frame; items have **no bezel**; **every toolbar item must also exist as a menu bar command**.

Checks: bar fills/tints · text "Back"/"Close" · multiple or non-trailing prominent · bordered icons · >3 groups · hand-built overflow · macOS toolbar-only commands · bad titles — violations; non-concentric radii → flag.

Corrections: Was: opaque edge-pinned bars, hairline separation → Now: floating Liquid Glass capsules; content scrolls beneath; scroll edge effect (since 2025-06-09). Was: bordered bar-button styles → Now: borderless + one `.prominent` (since 2025-06-09).

> **27 beta delta (promote on GA):** WWDC26 press (2026-06-08) reports a uniform frosted toolbar across app tops in macOS 27. Not in the live HIG as of 2026-06-10 — not doctrine.

## buttons
<!-- src: buttons · changed: 2025-12-16 · platforms: all · speed: stub -->
**Style + Content + Role** model — the UIKit filled/gray/tinted/plain + small/medium/large vocabulary is gone (since 2025-06-09). Non-obvious rules: hit region **at least 44x44 pt** for any input method (authoritative home of this number); custom buttons always include a **press state**; **one or two prominent buttons per view, max**; **style, not size, distinguishes the preferred choice**; text labels **title-style capitalisation**, verb-led ("Add to Cart"). Roles: Normal · **Primary** (the default button; responds to **Return**) · Cancel · **Destructive** (system red) — **never make a destructive action primary**. iOS/iPadOS: buttons may show an **activity indicator** with an alternative label ("Checking out…"). macOS-only types: **push button** (**trailing "…" when it opens another window/view/app**) · **square/gradient** (symbols only — never text, never in bars) · **help button** (system-provided; **max one per window**; lower corner opposite any dismissal buttons) · **image button** (~**10 px** image-to-clickable-edge padding; label below). Fetch for detail: buttons.

## menus
<!-- src: menus · changed: 2026-06-08 · platforms: all · speed: full -->
Umbrella rules for every menu, inherited by all menu components and the menu bar.

Rules:
- Labels: verb or verb phrase, **title-style capitalisation**, **no articles** ("View Settings").
- **Dim unavailable items, never remove them**; an all-unavailable menu stays openable (learnability). Context menus invert this.
- **Append "…"** when an action needs more input before completing; never on immediate actions.
- Icons (2025-07/2026-06 rules): **standard icons** for common actions (Share, Print, Search); sparing and purposeful; never an unclear icon; **within one separator group — icons on all items or none**.
- Important/frequent items first; group with separators; keep logical relatives together (Paste and Match Style with Cut/Copy/Paste); split long menus — user-defined/dynamic menus may scroll.
- Submenus: **sparing**; consider one when a term repeats in more than two items of a group (repeated term = submenu label); **single level only**; **beyond ~5 items, consider a new menu**; stay enabled when all children are unavailable; **prefer a submenu over indentation**.
- Toggled items: prefer one changing label (Show Map ⇄ Hide Map); add a verb when ambiguous; checkmark marks attributes in effect.

iOS vs macOS: iOS/iPadOS layouts (`preferredElementSize`) — **small** = 4 icon-only top items, only for sets recognisable without labels; **medium** = 3 icon+label items for the most important actions; **large** (default) = list. macOS: menus may extend outside window bounds.

Checks: missing/superfluous "…" · mixed icon/no-icon within a group (2026 rule) · submenu ≥2 levels or >5 items · indentation as hierarchy · removed-not-dimmed items — violations; sentence case, articles, noun-only labels, or Show X + Hide X together → flag.

Corrections: Was: no menu-icon guidance → Now: sparing, purposeful, all-or-none per group (since 2025-07-28; refined 2026-06-08). Was: dim-vs-hide by feel → Now: regular menus dim, context menus hide (since 2023-12-05).

## the-menu-bar
<!-- src: the-menu-bar · changed: 2025-06-09 · platforms: iPadOS, macOS · speed: full -->
**The menu bar exists on iPadOS too** (since 2025-06-09).

**Canonical order:** AppName → File → Edit → Format → View → [app-specific] → Window → Help; macOS adds the Apple menu (leading, unmodifiable) and menu bar extras (trailing). Always show the same menus; **disable, never hide**. Prefer one-word titles. **Every custom command belongs in the menu bar** (shortcuts + Full Keyboard Access).

**App menu** (bold app short name, **≤16 characters**): **About YourAppName** (first, alone in its group, no version number) → **Settings…** (app-level only; document settings go in File) → app-specific config items → Services (macOS) → Hide YourAppName · Hide Others · Show All (macOS) → **Quit YourAppName** (Option ⇒ Quit and Keep Windows).

**File:** New Item (name the type) · Open… · **Open Recent** (most recent first, real names never paths, Clear Menu) · Close (Option ⇒ Close All) · Close Tab (Option ⇒ Close Other Tabs) · Save (autosave; new docs prompt name+location) · Save All · **Duplicate** (Option ⇒ Save As; **prefer Duplicate over Save As/Export/Copy To**) · Rename… · Move To… · Export As… (only formats not normally handled) · Revert To · Page Setup… · Print…. No files handled → rename or drop File.

**Edit:** Undo / Redo (name the target: "Undo Typing") · Cut · Copy · Paste · Paste and Match Style · **Delete** (never "Erase"/"Clear" — must match the Delete key) · Select All · Find (submenu: Find, Find and Replace, Find Next/Previous, Use Selection for Find, Jump to Selection; may move to File when finding objects, not text) · Spelling and Grammar · Substitutions · Transformations · Speech (system adds Start Dictation, Emoji & Symbols).

**Format:** Font + Text submenus; omit without formatted-text editing.

**View:** window appearance only — **never window navigation/management**: Show/Hide Tab Bar · Show All Tabs · Show/Hide Toolbar · Customize Toolbar… · Show/Hide Sidebar · Enter/Exit Full Screen. Provide a View menu even for a subset; Show/Hide labels track state.

**App-specific menus:** between View and Window; mirror the app hierarchy, most → least general.

**Window:** Minimize (Option ⇒ Minimize All) · Zoom (**never for full screen**) · Show Previous/Next Tab · Move Tab to New Window · Merge All Windows · Enter/Exit Full Screen (**only when no View menu exists**) · Bring All to Front · open-window names (**alphabetical**, no panels/modals). Provide it even for one window.

**Help** (trailing): Send Feedback to Apple · YourAppName Help (Help Book gets automatic search) · few extras after a separator.

**Dynamic items:** modifier alternates (Option ⇒ Minimize All); never the only path; **single modifier** (`isAlternate`); menu bar menus only.

**Menu bar extras (macOS):** menu bar height **24 pt**; template-style icon (system recolours); **menu on click, never a popover**; user opt-in/out; system hides extras when space-constrained — **never the sole access point** (a Dock menu is always available).

iPadOS divergence: hidden until revealed (pointer to top edge / swipe down) · centred · no extras, no Apple menu · app menu lacks About, Services, Hide · window controls in the bar when full screen · YourAppName > Settings opens the app's page in iPadOS Settings · every function also reachable in the app UI · group into submenus more readily.

Checks (macOS): deviant order · About not first/alone · Settings without "…" · version in About · name >16 chars · "Clear"/"Erase" · full-screen in both View and Window · paths in Open Recent · unalphabetised window list or panels listed · toolbar-only commands · popover/non-template/sole-access extras · double-modifier dynamics — violations; top-level "Save As" → flag.

Corrections: Was: menu bars are Mac-only → Now: iPadOS has one (since 2025-06-09). Was: "Preferences…" → Now: **"Settings…"** (since macOS 13, 2022). Was: menu bar height 22 pt → Now: **24 pt**.

## context-menus
<!-- src: context-menus · changed: 2023-12-05 · platforms: iOS, iPadOS, macOS · speed: stub -->
**Hide unavailable items, don't dim** — the inverse of regular menus (macOS may dim Cut/Copy/Paste). Every item must also exist in the main UI. Few, most-likely items; ≤~3 separator groups; submenus one level; **no shortcut glyphs**. Frequent items nearest the invocation point (the menu may open above or below). iOS: destructive items last and red; an item gets a context menu OR an edit menu, never both; match a preview's clipping path to the content shape. Touch-and-hold / Control-click — 3D Touch is dead. Fetch for detail: context-menus.

## edit-menus
<!-- src: edit-menus · changed: 2023-06-21 · platforms: iOS, iPadOS, macOS · speed: stub -->
Prefer the system edit menu (`UIEditMenuInteraction`; the `UIMenuController` bubble died with iOS 16) and system reveal gestures. Offer only applicable commands (no Paste with an empty pasteboard). Make noneditable text selectable — never control labels. iPadOS is dual-style: touch reveal = horizontal bubble; pointer/keyboard = vertical context-menu style — design both. macOS has no floating bubble: editing commands live in the context menu and the Edit menu. Delete = Delete key; Cut = copy then delete. Fetch for detail: edit-menus.

## pop-up-buttons
<!-- src: pop-up-buttons · changed: 2023-10-24 · platforms: iOS, iPadOS, macOS · speed: stub -->
Menu of **mutually exclusive choices**; the button shows the current selection — provide a useful default and make options predictable without opening. Actions, multi-select, or submenus → pull-down button instead. iPadOS: prefer a pop-up over a disclosure push for small option sets; on iOS it replaces old picker-wheel habits. Fetch for detail: pop-up-buttons.

## pull-down-buttons
<!-- src: pull-down-buttons · changed: stable · platforms: iOS, iPadOS, macOS · speed: stub -->
Menu of **actions related to the button's purpose**; the label never changes to the chosen item (if it does → pop-up button: the distinguishing test). Worthwhile from ~**3 items**; 1–2 → plain controls. Never bury all primary actions in one pull-down, including a lone More (…) button. Destructive items: red; system confirms via action sheet (iOS) or popover (iPadOS). Icons: SF Symbols after the label. Fetch for detail: pull-down-buttons.

## activity-views
<!-- src: activity-views · changed: stable · platforms: iOS, iPadOS · speed: stub -->
The share sheet. **No macOS activity view** — Mac uses a Share toolbar button, Share in a context menu, or Finder quick actions. Reveal only from the standard Share button (`square.and.arrow.up`). Don't duplicate system actions (distinguish similar custom ones: "Print Transaction"); titles = single verb phrase, **never company/product names**; exclude inapplicable system tasks. Custom icons centred in ~**70x70 px**. Extensions: no stacked modals (alerts excepted); never notify just for completion. Fetch for detail: activity-views.

## dock-menus
<!-- src: dock-menus · changed: stable · platforms: macOS · speed: stub -->
Secondary-click menu on a Dock app icon. **Custom items must also exist in the menu bar or app.** Prefer high-value items: open/recent windows; actions useful when the app isn't frontmost (Mail: Get New Mail). iOS/iPadOS analogue: home-screen-quick-actions. Fetch for detail: dock-menus.

## home-screen-quick-actions
<!-- src: home-screen-quick-actions · changed: stable · platforms: iOS, iPadOS · speed: stub -->
App-icon long-press shortcuts (touch-and-hold; 3D Touch framing is legacy). People expect **at least one**; provide **at most four**. Titles state the result ("Directions Home"); no app name or marketing; short enough not to truncate. Icons: SF Symbols or the Quick Action Icon Template; **never an emoji** (glyphs are monochromatic). Dynamic actions change predictably. macOS analogue: dock-menus. Fetch for detail: home-screen-quick-actions.
