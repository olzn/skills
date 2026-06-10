<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: tab-bars, sidebars, search-fields, token-fields, path-controls, toolbars -->

## navigation-bars
<!-- src: toolbars · changed: 2025-06-09 · platforms: iOS, iPadOS · speed: stub -->
**This page no longer exists**: `navigation-bars` 301-redirects to `toolbars` (since 2025-06-09; verified 2026-06-10). The iOS top bar is a toolbar — "In iOS, a navigation-specific toolbar is sometimes called a navigation bar." Full guidance: components-menus-actions.md `## toolbars`. Designs or skills treating the navigation bar as a distinct component are using pre-Liquid-Glass vocabulary.

## tab-bars
<!-- src: tab-bars · changed: 2026-06-08 · platforms: iOS, iPadOS, macOS · speed: full -->
Top-level navigation between app sections; preserves each section's navigation state.

Rules:
- **Navigation only, never actions** — controls that act on the current view belong in a toolbar.
- Keep the tab bar **visible on every section**; only modal views may cover it.
- Fewer tabs are easier; for complex structures consider a sidebar, or a tab bar that adapts to one.
- **Avoid overflow**: when tabs don't fit, the trailing tab becomes a **More tab** (iOS/iPadOS) — limit scenarios that trigger it.
- **Never disable or hide a tab**, even when its content is unavailable — explain the empty section instead.
- **Label every tab**, single words wherever possible (label sits beneath the icon in compact views, beside it in regular).
- Prefer **filled SF Symbol variants** for tab icons; custom icon dimensions per Apple Design Resources.
- Badges: red oval, white text (number or exclamation point); **critical information only**.
- Avoid tab colours similar to the content background; prefer the monochromatic appearance or a clearly differentiated accent.

