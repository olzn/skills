<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: accessibility, typography, color, the-menu-bar, menus, keyboards, pointing-devices, focus-and-selection, windows, panels, sheets, alerts, toolbars, sidebars, split-views, lists-and-tables, outline-views, column-views, tab-views, buttons, page-controls, action-sheets, activity-views, layout, privacy, sign-in-with-apple -->

# Screen review — macOS

Everything checkable on one static macOS window/screen. Self-sufficient — the hot numbers are inlined. Web-first designs fail macOS differently from iOS: the failures below are mostly a missing desktop contract (menu bar, keyboard, pointer semantics), not visual styling. Glass/material depth → `review-liquid-glass.md`; what a render can't prove → `adapters/`.

## Tier 1 — rejection risk (App Review enforces these)

- Flag any pre-permission explainer with more than **one button**, a button titled "Allow" (must be Continue/Next-like), or a bypass affordance; flag tracking-consent screens with incentives, system-alert mockups, or pointing annotations (Guideline 5.1.1(iv)). <!-- src: privacy -->
- Flag Sign in with Apple drawn as a custom-styled button. <!-- src: sign-in-with-apple, _practice -->
- Flag minimum-functionality tells (Guideline 4.2): placeholder content, broken layouts, blurry assets, spelling errors — a bare web-wrapper look (no menu bar, no native chrome) feeds the same judgement. <!-- src: _practice -->

## Tier 2 — feels broken

**The numbers** (inline copies; source of truth `tables/accessibility-sizes.md`):

- Controls: **28×28 pt default, 20×20 pt absolute minimum** — pointer targets included. Flag below 28, fail below 20. <!-- src: tables/accessibility-sizes.md -->
- Spacing: ≥ **12 pt** padding around bezeled controls; ≥ **24 pt** around the visible edges of bezel-less ones. <!-- src: tables/accessibility-sizes.md -->
- Type: body defaults to **13 pt**; flag anything below **10 pt**. <!-- src: tables/accessibility-sizes.md -->
- Contrast (WCAG AA, check light AND dark): ≥ **4.5:1** for text through 17 pt; ≥ **3:1** at 18 pt and up, or bold. <!-- src: tables/accessibility-sizes.md -->

**Menu bar — the command contract.** The menu bar is the superset of every command; to a keyboard user, an absent command is an absent feature:

