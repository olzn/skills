<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: app-icons, branding, icons, sf-symbols, images -->
# Foundations — identity (app icons · branding · interface icons · SF Symbols · images)

## app-icons
<!-- src: app-icons · changed: 2026-06-08 · platforms: iOS, iPadOS, macOS · speed: full -->

Layered icon pipeline (since 2025-06-09; refined 2026-06-08):
- One background layer + one or more foreground layers, assembled in **Icon Composer** (ships with Xcode). The system renders Liquid Glass attributes — specular highlights, refraction, translucency — adapting per icon size and OS version.
- Deliverable: **one 1024×1024 px square, unmasked** source. The system applies the rounded-corner mask, concentric with system UI and the device bezel. Pre-masked layers degrade specular highlights and produce jagged edges; keep primary content centred to survive masking.
- Layout shape Square; masked result Rounded rectangle; style Layered. The system auto-scales every smaller variant (Settings, notifications, Spotlight).
- Colour spaces: sRGB, Display P3, Gray Gamma 2.2 (grayscale).
- Prefer vector layers (SVG/PDF); outline all text and strokes. PNG (lossless) only for mesh gradients or raster artwork.
- Foreground edges crisp — no soft/feathered edges (breaks system highlights and shadows). Vary foreground-layer opacity for depth (import opaque, adjust inside Icon Composer). Background: solid colour or gradient defined in Icon Composer; an imported background image must be full-bleed and opaque.
- Do NOT bake in effects: no custom speculars, drop shadows between layers, bevels, blurs, glows — the system supplies dynamic ones. Icon Composer layer groups can take group-level glass configuration.
- Design: one core concept, minimal shapes, simple background; prefer filled, overlapping shapes for depth; you needn't fill the canvas. One visually consistent design across all platforms.
- Text only when brand-essential; no calls to action ("Play"), no context terms ("New"); a single-letter mnemonic is acceptable. Icon text doesn't localise or support accessibility.
- Prefer illustrations over photos; never replicate UI components or screenshots; never depict Apple hardware (copyrighted).
- **Appearances (six):** default, dark, clear light, clear dark, tinted light, tinted dark. Annotated in Icon Composer; the system auto-generates any variant you don't supply. Keep core features identical across variants; build the dark icon from the light one; coloured backgrounds give the best dark-icon contrast.
- Alternate icons (iOS/iPadOS): offered via in-app setting; each must stay closely related to the app and carry its own variant set; all icons go through App Review.

iOS vs macOS: none — pipeline, shape, size and appearance variants are identical across iOS/iPadOS/macOS.

Reviewer checks:
- Single 1024 px square supplied with no pre-applied corner rounding? Pre-rounded corners = violation.
- Baked-in shadows, bevels, glows or speculars? Flag.
- Dark/clear/tinted variants present, or consciously delegated to system generation? Alternate icons each have variants?
- Photos, screenshots/UI replicas, Apple hardware, nonessential text? Flag.
- Same core design across iOS and macOS deliverables; crisp foreground edges; full-bleed opaque background if image-based.

Stale-prior corrections:
- Was: flat single-image icon, designer-supplied squircle, grid of export sizes → Now: one 1024 px layered source built in Icon Composer; the system masks and renders glass (since 2025-06-09).
- Was: macOS permits freeform/realistic icon shapes with overhanging elements (Big Sur era) → Now: macOS uses the same square layout and system mask as iOS (since 2025-06-09).
- Was: light + dark variants only → Now: six appearances; the clear pair is Liquid Glass-era, tinted splits into light/dark (since 2025-06-09; dark/tinted first arrived June 2024).
- Was: "avoid transparency, add a subtle gradient" → Now: transparency within foreground layers is encouraged for depth (since 2025-06-09).

> **27 beta delta (promote on GA):** Icon Composer 2 beta (2026-06-08) builds Liquid Glass layering for iPhone/iPad/Mac/Watch from one design. Press reports app icons gain additional refraction layers in iOS/macOS 27 — press-sourced, not reflected in the HIG as of 2026-06-10.

## branding
<!-- src: branding · changed: none (stable, pre-2025) · platforms: iOS, iPadOS, macOS · speed: stub -->

