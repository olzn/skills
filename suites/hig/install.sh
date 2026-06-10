#!/bin/sh
# Installs the HIG skill suite into a Codex, Claude Code, or project skills directory.
#
# The three skills install as SIBLING directories; hig-design and hig-review read the
# shared references via ../hig/references/ (single copy — see repo spec D14). Do not
# install them separately.

set -e

REPO_TARBALL="https://github.com/olzn/skills/archive/refs/heads/main.tar.gz"
TARGET_DIR="${TARGET_DIR:-${CODEX_HOME:-$HOME/.codex}/skills}"
SKILLS="hig hig-design hig-review"

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd 2>/dev/null || echo "")"
TMP_DIR=""
PRESERVE_DIR=""

cleanup() {
  if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR"
  fi
  if [ -n "$PRESERVE_DIR" ] && [ -d "$PRESERVE_DIR" ]; then
    rm -rf "$PRESERVE_DIR"
  fi
}

trap cleanup EXIT INT TERM

if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/hig/references" ]; then
  SRC_ROOT="$SCRIPT_DIR"
else
  TMP_DIR="${TMPDIR:-/tmp}/hig-install-$$"
  mkdir -p "$TMP_DIR"
  curl -fsSL "$REPO_TARBALL" | tar -xz -C "$TMP_DIR"
  SRC_ROOT="$TMP_DIR/skills-main/suites/hig"
fi

copy_dir() {
  src="$1"
  dest="$2"
  preserved_learnings=""

  if [ -f "$dest/learnings.md" ]; then
    if [ -z "$PRESERVE_DIR" ]; then
      PRESERVE_DIR="${TMPDIR:-/tmp}/hig-preserve-$$"
      mkdir -p "$PRESERVE_DIR"
    fi
    preserved_learnings="$PRESERVE_DIR/$(basename "$dest").learnings.md"
    cp "$dest/learnings.md" "$preserved_learnings"
  fi

  rm -rf "$dest"
  mkdir -p "$(dirname "$dest")"
  cp -R "$src" "$dest"

  if [ -n "$preserved_learnings" ] && [ -f "$preserved_learnings" ]; then
    cp "$preserved_learnings" "$dest/learnings.md"
  fi

  printf '  %s/\n' "$dest"
}

echo "Installing HIG suite skills to $TARGET_DIR ..."
mkdir -p "$TARGET_DIR"

for skill in $SKILLS; do
  copy_dir "$SRC_ROOT/$skill" "$TARGET_DIR/$skill"
done

# Runtime scripts ship inside hig/scripts/ (copied with the skill above);
# ensure they are executable.
chmod +x "$TARGET_DIR"/hig/scripts/*.sh 2>/dev/null || true

# Sanity: sibling references must resolve.
if [ ! -f "$TARGET_DIR/hig/references/versions.md" ]; then
  echo "WARNING: hig/references/versions.md missing — hig-design and hig-review will not find shared references." >&2
  exit 1
fi

echo "Done. Snapshot date: $(grep -o 'hig-snapshot: [0-9-]*' "$TARGET_DIR/hig/references/versions.md" | head -1)"
