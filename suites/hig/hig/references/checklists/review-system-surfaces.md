<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: widgets, live-activities, notifications, controls, app-shortcuts, snippets, always-on -->

# Review — system surfaces

The app's presence outside its own windows. The system renders the container, the app supplies content: **never draw what the system draws** (fake badges, duplicate Done/Cancel, faked avatars, mock chrome). T2 = feels broken · T3 = feels non-native; tier-1 consent/marketing rules: `review-compliance.md`. Nearly all of this is 2023–2026 material — never answer from priors.

## widgets

Rewritten 2025-12-16; tinted (iOS 18) and clear (iOS 26) appearances postdate most priors.

- T2 — Demand all four appearances: light, dark, **clear**, **tinted**. Clear/tinted desaturate everything — flag meaning carried by colour alone; it must survive in text/shape.
- T2 — The background must be a removable group: StandBy, CarPlay, and accented rendering strip it; no background colours in StandBy.
- T2 — Rendering modes are authored, not automatic: accented = accent + primary groups tinted solid (not supported in Mac Home contexts); vibrant (Lock Screen, Mac desktop) = full-opacity **opaque greyscale** — white/light grey primary, darker greys secondary, never white at partial opacity.
- T3 — Margins 16 pt (11 pt tight grouping); content radii concentric with the widget corner (ContainerRelativeShape).
- T2 — Text ≥ 11 pt; system font + text styles + SF Symbols preferred; never rasterised text; Dynamic Type Large→AX5.
- T2 — Interactivity = buttons and toggles only; all else deep-links to the relevant content; inline accessory widgets get exactly one tap target. Flag app-like layouts.
- T3 — Updates periodic, not real-time (that's Live Activities); system renders dates/times; update animations ≤ 2 s.
- T3 — Not an app-icon clone or brand tile (small logo in a top corner at most); don't stretch a small layout into a large one; gallery description verb-first, never "This widget shows…".
- macOS: desktop + Notification Center only — no Lock Screen accessories, StandBy, or tinted treatment; desktop widgets go vibrant when unfocused.

<!-- src: widgets -->

## live-activities

- T2 — All four presentations: **compact** (leading+trailing pair), **minimal**, **expanded**, **Lock Screen** — most mocks show only one.
- T2 — Lifecycle: bounded tasks ≤ 8 h; end when the event ends — the Dynamic Island clears at once but Lock Screen/Mac menu bar linger up to 4 h unless custom dismissal is set; **15–30 min is adequate in most cases**.
- T2 — Compact pair reads as one piece of information (consistent colour/typography across the gap); snug to the camera, no padding; balanced widths; both sides deep-link to the same screen.
- Numbers: island corner radius 44 pt; compact/minimal width 250 pt (Max/Plus/Air) / 230 pt (regular/Pro); expanded and Lock Screen width 408/371 pt, height 84–160 pt; **Lock Screen margin 14 pt**; macOS uses the iOS dimensions.
- T2 — No ads or promotions; no sensitive info (bystanders see it) — innocuous summary, opt-in detail.
- T3 — Key info medium weight+; logo mark without container, never the full app icon; concentric radii (outer − margin = inner); no content at the island edge; tint the key line; check dismiss-button colour. Not a notification clone.
- T2 — Alerts (screen lights up + expanded) only for must-see updates; never duplicate with a push notification; one Activity rotating events beats several concurrent.
- T3 — Animation ≤ 2 s, none on Always-On; prefer a single interactive element (CarPlay disables interactivity).
- T2 — Always-On variant: dim nonessential, keep the essential legible, redact sensitive data, finish in-progress motion gracefully — never an instant stop. <!-- src: always-on -->
- macOS: Activities start on iPhone/iPad only and surface **in the Mac menu bar** (click opens iPhone Mirroring) — flag any other Mac placement.

<!-- src: live-activities -->

## notifications-component

Interruption levels and Focus live on `managing-notifications`; tier-1 subset in `review-compliance.md`.

- T2 — Never multiple notifications for the same thing, even unanswered.
- T2 — Errors are alerts, not notifications.
- T3 — Title: brief, title-style capitalisation, no ending punctuation; generic best title ("New Document") → provide none, the app name shows. Body: complete sentences, sentence case; never self-truncate.
- T2 — No app name or icon in the content — the system shows the icon; sender avatars come via donated intents, never faked payload imagery.
- T2 — Personal content needs a hidden-previews placeholder that describes without revealing ("Friend request" — sentence case).
- T2 — Actions: ≤ 4; none that merely opens the app; nondestructive first (Watch double tap fires it); short title-case result labels; SF Symbol trailing.
- T2 — Badge = unread-notification count, nothing else; never the only channel; never custom UI mimicking a badge. Gotcha: badge zero clears the app's notifications from Notification Center.
- T3 — Foreground: no in-app replica of the system banner while frontmost — surface subtly in context.

<!-- src: notifications -->

## controls

Control Center / Lock Screen / Action button tiles (iOS 18+, WidgetKit + App Intents) — not generic UI controls. macOS hosts them in its Control Center; flag Lock Screen/Action button placements in Mac mocks.

- T2 — The symbol carries the meaning alone (Lock Screen shows symbol only). Toggles need one symbol per state (`door.garage.open`/`.closed`).
- T2 — Redact title/value when locked for personal/security info; security-affecting actions (unlock the door, start the car) require authentication (`IntentAuthenticationPolicy`).
- T2 — State honesty: actions with a duration animate while running, stop on completion; controls update on interaction, completion, and remote push — flag stale state.
- T3 — Action button hint text is a verb phrase; supply placeholder title/value; prompt for setup at add time.
- T2 — Locked camera: capture only while locked — anything more requires unlock; the locked UI matches the in-app camera.
- T3 — A control that merely opens the app adds no value (good pattern: launch a Live Activity).

<!-- src: controls -->

## app-shortcuts

Updated 2026-06-08 (app schemas) — verify schema guidance live. Not on macOS (App Intents actions still reach the Mac Shortcuts app); flag any "App Shortcut in Spotlight" Mac mock.

- T2 — The activation phrase includes the app name, brief and natural to say aloud.
- T2 — ≤ 1 optional parameter with predictable values; two-parameter phrases are the named anti-pattern — gather extras in a follow-up. Missing parameter → clarify with a likely default + short list.
- T2 — Hard cap: 10 App Shortcuts per app.
- T2 — Audio parity: all critical information in the full dialogue text — AirPods/HomePod users hear but don't see.
- T3 — Editorial: "App Shortcuts" and the "Shortcuts" app in title case, Shortcuts always plural; user-built "shortcut" lowercase.
- T3 — Order by importance; SF Symbol or preview image per shortcut; in-app discoverability tips (`SiriTipUIView`).
- T3 — 2026 rule: commodity-domain actions → adopt **app schemas** so Apple Intelligence surfaces them; App Shortcuts are for unique features schemas don't cover.

<!-- src: app-shortcuts -->

## snippets

New page 2026-06-08 — no pre-WWDC26 prior; not code snippets, not the deprecated Intents UI extensions. Result/confirmation views for Siri, Spotlight, and Shortcuts actions; iOS/iPadOS/macOS, no platform deltas.

- T2 — Custom view ≤ **400 pt** tall; more detail → deep-link into the app, never grow the view. Account for Dynamic Type — flag fixed heights that clip.
- T2 — Two types, one rule: **confirmation** (system Cancel + custom-label primary) optionally precedes the mandatory **result** (lone system Done).
- T3 — Confirmation primary label is a descriptive verb ("Order"), from `ConfirmationActionName` or custom; system default "Continue" — flag lazy OK/Proceed.
- T2 — Never duplicate the system buttons inside the custom view; prefer omitting the dialogue sentence from the visual — the system places dialogue above the view.
- T2 — Contrast checked against the system background in both light and dark; no hardcoded light-mode colours; consistent internal margins.

<!-- src: snippets -->
