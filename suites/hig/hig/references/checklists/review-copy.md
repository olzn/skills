<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: writing, inclusion, offering-help, managing-accounts, settings, alerts, menus, buttons, segmented-controls, undo-and-redo, progress-indicators, privacy, windows, panels, popovers, sign-in-with-apple -->

# Review — copy lint

Mechanically checkable rules. Scan every user-facing string — labels, buttons, alerts, errors, empty states, tooltips, settings, placeholders — then judge hits in context before reporting. Severity: **[2] feels broken · [3] feels non-native**. Rejection-tier copy (tracking-screen wording, Sign in with Apple button titles, marketing-notification opt-in language) lives in `review-compliance.md`.

## feels-broken

- [2] "Click here" or bare "here" as link text — links use descriptive phrases ("Learn more about exporting"); screen-reader critical. <!-- src: writing -->
- [2] Wrong device verb: "click" anywhere in iOS/iPadOS copy; "tap" in macOS pointer contexts. <!-- src: writing, offering-help -->
- [2] Error messages without the fix, or with blame: "Choose a password with at least 8 characters", never "That password is too short" or "You entered the wrong…". Errors appear next to the problem — not in a distant toast or post-submit summary. <!-- src: writing -->
- [2] Auth controls name the method they invoke — "Sign In with Face ID", never generic "Sign In" beside a biometric glyph; never reference Face ID on Touch ID hardware. <!-- src: managing-accounts -->
- [2] "passcode" in account/auth copy — people reserve the word for device unlock and Apple services. <!-- src: managing-accounts -->
- [2] Purpose strings (permission alerts): a brief, complete, feature-specific sentence; active voice; sentence case; ends with a full stop. Good: "The app records during the night to detect snoring sounds." Flag passive-vague ("Microphone access is needed for a better experience.") and imperative ("Turn on microphone access."). <!-- src: privacy -->

## feels-non-native

**Buttons, alerts, menus**
- [3] Button labels: verbs or verb phrases, a few words, title-style capitalization — "Add to Cart"; flag cute labels ("Let's do it!") and bare OK/Yes/No where a verb fits. <!-- src: buttons, writing -->
- [3] Alert buttons: 1–2-word verbs tied to the alert text; "OK" only in purely informational alerts; never "Yes"/"No"; Cancel is always titled "Cancel"; a single-button informational alert uses "Done". <!-- src: alerts -->
- [3] Alert titles: never "Error" or a raw error code; at most 2 lines; fragment → title case, no end punctuation; complete sentence → sentence case + full stop. <!-- src: alerts -->
- [3] Never explain buttons in body text ("Tap OK to…"); if unavoidable, say *choose* with the exact button title, no quotation marks. <!-- src: alerts -->
- [3] Menu items: verb-first, title-style capitalization, no articles — "View Settings", not "View the Settings". <!-- src: menus -->
- [3] Ellipsis: append "…" to a menu item or macOS push button that needs more input before completing (opens another view or window); no ellipsis on immediate actions. <!-- src: menus, buttons -->
- [3] Undo: the iPhone shake alert auto-prefixes "Undo "/"Redo " — supply only one or two words ("Undo Name"); menu items name the operation ("Undo Typing", "Redo Bold"). <!-- src: undo-and-redo -->

**Terminology currency**
- [3] "Settings", never "Preferences" — macOS included (System Settings since macOS 13; the ⌘, shortcut is unchanged). <!-- src: settings -->
- [3] "Apple Account", not "Apple ID" (renamed 2024) — settings path is "Settings > Apple Account > …". <!-- src: sign-in-with-apple -->
- [3] "window", never "scene"; never the words "panel" or "popover" in UI strings or menu items — "Show Fonts", not "Show Fonts Panel". <!-- src: windows, panels, popovers -->

**Voice**
- [3] No "we/our/us" in errors or status: "Unable to load content", not "We're having trouble loading this content". <!-- src: writing, inclusion -->
- [3] "you/your", never "the user"/"the player"; plural nouns over gendered pronouns ("Subscribers can post recipes…", not "his or her"). <!-- src: inclusion -->
- [3] Possessives sparingly: "Favorites", not "Your Favorites"/"My Favorites"; if kept, one perspective app-wide — never mixed My/Your. <!-- src: writing -->
- [3] No interjections in errors or status — "oops!", "uh-oh" read insincere. <!-- src: writing -->
- [3] Flag colloquialisms, idioms, culture-bound humour, and undefined jargon (localisation and inclusion risk). <!-- src: inclusion -->

**Capitalisation and flows**
- [3] One capitalisation style per element type, applied consistently app-wide (title case reads formal, sentence case casual). Component rules override the app-level choice: menu items and button labels title-style; segment labels title-style nouns; macOS introductory labels title-style ending with a colon. <!-- src: writing, menus, buttons, segmented-controls -->
- [3] Multistep flows: open with "Get Started"-class language; advance with ONE of "Continue"/"Next" throughout — never mixed; close with "Done"-class language. <!-- src: writing -->

**Per-surface rules**
- [3] Tooltips (macOS only): 60–75 characters maximum; sentence case; no trailing full stop on complete sentences; verb-first ("Restore default settings"); never repeat the control's name. <!-- src: offering-help -->
- [3] Tips (TipKit): one or two sentences, action-oriented, no promotional content. <!-- src: offering-help -->
- [3] Empty states: a clear next step (button or link); never park crucial information there — it disappears. <!-- src: writing -->
- [3] Settings toggles: explanations describe only the ON state (people infer the opposite); link directly to a setting, never "go to Settings > … > …" prose. <!-- src: writing -->
- [3] Text fields: every field labelled; placeholder shows the expected format ("name@example.com"); corrections phrased positively ("Use only letters for your name", not "Don't use numbers or symbols"); never robotic ("Invalid name"). <!-- src: writing -->
- [3] Progress captions: avoid vague "Loading…"/"Authenticating…"; never caption a refresh control with instructions ("Pull to refresh"); never label a macOS spinner. <!-- src: progress-indicators -->
