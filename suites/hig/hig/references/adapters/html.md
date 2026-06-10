<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: layout, typography, color, dark-mode, materials, scroll-views, tab-bars, toolbars, sheets, buttons, search-fields, lists-and-tables, motion -->

# HTML adapter — native-targeting prototypes

Load this BEFORE generating any HTML prototype that imitates iOS/iPadOS native UI. Load once, generate all N options under it, then run ONE combined post-generation pass across the set. Vary options within the native idiom (grouping, density, copy, disclosure), never across interaction models. <!-- src: _practice -->

**Cross-suite precedence:** ui-craft owns web mechanics (CSS architecture, responsive strategy, web accessibility plumbing); the hig suite owns native idiom and metric values. On conflict, HIG wins for native-targeting prototypes. <!-- src: _practice -->

## Pre-generation constraint sheet

### Document setup

```html
<meta name="viewport" content="initial-scale=1, viewport-fit=cover, user-scalable=no">
```

- Canvas: **402×874** (iPhone 17/17 Pro) or **440×956** (17 Pro Max); 1 pt = 1 CSS px. <!-- src: tables/metrics.md -->
- Pad chrome with `env(safe-area-inset-top/right/bottom/left)`; content scrolls edge-to-edge **under** the floating bars — never letterboxed above them. <!-- src: layout, _practice -->
- `-webkit-tap-highlight-color: transparent` on interactive elements, AND explicit `:active` states to replace the flash. <!-- src: _practice -->
- Body-scroll-lock while a sheet/modal is open (fix the body's position, preserve the scroll offset) — otherwise the page scrolls behind the sheet, an instant non-native tell. <!-- src: _practice -->
- Test in the Xcode Simulator's Safari or on device, not desktop Chrome. <!-- src: _practice -->

### Standalone PWA recipe (on-device feel)

Manifest with `"display": "standalone"`; `<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">`; install to the Home Screen to test without browser chrome. <!-- src: _practice -->

### Glass approximation — and its limits

Approximate regular Liquid Glass with `backdrop-filter: blur()` (+ `-webkit-`) plus a translucent tint and a light border/inner highlight — tune against a simulator screenshot. CSS cannot do refraction, specular highlights, or beneath-content light/dark adaptation (SVG refraction is Chromium-only; WebGL too heavy) — declare glass as approximated. The clear variant is only for visually rich media and needs a **35%-opacity dark dimming layer** over bright content — that rule transfers to CSS directly. <!-- src: materials, _practice -->

Scroll-edge effect: a progressive blur/fade pocket at the screen edge (backdrop-filter layer under a `mask-image` gradient), never a solid bar fill. <!-- src: scroll-views, tables/metrics.md -->

### Token sheet (CSS custom properties)

```css
:root {
  --font-ui: -apple-system, system-ui, sans-serif; /* resolves to SF Pro on Apple hardware */

  /* Type — iOS Dynamic Type, Large default (HIG-published). Regular weight unless noted. */
  --type-large-title: 34px; --lh-large-title: 41px; /* emphasised Bold; nav large titles render bold */
  --type-title1: 28px;      --lh-title1: 34px;
  --type-title2: 22px;      --lh-title2: 28px;
  --type-title3: 20px;      --lh-title3: 25px;
  --type-headline: 17px;    --lh-headline: 22px;    /* Semibold */
  --type-body: 17px;        --lh-body: 22px;
  --type-callout: 16px;     --lh-callout: 21px;
  --type-subhead: 15px;     --lh-subhead: 20px;
  --type-footnote: 13px;    --lh-footnote: 18px;
  --type-caption1: 12px;    --lh-caption1: 16px;
  --type-caption2: 11px;    --lh-caption2: 13px;

  /* Geometry — runtime-measured, NOT HIG-published; provenance in tables/metrics.md */
  --safe-top: env(safe-area-inset-top, 62px);
  --safe-bottom: env(safe-area-inset-bottom, 34px);
  --margin: 16px;          /* 20px on the 440px-wide canvas */
  --hit-min: 44px;         /* HIG-normative minimum hit region */
  --nav-h: 54px; --large-title-row: 52px;   /* no opaque bar fill — scroll-edge mask */
  --tab-h: 62px; --tab-inset: 21px; --tab-r: 31px;  /* floating capsule, hugs content width */
  --toolbar-platter: 48px; /* individual circles/capsules, ~28px from edges — not a strip */
  --btn-lg: 50px; --btn-md: 34px;           /* capsule: radius = height/2 */
  --search-h: 44px;        /* capsule, radius 22 */
  --row-h: 53px; --list-inset: 20px; --list-r: 26px; /* inset-grouped lists */
  --sheet-r-top: 38px;     /* bottom corners concentric with display */
  --display-r: 62px;       /* concentric maths: child radius = parent radius − inset */
}
```
<!-- src: tables/metrics.md, typography -->

**Semantic colour slots — no published RGB.** Define `--label`/`--label-2`/`--label-3`/`--label-4`, `--bg`/`--bg-2`/`--bg-3`, `--bg-grouped`(+2/3), `--separator`, `--fill`, `--tint`. Apple ships system-colour swatches as images only and warns values fluctuate — memorised hexes (#007AFF) are pre-2025 and wrong; sample a current simulator screenshot or the Apple Figma kit. Supply light AND dark via `prefers-color-scheme` — dark is re-derived (dimmer backgrounds, brighter foregrounds), never inverted; sheets/popovers take an elevated background step. One hue, one meaning: `--tint` never on non-interactive text. <!-- src: color, dark-mode -->

### Geometry rules

- Bars never get solid fills, tints, or hairline borders — separation is the scroll-edge effect. <!-- src: toolbars, materials -->
- Tab bar = floating capsule inset from edges; bottom toolbar = separate platters; never full-width docked strips. <!-- src: tab-bars, toolbars, tables/metrics.md -->
- No full-width edge-to-edge buttons — CTAs inset within `--margin`. <!-- src: layout -->
- Nested radii are concentric: child = parent − inset. <!-- src: toolbars -->

## Emulate-or-waive declaration — REQUIRED output

Every native-targeting prototype ships with a declaration covering all seven behaviours, each marked **emulated** (and how) or **waived** (explicitly, with "verify in SwiftUI / on hardware"). An undeclared gap reads as a claim the prototype can't honour. <!-- src: _practice -->

| Behaviour | Emulated means |
|---|---|
| Swipe-back | edge-swipe pops the view with finger tracking |
| Rubber-banding | overscroll bounce (free in native Safari scroll; lost under `overflow:hidden`/JS scrolling) |
| Sheet detents | medium/large snap points, drag between, grabber (36×5px) |
| Scroll-edge effects | progressive fade/blur under bars, appearing on scroll |
| Dynamic Type | type scales with the system/browser text size (rem-based); AX sizes usually waived |
| Dark mode | `prefers-color-scheme` with a re-derived palette |
| Glass legibility | legible over moving/bright content; approximated at best — say so |

Format, one line per prototype: `Native behaviours: swipe-back WAIVED (verify in SwiftUI) · rubber-banding EMULATED · detents WAIVED · scroll-edge EMULATED (mask) · Dynamic Type PARTIAL · dark mode EMULATED · glass APPROXIMATED`.

## Post-generation checklist (one combined pass across all N options)

- [ ] Declaration present, all seven behaviours, honest. <!-- src: _practice -->
- [ ] `viewport-fit=cover` set; safe areas padded with `env()`; content runs under bars — no letterboxing, no opaque bar fills. <!-- src: layout -->
- [ ] Tap-highlight suppressed AND `:active` states present. <!-- src: _practice -->
- [ ] Hit regions ≥ 44px measured on the padded element, not the glyph. <!-- src: buttons -->
- [ ] Type uses the token ramp; body 17px; nothing below 11px; no Ultralight/Thin/Light weights. <!-- src: typography -->
- [ ] Colours are semantic tokens, light + dark both defined or dark explicitly waived; no pre-2025 hardcoded system hexes. <!-- src: color, dark-mode -->
- [ ] `prefers-reduced-motion` respected for any custom animation. <!-- src: motion -->
- [ ] No full-width CTAs; sheets lock body scroll and show a grabber if resizable. <!-- src: layout, sheets -->
- [ ] Tested in Simulator Safari or as a Home Screen PWA. <!-- src: _practice -->

This checklist is mechanics-only. The full design audit is `checklists/review-screen-ios.md` (+ `review-liquid-glass.md` for glass depth).
