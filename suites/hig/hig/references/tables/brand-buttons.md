<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: sign-in-with-apple, apple-pay, tap-to-pay-on-iphone -->

# Brand buttons and marks — Sign in with Apple, Apple Pay, Tap to Pay

**Tier 1 — App Review enforces these specs.** Button artwork, titles, sizing and placement here are contractual/review-enforced, not stylistic. The apple-pay page is hot: refreshed 2026-06-08 for current button appearance — render buttons via the APIs, never copy from old screenshots; re-verify before asserting (`scripts/hig-fetch.sh apple-pay`). <!-- src: apple-pay, sign-in-with-apple -->

## Sign in with Apple — system button
| Spec | Value |
|---|---|
| Titles (only these three) | Sign in with Apple · Sign up with Apple · Continue with Apple |
| Appearances | white (on dark) · white with outline (white/light backgrounds only — never dark) · black (light backgrounds — never black/dark) |
| Minimum size | 140×30 |
| Minimum surrounding margin | 1/10 of button height |
| Corner radius | adjustable square → capsule |
| Placement | at least as large as other sign-in buttons; never below the scroll fold |
<!-- src: sign-in-with-apple -->

## Sign in with Apple — custom button
| Spec | Value |
|---|---|
| Logo | Apple-supplied artwork only, never redrawn or recoloured; logo height = button height; no cropping, no added vertical padding |
| Colours | black or white only, logo and title |
| Title size | 43% of button height (button height = 233% of font size) |
| Title-to-trailing-edge margin | ≥8% of button width |
| Logo-only button | 1:1 ratio; maskable to circle/rounded rectangle |
| Assets | PNG only at 44pt button height (iOS default); vector otherwise |
<!-- src: sign-in-with-apple -->

## Apple Pay — buttons
Always use the Apple-provided API (`PKPaymentButtonType` / `PKPaymentButtonStyle` on iOS and macOS; JS API on web): approved captions, fonts, colours, proportional scaling, ~40-language auto-localisation, built-in VoiceOver alt text. Never hand-build or replicate. Buttons may only initiate payment or the Apple Pay set-up flow — nothing else. <!-- src: apple-pay -->

| Spec | Value |
|---|---|
| Types (16) | plain Apple Pay · Buy · Pay · Check Out · Continue · Book · Donate · Subscribe · Reload · Add Money · Top Up · Order · Rent · Support · Contribute · Tip — plus Set Up Apple Pay (device supports it, not yet set up) |
| Undersizing fallback | translated title doesn't fit your size → system silently swaps in the plain Apple Pay button (no fallback for Set Up Apple Pay) |
| Styles | automatic (prefer) · black (light backgrounds with sufficient contrast; never dark) · white with outline (light backgrounds lacking contrast; never dark/saturated) · white (dark backgrounds) |
| Minimum size | plain Apple Pay 100×30 · all texted variants 140×30 |
| Minimum margins | 1/10 of button height |
| Corner radius | customisable square → capsule, match neighbouring buttons |
| Position | never smaller than other payment buttons; never below the scroll fold; beside Add to Cart → Apple Pay on the right; stacked → Apple Pay on top |
| Availability | never hide or fake-disable; if unusable yet, let the tap happen and explain afterwards. Device without Apple Pay → don't present the option at all. Using the card-availability APIs → Apple Pay must be the primary (not necessarily sole) payment option everywhere those APIs are used |
<!-- src: apple-pay -->

## Apple Pay — mark and text
| Element | Rules |
|---|---|
| Apple Pay mark | Apple artwork only; never a button or tap target; resize by height only; ≥ other payment brand marks; keep the border; no ™, shadows, glows, flips, rotation or animation; clear space ≥1/10 of mark height; never shares a border with another graphic/button |
| Custom payment button | must NOT show "Apple Pay" text or logo; disclose acceptance via the Apple Pay mark or "Apple Pay" in text on the same page |
| Text form | "Apple Pay" exactly — two words, capital A and P; never plural, possessive or translated; your app's font, not Apple's; ® on first US body-text occurrence but not on checkout options; never the Apple logo glyph in place of "Apple"; text-only list entry allowed only if every payment option is text-only |
<!-- src: apple-pay -->

## Tap to Pay on iPhone (iOS only — merchant payment-acceptance apps)
| Spec | Value |
|---|---|
| Button label (mandated) | "Tap to Pay on iPhone", or "Tap to Pay" when space-constrained — payment actions only; sole-payment-method apps may reuse existing Charge/Checkout buttons |
| Icon, if any | SF Symbols `wave.3.right.circle` / `.fill` — never the Apple logo |
| Colour/shape | may match your app |
| Non-payment card reads | generic labels only (Look Up · Store Card · Verify · Refund) — never "Tap to Pay" wording; same for loyalty-card reads |
<!-- src: tap-to-pay-on-iphone -->

## Hard flags (reviewer)
Custom-styled or recoloured Apple Pay button · mark used as tap target · SIWA black button on dark / outline button on dark · titles beyond the approved strings · redrawn or recoloured Apple logo · "ApplePay" / "Pay" / "APPLE PAY" in copy · brand button smaller than competitor buttons or below the fold · Apple logo in a Tap to Pay button. <!-- src: sign-in-with-apple, apple-pay, tap-to-pay-on-iphone -->

Stale priors: "Apple ID" was renamed **Apple Account** (2024) — settings path is Settings > Apple Account > Sign in with Apple. The Apple Pay type list is longer than older training data (Tip, Rent, Support, Contribute, Add Money, Top Up are post-2022). <!-- src: sign-in-with-apple, apple-pay -->
