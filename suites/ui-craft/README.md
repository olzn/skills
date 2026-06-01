# UI Craft

UI Craft is a suite of agent skills for building and reviewing web interfaces.

It helps agents make better decisions about structure, naming, components, tokens, copy, typography, colour, motion, interaction behaviour, accessibility, and browser polish.

Use `ui-craft` when the task is broad. Use a narrower skill when the domain is already clear.

## Install

Install globally for Codex:

```sh
curl -fsSL https://raw.githubusercontent.com/olzn/skills/main/suites/ui-craft/install.sh | sh
```

Install into a project or Claude Code folder:

```sh
TARGET_DIR=.claude/skills sh install.sh
```

From a local clone:

```sh
git clone https://github.com/olzn/skills.git
cd skills/suites/ui-craft
sh install.sh
```

By default, the installer writes to:

```text
${CODEX_HOME:-$HOME/.codex}/skills
```

It preserves each installed skill's `learnings.md` file across updates.

## What Is Included

```text
ui-craft/
|-- ui-craft/                 Coordinator skill
|-- surface/                  Visual, copy, motion, interaction, browser polish
`-- system/                   Naming, tokens, components, composite patterns
```

The coordinator skill:

- `ui-craft`: routes broad UI work to the right specialist skill.

Surface skills:

- `surface-motion`: animation vocabulary, easing, timing, transitions, entrances, exits.
- `surface-interaction`: gestures, spatial logic, interruptibility, behaviour intent.
- `surface-typography`: type scales, font loading, rhythm, wrapping, OpenType features.
- `surface-copy`: UX copy, errors, empty states, helper text, onboarding, tooltips.
- `surface-colour`: OKLCH palettes, semantic colours, contrast, dark mode.
- `surface-details`: forms, focus, touch, scroll, platform quirks, visual finish.

System skills:

- `system-tokens`: spacing, radius, shadow, z-index, breakpoints, semantic tokens.
- `system-naming`: UI terms, commands, variables, components, icons, tokens.
- `system-components`: reusable component APIs, variants, state coverage, composition.
- `system-patterns`: forms, navigation, tables, feedback, layouts, larger UI patterns.

## Choosing A Skill

Start with the narrowest skill that owns the decision.

| Task | Start with |
|---|---|
| Broad UI build, review, or polish pass | `ui-craft` |
| Feature names, commands, component names, token names | `system-naming` |
| Design tokens, spacing, radius, shadows, theme structure | `system-tokens` |
| Reusable component APIs and state coverage | `system-components` |
| Forms, tables, navigation, dashboards, modals, page structure | `system-patterns` |
| Error messages, empty states, helper text, onboarding copy | `surface-copy` |
| Type scale, font loading, text wrapping, rhythm | `surface-typography` |
| Colour palettes, contrast, dark mode, semantic colours | `surface-colour` |
| Gesture behaviour, animation intent, spatial logic | `surface-interaction` |
| Animation implementation, easing, timing, transitions | `surface-motion` |
| Browser details, focus, touch, scroll, inputs, visual polish | `surface-details` |

For deeper routing guidance, read:

- [surface/README.md](surface/README.md)
- [system/README.md](system/README.md)
- [surface/composition.md](surface/composition.md)
- [surface/quality.md](surface/quality.md)

## Validate

Run the dependency-free validation harness before publishing or installing from a local clone:

```sh
sh scripts/validate.sh
```

## Attribution

This suite distils ideas from many designers, engineers, and design-system practitioners, including Anthony Hobday, Benji Taylor, Rauno Freiberg, Emil Kowalski, Jakub Krolikowski, Derek Briggs, Raphael Salaja, Laws of UX, NN/g, Polaris, Intuit, Vodafone, and others cited inside the relevant skill documents.

All original ideas and guidelines belong to their respective authors. This repo packages those influences as agent skills for practical interface work.

## Licence

MIT
