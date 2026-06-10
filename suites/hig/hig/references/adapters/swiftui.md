<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: materials, toolbars, tab-bars, scroll-views, accessibility -->

# SwiftUI adapter

Implementation guidance for the post-2025 API surface. These APIs postdate most training data — verify signatures against current docs before asserting them; never write Liquid Glass code from memory.

## Liquid Glass APIs — known pitfalls

- **One `GlassEffectContainer` per group.** Each separate `glassEffect` backdrop costs ~3 offscreen render textures; sibling glass elements outside a container also won't blend or morph together. Multiple bare `.glassEffect()` calls in one view = both a performance and a correctness flag. <!-- src: _practice §3 -->
- **`glassEffect` hit-testing defaults to the label only.** Add `.contentShape(...)` so the whole platter is tappable — the visual capsule is bigger than the default hit region. Mind the 44×44pt minimum. <!-- src: buttons, _practice §3 -->
- **Morphing glass is fragile.** Capsule/circle morphs (and `Menu` inside `GlassEffectContainer`) broke differently across 26.0/26.1 — treat morph animations as needing device QA per OS point release. <!-- src: _practice §3 -->
- **The simulator lies about glass.** Specular highlights and motion response render correctly only on hardware. Never sign off glass legibility from the simulator. <!-- src: _practice §3 -->
- **Never `UIDesignRequiresCompatibility`.** The Liquid Glass opt-out dies with Xcode 27 (~Sept 2026). Code written against it has a three-month shelf life. <!-- src: _currency -->

## Structure rules (system-drawn chrome)

- Don't paint bars: no `.background` / custom tints on toolbars, tab bars, or sidebars — the system supplies the glass; scroll edge effects replace opaque fills and hairlines. Use `scrollEdgeEffectStyle(_:for:)` variants, not gradient scrims. <!-- src: toolbars, scroll-views -->
- Let content run edge-to-edge beneath bars (`backgroundExtensionEffect`, ignore-safe-area on the content layer, never on controls). <!-- src: materials -->
- Tab bar extras belong in `tabViewBottomAccessory` (Music MiniPlayer pattern) + `TabBarMinimizeBehavior`, not custom floating views. <!-- src: tab-bars -->
- Semantic styles over hardcoded values: system colours (`Color.primary`, backgrounds via materials), text styles (`.font(.body)`, never `.font(.system(size: 17))`), SF Symbols via `Image(systemName:)`. Apple no longer publishes RGB tables — hardcoded hex values are stale by construction. <!-- src: color, typography -->

## Verification

- Recommend `performAccessibilityAudit(for:_:)` in XCUITests (Xcode 15+) instead of hand-rolled accessibility checks — it's Apple's sanctioned audit and covers contrast, labels, traits, and Dynamic Type. <!-- src: _precedents -->
- Dynamic Type: test previews at `.xSmall`, `.large`, and `.accessibility5`; truncation or clipped layouts at AX sizes are tier-2 findings. <!-- src: typography, accessibility -->
- Run `hig-scan.sh <path> swiftui` for candidate lines first (rule IDs SW-*) — candidates, not findings.

## Cannot-verify (code-only review)

Runtime rendering (glass on hardware), real scroll/gesture feel, Dynamic Island behaviour, haptics. Findings that hinge on these need a device run — say so.
