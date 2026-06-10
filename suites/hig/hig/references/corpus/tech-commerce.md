<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: apple-pay, wallet, in-app-purchase, sign-in-with-apple, tap-to-pay-on-iphone, icloud, app-clips, game-center -->

# Technologies — commerce and services

Rail-picking first: physical goods/services/donations → Apple Pay; virtual/digital goods → In-app purchase; merchant acceptance → Tap to Pay on iPhone. The wrong rail is App-Review-enforced (rejection), not style. <!-- src: apple-pay, in-app-purchase -->

## apple-pay
<!-- src: apple-pay · changed: 2026-06-08 (Liquid Glass appearance; 2025-12-16 web + Vision Pro) · platforms: iOS, iPadOS, macOS, web (not tvOS), no deltas · speed: full -->
Physical goods, services, donations — never virtual goods. Buttons, primary-option rule and mark usage are contractual; **App Review enforces them**.
**Offering.** Unsupported device → don't show it. Active-card-check APIs ⇒ **Apple Pay must be the primary (not necessarily sole) option wherever those APIs are used** — never a separate step. Buttons only initiate payment or Set Up Apple Pay; **never hide or fake-disable one**. Custom payment buttons must not show "Apple Pay" text/logo; disclose acceptance via the **Apple Pay mark** (never tappable) or text on the same page.
**Buttons — API-only.** Always `PKPaymentButtonType`/`PKPaymentButtonStyle` (JS on web); **never hand-build**. 16 types (plain, Buy, Pay, Check Out, Continue, Book, Donate, Subscribe, Reload, Add Money, Top Up, Order, Rent, Support, Contribute, Tip) + Set Up Apple Pay; an unfitting translated title silently swaps in the plain button. Styles: `automatic` (prefer) · black (light only) · white-with-outline (low-contrast light only) · white (dark). Sizes: plain min **100×30 pt**, texted min **140×30 pt**, margins ≥ **1/10 button height**. Never smaller than other payment buttons, never below the fold; beside Add to Cart → right, stacked → on top.
**Mark.** Apple artwork only; resize by height, ≥ other brand marks; no edits/rotation/animation; clear space ≥ 1/10 height. Text-only "Apple Pay" in a payment list only if every option is text-only.
**Trademark.** "Apple Pay" exactly; never plural/possessive/translated; never the Apple logo glyph as "Apple"; your app's font.
**Payment sheet.** Essential fields only. Line items = charges, discounts, pending costs, recurring payments — **never an itemised product list**. Total: **"Pay [Business_Name]"** matching the card statement; marketplaces **"Pay End_Merchant (via Your_Business)"**; unknown cost → **"Amount Pending"**. Coupons enterable on the sheet; required selections before the button. Product-page button buys that item **excluding the cart**. **Defer to the sheet for progress** — no custom spinners (2026 refresh); report results, incl. failures, in the sheet. Errors: `PKPaymentError` codes + noun-phrase messages, sentence case, no ending punctuation, **≤128 chars**; interruption → cancel the payment.
**Subscriptions** (recurring physical/services ≠ IAP): terms before the sheet; trials as line items — trial amount (incl. $0), regular amount, start date; re-show only when cost **increases**. **Donations**: preset amounts + "Other Amount". No account creation before purchase.
**Checks.** Custom/recoloured button (App Review enforces) · not primary while availability APIs used · mark as tap target · itemised line items · custom spinner · "ApplePay"/" Pay"/"APPLE PAY".
**Was → Now.** Render buttons via API, never from old screenshots (2026-06-08 refresh); Tip/Rent/Support/Contribute/Add Money/Top Up are post-2022 types.

