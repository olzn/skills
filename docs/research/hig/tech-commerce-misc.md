# HIG research notes — tech-commerce-misc

> Researched 2026-06-10 from Apple's JSON content API (`https://developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`). Bucket: commerce technologies (Apple Pay, Wallet, In-app purchase, Tap to Pay on iPhone) + niche pages (Always On, Workouts) + games triage (Designing for games, Game Center).
> Currency: **Apple Pay updated 2026-06-08** ("Refined guidance to reflect the latest Apple Pay appearance and capabilities") and **Wallet updated 2026-06-08** ("guidance for iOS 27 and the Pass Designer app") — both current to WWDC 2026. In-app purchase is stable since 2023-09-12. Games pages were rewritten for WWDC25 (2025-06-09: Apple Games app, Game Overlay).

---

## Apple Pay

**URL:** https://developer.apple.com/design/human-interface-guidelines/apple-pay
**Platforms:** iOS, iPadOS, macOS, visionOS, watchOS, and the web. **Not supported in tvOS.** Page states "No additional considerations" per platform — rules below apply identically on iOS and macOS.
**Change log:** 2026-06-08 (refined for latest appearance/capabilities), 2025-12-16 (clarified supported platforms incl. browsers and Vision Pro), 2024-06-10, 2023-09-12, 2023-05-02 (consolidated to one page).

**Purpose.** Apple Pay sells **physical goods, services (memberships, hotels, event tickets), and donations** — in apps and any browser. Hard boundary with In-app purchase: IAP sells **virtual goods** (premium content, digital subscriptions). This split is App-Review-enforced; recommending the wrong rail is a rejection-grade error. Many rules on this page (button artwork, "primary option" requirement, mark usage) are contractual/review-enforced, not just stylistic.

**Offering Apple Pay (must-rules).**
- Offer on **all** devices/browsers that support it; if the device doesn't support Apple Pay, **don't present it as an option** at all.
- If you use the Apple Pay APIs that check whether someone has an active card in Wallet, you **must make Apple Pay the primary — but not necessarily sole — payment option everywhere you use those APIs.** Don't separate Apple Pay into a different step or flow; pre-selecting it alongside other options is fine.
- Apple Pay buttons may **only** initiate payment or (when unset-up) the Apple Pay setup flow. No other uses.
- A **custom** payment button must NOT display "Apple Pay" text or the Apple Pay logo. If you use one, you must still disclose acceptance via the **Apple Pay mark** graphic or "Apple Pay" in text **on the same page** as the button.
- The **Apple Pay mark is never a button** — it only communicates acceptance. Don't position it as tappable.
- **Never hide or fake-disable an Apple Pay button.** If it can't be used yet (e.g., size/color not chosen), let the tap happen and gracefully point out the problem afterward.
- Websites: list Apple Pay in semantic markup for search engines; all Apple Pay websites must include a privacy statement and adhere to the Apple Pay web merchant terms.

**Streamlining checkout.**
- Keep the whole checkout inside your app/site branding; avoid opening new pages/windows (on the web this reads as a handoff to another site).
- "If Apple Pay is available, assume people want to use it" — first position, larger, or visually separated by a divider line.
- Apple Pay buttons on **product detail pages** = single-item purchase only, **excluding cart contents**; if the bought item was in the cart, remove it after purchase. **Express checkout** = whole cart, one shipping method/destination, straight to the payment sheet.
- Coupons/promo codes: support entry **directly on the payment sheet** (critical for express checkout); display an active code on the sheet for reassurance.
- Collect required selections (size, color) **before** the button; collect optional data (gift messages, delivery instructions) before checkout or after purchase — **the payment sheet has no free-input fields for optional data**.
- The sheet supports **one shipping method + one destination per order**; per-item splits must be collected beforehand. In-store pickup: choose location first, show its address read-only on the sheet.
- **Prefer Apple Pay's data over stored account data** — fetch latest contact/shipping/payment from Apple Pay even for known customers.
- **Don't require account creation before purchase**; invite registration on the order-confirmation page, prepopulated from checkout data.
- Report transaction results **in the payment sheet** (incl. failure messages); then show a confirmation/thank-you page. Referencing Apple Pay there is optional; format: "1234 (Apple Pay)" or "Paid with Apple Pay."

