<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: whats-new -->

# Versions and currency

## Snapshot
- **Captured:** 2026-06-10 (two days after the WWDC 2026 HIG drop of 2026-06-08).
- **Encoded baseline:** iOS/iPadOS 26.x · macOS Tahoe 26.x — the stable shipping platforms.
- **Beta (version-gated):** iOS 27 / macOS 27 "Golden Gate", announced 2026-06-08, expected GA ~September 2026. All 27 content lives in delta blocks marked `promote on GA`. Beta guidance flip-flopped during the 2025 cycle — do not treat 27 deltas as settled.

## Expiry — check before asserting volatile guidance
| Window | Expected | What changes |
|---|---|---|
| 2026-09-15 | iPhone hardware + 27 GA | device dimensions, layout specs, **the 27 baseline flip** (see scripts/refresh-workflow.md) |
| 2026-12-15 | 27.2 | component revisions (tab bars changed in Dec 2025) |
| 2027-06-15 | WWDC 2027 | major drop (~18–30 pages) |

**Behaviour rules:**
- Today past an expiry date → attach a staleness caveat to volatile answers and offer `scripts/hig-whats-new.sh`.
- Fetch unavailable or failing → answer from snapshot **plus** explicit caveat. Never bare. Never silently.
- `hig-whats-new.sh` exit 2 (parse fail) means "unknown", never "no changes".

## Hot pages — verify live when expired or contested
tab-bars · toolbars · search-fields · sidebars · buttons · color · app-icons · materials · scroll-views · menus · siri · app-shortcuts · widgets · live-activities · layout (device tables)

Stable areas (bake-safe, last changed 2022–24): interaction patterns (modality, drag-and-drop, undo, feedback), lifecycle patterns, most selection/input components.

## Provenance rules
- HIG-sourced = verifiable on a live HIG page (slug + change date). Press-sourced (WWDC coverage, blogs) = version-gated, labelled, never stated as HIG doctrine. Two press claims were already corrected this way on 2026-06-10 (sidebar icon colour "reversal"; search-tab "re-integration") — see docs/research/hig/_currency.md provenance section in the source repo.
- Numbers Apple doesn't publish (bar heights, capsule dims): provenance-marked in `tables/metrics.md` (kit-derived / community-measured + confidence). Never present these as HIG values.

## 27 delta-block registry
Find all beta deltas: `grep -rn "promote on GA" .` — each must be promoted or deleted at the September flip (procedure: `../scripts/refresh-workflow.md`).