iOS vs iPadOS vs macOS:
- **iOS:** the bar **floats above content at the bottom** on a Liquid Glass background — content peeks through beneath. Supports an attached **accessory** (Music's MiniPlayer) and opt-in **minimise-on-scroll** (`TabBarMinimizeBehavior` / `UITabBarController.MinimizeBehavior`): the accessory moves inline when minimised; tapping a tab or scrolling to top restores. May include a **dedicated search tab at the trailing end** (see search-fields).
- **iPadOS:** the tab bar sits **near the top** — fixed (`tabBarOnly`) or sidebar-convertible (`sidebarAdaptable`). "Prefer a tab bar for navigation" on iPad; sidebar-only apps use `NavigationSplitView`, not a tab view. If user-customisable (`TabViewCustomization`, `UITab.Placement`), **default to five or fewer tabs** so compact and regular layouts stay continuous.
- **macOS:** supported with "No additional considerations" — the SwiftUI `TabView`/`sidebarAdaptable` model now spans macOS. (Safari-style window tabs are the separate Tab views page.)

Checks: action verbs in tabs (Compose, Share, Add) · bar missing on inner non-modal screens · dimmed or hidden tabs — violations; opaque edge-pinned bottom bar on iOS → flag (expect floating bar, content visible beneath); unlabelled tabs, multi-word labels, outline icons → flag; >5 visible tabs on iPhone → flag (More-tab risk); non-critical or non-red badge → flag; iPad mock with a bottom tab bar → stale; tab accent similar to content background → flag.

Corrections:
- Was: translucent rectangle pinned full-width to the bottom → Now: floats on Liquid Glass; minimises on scroll; carries accessories (since 2025-07-28).
- Was: iPad tab bar at the bottom → Now: top of screen, sidebar-adaptable (since iPadOS 18, 2024).
- Was: tab bars are iOS-only; Macs use sidebars/segmented controls → Now: available on macOS via SwiftUI (since 2025).
- Was: search lives in the navigation bar → Now: search can be a system-styled trailing tab (since 2025; terminology finalised 2026-06-08).

## sidebars
<!-- src: sidebars · changed: 2026-06-08 · platforms: iOS, iPadOS, macOS · speed: full -->
Leading-side navigation between app areas or top-level collections (folders, playlists). Sidebars need generous space — most apps shouldn't choose between sidebar and tab bar: use the **adaptable style that provides both**.

Rules:
- **Extend visually rich content beneath the sidebar**: sidebars float in the Liquid Glass layer; let content scroll under, or apply the **background extension effect** (`backgroundExtensionEffect()`) that mirrors adjacent content beneath it.
- **Maximum two levels of hierarchy**; deeper data → a split view with a content list between sidebar and detail. Label each top-level group succinctly.
- Use disclosure controls to group large content sets; let people customise which areas appear, and in what order.
- Prefer SF Symbols or custom symbols over bitmaps for item icons.
- **Icon colours (2026-06-08, verified live):** sidebar icons use the **app accent colour by default**; on macOS they must **follow the user-chosen system accent colour**; fixed colours only sparingly and purposefully (Mail's yellow VIP icon).
- Standard hide affordances: iPadOS = edge swipe; macOS = toolbar show/hide button **plus View > Show/Hide Sidebar**. **Avoid hiding the sidebar by default** (discoverability).

iOS vs macOS:
- iOS/iPadOS: sidebar via the `sidebarAdaptable` tab view style — both variations include a switch button and adapt to rotation/resizing; **consider a tab bar first** (the sidebar appearance suits overflow of less-frequent areas). Sidebar-only → `NavigationSplitView` / `UISplitViewController`; non-SwiftUI lists: `UICollectionLayoutListConfiguration.Appearance.sidebar`. Compact (iPhone) widths show a tab bar, not a sidebar.
- macOS: three sizes (small/medium/large — row height, text, and glyph follow) driven by the user's "sidebar icon size" in General settings — designs must tolerate all three. Consider auto-collapsing when the window shrinks (Mail). **Avoid critical info or actions at the bottom of a sidebar** (the bottom edge is often offscreen).

Checks: >2 hierarchy levels · hardcoded multicolour icons or broad fixed colours ignoring accent (esp. macOS system accent) · macOS sidebar without a show/hide affordance — violations; opaque full-height panel with a hard divider → flag (expect floating panel, content extending beneath); hidden by default → flag; critical buttons pinned to the macOS sidebar bottom → flag; sidebar at iPhone width → flag; bitmap glyphs → prefer symbols.

Corrections:
- Was: macOS sidebar = translucent "sidebar material" in opaque window chrome → Now: floats on Liquid Glass; the background extension effect fills the space behind (since 2025-06-09).
- Was: tab bar vs sidebar is an exclusive choice on iPad → Now: largely dissolved by the adaptable style (since 2024).
- Was: press story of monochrome (iOS 26) → coloured (iOS 27) sidebar icons → Now: no such narrative in the HIG; the rule is app accent colour by default + macOS system-accent compliance (since 2026-06-08). Don't hard-code icon colour treatments.

> **27 beta delta (promote on GA):** WWDC26 press (2026-06-08) reports macOS 27 sidebars extend edge-to-edge with refraction continuing beneath. Press-sourced; not in the live HIG as of 2026-06-10 — not doctrine.

## search-fields
<!-- src: search-fields · changed: 2026-06-08 · platforms: all · speed: full -->
Anatomy: **search icon, clear button, placeholder text** — plus scope bars and search tokens. The page governs *where the search entry point lives* per platform. macOS sibling component: token-fields.

Rules:
- Placeholder text reinforces scope and teaches what's searchable.
- **Start search as the person types** where possible; show **recent searches before typing** and predictive suggestions while typing; most relevant results first; let people filter results.
- **Scope bar**: for clearly defined categories; **default to the broader scope** and let people narrow.
- **Token**: a search term encapsulated as a selectable, editable single item acting as a filter (a contact in Mail). Pair tokens with suggestions so people discover them.

iOS placements (three):
1. **As a tab** — two sanctioned styles, current and co-equal (terminology finalised 2026-06-08): **standard tab** (uniform with the other tabs; opens a search landing page — choose for discovery/exploration, e.g. Apple TV) vs **button appearance** (distinct button at the trailing end; focuses the field and raises the keyboard immediately — choose for fast find-and-go; returns to the previous tab on exit). Never mix the two styles' behaviours.
2. **In a toolbar** — **prefer the bottom for reachability** (Settings, Mail, Notes); top toolbar when bottom content must stay clear (Wallet) or there is no bottom bar.
3. **Inline with content** — when adjacency clarifies local scope (Music library filter vs the Search tab); position **above the list it searches**; consider pinning to the top toolbar on scroll.

iPadOS + macOS (explicitly consolidated — keep consistent across both):
- **Trailing side of the toolbar** is the default — especially split-view apps searching across columns (Mail, Notes, Freeform).
- **Top of the sidebar** when search filters the sidebar/navigation itself (Settings).
- **A sidebar or tab item** for a dedicated discovery area (Music, TV).
- In a dedicated search area, **auto-focus the field** — except on iPad with only the virtual keyboard (it would cover the view). On iPad the field resizes fluidly; in compact widths relocate search where useful (above the content-list column).

Checks: missing magnifier, clear button, or placeholder → flag; iOS site-wide search buried at the top of a long scroll → suggest bottom placement or a search tab; a search tab mixing the two styles → flag; macOS/iPad search leading or centre in the toolbar → flag (trailing is the convention); sidebar-filtering search not at the sidebar top → flag; dedicated area not auto-focused (desktop) or force-focused (touch-only iPad) → flag; no live results, suggestions, or recents → flag; scope bar defaulting narrow → flag; chip-style filters not selectable/editable as units → flag.

Corrections:
- Was: iOS search = `UISearchController` pinned under a large title in the navigation bar → Now: bottom placement preferred for reachability; search-as-tab with two named styles (since 2025; refined 2026-06-08).
- Was: tokens are macOS-only (`NSTokenField`) → Now: search tokens exist on iOS inside search fields (since 2025).
- Was: press reported iOS 27 "re-integrates" the search tab → Now: no reversal in the HIG; standard tab and button appearance are co-equal current options (verified 2026-06-08).

## token-fields
<!-- src: token-fields · changed: stable · platforms: macOS · speed: stub -->
macOS-only (`NSTokenField`): typed text converts to draggable, selectable tokens. Default conversion trigger is the **comma** (more triggers addable, e.g. Return). Suggestions appear immediately by default — lengthen the delay if that distracts. **Add value with a context menu on tokens** (Mail recipient: edit name, mark VIP, contact card). Tokens select, drag to reorder, and move between fields — chips that can't are not tokens. iOS-side tokens live in search fields only. Fetch for detail: token-fields.

## path-controls
<!-- src: path-controls · changed: stable · platforms: macOS · speed: stub -->
macOS-only: shows the file-system path of the selection (Finder's View > Show Path Bar), or the window's folder when nothing is selected. **Lives in the window body — never the toolbar, title bar, or a status bar.** On iOS designs, a Finder-style path control is itself a flag: use navigation hierarchy instead. Fetch for detail: path-controls.
