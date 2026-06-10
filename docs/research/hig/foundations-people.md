# HIG research notes — foundations-people

> Bucket: human-centred Foundations pages (accessibility, inclusion, privacy, right-to-left, writing) plus the VoiceOver page (Technologies section — split out of Accessibility in March 2025, so it belongs with this material).
> Source: Apple JSON content API (`developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`), fetched 2026-06-10.
> Currency: none of these six pages changed at WWDC 2026 (2026-06-08). Most recent edits — Writing 2025-12-16, Accessibility 2025-06-09, VoiceOver 2025-03-07 (new page), Privacy 2023-06-21, Inclusion and Right to left stable.

---

## Accessibility

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/accessibility
**Platforms:** all. **Last change:** 2025-06-09 (Assistive Access, Switch Control, Accessibility Nutrition Labels). Major rewrite 2025-03-07 (Dynamic Type guidance moved to Typography page; VoiceOver split into its own page).

### Purpose
Governs making interfaces usable regardless of capability or how people use their devices. Apple's frame: an accessible interface is **Intuitive** (familiar, consistent interactions), **Perceivable** (no single method conveys information — sight, hearing, speech, or touch all work), **Adaptable** (supports system accessibility features and personalisation). Organised by human capability: Vision, Hearing, Mobility, Speech, Cognitive.

### Normative rules — exact specs

**Vision**
- Support text enlargement of **at least 200%** (140% for watchOS), via Dynamic Type or custom UI.
- Default/minimum sizes for custom type styles:

| Platform | Default size | Minimum size |
|---|---|---|
| iOS, iPadOS | **17 pt** | **11 pt** |
| macOS | **13 pt** | **10 pt** |
| (tvOS 29/23, visionOS 17/12, watchOS 16/12 — out of scope) |

- Thin-weight custom fonts: go **larger** than the recommended sizes.
- Colour contrast — Accessibility Inspector applies **WCAG Level AA**:

| Text size | Text weight | Minimum contrast ratio |
|---|---|---|
| Up to 17 pt | All | **4.5:1** |
| 18 pt and up | All | **3:1** |
| All sizes | Bold | **3:1** |

- APCA is named alongside WCAG as an accepted measure.
- If the app can't meet contrast by default, it MUST provide a higher-contrast scheme when the system **Increase Contrast** setting is on.
- If the app supports Dark Mode, check contrast in **both** light and dark appearances.
- **Prefer system-defined colors** — they have built-in accessible variants that adapt to Increase Contrast and light/dark.
- **Convey information with more than color alone** — add distinct shapes or icons (problem pairings: red-green, blue-orange). Consider user-customisable colour schemes (charts, game characters).

**Hearing**
- Don't communicate dialogue/crucial info through audio alone. Apple's four distinct text alternatives (use the right one): **Captions** (textual equivalent of audible info, synced live — cutscenes, clips), **Subtitles** (live onscreen dialogue in preferred language — TV/movies), **Audio descriptions** (spoken narration of visual-only info in natural pauses), **Transcripts** (complete textual description of both audible and visual info — podcasts, audiobooks).
- Pair audio cues (success chime, error sound) with **matching haptics**. iOS/iPadOS extras: Music Haptics, Audio graphs.
- Augment audio cues with visual cues, especially for off-screen events.

**Mobility**
- Control sizes:

| Platform | Default control size | Minimum control size |
|---|---|---|
| iOS, iPadOS | **44×44 pt** | **28×28 pt** |
| macOS | **28×28 pt** | **20×20 pt** |

- Spacing is as important as size: **~12 pt padding around bezeled elements; ~24 pt around the visible edges of bezel-less elements**.
- Use the **simplest gesture possible** for frequent interactions; avoid custom multifinger/multihand gestures.
- **Offer alternatives to gestures**: every gesture-driven core function needs an onscreen equivalent (e.g. swipe-to-dismiss also needs a visible button).
- Label elements properly so **Voice Control** works; integrate Siri/Shortcuts for voice-only task automation.
- Support VoiceOver, AssistiveTouch, Full Keyboard Access, Pointer Control, **Switch Control**.

**Speech / keyboard**
- Support **Full Keyboard Access** (entire app navigable by keyboard alone). **Avoid overriding system-defined keyboard shortcuts.**
- Support **Switch Control** (control via separate hardware, game controllers, or sounds like a click or pop).