- A complete menu bar exists (Electron/web shells: flag stub menus) in the canonical order **AppName · File · Edit · Format · View · [app-specific] · Window · Help**. <!-- src: the-menu-bar -->
- App menu: **About AppName** first and alone in its group (no version number); **Settings…** — "Preferences…" is pre-2022; Services; Hide/Hide Others/Show All; **Quit AppName**. <!-- src: the-menu-bar -->
- Every toolbar, context-menu, and Dock-menu command also exists as a menu bar command — flag any visible control with no plausible menu home. <!-- src: toolbars, context-menus, dock-menus -->
- Menu items disable, never disappear; actions needing further input end in an ellipsis (…); Edit uses **Delete** (the key's name — never "Clear"/"Erase"); Undo/Redo name their target ("Undo Typing"). <!-- src: the-menu-bar, menus -->
- View customises appearance (Show/Hide Toolbar/Sidebar, Enter Full Screen); Window manages windows (Minimize, Zoom — Zoom is never full screen; window list alphabetical, no panels in it); full screen lives in View OR Window, never both. <!-- src: the-menu-bar -->
- Menu bar extras: template-style symbol (never colourful), opens a menu — not a popover — and is never the sole access point. <!-- src: the-menu-bar -->

**Keyboard**

- Standard shortcuts mean their standard things: ⌘, Settings · ⌘W Close Window (never Quit) · ⌘Z/⇧⌘Z Undo/Redo · ⌘S Save · ⌘F Find · ⌃⌘F Full Screen · ⌘M Minimize. Frequent menu commands display shortcuts; context menus never do. <!-- src: keyboards, context-menus -->
- Shortcut rendering: glyphs in **Control–Option–Shift–Command** order (⌃⌥⇧⌘); never Shift plus the upper character of a two-character key — Help is ⌘?, not ⇧⌘/ (a classic Electron tell); avoid Control as an app modifier. <!-- src: keyboards, _practice -->

**Pointer and focus**

- Semantic cursors: pointing hand for links only; I-beam over editable/selectable text; operation-not-allowed on invalid drop; open/closed hand for repositionable content. An arrow everywhere is a web tell. <!-- src: pointing-devices -->
- The active text/search field shows a focus ring; focused/selected list rows use the full-row accent highlight with white text; buttons and toggles carry no custom focus rings (Full Keyboard Access owns control focus). <!-- src: focus-and-selection -->

**Windows and alerts**

- System traffic lights only — no custom window chrome or replicas. In multi-window mocks, the key window's controls are coloured; inactive windows go grey and lose material colour-through — flag identical states. <!-- src: windows -->
- No critical actions or status at the window's bottom edge (often pushed offscreen); bottom bars carry only small selection/status info. <!-- src: windows, layout -->
- Alerts: the app icon shows; ≤3 buttons; Cancel leading, default trailing and answering Return; destructive never the default; repeating alerts offer a suppression checkbox; the caution badge only for unexpected data loss. <!-- src: alerts -->

## Tier 3 — feels non-native

**Containers: panel vs sheet vs window**

- Repeated input-observe-result loops (find and replace) → panel, never a sheet. A scoped one-shot subtask → sheet: a card attached to its parent, parent dims, other windows stay usable. A self-contained or prolonged task → its own window. <!-- src: panels, sheets -->
- An inspector that follows the selection → panel or trailing split-view pane; fixed info about one item → window. Panels: title bar with a title-style noun ("Fonts"), no minimize button; HUD style only in media contexts. <!-- src: panels -->
- Flag iOS transplants: page-control dots (unsupported on macOS), bottom-anchored action sheets (macOS confirmation presents dialog-like), iOS share sheets (use a Share toolbar button or context-menu item), and 17 pt body type — the telltale port; macOS body is 13 pt. <!-- src: page-controls, action-sheets, activity-views, typography -->

**Toolbar**

- Items are borderless symbols in the window frame — no bezels; overflow is system-managed (never a hand-built » or custom More); exactly one prominent action, trailing; window titled, never with the app name, under 15 characters. <!-- src: toolbars -->

**Tables, outlines, columns**

- Multicolumn tables: alternating row backgrounds, resizable columns, clickable heading sort (second click reverses); headings are title-style nouns, no punctuation. <!-- src: lists-and-tables -->
- Hierarchical data → outline view: disclosure triangles in the first column only; expansion state persists across sessions. Deep hierarchy with frequent level-hopping and no sorting need → column view: root in the first column, resizable columns. <!-- src: outline-views, column-views -->
- Mutually exclusive panes → tab view: ≤6 tabs, title-style noun labels, inset from the window edges; more panes → pop-up switcher. <!-- src: tab-views -->

**Buttons**

- A push button that opens another window, view, or app ends with an ellipsis ("Edit…"). <!-- src: buttons -->
- Help button: the system circular "?", max one per window, lower corner opposite the dismissal buttons — never in a toolbar. <!-- src: buttons -->
- Square (gradient) and image buttons live in the window body, never toolbars or status bars; image buttons keep ~10 px padding inside their edges; any label sits below. <!-- src: buttons -->

**Sidebar**

- Show/hide exists as a toolbar button AND a View-menu command; not hidden by default; ≤2 hierarchy levels; icons follow the user's system accent colour, fixed colours sparingly (Mail's VIP yellow); nothing critical pinned at the sidebar bottom; layout tolerates the user's small/medium/large sidebar icon size. <!-- src: sidebars -->

**The user owns the environment**

- The system accent colour can replace the app accent everywhere — flag designs whose hierarchy collapses without the brand hue. <!-- src: color -->
- Free window resizing is the default condition: check narrow widths; split-view panes set min/max sizes so the 1 pt divider never vanishes; hidden panes restore by more than one path (toolbar button + menu command + shortcut). <!-- src: windows, split-views, layout -->
