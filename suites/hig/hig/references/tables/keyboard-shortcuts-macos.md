<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: keyboards -->

# Standard keyboard shortcuts — macOS (authoritative copy)

All rows HIG-published (keyboards page; last change 2025-06-09, which moved game key-binding guidance to Game controls; untouched in the 2026-06-08 drop). Captured 2026-06-10. Table is macOS-centric; iPadOS/iOS apps with hardware keyboards inherit the same expectations.

**Stripped from this copy** (4 rows Apple still lists but that reference retired features): Control-Command-Eject (restart) and Control-Option-Command-Eject (shut down) — no Eject key on modern Macs; F12 (Dashboard — removed in macOS 10.15); Option-Command-Grave (window drawers — deprecated AppKit concept). They remain in Apple's table, so still treat those combinations as reserved — don't repurpose them. <!-- src: keyboards -->

## shortcut-rules

- **Don't repurpose standard shortcuts.** Redefine one only if its action is meaningless in your app (Apple's example: no text editing → Command–I can become Get Info).
- Custom shortcuts: only for the most frequently used app-specific commands; too many makes an app seem hard to learn.
- Modifier preference: **Command** as main modifier; **Shift** as secondary complement to a related shortcut; **Option** sparingly, for power features; **avoid Control** (system-reserved).
- **Modifier listing order: Control, Option, Shift, Command** — symbols ⌃ ⌥ ⇧ ⌘.
- Don't add Shift to a shortcut using the upper character of a two-character key (Help is Command–Question mark, not Shift–Command–Slash).
- Let the system localise and mirror shortcuts (RTL); avoid non-Command modifiers with characters not on all keyboards (e.g. Option-5 = "{" on French keyboards).
- Support Full Keyboard Access. iPadOS: don't implement keyboard navigation for buttons/segmented controls/switches — leave that to Full Keyboard Access.
<!-- src: keyboards -->

## standard-shortcuts

