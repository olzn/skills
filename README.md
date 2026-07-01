# Skills

Personal agent skills for design and product work.

## Repository Structure

```text
skills/
├── skills/
│   ├── prototype/
│   ├── paper-prototype/
│   ├── pre-build-review/
│   ├── post-build-review/
│   ├── polish-fix/
│   └── decision-coach/
└── suites/
    ├── ui-craft/
    │   ├── install.sh
    │   ├── scripts/
    │   ├── ui-craft/
    │   ├── surface/
    │   └── system/
    └── hig/
        ├── install.sh
        ├── scripts/
        ├── hig/
        ├── hig-design/
        └── hig-review/
```

- [`skills/`](skills/) contains independently installable single skills.
- [`suites/`](suites/) contains larger composed skill systems.

## Standalone Skills

- [`prototype`](skills/prototype/) - Generate N different single-file HTML implementations of a UI feature, preview them in a gallery, and iterate. Quietly flags a favourite inside the preview; deliberately does not pick a winner, research, implement, verify, or open a PR.
- [`paper-prototype`](skills/paper-prototype/) - Create Paper-first UI prototype directions, especially after `grill-with-docs` has settled product and domain decisions. Use it to turn open interface questions into editable Paper artboards before committing to implementation.
- [`pre-build-review`](skills/pre-build-review/) - Run a direct pre-implementation review for blockers, missing states, accessibility and mobile gaps, awkward data assumptions, and implementation ambiguity.
- [`post-build-review`](skills/post-build-review/) - Run a read-only post-implementation review that checks a built change against its intent and promised states, runs lint, typecheck, tests, and build, and assembles the handoff evidence before a PR. The mirror of `pre-build-review`.
- [`polish-fix`](skills/polish-fix/) - Land one small UI papercut as a tiny, easy-to-approve PR with a before/after screenshot, the low-ceremony path for fixes too small to warrant a session.
- [`decision-coach`](skills/decision-coach/) - Coach a real decision, or stress-test reasoning you've already formed, grounded in Annie Duke, Philip Tetlock, and Shane Parrish's Great Mental Models. Routes each decision by stakes and reversibility onto a fast, middle, or deep path (the deep path runs the full frame → map → calibrate → stress-test → decide & protect process). Explicitly invoked.

## Suites

- [`ui-craft`](suites/ui-craft/) - A coordinator skill plus two domain suites for building web interfaces with stronger structure, clearer naming, and better surface quality.
- [`hig`](suites/hig/) - Three skills (`hig` lookup/routing, `hig-design` build-time guidance, `hig-review` audits) that keep iOS and macOS designs and prototypes aligned with Apple's Human Interface Guidelines: Liquid Glass-current, provenance-marked numbers, staleness made detectable, every iOS/macOS-relevant slug routable (corpus, API symbols, or live fetch). Installs like ui-craft (`sh suites/hig/install.sh`); validate with `sh suites/hig/scripts/validate.sh`.

## Installing UI Craft

Install globally for Codex:

```sh
curl -fsSL https://raw.githubusercontent.com/olzn/skills/main/suites/ui-craft/install.sh | sh
```

By default, this installs to:

```text
${CODEX_HOME:-$HOME/.codex}/skills
```

Install into a project or Claude Code folder by setting `TARGET_DIR`:

```sh
TARGET_DIR=.claude/skills sh suites/ui-craft/install.sh
```

From a local clone:

```sh
git clone https://github.com/olzn/skills.git
cd skills
sh suites/ui-craft/install.sh
```

## Installing a Standalone Skill

Install a skill directly from GitHub:

```sh
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --url https://github.com/olzn/skills/tree/main/skills/paper-prototype
```

Replace `paper-prototype` with any standalone skill directory, such as `pre-build-review`.

Or clone this repository, then add it to pi settings:

```json
{
  "skills": ["/path/to/skills/skills/paper-prototype"]
}
```

You can also copy a skill directory into a discovered skill location, such as `~/.codex/skills/` or `~/.agents/skills/`.

## Validation

Run the UI Craft suite checks from the suite root:

```sh
cd suites/ui-craft
sh scripts/validate.sh
```
