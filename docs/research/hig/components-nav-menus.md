# HIG research notes — Components: Navigation and search + Menus and actions

> Bucket: `components-nav-menus`. Researched 2026-06-10 from Apple's JSON content API (`https://developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`). Scope: iOS + macOS (iPadOS noted only where it clarifies adaptive behavior; tvOS/watchOS/visionOS omitted).
>
> **Headline structural fact:** the former **"Navigation bars" page no longer exists.** `navigation-bars` 301-redirects to `toolbars` (verified on both the data API and the public URL). Since 2025-06-09 the iOS top bar is just "a toolbar at the top of the screen"; the HIG says *"In iOS, a navigation-specific toolbar is sometimes called a navigation bar."* Any skill that talks about "navigation bars" as a distinct component is using pre-Liquid-Glass vocabulary.
>
> Pages in this bucket, by last-change date: search-fields / sidebars / tab-bars / menus (2026-06-08, WWDC26 week); buttons / toolbars (2025-12-16); the-menu-bar (2025-06-09); context-menus (2023-12-05); pop-up-buttons (2023-10-24); edit-menus (2023-06-21); activity-views, dock-menus, home-screen-quick-actions, path-controls, pull-down-buttons, token-fields (no recent alert).

---

## Toolbars (absorbs former "Navigation bars")

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/toolbars
**Platforms:** all. **Last change:** 2025-12-16 "Updated guidance for Liquid Glass." (2025-06-09: "incorporated navigation bar guidance", added item-grouping guidance.)

**Purpose.** Governs the bar(s) of controls along the top or bottom edge of a view: titles, navigation controls (back/forward, search fields), and actions ("bar items": buttons, menus). Explicit contrast: a toolbar acts on content and facilitates navigation/orientation; a **tab bar** is specifically for navigating between areas of an app.

**Normative rules.**
- Toolbar contains three content types: (1) title of current view, (2) navigation controls + search fields, (3) actions/bar items.
- *Choose items deliberately to avoid overcrowding.* Define which items move to the overflow menu as the toolbar narrows.
- **System adds the overflow menu automatically in macOS/iPadOS when items don't fit. Don't add an overflow menu manually**, and avoid layouts that overflow by default.
- *Add a More menu* only if really needed; prioritize less-important actions for it; try to fit all actions in the toolbar first.
- iPadOS/macOS: consider user **toolbar customization** (esp. apps with many items / advanced functionality / long usage sessions).
- **Liquid Glass core rule: reduce toolbar backgrounds and tinted controls.** Custom backgrounds/appearances interfere with system background effects. Let the content layer inform toolbar color; use a **scroll edge effect** (`ScrollEdgeEffectStyle`) when you need to distinguish bar from content.
- *Avoid similar colors on toolbar item labels and the content layer background*; if content is bright/colorful, prefer the default **monochromatic** toolbar appearance ("Liquid Glass color" guidance).
- *Prefer standard components*: standard buttons/text fields/headers/footers get corner radii **concentric with the bar's corners**; custom components must match this concentricity.
- Hiding toolbars for distraction-free viewing is OK contextually; always offer a reliable way to restore them (see Going full screen).
- **Titles:** title every window (helps orientation and differentiates multiple windows); the title area may be left empty if redundant (e.g., Notes single-window). **Don't title windows with the app name.** Keep the title **under 15 characters**.
- **Navigation:** the top toolbar moves people through a content hierarchy; often contains a search field. **Use the standard Back and Close buttons — prefer the standard symbols; don't use a text label that says "Back" or "Close".** Custom versions must look and behave the same, consistently app-wide.
- **Actions:** support main tasks; prefer simple recognizable **symbols rather than text**, except actions like Edit that symbols represent poorly (see "Standard icons" table on the Icons page). **Prefer system SF Symbols without borders** — no outlined-circle symbols; the toolbar section already provides the visible container and the system supplies hover/selection states.
- **Use the `.prominent` style for the key action (Done, Submit).** Only ONE prominent/primary action per toolbar, placed on the **trailing** side; it gets a tint and clear focal point.
- **Item groupings — three positions:** leading edge, center area, trailing edge.
  - *Leading edge:* back/previous-document control, show/hide-sidebar control, then the view title; optionally a document menu (Duplicate, Rename, Move, Export). **Leading-edge items are not customizable** (always available).
  - *Center area:* common controls; title may live here if not leading. In macOS/iPadOS this section is the user-customizable one, and its items **auto-collapse into the system overflow menu** as the window shrinks.
  - *Trailing edge:* important always-available items, inspector buttons, optional search field, the More menu, and the primary action (e.g., Done). **Trailing items remain visible at all window sizes.**
- Group items logically by function and frequency; group navigation controls and critical actions (Done, Close, Save) in dedicated, visually distinct sections; **keep groupings/placement consistent across platforms**; **aim for a maximum of three groups**.
- **Keep text-labeled actions separated** — adjacent text-label + symbol items read as one control; multiple adjacent text buttons run together. Insert fixed space (`UIBarButtonItem.SystemItem.fixedSpace`).

**iOS vs macOS.**
- iOS: space is scarce — only essential items in the main bar, rest into a More menu. **Large title** behavior: large title transitions to standard title on scroll, back to large at top (`prefersLargeTitles`) — used for orientation.
- iPadOS: a toolbar and a tab bar **can coexist in the same horizontal space at the top of the view**.
- macOS: toolbar lives in the **window frame** at the top, below or integrated with the title bar; window titles can display inline with controls; **toolbar items don't include a bezel**. **Every toolbar item must also be available as a menu bar command** (toolbar can be customized/hidden, so it can't be the sole access point); the reverse is not required.

**Reviewer checks.**
- Top bar labeled "navigation bar" as a separate component from toolbar → terminology stale (acceptable informally for iOS top toolbar only).
- Back/Close rendered as the words "Back"/"Close" instead of standard chevron / xmark symbols → violation.
- View/window title > 15 characters; window titled with the app name → violation.
- Custom toolbar background fill or heavily tinted bar controls → Liquid Glass violation; expect transparent bar region with content scrolling beneath + scroll edge effect.
- More than one prominent/tinted "primary" action in a bar; prominent action not on trailing edge → violation.
- Outlined/circle-bordered toolbar icons → violation (no borders; section supplies container).
- More than ~3 control groups; text-labeled buttons adjacent without fixed space; critical actions (Done/Save) mixed into generic groups → violations.
- macOS: command available only in the toolbar with no menu bar equivalent → violation. Toolbar items drawn with bezels → violation.
- Hand-built overflow ("»" or custom More for items that no longer fit) on macOS/iPadOS → violation (system-managed).
- HTML/Figma prototypes: check bar corner radii of contained controls are concentric with the bar shape.

