<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: privacy, sign-in-with-apple, apple-pay, in-app-purchase, managing-accounts, ratings-and-reviews, managing-notifications, wallet, modality, entering-data, onboarding, app-clips -->

# Review — App Store compliance (tier 1 only)

Every item is objectively enforced by App Review or by the OS itself — the slice of the HIG where a violation risks rejection rather than taste. Cite the src slug in findings. Nothing off this list may be presented as rejection risk (tiers 2–3 live in the other checklists).

## privacy-permission-screens

App Review enforces these (Guideline 5.1.1).

- Pre-alert screen (custom explainer before a system permission alert): **exactly one button**, and it must open the system alert — flag any other count.
- Flag a pre-alert button titled "Allow", "OK", or anything mimicking the system alert's consent button — it must read like **"Continue" or "Next"**.
- Flag any close, cancel, skip, or back affordance on a pre-alert screen — no bypass is permitted.
- Purpose strings: flag vague ("for a better experience"), imperative ("Turn on microphone access"), or passive copy. Required shape: brief complete sentence, sentence case, active voice, ends with a period, names the feature-specific reason.
- Flag permission requests at launch unless the app can't function without the data (navigation + location is the sanctioned example); request at first use of the dependent feature.

<!-- src: privacy, onboarding -->

## tracking-screens

App Review enforces these — Guideline 5.1.1(iv), named on the HIG page as rejection causes.

- The App Tracking Transparency alert must appear **before any tracking data is collected**.
- Flag the four prohibited custom-screen designs: an incentive for allowing tracking; a screen that looks like the system request; an image or mockup of the alert; annotations behind the alert (arrows/highlights pointing at Allow).

<!-- src: privacy -->

## sign-in-with-apple

App Review enforces the button artwork and the parity rule.

- Parity (App Review Guideline 4.8 — policy text, not HIG): an app offering third-party sign-in must offer a privacy-equivalent option; Sign in with Apple qualifies. Flag social-login screens with no such option.
- System button titles: exactly **"Sign in with Apple"**, **"Sign up with Apple"**, or **"Continue with Apple"** — flag any other string.
- Appearances: white on dark; white-with-outline on white/light only (never dark); black on light (never black/dark).
- Size and position: at least as large as every other sign-in button; never below the scroll fold; minimum **140×30 pt**; surrounding margin ≥ 1/10 of button height.
- Custom buttons: Apple-supplied logo artwork only, never redrawn or recoloured; logo height = button height, no cropping or added padding; black or white only; **title = 43% of button height** (height = 233% of font size); title-to-trailing margin ≥ 8% of width; logo-only buttons 1:1.
- Flag a password field inside a SIWA flow, and any request for a personal email after a private-relay address was shared.

<!-- src: sign-in-with-apple -->

## apple-pay-buttons

App Review enforces the artwork rules; the HIG page calls them contractual.

- Buttons come from the Apple API only (`PKPaymentButton` types/styles; JS on web) — flag any hand-built, restyled, or recoloured Apple Pay button.
- Minimums: plain Apple Pay button **100×30 pt**; all texted variants (Buy, Check Out, Donate, Subscribe…) **140×30 pt**; margins ≥ 1/10 of button height. Under-sizing makes the system silently swap texted variants for the plain button.
- Styles: `automatic` preferred; black never on dark; white-with-outline never on dark/saturated; white for dark backgrounds.
- Primacy: if the availability APIs are used, Apple Pay must be the primary — not necessarily sole — option wherever they're used. Flag Apple Pay behind a "choose payment" sub-step, smaller than other payment buttons, or below the fold. Side-by-side → right; stacked → on top.
- Never hide or fake-disable an Apple Pay button — let the tap happen and explain afterwards.
- The Apple Pay mark is never a button. A custom payment button must not show "Apple Pay" text or the logo — acceptance must then be disclosed via the mark or "Apple Pay" in text on the same page.
- Trademark: "Apple Pay" — two words, exact capitalisation; flag "ApplePay", "APPLE PAY", the Apple logo glyph standing in for "Apple", or mimicry of Apple typography.

<!-- src: apple-pay -->

## commerce-rail

App Review enforces the boundary; the wrong rail is rejection-grade.

- Physical goods, services, donations → **Apple Pay**. Virtual goods, premium content, digital subscriptions → **In-App Purchase**. Flag features unlocked via Apple Pay, or physical goods sold via IAP. <!-- src: apple-pay, in-app-purchase -->
- Subscription sign-up screens must contain all three: (1) name, duration, what's provided each period; (2) localised billing total in the most prominent position; (3) sign-in / **Restore Purchases** on the screen itself. Free trials must state the trial length and the amount auto-billed when it ends. <!-- src: in-app-purchase -->

## account-deletion

App Review enforces this (App Store requirement since 2022).

- If an account can be created in-app, the app must offer account **deletion** — flag "Deactivate"-only flows.
- Discoverable: in-app, or a direct, easy-to-find link to the deletion webpage — flag deletion buried in a Privacy Policy or Terms of Service.
- Web parity: the web deletion flow must be as simple as the in-app one.
- Scheduled future deletion only **alongside** an immediate option; state when deletion completes and notify when finished.
- Billing disclosure: explain that auto-renewable subscription billing continues through Apple until cancelled, regardless of account deletion — required even if the subscription wasn't purchased in this app.
- Sign in with Apple accounts: revoke tokens on deletion.

<!-- src: managing-accounts -->

## ratings-prompts

The OS enforces the cap; the HIG directs all rating solicitation through the system prompt.

- Use the system prompt (`RequestReviewAction`) — flag custom-drawn star dialogs soliciting an App Store rating.
- The system caps prompts at **3 per app per 365 days** and suppresses them once feedback is given — designs assuming more are broken by the OS. Leave at least a week or two between requests.
- Flag rating prompts on first launch or inside onboarding, and pre-screen gating ("Enjoying the app?" filters before the real prompt).

<!-- src: ratings-and-reviews, onboarding -->

## notifications-consent

App Review enforces these; the HIG language is "you must".

- Permission before sending **any** notification.
- Marketing notifications require explicit opt-in via an alert/modal/interface describing what will be sent, **and** an in-app settings screen to change the choice — flag designs missing either half.
- Never **Time Sensitive** for marketing. Time Sensitive is only for events happening now or within the hour.
- The **Critical** interruption level requires an Apple entitlement — flag any non-health/safety design assuming it.
- Wallet change messages: time-critical info only, never marketing. <!-- src: wallet -->

<!-- src: managing-notifications -->

## minimum-functionality

App Review enforces this as Guideline 4.2 "Minimum Functionality" (App Review Guidelines, not HIG text — re-verify the live wording before quoting).

- Flag web-wrapper signals: the core experience is a web view of the existing website, with little native capability beyond what Safari already gives. <!-- src: app-review-guidelines (non-HIG, version-gated) -->
- App Clips specifically must avoid web views — native or nothing; link out to the website instead. <!-- src: app-clips -->

## hard-rules-adjacent

Hard HIG "never" rules adjacent to review — blocking findings, but don't promise rejection.

- Never two alerts at once; one modal at a time (only an alert may sit on top). <!-- src: modality -->
- Never prepopulate a password field — require entry or biometric/keychain auth. <!-- src: entering-data -->
- Never modify or replicate the system purchase confirmation sheet. <!-- src: in-app-purchase -->
