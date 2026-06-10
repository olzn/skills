<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: alerts, action-sheets, sheets, popovers, panels, windows, modality, toolbars, tab-bars, sidebars, scroll-views, search-fields, searching, materials -->

# Decision trees — containers, bars, search, modality

Pick the presentation container from the **trigger**, not the content size. Full anatomy: corpus sections named by each slug.

## container-tree

1. **Unexpected problem, or critical information needing an immediate decision** → **alert**. Title + optional message + up to 3 buttons (need more → action sheet). Never at app launch; never for FYI-only information; not for common, undoable deletions. <!-- src: alerts -->
2. **Choices completing an action the person just took** (close an unsaved draft, confirm a destructive tap) → **action sheet** (`confirmationDialog`). Destructive choice red and at the top; Cancel at the bottom; don't let it scroll. <!-- src: action-sheets -->
3. **A scoped subtask closely related to the current context** (fill in details, then return) → **sheet**. Done must be paired with Cancel or Back — never Done alone, never all three. Long multistep or immersive work → full-screen modal (iOS) or a window (macOS). <!-- src: sheets, modality -->
4. **A small amount of transient content or functionality anchored to a control** → **popover** — regular width only (see width-class forks). Arrow points at the revealing element; never use a popover for a warning (that's an alert). <!-- src: popovers -->
5. **Persistent supplementary tools that track the current selection** → macOS **panel**, or the modern preference, an inspector split-view pane. Inspector (auto-updates with selection) → panel/pane; Info window (fixed to one item) → regular window. iOS equivalent: nonmodal sheet. <!-- src: panels, sheets -->
6. **A parallel context worth keeping alongside** (compose next to the mailbox, a second document) → **window** (macOS, iPadOS). Offer "open in new window" as an option, never the default; no custom window chrome, ever. <!-- src: windows -->

**Disambiguators.**
- Alert vs action sheet: the system interrupts the person → alert; the person's own action needs a follow-up choice → action sheet. <!-- src: alerts, action-sheets -->
- Sheet vs panel (macOS): repeated input-observe-result loops (find and replace) → panel, never a sheet. <!-- src: sheets, panels -->
- Popover vs panel: a dragged macOS popover may detach into a panel — keep the detached state visually similar. <!-- src: popovers -->

## width-class-forks

The same trigger must adapt by size class — hardcoding one presentation across widths is a violation.

| Trigger | Compact (iPhone) | Regular (iPad) | macOS |
|---|---|---|---|
| Popover content | **sheet** — avoid popovers in compact widths | popover | popover (detachable) |
| Action sheet | bottom sheet of buttons | **popover from the source element** | dialog-style confirmation — no bottom-sheet idiom |
| Sheet | card from the bottom; detents (large / medium ≈ half height), grabber, swipe-to-dismiss | page or form sheet, centred over a dimmed surround | card floating on its parent window; parent dims, **other windows stay usable**; no detents, button-only dismissal |
| Supplementary tools | nonmodal sheet | popover or split-view pane | panel or inspector pane |

<!-- src: popovers, action-sheets, sheets, panels -->

## stacking-rules

- One popover at a time; never a popover from a popover; nothing displays above a popover except an alert. <!-- src: popovers -->
- One sheet at a time from the main interface; close the first before showing a second. <!-- src: sheets -->
- One modal at a time; an alert may appear above anything, but **never two alerts at once**. <!-- src: modality -->

## bars-doctrine

Checklist for any bar — toolbar, tab bar, sidebar. Rationale: `doctrine.md` two-layer model.

- [ ] Bar **floats on Liquid Glass**; content scrolls beneath and peeks through. Opaque pinned bars are pre-26 styling — flag as a craft violation. <!-- src: toolbars, tab-bars, materials -->
- [ ] **No custom bar backgrounds or tinted bar controls.** Separation from content is the **scroll edge effect** (prefer the automatic style; one per view; consistent heights across split-view panes) — never gradients, scrims, or hairline dividers. <!-- src: toolbars, scroll-views -->
- [ ] **Exactly one prominent action** per toolbar (`.prominent`, e.g. Done), on the trailing edge; everything else monochromatic, borderless SF Symbols (no outlined-circle icons). <!-- src: toolbars -->
- [ ] At most **3 item groups**: leading (back, sidebar toggle, title — not customisable) · centre (customisable; auto-collapses to the system overflow) · trailing (always visible; More menu; the prominent action). Never hand-build overflow on macOS/iPadOS. <!-- src: toolbars -->
- [ ] **Tabs navigate, never act.** Label every tab (single words); filled symbols; never hide or disable a tab. iOS: floating bottom bar, may minimise on scroll, may carry an accessory. iPadOS: top placement, `sidebarAdaptable`. <!-- src: tab-bars -->
- [ ] Sidebars: content extends or mirrors beneath (`backgroundExtensionEffect`); ≤2 hierarchy levels; icons follow the accent colour — on macOS, the **user's** system accent. <!-- src: sidebars -->
- [ ] macOS: every toolbar item also exists as a menu bar command. <!-- src: toolbars, the-menu-bar -->

## search-placement

26.x canon — **version-sensitive**; verify live once `versions.md` expires.

**iOS — choose one primary entry point:**
1. **Search tab** in the tab bar, two named styles: **standard tab** (navigates to a search landing page — promotes discovery; Apple TV) or **button appearance** (distinct trailing button; focuses the field and raises the keyboard immediately — fast find-and-go, returns to the previous tab on exit). Never mix the two behaviours. <!-- src: search-fields -->
2. **Toolbar field** — bottom toolbar when there's room (reachability; Notes, Mail); top toolbar only when the bottom must stay clear (Wallet) or no bottom toolbar exists. <!-- src: search-fields, searching -->
3. **Inline above the content it filters** — local search only, in addition to a single global entry point. <!-- src: search-fields, searching -->

**iPadOS + macOS (keep the two consistent):** trailing side of the toolbar (the default; split-view apps) · top of the sidebar (when search filters navigation; Settings) · a sidebar/tab item (dedicated discovery area; Music, TV). Auto-focus the field on arrival in a dedicated search area — except iPad with only the virtual keyboard available. <!-- src: search-fields -->

A top-of-list navigation-bar search field as the only entry point is pre-26 styling — flag, then check the live page given churn here. <!-- src: searching -->

> **27 beta delta (promote on GA):** press reports — not verifiable on a live HIG page — say iOS 27 re-integrates the search tab with the other tabs, reversing the 26 split-search look. Unsettled; fetch `search-fields` and `tab-bars` live before asserting search placement for 27-targeting designs. <!-- src: search-fields · press-sourced -->

## modality-rules

- Go modal only with a clear benefit: critical information, confirming/modifying the latest action, a distinct narrowly scoped task, or immersive focus. A detail view belongs in navigation, not a modal. <!-- src: modality -->
- Keep modal tasks short and flat. **No app-within-app**: no tab bars or branching hierarchies inside a modal; one path through any subviews; title the task so people keep their place. <!-- src: modality -->
- Full-screen modal style is **endorsed** for in-depth multistep work (video, camera, markup, photo editing) — models that discourage it are stale. <!-- src: modality -->
- Dismissal conventions: iOS/iPadOS = button in the top toolbar or swipe down; macOS = button in the content view. Confirm any dismissal that would lose user-generated content — gesture or button alike (iOS: confirm via action sheet). <!-- src: modality, sheets -->