Non-obvious rules: never use the launch screen as a branding splash — it vanishes too quickly; use a welcome/onboarding screen if needed. Don't repeat the logo through the app. Branding always defers to content — no persistent brand chrome that shows nothing useful. Custom font: headlines/subheads only, system font for body and captions; must stay legible at all sizes and support bold text + larger type accessibility. macOS: the user's system-wide accent colour can replace your app accent — the design must tolerate that substitution. Apple trademarks never appear in app names or imagery.
Reviewer: flag logo-bearing launch screens; logos in toolbars/headers across screens; brand colour doing both interactive and decorative duty (cross-ref color); body copy in a custom font at small sizes; macOS designs that break under a substituted accent.
Fetch for detail: branding

## icons
<!-- src: icons · changed: 2025-06-09 · platforms: iOS, iPadOS, macOS · speed: full -->

Interface icons (glyphs) — distinct from app icons. Streamlined shapes drawn in "black and clear colors"; the system colours the black areas.
- Prefer SF Symbols. Custom icons must match symbols in size, detail level, stroke weight and perspective; supply vector format (PDF/SVG — the system scales), or build a custom SF Symbol instead.
- Match icon weight to adjacent text weight unless deliberately emphasising one.
- Bake optical-centring adjustments into the asset as padding (asymmetric glyphs, e.g. download arrows) so geometric centring yields optical centring.
- Don't supply selected-state variants for icons in standard components (toolbars, tab bars, buttons) — the system handles selected appearance.
- Provide accessibility labels for all custom icons. Localise any text characters; provide flipped RTL variants when depicting text blocks. Gender-neutral, cross-culture imagery. No Apple hardware replicas (exceptions: Apple Design Resources assets, product SF Symbols).
- Canonical action→symbol vocabulary (table added 2025-06-09): tables/sf-symbols-actions.md. Use it instead of ad-hoc glyph choices.

macOS-only — document icons (folded top-right corner): supply none and macOS composites your app icon + extension automatically. Custom = background fill + optional centre image + text term. Background fill sizes 512/256/128/32/16 px @1x with @2x doubles; centre image = half the canvas (16×16 px in a 32×32 icon), kept within ~10% margin (occupies ~80% of canvas); reduce detail at small sizes; nothing important in the top-right corner (fold mask); extension text auto-uppercases and may substitute a short term ("scene", not "scn"). iOS: no additional considerations.

Reviewer checks:
- Custom glyph drawn for an action with a standard symbol (gear, share arrow, trash)? Flag and name the SF Symbol.
- Wrong symbol semantics (`square.and.arrow.up` for upload-to-server; `trash` for recoverable removal; `magnifyingglass` for zoom)?
- Mixed stroke weights/detail levels across a set; icon weight mismatched to label weight; raster custom glyphs; missing accessibility labels; baked selected states; asymmetric glyphs off-centre in containers.

Stale-prior corrections:
- Was: `doc.on.doc`, `doc.on.clipboard`, `doc.text.magnifyingglass` → Now: Copy `document.on.document`, Paste `document.on.clipboard`, Find `text.page.badge.magnifyingglass` — old names are deprecated aliases (since SF Symbols 6, 2024).
- Was: ad-hoc glyph choice per action → Now: a published canonical action→symbol table is the standard vocabulary (since 2025-06-09).
- Menu items now commonly carry icons on macOS too (Menus page updated 2026-06-08) — see components-menus-actions.

## sf-symbols
<!-- src: sf-symbols · changed: 2025-07-28 · platforms: iOS, iPadOS, macOS · speed: full -->

