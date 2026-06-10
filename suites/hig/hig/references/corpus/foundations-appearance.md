<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: color, dark-mode, materials, motion -->
# Foundations — appearance (colour · Dark Mode · materials · motion)

## color
<!-- src: color · changed: 2025-12-16 · platforms: iOS, iPadOS, macOS · speed: full -->

- Never use one colour for two meanings (e.g. brand colour as both interactive button and decorative text).
- Every colour must work in light, dark and increased-contrast contexts. Custom colours need light + dark variants **plus an increased-contrast variant of each**. **Even single-appearance apps must supply light and dark colours "to support Liquid Glass adaptivity."**
- Never rely on colour alone for state, interactivity or information — pair with a text label or glyph shape. Mind cultural colour connotations.
- **Don't hard-code system colour values** — documented values are reference-only and "may fluctuate from release to release"; the HIG publishes swatches as images, not RGB text. Use APIs (`Color`, `UIColor`, `NSColor`). Values changed 2025-06-09 — memorised RGBs (e.g. #007AFF as systemBlue) are wrong.
- Dynamic system colours are semantic — don't redefine them (no `separator` as text colour, no `secondaryLabel` as background).

Liquid Glass colour (layer model: doctrine.md):
- Glass has no inherent colour; tinting it produces a "stained glass" effect for emphasis only. Apply colour sparingly — status indicators or the single primary action. "Refrain from adding color to the background of multiple controls."
- Emphasise a primary action by tinting its **background**, not its symbol/text (system pattern: the Done button's background takes the app accent).
- Toolbar/tab-bar symbols default to monochromatic, auto-darkening/lightening against underlying content. Colourful app backgrounds → monochromatic bars or one high-differentiation accent; monochromatic content → a brand accent works well.
- Check the resting state (top of scroll) for colour collisions between content layer and controls.

Colour management: profile every image; sRGB is the safe baseline; Display P3 at 16 bpc exported as PNG for wide gamut; per-gamut asset variants when P3-only distinctions matter (asset catalog supports this). Test under different lighting, True Tone, and macOS colour profiles (P3 vs sRGB).

iOS/iPadOS semantic palette: two background sets — system (`systemBackground` + secondary/tertiary) and grouped (`systemGroupedBackground` + secondary/tertiary; use grouped for grouped table views). Hierarchy: primary = overall view, secondary = grouping within view, tertiary = grouping within secondary. Foreground: `label`, `secondaryLabel`, `tertiaryLabel`, `quaternaryLabel`, `placeholderText`, `separator` (translucent), `opaqueSeparator`, `link`; six grays `systemGray`…`systemGray6` (SwiftUI exposes only `gray` = systemGray).

macOS semantic palette: ~35 AppKit names — `labelColor` (+secondary/tertiary/quaternary), `controlColor`, `controlAccentColor`, `controlBackgroundColor`, `selectedContentBackgroundColor`, `separatorColor`, `windowBackgroundColor`, `underPageBackgroundColor`, `textBackgroundColor`, `findHighlightColor`, `keyboardFocusIndicatorColor`, unemphasized-selection variants (full table on page). Accent: the app accent applies only while System Settings General > Accent color = multicolor; otherwise the user's colour replaces it everywhere except fixed-colour sidebar icons.

System colours (both platforms, unified table): red, orange, yellow, green, mint, teal, cyan, blue, indigo, purple, pink, brown — each with default + increased-contrast light/dark variants; values published as images only.

iOS vs macOS: entirely different semantic vocabularies — use the right namespace per platform. macOS adds the accent override and desktop-tinting interplay; the iOS gray scale has no macOS equivalent.

Reviewer checks:
- Hard-coded hexes standing in for system colours; one hue doing interactive + decorative duty; colour-only state signalling.
- Custom palette missing dark or increased-contrast variants (required even for single-appearance apps).
- More than one tinted/prominent glass control per bar or view; bar symbols individually multicoloured over rich backgrounds.
- Semantic misuse: separator-as-text, label-as-fill, grouped backgrounds on a non-grouped screen.
- HTML prototypes: tokens structured semantically (label/secondaryLabel/background hierarchy), not raw hexes.

Stale-prior corrections:
- Was: copy published RGB tables (#007AFF etc.) → Now: system colour values changed and the text tables were removed; API-only (since 2025-06-09).
- Was: tint bar buttons via tintColor → Now: glass doctrine — at most one tinted prominent control per context, tint the background not the glyph (since 2025-06-09; reaffirmed 2025-12-16).
- Was: single-appearance apps may skip dark colours → Now: light + dark variants required for Liquid Glass adaptivity (since 2025-12-16 guidance).

## dark-mode
<!-- src: dark-mode · changed: 2024-08-06 · platforms: iOS, iPadOS, macOS, tvOS · speed: full -->

Stable page; kept full because it carries the HIG's only hard contrast numbers.
- **Contrast minima: ≥4.5:1 always; aim for 7:1 for custom foreground/background pairs, especially small text.** (Authoritative copy — derived files reference this section.)
- Don't offer an app-specific appearance setting — respect the system setting, including Auto, which can flip appearance while the app runs. Permanently dark UI is acceptable only for immersive media experiences.
- A dark palette is dimmer backgrounds + brighter foregrounds — **not simple inversions** of light colours. Use semantic/adaptive colours; custom colours live in asset-catalog Color Sets with explicit light + dark variants; no hard-coded values.
- Test with Increase Contrast and Reduce Transparency on, separately and together.
- Soften pure-white content images (slight darkening prevents glow against dark surroundings). SF Symbols adapt automatically; a custom icon that only works on one background needs per-appearance assets combined in one named image.
- Use system label colours (primary–quaternary) and system text views — they handle vibrancy automatically.

iOS vs macOS:
- iOS/iPadOS: **base** and **elevated** background-colour sets — elevated (brighter) is applied automatically to foreground layers (popovers, modal sheets, multitasking window separation). Prefer system background colours or you lose this depth signalling.
- macOS: **desktop tinting** — with the graphite accent, window backgrounds pick up colour from the desktop picture. Custom component backgrounds may include slight transparency in neutral (uncoloured) states only, never coloured states.
- Dark Mode does not exist on watchOS or visionOS — don't invent it there.

Reviewer checks: in-app light/dark toggle present; text below 4.5:1 in either mode (automatable); custom small text below 7:1 (warn); palettes built by naive inversion or reused light colours; iOS dark sheets/popovers missing the elevated step; glowing full-white images; single-asset icons illegible in one mode.

Stale-prior correction: Was: give bars solid dark `barTintColor` backgrounds → Now: bars and controls adapt via the Liquid Glass material itself — no solid bar fills (since 2025-06-09; see materials).

## materials
<!-- src: materials · changed: 2025-09-09 · platforms: iOS, iPadOS, macOS · speed: full -->

Liquid Glass is documented inside this page (`materials#Liquid-Glass`) — there is no standalone HIG page. The two-layer model (content layer vs floating Liquid Glass functional layer) lives in doctrine.md; this section carries the material and vibrancy specifics.

Liquid Glass specifics:
- Properties: no inherent colour (takes on colour from content behind it), specular highlights, refraction, translucency; adapts between light/dark appearance from underlying content; symbols/text on it default to monochromatic; appears more opaque in larger elements (sidebars) for legibility.
- **"Don't use Liquid Glass in the content layer."** Standard materials belong there. Exception: content-layer controls (sliders, toggles) take on glass while a person actively manipulates them.
- **"Use Liquid Glass effects sparingly"** on custom controls — system components adopt it automatically; limit custom glass to the most important functional elements.
- Variants: **regular** (default — blurs + adjusts luminosity of background; for text-heavy components such as alerts, sidebars, popovers, and any legibility-risk background; most system components use it) and **clear** (highly translucent; only over visually rich media such as photos/video). Clear over bright content: **add a dark dimming layer at 35% opacity**; skip it when content is sufficiently dark or AVKit standard playback controls supply their own.
- Scroll edge effects blur/reduce opacity of background content under bars to preserve edge legibility (see layout and scroll-views).
- Appearance responds to user settings — the person's preferred Liquid Glass appearance (a system Clear/Tinted setting shipped in 26.1, press-documented), Reduce Transparency, Increase Contrast. Designs must survive all of them.

Standard materials (content layer):
- Choose by semantic meaning, not imparted colour. Ensure legibility with system vibrant colours on top of materials — never plain opaque colours. Thicker material = more contrast for fine elements; thinner = more context visibility.
- iOS/iPadOS: four — ultraThin, thin, regular (default), thick. Vibrancy levels — labels `label` (default) / `secondaryLabel` / `tertiaryLabel` / `quaternaryLabel` (**avoid quaternary on thin/ultraThin** — too low contrast); fills `fill`/`secondaryFill`/`tertiaryFill`; one `separator` level.
- macOS: NSVisualEffectView materials with designated semantic purposes (sidebar, menu, header, sheet…), all with vibrant versions; choose the blending mode — behind-window vs within-window; decide deliberately where vibrancy applies in custom views and test across contexts.

iOS vs macOS: iOS has the fixed four-thickness set + UIVibrancyEffectStyle levels; macOS has the purpose-named set + two blending modes with per-view vibrancy. The glass layer doctrine is identical on both.

Reviewer checks:
- Glass applied to content cards, list rows or backgrounds? Content layer takes standard materials.
- More than a handful of custom glass elements on one screen; clear variant over flat/bright non-media backgrounds; clear over bright media without its 35% dimming layer.
- Plain (non-vibrant) colours over any material, especially plain grey text; quaternary-level text on thin/ultraThin.
- Solid opaque toolbars/tab bars/sidebars in new designs — should be glass with a scroll edge effect.
- HTML imitations: `backdrop-filter: blur()` with a white fill but no adaptive light/dark response doesn't match system glass — flag, or require it declared waived (adapters/html.md).

Stale-prior corrections:
- Was: "frosted glass" = UIBlurEffect; four blur materials usable anywhere → Now: Liquid Glass is a distinct refractive, specular, adaptive material reserved for the floating control layer; standard materials are content-layer-only (since 2025-06-09).
- Was: material choice is a styling decision → Now: layer discipline — glass = functional layer; standard materials = content layer.
- tvOS focus-driven glass and visionOS "glass" windows are different systems — don't conflate.

> **27 beta delta (promote on GA):** press reports a user transparency slider ("ultra clear to fully tinted") replacing the 26.1 Clear/Tinted setting, plus more uniform refraction — press-sourced, not reflected in the HIG as of 2026-06-10. Design consequence if it ships: legibility across the whole opacity range, not two states.

## motion
<!-- src: motion · changed: 2025-09-09 · platforms: iOS, iPadOS, macOS · speed: stub -->

**The page publishes no duration or easing numbers** — any "Apple standard 0.3 s ease-in-out" claim is invented; HIG motion guidance is qualitative, with most motion supplied by system components.
Non-obvious rules: Liquid Glass motion is input-aware — direct touch produces greater emphasis, trackpad a more subdued effect (new since 2025). Make motion optional — never the sole channel for information; supplement with haptics and audio. Brief, precise feedback beats prominent animation; feedback must follow the person's gesture (a view revealed by sliding down shouldn't dismiss sideways). Don't add motion to frequently occurring interactions — the system already animates standard elements. Let people cancel/skip motion; never gate interaction on an animation completing. Animated SF Symbols are the sanctioned micro-animation toolkit (see sf-symbols). Games: consistent 30–60 fps; sensible default graphics settings; allow performance/battery customisation.
Reviewer: unskippable intros; UI blocked while animating; motion-only information; custom animation on every keystroke/cell; HTML prototypes missing `prefers-reduced-motion`; dismiss direction contradicting reveal direction.
iOS vs macOS: none stated on the page; the touch-vs-pointer glass emphasis is the only implicit divergence.
Fetch for detail: motion
