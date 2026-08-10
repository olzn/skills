#!/bin/sh
# Link this repo's standalone skills into an agent skills directory and install the
# ui-craft suite there, so this repo is the single source of truth.
#
# Standalone skills are SYMLINKED, so editing the repo updates every linked location
# instantly, with no reinstall. Re-run when you add, rename, or remove a
# standalone skill (re-running also prunes stale links).
# The ui-craft suite is copy-installed via its own installer, so re-run after changing
# the suite.
#
# Usage:
#   sh link.sh                             # link into ~/.claude/skills, ~/.codex/skills,
#                                          # and ~/.agents/skills — only where the parent
#                                          # (~/.claude, ~/.codex, ~/.agents) already exists
#   TARGET_DIR=/path/to/skills sh link.sh  # link into a single directory
#   FORCE=1 sh link.sh                     # replace entries that exist but are not symlinks
set -e

REPO_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

link_into() {
  target="$1"
  mkdir -p "$target"
  echo "==> $target"

  # Prune links into this repo whose skill has since been removed or renamed.
  for entry in "$target"/*; do
    { [ -L "$entry" ] && [ ! -e "$entry" ]; } || continue
    case "$(readlink "$entry")" in
      "$REPO_DIR"/skills/*)
        rm -f "$entry"
        echo "  pruned     $(basename "$entry")"
        ;;
    esac
  done

  # Symlink each standalone skill (any skills/<name>/ that contains a SKILL.md).
  for skill in "$REPO_DIR"/skills/*/; do
    [ -f "${skill}SKILL.md" ] || continue
    name="$(basename "$skill")"
    if [ -L "$target/$name" ]; then
      rm -f "$target/$name"
    elif [ -e "$target/$name" ]; then
      if [ "${FORCE:-}" = "1" ]; then
        rm -rf "$target/$name"
      else
        echo "  skipped    $name — exists and is not a symlink; move it aside or set FORCE=1"
        continue
      fi
    fi
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
  for parent in "$HOME/.claude" "$HOME/.codex" "$HOME/.agents"; do
    if [ -d "$parent" ]; then
      link_into "$parent/skills"
    else
      echo "==> $parent/skills skipped ($parent does not exist)"
    fi
  done
fi

echo "Done. Standalone skills are symlinked to the repo; edits are picked up automatically."