**Payment sheet content rules.**
- Only essential fields — requesting a shipping address for an e-gift card reads as a privacy problem and implies physical delivery.
- Shipping methods: description + cost + optional estimated date/date-range; use `PKDateComponentsRange` calendar/time-zone support so dates are correct regardless of the buyer's location.
- **Line items** are for additional charges, discounts, pending costs, add-on donations, recurring/future payments — **never an itemized product list**. Keep each to a single line.
- Total line: **"Pay [Business_Name]"** where the name matches what appears on the card statement. Intermediary/marketplace: **"Pay End_Merchant (via Your_Business)"**.
- Unknown final cost (rides, post-delivery tips): explain in the sheet + subtotal marked **"Amount Pending"** (where regulations allow); preauthorized amounts must be shown accurately.
- **Defer to the payment sheet for progress display** — adding your own spinners during payment creates confusion (sheet has built-in loading/progress states; this guidance reflects the 2026 refresh).

**Error handling.**
- Privacy constraint: before authorization you only get **card type + redacted shipping address** — validate what you can early, but the authorization-failure moment is where full validation happens.
- Be lenient: accept Zip+4 when you need 5 digits (ignore extras), accept phone numbers with/without dashes/country code.
- Supply custom messages + correct `PKPaymentError` status codes so the system highlights the right field. Detail-view messages: **noun phrases, sentence-style capitalization, no ending punctuation, ≤128 characters** (truncation limit). Be specific: "Zip code doesn't match city," not "Address is invalid."
- Interruptions (cancellation/timeout dismissing the sheet): you **must cancel any in-progress payment**; the user restarts via the button.

**Subscriptions via Apple Pay** (recurring payments for physical/services — distinct from IAP auto-renewables): clarify billing frequency/terms **before** the sheet; line items reiterating frequency, discounts, upfront fees; trials shown as line items — trial amount (incl. **$0**), regular amount, and the date regular billing begins; total line = amount billed **now**. Only re-show the sheet when a plan change **increases** cost. The billing-agreement field is a plain-language summary, not legal terms — "when in doubt, leave this field blank."

**Donations** (approved nonprofits only): line item like "Donation $50.00"; offer predefined amounts ($25/$50/$100) + "Other Amount."

