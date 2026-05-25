# Skills

Personal agent skills for design and product work.

## Available skills

- [`paper-prototype`](paper-prototype/) - Create Paper-first UI prototype directions, especially after `grill-with-docs` has settled product and domain decisions. Use it to turn open interface questions into editable Paper artboards before committing to implementation.
- [`surface-details`](surface-details/) - Catch browser quirks, focus handling, touch issues, layout shift, and interface polish details that make web UI feel professional.

## Using with Codex or pi

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
