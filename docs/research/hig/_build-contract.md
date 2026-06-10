# HIG suite — build contract (every drafter follows this)

Spec: `docs/specs/2026-06-10-hig-suite-design.md` (v2). Suite root: `repo/suites/hig/`. Shared references live ONLY under `suites/hig/hig/references/`.

## File header (every reference file, first line)
```html
<!-- hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: <comma-separated slugs this file derives from> -->
```

## Corpus files (`references/corpus/`)
- One section per HIG page, header is the slug exactly: `## tab-bars` (enables `grep -n "^## tab-bars"`).
- Section first line: `<!-- src: tab-bars · changed: 2026-06-08 · platforms: iOS, iPadOS, macOS · speed: full|stub -->`
- Two-speed rule: `full` (30–80 lines) ONLY for pages changed since 2025-01-01, pages carrying numeric specs, or pages with stale-prior corrections. Everything else is a `stub` (5–15 lines: the non-obvious rules + `Fetch for detail: <slug>`). Do NOT re-teach what a strong model already knows (what a slider is, why consistency matters).
- Full sections contain, tersely: normative rules (exact values, exact Apple terms) · iOS vs macOS deltas · reviewer checks · stale-prior corrections (`Was: → Now: (since YYYY-MM-DD)`).
- iOS/macOS 27 beta content goes in delta blocks: `> **27 beta delta (promote on GA):** …` — never woven into baseline prose.
- File budget: ≤14KB (~3.5K tokens). Canonical URL appears once per section, in the src comment line, as the slug (full URL pattern documented once in index.md).

## Derived files (checklists, trees, tables, adapters, doctrine, corrections, adaptation)
- Every claim-carrying block ends with a greppable source tag: `<!-- src: tab-bars, toolbars -->`.
- Checklists: imperative, checkable items ("Flag any X that Y"), grouped by severity tier (1 rejection-risk / 2 feels-broken / 3 feels-non-native). Composite screen checklists (review-screen-ios/-macos) are self-sufficient: they inline the hot numbers, each inline copy marked `<!-- src: tables/<file>.md -->` so validate.sh can diff copies against source.
- Numbers live ONCE authoritatively (tables/ or a corpus section); everything else is a marked copy or a reference.
- Tables: markdown tables, no prose padding, provenance column where values are not HIG-published (`HIG <date>` / `kit-derived` / `community-measured` + confidence).
- corrections.md entries: `| You likely believe | Current guidance (since) | src | volatility |` — volatility = stable/hot (hot = re-verify before asserting).
- Budgets: checklist ≤10KB · adapter ≤8KB · doctrine ≤8KB · tree file ≤8KB · adaptation ≤8KB.

## Style
- British prose (colour, behaviour) EXCEPT Apple proper nouns and component/API names verbatim (Color well, Dark Mode, glassEffect).
- Dense, imperative, zero filler. No "it's important to note". One excellent example beats three mediocre ones.
- Never invent a number. If Apple doesn't publish it: say so + provenance-marked estimate or "measure at runtime".
- Severity language: tier 1 may say "App Review enforces this"; tiers 2–3 must NEVER claim rejection risk.
- Press-sourced claims (anything not verifiable on a live HIG page) must be version-gated and labelled.

## Verification expectations for drafters
- Research notes in `docs/research/hig/` are your primary source. If a claim is load-bearing and the note flags it as hot/uncertain, verify live: `curl -s 'https://developer.apple.com/tutorials/data/design/human-interface-guidelines/<slug>.json'` (check it parses; extract from primaryContentSections). Respect provenance corrections in _currency.md/_practice.md.
- Return value: list of files written + per-file byte count + any claim you could not source (do NOT write unsourced claims).
