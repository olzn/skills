<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: mac-catalyst, designing-for-macos, designing-for-ios, the-menu-bar, toolbars, sidebars, windows, panels, typography, pointing-devices, keyboards, context-menus, undo-and-redo, file-management, drag-and-drop, buttons, sheets, popovers, live-activities -->

# Adaptation — porting a design between iOS and macOS

A sequenced process: each step feeds the next; skipping step 3 is how "iPad app in a window" ports happen. Forward direction (iOS → macOS) first; reverse deltas at the end. For system surfaces (widgets, Live Activities) Apple prescribes the same ordering: "Start with the iPhone design, then refine it for other contexts." <!-- src: live-activities -->

## step-1-inventory

Census the source design before translating anything:

- **Medium** — HTML prototype, Figma, or SwiftUI. Determines what is verifiable; load the matching adapter (`adapters/html.md` / `figma.md` / `swiftui.md`) before reviewing the result.
- **Navigation model** — tab bar? hierarchical push? modal flows? where does search live? Each maps differently in step 2.
- **Component census** — list every control; run the list against `trees-controls.md#availability-matrix`. Platform-walled components (switch-in-row, action sheets, page controls, checkboxes…) need substitution, not copying.
- **Container census** — sheets, popovers, action sheets, full-screen modals; map them with `trees-containers.md#width-class-forks`.
- **Input inventory** — every gesture (swipe actions, pull-to-refresh, long-press) needs a pointer/keyboard/menu equivalent on the Mac; gestures are shortcuts, never the only path.
- **Type spec** — which Dynamic Type styles are in use; fixed px sizes are a defect in both directions.
- **Suitability check** — features leaning on gyroscope/accelerometer, the rear camera, or ARKit don't port; design around them, don't fake them. <!-- src: mac-catalyst, designing-for-ios -->

## step-2-translate

The Mac Catalyst table — the HIG's only explicit iOS→macOS translation table, valid generic port guidance whether or not Catalyst is involved:

| iOS source | macOS target |
|---|---|
| Tab bar | **Sidebar** (split view) preferred; segmented control only for genuinely flat hierarchies; tab destinations also reachable from the **View menu** |
| Bottom-edge / side-edge buttons | **Toolbar** — the reach rationale doesn't exist on a Mac — plus menu bar commands |
| Popover used as a persistent inspector | **Inspector pane next to the content** |
| Single column | Multiple columns; regular-width/regular-height size classes; side-by-side reflow on window resize |
| 17 pt body text | **13 pt** — the iPad idiom renders everything at **77%** (17 pt → 13 pt, the native macOS body baseline); the Mac idiom renders at 100% but demands a full type audit using text styles, not fixed sizes |
| Swipe paging | Add **Next/Previous buttons** alongside the gesture |
| Touch input | Automatic mapping: tap → click; touch-and-hold → click-and-hold; pan → click-drag; pinch/rotate → trackpad pinch/rotate |
| Layout flow | **Top-down**: most important content and actions near the top of the window |
| App icon | macOS-specific variant — follow the current `app-icons` layered-icon guidance, which supersedes the Catalyst page's "lifelike rendering" wording |

<!-- src: mac-catalyst -->

## step-3-macos-completeness

Translation is not completion. A Mac design is incomplete until:

- **Menu bar superset** — every command in the app (toolbar, context menu, and Dock menu items included) also exists as a menu bar command, in canonical order: AppName · File · Edit · Format · View · app-specific · Window · Help. <!-- src: the-menu-bar, designing-for-macos -->
- **Shortcuts for every command** — the standard table is a hard expectation (⌘Z undo / ⇧⌘Z redo at the top of the Edit menu; ⌘, opens Settings; ⌃⌘F enters full screen); keyboard-only operation must work. <!-- src: keyboards, undo-and-redo, the-menu-bar -->
- **Semantic pointers and hover** — I-beam over text, pointing hand over links, not-allowed over invalid drops; tooltips on toolbar items; focus rings on fields; drag operations show copy/link pointers and multi-item count badges. <!-- src: pointing-devices, drag-and-drop -->
- **Window behaviour** — free resize with reflow, state restoration, full screen, the main/key/inactive state appearances; no critical actions in bottom bars or at the sidebar's bottom (often offscreen). <!-- src: windows, sidebars -->
- **Targets and density** — 28 pt default control size, 20 pt minimum; 13 pt body; flatter hierarchy with less modality and more content per screen. <!-- src: pointing-devices, typography, designing-for-macos -->
- **A context menu on every object** — Mac users expect one everywhere; its commands mirror menu bar entries (hide unavailable items; Cut/Copy/Paste may dim). <!-- src: mac-catalyst, context-menus -->
- **The user owns the environment** — the system accent colour can replace yours (sidebar icons must follow it); sidebar icon size is a user setting (small/medium/large); toolbars are customisable. Designs must tolerate every substitution. <!-- src: sidebars, toolbars, designing-for-macos -->
- **Document behaviours** (document-based apps) — full File menu, system open/save dialogs, autosave with "Untitled" defaults and the Edited/close-button-dot conventions, Finder integration. <!-- src: file-management -->
- **Vocabulary** — "Settings…" never "Preferences"; "window" never "scene"; macOS form labels in title-style capitalization ending with a colon. <!-- src: the-menu-bar, windows, combo-boxes -->

## step-4-review-handoff

Run the finished port through `checklists/review-screen-macos.md` (self-sufficient; inlines the hot numbers) plus the medium adapter from step 1. Re-check bars and containers against `trees-containers.md#bars-doctrine` and `#width-class-forks`. Tier and principle-tag findings per hig-review's SKILL.md.

## reverse-port

macOS → iOS: invert the step-2 table, then add what the Mac never needed:

- Menu-bar-only and toolbar commands need **visible, reachable homes** — primary actions in the middle or bottom of the screen; menu-only commands become buttons, swipe actions, or context menus (each with a persistent twin). <!-- src: designing-for-ios, context-menus -->
- Hover, tooltips, pointers, and focus rings don't exist on iPhone — any meaning they carried needs a visible affordance. <!-- src: designing-for-ios -->
- Density loosens: 13 pt → 17 pt body; hit regions ≥ 44×44 pt; wide multi-column layouts flatten into navigable columns. <!-- src: typography, buttons -->
- Containers re-fork: panels → nonmodal sheets; persistent inspectors → popovers (regular width) or sheets (compact); sheets gain detents, a grabber, and swipe-to-dismiss. <!-- src: panels, sheets, popovers -->
- Support Dark Mode, Dynamic Type, swipe-back, and list-row swipes from the start — user choices, not edge cases. <!-- src: designing-for-ios -->

> **27 beta delta (promote on GA):** iOS/macOS 27 "Golden Gate" was announced 2026-06-08; the navigation-affecting pages (tab-bars, search-fields, toolbars, sidebars) are hot. Before porting navigation or search placement for a 27-targeting design, fetch those slugs live; the reported 27 search-tab re-integration is press-sourced and unsettled. <!-- src: tab-bars, search-fields · press-sourced -->