- Symbols align with San Francisco text in all weights and sizes; usable wherever interface icons appear. Availability is OS-version-gated — a release year's symbols don't exist on earlier OSes.
- **Licence: SF Symbols (or confusingly similar artwork) are prohibited in app icons, logos, or any trademarked use.** Symbols depicting Apple products/features are display-as-is, non-customisable (Info-badged in the SF Symbols app).
- Rendering modes: Monochrome (one colour, all layers); Hierarchical (one colour, per-layer opacity = depth); Palette (2+ colours, one per layer; 2 colours over 3 layers → secondary + tertiary share); Multicolor (intrinsic colours, e.g. green `leaf`). Use system colours so symbols adapt to vibrancy, Dark Mode and accessibility; verify legibility per context — automatic mode is a starting point.
- Gradients (SF Symbols 7+): smooth linear gradient from one source colour; all modes, system or custom colours; best at larger sizes.
- Variable colour represents a changing quantity (capacity, strength, progress), NOT depth — depth is Hierarchical mode.
- Nine weights (ultralight→black) matching San Francisco; three scales — small, medium (default), large — defined relative to SF cap height; scale shifts emphasis without breaking the weight match (`imageScale(_:)`, `UIImage.SymbolScale`, `NSImage.SymbolConfiguration`).
- Variants: outline (default, text-like), fill (solid emphasis), slash (unavailable), enclosed (small-size legibility); script variants (Arabic, Hebrew, CJK…) auto-adapt with device language. Containers pick variants — iOS tab bar prefers fill, toolbars take outline — don't fight it.
- Animations (all symbols, custom included): Appear, Disappear, Bounce (one-shot feedback), Scale (persistent, selection), Pulse (opacity-only, ongoing activity), Variable Color (cumulative/iterative; closed-loop layers repeat seamlessly), Replace — **Magic Replace is the default** (smart transition between related shapes; falls back to down-up between unrelated symbols), Wiggle (directional attention), Breathe (living/ongoing), Rotate (whole-symbol or By Layer), **Draw On / Draw Off (SF Symbols 7+; draws along guide-point paths; progress/directionality)**. Every animation must serve a clear communicative purpose.
- Custom symbols: export a similar symbol's template and edit in a vector tool; match system detail, optical weight, alignment, perspective; annotate layers; negative side margins for badge-widened symbols; optimise layers for animation (whole shapes + erase layers, not cutouts); use the component library for enclosures/badges — never hand-drawn; accessibility labels; no Apple product replicas.

iOS vs macOS: no page-level differences; divergence comes from containers (iOS tab bar → fill; toolbar → outline) and API families.

Reviewer checks:
- Symbol-lookalike artwork in an app icon or logo? Licence violation.
- Weight mismatched to adjacent text; mixed scales in one bar; fill variants in macOS toolbars / outline in iOS tab bars.
- Variable colour used decoratively for depth; Multicolor symbols recoloured against intrinsic meaning.
- Symbols from a newer release targeted at older OS versions; custom glyphs duplicating existing symbols; hand-drawn enclosures/badges.

Stale-prior corrections:
- Was: SF Symbols 5/6 feature set → Now: SF Symbols 7 adds gradients and Draw On/Off; Magic Replace is the default replace animation (since 2025-07-28).
- Symbol renames continue across releases (doc→document family) — never assert a symbol name from memory; check the SF Symbols app or tables/sf-symbols-actions.md.

> **27 beta delta (promote on GA):** SF Symbols 8 beta (2026-06-08): semantic search, new symbols, draw annotation guide points (Ultralight/Regular/Black), Variable Draw; targets the 27 OSes. This page predates the beta — verify names/features in the beta app before asserting.

## images
<!-- src: images · changed: 2025-12-16 (visionOS-only additions; iOS/macOS content stable) · platforms: iOS, iPadOS, macOS · speed: full -->

Asset-production mechanics; kept full for its numeric specs.
- A point is the abstract unit; the scale factor maps points→pixels. **Required scale factors: iOS @2x and @3x; iPadOS @2x; macOS @1x and @2x.** Name assets with @1x/@2x/@3x suffixes in the asset catalog.
- Design at the lowest resolution and scale up; place vector control points at whole values at 1x so they stay grid-aligned at 2x/3x.
- Formats: bitmap/raster → de-interlaced PNG (8-bit colour palette when 24-bit is unneeded); photos → JPEG (optimised) or HEIC; flat icons/interface icons/flat artwork needing scaling → PDF or SVG.
- Include a colour profile with every image (see color, colour management). Test on real devices — design-time renders can pixelate or stretch on hardware.

iOS vs macOS: scale factors only (above); no other considerations for either.

Reviewer checks: iOS deliverables missing @3x / macOS missing @1x; raster used for flat glyphs or artwork; interlaced PNG; JPEG for flat UI artwork; missing colour profiles; fractional vector control points causing soft 1x rendering.

Stale-prior correction: Was: JPEG-only for photos → Now: HEIC accepted alongside JPEG. No Liquid Glass impact on this page.
