# HIG compliance in practice — what people actually struggle with

Research notes, 2026-06-10. Sources: web search + fetches across NN/g, RevenueCat, Apple Developer Forums,
HN, developer blogs, State of AI in Design 2026, WWDC26 coverage (WWDC26 ran June 8-12, 2026 — this week).
Companion to the per-topic HIG spec notes; this file covers real-world practice, not Apple's published rules.

---

## Provenance corrections (2026-06-10 audit)

A completeness audit found two press-sourced WWDC26 claims in this file (and in `_currency.md`) that are
**contradicted or unsupported by the live HIG**, re-verified 2026-06-10 against the JSON API (sidebars,
searching, search-fields, tab-bars). Affected text below is annotated in place, not deleted.

**1. "iOS 27 re-integrates search with the other tabs, reversing the iOS 26 split-search"**
(§1 *Navigation misuse* NOTE; §3 *WWDC26 changes designers must know*).
Live HIG: the Searching page (updated **2026-06-08**) still teaches search as *"a dedicated tab"* in
tab-bar apps (Photos, Apple TV) or a bottom-toolbar field (Notes, Mail, Settings). The search-fields page
(**2026-06-08**) defines **two co-equal search-tab styles** — *standard tab* (uniform with other tabs,
opens a search landing page) and *button appearance* (separate button, immediately focuses the field) —
each recommended for different use cases. The tab-bars page (**2026-06-08**) still says *"A tab bar can
include a dedicated search tab at the trailing end."* There is **no reversal/reintegration narrative**;
"custom tab bars mimicking iOS 26 are now stale" does not follow from Apple's guidance.

