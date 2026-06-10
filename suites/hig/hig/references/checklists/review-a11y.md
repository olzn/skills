<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: accessibility, voiceover, charting-data, typography, drag-and-drop -->

# Review — accessibility

Numeric backbone first, then binary rules. Most items are tier 2 — broken for real users — and none are rejection-tier: never claim App Review enforces them. HTML prototypes: map to ARIA equivalents. SwiftUI: prefer recommending `performAccessibilityAudit` XCUITests over re-implementing these checks by hand (see adapters/swiftui.md).

## the-numbers

Copies — authoritative homes: tables/accessibility-sizes.md, tables/dynamic-type.md. <!-- src: tables/accessibility-sizes.md, tables/dynamic-type.md -->

| Check | iOS/iPadOS | macOS |
|---|---|---|
| Control hit target — default / minimum | 44×44pt / 28×28pt | 28×28pt / 20×20pt |
| Padding around interactive elements | ~12pt bezeled / ~24pt bezel-less | same |
| Type — default / minimum | 17pt / 11pt | 13pt / 10pt |
| Contrast (WCAG AA; APCA also accepted) | ≥4.5:1 up to 17pt · ≥3:1 at 18pt+ or bold any size | same |
| Text enlargement | ≥200% without truncation | ≥200% (custom UI — no Dynamic Type) |
| Largest accessibility size | AX5: Body = 53pt (3.1× default) | n/a |

- [2] Below minimum target, type, or contrast = violation. Measure the **hit region**, not the glyph — a 24pt icon with a 44pt region passes; SwiftUI defaults the tappable area to the label's bounds (`contentShape` needed). <!-- src: accessibility -->
- [3] Between default and minimum (say, a 34pt control on iOS) → recommend the default; not an automatic violation — the old single-44pt rule is a stale prior (default/minimum split since 2025). <!-- src: accessibility -->
- [2] Check contrast in **both appearances** when Dark Mode is supported, over the actual content behind translucent materials — glass makes contrast content-dependent. <!-- src: accessibility -->

## feels-broken

**Vision**
- [2] Flag any state conveyed by colour alone (red vs green dot, same shape) — add a distinct shape or symbol; worst pairings: red–green, blue–orange. <!-- src: accessibility -->
- [2] Dynamic Type: flag fixed font sizes, and containers that truncate or overlap when text scales — verify at AX5, where Body = 53pt. <!-- src: accessibility, typography -->
- [2] If default contrast can't be met, a higher-contrast scheme must appear when the system Increase Contrast setting is on. <!-- src: accessibility -->
- [2] Reduce Transparency / Increase Contrast swap translucent materials for opaque variants — the design must survive that swap intact. <!-- src: accessibility -->

**Motor and input**
- [2] Every gesture-driven core function needs an onscreen equivalent (swipe-to-dismiss also needs a visible button; drag-only features need a menu or button path). Simplest gesture possible for frequent actions. <!-- src: accessibility, drag-and-drop -->
- [2] Full Keyboard Access: the entire app navigable by keyboard alone; never override system-defined keyboard shortcuts. Label elements properly so Voice Control works; support VoiceOver, Switch Control, AssistiveTouch, Pointer Control. <!-- src: accessibility -->

**Cognitive and time**
- [2] No timer-dismissed UI: any view that auto-dismisses (toast, banner, transient confirmation) needs an explicit dismissal alternative. <!-- src: accessibility -->
- [2] No autoplaying audio/video without discoverable start/stop controls; respond to Dim Flashing Lights in video playback. <!-- src: accessibility -->
- [2] Under Reduce Motion: replace x/y/z transitions with fades; no z-axis depth animation; tighten springs (less bounce); track animations directly with gestures; don't animate into or out of blurs. <!-- src: accessibility -->

**Hearing**
- [2] Never audio-only for crucial information; pair audio cues with matching haptics and visual cues (especially for off-screen events). Use the right text alternative: **Captions** (synced audible info) · **Subtitles** (dialogue, preferred language) · **Audio descriptions** (visual-only info, spoken) · **Transcripts** (complete, audible + visual). <!-- src: accessibility -->

**VoiceOver**
- [2] Every interactive element carries a non-generic label (no default "Button"/"Image"); labels describe the app-specific action or content and stay current as content changes. HTML: descriptive aria-label/alt on every control. <!-- src: voiceover -->
- [2] Every screen has a unique, descriptive title — the first thing announced on arrival; long screens use real heading semantics, not styled text. <!-- src: voiceover -->
- [2] Visual-only relationships are described: group each image with its caption as one element (read as pairs, not all images then all captions); reading order matches visual logic; report content/layout changes (AccessibilityNotification; HTML live regions); support the rotor where possible. <!-- src: voiceover -->
- [2] Charts: accessibility labels describe the chart's **values and components**, with accessible equivalents for any interactive exploration — a descriptive headline is NOT a substitute. Label meaningful images with only what the image itself conveys; VoiceOver already reads nearby captions. <!-- src: charting-data, voiceover -->

## feels-non-native

- [3] Hardcoded hex where a semantic system colour exists — loses the built-in Increase Contrast and appearance variants. <!-- src: accessibility -->
- [3] Thin-weight custom fonts at the recommended sizes — go larger than the defaults. <!-- src: accessibility -->
- [3] Decorative images exposed to VoiceOver (mark them hidden / `alt=""`), or alt text duplicating an adjacent visible caption — both are noise that costs users time. <!-- src: voiceover -->
- [3] Custom multifinger or multihand gestures for frequent actions — prefer system gestures people already know. <!-- src: accessibility -->
- [3] If the app supports Assistive Access (iOS/iPadOS): one interaction per screen in multistep workflows; ask for confirmation twice before hard-to-recover actions. Declare supported features via Accessibility Nutrition Labels (App Store Connect) — distinct from privacy nutrition labels. <!-- src: accessibility -->
