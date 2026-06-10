<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: accessibility, inclusion, privacy, right-to-left, writing -->

# Foundations — people

## accessibility
<!-- src: accessibility · changed: 2025-06-09 · platforms: iOS, iPadOS, macOS · speed: full -->

Apple's frame: accessible = **Intuitive**, **Perceivable** (no single method conveys information), **Adaptable**. VoiceOver guidance split to its own `voiceover` page on 2025-03-07 — cite that slug.

**The numbers** (copies — authoritative: `tables/accessibility-sizes.md`): <!-- src: tables/accessibility-sizes.md -->
- Control size: iOS/iPadOS default **44×44 pt**, minimum **28×28 pt**; macOS default **28×28 pt**, minimum **20×20 pt**.
- Spacing: ~**12 pt** padding around bezeled controls; ~**24 pt** around visible edges of bezel-less ones.
- Type: iOS default **17 pt** / minimum **11 pt**; macOS **13 pt / 10 pt**. Support text enlargement to at least **200%**.
- Contrast (Accessibility Inspector applies WCAG AA; APCA also accepted): ≥**4.5:1** up to 17 pt; ≥**3:1** at 18 pt+; ≥**3:1** bold at any size. Check both appearances if Dark Mode is supported.

**Vision.** Prefer system-defined colors (accessible variants built in). If default contrast can't be met, provide a higher-contrast scheme under Increase Contrast. Never convey information with colour alone — add shapes or icons (worst pairings: red–green, blue–orange). Thin custom fonts: go larger.

**Hearing.** Never audio-only for crucial information. Pick the right text alternative: **Captions** (synced, audible info), **Subtitles** (dialogue, preferred language), **Audio descriptions** (visual-only info, spoken), **Transcripts** (audible + visual, complete text). Pair audio cues with matching haptics; add visual cues for off-screen events.

**Mobility / keyboard.** Simplest gesture possible for frequent interactions; no custom multifinger gestures. **Every gesture-driven core function needs an onscreen equivalent** (swipe-to-dismiss also needs a button). Label elements so Voice Control works; support VoiceOver, AssistiveTouch, Pointer Control, Switch Control, and Full Keyboard Access end to end; never override system-defined keyboard shortcuts.

**Cognitive.** Prefer system gestures over learned custom ones. Minimise time-boxed UI — auto-dismissing views need an explicit dismissal alternative. No autoplay without discoverable start/stop controls. Respect **Dim Flashing Lights** in video. Under **Reduce Motion**: tighten springs, track animations with gestures, no z-axis depth animation, **replace x/y/z transitions with fades**, don't animate into/out of blurs.

**Assistive Access** (iOS/iPadOS only): streamlined-app mode — strip noncritical workflows, **one interaction per screen** in multistep flows, **confirm twice** for hard-to-recover actions. **Accessibility Nutrition Labels** (App Store Connect, 2025) declare supported accessibility features — distinct from privacy nutrition labels.

**Liquid Glass.** Reduce Transparency and Increase Contrast swap translucent materials for opaque variants — designs must survive that swap; check contrast over varied content in both appearances.

**iOS vs macOS.** The numeric tables above are the divergence; Assistive Access, Music Haptics, Audio graphs are iOS/iPadOS-only; Full Keyboard Access is table-stakes on macOS.

**Reviewer checks.**
- Smallest interactive element: flag < 44×44 pt on iOS (hard-fail < 28×28); < 28×28 pt on macOS (hard-fail < 20×20). Padding: bezeled < 12 pt, bezel-less < 24 pt. <!-- src: tables/accessibility-sizes.md -->
- Text below 11 pt (iOS) / 10 pt (macOS) = violation; below the 17/13 default = warn for primary content.
- WCAG AA contrast on every text/background and icon/background pair; repeat in dark mode.
- Colour-only state signalling (red vs green dot, same shape) = violation.
- Auto-dismissing toast with no dismiss affordance; gesture-only core action; autoplaying media without controls; hard-coded hex where a semantic colour exists (loses Increase Contrast variants).
- Dynamic Type claims: text containers survive 200% scaling without truncation.

**Stale priors.**
- Was: a single 44×44 pt rule. → Now: iOS default 44×44 / minimum 28×28 — recommend 44, don't call 28-pt controls automatic violations; macOS gained 28/20 targets (since 2025).
- Was: Dynamic Type tables here. → Now: on the typography page; VoiceOver on its own page (since 2025-03-07).
- Post-2025 vocabulary models miss: Assistive Access, Accessibility Nutrition Labels, Music Haptics, Dim Flashing Lights, APCA.

