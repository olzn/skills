<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: icons, sf-symbols -->

# SF Symbols — canonical action vocabulary

Apple's standard action→symbol table (icons page, added 2025-06-09). This is the canonical vocabulary, not a suggestion: flag any custom glyph drawn for an action listed here and name the symbol. <!-- src: icons -->

**Rename churn — verify before asserting.** Symbol names get renamed across SF Symbols releases (the doc→document family is the big one); models trained pre-2024/2025 emit deprecated aliases. SF Symbols 8 beta shipped at WWDC26 (2026-06-08) — expect additions and renames not yet in this snapshot. Before asserting a name in code, check the SF Symbols app or fetch live: `scripts/hig-fetch.sh icons`. Symbol availability is OS-version-gated — a given year's symbols don't exist on earlier OSes. <!-- src: icons, sf-symbols -->

## Editing and file management
| Action | Symbol |
|---|---|
| Cut | `scissors` |
| Copy | `document.on.document` |
| Paste | `document.on.clipboard` |
| Undo | `arrow.uturn.backward` |
| Redo | `arrow.uturn.forward` |
| Compose | `square.and.pencil` |
| Duplicate | `plus.square.on.square` |
| Rename | `pencil` |
| Delete | `trash` |
| Add | `plus` |
| Attach | `paperclip` |
| Move to / Folder | `folder` |
| Archive | `archivebox` |

## Confirmation and selection
| Action | Symbol |
|---|---|
| Done / Save | `checkmark` |
| Cancel / Close | `xmark` |
| Select | `checkmark.circle` |
| Deselect | `xmark` |
| More | `ellipsis` |

## Text formatting
| Action | Symbol |
|---|---|
| Bold / Italic / Underline | `bold` / `italic` / `underline` |
| Superscript / Subscript | `textformat.superscript` / `textformat.subscript` |
| Align Left / Center / Right | `text.alignleft` / `text.aligncenter` / `text.alignright` |
| Justify | `text.justify` |

## Find, share, people, arrangement
| Action | Symbol |
|---|---|
| Search | `magnifyingglass` |
| Find (incl. Replace/Next/Previous) | `text.page.badge.magnifyingglass` |
| Filter | `line.3.horizontal.decrease` |
| Share / Export | `square.and.arrow.up` |
| Print | `printer` |
| Account / User / Profile | `person.crop.circle` |
| Like / Dislike | `hand.thumbsup` / `hand.thumbsdown` |
| Bring to Front / Send to Back | `square.3.layers.3d.top.filled` / `square.3.layers.3d.bottom.filled` |
| Bring Forward / Send Backward | `square.2.layers.3d.top.filled` / `square.2.layers.3d.bottom.filled` |
| Alarm | `alarm` |
| Calendar | `calendar` |
<!-- src: icons -->

## Deprecated aliases — stale priors
| Current name | Deprecated alias (pre-SF Symbols 6) |
|---|---|
| `document.on.document` | `doc.on.doc` |
| `document.on.clipboard` | `doc.on.clipboard` |
| `text.page.badge.magnifyingglass` | `doc.text.magnifyingglass` |
<!-- src: icons -->

## Semantic misuse — flag these
| Symbol | Means | Not for |
|---|---|---|
| `square.and.arrow.up` | Share/Export | upload-to-server |
| `trash` | Delete | remove-from-list-but-recoverable |
| `magnifyingglass` | Search | zoom |
<!-- src: icons -->

## Usage rules (terse)
- Match symbol weight to adjacent text weight; nine weights mirror San Francisco; three scales (small / medium default / large) defined relative to SF cap height. <!-- src: sf-symbols -->
- Variants: outline (default) suits toolbars and lists; fill suits iOS tab bars and swipe actions; the containing view often picks automatically — don't fight it. <!-- src: sf-symbols -->
- Don't supply selected-state variants for icons in standard components (toolbars, tab bars, buttons) — the system handles selected appearance. <!-- src: icons -->
- Licence prohibition: never use SF Symbols, or confusingly similar artwork, in app icons, logos, or any trademarked use. Symbols depicting Apple products are display-as-is only, non-customisable. <!-- src: sf-symbols -->
- Custom interface icons: vector (PDF/SVG) or a custom SF Symbol — never PNG sets; bake optical-centring into the asset; always provide accessibility labels. <!-- src: icons -->
