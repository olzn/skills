<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: layout, materials, typography -->

# Figma adapter

How to review (and spec) Apple-platform designs in Figma through the connected Figma MCP — built around what the tooling actually does.

## The capability reality

`view_node` returns a **thumbnail image** of a node. No geometry, no layer tree, no text content, no variables. Therefore: <!-- src: tool schema, verified 2026-06-10 -->

- **Every numeric check is on the cannot-verify list for this medium.** You cannot confirm 44pt targets, margins, type sizes, or radii from a render. Do not pretend otherwise.
- What a thumbnail CAN support: idiom judgment (web-transplant components, wrong platform idiom, container choice), hierarchy and grouping, copy review, obvious contrast failures, missing states (if frames exist), Liquid Glass layer misuse visible at render scale.

## Review protocol

1. Treat `view_node` output under the same screenshot protocol as an agent-browser capture: run the relevant screen checklist's **visually-judgeable** items only.
2. Tag any size/spacing estimate explicitly: **"estimated from render — confirm in Figma inspector."** Never put an estimated number in a finding's spec line.
3. For numeric verification, use a fallback:
   - Ask for inspector values (user selects the node, reads W/H/x/y), or
   - Ask for an export at a declared scale (e.g. @1x PNG of the frame) and measure pixels = points, stating the assumption.
4. End the audit with the standard cannot-verify list: all pt values, scroll-edge behaviour, Dynamic Type reflow, morphing/motion, glass legibility over moving content, interactive states not drawn as frames. <!-- src: _practice §4 -->

## Working against Apple's kit

- Apple's official **iOS/iPadOS 26 Figma kit** (Community file `1527721578857867021`, overhauled July 2025 with Liquid Glass components, control sizes, radii, colours) is design-truth for component geometry. Audit against it rather than re-deriving geometry. <!-- src: _precedents -->
- Community files aren't directly API-readable: duplicate the kit into the user's account, `add_figma_file`, then `view_node` component frames for side-by-side comparison renders.
- Kit-version lag is real (27-era kits were Sketch-only at snapshot date; Figma lagged ~2 months in 2025). A design built on the 26 kit is correct against baseline — flag 27 deltas as upcoming, not as violations. <!-- src: _currency -->

## What static comps can't prove (say so in findings)

Scroll-edge effects · sheet detent behaviour · swipe-back and gesture conflicts · Dynamic Type reflow at AX sizes · glass legibility across the intensity slider and Reduce Transparency · morph animations · keyboard avoidance. Recommend a motion-capable medium (SwiftUI preview or HTML prototype) for any finding that hinges on these.

## Upgrade path

If a Dev-Mode-grade Figma MCP (get_metadata / get_code / variables) is ever connected, numeric checks move off the cannot-verify list — re-read this adapter then.
