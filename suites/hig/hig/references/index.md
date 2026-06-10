<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: all -->

# Index — slug → corpus section

Lookup: `grep -n "^## <slug>" corpus/<file>.md` → Read at that offset. Public URL per slug: `https://developer.apple.com/design/human-interface-guidelines/<slug>`. Live fetch: `../scripts/hig-fetch.sh <slug>`.

## corpus/foundations-identity.md
app-icons · branding · icons · sf-symbols (table: sf-symbols-actions) · images

## corpus/foundations-appearance.md
color · dark-mode · materials (doctrine.md for the two-layer model; checklist: review-liquid-glass) · motion

## corpus/foundations-layout-typography.md
layout (tables: metrics) · typography (table: dynamic-type)

## corpus/foundations-people.md
accessibility (table: accessibility-sizes; checklist: review-a11y) · inclusion · privacy (checklist: review-compliance) · right-to-left · writing (checklist: review-copy)

## corpus/patterns-lifecycle.md
launching · onboarding · loading · managing-accounts (checklist: review-compliance) · offering-help · ratings-and-reviews (checklist: review-compliance) · settings · multitasking · going-full-screen · printing
(first-run choreography + required states: checklist review-flow)

## corpus/patterns-interaction.md
charting-data · collaboration-and-sharing · drag-and-drop (checklist: review-flow) · entering-data · feedback · file-management · modality (tree: trees-containers) · managing-notifications (table: notifications-matrix) · playing-audio (table: audio-haptics) · playing-haptics (table: audio-haptics) · playing-video · searching (version-gated; tree: trees-containers) · undo-and-redo

## corpus/components-menus-actions.md
toolbars (absorbed navigation-bars) · buttons · menus · the-menu-bar (checklist: review-screen-macos) · context-menus · edit-menus · pop-up-buttons · pull-down-buttons (tree: trees-controls) · activity-views · dock-menus · home-screen-quick-actions

## corpus/components-nav-search.md
navigation-bars (→ toolbars) · tab-bars (table: metrics) · sidebars · search-fields · token-fields · path-controls

## corpus/components-presentation-status.md
action-sheets · alerts · page-controls · panels · popovers · scroll-views · sheets · windows (tree: trees-containers) · gauges · progress-indicators · rating-indicators

## corpus/components-selection-input.md
color-wells · combo-boxes · image-wells · pickers · segmented-controls · sliders · steppers · text-fields · toggles · virtual-keyboards (tree: trees-controls — availability matrix)

## corpus/components-system-experiences.md
widgets · live-activities (table: system-surface-dims) · controls · notifications · status-bars · app-shortcuts · snippets · always-on (checklist: review-system-surfaces)

## corpus/inputs.md
gestures · keyboards (table: keyboard-shortcuts-macos) · pointing-devices (table: cursors-macos) · focus-and-selection · action-button · camera-control · apple-pencil-and-scribble · siri · gyro-and-accelerometer · nearby-interactions

## corpus/platforms.md
designing-for-ios · designing-for-macos · designing-for-ipados · mac-catalyst (process: adaptation.md)

## corpus/tech-ai.md
machine-learning · generative-ai (checklist: review-ai)

## corpus/tech-commerce.md
apple-pay · wallet · in-app-purchase · sign-in-with-apple · tap-to-pay-on-iphone (table: brand-buttons; checklist: review-compliance) · icloud · app-clips · game-center

## Non-corpus references — when to load
- **doctrine.md** — any generative task; the Liquid Glass two-layer model, platform character, 8 principles + violation mapping.
- **corrections.md** — before trusting your own priors; the stale-beliefs table.
- **trees-containers.md / trees-controls.md** — choosing a container/bar/search placement; choosing a control/menu, platform availability.
- **adaptation.md** — porting iOS↔macOS (sequenced process).
- **checklists/** — review-screen-ios · review-screen-macos · review-flow · review-copy · review-a11y · review-liquid-glass · review-compliance (tier-1 only) · review-ai · review-system-surfaces.
- **tables/** — dynamic-type · accessibility-sizes · keyboard-shortcuts-macos · cursors-macos · sf-symbols-actions · system-surface-dims · brand-buttons · notifications-matrix · audio-haptics · metrics (provenance-marked, non-HIG numbers).
- **adapters/** — html (constraint sheet + emulate-or-waive) · figma (thumbnail-only) · swiftui (Liquid Glass APIs).
- **versions.md** — snapshot date, expiry, hot pages, 27 delta registry. Check when asserting volatile guidance.

Missing slug? The page may be new or renamed: `../scripts/hig-fetch.sh <slug>` (404 → re-fetch root TOC), then note it in learnings.md.
