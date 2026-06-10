<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: toggles, segmented-controls, pop-up-buttons, pull-down-buttons, pickers, sliders, steppers, text-fields, combo-boxes, image-wells, color-wells, virtual-keyboards, page-controls, path-controls, token-fields, rating-indicators, gauges, progress-indicators, menus, context-menus, edit-menus, the-menu-bar, dock-menus, home-screen-quick-actions, action-sheets, activity-views -->

# Decision trees — controls, platform availability, menu types

## control-tree

What does the person choose or enter?

- **Two opposing states (on/off)** → toggle. iOS: **switch only inside a list row** (row content is the label); anywhere else, a button that behaves like a toggle. macOS: checkbox by default; switch only for an emphasised setting governing a group (mini switch per grouped-form row); don't convert existing checkboxes; never in a toolbar or status bar. State difference must not be colour-only. <!-- src: toggles -->
- **2–5 mutually exclusive options, labels always visible** → segmented control (closely related subviews; noun labels, equal widths, text or icons — not both) or, on macOS, radio buttons. iPhone ≤5 segments; wide layouts ≤7. Never app navigation (tab bar's job) and never macOS main-window view switching (tab view's job). <!-- src: segmented-controls, toggles -->
- **More than ~5 mutually exclusive options** → **pop-up button** (label shows the current choice; provide a meaningful default). A radio group past ~5 becomes a pop-up button too. <!-- src: pop-up-buttons, toggles -->
- **Medium-to-long ordered list** → picker. Short list → pull-down/pop-up instead (a picker "adds too much visual weight"); very large set → list or table (indexable). Values predictable, logically ordered, shown in context — not on a separate screen. Minute intervals must divide evenly into 60; countdown mode caps at 23:59 and never uses compact/inline styles. macOS has no wheels: date pickers are **textual** or **graphical**; generic choice renders as a pop-up. <!-- src: pickers -->
- **Continuous range** → slider — minimum leading/bottom, maximum trailing/top. Wide range → slider + text field + stepper together. iOS volume → **volume view**, never a bare slider. macOS extras: tick marks, circular style for cyclic values (rotation), introductory label ending in a colon, live feedback while dragging. <!-- src: sliders -->
- **Small incremental nudges** → stepper, always beside a visible value (it displays none itself). Widely varying values → pair with a text field. macOS: Shift-click may step at 10× the increment. <!-- src: steppers -->
- **Small, specific free text** → text field: placeholder **plus** a persistent label (placeholder vanishes on typing); secure text field for secrets; width matched to expected input; correct keyboard type on iOS, Clear button at the trailing end. Paragraphs → text view. <!-- src: text-fields, virtual-keyboards -->
- **Free text + suggested values** → macOS **combo box** (meaningful default from the list; label in title-style capitalization ending with a colon). On iOS this component does not exist — use a text field with suggestions, a picker, or a pop-up button. <!-- src: combo-boxes, text-fields -->
- **Colour** → color well; prefer the system color picker (cross-app saved colours). <!-- src: color-wells -->
- **A value within a range (display)** → gauge. **Progress of an operation** → progress indicator: determinate whenever duration is knowable; never switch circular → bar mid-task. Don't swap the two. <!-- src: gauges, progress-indicators -->

## availability-matrix

Hard platform walls. The component on the wrong platform is a violation, not a style choice.

| Component | iOS/iPadOS | macOS |
|---|---|---|
| Checkbox · radio buttons | — (web/Mac idiom leaking in) | ✓ |
| Combo box | — | ✓ |
| Image well | — | ✓ |
| Path control | — | ✓ window body only, never toolbar |
| Token field | tokens only inside search fields | ✓ |
| Rating indicator (whole stars) | — (App Store-style ratings are a pattern, not this control) | ✓ |
| Level indicator (capacity/relevance) | — (use Gauge) | ✓ |
| Panel / HUD | — (nonmodal sheet instead) | ✓ |
| Menu bar extra | — | ✓ 24 pt bar; opens a menu, never a popover |
| Dock menu | — | ✓ |
| Indeterminate progress **bar** | — (spinner only) | ✓ |
| Page control | ✓ ≤~10 dots, centred near the bottom | — |
| Bottom action-sheet idiom | ✓ (iPad: popover from source) | — (dialog-style confirmation) |
| Activity view (share sheet) | ✓ | — (Share toolbar button / context menu) |
| Virtual keyboards / keyboard types | ✓ | — |
| Switch in list row · Clear button · refresh control | ✓ | — |
| Sheet detents + grabber + swipe-to-dismiss | ✓ | — |
| Home Screen quick actions (≤4) | ✓ | — (Dock menu is the analogue) |

<!-- src: toggles, combo-boxes, image-wells, path-controls, token-fields, rating-indicators, gauges, panels, the-menu-bar, dock-menus, progress-indicators, page-controls, action-sheets, activity-views, virtual-keyboards, text-fields, sheets, home-screen-quick-actions -->

## menu-chooser

- Button label **changes to the chosen item** (mutually exclusive choices) → **pop-up button**.
- Button **performs actions** related to its purpose → **pull-down button**. Worthwhile from ~3 items; 1–2 items → plain buttons. Destructive items red; the system confirms via an action sheet (iOS) or popover (iPadOS). The More (…) button is the canonical pull-down — weigh its space saving against discoverability.
- **Frequent, item-specific commands** on touch-and-hold / secondary click → **context menu**. Few items, ≤~3 separator groups, one submenu level; destructive items last and red (iOS).
- **Commands on the current selection** (Copy, Look Up, Translate) → system **edit menu**: iOS horizontal bubble expanding via the trailing chevron; iPad adds a vertical context-menu style for keyboard/pointer — design both. macOS has no bubble: editing commands live in the context menu and the menu bar's Edit menu. iOS: give an item a context menu **or** an edit menu, never both. <!-- src: pop-up-buttons, pull-down-buttons, context-menus, edit-menus -->

**The inverted rule pair — easy to get backwards:**
- Regular menus (menu bar, pop-up, pull-down): **dim unavailable items, never remove them**; the menu stays openable even when everything is dimmed.
- Context menus: **hide unavailable items, never dim them** — show only what applies. Sole macOS exception: Cut, Copy, Paste may appear dimmed.
- Edit menus sit between: remove or dim inapplicable commands (no Paste with an empty pasteboard).
- Keyboard shortcuts display in menu bar menus, never in context menus. <!-- src: menus, context-menus, edit-menus, the-menu-bar -->

**Umbrella rules inherited by every menu type:** verb-first labels in title-style capitalization, no articles; ellipsis (…) when more input follows; within one separator group, icons on **all items or none** (2026 rule); submenus one level deep — past ~5 items, rethink; prefer one toggled label (Show Map ⇄ Hide Map) over two items, with a checkmark for attributes in effect. <!-- src: menus -->

**Reach test:** anything that lives only in a context menu, Dock menu, toolbar, or menu bar extra is invisible to someone. Every command needs a persistent home — and on macOS the menu bar is the **superset** of all commands. <!-- src: context-menus, dock-menus, toolbars, the-menu-bar -->