| Primary key | Keyboard shortcut | Action |
|---|---|---|
| Space | Command-Space | Show or hide the Spotlight search field. |
| Space | Shift-Command-Space | Varies. |
| Space | Option-Command-Space | Show the Spotlight search results window. |
| Space | Control-Command-Space | Show the Special Characters window. |
| Tab | Shift-Tab | Navigate through controls in a reverse direction. |
| Tab | Command-Tab | Move forward to the next most recently used app in a list of open apps. |
| Tab | Shift-Command-Tab | Move backward through a list of open apps (sorted by recent use). |
| Tab | Control-Tab | Move focus to the next group of controls in a dialog or the next table (when Tab moves to the next cell). |
| Tab | Control-Shift-Tab | Move focus to the previous group of controls. |
| Esc | Esc | Cancel the current action or process. |
| Esc | Option-Command-Esc | Open the Force Quit dialog. |
| F1 | Control-F1 | Toggle full keyboard access on or off. |
| F2 | Control-F2 | Move focus to the menu bar. |
| F3 | Control-F3 | Move focus to the Dock. |
| F4 | Control-F4 | Move focus to the active (or next) window. |
| F4 | Control-Shift-F4 | Move focus to the previously active window. |
| F5 | Control-F5 | Move focus to the toolbar. |
| F5 | Command-F5 | Turn VoiceOver on or off. |
| F6 | Control-F6 | Move focus to the first (or next) panel. |
| F6 | Control-Shift-F6 | Move focus to the previous panel. |
| F7 | Control-F7 | Temporarily override the current keyboard access mode in windows and dialogs. |
| F8 | — | Varies. |
| F9 | — | Varies. |
| F10 | — | Varies. |
| F11 | — | Show desktop. |
| Grave accent (`) | Command-Grave accent | Activate the next open window in the frontmost app. |
| Grave accent (`) | Shift-Command-Grave accent | Activate the previous open window in the frontmost app. |
| Hyphen (-) | Command-Hyphen | Decrease the size of the selection. |
| Hyphen (-) | Option-Command-Hyphen | Zoom out when screen zooming is on. |
| Left bracket ({) | Command-Left bracket | Left-align a selection. |
| Right bracket (}) | Command-Right bracket | Right-align a selection. |
| Pipe (\|) | Command-Pipe | Center-align a selection. |
| Colon (:) | Command-Colon | Display the Spelling window. |
| Semicolon (;) | Command-Semicolon | Find misspelled words in the document. |
| Comma (,) | Command-Comma | Open the app's settings window. |
| Comma (,) | Control-Option-Command-Comma | Decrease screen contrast. |
| Period (.) | Command-Period | Cancel an operation. |
| Period (.) | Control-Option-Command-Period | Increase screen contrast. |
| Question mark (?) | Command-Question mark | Open the app's Help menu. |
| Forward slash (/) | Option-Command-Forward slash | Turn font smoothing on or off. |
| Equal sign (=) | Shift-Command-Equal sign | Increase the size of the selection. |
| Equal sign (=) | Option-Command-Equal sign | Zoom in when screen zooming is on. |
| 3 | Shift-Command-3 | Capture the screen to a file. |
| 3 | Control-Shift-Command-3 | Capture the screen to the Clipboard. |
| 4 | Shift-Command-4 | Capture a selection to a file. |
| 4 | Control-Shift-Command-4 | Capture a selection to the Clipboard. |
| 8 | Option-Command-8 | Turn screen zooming on or off. |
| 8 | Control-Option-Command-8 | Invert the screen colors. |
| A | Command-A | Select every item in a document or window, or all characters in a text field. |
| A | Shift-Command-A | Deselect all selections or characters. |
| B | Command-B | Boldface the selected text or toggle boldfaced text on and off. |
| C | Command-C | Copy the selection to the Clipboard. |
| C | Shift-Command-C | Display the Colors window. |
| C | Option-Command-C | Copy the style of the selected text. |
| C | Control-Command-C | Copy the formatting settings of the selection and store on the Clipboard. |
| D | Option-Command-D | Show or hide the Dock. |
| D | Control-Command-D | Display the definition of the selected word in the Dictionary app. |
| E | Command-E | Use the selection for a find operation. |
| F | Command-F | Open a Find window. |
| F | Option-Command-F | Jump to the search field control. |
| F | Control-Command-F | Enter full screen. |
| G | Command-G | Find the next occurrence of the selection. |
| G | Shift-Command-G | Find the previous occurrence of the selection. |
| H | Command-H | Hide the windows of the currently running app. |
| H | Option-Command-H | Hide the windows of all other running apps. |
| I | Command-I | Italicize the selected text or toggle italic text on or off. |
| I | Command-I | Display an Info window. |
| I | Option-Command-I | Display an inspector window. |
| J | Command-J | Scroll to a selection. |
| M | Command-M | Minimize the active window to the Dock. |
| M | Option-Command-M | Minimize all windows of the active app to the Dock. |
| N | Command-N | Open a new document. |
| O | Command-O | Display a dialog for choosing a document to open. |
| P | Command-P | Display the Print dialog. |
| P | Shift-Command-P | Display the Page Setup dialog. |
| Q | Command-Q | Quit the app. |
| Q | Shift-Command-Q | Log out the person currently logged in. |
| Q | Option-Shift-Command-Q | Log out the person currently logged in without confirmation. |
| S | Command-S | Save a new document or save a version of a document. |
| S | Shift-Command-S | Duplicate the active document or initiate a Save As. |
| T | Command-T | Display the Fonts window. |
| T | Option-Command-T | Show or hide a toolbar. |
| U | Command-U | Underline the selected text or turn underlining on or off. |
| V | Command-V | Paste the Clipboard contents at the insertion point. |
| V | Shift-Command-V | Paste as (Paste as Quotation, for example). |
| V | Option-Command-V | Apply the style of one object to the selection. |
| V | Option-Shift-Command-V | Paste the Clipboard contents at the insertion point and apply the style of the surrounding text to the inserted object. |
| V | Control-Command-V | Apply formatting settings to the selection. |
| W | Command-W | Close the active window. |
| W | Shift-Command-W | Close a file and its associated windows. |
| W | Option-Command-W | Close all windows in the app. |
| X | Command-X | Remove the selection and store on the Clipboard. |
| Z | Command-Z | Undo the previous operation. |
| Z | Shift-Command-Z | Redo (when Undo and Redo are separate commands rather than toggled using Command-Z). |
| Right arrow | Command-Right arrow | Change the keyboard layout to current layout of Roman script. |
| Right arrow | Shift-Command-Right arrow | Extend selection to the next semantic unit, typically the end of the current line. |
| Right arrow | Shift-Right arrow | Extend selection one character to the right. |
| Right arrow | Option-Shift-Right arrow | Extend selection to the end of the current word, then to the end of the next word. |
| Right arrow | Control-Right arrow | Move focus to another value or cell within a view, such as a table. |
| Left arrow | Command-Left arrow | Change the keyboard layout to current layout of system script. |
| Left arrow | Shift-Command-Left arrow | Extend selection to the previous semantic unit, typically the beginning of the current line. |
| Left arrow | Shift-Left arrow | Extend selection one character to the left. |
| Left arrow | Option-Shift-Left arrow | Extend selection to the beginning of the current word, then to the beginning of the previous word. |
| Left arrow | Control-Left arrow | Move focus to another value or cell within a view, such as a table. |
| Up arrow | Shift-Command-Up arrow | Extend selection upward in the next semantic unit, typically the beginning of the document. |
| Up arrow | Shift-Up arrow | Extend selection to the line above, to the nearest character boundary at the same horizontal location. |
| Up arrow | Option-Shift-Up arrow | Extend selection to the beginning of the current paragraph, then to the beginning of the next paragraph. |
| Up arrow | Control-Up arrow | Move focus to another value or cell within a view, such as a table. |
| Down arrow | Shift-Command-Down arrow | Extend selection downward in the next semantic unit, typically the end of the document. |
| Down arrow | Shift-Down arrow | Extend selection to the line below, to the nearest character boundary at the same horizontal location. |
| Down arrow | Option-Shift-Down arrow | Extend selection to the end of the current paragraph, then to the end of the next paragraph (include the paragraph terminator, such as Return, in cut, copy, and paste operations). |
| Down arrow | Control-Down arrow | Move focus to another value or cell within a view, such as a table. |
<!-- src: keyboards -->