## wallet
<!-- src: wallet · changed: 2026-06-08 (iOS 27 + Pass Designer) · platforms: iOS, iPadOS, macOS (not tvOS) · speed: full -->
Three surfaces: **passes** · **order tracking** (iOS 17+) · **Verify with Wallet** (iOS 16+).
**Pass lifecycle.** One-tap system add UI; predictable adds in the background after one-time authorisation; declined → **never ask again**; **group related passes**; set `expirationDate`/`voided`; **permission before deleting**; relevance time/place data surfaces passes on the Lock Screen. **Change messages** only for time-critical info — **marketing never** (App Review enforces).
**Anatomy.** Pass fields (layout) + semantic tags (meaning). Tags **required** for poster event tickets + airline boarding passes (keep fields for older iOS). Essentials in the **header** — the only area visible when stacked.
**Designing.** **Pass Designer** (WWDC26) is the canonical workflow; never embed barcodes in images; **not a replica of the physical card**; no text in images. Styles: boarding pass, coupon, event ticket (poster = full-art + semantic tags), store card, poster generic, generic. Exact pass-image dimension table (logo/strip/thumbnail/background/artwork, PNG @2x+@3x): fetch for detail — wallet.
**Order tracking.** Auto-add after Apple Pay transactions (`PKPaymentOrderDetails`); else the system **"Track with Apple Wallet"** button. Statuses are system-defined. **Logo + product images 300×300 px, nontransparent solid background.** Universal link to order management; pickup → scannable barcode.
**Verify with Wallet.** Button only when the device can return the requested data, with a fallback; ask at the precise moment. Purpose string: brief sentence, sentence case, ends with a period. **Age threshold (`age(atLeast:)`), never birthdate.** Labels: Verify Age / Verify Identity / Continue / Verify with Wallet. **Always white on black** (outline variant + cornerRadius only).
**Checks.** Physical-card replica · essentials missing from header · text/barcodes in images · wrong image dims · marketing change messages (violation) · poster pass without semantic tags · recoloured Verify button (violation).
**Was → Now.** Hand-authored `pass.json` as the design path → Pass Designer (2026); poster styles post-date 2024-12-18; image specs published 2025-01-17 — pre-2025 sources guess.
> **27 beta delta (promote on GA):** the 2026-06-08 update targets iOS 27; content above is valid for the 26.x baseline.

## in-app-purchase
<!-- src: in-app-purchase · changed: 2023-09-12 · platforms: all, no deltas · speed: full -->
Virtual goods. Paywall items below are App-Review-grade.
**Four types (exact terms):** consumable · non-consumable · auto-renewable subscription · non-renewing subscription. Huge catalogs → Advanced Commerce API.
**Store.** Feels like part of your app; **display the total billing price for every IAP**; **hide or explain the store when `canMakePayments` is false**; **use the system confirmation sheet as-is**.
**Family Sharing.** Auto-renewables + non-consumables shareable with up to five family members; signal in product names + sign-up screens.
**Refunds.** Funnel into the system flow (`beginRefundRequest`); label "Refund"/"Request a Refund"; **never buried**; **never characterise Apple's refund policies**.
**Sign-up screen — required (App Review enforces):** 1) name, duration, what's provided each period; 2) **billing amount, localised — total most prominent**; 3) **sign-in/Restore Purchases on the paywall itself**. Free trials: state **duration and the amount auto-billed when it ends**.
**Paywalls.** Free-access models: freemium, metered paywall, free trial; persistent entry incl. **app settings**; **never pitch to current subscribers**; cross-platform subscriptions need sign-in.
**Offer codes.** One-time vs custom codes (**alphanumeric ASCII only**; custom NOT redeemable via App Store settings — say how); system redemption sheet; button homes: paywall, onboarding, settings.
**Management.** Summary + renewal date in settings (`SubscriptionInfo`); prefer `showManageSubscriptions`; **cancellation easy to find**; retention offers complement, never replace, the system flow.
**Checks.** Paywall missing localised total/terms/restore (App Review-grade) · trial without post-trial charge + date · custom confirmation sheet · wrong rail (rejection) · refund behind screens · "Subscribe" shown to subscribers.