**Stale-knowledge corrections.**
- "Navigation bars" as a component is gone (merged into Toolbars, 2025-06-09). UINavigationBar guidance (centered title rules, large-title-specific page) no longer exists separately.
- Old flat-design toolbars were opaque/translucent-blur attached bars; now toolbars float in the **Liquid Glass layer**, content scrolls beneath, and the separation cue is the scroll edge effect, not a bar background or hairline divider.
- Old guidance allowed/encouraged "bordered" bar button styles in some contexts; current rule is explicitly borderless symbols + one `.prominent` exception.
- Three-region grouping model (leading/center/trailing, with customizability rules per region) is new Liquid-Glass-era structure.

---

## Tab bars

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/tab-bars
**Platforms:** ios, ipados, macos, tvos, visionos (NOT watchOS). **Last change:** 2026-06-08 "Updated terminology and art." (2025-12-16 + 2025-07-28 Liquid Glass.)

**Purpose.** Top-level navigation between sections of an app; preserves each section's navigation state.

**Normative rules.**
- **Navigation only, never actions.** Controls that act on the current view belong in a toolbar.
- Keep the tab bar **visible on every section**; exception: modal views may cover it (modals are temporary/self-contained).
- Use the *appropriate number* of tabs; fewer is easier; for complex structures consider a **sidebar or a tab bar that adapts to a sidebar**.
- **Avoid overflow tabs.** If horizontal space limits visible tabs, the trailing tab becomes a **More tab** (iOS/iPadOS) revealing the rest in a list — limit scenarios where this happens.
- **Don't disable or hide tab bar buttons ever**, even when content is unavailable — explain why a section is empty instead.
- **Include tab labels**; single words whenever possible. Label appears beneath the icon in compact views, beside it in regular views.
- Prefer **SF Symbols, filled variants**, for tab icons ("Prefer filled symbols or icons for consistency with the platform"). Custom icon dimensions: see Apple Design Resources.
- **Badges**: red oval, white text, number or exclamation point; reserve for critical information only.
- *Avoid similar color on tab labels and content background*; prefer monochromatic tab bar appearance or a clearly differentiated accent (Liquid Glass color).

**iOS vs macOS (and iPadOS).**
- **iOS:** tab bar **floats above content at the bottom of the screen**; items rest on a **Liquid Glass background** that lets content peek through. Supports an **attached accessory** (e.g., Music's MiniPlayer); you can opt into **minimize-on-scroll** (`TabBarMinimizeBehavior` / `UITabBarController.MinimizeBehavior`) — tab bar minimizes and the accessory moves inline; exit by tapping a tab or scrolling to top. Tab bar can include a **dedicated search tab at the trailing end** (see Search fields).
- **iPadOS:** tab bar appears **near the top of the screen** — fixed (`tabBarOnly`) or convertible to a sidebar (`sidebarAdaptable`) via a button. For sidebar-only (no tab conversion) use `NavigationSplitView`, not a tab view. "Prefer a tab bar for navigation" on iPad; allow **tab bar customization** (users add/remove/reorder tabs; e.g., Music favorite playlists); if customizable, **default to five or fewer tabs** to preserve continuity between compact and regular sizes (`TabViewCustomization`, `UITab.Placement`).
- **macOS:** listed as supported with "No additional considerations" — i.e., the SwiftUI `TabView`/sidebarAdaptable model now spans macOS too, with no Mac-specific rules on this page. (Window tab bars — Safari-style document tabs — are the separate macOS "Tab views" page, different bucket.)
- (tvOS-only numeric specs exist — 68 pt bar height, 46 pt from top — out of scope.)

**Reviewer checks.**
- iOS mock with an opaque, screen-edge-attached bottom tab bar (old style) → flag; expect floating capsule-style bar on Liquid Glass with content visible beneath.
- Any action verbs in tabs (Compose, Share, Add) → violation: tabs navigate, never act.
- Tab bar disappearing on inner screens (non-modal) → violation.
- Tabs without labels; multi-word labels where one word works; outline-style icons instead of filled → flag.
- More than 5 visible tabs on iPhone (creates a More tab) → flag overflow risk.
- A dimmed/hidden tab → violation.
- Badge used for non-critical info (e.g., marketing) or non-red badge → flag.
- iPad mock with bottom tab bar → stale; expect top-positioned tab bar / adaptable sidebar.
- Accent color of tab items nearly matching content background hues → Liquid Glass color flag.

**Stale-knowledge corrections.**
- iOS tab bar is no longer a translucent rectangle pinned to the bottom edge — it floats on Liquid Glass and can **minimize on scroll** (pre-2025 models know "hide bars on scroll" only for navigation bars; the tab-bar minimize behavior + bottom accessory API is new).
- iPadOS tab bar moved to the **top** (since iPadOS 18, 2024) and gained the sidebar-adaptable style; old "bottom tab bar everywhere" assumption is wrong on iPad.
- Tab bars are now nominally available on macOS via SwiftUI; pre-2025 HIG said tab bars were iOS-only and Macs used sidebars/segmented controls.
- Search as a system-styled trailing tab is a 2025-2026 pattern (see Search fields).

---

## Sidebars

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/sidebars
**Platforms:** ios, ipados, macos, tvos, visionos (NOT watchOS). **Last change:** 2026-06-08 "Updated guidance for sidebar icon colors, and clarified guidance for the adaptable sidebar style."

**Purpose.** Leading-side navigation between app areas or top-level content collections (folders, playlists). Positions the sidebar against the tab bar tradeoff: sidebars need lots of vertical+horizontal space; many apps shouldn't choose — use the **adaptable tab-bar style that provides both**.

**Normative rules.**
- **Extend visually rich content beneath the sidebar** (iOS/iPadOS/macOS): sidebars float above content in the **Liquid Glass layer**; either let content scroll horizontally underneath or apply a **background extension effect** (`backgroundExtensionEffect()`) that mirrors adjacent content to appear stretched under the sidebar.
- Let people **customize sidebar contents** (which areas, what order) when possible.
- Use **disclosure controls** to group hierarchy when content is large.
- Prefer **SF Symbols / custom symbols** (not bitmaps) for sidebar item icons.
- Let people **hide the sidebar** using platform-standard interactions: iPadOS = edge swipe; macOS = show/hide toolbar button plus **View > Show/Hide Sidebar** menu commands. **Avoid hiding the sidebar by default** (discoverability).
- **Max two levels of hierarchy in a sidebar**; deeper data → use a split view with a content list between sidebar and detail.
- With two levels, give each group a succinct, descriptive label; omit unnecessary words.
- **Sidebar icon colors (2026-06-08):** by default sidebar icons use the **app accent color**; in macOS people can change the **system accent color**, which applies to all apps — your sidebar icons must follow the user's chosen color. Fixed colors only sparingly and purposefully (e.g., Mail's yellow VIP icon).

