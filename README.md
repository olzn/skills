# Skills

Personal agent skills for design and product work.

This repository now hosts the UI Craft suite as well as standalone skills.

## Available skills

- [`paper-prototype`](paper-prototype/) - Create Paper-first UI prototype directions, especially after `grill-with-docs` has settled product and domain decisions. Use it to turn open interface questions into editable Paper artboards before committing to implementation.

## UI Craft

UI Craft is a coordinator skill plus two domain suites for building web interfaces with stronger structure, clearer naming, and better surface quality.

It contains:

- [`ui-craft`](ui-craft/) - the coordinator skill for routing broad UI tasks.
- [`surface`](surface/) - how interfaces look, read, move, respond, adapt to platform constraints, and feel in use.
- [`system`](system/) - what interface parts are made from, what they are called, and how they fit into a reusable system.

### Surface skills

- [`surface-motion`](surface/surface-motion/) - animation implementation, easing, timing, transitions, exits, entrances, and motion polish.
- [`surface-interaction`](surface/surface-interaction/) - gesture intent, spatial logic, frequency calibration, drag behaviour, and whether something should animate.
- [`surface-typography`](surface/surface-typography/) - type scales, font loading, OpenType features, rhythm, wrapping, and rendering.
- [`surface-copy`](surface/surface-copy/) - interface copy, microcopy, errors, empty states, onboarding, tooltips, and UX writing.
- [`surface-colour`](surface/surface-colour/) - OKLCH palettes, semantic colours, contrast, dark mode, colour blindness, and theme mapping.
- [`surface-details`](surface/surface-details/) - browser quirks, input details, touch behaviour, focus handling, performance micro-details, and visual polish.

### System skills

- [`system-tokens`](system/system-tokens/) - design token architecture, foundation scales, semantic mappings, and theming.
- [`system-naming`](system/system-naming/) - labels, commands, variables, classes, tokens, icons, components, features, products, and UI terminology.
- [`system-components`](system/system-components/) - reusable component APIs, variants, composition, state coverage, and icon conventions.
- [`system-patterns`](system/system-patterns/) - forms, navigation, tables, feedback, layouts, and larger product patterns.

## Installing UI Craft

Install globally for Codex:

```sh
curl -fsSL https://raw.githubusercontent.com/olzn/skills/main/install.sh | sh
```

By default, this installs to:

```text
${CODEX_HOME:-$HOME/.codex}/skills
```

Install into a project or Claude Code folder by setting `TARGET_DIR`:

```sh
TARGET_DIR=.claude/skills sh install.sh
```

From a local clone:

```sh
git clone https://github.com/olzn/skills.git
cd skills
sh install.sh
```

## Installing a standalone skill

Install a skill directly from GitHub:

```sh
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --url https://github.com/olzn/skills/tree/main/paper-prototype
```

Or clone this repository, then add it to pi settings:

```json
{
  "skills": ["/path/to/skills"]
}
```

You can also copy a skill directory into a discovered skill location, such as `~/.codex/skills/` or `~/.agents/skills/`.

## Validation

Run the UI Craft suite checks from the repository root:

```sh
sh scripts/validate.sh
```