**Buttons (App-Review-enforced artwork rules).**
- **Always use the Apple-provided API** (`PKPaymentButtonType`/`PKPaymentButtonStyle` on iOS and macOS; JS API on web) — gives approved captions/fonts/colors, proportional scaling, ~40-language auto-localization, corner-radius customization, built-in VoiceOver alt text. **Never hand-build or replicate** the button.
- **16 button types:** plain Apple Pay, Buy, Pay (bills/invoices), Check Out, Continue, Book, Donate, Subscribe, Reload, Add Money, Top Up, Order, Rent, Support, Contribute, Tip — each tied to specific flow wording. Plus **Set Up Apple Pay** (shown in Settings/profile/interstitial when the device supports Apple Pay but it isn't set up). Some contexts render the user's default card image on the button.
- If a translated title doesn't fit your specified size, the system silently swaps in the **plain Apple Pay button** (no such fallback for Set Up Apple Pay) — so under-sizing changes your CTA.
- **Styles:** `automatic` (follows light/dark appearance — prefer it), **black** (light backgrounds with sufficient contrast; never on dark), **white with outline** (light backgrounds lacking contrast; never on dark/saturated), **white** (dark backgrounds).
- **Sizes:** plain Apple Pay button min **100×30 pt**; all texted variants (Buy/Book/Check Out/Donate/Subscribe/Set Up…) min **140×30 pt**; minimum margins **1/10 of button height**. Corner radius is customizable (square → capsule) to match neighboring buttons.
- **Position:** never smaller than other payment buttons; never below the scroll fold. Side-by-side with Add to Cart → Apple Pay goes **right**; stacked → Apple Pay goes **on top**.

**Apple Pay mark.** Apple-supplied artwork only; resize by **height only** and keep it ≥ other payment brand marks; don't change width/corner radius/aspect ratio, don't add ™ or content, don't remove the border, no shadows/glows/reflections, no flip/rotate/animate. Clear space ≥ **1/10 of mark height**; never share a border with another graphic/button.

**Referring to Apple Pay in text.** Exact trademark form "Apple Pay" (two words, A+P caps; all-caps only inside an established all-caps typographic style); never plural/possessive/translated; ® on first body-text occurrence in the US but **not** on checkout selection options; never the Apple logo glyph in place of "Apple"; use **your** app's font, don't mimic Apple typography. In a payment-method list, a text-only "Apple Pay" entry is allowed **only if every option is text-only** — if any competitor shows a logo, you must use the Apple Pay mark.

**Reviewer checks.** Custom-styled or recolored Apple Pay button (not API-generated) → violation. Apple Pay shown but not primary while availability APIs are used → violation. Apple Pay hidden behind a "choose payment" sub-step → violation. Mark used as a tap target → violation. Sheet mockups showing itemized product lists as line items, or shipping fields for digital delivery → wrong. Buy button below other payment buttons in size/order → flag. Sheet shown for a subscription downgrade → unnecessary. Custom spinner over the payment sheet → remove. "ApplePay", " Pay", "APPLE PAY" in copy → trademark errors.

**Stale-knowledge corrections.** Page refreshed 2026-06-08 for current (Liquid Glass-era) button appearance — render buttons via API, never from old screenshots. Dec 2025 update made browser + Vision Pro support explicit. The button-type list is longer than older training data (Tip, Rent, Support, Contribute, Add Money, Top Up are post-2022 additions). "Defer to the sheet for progress" is newer guidance — older designs added custom processing overlays.

---

## Wallet

**URL:** https://developer.apple.com/design/human-interface-guidelines/wallet
**Platforms:** iOS, iPadOS, macOS, visionOS, watchOS (passes auto-sync to Watch). **Not supported in tvOS.** Practically iPhone-centric; macOS has no extra considerations.
**Change log:** **2026-06-08 (iOS 27 + the new Pass Designer app)**, 2025-01-17 (**pass image dimension specs added**), 2024-12-18 (poster event ticket style), 2023-09-12 (orders-in-Wallet), 2023-02-20, 2022-11-30, 2022-09-14 (Verify with Wallet; consolidated page).

**Purpose.** Three integration surfaces: **passes** (tickets, boarding passes, loyalty cards, coupons), **order tracking** (Wallet order dashboard, iOS 17+), **identity verification** (Verify with Wallet, iOS 16+).

**Pass lifecycle rules.**
- When an action creates a pass, present the **one-tap system add UI**; for frequent predictable actions (flight check-in), add passes **in the background after a one-time authorization** (Wallet notifies on each add). Custom review view → include an **Add to Apple Wallet** button (`PKAddPassButton`); an Add to Apple Wallet **badge** exists for emails/webpages.
- Pass created on web/another device → suggest adding next app open; **if declined, never ask again** (but keep an Add button wherever the pass info appears).
- **Add related passes as a group** (multi-leg flights, sets of event tickets) — one download, not N.
- Offer a "View in Wallet" link wherever the app shows a pass that's already in Wallet.
- Set `expirationDate`, relevant date, and `voided` correctly — Wallet auto-hides expired passes.
- **Always get permission before deleting passes.**
- Provide relevance time/place data so the system can surface the pass on the Lock Screen (gym card at the gym); event tickets can start a **Live Activity**.
- **Change messages** (per-field push updates that interrupt) only for time-critical info — gate change yes, phone-number change no, **marketing never**.

**Pass anatomy.** Content = **pass fields** (layout) + **semantic tags** (meaning; enable Lock Screen surfacing and "featured actions" like venue directions). Semantic tags are **required** for **poster event tickets and semantic boarding passes** and drive automatic layout there — but still include pass fields for older iOS. Field areas: **logo + logo text** (visible when pass is stacked/collapsed), **header** (critical info, visible collapsed), **primary** (most important), **secondary/auxiliary**, **footer** (e.g., "Family"/"Annual" category), **back fields** (rarely needed details, settings, legal).

**Designing passes.**
- **Pass Designer** (new, WWDC26): Apple's app for designing/previewing passes from templates or blank — the current canonical workflow; also handles barcodes (never embed barcodes in images).
- Design a **clean, simple pass that feels at home in Wallet** — explicitly *not* a replica of the physical card (anti-skeuomorphism rule).
- Essentials (event date, balance) go in the **header** so they're visible when collapsed in the stack; rarely-needed info goes to the back/details sheet.
- Brand recognition via colors/images/full-art backgrounds; label colors must keep text legible over both solid colors and images.
- Device-agnostic wording ("Slide to view" is meaningless on Watch); watchOS crops strip images and may crop white space — avoid padding in images and don't put essentials in elements that drop on some devices.

**Pass styles:** boarding pass (airline = semantic tags; trains/buses/boats = pass fields), coupon, event ticket (**poster** style = full-art background, semantic tags; non-poster = standard fields + background/thumbnail), store card (show the balance), **poster generic** (full background, distinct layout, the "anything else" flexible style), generic (gym card, coat check).

**Pass image specs** (PNG, supply **@2x and @3x**; visual content only — no embedded text, it's inaccessible and may not render on all devices; keep files small for email/web delivery):

| Image | File | Size | Styles |
|---|---|---|---|
| Logo | `logo.png` | height 50 pt; width 50–160 pt | non-semantic boarding, coupons, non-poster event, generic, store cards |
| Primary logo | `primaryLogo.png` | height 30 pt; width 30–126 pt | semantic styles: airline boarding, poster event, poster generic |
| Secondary logo | `secondaryLogo.png` | height 12 pt; width 12–135 pt | poster event only (bottom-trailing; issuer/organizer) |
| Icon | `icon.png` | 38×38 pt (system rounds corners) | all — shown on Lock Screen, in Mail |
| Strip | `strip.png` | 375×144 pt | coupon, store card (text overlays it — keep contrast, key art bottom/trailing) |
| Thumbnail | `thumbnail.png` | width 60–90 pt × height 90 pt; round your own corners, transparent PNG | event ticket, generic |
| Background | `background.png` | 343×503 pt | non-poster event tickets |
| Poster background | `artwork.png` | 358×448 pt | poster event + poster generic; a **material strip covers the bottom edge** — keep content in the safe area, account for the barcode; preview in Pass Designer (`footerBackgroundColor`) |
| Footer | `footer.png` | 268×15 pt | airline boarding passes only |

Logo artwork: avoid inner drop shadows (legibility).

**Order tracking (iOS 17+).**
- Auto-add orders after Apple Pay transactions (`PKPaymentOrderDetails` app / `ApplePayPaymentOrderDetails` web); elsewhere show the system **"Track with Apple Wallet"** button (`AddOrderToWalletButton`) on confirmation/status/tracking pages and in emails. Re-adding an existing order opens it in Wallet.
- Order data must be available **immediately** after placement even if details are pending ("Check back later for full order details").
- System-defined statuses driven by your fulfillment data: **Order Placed, Processing, Ready for Pickup, Picked Up, Out for Delivery, Delivered, Issue, Canceled.** Use granular shipping statuses (`onTheWay`, `outForDelivery`, `delivered`) only if you actually have carrier detail; otherwise `shipped`. Known carrier → set `carrier`; unknown → leave default "Track Shipment." Always include a tracking link when available.
- **Merchant logo: 300×300 px PNG/JPEG, nontransparent background.** **Product images: 300×300 px, nontransparent, solid background** — no lifestyle shots (illegible at small sizes).
- Provide a **universal link** to your order-management area (works without the app installed); a prioritized app list (system links the highest installed one); suppress duplicate Wallet notifications when your app is installed; Contact button needs at minimum a website link (plus optionally Messages for Business, phone, email, support page).
- Pickup fulfillments: include the **scannable barcode** in Wallet plus clear pickup instructions. Keep fulfillment screens centered on tracking, not upsells. Be direct about Issue/Canceled causes and remedies.

**Identity verification (Verify with Wallet, iOS 16+).**
- Show the button **only when the device can return the requested data**; have a fallback verification method.
- Ask **at the precise moment** verification is needed — not at account creation or flow start.
- **Purpose string** appears in the system sheet: brief complete sentence, sentence case, active voice, ends with a period (e.g., "Federal law requires this information to verify your identity and also to help [App Name] prevent fraud.").
- **Data minimization:** request an age **threshold** (`age(atLeast:)`), never birthdate/current age, when an age gate is all you need. Declare retention via `PKIdentityIntentToStore` — the sheet auto-explains the duration to the user.
- Four system button labels: **Verify Age** (age completes the transaction), **Verify Identity** (identity completes it, e.g., car rental), **Continue** (one step of a longer verification needing extra data like an SSN), **Verify with Wallet** (generic). Multiline variants auto-apply in tight widths.
- Button is **always white text on black**; only choices are an optional light-outline variant for dark backgrounds and `cornerRadius`. Don't restyle it.

**Reviewer checks.** Pass mockups that replicate the printed ticket verbatim → redesign for Wallet's clean style. Essential info missing from header (invisible when stacked) → flag. Text or barcodes baked into pass images → violation. Image specs off (e.g., strip not 375×144 pt, icon not 38×38 pt) → flag. Marketing pushed through change messages → violation. Poster-style passes without semantic tags → broken auto-layout. Order-tracking product shots on transparent/busy backgrounds → flag. Verify-with-Wallet button recolored to brand colors → violation; purpose string vague ("We need your ID") → rewrite.

**Stale-knowledge corrections.** **Pass Designer app is the 2026 workflow** — older advice to hand-author `pass.json` bundles is outdated as the design path (the format remains). The **poster generic** style (and poster event w/ required semantic tags) post-dates most training data (Dec 2024+). Exact image dimension specs were only published 2025-01-17 — pre-2025 sources guess at sizes. Page confirms the **iOS 27** generation (WWDC 2026).

---

## In-app purchase

**URL:** https://developer.apple.com/design/human-interface-guidelines/in-app-purchase
**Platforms:** all (iOS, iPadOS, macOS, tvOS, visionOS, watchOS); "no additional considerations" for iOS/macOS.
**Change log:** 2023-09-12 (artwork + offer-code redemption), 2022-11-03 (total-billing-price rule; consolidated). Stable page — but its rules overlap heavily with App Review subscription requirements.

**Purpose.** Selling **virtual goods**: the page covers store UX, paywalls/sign-up screens, Family Sharing, refunds, offer codes, and subscription management. Boundary rule (mirrored on the Apple Pay page): IAP = premium content/digital subscriptions; Apple Pay = physical goods/services/donations.

**Four IAP types** (Apple's taxonomy — use exact terms): **consumable** (depletes, repurchasable: lives, gems), **non-consumable** (permanent: premium features), **auto-renewable subscription** (renews each period until canceled), **non-renewing subscription** (fixed-term access, repurchased manually, e.g., battle pass). Apps with very large/multi-creator catalogs → **Advanced Commerce API**.

**Store best practices.**
- Let people experience the app before asking them to pay.
- The store must feel like **part of your app**, not an embedded foreign storefront.
- Short product names that don't truncate/wrap; plain language.
- **Display the total billing price for every IAP, regardless of type** (explicit rule since 2022).
- **Hide or explain the store when `canMakePayments` is false** (e.g., parental restrictions) — don't show a store that silently fails.
- **Use the system confirmation sheet as-is — never modify or replicate it.**

**Family Sharing.** Shareable purchases (auto-renewables, non-consumables) extend to **up to five additional family members**. Signal support in product names ("Family", "Shareable") and sign-up screens; adapt in-app messaging for family members ("Your family subscription includes…").

**Refunds and purchase help.**
- You can build a custom purchase-help screen that funnels into the **system-provided refund flow** (`beginRefundRequest`). Label the action simply **"Refund" or "Request a Refund"** (the system flow already explains Apple handles it).
- Help people identify the purchase: product image, name, description, original purchase date.
- Alternative remedies (re-fulfillment, conciliatory item) are fine, **but the refund button must not be buried** — no extra scrolling or extra screens to reach it.
- **Never characterize Apple's refund policies** or predict outcomes; link to Apple's refund support page instead.

**Auto-renewable subscriptions / paywalls.**
- Pitch subscription value during **onboarding** with a clear CTA + terms summary.
- Offer a range of tiers/durations; offer limited free access — **freemium, metered paywall, or free trial** (Apple's three named models).
- Prompt at relevant moments (nearing the monthly free-content limit), plus persistent subscribe entry points — **including in app settings** (a place people actively look).
- **Never pitch subscriptions to current subscribers** (implies their subscription lapsed); if the subscription is sold across apps/web, provide **sign-in** so people don't pay twice.

**Sign-up screen — required contents** (effectively App-Review checklist; applies on every platform):
1. Subscription **name, duration, and what's provided each period**;
2. **Billing amount, localized** for the sale territory/currency — totals in the most prominent position, per-period breakdowns subordinate so options can be compared;
3. **A way for existing subscribers to sign in or restore purchases** — i.e., **Restore Purchases lives on the paywall/sign-up screen itself**, not buried elsewhere.
Free trials must state **the trial duration and the amount auto-billed when it ends**. Ask only for necessary info at signup; defer the rest.

**Offer codes (iOS/iPadOS).** Two kinds: **one-time use codes** (unique, generated in App Store Connect; redeemable via link, in-app, or App Store entry; for small/controlled distribution) and **custom codes** (e.g., NEWYEAR; **alphanumeric ASCII only — no special, Chinese, or Arabic characters**; redeemable via URL or in-app **but not via App Store account settings — tell users how to redeem**). Support in-app redemption via the system sheet; natural homes for a "Redeem Code" button: **paywall, onboarding, settings**. Supply a promotional image or the redemption screens default to your app icon. Be ready to welcome users whose first-ever app launch is post-redemption (don't wall them behind heavy account creation).

**Subscription management.**
- Show a subscription **summary with the upcoming renewal date** in settings/account, next to the manage option (`SubscriptionInfo`).
- Prefer the system management UI (`showManageSubscriptions`) — upgrade/downgrade/cancel without leaving the app.
- **Cancellation must be easy to find** — a manage action that's deep or hard to recognize reads as obstruction (and is an App Review risk).
- At cancellation you may present a personalized retention offer or exit survey; custom branded UI may complement (not replace) the system flow; offer codes work for win-back.

**Reviewer checks.** Paywall missing any of: localized total price, period/terms, restore/sign-in affordance → App-Review-grade violation. Free-trial screen not stating post-trial charge and date → violation. Custom-drawn purchase confirmation replacing the system sheet → violation. Store visible with payments disabled and no explanation → flag. Refund action behind multiple screens → flag. "Subscribe" CTAs shown to active subscribers → flag. Physical goods sold via IAP, or app features unlocked via Apple Pay → wrong rail, rejection.

**Stale-knowledge corrections.** Largely stable since 2023, so older knowledge holds — main additions a model may miss: **Advanced Commerce API** (large catalogs), and that Apple's named free-access taxonomy is freemium / metered paywall / free trial. Note the StoreKit subscription-store SwiftUI views aren't covered on this page; the design rules here are framework-agnostic.

---

## Tap to Pay on iPhone

**URL:** https://developer.apple.com/design/human-interface-guidelines/tap-to-pay-on-iphone
**Platforms:** **iOS only** (not iPadOS, macOS, tvOS, visionOS, watchOS). Audience: payment-acceptance apps for merchants (POS), not consumer checkout.
**Change log:** "January 17, 2024" as printed on the page (Apple's what's-new index dates this same entry **2025-01-17** — the page entry appears to be a year typo since it sorts above May 7, 2024), 2024-05-07, 2023-03-03, 2022-09-14.

**Purpose.** Lets merchants accept contactless payments on iPhone with no extra hardware. Requires a supported **payment service provider (PSP)**, the Tap to Pay entitlement, and `ProximityReader` API. The tap UI, checkmark, and error screens are **system-provided**; your app owns everything around them.

**Key rules (condensed).**
- Terms & conditions must be accepted by an **administrative user** before first configuration; surface acceptance in settings/onboarding, not mid-checkout; non-admins get an explanatory message.
- **Merchant education:** provide a tutorial covering each supported payment type, how customers position card/wallet on the device, and PIN entry incl. accessibility mode — or use the `ProximityReaderDiscovery` pre-built, Apple-localized education experience.
- **Never block checkout on configuration:** prepare the feature at launch and on every foregrounding (`prepare(using:)`); keep the Tap to Pay option selectable during configuration with a progress indicator (indeterminate normally; determinate if the API reports ongoing configuration progress).
- **Button label is mandated:** "Tap to Pay on iPhone", or "Tap to Pay" when space-constrained — payment actions only. Sole-payment-method apps may reuse existing Charge/Checkout buttons. Icon, if any: SF Symbols `wave.3.right.circle`/`.fill`. **Never the Apple logo.** Button color/shape may match your app.
- Non-payment card reads (look up, store card, verify, refund) must use **generic labels** ("Look Up," "Store Card," "Verify," "Refund") — never "Tap to Pay" wording; same for independent loyalty-card reads.
- Determine the **final amount (incl. tips/pre-payment options) before** showing the Tap to Pay screen; show authorization progress after the system checkmark animation; clearly display declined vs. successful results; offer digital receipts (QR/text) and fallback paths (cash, hardware reader, payment link, retry with another card). Regional edge cases (SCA PIN-after-tap, Offline PIN markets) go through the PSP.

**Reviewer checks.** "Tap to Pay" label on a non-payment or loyalty action → violation. Apple logo in the button → violation. Checkout blocked while configuring → flag.

---

## Always On

**URL:** https://developer.apple.com/design/human-interface-guidelines/always-on
**Platforms:** iOS + watchOS only (not iPadOS/macOS/tvOS/visionOS).
**Change log:** 2023-09-12 (artwork), 2022-09-23 (expanded for iPhone 14 Pro). Stable page.

**Purpose.** Rules for app UI persisting on a dimmed, low-power, privacy-conscious display. **On iPhone** (14 Pro and later Pro models), Always On shows **Lock Screen items — widgets and Live Activities** — when the phone is set face-up and idle; so for iOS designers this page governs **widget/Live Activity behavior in the dimmed Lock Screen state**, not in-app UI (the in-app case is Apple Watch). Notifications appear in Always On on both devices; tapping exits.

**Normative rules.**
1. **Hide sensitive information** (bank balances, health data) — redaction is "crucial"; also applies to notification content.
2. Keep genuinely useful info glanceable (flight arrival, ride-share arrival on iPhone) — users who want nothing visible can disable Always On themselves.
3. **Dim nonessential content; keep the important thing legible** — strip row backgrounds, dim secondary text/details, replace rich images/large color fields with dimmed colors.
4. **Consistent layout across the transition** — don't remove interactive components, transition them to an unavailable appearance; make infrequent, subtle updates (a sports app pauses play-by-play, updates only the score). On iPhone this matters extra: a face-up phone on a table makes any motion visible peripherally.
5. **Transitions of in-progress motion: finish gracefully to a resting state, never stop instantly** (instant stops read as malfunction).

**Reviewer checks.** Live Activity/widget designs with no dimmed-state variant → flag. Personal data (balances, health metrics) identical in dimmed state → violation. Elements that disappear (instead of becoming unavailable) when Always On begins → flag. Frequent ticking updates/animation in the dimmed state → flag.

**Stale-knowledge corrections.** None significant; note Always On is in scope for iOS work despite the watch-flavored name — it constrains Live Activities and Lock Screen widgets on Pro iPhones.

---

## Workouts (iOS-relevant rules only)

**URL:** https://developer.apple.com/design/human-interface-guidelines/workouts
**Platforms:** iOS, iPadOS, watchOS (not macOS/tvOS/visionOS). **No change log on the page** (no dated revisions published).

**Purpose.** Fitness-experience UX. Mostly watchOS (workout sessions, metrics screens); the rules below carry to iPhone/iPad fitness apps (people carry iPhone/iPad while walking/running; iPad/Mac/TV used for live/recorded workout sessions).

**Rules that apply on iOS.**
- During an active workout, show only workout-relevant data/controls (elapsed/remaining time, calories, distance, lap/interval markers) — not your app's catalog or navigation.
- Make the **active state visually unmistakable** (live-updating metrics, distinct layout).
- Pause/resume/stop controls easy to find and tap, with clear start/stop feedback.
- If sensor data is unavailable, explain what's still recorded, in language modeled on Apple's Workout app (e.g., "GPS is not used during a Pool Swim… Apple Watch will still track your calories, laps, and distance using the built-in accelerometer.").
- **End-of-session summary screen** confirming completion + recorded data; consider including Activity rings for progress context.
- **Discard extremely brief sessions** (seconds long) automatically, or ask before recording.
- **Legibility in motion:** large font sizes, high-contrast colors, most important info easiest to read — Dynamic Type defaults are calibrated for stationary use, not running.
- **Activity rings are an Apple-designed element with fixed colors/meanings matching the Activity app — use them only for their documented purpose** (never as a generic progress ring or rebranded). See the separate `activity-rings` HIG page.

**Reviewer checks.** Fitness app showing full nav/catalog during an active session → flag. Ring-shaped progress UI mimicking Activity rings colors/stacking for non-Activity data → violation. Small/low-contrast metrics for in-motion use → flag.

---

## Designing for games + Game Center (triage)

**URLs:** https://developer.apple.com/design/human-interface-guidelines/designing-for-games · https://developer.apple.com/design/human-interface-guidelines/game-center
**Change logs:** designing-for-games — 2025-06-09 (touch controls + Game Center update), 2024-06-10 (new page). game-center — 2025-06-09 (challenges, multiplayer activities, **Apple Games app + Game Overlay**), 2024-02-02, 2023-09-12, 2023-05-02.

**Where game guidance lives.** The HIG has a dedicated games cluster: `designing-for-games` (platform integration), `game-center` (social layer), `game-controls` (touch + physical controllers), plus `menus#In-game-menus` and `going-full-screen`. A skill serving non-game apps can route all game questions there and to the GameKit docs. Since WWDC25 the player-facing surfaces are the **Apple Games app** and the **Game Overlay** (iOS/iPadOS/macOS system overlay reached from the Game Center **access point**); tvOS/visionOS still use the full-screen dashboard.

**Cross-cutting numbers a non-game designer may still want** (the games page is the one HIG location stating these per-platform minima in a single table):
- Text size — iOS/iPadOS default **17 pt**, minimum **11 pt**; macOS default **13 pt**, minimum **10 pt**.
- Button size — iOS/iPadOS default **44×44 pt**, minimum **28×28 pt**; macOS default **28×28 pt**, minimum **20×20 pt**.
- Default interaction methods — iOS: touch (+ game controller); macOS: keyboard/mouse/trackpad (+ game controller).
- Generally-applicable principles: initial download playable in ≤30 minutes with background download of the rest; smart defaults from device info; defer permission/rating prompts to the moment of need; design for full-screen; layouts must adapt to aspect ratios (16:10, 19.5:9, 4:3) and rounded corners/camera housings via safe areas.

**Game Center specifics worth retaining (brief).** Access point goes on menu/settings screens, any corner, never during gameplay/splash/tutorials; check collapsed+expanded overlap with controls; pause gameplay while the overlay/dashboard shows. Terminology is enforced: "Game Center" (never GameKit/GameCenter), "Achievements" (not Awards/Trophies/Medals), "Leaderboards" (not Rankings/Scores), "Challenges" (not Competitions), "Add Friends". Asset specs: achievement images **512×512 pt (1024×1024 px @2x), circular mask, PNG/TIF/JPG, sRGB/P3, ≥72 DPI**; leaderboard images (iOS/iPadOS/macOS) **512×512 pt, cropped area 512×312 pt**; challenge & multiplayer-activity artwork **1920×1080 pt (3840×2160 px @2x), cropped area 1465×767 pt**. Challenges should be 1–5 minute individually-completable activities tracking the most recent score (not personal bests); party codes are ~8-char alphanumeric (e.g., "2MP4-9CMF") and should be viewable/enterable manually, with late-join/leave/return supported.

---

## Cross-page observations for skill design

- **Rail-picking is the first commerce decision:** physical/services/donations → Apple Pay; virtual/digital → IAP; merchant-side acceptance → Tap to Pay. Both Apple Pay and IAP pages carry the same boundary aside; getting it wrong is an App Review rejection, not a style issue.
- The commerce pages are the HIG's most **enforcement-heavy** cluster: mandated button artwork/labels ("Apple Pay" via API only; "Tap to Pay on iPhone"; white-on-black Verify with Wallet), mandated paywall contents (price, terms, restore purchases), and trademark text rules. Reviewer checks here are unusually mechanical/checkable.
- Numeric spec density: Apple Pay buttons (100/140×30 pt, 1/10-height margins), website icon (60×60 pt @2x/@3x), Wallet pass images (9 named files with pt dimensions), order-tracking images (300×300 px), Game Center artwork (512×512, 1920×1080). These belong in lookup tables, not prose.
- Freshness split: Apple Pay + Wallet are 2026-06-08-current (Pass Designer, iOS 27); IAP is 2023-stable; Tap to Pay 2024/25-stable; Always On/Workouts stable. Liquid Glass affects these pages mainly through the refreshed Apple Pay button appearance (always API-rendered, so designs inherit it automatically).
