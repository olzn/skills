<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: accessibility, typography, color, dark-mode, layout, materials, tab-bars, toolbars, search-fields, sheets, action-sheets, alerts, popovers, lists-and-tables, disclosure-controls, buttons, pop-up-buttons, context-menus, icons, labels, privacy, sign-in-with-apple, gestures, writing -->

# Screen review — iOS

Everything checkable on one static iOS screen (screenshot, Figma frame, HTML prototype, SwiftUI preview). Self-sufficient — the hot numbers are inlined. Glass/material depth → `review-liquid-glass.md`; flows → `review-flow.md`; copy → `review-copy.md`; what a render can't prove → `adapters/`.

## Tier 1 — rejection risk (App Review enforces these)

- Flag any pre-permission explainer screen with more than **one button**, a button titled "Allow"/"OK" (must be Continue/Next-like), or any close/skip/cancel affordance. <!-- src: privacy -->
- Flag any tracking-consent screen offering an incentive, showing an image or replica of the system alert, or annotating/pointing at the upcoming alert (Guideline 5.1.1(iv)). <!-- src: privacy -->
- Flag Sign in with Apple drawn as a custom button rather than the system-provided style — the one brand spec App Review checks pixel-by-pixel. <!-- src: sign-in-with-apple, _practice -->
- Flag minimum-functionality tells (Guideline 4.2): placeholder/lorem content, broken or overlapping layout, blurry or stretched assets, spelling errors, spinner-only screens. <!-- src: _practice -->

## Tier 2 — feels broken

**The numbers** (inline copies; source of truth `tables/accessibility-sizes.md`):

- Interactive targets: **44×44 pt default, 28×28 pt absolute minimum** — flag below 44, fail below 28. Measure the hit region, not the glyph. <!-- src: tables/accessibility-sizes.md -->
- Spacing: ≥ **12 pt** padding around bezeled controls; ≥ **24 pt** around the visible edges of bezel-less ones. <!-- src: tables/accessibility-sizes.md -->
- Type: body defaults to **17 pt**; flag anything below **11 pt**. <!-- src: tables/accessibility-sizes.md -->
- Contrast (WCAG AA, check light AND dark): ≥ **4.5:1** for text through 17 pt; ≥ **3:1** at 18 pt and up, or bold. <!-- src: tables/accessibility-sizes.md -->
- Text containers must survive **200%** enlargement — flag fixed-height containers on primary text. <!-- src: tables/accessibility-sizes.md -->

Structural checks:

- Flag interactive content under the Dynamic Island, status bar, or home indicator — and the opposite failure, dead letterboxed margins: content runs edge-to-edge beneath the floating bars. <!-- src: layout -->
- Flag full-width edge-to-edge buttons; CTAs inset within the layout margins. <!-- src: layout -->
- Flag state conveyed by colour alone (red vs green dot, same shape) — require a shape or label difference. <!-- src: accessibility -->
- Flag views that auto-dismiss on a timer with no explicit dismiss control. <!-- src: accessibility -->
- Flag core actions with no visible path: anything reachable only by gesture (swipe-delete with no Edit affordance, swipe-dismiss with no button) needs an onscreen equivalent. <!-- src: accessibility, gestures -->
- Flag a destructive action styled as the primary/accent button — destructive is red and never the default. <!-- src: buttons -->
- Alerts: max 3 buttons; title never "Error" or a raw code; Cancel leading (row) / bottom (stack), default trailing/top; never "Yes"/"No"; "OK" only when purely informational; a destructive alert always includes Cancel and isn't red-styled when the person deliberately chose the action. <!-- src: alerts -->
- Action sheets: destructive choice red AND at the top, Cancel at the bottom; on iPad it presents as a popover from its source. <!-- src: action-sheets -->
- Sheets: Done always paired with Cancel (or Back mid-flow); never Cancel+Done+Back together; Cancel top-leading, Done top-trailing; resizable sheets show a grabber. <!-- src: sheets -->
- Flag any popover at iPhone width — compact size classes present a sheet instead. <!-- src: popovers -->
- Flag hardcoded hex where a semantic colour exists (label levels, systemBackground/grouped sets) — it loses Dark Mode and Increase Contrast variants. Flag dark mode built by inversion: pure #000 plus fixed greys misses the base/elevated background step; aim 7:1 for small custom text on dark. <!-- src: color, dark-mode -->

