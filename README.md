# Skills

Personal agent skills for design and product work.

These are published snapshots. The canonical copies live in a private
configuration tree and are exported here with personal paths and workflow
references genericised, so this repo can lag its sources between publishes.
Substantive fixes land on the next publish; edits made here do not flow back.

## Repository Structure

```text
skills/
├── docs/
├── link.sh
├── skills/
│   ├── grill-with-docs/
│   ├── prototype/
│   ├── logic-prototype/
│   ├── paper-prototype/
│   ├── pre-build-review/
│   ├── build/
│   ├── post-build-review/
│   ├── wrapup/
│   ├── polish-fix/
│   ├── decision-coach/
│   ├── handoff/
│   ├── harness-config/
│   └── writing-for-agents/
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

- [`docs/`](docs/) contains the design plans, research, and specs behind the skills.
- [`skills/`](skills/) contains independently installable single skills.
- [`suites/`](suites/) contains larger composed skill systems.

## Standalone Skills

- [`grill-with-docs`](skills/grill-with-docs/) - Grill a plan against the existing domain model, sharpen fuzzy terminology into canonical terms, and capture them in CONTEXT.md and ADRs as decisions crystallise. Stage 1 of the design pipeline. Derived from Matt Pocock's MIT-licensed [`grill-with-docs`, `grilling`, and `domain-modeling` skills](https://github.com/mattpocock/skills).
- [`prototype`](skills/prototype/) - Generate N different single-file HTML implementations of a UI feature, preview them in a gallery, and iterate. Quietly flags a favourite inside the preview; deliberately does not pick a winner, research, implement, verify, or open a PR.
- [`logic-prototype`](skills/logic-prototype/) - Build a single-file HTML demo that answers whether a state model, business logic, or data shape feels right: a pure liftable module driven by free-play buttons and tabbed guided walkthroughs a non-developer can click through. Derived from Matt Pocock's MIT-licensed [`prototype` skill](https://github.com/mattpocock/skills) (`LOGIC.md` branch).
- [`paper-prototype`](skills/paper-prototype/) - Create Paper-first UI prototype directions, especially after `grill-with-docs` has settled product and domain decisions. Use it to turn open interface questions into editable Paper artboards before committing to implementation.
- [`pre-build-review`](skills/pre-build-review/) - Run a direct pre-implementation review for blockers, missing states, accessibility and mobile gaps, awkward data assumptions, and implementation ambiguity.
- [`build`](skills/build/) - Take a scoped request or chosen design direction (Paper, HTML, or Figma) to a verified candidate ready for the owner's local review. Implementation is bracketed by `pre-build-review` and `post-build-review`, and the reviewed tree is fingerprinted so the ship step can prove what was reviewed is what ships. Never self-ships.
- [`post-build-review`](skills/post-build-review/) - Run a read-only post-implementation review that checks a built change against its intent and promised states, runs lint, typecheck, tests, and build, and assembles the handoff evidence before a PR. The mirror of `pre-build-review`.
- [`wrapup`](skills/wrapup/) - Close out a feature worktree once its PR has merged — confirm the merge, verify the deploy where one applies, remove the worktree, and clean branches. Ownership and clean-and-ahead guards, an `--abandon` mode with inverted guards, and a detached reaper for when the session lives inside the worktree it is removing.
- [`polish-fix`](skills/polish-fix/) - Land one small UI papercut as a tiny, easy-to-approve PR with a before/after screenshot, the low-ceremony path for fixes too small to warrant a session.
- [`decision-coach`](skills/decision-coach/) - Coach a real decision, or stress-test reasoning you've already formed, grounded in Annie Duke, Philip Tetlock, and Shane Parrish's Great Mental Models. Routes each decision by stakes and reversibility onto a fast, middle, or deep path (the deep path runs the full frame → map → calibrate → stress-test → decide & protect process). Explicitly invoked.
- [`handoff`](skills/handoff/) - Compact the current conversation into a single Markdown handoff another session or agent can resume from, saved to a durable, harness-agnostic path (`$HANDOFF_DIR`, default `~/handoffs`) with a timestamped name. Captures goal, state, next step, and where to resume, not a transcript.
- [`harness-config`](skills/harness-config/) - Keep agent configuration — instructions, skills, commands, agents, MCP registrations, hooks, and permissions — aligned across more than one harness (e.g. Claude Code and Codex) from a single canonical source, with generated per-harness projections you never edit by hand.
- [`writing-for-agents`](skills/writing-for-agents/) - Reference for writing any document an agent consumes — skills, `AGENTS.md`/`CLAUDE.md`, pointer-reached docs: context pointers, the two loads, information hierarchy, completion criteria, leading words, and pruning, with a skill-mechanics branch for frontmatter and invocation choice. Adapted from Matt Pocock's MIT-licensed [`writing-for-agents`](https://github.com/mattpocock/skills).

## Suites

- [`ui-craft`](suites/ui-craft/) - A coordinator skill plus two domain suites for building web interfaces with stronger structure, clearer naming, and better surface quality.
- [`hig`](suites/hig/) - Three skills (`hig` lookup/routing, `hig-design` build-time guidance, `hig-review` audits) that keep iOS and macOS designs and prototypes aligned with Apple's Human Interface Guidelines: Liquid Glass-current, provenance-marked numbers, staleness made detectable, every iOS/macOS-relevant slug routable (corpus, API symbols, or live fetch). Installs like ui-craft (`sh suites/hig/install.sh`); validate with `sh suites/hig/scripts/validate.sh`.

## Installing everything (linked)

Symlink every standalone skill into your agent skills folders and install the
`ui-craft` suite, so a `git pull` updates every linked location without
reinstalling:

```sh
sh link.sh
```

This links into `~/.claude/skills`, `~/.codex/skills`, and `~/.agents/skills`,
skipping any target whose parent directory (`~/.claude`, `~/.codex`, `~/.agents`)
doesn't exist. If a target already contains a real directory or file with a
skill's name, `link.sh` skips it with a warning; set `FORCE=1` to replace it.

The first two are each harness's own discovery folder. `~/.agents/skills` is
different: it is a harness-neutral home for agent configuration, so skills
linked there survive switching or adding harnesses — a new tool reads (or is
projected from) the same tree instead of needing its own install. The
[`harness-config`](skills/harness-config/) skill documents this
one-canonical-source pattern; if you don't keep an `~/.agents` tree, the two
harness folders are all you need.

Target a single directory with `TARGET_DIR`:

```sh
TARGET_DIR=.claude/skills sh link.sh
```

Re-run when you add, rename, or remove a standalone skill (re-running also
prunes stale links); edits to existing skills are live
through the symlinks. The `ui-craft` suite is copy-installed, so re-run after changing
the suite; it also places four shared reference `.md` files at the root of the skills
directory, which its skills read via relative paths. The `hig` suite installs
separately: `sh suites/hig/install.sh` (same `TARGET_DIR` contract).

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

Copy or symlink the skill directory into your agent's skills folder —
`~/.claude/skills`, `~/.codex/skills`, or a shared tree like `~/.agents/skills`:

```sh
git clone https://github.com/olzn/skills.git
ln -s "$(pwd)/skills/skills/paper-prototype" ~/.claude/skills/paper-prototype
```

Replace `paper-prototype` with any standalone skill directory, such as `pre-build-review`.

## Validation

Run the UI Craft suite checks from the suite root:

```sh
cd suites/ui-craft
sh scripts/validate.sh
```