**Cognitive**
- Prefer system gestures/behaviours over custom ones people must learn.
- **Minimize time-boxed UI**: views/controls that auto-dismiss on a timer are problematic; prefer explicit dismissal actions.
- Don't autoplay audio/video without discoverable start/stop controls; consider a global opt-out setting.
- Respond to the **Dim Flashing Lights** setting in video playback.
- When **Reduce Motion** is on, reduce automatic and repetitive animation (zooming, scaling, peripheral motion). Apple's explicit reduced-motion techniques: tighten animation springs (less bounce); track animations directly with gestures; avoid animating z-axis depth changes; **replace x/y/z transitions with fades**; avoid animating into/out of blurs.
- **Assistive Access** (iOS/iPadOS streamlined-app mode): identify core functionality and remove noncritical workflows/UI; **one interaction per screen** in multistep workflows; **ask for confirmation twice** for hard-to-recover actions (e.g. deleting a file).
- App Store **Accessibility Nutrition Labels** (managed in App Store Connect) communicate which accessibility features the app supports.

### iOS vs macOS
- Tap/click targets: iOS default 44×44 pt (min 28×28); macOS default 28×28 pt (min 20×20).
- Body type: iOS default 17 pt (min 11); macOS default 13 pt (min 10).
- Assistive Access is iOS/iPadOS only. Music Haptics/Audio graphs are iOS/iPadOS. Full Keyboard Access matters on both but is table-stakes on macOS.
- Otherwise the page explicitly says "No additional considerations for iOS … or macOS" — guidance is shared.

### Reviewer checks (automatable)
1. Measure smallest interactive element: flag < 44×44 pt on iOS (hard-fail < 28×28); flag < 28×28 pt on macOS (hard-fail < 20×20).
2. Measure inter-control padding: flag bezeled controls with < 12 pt clearance; bezel-less with < 24 pt from visible edges.
3. Body/label text below 11 pt (iOS) / 10 pt (macOS) = violation; below 17/13 default = warn for primary content.
4. Run WCAG AA contrast on every text/background and icon/background pair: ≥ 4.5:1 up to 17 pt; ≥ 3:1 at 18 pt+ or bold. Repeat in dark mode if supported.
5. Any state/status conveyed by colour only (e.g. red vs green dot with same shape) = violation.
6. Any toast/banner/view that auto-dismisses on a timer without an explicit dismiss affordance = flag.
7. Any gesture-only core action (swipe to delete/dismiss with no button equivalent) = violation.
8. Autoplaying media without visible playback controls = violation.
9. Hard-coded hex colours where a semantic system colour exists = warn (loses Increase Contrast variants).
10. Custom multifinger gestures for frequent actions = flag.
11. For prototypes claiming Dynamic Type support: text containers must survive 200% text scaling without truncation.

### Stale-knowledge corrections
- **Page restructured 2025**: Dynamic Type details now live on the Typography page; VoiceOver has its own Technologies page. A model citing "the accessibility page's Dynamic Type table" is out of date.
- **The 28×28 pt iOS minimum is current framing**: older HIG stated 44×44 pt as the single rule. Current guidance distinguishes *default* (44×44) from *minimum* (28×28). Recommend designs to 44 but don't claim 28-pt controls are automatic violations.
- **macOS now has explicit numeric targets** (28×28 default / 20×20 min) — pre-2025 HIG gave no macOS control-size numbers.
- **APCA** is now named as an accepted contrast standard alongside WCAG.
- **New 2025 vocabulary** models may not know: Assistive Access, Accessibility Nutrition Labels, Music Haptics, Dim Flashing Lights.
- Liquid Glass context: translucent materials make contrast checking *in both appearances and over varied content* more important; the system Reduce Transparency/Increase Contrast settings swap materials for opaque variants — designs must not break when that happens.

---

## VoiceOver (Technologies section — covered here because it's the 2025 split-out of accessibility content)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/voiceover
**Platforms:** all. **New page 2025-03-07.**

### Purpose
Governs how an app describes its interface and content to the VoiceOver screen reader so blind/low-vision people can navigate without seeing the display.

