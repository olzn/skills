<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: pointing-devices -->

# macOS cursors — NSCursor semantic table (authoritative copy)

All semantics HIG-published (pointing-devices page; last change 2023-06-21 — stable, not rewritten for Liquid Glass; pointer behaviour carried into macOS 26 unchanged). Captured 2026-06-10. On macOS the pointer is **fixed-shape and semantic**: the cursor style signals the operation available. Use the standard AppKit `NSCursor` styles; pick the semantically correct one.

## nscursor-table

| Cursor | Show when |
|---|---|
| Arrow | Default — anywhere no other style applies. |
| Pointing hand | The element is a **URL link** — links only, never general buttons or controls. |
| Horizontal I-beam | Selection or insertion point in horizontal **editable text**. |
| Vertical I-beam | Selection or insertion point in vertical text. |
| Open hand | Content can be repositioned (grab-and-pan). |
| Closed hand | Actively dragging content position. |
| Drag copy | **Option held during a drag** — the drop will copy, not move. |
| Drag link | **Option-Command held during a drag** — the drop creates a link/alias. |
| Operation not allowed | The current target can't accept the drop. |
| Disappearing item | The drop will remove the dragged reference. |
| Contextual menu | Shown with Control pressed — a contextual menu is available. |
| Crosshair | Precise rectangular selection. |
| Resize down · left · right · up | Edge or divider resizable in that single direction. |
| Resize left-right · up-down | Edge or divider resizable in either direction along the axis. |
<!-- src: pointing-devices -->

## cursor-rules

- **Pointing hand = links only.** A button is not a link; standard controls keep the arrow.
- I-beam over editable or selectable text; restore the arrow elsewhere.
- During drags, the cursor narrates the outcome: open hand → closed hand while moving content; Option = drag copy; Option-Command = drag link; invalid target = operation not allowed; drop-removes-reference = disappearing item.
- **Consistent results across input types**: Option-drag duplicates whether dragging by touch or pointer.
- Never redefine systemwide trackpad gestures (Dock, Mission Control reveals), even in games — users customise them in System Settings.
- Pointer hover may reveal auto-minimising or fading controls (minimised toolbar, full-screen video); moving away hides them again.
- Secondary click reveals a contextual menu on content objects; force click (Quick Look/lookup) is an expected interaction.
- No decorative pointer styling or animation; no instructional text attached to the pointer (custom annotations such as X/Y values or image dimensions, à la Keynote, are fine).
<!-- src: pointing-devices -->

## reviewer-checks

- Cursor style correct per context: pointing hand only on links; I-beam over editable text; operation-not-allowed during invalid drop; Option-drag shows the drag-copy cursor.
- Secondary click produces a contextual menu on content objects.
- Anything that styles or animates the pointer itself decoratively → flag.
- Web prototypes of macOS UI: `cursor: pointer` on every button is a web convention, not a Mac one — flag it; use it for links only.
<!-- src: pointing-devices -->
