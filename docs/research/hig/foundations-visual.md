# HIG research notes — Foundations: visual design (foundations-visual)

> Captured 2026-06-10 from Apple's JSON content API (`https://developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json`). 11 pages: app-icons, branding, color, dark-mode, icons, images, layout, materials, motion, sf-symbols, typography. Scope: iOS + macOS (iPadOS noted only where it clarifies adaptive behaviour; tvOS/visionOS/watchOS content omitted unless it disambiguates terminology).
> Bucket-level currency note: app-icons was updated 2026-06-08 (WWDC26, "Refined guidance for Liquid Glass"); color and typography 2025-12-16; materials and motion 2025-09-09; layout 2025-09-09 (device specs) with Liquid Glass guidance from 2025-06-09; sf-symbols 2025-07-28 (SF Symbols 7); icons 2025-06-09; dark-mode last touched 2024-08-06 (stable); branding unchanged; images 2025-12-16 (visionOS-only additions).

## Cross-cutting model of the Liquid Glass era (read first)

- The interface has **two layers**: the **content layer** (app content, backgrounds, in-content controls) and a **functional layer** of controls/navigation (tab bars, toolbars, sidebars) made of **Liquid Glass** that *floats above* the content. Content scrolls edge-to-edge underneath the glass.
- **Liquid Glass** is documented inside the Materials page (`materials#Liquid-Glass`); there is no standalone HIG page. Colour rules for it live at `color#Liquid-Glass-color`. Developer entry points: "Adopting Liquid Glass" (TechnologyOverviews), `glassEffect(_:in:)` (SwiftUI), `UIGlassEffect`-era UIKit APIs, "Applying Liquid Glass to custom views".
- Liquid Glass properties: no inherent colour (takes on colour from content behind it), specular highlights, refraction, translucency; adapts between light/dark appearance based on underlying content; symbols/text on it default to a **monochromatic** scheme (dark over light content, light over dark content); appears **more opaque in larger elements** (sidebars) for legibility.
- Two Liquid Glass variants: **regular** (default — blurs + adjusts luminosity of background; use for text-heavy components: alerts, sidebars, popovers) and **clear** (highly translucent; only over visually rich media backgrounds; may need a **35%-opacity dark dimming layer** when underlying content is bright).
- System components get Liquid Glass automatically. Custom Liquid Glass is to be used *sparingly*, never in the content layer (exception: transient interactive elements — a slider knob or toggle takes on glass while actively manipulated).

---

## 1. App icons

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/app-icons
**Status:** updated 2026-06-08 ("Refined guidance for Liquid Glass"); previous major rewrite 2025-06-09 (layered icons).

**Purpose.** Governs the design, layering, shape, appearance variants, and deliverable specs of the app icon shown on the Home Screen, in search, notifications, Settings, and share sheets.

**Normative rules.**
- iOS/iPadOS/macOS/watchOS icons are **layered**: one background layer + one or more foreground layers, assembled in **Icon Composer** (ships with Xcode / Apple Developer site). The system applies Liquid Glass attributes — specular highlights, refraction, translucency — that adapt with icon size and can differ between OS versions.
- In Icon Composer you: define the background, place foreground layers, apply glass effects, **annotate default / dark / mono appearance variants**, preview across system versions, export for Xcode.
- **Prefer clearly defined edges** in foreground layers; avoid soft/feathered edges (breaks system highlights/shadows).
- **Vary opacity in foreground layers** for depth (import fully opaque layers, adjust transparency inside Icon Composer).
- Background: prefer solid colour or gradient defined in Icon Composer; if importing a background image it must be **full-bleed and opaque**.
- **Prefer vector layers (SVG/PDF)**; outline all text/strokes. Use PNG (lossless) for mesh gradients / raster artwork.
- **Shape:** iOS/iPadOS/macOS icons are square; the **system applies the rounded-corner mask** matching the concentricity of system UI and device bezel. Provide **square, unmasked layers** — pre-masked layers degrade specular highlights and produce jagged edges. Keep primary content centred to survive masking.
- Design: simple; one core concept; minimal shapes; simple background (solid/gradient); you don't need to fill the entire canvas. Prefer **filled, overlapping shapes** for depth. **Provide a visually consistent icon across all platforms** (one design, recognisable everywhere).
- **Text in icons:** only when essential to the brand; no calls to action ("Watch", "Play"); no context terms ("New"); a single-letter mnemonic is acceptable. Text doesn't localise or support accessibility.
- **Prefer illustrations over photos; never replicate UI components or screenshots; never depict Apple hardware** (copyrighted).
- **Do NOT bake in visual effects** — no custom specular highlights, drop shadows between layers, bevels, blurs, glows. The system supplies dynamic ones. Layer groups in Icon Composer can receive group-level glass effect configuration.
- **Appearances (iOS/iPadOS/macOS):** users can set Home Screen icons to **default, dark, clear, or tinted**. Full variant set per the spec table: **default, dark, clear light, clear dark, tinted light, tinted dark**. The system auto-generates any variant you don't supply. Keep core features identical across variants (no swapping elements). Build the dark icon from the light one; colour backgrounds give the best contrast in dark icons; dark icons are subdued, clear/tinted ones more so.
- **Alternate app icons** (iOS/iPadOS): allowed via in-app setting; each must stay closely related to the app and require their own dark/clear/tinted variants; all icons go through App Review.
- **Specifications (iOS, iPadOS, macOS):** layout shape Square; masked result Rounded rectangle; **layout size 1024×1024 px**; style Layered; appearances default/dark/clear-light/clear-dark/tinted-light/tinted-dark. The system auto-scales all smaller variants (Settings, notifications, etc.).
- **Colour spaces:** sRGB, Gray Gamma 2.2 (grayscale), Display P3.

**iOS vs macOS.** None — "No additional considerations for iOS, iPadOS, or macOS." The pipeline, shape, size, and appearance variants are now **identical** across the three platforms.

