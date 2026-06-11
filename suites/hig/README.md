# HIG

A suite of agent skills that keeps iOS and macOS designs and prototypes aligned with Apple's Human Interface Guidelines — current to the Liquid Glass era, honest about staleness, and exact about numbers.

Three skills, split by workflow:

- **`hig`** — coordinator, spec lookup, currency checks. "What's the minimum tap target?" answered with citations, not priors.
- **`hig-design`** — design, prototype, port, or implement Apple-native UI under current constraints (HTML prototypes, Figma, SwiftUI).
- **`hig-review`** — audit against the HIG: severity-tiered findings (App-Review-enforced / feels broken / feels non-native), exact values, honest per-medium verification limits.

Why it exists: model priors on Apple design are confidently stale — the HIG was rewritten for Liquid Glass (2025) and again at WWDC 2026. This suite ships a dated, distilled snapshot of ~117 iOS/macOS-relevant HIG pages, a stale-priors corrections table, decision trees, review checklists, runtime-measured component metrics, and scripts that make staleness *detectable* instead of silent. The index also routes code-phrased questions (API symbol → topic) and ~17 niche topics answered by live fetch instead of a corpus section — every iOS/macOS-relevant HIG slug resolves somewhere.

## Install

```sh
# Codex (default target ${CODEX_HOME:-~/.codex}/skills)
sh install.sh

# Claude Code or project-local
TARGET_DIR=.claude/skills sh install.sh
```

The three skills install as **sibling directories**; `hig-design` and `hig-review` read the shared references from `../hig/references/` (single copy). Don't install them separately. Each skill's `learnings.md` survives updates.

## Layout

```text
hig/
├── hig/                 # coordinator skill + references/ (corpus, checklists, tables, adapters,
│   │                    #   doctrine, corrections, trees, adaptation, index, versions) + scripts/
│   └── scripts/         # hig-fetch.sh · hig-whats-new.sh · hig-scan.sh · refresh-workflow.md
├── hig-design/          # build-time skill
├── hig-review/          # audit skill
└── scripts/validate.sh  # repo-side structural validation
```

## Boundaries

- **ui-craft** owns web mechanics; **hig** owns native idiom and metric values. On an HTML prototype of a native app both apply — on conflict, HIG wins for native-targeting work.
- Unmarked "review my prototype" on web work stays with ui-craft/interface-craft; hig-review answers Apple-marked asks.

## Maintenance

The HIG changes ~8–13 times a year (June drop, September GA, December x.2). `hig/references/versions.md` carries the snapshot date and expiry windows — past expiry, the skills attach staleness caveats automatically. To refresh: follow `hig/scripts/refresh-workflow.md` (~2–3h supervised agent session). **September 2026 is the big one**: iOS/macOS 27 GA promotes all `promote on GA` delta blocks. Validate with `scripts/validate.sh`.

Provenance discipline throughout: HIG-published values cite slug + change date; numbers Apple doesn't publish (bar heights, capsule dims) are runtime-measured or kit-derived and marked as such — never presented as HIG values. Sources and method: `docs/research/hig/` in this repo.
