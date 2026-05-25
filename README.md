# Skills

Personal agent skills for design and product work.

## Repository Structure

```text
skills/
├── skills/
│   └── paper-prototype/
└── suites/
    └── ui-craft/
        ├── install.sh
        ├── scripts/
        ├── ui-craft/
        ├── surface/
        └── system/
```

- [`skills/`](skills/) contains independently installable single skills.
- [`suites/`](suites/) contains larger composed skill systems.

## Standalone Skills

- [`paper-prototype`](skills/paper-prototype/) - Create Paper-first UI prototype directions, especially after `grill-with-docs` has settled product and domain decisions. Use it to turn open interface questions into editable Paper artboards before committing to implementation.

## Suites

- [`ui-craft`](suites/ui-craft/) - A coordinator skill plus two domain suites for building web interfaces with stronger structure, clearer naming, and better surface quality.

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

Or clone this repository, then add it to pi settings:

```json
{
  "skills": ["/path/to/skills/skills"]
}
```

You can also copy a skill directory into a discovered skill location, such as `~/.codex/skills/` or `~/.agents/skills/`.

## Validation

Run the UI Craft suite checks from the suite root:

```sh
cd suites/ui-craft
sh scripts/validate.sh
```