## inclusion
<!-- src: inclusion · changed: stable (pre-2025) · platforms: all · speed: stub -->
Inoffensive ≠ inclusive — inclusion is a positive design goal. The non-obvious rules:
- Address people as "you/your"; never "the user"/"the player". Reserve "we/our" for the company — and avoid "we" entirely in errors (Writing's stricter rule wins there).
- Replace colloquialisms with plain language (Apple's negative examples: "peanut gallery", "grandfathered in"); humour is culture-bound and wears thin; define or drop jargon.
- Strip unnecessary gender: plural nouns over "his or her"; nongendered glyphs for generic people (`person.crop.circle`, `figure.wave`); if gender data is genuinely required, offer nonbinary, self-identify, and decline-to-state.
- Imagery: range of racial backgrounds, body types, ages, capabilities; no stereotyped role casting; relatable settings over affluence.
- Security questions must not assume cultural experience (first car, college subject); use universal experiences ("name of your first friend").
- People-first language for disability; disabilities are permanent, temporary, or situational; never use disability as a negative metaphor.
- Colour meaning is culture-specific (white = grief in some locales) — verify per locale; internationalise before localising.
Fetch for detail: inclusion

## privacy
<!-- src: privacy · changed: 2023-06-21 · platforms: all · speed: full -->

Several rules here are App Store rejection criteria, not style advice.

**Requesting access.** Request only what a feature actually needs, when the person first uses that feature — never at launch unless the app can't function without it (navigation + location is Apple's example). Permission-gated: personal data (location, health, contacts, PII), user-generated content (messages, calendar, photos, audio/video), protected resources (Bluetooth, local network, home automation), device capabilities (camera, microphone), the advertising identifier.

**Purpose strings.** A brief, complete sentence; specific; sentence case; active voice; ends with a full stop. Good: "The app records during the night to detect snoring sounds." Bad: "Microphone access is needed for a better experience." (passive, vague); "Turn on microphone access." (imperative, no justification).

**Pre-alert custom screens** (shown before the system permission alert):
- **Exactly one button**, which clearly opens the system alert.
- Button title like **"Continue" or "Next" — never "Allow"** (mimicking the alert's button manipulates choice).
- **No other actions** — no close, no cancel, no bypass.

**Tracking (App Tracking Transparency) — App Review enforces this** (Guideline 5.1.1(iv)). Show the system alert before collecting any tracking data. Designs that cause rejection: incentives to allow tracking; a screen resembling the system request; an image of the alert; annotating the screen behind the alert (arrows/highlights at "Allow").

**Location button** (iOS/iPadOS — no macOS equivalent): one-time location authorisation per tap. Customisable ONLY in: system-provided title ("Current Location" / "Share My Current Location"), filled vs outlined glyph, background colour, title/glyph colour, corner radius. The title must fit untruncated at all accessibility sizes and languages; persistent low contrast or excess translucency makes the system silently stop granting location.

**Protecting data.** **Prefer passkeys**; if passwords, add two-factor; Face ID / Touch ID for re-authentication (macOS too). Sensitive data in the **Keychain, never plain-text files**. Never invent custom authentication — passkeys, Sign in with Apple, or Password AutoFill. Process on device where possible; adopt system protections (CloudKit encryption). App Store privacy details (privacy "nutrition labels") are mandatory at submission.

**macOS.** Valid Developer ID for outside-store distribution; App Sandbox required for the Mac App Store; never assume who is signed in — fast user switching means multiple active users per machine.

**Reviewer checks.**
- Permission alerts at launch without functional necessity → violation.
- Purpose strings: complete sentence, active voice, feature-specific reason, full stop — not "for a better experience".
- Pre-alert screens: exactly one button; label Continue/Next-class, never "Allow"/"OK"; no skip/close affordance.
- Tracking screens: any incentive, alert mockup image, or annotation pointing at "Allow" → rejection-tier violation.
- Password-only custom sign-in → flag; expect passkeys / Sign in with Apple / AutoFill.
- Forms requesting fields the visible feature doesn't need; macOS UI assuming a single signed-in user → flag.

**Stale priors.** Unchanged since 2023 yet still authoritative — it survived the 2025 rewrite. Don't merge **privacy nutrition labels** (App Store privacy details, 2020) with **Accessibility Nutrition Labels** (2025, accessibility page). Recommendation order: passkeys → passwords + 2FA → biometric re-auth — stronger than older password-first priors. The one-button/never-"Allow" and 5.1.1(iv) rules are precise and testable — don't paraphrase loosely.

## right-to-left
<!-- src: right-to-left · changed: stable (pre-2025) · platforms: all · speed: stub -->
Frameworks flip standard components automatically; these are the manual-judgement rules. Model errors run both ways — over-flipping (photos, logos, clocks) and under-flipping (slider direction, numeral order).
- **Flip:** sliders/progress indicators including their start/end glyphs; the **order** of numerals along progress/rating scales; back/next controls (back points RIGHT in RTL); icons depicting text blocks or motion direction (speaker waves emanate from the right); image sequences whose order is meaningful.
- **Never flip:** digit order within a number (phone numbers, "541" — never reverse, never mirror glyphs); photographs/illustrations (make an RTL version if reading-direction-bound); logos; universal marks (checkmark); real-world objects (clocks, pencils); right-handed-tool icons; the SF Symbols prohibition slash (stays a backslash).
- Paragraphs of **3+ lines** align to their language; 1–2-line text aligns to the UI context; all items in a list share one alignment, even across scripts.
- Arabic/Hebrew next to all-caps Latin reads too small (no uppercase in those scripts) — increase the RTL script ~**+2 pt**.
- Controls naming an actual direction ("to the right") keep pointing that way.
- HTML prototypes: logical properties (`dir="rtl"`, start/end), never hard left/right — otherwise flipping is impossible.
Fetch for detail: right-to-left

## writing
<!-- src: writing · changed: 2025-12-16 · platforms: all · speed: full -->

Voice = stable app personality (derive from audience; keep a term list); tone = situational (fall-detection direct, move-streak light). Page created 2023-02-27 — older models have no Writing page to cite.

**Rules.**
- Most important information first; one idea per screen; every word earns its place; read copy aloud.
- Action-oriented: **button/link labels are almost always verbs** — "Send" beats "Let's do it!". **Never "Click here"** as link text; use descriptive phrases (screen-reader critical).
- Capitalization is an app-level choice per element type (title case formal, sentence case casual), applied consistently; component pages (Buttons, Alerts) override.
- Multistep flows: open "Get Started"-class; advance with **one** of "Continue"/"Next" (never mix); close "Done"-class.
- **Possessive pronouns sparingly:** "Favorites" over "Your Favorites"; if used, one perspective app-wide (never mix My/Your). **Avoid "we" altogether:** "Unable to load content", not "We're having trouble loading this content".
- Device vocabulary: say **"tap" on iPhone/iPad, "click" only in macOS** pointer contexts.
- Empty states: welcome + educate + a clear next step (button or link); **never park crucial information there** — it disappears.
- Errors: prevent first; message **as close to the problem as possible**; no blame; state the fix ("Choose a password with at least 8 characters", not "That password is too short"); **no interjections** ("oops!", "uh-oh"). If language can't fix a common error, redesign the interaction.
- Settings: toggle explanations describe **only the ON state** (people infer the opposite); link directly to a setting rather than describing its path.
- Text fields: label every field; placeholder shows format ("name@example.com"); errors inline by the field, phrased positively ("Use only letters…", not "Don't use numbers or symbols"); never robotic ("Invalid name").

**iOS vs macOS.** Only the tap/click vocabulary split; brevity pressure scales with screen size and viewing distance.

**Reviewer checks.** Highest-yield scans: "Click here"/bare "here" links (violation); "click" in iOS copy / "tap" in macOS copy (violation); "we/our/us" in errors or status; "My …/Your …" prefixes; mixed Continue/Next within one flow; mixed capitalization within one element type; interjections or blame in errors; empty states without a next-step action; settings prose describing both toggle states or a "go to Settings > …" path; non-inline validation.

**Stale priors.**
- Was: "My …/Your …" labels (legacy "My Watch" pattern). → Now: drop the possessive — "Favorites" (since 2025-12-16).
- Was: apologetic "we" error voice. → Now: avoid "we" entirely; impersonal "Unable to …" (since 2025-12-16).