## input-source-shortcuts

For localised systems, keyboards, layouts and input methods; these don't correspond directly to menu commands.

| Keyboard shortcut | Action |
|---|---|
| Control-Space | Toggle between the current and last input source. |
| Control-Option-Space | Switch to the next input source in the list. |
| [Modifier key]-Command-Space | Varies. |
| Command-Right arrow | Change keyboard layout to current layout of Roman script. |
| Command-Left arrow | Change keyboard layout to current layout of system script. |
<!-- src: keyboards -->

## coverage-notes

- The standard set defines **no Command-K, Command-L, Command-R or Command-Y rows** — those are app conventions (e.g. Command-R reload in Safari), free for apps to define as custom shortcuts.
- Two Command-I meanings coexist (Italicize vs Info window) — Apple's sanctioned repurposing example.
<!-- src: keyboards -->

## reviewer-checks

- Every frequently used menu command has a shortcut; standard shortcuts map to their standard meanings (especially Command-Comma → Settings; Command-W closes the window, not the app; Command-Q quits; Command-Z/Shift-Command-Z undo/redo).
- Shortcut strings rendered in UI: modifiers in Control-Option-Shift-Command order, symbols ⌃⌥⇧⌘; no "Shift-Command-/"-style mistakes for upper characters.
- Custom shortcuts: flag any collision with the table above unless the standard action is genuinely inapplicable; flag Control as a modifier.
- SwiftUI: `.keyboardShortcut` on primary actions; a `Settings` scene gives Command-Comma free on macOS.
<!-- src: keyboards -->