**Reviewer checks.**
- Icon supplied as a single 1024×1024 square with no pre-applied corner rounding/masking? (Pre-rounded corners = violation.)
- No baked-in drop shadows, bevels, glows, specular highlights?
- Dark / clear / tinted variants exist or consciously delegated to system generation? Alternate icons each have variants?
- No photos, no screenshots/UI replicas, no Apple hardware, no nonessential text?
- Same core design across iOS and macOS deliverables?
- Foreground edges crisp (no feathering); background full-bleed opaque if image-based.

**Stale-knowledge corrections.**
- Pre-2025 models assume flat, single-image icons with a designer-supplied squircle and a grid of export sizes. Current: **one 1024 px layered source** built in **Icon Composer** (a tool that didn't exist before June 2025); the system masks and renders glass effects.
- Pre-2025 macOS guidance allowed freeform/realistic icon shapes (Big Sur rounded-rect with overhanging elements). Now: macOS uses the **same square layout and system mask** as iOS — no overhanging elements, no platform-specific shape.
- "Clear" appearance variants (clear light/clear dark) are new in the Liquid Glass era; "dark and tinted" arrived June 2024; tinted now splits into tinted light/tinted dark. A model recalling only "light + dark" icon variants is two generations behind.
- The old advice "add a subtle gradient and avoid transparency" is obsolete: transparency *within foreground layers* is now encouraged for depth.

---

## 2. Branding

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/branding
**Status:** no recent alert; stable page.

**Purpose.** How to express brand identity (colour, font, voice) without fighting platform conventions or stealing space from content.

**Normative rules.**
- Use brand **voice and tone** in all written communication.
- **Consider an accent colour** — the system applies it to interface icons, buttons, text. **macOS caveat:** users can override the app accent colour with their own system-wide accent choice; design must tolerate that substitution.
- **Custom font:** acceptable if legible at all sizes and supporting bold text + larger type accessibility; recommended pattern — custom font for headlines/subheadings, **system font for body and captions**.
- **Branding always defers to content** — no persistent brand chrome that displays nothing useful.
- Keep standard patterns: components in expected places, standard symbols for common actions.
- **Don't repeat the logo throughout the app**; people know which app they're in.
- **Never use the launch screen as a branding splash** — it disappears too quickly; use a welcome/onboarding screen instead if needed.
- **Apple trademarks must not appear in app names or imagery** (Apple Trademark List, Guidelines for Using Apple Trademarks).

**iOS vs macOS.** Only the macOS accent-colour override noted above; otherwise "No additional considerations" for any platform.

**Reviewer checks.**
- Splash/launch screen carrying a logo or tagline? Flag.
- Logo appearing in toolbars/headers on multiple screens? Flag.
- Brand colour used on both interactive and non-interactive elements (ambiguity)? Flag (cross-ref Color page).
- Custom font used for body copy at small sizes? Suggest system font for body/captions.
- macOS design that breaks if the user's accent colour replaces the brand accent? Flag.

**Stale-knowledge corrections.** None significant — this guidance is stable across eras. (The launch-screen rule predates 2025 and still stands.)

---

## 3. Color

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/color
**Status:** updated 2025-12-16 ("Updated guidance for Liquid Glass"); system colour **values were changed** 2025-06-09.

**Purpose.** Use of system-defined and custom colour: consistency, adaptivity (light/dark/increased contrast), Liquid Glass tinting, colour management/gamuts, and the semantic colour vocabularies of each platform.

**Normative rules.**
- **Never use one colour for two meanings** (e.g. brand colour for both interactive buttons and decorative non-interactive text).
- All colours must work in **light, dark, and increased-contrast** contexts. Custom colours need light + dark variants **plus an increased-contrast variant of each**. **Even single-appearance apps must supply light and dark colours "to support Liquid Glass adaptivity"** — new, checkable rule.
- Test under different lighting and on True Tone displays; test macOS under different colour profiles (P3 vs sRGB via System Settings > Displays).
- **Inclusive colour:** never rely on colour alone for state/interactivity/information — pair with text labels or glyph shape; mind cultural colour connotations.
- **Do not hard-code system colour values** — documented values are reference-only and "may fluctuate from release to release." Use APIs (`Color`, `UIColor`, `NSColor`). (Note: the HIG now publishes swatches as images, not RGB text — a deliberate de-emphasis of copying values.)
- **Dynamic system colours** are semantic (purpose-defined, not appearance-defined). Don't redefine their semantics (no `separator` as text colour, no `secondaryLabel` as background).
- **Liquid Glass colour rules:**
  - Glass has **no inherent colour**; tinting it produces a "stained glass" effect for *emphasis only*.
  - **Apply colour sparingly on glass**; reserve for status indicators or the **single primary action** (e.g. the system tints the Done button's *background* with the app accent colour). "Refrain from adding color to the background of multiple controls."
  - To emphasise a primary action, **tint the background, not the symbol/text**.
  - Symbols/text on toolbars/tab bars default to **monochromatic**, auto-darkening/lightening against underlying content.
  - With colourful app backgrounds, prefer monochromatic toolbars/tab bars or a high-differentiation accent; with monochromatic content, a brand accent colour works well.
  - Watch colour collisions between the content layer and controls — the **resting state** (e.g. top of scroll) must maintain legibility.
- **Colour management:** apply colour profiles to all images; sRGB is the safe baseline; use **Display P3 at 16 bpc, exported as PNG** for wide-gamut work; provide per-gamut asset variants when P3-only distinctions matter (asset catalog supports this). Designing P3 requires a wide-colour display.
- **iOS/iPadOS semantic palette:** two background sets — **system** (`systemBackground`, `secondarySystemBackground`, `tertiarySystemBackground`) and **grouped** (`systemGroupedBackground` + secondary/tertiary) — use grouped for grouped table views. Hierarchy convention: primary = overall view, secondary = grouping within view, tertiary = grouping within secondary. Foreground: `label`, `secondaryLabel`, `tertiaryLabel`, `quaternaryLabel`, `placeholderText`, `separator` (translucent), `opaqueSeparator`, `link`. Plus six grays: `systemGray` … `systemGray6` (SwiftUI only exposes `gray` = systemGray).
- **macOS semantic palette:** ~35 named colours incl. `labelColor` (+secondary/tertiary/quaternary), `controlColor`, `controlAccentColor`, `controlBackgroundColor`, `selectedContentBackgroundColor`, `separatorColor`, `windowBackgroundColor`, `underPageBackgroundColor`, `textBackgroundColor`, `findHighlightColor`, `keyboardFocusIndicatorColor`, unemphasized-selection variants, etc. (full table in page).
- **macOS accent colour:** app-specified accent applies only while System Settings General > Accent color = **multicolor**; otherwise the user's colour replaces it everywhere except **fixed-colour sidebar icons**, which the system never overrides.
- **System colours (both platforms, unified table):** red, orange, yellow, green, mint, teal, cyan, blue, indigo, purple, pink, brown — each with default light/dark + increased-contrast light/dark variants. (Values shown as images only; treat memorised RGBs as unreliable.)

**iOS vs macOS.**
- Completely different semantic colour vocabularies (background sets + labels vs the large AppKit control-colour list) — a reviewer must use the right namespace per platform.
- macOS adds user accent-colour override + multicolor rule and desktop-tinting interplay; iOS has none of this.
- iOS gray scale (systemGray–systemGray6) has no macOS equivalent.

**Reviewer checks.**
- Hard-coded hex values for system-ish colours (e.g. #007AFF assumed = systemBlue)? Flag — values changed June 2025 and are API-only.
- Same hue used for interactive and non-interactive elements?
- Any colour-only state signalling (no label/shape redundancy)?
- Custom palette missing dark or increased-contrast variants? (Required even for single-appearance apps.)
- More than one tinted/prominent glass control per bar or view? Flag ("refrain from adding color to the background of multiple controls").
- Toolbar/tab-bar symbols individually multi-coloured over rich backgrounds instead of monochromatic?
- Semantic misuse: separator-as-text, label-as-fill, grouped backgrounds on a non-grouped screen.
- HTML prototypes: are tokens structured semantically (label/secondaryLabel/background hierarchy) rather than raw hexes?

**Stale-knowledge corrections.**
- **System colour RGB values memorised from pre-2025 docs are wrong** — Apple "updated system color values" June 2025 and removed text RGB tables from the page entirely.
- Liquid Glass colour section is entirely new (no pre-2025 equivalent): the "tint one prominent control's background" doctrine replaces older "tint bar buttons with tintColor" thinking.
- The rule that single-appearance apps must still ship light+dark colour variants is new (Liquid Glass adaptivity).
- iOS no longer documents separate dark-mode "elevated" colour discussions here (moved to Dark Mode page); the unified cross-platform system colour table (incl. mint/teal/cyan/brown on macOS) post-dates older per-platform tables.

---

## 4. Dark Mode

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/dark-mode
**Status:** last alert 2024-08-06; content stable through Liquid Glass era. Platforms: iOS, iPadOS, macOS, tvOS (NOT visionOS/watchOS).

**Purpose.** Systemwide dark appearance: behavioural expectations, colour adaptation, contrast minima, icon/text handling.

**Normative rules.**
- **Don't offer an app-specific appearance setting** — respect the system setting (incl. Auto, which can flip appearance while the app runs).
- App must look good in **both** modes; permanently-dark UI is acceptable only for immersive media experiences (e.g. Stocks-style).
- Test with **Increase Contrast** and **Reduce Transparency** on, separately and together.
- Dark palette = dimmer backgrounds + brighter foregrounds; **dark colours are not simple inversions** of light ones.
- Use **semantic/adaptive colours**; custom colours go in asset-catalog Color Sets with explicit light + dark variants; no hard-coded values.
- **Contrast minima: ≥ 4.5:1 always; aim for 7:1 for custom foreground/background pairs, especially small text.** (The only hard numbers on the page — reuse them everywhere.)
- **Soften white backgrounds** in content images (slightly darken to prevent "glow" in dark surroundings).
- Use SF Symbols (auto-adapt) wherever possible; design separate light/dark interface-icon assets when an asset only works on one background (e.g. moon icon needing an outline only in light mode); combine via asset catalog single named image.
- Use system label colours (primary–quaternary) and system text views (they handle vibrancy automatically).

**iOS vs macOS.**
- **iOS/iPadOS:** Dark Mode defines **base** and **elevated** background-colour sets; elevated (brighter) is applied automatically to foreground layers — popovers, modal sheets, multitasking window separation. **Prefer system background colours** or you lose this depth signalling.
- **macOS:** **desktop tinting** — with the graphite accent, window backgrounds pick up colour from the desktop picture. Guidance: include slight transparency in custom component backgrounds *only in neutral (uncoloured) states* so they harmonise with tinting; never on coloured states (colour would fluctuate with the wallpaper).

**Reviewer checks.**
- In-app light/dark toggle present? Flag.
- Any screen with text contrast below 4.5:1 in either mode? (Automatable.) Custom small text below 7:1? Warn.
- Custom dark theme built by naive inversion or by reusing light colours? Check that backgrounds dim and foregrounds brighten.
- iOS dark sheets/popovers using the same background colour as the base layer (missing elevated step)? Flag.
- Full-white content images glowing against dark backgrounds?
- Custom icons illegible on one of the two backgrounds with a single asset?

**Stale-knowledge corrections.** Guidance substantively unchanged since 2019–2024; the only trap is the interplay with Liquid Glass: bars/controls now adapt via the glass material itself (see Materials/Color), so old advice to give bars solid dark `barTintColor` backgrounds is obsolete. Dark Mode remains unsupported on watchOS/visionOS — don't invent it there.

---

## 5. Icons (interface icons / glyphs)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/icons
**Status:** updated 2025-06-09 ("Added a table of SF Symbols that represent common actions").

**Purpose.** Design of in-interface icons (glyphs) as distinct from app icons; the canonical action→SF Symbol mapping; macOS document icons.

**Normative rules.**
- Interface icons use streamlined shapes, "black and clear colors to define their shapes"; the system colours the black areas. Prefer SF Symbols; custom icons must match symbols in size, detail level, stroke weight, perspective.
- **Match icon weight to adjacent text weight** unless deliberately emphasising one.
- **Optical alignment:** bake optical-centring adjustments into the asset as padding so geometric centring of the asset yields optical centring of the glyph (esp. asymmetric glyphs like download arrows).
- **Don't supply selected-state variants** for icons in standard components (toolbars, tab bars, buttons) — the system handles selected appearance.
- Inclusive imagery: gender-neutral figures; cross-culture legibility; localise any text characters; provide flipped variants for RTL when depicting text blocks.
- **Vector format (PDF/SVG) for custom interface icons** — system scales for resolution; PNG would need multiple sizes. Alternative: build a custom SF Symbol.
- **Provide alternative text labels (accessibility descriptions) for all custom icons.**
- **No Apple hardware replicas** except assets from Apple Design Resources or product SF Symbols.
- **Standard action→symbol table (memorise; June 2025):** Cut `scissors`; Copy `document.on.document`; Paste `document.on.clipboard`; Done/Save `checkmark`; Cancel/Close `xmark`; Delete `trash`; Undo `arrow.uturn.backward`; Redo `arrow.uturn.forward`; Compose `square.and.pencil`; Duplicate `plus.square.on.square`; Rename `pencil`; Move to/Folder `folder`; Attach `paperclip`; Add `plus`; More `ellipsis`; Select `checkmark.circle`; Deselect `xmark`; Superscript/Subscript `textformat.superscript`/`.subscript`; Bold/Italic/Underline `bold`/`italic`/`underline`; alignment `text.alignleft`/`text.aligncenter`/`text.justify`/`text.alignright`; Search `magnifyingglass`; Find (+Replace/Next/Previous) `text.page.badge.magnifyingglass`; Filter `line.3.horizontal.decrease`; Share/Export `square.and.arrow.up`; Print `printer`; Account/User/Profile `person.crop.circle`; Like/Dislike `hand.thumbsup`/`hand.thumbsdown`; Bring to Front `square.3.layers.3d.top.filled`; Send to Back `square.3.layers.3d.bottom.filled`; Bring Forward `square.2.layers.3d.top.filled`; Send Backward `square.2.layers.3d.bottom.filled`; Alarm `alarm`; Archive `archivebox`; Calendar `calendar`.

**iOS vs macOS.**
- macOS-only: **document icons** (folded top-right corner). If you don't supply one, macOS composites your app icon + extension automatically. Custom doc icon = background fill + optional centre image + text term. Specs: background fill sizes **512/256/128/32/16 px @1x with @2x doubles**; centre image = **half the canvas** (e.g. 16×16 px for a 32×32 icon), sizes 256/128/32/16 @1x +@2x; keep image within ~**10% margin** (occupies ~80% of canvas, e.g. 205×205 in 256); reduce detail at small sizes; nothing important in top-right corner (folded corner mask); extension text auto-uppercased, may substitute a short term (e.g. "scene" not "scn").
- iOS: no additional considerations.

**Reviewer checks.**
- Custom glyph drawn for an action that has a standard symbol (e.g. a custom gear, share arrow, trash can)? Flag and name the SF Symbol.
- Wrong symbol semantics (e.g. `square.and.arrow.up` used for upload-to-server, `trash` for remove-from-list-but-recoverable, magnifying glass for zoom)?
- Mixed stroke weights / detail levels across an icon set; icon weight mismatched with adjacent label weight.
- Raster (PNG) custom glyphs; missing accessibility labels; baked-in selected states.
- Asymmetric glyphs visually off-centre in their containers.

**Stale-knowledge corrections.**
- Symbol **renames**: Copy is `document.on.document` and Paste `document.on.clipboard` (the pre-SF-Symbols-6 names `doc.on.doc` / `doc.on.clipboard` are deprecated aliases); Find is `text.page.badge.magnifyingglass` (not `doc.text.magnifyingglass`). Models trained pre-2024/2025 will emit old names.
- The standard-actions table itself is new (June 2025) — treat it as the canonical vocabulary rather than ad-hoc choices.
- WWDC26 (2026-06-08) added menu-item icon guidance on the Menus page — menu items now commonly carry icons on macOS too; coordinate with the components bucket.

---

## 6. Images

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/images
**Status:** alert 2025-12-16 (visionOS spatial-photo additions only; iOS/macOS content stable).

**Purpose.** Asset production mechanics: points vs pixels, scale factors, file formats, colour profiles.

**Normative rules.**
- A **point** is the abstract unit; **scale factor** maps points→pixels: @1x, @2x, @3x.
- **Required scale factors: iOS @2x and @3x; iPadOS @2x; macOS @1x and @2x.**
- Name assets with `@1x/@2x/@3x` suffixes in the asset catalog.
- **Design at the lowest resolution, scale up**; place vector control points at whole values at 1x so they stay grid-aligned at 2x/3x.
- **Format table:** bitmap/raster → **de-interlaced PNG**; PNG not needing 24-bit colour → **8-bit colour palette**; photos → **JPEG (optimised) or HEIC**; flat icons/interface icons/flat artwork needing scaling → **PDF or SVG**.
- **Include a colour profile with every image** (see Color > Color management).
- **Test on real devices** — design-time appearance can pixelate/stretch on hardware.

**iOS vs macOS.** Only scale factors: iOS @2x+@3x, macOS @1x+@2x. No other platform considerations for either.

**Reviewer checks.**
- iOS deliverables missing @3x; macOS missing @1x.
- Raster used for flat glyphs/artwork (should be PDF/SVG).
- Interlaced PNG; JPEG used for flat UI artwork; missing colour profiles.
- Vector sources with fractional control points causing soft 1x rendering.

**Stale-knowledge corrections.** Stable page; one nuance — HEIC is now an accepted photo format alongside JPEG (older guidance was JPEG-only). No Liquid Glass impact.

---

## 7. Layout

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/layout
**Status:** specs updated 2025-09-09 (iPhone 17 family); **Liquid Glass layout guidance added 2025-06-09**.

**Purpose.** Structuring screens/windows: content extension, visual hierarchy of content vs controls, adaptability (size classes, Dynamic Type, orientation), guides and safe areas, device dimension specs.

**Normative rules.**
- Group related items via negative space, background shapes, colours, materials, separators; keep content and controls clearly distinct.
- **Extend content to fill the screen/window.** Backgrounds and full-screen artwork must reach display edges; scrollable layouts must continue to the bottom and sides of the screen. **Controls and navigation (sidebars, tab bars) float on top of content, not on the same plane.** When content doesn't span the window, use a **background extension view** (`backgroundExtensionEffect()` / `UIBackgroundExtensionView`) to fake content behind the sidebar/inspector control layer.
- **Differentiate controls from content with Liquid Glass; use a scroll edge effect** — not an opaque bar background — as the transition between content and the control area.
- Place important items top + leading (reading order; respect RTL).
- Align elements; use indentation+alignment to express hierarchy; use progressive disclosure for hidden content.
- Give controls breathing room and logical grouping (crowded controls are hard to distinguish).
- **Adaptability:** handle screen sizes/resolutions/colour spaces, orientations, **Dynamic Island and camera controls**, external displays, Display Zoom, iPad resizable windows, Dynamic Type changes, locale (RTL, text length). Use SwiftUI/Auto Layout; respect **safe areas, layout guides, margins**.
- Test largest + smallest layouts first; don't change artwork aspect ratios when adapting — scale instead.
- **iOS-specific:** support both orientations where possible (landscape-only must work both rotations); games prefer full-bleed; **avoid full-width buttons** — respect system margins, inset from screen edges; any full-width button must harmonise with hardware corner curvature and safe areas. Hide the status bar only for immersive experiences.
- **iPadOS (adaptive clarification):** windows freely resizable to a minimum size; design full-screen first and **defer switching to compact layouts as long as possible**; hide tertiary columns (inspectors) first as width shrinks; test at system tiling sizes (halves, thirds, quadrants); consider the **convertible tab bar** (`sidebarAdaptable`) that switches between tab bar and sidebar.
- **macOS-specific:** **avoid controls/critical info at the bottom of a window** (users push bottoms offscreen); **avoid content in the camera-housing area** at the top of the screen (`NSPrefersDisplaySafeAreaCompatibilityMode`).
- **Size classes (iOS/iPadOS):** regular vs compact per dimension. iPads: regular×regular both orientations. iPhones: compact width × regular height portrait; landscape = regular width × compact height on Max/Plus/Air models, compact×compact on regular-size iPhones.
- **Key device dimensions (pt, portrait):** iPhone 17 Pro Max 440×956 @3x; iPhone 17 Pro / iPhone 17 402×874 @3x; **iPhone Air 420×912 @3x**; iPhone 16 393×852 @3x; iPhone 16e 390×844 @3x; iPhone SE (4.7") 375×667 @2x; iPad Pro 13" 1032×1376 @2x; iPad Pro 11" (5th/6th gen) 834×1210 @2x; iPad Air 11" 820×1180 @2x; iPad mini 8.3" 744×1133 @2x. (Full table on page; UIKit scale ≠ native scale on some devices.)
- Layout guides: predefined guides give standard margins and a **readability-constrained text width**; safe areas avoid Dynamic Island, bars, camera housings.

**iOS vs macOS.**
- iOS: safe areas around Dynamic Island/sensor housing, status bar, orientation, size classes, full-width-button prohibition.
- macOS: window-bottom rule, camera-housing rule, free window resizing as the default condition (no size classes).
- Shared: edge-to-edge content under floating glass controls; scroll edge effect; background extension view.

**Reviewer checks.**
- Content area stops above a tab bar / beside a sidebar with hard edges (not extending beneath the glass layer)? Flag — content must scroll under floating controls.
- Opaque rectangular bar backgrounds instead of scroll edge effects?
- iOS: buttons spanning full screen width; controls inside Dynamic Island/status-bar/home-indicator safe areas; fixed 375×667-era artboards for current devices (should be 402×874 default iPhone now).
- macOS: primary actions or status info pinned to the window's bottom edge.
- Text blocks wider than the readable-width guide; misaligned sibling elements; missing hierarchy in spacing.
- Prototype breaks at compact width / largest Dynamic Type / landscape?

**Stale-knowledge corrections.**
- **The biggest stale assumption in this bucket:** pre-2025 models lay out iOS screens as content sandwiched between an opaque navigation bar and an opaque tab bar. Current doctrine: bars are **floating Liquid Glass elements; content is edge-to-edge underneath; scroll edge effect replaces bar backgrounds**; background extension views fill the area behind sidebars/inspectors.
- "Avoid full-width buttons" is post-2025 iOS guidance (older designs commonly used edge-to-edge pill CTAs).
- Navigation-bar layout guidance was folded into the Toolbars component page (2025-06-09); this Foundations page no longer carries bar-height/margin tables — don't cite old 44pt nav-bar/49pt tab-bar numbers as HIG-sourced.
- Newest devices (iPhone 17 family, iPhone Air 420×912) post-date most model knowledge; default flagship canvas is 402×874 pt, not 393×852 or 390×844.
- Note: this page no longer publishes a minimum tap-target size; the canonical 44×44 pt minimum hit-target rule lives in Accessibility/Buttons pages (other buckets) — keep using it, but cite the right page.

---

## 8. Materials (incl. Liquid Glass)

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/materials
**Status:** updated 2025-09-09 ("Updated guidance for Liquid Glass"); first Liquid Glass guidance 2025-06-09.

**Purpose.** The two material systems — Liquid Glass (functional layer) and standard materials (content layer) — and their legibility/vibrancy rules.

**Normative rules.**
- Two material types: **Liquid Glass** ("dynamic material that unifies the design language across Apple platforms… presents controls and navigation without obscuring underlying content") and **standard materials** ("help with visual differentiation within the content layer").
- Liquid Glass forms a **distinct functional layer** for controls/navigation (tab bars, sidebars, toolbars) **floating above the content layer**.
- **Don't use Liquid Glass in the content layer.** Use standard materials there (e.g. app backgrounds). Exception: content-layer controls with transient interactive elements (Sliders, Toggles) take on glass **while a person actively manipulates them**.
- **Use Liquid Glass effects sparingly** on custom controls; system components adopt it automatically; overuse distracts from content. "Limit these effects to the most important functional elements in your app."
- **Variants:** *regular* — blurs + adjusts luminosity, used by most system components, for components with significant text (alerts, sidebars, popovers) or legibility-risk backgrounds; scroll edge effects add further legibility. *clear* — highly translucent, **only for components over visually rich media** (photos/video). Dimming-layer rule for clear: bright underlying content → add **dark dimming layer, 35% opacity**; dark content or AVKit standard playback controls (own dimming) → none.
- Variant appearance responds to user settings: preferred Liquid Glass look, Reduce Transparency, Increase Contrast.
- **Standard materials:** choose by **semantic meaning, not imparted colour**; ensure legibility with **system vibrant colours on top of materials** (never plain opaque colours); thicker material = more contrast for fine elements, thinner = more context visibility.
- **iOS/iPadOS standard materials:** four — **ultraThin, thin, regular (default), thick** — content-layer use. Vibrancy levels: labels `label` (default) / `secondaryLabel` / `tertiaryLabel` / `quaternaryLabel` (**avoid quaternary on thin/ultraThin** — too low contrast); fills `fill` / `secondaryFill` / `tertiaryFill` (all materials); one `separator` vibrancy (all materials).
- **macOS standard materials:** NSVisualEffectView materials with **designated semantic purposes** (sidebar, menu, header, sheet, etc. — see NSVisualEffectView.Material), all with vibrant versions; choose **blending mode**: *behind window* vs *within window* (NSVisualEffectView.BlendingMode); decide deliberately where vibrancy applies in custom views and test across contexts.

**iOS vs macOS.**
- iOS: fixed four-thickness material set + UIVibrancyEffectStyle levels.
- macOS: purpose-named material set + two blending modes; vibrancy is configurable per view. The Liquid Glass layer doctrine is identical on both.

**Reviewer checks.**
- Glass effect applied to content cards, list rows, or backgrounds? Flag — content layer must use standard materials.
- More than a handful of custom glass elements on one screen?
- Clear variant over flat/bright non-media backgrounds, or missing its 35% dimming layer over bright media?
- Text/controls over any material using non-vibrant plain colours (esp. plain gray text)?
- Quaternary-level text on thin/ultraThin materials?
- Solid opaque toolbars/tab bars/sidebars in new designs (should be glass with scroll edge effect)?
- Frosted-glass-styled custom control trying to imitate but not match system glass (e.g. CSS `backdrop-filter: blur()` with white fill but no adaptive light/dark response in HTML prototypes)?

**Stale-knowledge corrections.**
- Pre-2025 models know only the four-blur-material system ("frosted glass", UIBlurEffect) and chrome translucency. **Liquid Glass is a different thing**: a refractive, specular, adaptive material reserved for the floating control layer, with regular/clear variants — not just stronger blur.
- Old mental model: materials are a styling choice anywhere in the UI. New model: **layer discipline** — glass = functional layer only; standard materials = content layer only.
- tvOS-style focus-driven glass and visionOS "glass" windows are different systems; don't conflate.

---

## 9. Motion

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/motion
**Status:** updated 2025-09-09 ("Added guidance for Liquid Glass").

**Purpose.** Principles for custom animation: purpose, optionality, feedback realism, brevity; relies on system components for most motion.

**Normative rules.**
- System components include motion automatically and adapt it to accessibility settings and input device. **Liquid Glass motion responds to direct touch with greater emphasis; trackpad interaction produces a more subdued effect** — input-aware motion is now systemic.
- **Add motion purposefully** — never gratuitous; excessive animation can cause disconnection or physical discomfort.
- **Make motion optional** — never the sole channel for important information; supplement with haptics and audio. (Reduce Motion accessibility implications live on the Accessibility page.)
- Feedback motion must **follow people's gestures and expectations** (a view revealed by sliding down shouldn't dismiss sideways).
- **Brief and precise** feedback animations beat prominent ones.
- **Avoid adding motion to frequently occurring UI interactions** in apps — the system already animates standard elements; don't tax repeated interactions with extra motion.
- **Let people cancel/skip motion**; never gate interaction on an animation completing, especially repeated ones.
- Consider **animated symbols** (SF Symbols 5+) where meaningful.
- Games: maintain consistent **30–60 fps**; sensible default graphics settings per platform; allow performance/battery customisation (e.g. power modes on external power).

**iOS vs macOS.** "No additional considerations for iOS, iPadOS, macOS, or tvOS." The only implicit divergence is input-driven: touch (emphatic glass response) vs pointer (subdued) — relevant when prototyping the same component for both platforms.

**Reviewer checks.**
- Custom animation on high-frequency interactions (every keystroke, every cell appearance)?
- Unskippable intro/transition animations; UI blocked while animating?
- Information conveyed *only* via motion?
- Prototype lacks a reduced-motion variant (esp. HTML: missing `prefers-reduced-motion` handling)?
- Gesture-driven views whose dismiss direction contradicts their reveal direction?

**Stale-knowledge corrections.**
- The page contains **no duration/easing numbers** — any model emitting "Apple standard 0.3 s ease-in-out" is inventing; HIG motion guidance is qualitative, plus system-supplied behaviour.
- New since 2025: input-device-aware motion (touch vs trackpad emphasis) as a property of Liquid Glass; symbol animations as the sanctioned micro-animation toolkit.

---

## 10. SF Symbols

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/sf-symbols
**Status:** updated 2025-07-28 (SF Symbols 7: Draw animations, gradient rendering). **SF Symbols 8 beta + Icon Composer 2 beta were released at WWDC26 (2026-06-08)** — expect additions not yet reflected in this page.

**Purpose.** Using and customising Apple's symbol library: rendering modes, gradients, variable colour, weights/scales, variants, animations, custom symbols.

**Normative rules.**
- Symbols integrate with San Francisco, **aligning with text in all weights and sizes**; usable wherever interface icons appear. **Symbol availability is OS-version-gated** (a given year's symbols don't exist on earlier OSes).
- **License: prohibited to use SF Symbols (or confusingly similar images) in app icons, logos, or any trademarked use.** Symbols depicting Apple products/features are copyrighted, displayed as-is only, non-customisable (badged with Info icon in the app).
- **Rendering modes:** Monochrome (one colour, all layers); Hierarchical (one colour, per-layer opacity = depth); Palette (2+ colours, one per layer; 2 colours over 3 layers → secondary+tertiary share); Multicolor (intrinsic colours, e.g. green `leaf`, red `trash.slash`). Use system colours so symbols adapt to vibrancy/Dark Mode/accessibility. **Verify the rendering mode is legible per context** — automatic mode is a starting point.
- **Gradients (SF Symbols 7+):** smooth linear gradient from a single source colour; works in all rendering modes, system/custom colours, custom symbols; best at larger sizes.
- **Variable colour:** represents a changing quantity (capacity, strength, progress) by colouring layers at thresholds 0–100%; layers can opt out; **use for change over time, NOT depth** (depth = Hierarchical mode).
- **Weights/scales: nine weights (ultralight→black) matching San Francisco weights** for precise text matching; **three scales — small, medium (default), large — defined relative to the cap height of SF**; scale adjusts emphasis without breaking weight match (`imageScale(_:)`, `UIImage.SymbolScale`, `NSImage.SymbolConfiguration`).
- **Variants:** outline (default, text-like), fill (solid emphasis), slash (unavailable), enclosed (circle/square/rect — improves small-size legibility); language/script variants (Arabic, Hebrew, Devanagari, CJK…) auto-adapt with device language. **Outline works in toolbars/lists alongside text; fill suits iOS tab bars and swipe actions.** The containing view often picks the variant automatically (iOS tab bar prefers fill; toolbar takes outline) — don't fight it.
- **Animations (all symbols, all modes/weights/scales, custom included):** Appear, Disappear, Bounce (one-shot, action feedback), Scale (persistent size change, selection/feedback), Pulse (opacity-only, ongoing activity; annotated layers pulse by default), Variable Color (cumulative or iterative; open-loop vs closed-loop layer arrangements; closed loop = seamless repeat), Replace (down-up / up-up / off-up), **Magic Replace — the default replace animation** (smart transition between related shapes — slashes draw on/off, badges appear; falls back to down-up between unrelated symbols), Wiggle (directional attention), Breathe (opacity+size, living/ongoing), Rotate (whole-symbol or By Layer, e.g. fan blades), **Draw On / Draw Off (SF Symbols 7+; draws along guide-point paths; all-layers / staggered / per-layer; progress and directionality use cases)**.
- Animation discipline: apply judiciously; every animation must serve a clear communicative purpose; consider tone/brand alignment.
- **Custom symbols:** export a similar symbol's template, edit in a vector tool; match system symbols in detail, optical weight, alignment, perspective; **annotate** layers with colours/hierarchy levels; **negative side margins** for badge-widened symbols (margin naming pattern e.g. `left-margin-Regular-M`); optimise layers for animation (whole shapes + erase layers rather than cutouts; Z-order controls variable-colour order); test every animation preset; **use the component library for variants (enclosures, badges) instead of hand-drawing them**; provide accessibility labels; no Apple product replicas.

**iOS vs macOS.** "No additional considerations" for any platform. Divergence appears only via container behaviour (iOS tab bar → fill; toolbars → outline) and API families.

**Reviewer checks.**
- Symbol-lookalike artwork in an app icon or logo? Hard violation (licence).
- Symbol weight mismatched with adjacent text weight; mixed scales within one bar.
- Fill variants in macOS toolbars / outline in iOS tab bars (fighting container preference).
- Variable colour used decoratively for depth; multicolour symbols recoloured against intrinsic meaning.
- Symbols from a newer SF Symbols release targeted at older OS versions.
- Custom glyphs duplicating existing symbols; custom symbols with hand-drawn circles/badges instead of component-library variants.

**Stale-knowledge corrections.**
- Models trained ≤2024 know SF Symbols 5/6: they will miss **gradients and Draw On/Off (SF7, July 2025)** and won't know **Magic Replace is now the default** replace behaviour.
- **SF Symbols 8 beta is out as of this week (WWDC26)** — verify symbol names/features against the live app before asserting.
- Symbol renames continue across releases (doc→document family); never trust memorised names without checking — the Icons page table is the current canonical action vocabulary.

---

## 11. Typography

**Canonical URL:** https://developer.apple.com/design/human-interface-guidelines/typography
**Status:** updated 2025-12-16 ("Added emphasized weights to the Dynamic Type style specifications"); Dynamic Type guidance expanded 2025-03-07 (moved here from Accessibility).

**Purpose.** Legibility minima, system fonts (SF/NY), text styles, Dynamic Type, custom fonts, tracking specs for mockups.

**Normative rules.**
- **Default / minimum text sizes: iOS & iPadOS 17 pt / 11 pt; macOS 13 pt / 10 pt.** (tvOS 29/23, visionOS 17/12, watchOS 16/12 for reference.) Thin custom fonts need larger sizes.
- **Avoid light weights generally: prefer Regular, Medium, Semibold, Bold; avoid Ultralight, Thin, Light.**
- Hierarchy via weight/size/colour; **minimise the number of typefaces** (mixing obscures hierarchy); maintain relative hierarchy at all text sizes; when text size increases, scale the content people care about, not necessarily everything (tab titles, hit-damage numbers can stay).
- **System fonts:** San Francisco family — SF Pro, SF Compact, SF Arabic/Armenian/Georgian/Hebrew, SF Mono; rounded variants of most. New York (NY) = companion serif. Both ship as **variable fonts** with **dynamic optical sizes** (continuous interpolation merging old discrete Text/Display cuts — no discrete optical sizes needed unless the design tool can't handle variable fonts). Weights Ultralight→Black; SF also has Condensed/Expanded widths. **Don't embed system fonts; access via API** (`Font.Design.default`, `.serif` → NY).
- **Text styles** (system-defined font+size+leading sets forming the hierarchy): Large Title, Title 1, Title 2, Title 3, Headline, Body, Callout, Subhead(line), Footnote, Caption 1, Caption 2. Use built-in styles for Dynamic Type support; modify via **symbolic traits** (bold trait; loose/tight leading — avoid tight leading for 3+ lines).
- **iOS/iPadOS Dynamic Type, Large (default) size — the reference table (pt size/leading, weight, emphasized weight):**
  - Large Title 34/41 Regular (emph Bold); Title 1 28/34 Regular (Bold); Title 2 22/28 Regular (Bold); Title 3 20/25 Regular (Semibold); Headline 17/22 **Semibold** (Semibold); Body 17/22 Regular (Semibold); Callout 16/21 Regular (Semibold); Subhead 15/20 Regular (Semibold); Footnote 13/18 Regular (Semibold); Caption 1 12/16 Regular (Semibold); Caption 2 11/13 Regular (Semibold).
  - Sizes defined per Dynamic Type step xSmall→xxxLarge plus accessibility sizes AX1–AX5 (Body: 14, 15, 16, **17**, 19, 21, 23, then AX 28, 33, 40, 47, 53). Point sizes assume 144 ppi @2x / 216 ppi @3x mockups.
- **macOS built-in text styles (fixed; no Dynamic Type):**
  - Large Title 26/32 Regular (Bold); Title 1 22/26 Regular (Bold); Title 2 17/22 Regular (Bold); Title 3 15/20 Regular (Semibold); Headline 13/16 **Bold** (Heavy); Body 13/16 Regular (Semibold); Callout 12/15 Regular (Semibold); Subheadline 11/14 Regular (Semibold); Footnote 10/13 Regular (Semibold); Caption 1 10/13 Regular (Medium); Caption 2 10/13 **Medium** (Semibold).
- **macOS dynamic system font variants** for matching control text: controlContentFont, labelFont, menuFont, menuBarFont, messageFont, paletteFont, titleBarFont, toolTipsFont, userFont (document text), userFixedPitchFont, boldSystemFont, systemFont.
- **Dynamic Type (iOS, iPadOS — NOT macOS):** layout must adapt to all sizes incl. **Larger Accessibility Text Sizes**; meaningful interface icons grow with text (SF Symbols do automatically); **minimise truncation** — show as much text at largest accessibility size as at largest standard size; allow multi-line labels (`numberOfLines`); at AX sizes switch inline layouts to **stacked layouts** and reduce column counts (`isAccessibilityCategory`); keep hierarchy positions stable.
- **Custom fonts:** must be legible at the platform minima; must respond to Dynamic Type and Bold Text accessibility settings.
- **Tracking in mockups:** running apps auto-track per point size; mockups may need manual tracking from the supplied tables. SF Pro (iOS/macOS identical table): e.g. +6/1000 em at 11 pt, 0 at 12 pt, −26 at 17 pt (max tightening), −12 at 22 pt, +3 at 24 pt, ~+14 around 28–30 pt, decaying to 0 by 80 pt+. NY runs negative from 16 pt (−4) deepening to −16 to −18 at display sizes. Full tables on page; SF Pro Rounded tracks looser (+22 at 17 pt).

**iOS vs macOS.**
- **Dynamic Type exists on iOS/iPadOS; macOS does not support Dynamic Type** — macOS text styles are fixed point sizes.
- Default body: iOS 17 pt vs macOS 13 pt; minimum 11 pt vs 10 pt.
- macOS Headline is **Bold 13** (same size as Body, weight-differentiated); iOS Headline is **Semibold 17**. macOS Caption 2 is Medium by default — weight, not size, separates the bottom of the macOS hierarchy.
- macOS has the control-font variant API family (menu/menuBar/titleBar/toolTips fonts); iOS has none.
- System font is SF Pro on both; NY available natively on iOS, only via Mac Catalyst on macOS.

**Reviewer checks.**
- Any text below 11 pt (iOS) / 10 pt (macOS)? Body text not ~17 pt (iOS) / 13 pt (macOS) without justification?
- Ultralight/Thin/Light weights anywhere, esp. small sizes?
- Type ramp deviating from the text-style tables without rationale (e.g. 15 pt "body" on iOS)?
- HTML/Figma prototypes: SF Pro substituted by another sans without flagging? Tracking left at 0 where the table requires adjustment (visible at 17 pt body, display sizes)?
- iOS designs lacking a larger-text variant (does the layout stack at AX sizes? labels multi-line?); truncation at larger sizes; icons that don't scale with text.
- Mixed typefaces (>2 families); leading tightened on 3+ line text.
- macOS mockups using iOS sizes (17 pt body in a Mac window is a telltale cross-platform port).

**Stale-knowledge corrections.**
- **Emphasized weight column (Dec 2025) is new** — emphasis is style-specific (Bold for titles, Semibold for body/captions on iOS; Heavy for macOS Headline), not a blanket "make it bold".
- "SF Pro Text vs SF Pro Display with a 20 pt switch" is obsolete framing: variable fonts with **dynamic optical sizes** interpolate continuously; only fall back to discrete cuts in tools lacking variable-font support.
- Dynamic Type guidance moved from Accessibility into Typography (March 2025); the size tables here (incl. AX1–AX5) are the canonical ones.
- The tables themselves are long-stable (Large/default values match pre-2025 docs) — this is one area where memorised numbers are mostly still right; the additions are emphasized weights and the table reorganisation.

---

## Bucket synthesis (for skill architecture)

- **Spec-densest pages:** Typography (full type ramp + tracking), Layout (device dimensions, size classes), App icons (deliverable spec), Images (scale factors/formats), Icons (action→symbol table, doc-icon sizes). These translate directly into checklists and lookup tables.
- **Judgment-heavy pages:** Branding, Motion, Materials usage, Liquid Glass colour discipline — best encoded as decision rules + reviewer heuristics, not numbers.
- **The Liquid Glass layer model is the single most important correction** to ship: content layer vs floating glass functional layer; edge-to-edge content; scroll edge effects; sparing tint on at most one prominent control; no glass in content.
- **Volatile facts** (re-verify against live JSON when used): SF Symbols version features (v8 beta just dropped), system colour values (image-only now), newest device dimensions, app-icon guidance (touched again 2026-06-08).