## sign-in-with-apple
<!-- src: sign-in-with-apple · changed: stable since 2022 · platforms: all + web · speed: full -->
**App Review enforces the button rules**; policy context: third-party sign-in requires a privacy-equivalent option (guideline 4.8; SIWA qualifies).
**Flow.** **Delay sign-in as long as possible**; commerce: account creation AFTER purchase (guest checkout, reuse Apple Pay data). **Never ask for a password; never ask for a personal email when a private relay address was shared** — surface the relay, or point to Settings > **Apple Account** > Sign in with Apple.
**System buttons.** Titles: **Sign in with Apple / Sign up with Apple / Continue with Apple** only. Appearances: white (on dark) · white with outline (light only — never dark) · black (light only — never dark). **At least as large as other sign-in buttons; never below the scroll fold.** Min **140×30 pt**; margins ≥ 1/10 button height; radius square→capsule.
**Custom buttons.** Apple-supplied logo only (never redraw/recolour); logo height = button height, no cropping/padding; black or white only; **title = 43% of button height** (height = 233% of font size); trailing margin ≥ **8% of button width**; logo-only 1:1, maskable; PNG only at 44 pt height.
**Checks.** Smaller than rival sign-in buttons or below fold · black/outline on dark · custom or recoloured logo (App Review enforces) · non-approved title · password field · personal email after relay (violation).
**Was → Now.** "Apple ID" → **Apple Account** (2024); copy saying Apple ID is stale.

## tap-to-pay-on-iphone
<!-- src: tap-to-pay-on-iphone · changed: 2025-01-17 (page prints 2024-01-17, apparent typo) · platforms: iOS only · speed: full -->
Merchant-side contactless acceptance (PSP + entitlement + `ProximityReader`). Tap UI, checkmark, error screens are **system-provided**.
- **Label mandated:** "Tap to Pay on iPhone" ("Tap to Pay" if space-constrained) — payment actions only; non-payment reads use generic labels ("Look Up", "Store Card", "Verify", "Refund"). Icon: SF Symbols `wave.3.right.circle`/`.fill`; **never the Apple logo**.
- **Never block checkout on configuration** — prepare at launch/foregrounding (`prepare(using:)`); keep the option selectable with progress.
- Admin accepts T&C before first configuration; educate merchants or use `ProximityReaderDiscovery`. Final amount (incl. tips) **before** the Tap to Pay screen.
**Checks.** "Tap to Pay" on a non-payment action (violation) · Apple logo in the button (violation) · checkout blocked while configuring.

## icloud
<!-- src: icloud · changed: 2025-06-09 (GameSave) · platforms: all, no deltas · speed: stub -->
Principle: **transparency** — content is just "the latest version, everywhere".
- Works automatically; at most one first-launch choice (all data or none) — **never ask per-document**.
- Unavailable → **no alert**, just an unobtrusive note. **Deleting = deleting everywhere: warn + confirm.**
- Conflicts: auto-resolve, else an early unobtrusive version-picker. Store user-created content only. Games: prefer **GameSave** (2025).
Flag: per-document prompts · offline alert dialogs · delete without everywhere-warning. Fetch for detail: icloud

## app-clips
<!-- src: app-clips · changed: 2025-06-09 (demo App Clips) · platforms: iOS, iPadOS only — no Mac App Clips · speed: stub -->
Instantly-launched app slices; since 2025 also **demo experiences** (pre-2025 priors believe single tasks only).
- Complete the task/demo **inside** the clip; linear UI — **no tab bars, navigation hierarchies, or settings**; no splash screens; **no ads**; no account wall (offer SIWA; Apple Pay); notifications allowed ≤8 h post-launch without permission.
- Card: image **1800×1200 px**, no transparency, **no text in the image**; title ≤**30 chars**, subtitle ≤**56**; verb exactly **View / Play / Open**.
- App Clip Codes (App Review enforces artwork): generated codes only, never modified/recoloured/rotated/animated; print min **3/4 in (1.9 cm)**; digital min **256×256 px**; NFC tag ≥35 mm.
- Don't quote a MB size cap (none published).
Flag: tab bar/settings · account wall before value · card copy over limits or text in art · modified code artwork. Fetch for detail: app-clips

## game-center
<!-- src: game-center · changed: 2025-06-09 (Apple Games app, Game Overlay) · platforms: all · speed: stub -->
Games-only — enforced terminology ("Game Center", "Achievements", "Leaderboards", "Challenges" — never Trophies/Rankings); asset specs exist (achievements 512×512 pt circular-masked; challenge artwork 1920×1080 pt); player surfaces since WWDC25: Apple Games app + Game Overlay. Fetch for detail: game-center (also designing-for-games)