**iOS vs macOS.**
- iOS/iPadOS: sidebar via `sidebarAdaptable` tab view style — you choose whether app opens with sidebar or tab bar; both variations include a switch button; adapts to rotation/resizing automatically. Sidebar-only → `NavigationSplitView` / `UISplitViewController`. **"Consider using a tab bar first"** — sidebar appearance is for overflow of less-frequent areas. Non-SwiftUI: `UICollectionLayoutListConfiguration.Appearance.sidebar`.
- macOS: sidebar sizes **small, medium, large** — row height, text, and glyph size follow; user can override via "sidebar icon size" in **General settings** (so designs must tolerate all three). Consider auto-collapsing the sidebar when the window shrinks (e.g., Mail). **Avoid critical info/actions at the bottom of a sidebar** (windows often positioned so bottom edge is offscreen).

**Reviewer checks.**
- Sidebar drawn as an opaque full-height panel with a hard divider → flag; expect floating Liquid Glass panel with content extending/mirrored beneath.
- More than two hierarchy levels nested in a sidebar → violation.
- Sidebar icons in hardcoded multicolor, ignoring accent color; or fixed colors used broadly rather than sparingly → violation (esp. macOS system accent compliance).
- macOS sidebar lacking a Show/Hide affordance (toolbar button or View menu) → violation; hidden-by-default sidebar → flag.
- Critical buttons pinned to sidebar bottom on macOS → flag.
- iPhone-width layout showing a sidebar → flag (compact width should show tab bar; sidebar is regular-width).
- Bitmap glyphs in sidebar rows → prefer symbols.

**Stale-knowledge corrections.**
- Pre-2025: macOS sidebars used a translucent "sidebar material" baked into an opaque window chrome; now sidebars float on Liquid Glass and the new **background extension effect** is the sanctioned way to fill the space behind them.
- The "tab bar vs sidebar" choice on iPad is largely dissolved by the adaptable style (2024-2026); older guidance treated them as exclusive alternatives.
- 2026-06-08 accent-color rule (follow macOS system accent for sidebar icons) is newer than most model knowledge.

---

## Search fields (includes scope bars and search tokens)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/search-fields
**Platforms:** all. **Last change:** 2026-06-08 "Updated terminology and refined guidance for search as a tab in iOS."

**Purpose.** The editable field for searching a content collection — anatomy: **Search icon, Clear button, placeholder text**; plus scope bars and tokens for refining. Governs *where the search entry point lives* per platform.

**Normative rules.**
- Placeholder text reinforces search scope / educates about searchable content.
- **Start search immediately as the person types** when possible (live-refined results).
- Show **suggested search terms**: recent searches before typing, predictive suggestions while typing.
- Provide most relevant results first; consider categorizing results.
- Let people filter results (e.g., scope bar in results area).
- **Scope bar** = control for filtering/adjusting search scope. Use for clearly defined categories; **default to the broader scope** and let people narrow.
- **Token** = visual encapsulation of a search term, selectable/editable as a single item, acting as a filter (e.g., a contact in Mail, "photos" in Messages). Pair tokens with search suggestions so people discover them. (macOS sibling component: Token fields.)

**iOS vs macOS.**
- **iOS — three entry-point placements:** (1) **as a tab in the tab bar**, (2) **in a toolbar** at bottom or top, (3) **inline with content**.
  - *Search as a tab*, two styles: **standard tab** (uniform with tab bar; tapping navigates to a search landing page with field at top — choose to promote discovery/exploration, e.g., Apple TV) vs **button appearance** (separate button look at trailing end; tapping focuses the field and raises the keyboard immediately — choose for fast, transient find-and-go; returns to previous tab on exit).
  - *Search in a toolbar:* bottom toolbar = expanded field or button that animates into a field above the keyboard; top toolbar ("also called a navigation bar") = button that animates into a field. **Place search at the bottom if there's room** (easy reach; e.g., Settings sole item; Mail/Notes alongside controls). Place at top when content at the bottom must stay clear (e.g., Wallet's pass stack) or there's no bottom toolbar.
  - *Inline field:* when adjacency clarifies that search applies to this content, not globally (e.g., Music library filter vs the Search tab). Position the inline field **above the list it searches**; consider pinning it to the top toolbar on scroll.
- **iPadOS + macOS (explicitly consolidated, keep consistent across both):**
  - **Trailing side of the toolbar** is the familiar default — esp. split-view apps searching across columns (Mail, Notes, Voice Memos, Freeform).
  - **Top of the sidebar** when search filters the sidebar/navigation itself (e.g., Settings).
  - **As a sidebar/tab-bar item** for a dedicated discovery area (Music, TV).
  - In a dedicated search area, **auto-focus the field** on arrival — EXCEPT on iPad with only the virtual keyboard available (keyboard would cover the view).
  - Account for window resizing: on iPad the field resizes fluidly like Mac; in compact widths relocate search where contextually useful (Notes/Mail put it above the content-list column).

**Reviewer checks.**
- Search field missing magnifier icon, clear button, or placeholder → flag anatomy.
- iOS app with site-wide search buried only at top of a long scroll → suggest bottom toolbar placement or search tab.
- A search "tab" that mixes both styles (separate button look but opens a landing page, or vice versa) → flag inconsistent style choice.
- macOS/iPad: search field positioned leading/center in the toolbar → flag (trailing is the convention); sidebar-filtering search not at sidebar top → flag.
- Dedicated search area that doesn't focus the field (desktop) or force-focuses it on touch-only iPad → flag.
- Results not immediate / no suggestions / no recents → UX flags.
- Scope bar defaulting to a narrow scope → flag.
- Custom chip-style filters that look like tokens but aren't selectable/editable as units → flag.

**Stale-knowledge corrections.**
- Pre-2025 iOS search lived almost exclusively in the navigation bar (`UISearchController` pinned under a large title). Current guidance prefers **bottom-of-screen search** for reachability and introduces the **search tab** (with the two named styles "standard tab" / "button appearance" — terminology finalized 2026-06-08).
- The iOS top bar is called a *toolbar* ("also called a navigation bar") even in this page's text.
- Tokens-in-search-field guidance (iOS) is 2025+; older models know tokens only from macOS NSTokenField.

---

## Path controls (macOS only)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/path-controls
**Platforms:** macos only. No recent alert.