**2. "Colored sidebar icons return (active app only)" as a macOS 27 Golden Gate change** (§3).
Live HIG: the Sidebars page (updated **2026-06-08**, "Updated guidance for sidebar icon colors") says
icons use the **app accent colour by default**, must follow the user-chosen macOS system accent colour,
and may use fixed colours *sparingly* for meaning (Mail's VIP yellow). No monochrome-then-restored
storyline and no 26-vs-27 distinction exists in the HIG.

**Rule going forward:** press-sourced claims (MacRumors, Cult of Mac, Engadget, NN/g event coverage, etc.)
must be **version-gated** ("press reports iOS 27 will…; not reflected in the HIG as of YYYY-MM-DD") and
**never encoded as HIG doctrine**. Normative rules in the skills must trace to a live HIG page cited with
its change-log date.

---

## 1. Most common HIG violations actually committed

Ranked roughly by how often they appear in community discussion, audits, and "doesn't feel native" complaints.

### Navigation misuse
- Reinventing navigation instead of using `NavigationStack` / `UITabBar` / `NavigationSplitView` patterns:
  custom hamburger menus on iOS, custom back buttons that break the interactive swipe-back gesture,
  modals used for drill-down flows that should be pushes.
- Custom/emulated tab bars are a growing problem in the Liquid Glass era: iOS 26's floating capsule tab bar
  with separated search button created confusion about navigation vs action. Ryan Ashcraft documents apps
  "hijacking the search tab" or fully emulating the tab bar, which "blurs the line between navigation and
  action — and with it, the predictability that makes iOS feel coherent"
  (https://ryanashcraft.com/ios-26-tab-bar-beef/). NOTE: iOS 27 (announced WWDC26 this week) re-integrates
  search with the other tabs, reversing the split-search pattern — custom tab bar implementations built to
  mimic iOS 26 are now stale. **[⚠ PROVENANCE CORRECTION 2026-06-10: this NOTE is press-sourced and
  unsupported by the live HIG — searching/search-fields/tab-bars (all 2026-06-08) still teach a dedicated
  search tab (standard or button-appearance style) and toolbar search as current options; no reversal. See
  "Provenance corrections" at top.]**
- Burying essential actions in overflow menus (Apple's own Safari 26 was criticized by NN/g for hiding tabs
  behind an ellipsis menu — the HIG principle is that only nonessential actions belong in overflow).

### Touch targets and spacing
- The 44x44 pt minimum hit target is the single most-cited mechanical rule, and the most-violated.
  Designers size the *visible glyph* (e.g. 24 pt icon) and forget the *hit area*; in SwiftUI the tappable
  area defaults to the label's bounds, not the surrounding glass/padding (`contentShape` needed).
- Spacing between adjacent targets: NN/g cites ~0.4 cm minimum spacing between targets and ~1 cm x 1 cm
  tap areas as the classic research-backed thresholds — and notes Apple itself regressed on these in iOS 26's
  crowded capsule tab bars. Third-party designers copy that crowding.
- WCAG mapping designers ask about: Apple's 44 pt aligns with WCAG 2.5.5 (AAA); WCAG 2.5.8 (AA) is only
  24x24 CSS px — passing WCAG AA does NOT mean passing the HIG.

### Typography
- Ignoring Dynamic Type entirely (fixed font sizes) is the top accessibility-audit finding; body text below
  17 pt is the common concrete violation. Truncation/overlap at larger accessibility sizes goes untested.
- Using non-system fonts for UI chrome, wrong text-style hierarchy (e.g. everything in one size), tight
  line-spacing copied from web/print habits.

### Dark mode failures (recurring audit theme)
- Pure `#000000` backgrounds with hardcoded grays instead of semantic colors (`label`, `secondaryLabel`,
  `systemBackground`, `separator`) — misses Apple's base vs elevated background system (in dark mode the
  system brightens *elevated* surfaces to convey depth; shadows are nearly invisible on dark).
- Saturated accent colors reused unchanged from light mode (washed out / vibrating on dark surfaces).
- Hardcoded white text that breaks when the view appears in light mode, and images/illustrations with baked-in
  light backgrounds.
- Apps that implement dark mode by inverting colors rather than re-deriving hierarchy. Community consensus:
  "implement it right or don't implement it at all."

### Non-native controls and platform transplants
- Android-style components on iOS (Material ripples, FABs, left-side drawers, Android back behavior) —
  this is one of the few aesthetic issues App Review has actually called out ("Android-style buttons" appears
  in rejection anecdotes).
- On macOS: Electron/web-wrapper apps that lack a real menu bar, don't register standard shortcuts, render
  shortcuts wrong (e.g. "⌘#" instead of "⇧⌘3" — electron/electron#21790), break Ctrl+F2 menu-bar focus,
  ignore multi-window/resizable expectations. The macOS power-user contract: every Mac app must have a
  complete menu bar (it is the primary command-discovery mechanism), full keyboard control, standard
  shortcuts, and window restoration. Web-first designers miss all of this.
- Sign in with Apple button built as a custom button instead of `ASAuthorizationAppleIDButton` styling —
  disproportionately common because it's the one branding rule App Review checks pixel-by-pixel.

### Other recurring violations
- Blurry/wrong-size app icons and graphic assets (also a stated rejection trigger).
- No safe-area handling: content under the Dynamic Island / home indicator, or conversely dead letterboxed
  bands (iOS 26+ expects edge-to-edge content with scroll-edge effects, not blank margins).
- Gesture conflicts: custom horizontal swipes that fight the system back-swipe; custom pull-to-refresh.
- Accessibility beyond type: missing VoiceOver labels, no Reduce Motion/Reduce Transparency handling —
  the latter became much more visible with Liquid Glass.

---

## 2. App Store review reality: hard rejections vs soft quality issues

Key insight: **App Review enforces a thin, mostly objective subset of the HIG. The HIG itself is largely
unenforced "quality" guidance.** A skill suite should not justify rules with "Apple will reject you" except
for the specific cases below.

### What actually gets rejected (Guideline 4 'Design' of the App Review Guidelines)
- **4.2 Minimum Functionality — the big one.** Apple reports completeness-related issues account for
  over 40% of unresolved review issues (per RevenueCat's guide). Triggers: app looks unfinished, placeholder
  content, broken layouts, crashes, "thin wrapper around a website" with no native experience. This is the
  rejection that punishes *web-wrapper* shipping — directly relevant to an HTML-prototyping designer.
- **4.0 Design (general).** In practice cited for: Sign in with Apple button/branding violations (very
  common — including asking the user to re-enter a name that AuthenticationServices already provides),
  spelling/grammar errors, broken/overlapping layouts, blurry icons, UI that's visibly non-iOS
  ("Android-style buttons" anecdotes), spinner-only screens.
- **4.1 Copycats** — design too similar to an existing app; common in saturated categories.
- **4.3 Spam/redundancy** — repackaged templates; relevant to agencies, not to bespoke design.
- Reviewers' automated pre-checks reportedly flag unusual custom gestures/animations as HIG deviations,
  producing false-positive design rejections that get overturned on appeal (appitventures.com) — novel
  interaction design carries review *risk* even when HIG-defensible.

### What does NOT get you rejected (soft quality tier)
- Non-semantic colors, mediocre dark mode, fixed type sizes, 40 pt touch targets, custom navigation,
  non-standard icons inside the app, ignoring Liquid Glass adoption entirely (apps compiled against older
  SDKs still ship). These degrade perceived quality, App Store featuring chances, and ratings — not approval.
- Practical framing for skills: three tiers — (a) review-blocking (4.x objective rules), (b) feels-broken
  (gesture conflicts, illegible contrast, truncation at large type), (c) feels-non-native (semantic color,
  motion, materials, terminology). Tier (a) is a checklist; (b) and (c) are design review.

---

## 3. Liquid Glass adoption pain (June 2025 → now)

### Community critique (what to protect designers from repeating)
- NN/g's "Liquid Glass Is Cracked" is the canonical critique (https://www.nngroup.com/articles/liquid-glass/):
  - Translucent controls over busy backgrounds → text/icons "often invisible"; text-over-text (search bar
    blending into Mail previews) → "illegible mess".
  - Crowded capsule tab bars + detached search button → fragmented, harder to scan; tap-target spacing
    below the 0.4 cm threshold.
  - Context-dependent morphing controls (tab bar collapsing into search, appearing/vanishing buttons)
    → unpredictability, harder to learn.
  - Gratuitous motion: pulsating buttons, shimmering titles, wiggling tab bars — "shouting look at me when
    it should quietly step aside".
  - Back button lost its breadcrumb label → users guess where back goes.
- HN threads ("Liquid Glass: Apple vs. Accessibility", "Soaping up Liquid Glass") and Michael Tsai's
  link-roundups echo: if the design needs Reduce Transparency to be comfortable, the default is wrong.
  WCAG contrast failures over colorful backgrounds are the recurring measurable complaint.
- Apple's own trajectory validates the critique: betas got progressively more frosted; a "Tinted" variant
  was added after Clear proved illegible; iOS 26 shipped opt-outs (Reduce Transparency / Increase Contrast);
  and **at WWDC26 this week Apple added a system-wide Liquid Glass intensity slider ("anywhere from ultra
  clear to fully tinted"), changed the default look to be more legible, and said it rebuilt "the foundations
  of how Liquid Glass is built" (iOS 27 / macOS 27 "Golden Gate").**

### WWDC26 changes designers must know (June 8-12, 2026)
- Liquid Glass intensity slider (user-controlled transparency→opacity); designs must remain legible across
  the whole slider range, not just the default.
- Tab bar search re-integrated with other tabs (reverses iOS 26 split-search; affects Music/TV/Podcasts/
  News/Health and third-party custom tab bars). **[⚠ PROVENANCE CORRECTION 2026-06-10: press-sourced;
  contradicted by the live HIG — both the dedicated trailing search tab and the separated button
  appearance remain current, co-equal patterns (search-fields/tab-bars, 2026-06-08). See top of file.]**
- macOS 27 "Golden Gate": unified/frosted toolbar returns at top of windows; sidebars extend to window
  edge; colored sidebar icons return (active app only) **[⚠ PROVENANCE CORRECTION 2026-06-10: the
  "colored icons return" item is press-sourced; the live Sidebars page (2026-06-08) says icons use the
  app accent colour by default and follow the user's macOS accent colour — no return/restoration
  narrative. See top of file.]**; tighter window corner radius; refreshed app icons
  with integrated Liquid Glass layers. Most changes apply automatically to apps already on the LG frameworks.
- HIG republished at Platforms State of the Union with updated contrast/legibility standards responding to
  the iOS 26 failures. (Spec notes should be re-verified against the new HIG text as it propagates.)

### Designer/developer mistakes specific to Liquid Glass
- **Applying glass to content.** The #1 conceptual error: `.glassEffect()` on list items/cards. Liquid Glass
  is reserved for the floating *navigation/control layer*; content stays at the base layer. (Both Apple
  guidance and every shipping-experience writeup repeat this.)
- **Glass-on-glass stacking** and glass over busy imagery without a scrim — the legibility failure mode.
- **Not grouping effects:** multiple separate `glassEffect`s instead of one `GlassEffectContainer` —
  each backdrop layer costs ~3 offscreen textures; container merges `CABackdropLayer`s (performance).
- **Hit-testing regressions:** glass buttons accept taps only on the label by default; need
  `contentShape(...)` to make the whole glass area tappable.
- **Morph animation glitches:** capsule↔circle morphs snap/break across iOS 26.0/26.1, especially `Menu`
  inside `GlassEffectContainer`; workarounds changed between point releases (juniperphoton.substack.com).
  Lesson for skills: morphing glass groups are fragile; prototype them on hardware.
- **Simulator deception:** specular highlights and motion response don't render correctly in the simulator —
  hardware verification required.
- **Faking glass on the web:** SVG-filter refraction works only in Chromium; WebGL is too heavy for
  production. HTML prototypes approximate with `backdrop-filter: blur()` + tint + border highlights —
  acceptable for prototypes, but designers must flag that real refraction/lensing behavior differs.
- Smaller teams report the increased design complexity (materials, morphing, scroll-edge effects) is itself
  a burden — exactly the gap a skill suite fills.

---

## 4. How designers prototype for iOS/macOS today, and fidelity verification

### Figma
- Apple ships an official "iOS and iPadOS 26" Figma kit (fully overhauled July 2025 for Liquid Glass:
  controls, updated control sizes/corner radii, system colors, materials, text/color styles, layout guides)
  — https://www.figma.com/community/file/1527721578857867021. macOS kit equivalents also exist; community
  LG kits and a "Liquid Glass" Figma plugin fill gaps.
- Figma added a native glass effect to approximate LG materials.
- Known failure mode: static Figma comps can't express scroll-edge effects, morphing controls, Dynamic Type
  reflow, or the legibility of glass over *moving* content — the exact areas where LG designs fail in review
  by NN/g-style critique. Verification of these requires motion/code.
- Figma→SwiftUI codegen is poor: per-layer ZStacks with absolute frames, no stack inference; tool roundups
  (2026) say 20-50% of time goes to refining output. Don't treat generated SwiftUI as native-fidelity proof.

### SwiftUI as a design tool
- Growing "designers who code SwiftUI" movement (Design+Code, swiftuiprototyping.com): Xcode Previews give
  live, on-device-accurate rendering; SwiftUI is pitched to designers as "just another design tool".
- Highest-fidelity option: free correct nav transitions, Dynamic Type, dark mode, materials. The catch for
  LG specifically: simulator ≠ hardware for glass rendering.

### HTML prototypes (this user's primary medium)
- Standard techniques to make HTML feel native (Sam Selikoff's checklist + WebKit guidance):
  - `<meta name="viewport" content="initial-scale=1, viewport-fit=cover, user-scalable=no">`
  - PWA standalone: webmanifest `"display": "standalone"`, `apple-mobile-web-app-status-bar-style:
    black-translucent`, icons/splash via pwa-asset-generator.
  - Safe areas: `env(safe-area-inset-top/right/bottom/left)` padding; edge-to-edge content scrolling
    under chrome rather than letterboxed.
  - `-webkit-tap-highlight-color: transparent` + explicit active states; `font-family: -apple-system` /
    `system-ui` for SF Pro; momentum scroll and body-scroll-locking for modals (Ben Frain's technique).
  - Test in Xcode Simulator's Safari, not desktop Chrome.
- iOS-26-accurate CSS work exists (`@rdlabo/ionic-theme-ios26`): replicates floating tabs, bigger radii,
  icon-only nav buttons, left-aligned alert text, edge effects — but concedes the liquid refraction effect
  itself is impractical on the web. Push transitions and sheet detents also remain approximations.
- **Fidelity verification today is manual and weak:** side-by-side with screenshots of native apps,
  transparency-overlay comparison, testing on device via home-screen PWA. Nobody has a good "HIG diff" for
  an HTML prototype — a clear opportunity for the skill suite (check list of native behaviors the prototype
  must emulate or explicitly waive: swipe-back, rubber-banding, sheet detents, scroll-edge effects, Dynamic
  Type, dark mode, intensity-slider legibility).

### macOS prototyping
- Much thinner tooling/kit ecosystem than iOS; designers tend to design macOS in Figma with iOS habits, which
  produces the classic non-native-Mac failures (no menu bar thinking, no keyboard map, wrong toolbar
  patterns). WWDC26's macOS 27 toolbar/sidebar changes reset these conventions again.

---

## 5. What people want from AI design review

- State of AI in Design 2026 (stateofaidesign.com): 91% of designers use AI at least weekly (up from 54%
  in 2025); Claude overtook ChatGPT as designers' most-used AI tool; **Design QA & accessibility is one of
  the fastest-growing AI workflows (+16 pp YoY), with developer handoff +12 pp.** Design QA moved from edge
  to mainstream practice this year.
- Frustrations with current AI review: lack of control over output (ranked #2 obstacle), poor integration
  with existing tools (Figma/Xcode/repos), and enterprise security/compliance concerns. Designers want
  non-linear "research → concept → code" flows, not a separate critique silo.
- Screenshot-critique experience: LLMs give decent generic critique (hierarchy, responsiveness) but
  reviewers note vagueness without grounding — they want critiques anchored to a *specific authority*
  (exact HIG rule, exact numeric spec) rather than taste. That is precisely what an HIG-grounded skill
  provides: citations to named guidelines + checkable numbers (44 pt, 17 pt body, contrast ratios, corner
  radii, safe-area insets).
- Terminal-based designer workflow is real: designers report living in Claude Code for months, building
  prototypes and testing ideas — meaning skills can assume agentic, code-adjacent review (read the HTML/
  SwiftUI source, render screenshots, check numbers) rather than only image critique.
- Implied demand set for an AI HIG reviewer:
  1. Severity-tiered findings (review-blocking vs broken vs non-native — mirrors section 2 tiers).
  2. Exact-spec citations ("HIG: Buttons — 44x44 pt minimum") not vibes.
  3. Currency: post-LG, post-WWDC26 rules; flag stale flat-design assumptions explicitly.
  4. Medium-aware review: knows an HTML prototype can't do real refraction, checks the things HTML *can*
     get right and lists native behaviors to verify later in SwiftUI/on hardware.
  5. Actionable fixes in the designer's medium (CSS for HTML prototypes, modifier for SwiftUI, kit
     component for Figma).

---

## Cross-cutting implications for skill design (summary)

1. **Three distinct workflows confirmed:** (a) build-time guidance while creating (right pattern/control/
   spec on demand), (b) review/audit of an existing design or prototype (severity-tiered, citation-backed),
   (c) raw spec lookup (numbers, terminology). The review workflow is the fastest-growing AI use case.
2. **Stale-knowledge correction is a core feature, not a footnote.** Two redesign waves in 12 months
   (LG at WWDC25, LG-foundations rework + macOS Golden Gate at WWDC26 this week). Model priors anchored on
   flat-design-era iOS are wrong about: tab bars, search placement, materials vs opaque bars, corner radii,
   sidebar behavior, toolbar styling, icon construction (layered LG icons), safe-area edge effects.
3. **Severity tiers must separate App-Review-blocking rules (Guideline 4.x; ~thin objective set led by
   4.2 minimum functionality at >40% of unresolved issues and Sign-in-with-Apple branding) from quality
   guidance** — never claim "Apple will reject this" for soft issues.
4. **Per-medium adapters needed:** HTML prototype (safe-area env vars, standalone PWA, backdrop-filter
   approximations, explicit list of unreproducible native behaviors), SwiftUI (glassEffect/Container
   pitfalls, hit-testing, simulator limits), Figma (official Apple kits, what static comps cannot prove).
5. **Liquid Glass checkables:** glass only on the floating control layer never content; one
   GlassEffectContainer per group; legibility across the full new intensity slider range; scrim over busy
   imagery; test Reduce Transparency / Increase Contrast / Reduce Motion variants; hardware check for
   specular/motion.
6. **macOS deserves its own checklist** (menu bar completeness, keyboard shortcuts with correct symbols,
   multi-window, new Golden Gate toolbar/sidebar/corner-radius conventions) — web-first designers fail
   macOS in different ways than iOS.
7. **Numbers worth hardcoding in skills:** 44x44 pt min target (WCAG 2.5.5 AAA-aligned; 2.5.8 AA's 24 px
   is NOT enough), ~8 pt spacing between targets (0.4 cm), 17 pt Dynamic Type body baseline, base vs
   elevated dark-mode background system, semantic color names.
