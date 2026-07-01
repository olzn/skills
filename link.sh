#!/bin/sh
# Link this repo's standalone skills into an agent skills directory and install the
# ui-craft suite there, so this repo is the single source of truth.
#
# Standalone skills are SYMLINKED, so editing the repo updates every linked location
# instantly, with no reinstall. Re-run this only when you ADD a new standalone skill.
# The ui-craft suite is copy-installed via its own installer, so re-run after changing
# the suite.
#
# Usage:
#   sh link.sh                             # link into ~/.claude/skills, ~/.codex/skills, ~/.agents/skills
#   TARGET_DIR=/path/to/skills sh link.sh  # link into a single directory
set -e

REPO_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

link_into() {
  target="$1"
  mkdir -p "$target"
  echo "==> $target"

  # Symlink each standalone skill (any skills/<name>/ that contains a SKILL.md).
  for skill in "$REPO_DIR"/skills/*/; do
    [ -f "${skill}SKILL.md" ] || continue
    name="$(basename "$skill")"
    rm -rf "$target/$name"
    ln -s "${skill%/}" "$target/$name"
    echo "  linked     $name"
  done

  # Install the ui-craft suite (copy-based; preserves each skill's learnings.md).
  if [ -f "$REPO_DIR/suites/ui-craft/install.sh" ]; then
    TARGET_DIR="$target" sh "$REPO_DIR/suites/ui-craft/install.sh" >/dev/null
    echo "  installed  ui-craft suite"
  fi
}

if [ -n "${TARGET_DIR:-}" ]; then
  link_into "$TARGET_DIR"
else
  link_into "$HOME/.claude/skills"
  link_into "$HOME/.codex/skills"
  link_into "$HOME/.agents/skills"
fi

echo "Done. Standalone skills are symlinked to the repo; edits are picked up automatically."