**Purpose.** Shows the file-system path of the selected file/folder (e.g., Finder's View > Show Path Bar). Two styles exist (standard bar and pop-up style).

**Normative rules.**
- **Use a path control in the window body, not the window frame.** Not for toolbars or status bars. (Finder's path bar is at the bottom of the window *body*, not the status bar.)
- Shows path of selection, or the window's folder if nothing is selected.

**iOS vs macOS.** macOS-only; not supported anywhere else.

**Reviewer checks.** Path/breadcrumb control rendered inside a toolbar or title bar of a Mac design → violation; move into window body. On iOS designs, a Finder-style path control at all → flag (not a platform component; use navigation hierarchy instead).

**Stale-knowledge corrections.** None — page unchanged; minimal.

---

## Token fields (macOS only)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/token-fields
**Platforms:** macos only. No recent alert.

**Purpose.** Text field that converts typed text into draggable, selectable tokens (e.g., Mail recipients); can offer typed-text suggestions that insert as tokens.

**Normative rules.**
- **Add value with a context menu** on tokens (e.g., Mail recipient token: Edit name, mark VIP, view contact card).
- **Default conversion trigger: typing a comma.** You can add more triggers (e.g., Return).
- **Suggestions appear immediately by default**; consider customizing (lengthening) the delay if instant suggestions distract.
- Tokens can be selected, dragged to reorder, or moved between fields.
- For search-term tokens, see Search fields (iOS-side equivalent now exists there).

**iOS vs macOS.** macOS-only component (`NSTokenField`); the *concept* of tokens appears on iOS only inside search fields.

**Reviewer checks.** Mac compose-style UI with multiple recipients as plain comma text → suggest token field. Tokens without a context menu → flag missed affordance. Tokens that can't be selected/dragged as units → violation of the token concept.

**Stale-knowledge corrections.** None — stable page.

---

## Buttons

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/buttons
**Platforms:** all. **Last change:** 2025-12-16 "Updated guidance for Liquid Glass." (2025-06-09: updated style & content guidance.)

**Purpose.** The instantaneous-action control. Frames every button as **Style + Content + Role**; distinguishes from button-like components (toggles, pop-up buttons, segmented controls).

**Normative rules.**
- **Hit region at least 44x44 pt** (visionOS 60x60 pt) regardless of input method; include enough surrounding space to distinguish and activate.
- **Always include a press state** on custom buttons.
- **Style:** prominent visual style for the most likely action — system applies the accent color to a prominent button's background. **Keep prominent buttons to one or two per view** (more = cognitive load).
- **Use style, not size, to distinguish the preferred choice.** Same-size buttons signal a coherent set; different sizes side by side look confusing/inconsistent. Highlight the preferred option with a more prominent *style*.
- *Avoid similar colors on button labels and the content layer background*; with colorful content prefer the **default monochromatic label appearance** (Liquid Glass color).
- **Content:** symbol, text label, or both. Familiar actions → familiar icons (`square.and.arrow.up` = Share; see the Standard icons table). Text when a short label is clearer than an icon: a few words, **title-style capitalization**, ideally starting with a verb ("Add to Cart").
- **Role (system-defined semantic):** Normal / **Primary** (default button; people most likely to choose; responds to **Return key**; in a sheet/editable view/alert, Return can auto-close the view) / **Cancel** / **Destructive** (uses **system red**). Primary uses the app accent color.
- **Never assign the primary role to a destructive action**, even if it's the likeliest choice — people activate primary buttons without reading.

**iOS vs macOS.**
- **iOS/iPadOS:** a button can display an **activity indicator** (with optional alternative label, e.g., "Checkout" → "Checking out…") for non-instant actions; indicator replaces the button image next to the label.
- **macOS-unique button types:**
  - **Push button** — the standard macOS button; text/symbol/icon/image or text+image; can be the default button; tintable. **Flexible-height push button** only for tall/variable content (two-line text, tall icon); same corner radius & content padding as regular. **Append a trailing ellipsis ("…") when a push button opens another window, view, or app** (signals more input needed — e.g., Safari AutoFill "Edit…" buttons). Consider **spring loading** (drag selected items over button + force click to activate without dropping).
  - **Square button** (a.k.a. **gradient button**) — symbols/icons only, never text; for view-related actions (add/remove table rows); lives **within or beneath its view, never in toolbars/status bars**; can behave as push/toggle/pop-up; don't introduce with labels (`NSButton.BezelStyle.smallSquare`).
  - **Help button** — circular, fixed size, question mark; **system-provided only; max one per window**; opens contextually relevant help topic, else top-level help. **Placement table:** dialog with dismissal buttons (OK/Cancel) → lower corner opposite the dismissal buttons, vertically aligned with them; dialog without dismissal buttons → lower-left or lower-right corner; settings window/pane → lower-left or lower-right corner. In a view, not the window frame; no introductory text.
  - **Image button** — image/symbol/icon in a view (never toolbar/status bar; use a toolbar item there). **Include about 10 pixels of padding between image edges and button edges** (edges define the clickable area even when invisible); generally avoid the system border (`isBordered`); label, if any, goes **below** the button.

**Reviewer checks.**
- Any tappable control under 44x44 pt effective hit area (iOS or macOS) → violation.
- More than 2 prominent (accent-filled) buttons in one view → violation.
- Preferred action indicated by a *bigger* button rather than a more prominent style → violation.
- Destructive action styled as the primary/default (accent) button → violation; destructive should be red, non-default.
- Custom button with no pressed state in the prototype → violation.
- Button labels in sentence case, or not verb-led where text is used → flag (title-style capitalization).
- macOS: button opening a window/dialog without trailing "…" → violation; ">1 help button per window" → violation; help button floating in toolbar → violation; square/image buttons in window frame → violation.
- Accent-colored labels against similar-hue content backgrounds → Liquid Glass color flag.

**Stale-knowledge corrections.**
- Pre-2025 iOS button vocabulary (UIKit "filled / gray / tinted / plain" sizes "small/medium/large") is replaced in the HIG by the **Style + Content + Role** model with Liquid Glass styling; prominent style + monochromatic default is the current framing.
- Buttons sit on/within Liquid Glass surfaces; heavy custom fills and borders are discouraged in bars (see Toolbars).
- The role list (Normal/Primary/Cancel/Destructive) with Return-key semantics is the current cross-platform model.

---

## Menus (the umbrella page)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/menus
**Platforms:** all. **Last change:** 2026-06-08 "Updated guidance for menu item icons." (2025-07-28 added icon guidance.)

**Purpose.** General rules for ALL menus everywhere (labels, icons, organization, submenus, toggled items) — explicitly inherited by pop-up buttons, pull-down buttons, context menus, and the menu bar.

**Normative rules.**
- **Labels:** verb or verb phrase for action items (View, Close, Select). **Title-style capitalization.** **Remove articles** (a, an, the) — "View Settings" not "View the Settings". May include the **keyboard shortcut** in apps (rarely in games).
- **Unavailable items: dim them, don't remove** — and if all items are unavailable the menu itself must stay openable so people can learn its commands. (Context menus invert this — see that page.)
- **Append an ellipsis (…)** when an action needs more information/choices before completing (typically opens another view).
- **Icons (2025-2026 rules):** use the **standard icons** for common actions (Share, Print, Search) — consistent everywhere. **Use icons sparingly and with purpose** — highlight most common actions, key features, file locations, connected devices, visual concepts (rotate/flip), user content (folders/documents). **Don't use an icon that doesn't clearly represent the item.** **Within a single group: icons on ALL items or NONE** (uniform visual treatment).
- **Organization:** important/frequent items first (people scan from the top). Group related items with **separators** (line or gap). Keep logically related commands in one group even with mixed frequency (Paste and Match Style sits with Copy/Cut/Paste). **Be mindful of menu length** — split overly long menus or use a submenu; exception: user-defined/dynamic content menus (History, Bookmarks) may be long and scroll.
- **Submenus:** indicated by a chevron-like symbol after the label. **Use sparingly**; consider one when a term repeats in more than two items of a group ("Sort by Date/Score/Time" → "Sort by ▸ Date/Score/Time"; reuse the repeated term as the submenu label). **Restrict to a single level**; **if a submenu exceeds ~5 items, consider a new menu instead.** Submenus stay enabled even when all nested items are unavailable. **Prefer a submenu over indenting menu items** (indentation is non-system).
- **Toggled items:** prefer one changeable label (Show Map ⇄ Hide Map) over two items; add a verb if state vs action is ambiguous (Turn HDR On / Turn HDR Off); show both items when seeing both states helps; **checkmark** for attributes currently in effect; consider a "remove all attributes" item (e.g., Plain).

**iOS vs macOS.**
- **iOS/iPadOS menu layouts** (`preferredElementSize`): **Small** = top row of 4 icon-only items above the list; **Medium** = top row of 3 items with symbol above a short label; **Large (default)** = plain list. Use medium for the 3 most important frequent actions (Notes: Scan/Lock/Pin); use small ONLY for closely related groups recognizable without labels (Bold/Italic/Underline/Strikethrough).
- macOS: "No additional considerations" on this page (the menu bar page carries macOS specifics). Note macOS menus can extend outside window bounds.

**Reviewer checks.**
- Menu items in sentence case, with articles, or noun-only action labels → flag.
- Action requiring further input without "…" → violation; "…" on an action that completes immediately → violation.
- Mixed icon/no-icon items within one separator group → violation (2026 rule).
- Submenus 2+ levels deep; submenu with >5 items; indented items mimicking hierarchy → violations.
- Unavailable items removed from a regular menu (vs dimmed) → violation; entire menu disabled → violation.
- Both "Show X" and "Hide X" listed simultaneously without reason → flag (prefer toggled label).
- Icon-only rows (small layout) used for unrelated actions → flag.

**Stale-knowledge corrections.**
- The menu-item **icon** rules (sparing, purposeful, all-or-none per group) are 2025-07/2026-06 additions — older models have no guidance here and tend to either icon-everything or nothing.
- The small/medium/large menu layout system (icon rows atop menus) dates from iOS 16 but the current standard-icons cross-reference ("Standard icons" page) is the 2025 era way to pick glyphs.
- "Dim, don't hide" for regular menus vs "hide, don't dim" for context menus is an easy-to-confuse pair worth encoding explicitly.

---

## The menu bar (macOS + iPadOS)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/the-menu-bar
**Platforms:** ipados, macos. **Last change:** 2025-06-09 "Added guidance for the menu bar in iPadOS."

**Purpose.** The top-of-screen menu bar: canonical menu order, the standard contents of every standard menu, menu bar extras, dynamic menu items. The densest checkable page in this bucket.

**Normative rules.**
- **Canonical menu order:** AppName (short name) → File → Edit → Format → View → app-specific menus → Window → Help. macOS adds the **Apple menu** at the leading side (unmodifiable) and **menu bar extras** at the trailing side.
- **Support the system-defined menus and ordering.** Many standard items are system-implemented for free (e.g., Edit > Copy on text selection).
- **Always show the same set of menu items; disable, never hide,** non-actionable ones.
- Use the **same standard icons** for common actions everywhere (Copy/Share/Delete; per 2026 Menus icon rules).
- **Support standard keyboard shortcuts** (Copy/Cut/Paste/Save/Print…); custom shortcuts only when necessary.
- **Prefer short one-word menu titles**, title-style caps if multiword. System compresses/truncates titles when space-constrained.
- **App menu** (app name in bold) order: **About YourAppName** (FIRST, separator after, alone in its group; app short name **≤16 characters**; no version number) → **Settings…** (app-level settings only; document settings go in File) → optional app-specific config items (same group, after Settings) → Services (macOS) → Hide YourAppName (macOS) → Hide Others (macOS) → Show All (macOS) → **Quit YourAppName** (Option ⇒ Quit and Keep Windows).
- **File menu** standard items/order: New Item (name the item type, e.g., Event) / Open (… if it presents a chooser) / **Open Recent** (submenu, most recent first, real names not file paths, Clear Menu item) / Close (Option ⇒ Close All; Close Tab in tab-based windows; consider Close Window item) / Close Tab (Option ⇒ Close Other Tabs) / Close File / **Save** (autosave periodically; prompt name+location for new docs; multiple formats → pop-up in Save sheet) / Save All / **Duplicate** (Option ⇒ Save As; **prefer Duplicate over Save As/Export/Copy To** for clarity of file relationships) / Rename… / Move To… / Export As… (only for formats the app doesn't normally handle) / Revert To (autosave version browser) / Page Setup… (only for per-document print parameters) / Print…. If the app handles no files, rename or eliminate the File menu.
- **Edit menu:** Undo / Redo (clarify the target: "Undo Typing", "Redo Paste and Match Style") / Cut / Copy / Paste / Paste and Match Style / **Delete** (NOT "Erase"/"Clear" — must match the Delete key) / Select All / Find (submenu: Find, Find and Replace, Find Next, Find Previous, Use Selection for Find, Jump to Selection) / Spelling and Grammar (submenu) / Substitutions (submenu) / Transformations (Make Uppercase/Lowercase, Capitalize) / Speech / Start Dictation (system-added) / Emoji & Symbols (system-added). Find can move to the File menu if the app finds files/objects rather than text.
- **Format menu:** Font submenu (Show Fonts, Bold, Italic, Underline, Bigger, Smaller, Show Colors, Copy/Paste Style) and Text submenu (Align Left/Center/Justify/Right, Writing Direction, Show Ruler, Copy/Paste Ruler). Omit the menu if no formatted text editing.
- **View menu:** customizes window appearance for ALL window types — **never window navigation/management (that's Window)**. Items: Show/Hide Tab Bar, Show All Tabs/Exit Tab Overview, Show/Hide Toolbar, Customize Toolbar, Show/Hide Sidebar, Enter/Exit Full Screen. **Provide a View menu even for a subset** (e.g., only full screen). Show/Hide labels must reflect the current state.
- **App-specific menus:** between View and Window; mirror the app hierarchy (Mail: Mailbox → Message → Format); order most→least general. **Every custom command belongs in the menu bar**, even if available elsewhere — enables shortcuts and Full Keyboard Access; excluding commands makes them hard to find for everyone.
- **Window menu:** Minimize (Option ⇒ Minimize All) / Zoom (Option ⇒ Zoom All; **never use Zoom for full screen**) / Show Previous Tab / Show Next Tab / Move Tab to New Window / Merge All Windows / Enter-Exit Full Screen (ONLY if no View menu; keep separate Minimize and Zoom regardless) / Bring All to Front (Option ⇒ Arrange in Front) / open window names (**alphabetical order**; no panels/modals). Provide the menu even for one window (Full Keyboard Access). Doesn't customize or close windows (View / File jobs).
- **Help menu** (trailing end): Send Feedback to Apple / **YourAppName Help** (Help Book format gets automatic search field) / additional items after a separator; keep the count small.
- **Dynamic menu items:** modifier-key alternates (e.g., Option turns Minimize into Minimize All). Never the **only** way to do a task; primarily for menu bar menus (not context/Dock menus); require only a **single** modifier (`isAlternate`).
- **Menu bar extras (macOS):** app-specific icon at the trailing side while the app runs. **Menu bar height = 24 pt.** Use a template-style symbol/icon (black + clear, system recolors). **Show a menu, not a popover, on click.** **Let people opt in/out of showing the extra** (settings; offer during setup). System hides extras when space-constrained — **never rely on the extra's presence**; provide the same functionality elsewhere (e.g., a Dock menu, which is always available while the app runs).

**iOS vs macOS (iPadOS divergence table, quoted from the page).**
| | iPadOS | macOS |
|---|---|---|
| Menu bar visibility | Hidden until revealed (pointer to top edge, or swipe down) | Visible by default |
| Horizontal alignment | Centered | Leading side |
| Menu bar extras | Not available | System + custom |
| Window controls | In the menu bar when app is full screen | Never in the menu bar |
| Apple menu | Not available | Always available |
| App menu | No About, Services, or Hide items | Full set |

- iPadOS extras: menu bar shares vertical space with the status bar; because it's often hidden, **all functions must also be reachable in the app UI**; YourAppName > Settings opens the app's page in **iPadOS Settings** (internal preferences need a separate item below it); consider View-menu items per tab (with key bindings) for tab-style apps; group into submenus more readily (iPad menu rows are taller, screens smaller).

**Reviewer checks (macOS designs/prototypes).**
- Menu order ≠ AppName, File, Edit, Format, View, [custom], Window, Help → violation.
- About not first / not alone in its group; Settings missing "…"; version number in About item label; app name >16 chars → violations.
- Missing Quit/Hide group in app menu; Services absent → flags.
- "Save As" as a top-level item instead of Duplicate (without Option) → flag; "Clear"/"Erase" instead of Delete → violation.
- Full-screen item in both View and Window menus → violation (Window only when no View menu exists).
- Open Recent showing file paths or unordered → violation.
- Window list unalphabetized or including panels → violation.
- App functionality reachable only via toolbar/context menu with no menu bar command → violation.
- Menu bar extra that opens a popover, is colorful/non-template, or is the sole access point → violations.
- Dynamic items requiring two modifiers or being the only path to a task → violations.

**Stale-knowledge corrections.**
- **The menu bar now exists on iPadOS** (2025-06-09) with the divergences above — pre-2025 models believe menu bars are Mac-only.
- "Preferences…" was renamed **"Settings…"** (macOS 13, 2022) — older material says Preferences.
- Menu bar height 24 pt is worth pinning (older references say 22 pt for pre-notch Macs).

---

## Context menus

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/context-menus
**Platforms:** ios, ipados, macos, tvos, visionos (NOT watchOS). **Last change:** 2023-12-05 "Added guidance on hiding unavailable menu items."

**Purpose.** Hidden-by-default menu of frequently used, item-specific commands, revealed by touch-and-hold (iOS/iPadOS), Control-click or trackpad secondary click (macOS/iPadOS).

**Normative rules.**
- **Relevancy first:** quick access to the most likely commands in the current context — NOT advanced or rarely used items (Mail message: reply/move, not mailbox management).
- **Aim for a small number of items** (long menus are hard to scan/scroll).
- **Support context menus consistently throughout the app** — partial support reads as broken.
- **Every context menu item must also exist in the main interface** (iOS: e.g., also in the message-view toolbar; macOS: the menu bar lists all commands).
- Submenus: **max one level**, intuitive titles predictable without opening.
- **Hide unavailable items, don't dim them** — a context menu shows only relevant actions. macOS exception: **Cut, Copy, Paste may appear dimmed** when inapplicable.
- Put the most frequently used items where people encounter them first — the menu may open above OR below the selection, so **the order may need to be reversed** to keep frequent items nearest the invocation point.
- **Show keyboard shortcuts in main menus, not in context menus** (redundant there).
- Separators: fine for grouping, but **no more than about three groups**.
- iOS/iPadOS/visionOS: **destructive items last + marked destructive** (system shows red text); see also Pull-down buttons for confirmation patterns.
- **Content:** seldom a title; only add one if it clarifies effect (e.g., "5 Messages" when acting on a multi-selection). Each item needs a short clear label; use the same standard icons as the system (Copy/Share/Delete).

**iOS vs macOS.**
- iOS/iPadOS: **provide a context menu OR an edit menu for an item, never both** (intent detection conflicts). iPadOS: a context menu in empty space can support object creation (Files: New Folder). A context menu can show a **preview** of the content near the commands — prefer a graphical preview that confirms the target (condensed real content); the preview animates out of the content with the screen dimmed behind — **match the preview's clipping path to the image shape** (rounded corners stable during animation; `UIContextMenuInteractionDelegate`).
- macOS: also called a **contextual menu**; invoked via Control-click/secondary click; commands must mirror menu bar entries; the Cut/Copy/Paste dimming exception applies.

**Reviewer checks.**
- Context menu containing actions unavailable elsewhere in the UI → violation.
- Dimmed (rather than absent) inapplicable items in a context menu (other than macOS Cut/Copy/Paste) → violation.
- Keyboard shortcut glyphs rendered in a context menu → violation.
- >3 separator groups; submenu depth 2+ → violations.
- Destructive item not last / not red on iOS → violation.
- iOS item with both a custom edit menu and a context menu attached → violation.
- Context menus on some list items but not equivalent others → consistency violation.

**Stale-knowledge corrections.**
- 3D Touch / "peek and pop" is dead; invocation is touch-and-hold (haptic touch). Models trained on 2015-2019 material may still describe pressure-based peeking.
- The hide-don't-dim rule (codified 2023-12) is the inverse of regular-menu behavior — frequently mixed up.

---

## Edit menus

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/edit-menus
**Platforms:** ios, ipados, macos, visionos (NOT tvOS/watchOS). **Last change:** 2023-06-21.

**Purpose.** The selection-attached menu for editing actions (Copy, Select, Translate, Look Up…) on text and other selectable content (images, files, contact cards, charts, map locations). System data detectors can auto-add actions (e.g., selected address → "Get directions").

**Normative rules.**
- **Prefer the system-provided edit menu** (standard commands list: `UIResponderStandardEditActions`); custom clones confuse.
- **Use system-defined reveal interactions** (touch-and-hold / double-tap on iOS; secondary click) — never custom gestures for this standard task.
- **Offer only contextually relevant commands**: no Copy/Cut without a selection; no Paste with an empty pasteboard. (Note: edit menus *remove or dim*; contrast with context menus' strict hide rule.)
- **List custom commands near related system commands** (e.g., custom format commands after the system format section); don't overwhelm with custom items.
- **Let people select and copy noneditable text** (captions, statuses) — but not control labels.
- **Support undo/redo** — menus act without confirmation.
- **Avoid redundant controls** duplicating edit-menu functions in the surrounding UI.
- Differentiate deletion semantics: **Delete** = Delete key; **Cut** = copies to pasteboard, then deletes.
- Labels: short verbs/verb phrases.

**iOS vs macOS.**
- **iOS:** compact **horizontal** list at the selection; appears on touch-and-hold or double-tap; **chevron on the trailing edge expands it into a context-menu-style vertical list**.
- **iPadOS:** dual-style — touch reveal → compact horizontal; keyboard/pointer reveal → opens **directly as a context menu** (vertical). **Design for both styles.** Default position above/below the insertion point or selection with a pointer indicator; you can reposition (not reshape) the menu to avoid covering important content.
- **macOS:** no floating bubble component — editing commands live in the **context menu during editing** and the **Edit menu in the menu bar** (see The menu bar for ordering).

**Reviewer checks.**
- iOS selection UI showing the pre-iOS-16 black bubble styling, or a custom floating toolbar replacing the system edit menu → flag.
- Edit menu offering Paste with nothing pasteable, or Copy with no selection → violation.
- Static informational text in mocks that's visibly non-selectable where copying would help → flag.
- Buttons in the canvas duplicating Copy/Paste alongside the menu → flag.
- iPad designs only showing the horizontal style with no vertical/context variant → flag.
- Same item wired to both an edit menu and a context menu → violation (see Context menus).

**Stale-knowledge corrections.**
- `UIMenuController` (the old black edit bubble) is replaced by `UIEditMenuInteraction` (iOS 16+); the expand-chevron into a full context menu and the keyboard/pointer = vertical-style behavior are post-2022 facts the HIG now treats as baseline.

---

## Dock menus (macOS only)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/dock-menus
**Platforms:** macos only. No recent alert.

**Purpose.** The menu shown on secondary-click of an app icon in the Dock; mixes system items (varying with app open/closed) and custom items. iOS/iPadOS analog is Home Screen quick actions (explicit cross-reference).

**Normative rules.**
- Label succinctly + organize logically per the Menus page.
- **Custom Dock menu items must also be available elsewhere** (menu bar or in-app) — not everyone uses Dock menus.
- **Prefer high-value custom items**: currently/recently open windows list; actions useful when the app isn't frontmost or has no open windows (Mail: Get New Mail, Compose New Message).

**iOS vs macOS.** macOS-only; iOS equivalent is Home Screen quick actions.

**Reviewer checks.** Dock menu items with no in-app/menu-bar equivalent → violation. Dock menu stuffed with low-value or niche commands → flag. (Mostly relevant for SwiftUI/AppKit prototypes, rarely visible in Figma.)

**Stale-knowledge corrections.** None — stable page.

---

## Home Screen quick actions (iOS/iPadOS only)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/home-screen-quick-actions
**Platforms:** ios, ipados. No recent alert.

**Purpose.** The app-icon long-press menu on the Home Screen: app-specific shortcuts plus system items (Remove App, Edit Home Screen).

**Normative rules.**
- Anatomy per action: **title + interface icon (left or right depending on icon position on screen) + optional subtitle**; title/subtitle always left-aligned in LTR.
- **Quick actions must be compelling, high-value tasks.** People expect **at least one**; you can provide **a total of four**.
- **Dynamic quick actions** may update (recent conversations, location-based) — but change predictably; avoid surprising rearrangement.
- **Succinct titles that state the result** ("Directions Home", "New Message"); subtitle for extra context (Mail: unread counts); **no app name or extraneous info**; keep short to avoid truncation; mind localization.
- Icons: **prefer SF Symbols** / the Standard icons set; custom icons must use the **Quick Action Icon Template** from Apple Design Resources. **Never use an emoji** — emojis are full-color; quick-action symbols are monochromatic and adapt to Dark Mode.

**iOS vs macOS.** iOS/iPadOS only; macOS analog is the Dock menu.

**Reviewer checks.** More than 4 custom quick actions → violation. Titles with app name, marketing copy, or truncation-length strings → violation. Emoji or full-color glyphs as action icons → violation. Apps shipping zero quick actions → flag (expectation of ≥1).

**Stale-knowledge corrections.** 3D Touch framing ("press harder") is legacy; touch-and-hold is the default invocation. Otherwise stable.

---

## Pop-up buttons

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/pop-up-buttons
**Platforms:** ios, ipados, macos, visionos. **Last change:** 2023-10-24 (artwork only).

**Purpose.** A button revealing a menu of **mutually exclusive options/states** (a "choose one" control); after choosing, the menu closes and the button can show the current selection.

**Normative rules.**
- Use for a **flat list of mutually exclusive options**. Use a **pull-down button instead** if you need: a list of **actions**, **multi-select**, or a **submenu**.
- **Provide a useful default selection** (shown before any user choice).
- **Make the options predictable without opening**: introductory label or a button label describing the effect.
- Good when **space is limited** and options needn't be permanently visible.
- Optionally include a **Custom option** revealing occasional extra items/controls; explanatory text may appear below the list.

**iOS vs macOS.**
- macOS: classic `NSPopUpButton`; no extra page-level rules.
- iOS: supported (`changesSelectionAsPrimaryAction` / SwiftUI `MenuPickerStyle`) — renders as a button showing current value that opens a menu; no extra page-level rules.
- iPadOS: in a popover or modal list, **prefer a pop-up button over a disclosure-indicator push to a detail view** for a small, well-defined option set.

**Reviewer checks.**
- A menu-revealing control mixing actions AND exclusive options → split into pull-down (actions) + pop-up (choices).
- Pop-up button with no default value visible → violation.
- Selection list pushed to a child screen on iPad where ≤6 well-defined options exist → suggest pop-up button.
- Pop-up button menu containing submenus or checkbox multi-select → violation (wrong component).

**Stale-knowledge corrections.** None substantive; note that on modern iOS pop-up buttons (inline value-pickers in lists) replaced many old picker-wheel and detail-screen patterns — models defaulting to UIPickerView wheels for short option lists are out of date.

---

## Pull-down buttons

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/pull-down-buttons
**Platforms:** ios, ipados, macos, visionos. No recent alert.

**Purpose.** A button revealing a menu of **items/actions directly related to the button's purpose**; choosing an item performs the action (button content does not change to reflect a "selection").

**Normative rules.**
- Use for commands related to the button's action (Add → what to add; Sort → sort key; Back → jump to specific location). **Mutually exclusive non-command choices → pop-up button.**
- **Don't put all of a view's actions in one pull-down button** — primary actions must stay discoverable, not hidden behind a press.
- **Menu length: minimum ~3 items to be worthwhile**; 1-2 items → use plain buttons/toggles instead; too many items slows people down.
- **Menu title only if it adds meaning** (usually unnecessary).
- **Destructive items:** red text; on selection the system asks for confirmation via an **action sheet (iOS)** or **popover (iPadOS)** — deliberate dismissal protects against data loss.
- Menu item icons when they add value: **SF Symbols** displayed after the label, staying aligned at every scale.

**iOS vs macOS.**
- iOS/iPadOS: a gesture can reveal the menu on an otherwise-normal button (e.g., touch-and-hold Safari's Tabs button → New Tab / Close All Tabs; `showsMenuAsPrimaryAction`). The **More (…) button** is the canonical pull-down for low-priority items — weigh its space savings against discoverability cost (the ellipsis doesn't predict contents).
- macOS: `pullsDown` NSPopUpButton mode; no extra page rules.

**Reviewer checks.**
- Pull-down menu with 1-2 items → flag (use direct controls).
- A view whose only affordance is one "…" menu containing all primary actions → violation.
- Destructive menu item not red, or executing without confirmation on iOS → violation.
- Button that both performs a default action AND shows a value like a picker → confused component; reassign.
- Distinguishing test for reviewers: **does the button's label change to the chosen item?** Yes → should be a pop-up button; No (performs action) → pull-down.

**Stale-knowledge corrections.** Stable page; the system-confirmation-for-destructive-menu-items flow (action sheet/popover) is post-2020 and worth encoding.

---

## Activity views (share sheets) — iOS/iPadOS only

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/activity-views
**Platforms:** ios, ipados, visionos (NOT macOS). No recent alert.

**Purpose.** The share sheet: sharing activities (messaging), actions (Copy, Print), and frequent apps, presented from the **Action/Share button**; appears as a sheet or popover depending on device/orientation. Also governs **share and action app extensions** (which DO run on macOS, even though the activity view itself doesn't exist there).

**Normative rules.**
- App-specific actions list **before** system/multi-app actions by default; users can edit the action list.
- **Don't duplicate system actions** (no second "Print"); similar-but-custom functionality needs a distinguishing title ("Print Transaction").
- Custom activity icons: prefer **SF Symbols**; custom interface icons **centered in an area about 70x70 px**.
- Action titles: **single verb or brief verb phrase**; system wraps then truncates long titles; **no company/product names in action titles** (share-activity titles, by contrast, typically ARE the company name, shown below the icon).
- **Exclude inapplicable system tasks** (e.g., remove Print if printing makes no sense); you can't reorder system tasks.
- **Reveal only via the standard Share button** — no alternative custom entry points to the same sheet.
- Extensions: prefer the system composition view for share extensions; streamline to a few steps; **no modal views stacked above an extension** (alerts excepted); share extensions auto-use the app icon; **long tasks continue in the background with status in the main app — never notify just because a task completed**.

**iOS vs macOS.**
- iOS/iPadOS: full activity-view component.
- macOS: **no activity view component**; share extensions surface via a toolbar **Share button** or **Share in a context menu**; action extensions via hover affordances on embedded content, toolbar buttons, or **Finder quick actions**.

**Reviewer checks.**
- Custom "share" popup replacing the system share sheet → violation.
- Share entry point that isn't the standard Share (square.and.arrow.up) button → violation.
- Custom action titled with brand name, or duplicating Copy/Print → violation.
- Mac design showing an iOS-style share sheet → violation (use Share toolbar button/menu).

**Stale-knowledge corrections.** Page stable; note "activity view — often called a share sheet" is the current naming. macOS exclusion is explicit (older models sometimes assume NSSharingServicePicker = "share sheet on Mac" parity in HIG terms).

---

## Cross-page synthesis for skill design

**Component-choice decision rules (highly encodable):**
- Navigate between app areas → tab bar (iOS) / adaptable tab bar or sidebar (iPad, Mac). Act on the current view → toolbar. Never actions in tabs.
- Menu of mutually exclusive choices (label shows selection) → pop-up button. Menu of related actions → pull-down button. Frequent item-specific commands on press → context menu. Selection-editing commands → system edit menu. One item + one action → plain button.
- Context menu vs regular menu availability: regular menus **dim** unavailable items; context menus **hide** them (macOS Cut/Copy/Paste excepted).
- Everything in a context menu, Dock menu, toolbar, or menu bar extra must ALSO exist somewhere persistent (main UI or menu bar). macOS menu bar is the superset of all commands.

**Numeric quick-reference (this bucket):**
- Button hit region ≥ **44x44 pt** (iOS and macOS pointer included).
- Toolbar/window title < **15 characters**; app short name ≤ **16 characters**.
- Toolbar groups ≤ **3**; context menu groups ≤ ~**3**; prominent buttons per view ≤ **1-2** (toolbars: exactly 1 prominent action, trailing).
- Submenus: **1 level** max, ~**5 items** max; pull-down menus ≥ **3 items**.
- Home Screen quick actions ≤ **4**; tab bar customization default ≤ **5** tabs.
- macOS menu bar height **24 pt**; image button padding ~**10 px**; activity-view custom icon area ~**70x70 px**.
- iOS menu layouts: small = **4** icon-only top items; medium = **3** icon+label top items; large = list (default).

**Liquid Glass corrections that apply bucket-wide:** bars (toolbars, tab bars, sidebars) float in a distinct Liquid Glass layer above the content layer; no custom bar backgrounds/tints; monochromatic controls by default with at most one accent/prominent action; content scrolls/extends beneath bars; scroll edge effects replace bar borders; concentric corner radii inside bars; borderless symbols.