## Tier 3 — feels non-native

**Web/Android transplants — the five tells.** Each marks the screen as a port: <!-- src: _practice -->

1. **Hamburger/drawer** for top-level navigation → a floating tab bar, visible on every section. <!-- src: tab-bars -->
2. **Browser-style dropdown** (`<select>` look, custom chip menu) for a short exclusive option set → pop-up button showing the current value. <!-- src: pop-up-buttons -->
3. **Floating action button** (Material FAB) → primary actions live in the toolbar (one prominent, trailing) or in the content. <!-- src: toolbars, buttons -->
4. **Always-visible action buttons in list rows** → rows carry at most one accessory; actions live in swipe actions, edit mode, or a context menu. <!-- src: lists-and-tables, context-menus -->
5. **Centred modal card** for action choices → choices about a just-taken action are a bottom action sheet; scoped subtasks are a sheet; alerts are reserved for unexpected, critical situations. <!-- src: action-sheets, sheets, alerts -->

**Bars and placement**

- Tab bar floats above content on Liquid Glass (capsule; measured dims `tables/metrics.md`) — flag opaque edge-pinned strips. Tabs navigate, never act (no Compose/Add/Share); never hidden or disabled on inner non-modal screens; single-word labels under filled SF Symbols; ≤5 tabs before More overflow; badges red, critical info only. <!-- src: tab-bars -->
- Top toolbar: Back/Close are the standard chevron/xmark symbols, never the words; title under 15 characters; icons borderless (no outlined circles); ≤3 item groups; exactly one prominent tinted action, trailing. Custom bar backgrounds → `review-liquid-glass.md`. <!-- src: toolbars -->
- Search: prefer a bottom toolbar (reach) or a search tab — standard-tab or button-appearance style, one chosen consistently — or inline above the list it filters. Flag app-wide search buried only at the top of a long scroll. Field anatomy: magnifier, clear button, placeholder. <!-- src: search-fields -->
- Flag a hidden status bar outside immersive contexts. <!-- src: layout -->

**Lists and disclosure**

- ⓘ detail-disclosure reveals details only; drill-down uses the trailing chevron (disclosure indicator). Flag any ⓘ acting as a navigation target. <!-- src: lists-and-tables -->
- Never an A–Z index plus trailing-edge row controls together. Navigation lists keep a persistent selection highlight (split views); option-picker lists show a checkmark instead. <!-- src: lists-and-tables -->
- Settings-style screens use inset-grouped lists (radius 26 pt, runtime-measured — `tables/metrics.md`), not web cards with hairline borders. <!-- src: lists-and-tables -->
- Disclosure triangle points leading when collapsed, down when expanded, and carries a label; max one disclosure button per view. <!-- src: disclosure-controls -->

**Type, colour, symbols**

- Ramp deviations are tells: Body 17, Headline 17 Semibold, Footnote 13, Captions 11–12. A 15 pt "body" or a non-system UI font flags a port; no Ultralight/Thin/Light weights. <!-- src: typography -->
- One hue, one meaning — accent colour never on non-interactive text; text hierarchy uses the four semantic label levels, not custom greys. <!-- src: color, labels -->
- Standard actions take their standard symbols (Share `square.and.arrow.up`, Compose `square.and.pencil`, Copy `document.on.document` — full table on the icons page); symbol weight matches adjacent text; no emoji as interface glyphs. <!-- src: icons -->
- Copy says "tap", never "click"; button labels are title-case verbs. Depth → `review-copy.md`. <!-- src: writing -->
