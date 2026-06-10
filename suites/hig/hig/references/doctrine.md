<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: materials, color, layout, toolbars, tab-bars, sidebars, buttons, app-icons, design-principles, gestures, keyboards, pointing-devices, focus-and-selection, the-menu-bar, search-fields, typography -->

# Doctrine — the mental model behind every HIG rule

Exact values live in `tables/` and `corpus/`; this file is the reasoning that makes them cohere.

## The two-layer model (Liquid Glass)

Every current Apple interface is two layers:

1. **Content layer** — the app's content and in-content controls. Uses **standard materials** (iOS: ultraThin/thin/regular/thick; macOS: purpose-named NSVisualEffectView materials) and semantic colours. Content extends **edge-to-edge**: backgrounds reach the display edges; scrollable content continues to the bottom and sides of the screen.
2. **Functional layer** — controls and navigation (tab bars, toolbars, sidebars) made of **Liquid Glass**, floating above the content. Content scrolls beneath and peeks through. Glass has no inherent colour — it adapts to the content behind it; symbols and text default to monochromatic. <!-- src: materials, layout -->

Layer discipline generates most other rules:
- **"Don't use Liquid Glass in the content layer."** Sole exception: transient interactive elements (a slider knob, a toggle) take on glass only while actively manipulated. Glass on cards, list rows, or backgrounds is the commonest error. <!-- src: materials -->
- **"Use Liquid Glass effects sparingly."** System components get it automatically; limit custom glass to the most important functional elements. <!-- src: materials -->
- **Scroll edge effects replace bar backgrounds.** No opaque bar fills, no hairline dividers — the separation cue is the scroll edge effect blurring/fading content under the bar at screen edges. Where content doesn't span the window, a **background extension view** mirrors adjacent content behind sidebars and inspectors. <!-- src: materials, layout, toolbars, sidebars -->

**Variants.** *Regular* (default): blurs and adjusts luminosity of the background; use wherever there is significant text (alerts, sidebars, popovers) or legibility risk. *Clear*: highly translucent; **only over visually rich media** (photos, video); over bright content add a **dark dimming layer at 35% opacity** (skip when content is dark or AVKit playback controls supply one). Appearance shifts with the user's Liquid Glass preference, Reduce Transparency, and Increase Contrast — designs must survive all settings. <!-- src: materials -->

**One prominent control.** Colour on glass is emphasis, not decoration. Tint the **background** (never the symbol or text) of the single primary action — the `.prominent` style, e.g. Done — placed at the toolbar's **trailing** edge. Everything else stays monochromatic: "Refrain from adding color to the background of multiple controls." In a content view, keep prominent buttons to one or two. Two tinted controls in one bar is a checkable violation. <!-- src: color, toolbars, buttons -->

**Concentricity.** Corner radii nest: controls inside a bar are concentric with the bar's corners, and custom components must match (SwiftUI: `ConcentricRectangle`). App icons ship as square, unmasked 1024 px layered sources — the system applies a mask concentric with system UI and the device bezel. Never pre-round, never bake in shadows or speculars. <!-- src: toolbars, app-icons -->

## Platform character

One design language, two characters. The deltas are behavioural, not cosmetic — "approach every platform with intention". <!-- src: design-principles -->

**iOS is touch and reach.** Fingers are imprecise: hit regions ≥44×44 pt with 12 pt (bezeled) / 24 pt (bezel-less) surrounding padding; body text 17 pt. Thumbs live at the bottom: the tab bar floats there, and search prefers a bottom toolbar or search tab over a top placement. The system owns the screen edges (Home indicator, Dynamic Island, edge swipes) — custom gestures must not collide, and every gesture is a shortcut that supplements a visible control, never replaces it. There is no focus system and no hover on iPhone — nothing may depend on either. <!-- src: buttons, pointing-devices, typography, tab-bars, search-fields, gestures, focus-and-selection -->

**macOS is keyboard, pointer, menu bar, and density.** The menu bar is the superset of every command: anything reachable from a toolbar, context menu, or Dock menu must also exist as a menu bar command, in the canonical order (AppName · File · Edit · Format · View · app-specific · Window · Help). The standard shortcut table is a hard expectation (⌘, opens Settings; ⌃⌘F full screen; ⌘Z undo — always). Pointers are semantic (I-beam, pointing hand, not-allowed); fields show focus rings; lists highlight with the accent colour. Density is higher: 13 pt body, 28 pt default controls (20 pt minimum). And the **user owns the environment**: the system accent colour can replace yours, sidebar icon size and toolbar contents are user-configurable, windows resize freely and restore state — designs must tolerate every substitution. Keep critical controls away from the window bottom (it's often offscreen). <!-- src: the-menu-bar, keyboards, pointing-devices, focus-and-selection, typography, color, sidebars, toolbars, layout -->

## The eight design principles

Reintroduced 2026-06-08; the canonical set is **Purpose, Agency, Responsibility, Familiarity, Flexibility, Simplicity, Craft, Delight**. Apple frames them as trade-off instruments, not a checklist — use them as finding categories, the topic page as the citable spec. Agency, Responsibility, Familiarity, Flexibility, and Simplicity map to mechanical checks; Purpose, Craft, and Delight ground advisory findings. <!-- src: design-principles -->

| Principle — tagline | Checkable violations |
|---|---|
| **Purpose** — "Make something meaningful." | Launch lands on marketing/secondary dashboards instead of core content; toolbars/settings stuffed with rarely used controls. |
| **Agency** — "Let people do things their own way." | Guided flow with no Skip/escape; experience gated behind forced sign-up or tour; destructive action with neither undo nor confirmation; macOS app ignoring ⌘Z; rating/upsell overlays before the user has done anything. |
| **Responsibility** — "Act in people's best interest." | Permission battery at launch instead of in feature context; vague purpose strings; data collected beyond what the feature needs. |
| **Familiarity** — "Build on what people know." | Custom lookalike replacing a system alert/action sheet (verbatim rule: "use system patterns to display alerts and offer choices"); same icon/gesture meaning different things across screens; no enabled/disabled signalling; hijacked swipe-back. |
| **Flexibility** — "Adapt to diverse contexts and needs." | No Dynamic Type; missing VoiceOver labels; contrast failures — accessibility deferred to "later" violates "from the start"; single-input assumptions; straight platform ports. |
| **Simplicity** — "Be clear and direct." | Verbose/jargon labels; no discernible hierarchy. Inverse failure too: **simplicity isn't minimalism** — essential controls hidden behind ambiguous icons to look clean. |
| **Craft** — "Care about every detail." | Dropped-frame animation, placeholder wording, low-res assets; untested edge contexts (long text, slow network). "Maintain your craft / keep your interface current" makes pre-Liquid-Glass conventions (opaque bars, legacy icons) a citable craft violation, not a taste call. |
| **Delight** — "Make it human." | Decoration blocking tasks: gratuitous animation delaying completion, character copy obscuring an error's remedy; tonal mismatch (whimsy in a banking error). Absence of delight is a soft note, never a violation. |

<!-- src: design-principles -->

Pre-2023 principle sets (Clarity/Deference/Depth; the six-principle list) are obsolete — see `corrections.md`. Severity tiers live in hig-review's SKILL.md; tag tier-2/3 judgment findings with a principle name so critique reads as Apple's vocabulary, not taste.