### Normative rules
- **Provide alternative labels for all key interface elements** (alt labels aren't visible onscreen). System controls have generic default labels — override with app-specific descriptive labels. Label all custom elements. Keep labels up to date as content changes.
- **Describe meaningful images** — but describe only the information the image itself conveys (VoiceOver already reads nearby captions; don't duplicate).
- **Make charts/infographics fully accessible**: concise description of what each conveys + expose any interactive exploration to VoiceOver via accessibility APIs.
- **Exclude purely decorative images** from VoiceOver (reduces cognitive load and respects time).
- **Unique titles + accurate section headings**: the title is the *first* thing announced on arrival at a screen; headings build the mental model of hierarchy.
- **Specify grouping/order/links**: relationships that are only visual (proximity, alignment) must be described. Canonical example: group each image with its caption so VoiceOver reads image+caption pairs, not all images then all captions. Reading order follows the active language/locale (US English: top-to-bottom, left-to-right).
- **Report visible content/layout changes** to VoiceOver (AccessibilityNotification) so users' mental maps stay accurate.
- **Support the VoiceOver rotor** where possible (navigate by headings, links, content type; braille keyboard).

### iOS vs macOS
None — page states no additional considerations for either. (API names differ: SwiftUI accessibility modifiers / UIKit / AppKit NSAccessibilityCustomRotor.)

### Reviewer checks
1. Every interactive element has a non-generic accessible label (no "Button", "Image" defaults). In HTML prototypes: aria-label/alt present and descriptive.
2. Decorative images marked hidden from assistive tech (alt="" / accessibilityHidden) — flag described decorations as noise.
3. Every screen has a unique, descriptive title; long screens have section headings (proper heading semantics, not styled text).
4. Image+caption (and similar visual pairs) grouped as single accessibility elements; reading order matches visual logic.
5. Alt text that duplicates an adjacent visible caption = flag.
6. Charts have text descriptions; interactive chart features have accessible equivalents.
7. Dynamic content regions announce changes (live regions in HTML terms).

### Stale-knowledge corrections
- This page **did not exist before March 2025**; models will look for this guidance inside the Accessibility page. Cite `voiceover` slug.
- Guidance is design-level now (what to describe, grouping, rotor) — the old accessibility page mixed it with developer API detail.

---

## Inclusion

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/inclusion
**Platforms:** all. No recent alert; content stable.

### Purpose
Governs respectful communication and content/functionality that everyone can access and understand — copy tone, imagery, gender, stereotypes, approachability, and localisation-readiness. Key framing: *inoffensive ≠ inclusive*; inclusion is a positive design goal, not just offence-removal.

### Normative rules
**Welcoming language**
- Address people directly as **"you/your"**; avoid "the user"/"the player" (distant, unwelcoming).
- **Reserve "we/our" for the software or company** — otherwise risks seeming condescending. (Writing page goes further: avoid "we" entirely in errors.)
- Don't use specialised/technical terms without defining them; prefer plain language (also easier to translate).
- **Replace colloquial expressions with plain language** — many are culture-specific or have exclusionary origins (Apple's examples: "peanut gallery", "grandfathered in").
- **Consider carefully before including humor** — subjective, hard to translate, wears thin on repetition.

**Approachability**
- No prerequisite skills/knowledge to start; clear path to deepen understanding. Provide skippable step-by-step onboarding.

**Gender identity**
- Avoid unnecessary gender references in copy. Apple's worked example: replace "You can let a subscriber post his or her recipes…" with "Subscribers can post recipes…" (gender-neutral noun, no singular gendered pronouns — also localises better into gendered languages).
- Prefer letting people customise avatars/emoji/characters rather than assigning gender.
- For generic person imagery use **nongendered glyphs** — SF Symbols `person.crop.circle`, `person.3.fill`, `figure.wave` etc.
- If gender data is genuinely required (health/legal), offer **nonbinary, self-identify, and decline to state**; consider letting people specify pronouns.

**People and settings (imagery)**
- Portray a range of racial backgrounds, body types, ages, physical capabilities. Avoid stereotyped occupations (only male doctors, female nurses). Avoid showing affluence that reads as out of touch; prefer relatable places/objects.

**Avoiding stereotypes**
- Don't assume family structure, education, car ownership, sensory ability. Apple's example: security questions like "favorite subject in college" / "make of your first car" / "how did you feel when you first saw a rainbow" exclude; use universal experiences ("name of your first friend").

**Accessibility within inclusion**
- Each disability is a spectrum; disabilities can be permanent, temporary (infection), or situational (noisy train).
- **People-first language** for disability; check how communities self-identify; never use disability as a negative metaphor.

**Languages**
- Internationalise (handle other languages/regions) before localising. Plain language, no gender assumptions, no culture-specific content = localisation-ready.
- **Colour meanings are culture-specific** (white = death/grief in some places, purity/peace in others) — verify colour communication per locale.
- SF Symbols helps: language-specific glyphs + LTR/RTL variants.

### iOS vs macOS
None — "No additional considerations" for any platform.

### Reviewer checks
1. Copy scan: "the user", "the player" → flag; suggest "you/your".
2. Copy scan: gendered pronouns ("his or her", "he/she") where a plural or neutral noun works → flag.
3. Gender form fields without nonbinary/self-identify/decline-to-state options → flag.
4. Colloquialisms, idioms, culture-bound jokes in UI copy → flag for localisation/inclusion.
5. Imagery audit: generic-person icons should be nongendered (prefer SF Symbols figure/person glyphs); people imagery shows diversity; no stereotyped role casting.
6. Security/identity questions or examples that assume specific cultural experiences → flag.
7. Undefined jargon/technical terms in user-facing copy → flag.

### Stale-knowledge corrections
- Largely stable since 2021; low staleness risk. Note the cross-link: Apple Style Guide "Writing inclusively" and "Writing about disability" sections are the authoritative depth references.
- Don't conflate with the Writing page: Inclusion allows reserving "we/our" for the company; Writing (Dec 2025) says avoid "we" altogether in contexts like error messages — the stricter, newer rule wins for errors.

---

## Privacy

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/privacy
**Platforms:** all. **Last change:** 2023-06-21 (consolidated page).

### Purpose
Governs transparency about data/resource access, the design of permission requests (purpose strings, pre-alert screens, tracking requests), the Location button, and data protection. Several rules here are **App Store rejection criteria**, not just style advice.

### Normative rules
**Best practices**
- **Request access only to data a feature actually needs**; make permission requests as specific as possible.
- Be transparent about collection/use; respect Hide My Email and Mail Privacy Protection.
- **Process data on device where possible** (Neural Engine, Create ML).
- Adopt system privacy protections (e.g. CloudKit encryption) rather than custom schemes.
- App Store **privacy details** (privacy "nutrition labels") are mandatory at submission, managed in App Store Connect.

**Things that require permission** (the system shows a standard alert with your copy): personal data (location, health, financial, contacts, PII); user-generated content (emails, messages, calendar, photos, audio/video); protected resources (Bluetooth, home automation, Wi-Fi, local network); device capabilities (camera, microphone); advertising identifier (tracking).

**Timing**
- **Request permission only when the app clearly needs it — ideally when the person first uses the feature** requiring access.
- **Avoid requesting at launch** unless the app can't function without it (navigation app + location is the acceptable example).

**Purpose strings** (usage description shown in the system alert)
- A **brief, complete sentence**; straightforward, specific, easy to understand; **sentence case**; **active voice (avoid passive)**; **ends with a period**.
- Good: "The app records during the night to detect snoring sounds." Bad: "Microphone access is needed for a better experience." (passive, vague). Bad: "Turn on microphone access." (imperative, no justification).

**Pre-alert custom screens** (custom screen/window shown before the system permission alert)
- **Exactly one button**, and it must clearly open the system alert.
- Button title must be like **"Continue" or "Next" — never "Allow"** (mimicking the alert's allow button manipulates choice).
- **No additional actions** — no close, no cancel, no way to bypass the alert.

**Tracking requests (App Tracking Transparency)**
- Must show the system alert **before collecting any tracking data**.
- Prohibited custom-screen designs that **cause App Store rejection**: offering incentives to allow tracking; a screen that looks like the system request; showing an image of the alert; annotating the screen behind the alert (arrows/highlights pointing at "Allow"). Ref: App Review Guideline 5.1.1(iv).

**Location button** (iOS, iPadOS, watchOS — Core Location UI)
- Gives one-time location authorization per use; first tap shows a one-time educational alert.
- Customisable ONLY in: system-provided title ("Current Location" / "Share My Current Location"), filled vs outlined glyph, background colour, title/glyph colour, corner radius. Nothing else.
- System warns about **low contrast or too much translucency**; developer must ensure title **fits without truncation at all accessibility text sizes and in all languages**. Persistent visual problems → system silently stops granting location on tap.

**Protecting data**
- **Prefer passkeys over passwords**; if passwords, add two-factor; use Face ID / Touch ID (macOS too) for re-auth.
- Store sensitive info in the **Keychain**; **never in plain-text files**.
- **Don't invent custom authentication schemes** — use passkeys, Sign in with Apple, or Password AutoFill.

### iOS vs macOS
- **macOS-specific**: sign with a valid **Developer ID** for outside-store distribution; **App Sandbox required** for Mac App Store; **don't assume who is signed in** (fast user switching = multiple active users on one system).
- Location button is iOS/iPadOS/watchOS only — no macOS equivalent.
- Everything else shared ("No additional considerations for iOS…").

### Reviewer checks
1. Any onboarding flow that fires permission alerts at launch without functional necessity → violation.
2. Purpose-string copy in prototypes: complete sentence? active voice? specific feature-tied reason? ends with period? Not vague "for a better experience"?
3. Pre-permission explainer screens: count buttons (must be 1); button label is Continue/Next-like, not "Allow"/"OK"; no close/cancel/skip affordance.
4. Tracking-consent screens: any incentive offer, alert mockup image, or arrow/annotation pointing toward the upcoming alert → hard violation (App Review rejection).
5. Sign-in designs: password-only with custom UI → flag; expect passkeys/Sign in with Apple/AutoFill affordances.
6. Location-sharing features: consider Location button pattern; if used, check only the five allowed customisations are touched and text fits at accessibility sizes.
7. Data-hungry forms: fields requested that the visible feature doesn't need → flag.
8. macOS prototypes: any UI assuming a single signed-in user (e.g. "Welcome back, [only user]" tied to machine) → flag.

### Stale-knowledge corrections
- Page itself is pre-Liquid-Glass (2023) and survived the 2025 rewrite unchanged — its rules remain authoritative.
- Distinguish **Privacy Nutrition Labels** (App Store privacy details, 2020) from **Accessibility Nutrition Labels** (new 2025, on the Accessibility page) — models may merge the two concepts.
- Passkeys-first guidance is stronger than older models assume (they may default to password+2FA as the recommendation; current order is passkeys → else passwords+2FA → biometrics for re-auth).
- The "one button, never Allow" pre-alert rule and the 5.1.1(iv) rejection examples are precise and testable — models often paraphrase these loosely.

---

## Right to left

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/right-to-left
**Platforms:** all. Stable; no recent alert.

### Purpose
Governs adapting interfaces for RTL languages (Arabic, Hebrew): what flips, what never flips, text alignment, numerals, and icon mirroring. System frameworks flip standard components automatically; this page is the manual-judgement layer.

### Normative rules
**Text alignment**
- Match text alignment to interface direction (left-aligned LTR ⇄ right-aligned RTL) if the system doesn't do it automatically.
- **Paragraphs (defined: 3+ lines) align to their language, not the UI context.** One- and two-line text blocks align to the current context's reading direction.
- **All items in a list share one alignment**, even items in a different script.

**Numbers and characters**
- Hebrew uses Western Arabic numerals; Arabic uses Western or Eastern Arabic numerals depending on region — decide per locale if the app is number-centric; otherwise rely on system number formatting.
- **Never reverse the digit order within a number** (phone numbers, "541", credit cards) — digits keep the same order regardless of context.
- **Reverse the order of numerals showing progress or counting direction** (labels along sliders/progress bars/ratings, ordered sequences) — but never mirror the numeral glyphs themselves.

**Controls**
- **Flip controls showing progress from one value to another** (sliders, progress indicators) including the positions of their start/end glyphs.
- **Flip navigation controls in fixed orders**: back button points RIGHT in RTL; next/previous flip.
- **Preserve direction of controls referring to an actual direction or pointing at an onscreen area** ("to the right" always points right).
- **Visual balance**: Arabic/Hebrew next to all-caps Latin looks too small (no uppercase in those scripts) — **increase the RTL font size by ~2 pt** to balance.

**Images**
- **Don't flip photographs, illustrations, general artwork** (changes meaning; copyright risk). If reading-direction-bound, create a new RTL version instead.
- **Reverse positions of images when their order is meaningful** (chronological, alphabetical, favourites).

**Interface icons** (SF Symbols provides RTL variants + localised symbols automatically; custom symbols can declare directionality)
- **Flip** icons representing text/reading direction (text-lines glyphs right-align in RTL).
- **Localise** icons containing actual letters/words (signature, rich-text, I-beam have Latin/Hebrew/Arabic variants); if text in an icon is unrelated to reading/writing, redesign without text.
- **Flip** icons depicting forward/backward motion (speaker sound-waves emanate from the right in RTL).
- **Never flip**: logos (legal risk), universal signs and marks (checkmark stays the same), real-world objects (clocks, pencils, game controllers), right-handed-tool icons (most people are right-handed; flipping confuses).
- **Component-level judgement for complex icons**: the SF Symbols prohibition slash stays a backslash in both directions; badges that depict real UI flip with the UI; badges that merely modify meaning flip only if it preserves meaning AND visual balance (cart badge example: keep badge top-left in RTL to balance the flipped cart); tools keep their handedness orientation even when the base flips (magnifying-glass over mail example).

### iOS vs macOS
None — "No additional considerations" for any platform. (Behaviour is framework-level and identical.)

### Reviewer checks (run on an RTL variant of a screen)
1. Back/forward navigation chevrons point right/left respectively in RTL → else violation.
2. Sliders, progress bars, rating controls fill right-to-left; their min/max glyphs swapped.
3. Digits inside any number rendered in original order (spot-check phone/amounts) — reversed digits = violation.
4. Paragraphs of 3+ lines: alignment matches the paragraph's language, not the mirrored layout. 1–2-line labels: aligned to context.
5. Mixed-script lists: single consistent alignment.
6. Logos, checkmarks, clocks, real-object icons unchanged; text-direction icons and speaker/motion icons mirrored.
7. All-caps Latin next to Arabic/Hebrew in buttons/titles: RTL script bumped ~+2 pt.
8. Photos/illustrations not mirror-flipped.
9. HTML prototypes: layout driven by logical properties (`dir="rtl"`, start/end) rather than hard left/right, so flipping is even possible.

### Stale-knowledge corrections
- Stable content; low staleness. Main model errors are over-flipping (mirroring photos, logos, checkmarks, clocks) and under-flipping (forgetting slider/progress direction and numeral *order* in progress contexts). The "paragraph = 3+ lines" threshold and "+2 pt next to all-caps Latin" numbers are precise and rarely known to models.

---

## Writing

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/writing
**Platforms:** all. **Last change: 2025-12-16** (clarified language patterns; **added possessive-pronoun guidance**). Page itself only created 2023-02-27.

### Purpose
Governs voice, tone, and microcopy across the app: buttons, flows, alerts, errors, empty states, settings labels, text-field hints. Voice = stable app personality; tone = situational variation.

### Normative rules
**Voice & tone**
- **Determine the app's voice** from audience and desired feeling (banking = trust/stability; game = excitement/fun). **Create a list of common terms and reference it** for consistency.
- **Match tone to context** (Apple's contrast pair: fall-detection message = straightforward/direct; move-streak congratulation = light). Situational factors affect both the words and how text is displayed.
- **Be clear**: every word must earn its place; fewer words win; read copy aloud as a test.
- **Write for everyone**: plain language, no jargon, no gendered terminology; write with accessibility and localisation in mind.

**Best practices**
- **Consider each screen's purpose**: most important information FIRST; split multiple ideas across multiple screens; mind the flow across screens.
- **Be action oriented**: active voice; **button/link labels are almost always verbs**. "Send" beats "Let's do it!". **Never "Click here"** for links — use descriptive phrases ("Learn more about UX Writing") — critical for screen-reader users.
- **Build language patterns** — consistency makes the app feel cohesive and writing repeatable.
- **Capitalization**: components may have specific rules (e.g. Buttons page), but otherwise pick a style per UI element type and apply consistently (e.g. title case for all alerts, sentence case for all headlines). **Title case reads formal; sentence case reads casual.**
- **Multistep flows**: open with "Get Started"-type language; advance with a consistent choice of "Continue" or "Next" (pick one); close with "Done"-type language.
- **Possessive pronouns sparingly** (NEW Dec 2025): "Favorites" over "Your Favorites"; if used, keep one perspective consistently (don't mix My/Your). **Avoid "we" altogether** — "We're having trouble loading this content" → "Unable to load content".
- **Write for the device**: say **"tap" on iPhone/iPad, never "click"**; "click" belongs to macOS pointer contexts. Small screens (iPhone/Watch) demand brevity; TVs are communal (mind who you address) and big screens also need brevity.
- **Empty states**: welcome + educate; always give a clear next step, with a button or link where possible; **never put crucial information in an empty state** (it disappears).
- **Error messages**: prevent errors first; display the message **as close to the problem as possible**; **avoid blame**; state how to fix it ("Choose a password with at least 8 characters" not "That password is too short"). **No interjections** ("oops!", "uh-oh" — insincere). If language can't fix a common error, **redesign the interaction**.
- **Delivery method**: weigh urgency/importance/context to choose notification vs alert vs action sheet; tone matches the situation.
- **Settings labels**: practical, simple; if the label isn't enough add an explanation that **describes only the ON state** (people infer the opposite — handwashing-timer example). **Link directly to a setting rather than describing its location.**
- **Text fields**: label every field; hint/placeholder text shows format ("name@example.com") or describes content ("Your name"); **errors appear right next to the field**; phrase corrections positively ("Use only letters for your name" not "Don't use numbers or symbols"); never robotic ("Invalid name").

### iOS vs macOS
- The only explicit split is gesture vocabulary: **tap** (iOS/iPadOS) vs **click** (macOS). Brevity pressure scales with screen distance/size. Otherwise shared ("No additional considerations").

### Reviewer checks
1. Button labels: verb-first? Specific? Flag cute/clever labels and bare "OK/Yes/No" where a verb fits.
2. Links: any "Click here"/"here" link text = violation.
3. Capitalization consistency: collect all alert titles, all buttons, all headings; flag mixed title/sentence case within one element type.
4. Multistep flows: consistent advance label (all "Continue" or all "Next", not mixed); entry "Get Started"-class; exit "Done"-class.
5. Copy scan for "we/our/us" in errors and status messages = flag (suggest impersonal: "Unable to…").
6. Copy scan for "My …"/"Your …" prefixes on nav/labels = flag as usually unnecessary; if kept, verify single perspective app-wide.
7. Platform vocabulary: "click" anywhere in an iOS prototype = violation; "tap" in macOS-only context = violation.
8. Error messages: contains remedy? adjacent to the field/problem? no "oops"-class interjections? no blame ("you entered…")?
9. Empty states: contain a next-step action (button/link)? No crucial info parked there?
10. Settings: toggle descriptions describing both on and off states = flag (describe ON only). Prose like "go to Settings > … > …" instead of a direct link/button = flag.
11. Text fields: all labelled; placeholder demonstrates expected format; inline (not toast/summary-only) validation messages.

### Stale-knowledge corrections
- **Page didn't exist before Feb 2023** — older models have no "Writing" HIG page to cite (the old equivalent was scattered "Terminology"/"Writing great text" fragments).
- **Dec 2025 additions are after most training data**: the explicit anti-possessive rule ("Favorites" not "Your Favorites") and the blanket **avoid "we"** rule. Models steeped in older Apple products may even propose "My …" labels (legacy "My Watch" pattern) — current guidance says drop the possessive.
- Apple now explicitly frames capitalization as an app-level voice choice (consistent per element type) rather than a single global mandate — but component pages (Buttons, Alerts) still carry specific rules that take precedence.

---

## Cross-page synthesis for skill design

- **Numeric, machine-checkable core** (accessibility): 44/28 pt iOS and 28/20 pt macOS targets; 12/24 pt padding; 17/11 pt iOS and 13/10 pt macOS type; 4.5:1 / 3:1 contrast; 200% text scaling. Everything else in the bucket is mostly copy-lint and judgement rules.
- **Copy-lint rule set** spans Writing + Inclusion + Privacy purpose strings: a single "copy reviewer" can implement ~20 regex-able checks (click here, we/our, the user, his or her, oops, My/Your prefixes, click-vs-tap, imperative purpose strings…).
- **App Store rejection tier**: privacy pre-alert/tracking-screen rules are the only guidance in this bucket with hard rejection consequences — worth flagging at a distinct severity.
- **RTL is a screen-transform checklist**: only meaningful when a design needs RTL review; cleanly separable, near-zero platform divergence.
- iOS/macOS divergence in this bucket is confined to two numeric tables (targets, type sizes), tap/click vocabulary, and three macOS privacy notes (Developer ID, sandbox, fast user switching).
