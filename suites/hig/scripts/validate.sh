#!/bin/sh
# Structural validation for the HIG suite. Run from anywhere; operates on the suite dir.
# Checks layout, budgets, contract headers, anchors, src-tag integrity, sibling paths,
# delta-block discipline, and (network permitting) one live API smoke test.

SUITE_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
REFS="$SUITE_DIR/hig/references"
# Counters via files: several checks run in pipe subshells where $((…)) is lost.
CNT_DIR="$(mktemp -d)"
trap 'rm -rf "$CNT_DIR"' EXIT INT TERM
fail() { echo "FAIL: $1"; echo x >> "$CNT_DIR/fail"; }
warn() { echo "warn: $1"; echo x >> "$CNT_DIR/warn"; }

# --- 1. Required files -------------------------------------------------------
for f in \
  hig/SKILL.md hig/learnings.md hig-design/SKILL.md hig-design/learnings.md \
  hig-review/SKILL.md hig-review/learnings.md \
  hig/references/versions.md hig/references/index.md hig/references/doctrine.md \
  hig/references/corrections.md hig/references/trees-containers.md \
  hig/references/trees-controls.md hig/references/adaptation.md \
  hig/scripts/hig-fetch.sh hig/scripts/hig-whats-new.sh hig/scripts/hig-scan.sh \
  hig/scripts/refresh-workflow.md install.sh README.md
do
  [ -f "$SUITE_DIR/$f" ] || fail "missing $f"
done
for d in hig/references/corpus hig/references/checklists hig/references/tables hig/references/adapters; do
  [ -d "$SUITE_DIR/$d" ] || fail "missing dir $d"
done

# --- 2. Frontmatter ----------------------------------------------------------
for s in hig hig-design hig-review; do
  md="$SUITE_DIR/$s/SKILL.md"
  [ -f "$md" ] || continue
  head -1 "$md" | grep -q '^---$' || fail "$s/SKILL.md: no frontmatter"
  grep -q "^name: $s$" "$md" || fail "$s/SKILL.md: frontmatter name != $s"
  desc_len=$(awk '/^description:/{print length($0); exit}' "$md")
  [ "${desc_len:-0}" -gt 0 ] || fail "$s/SKILL.md: no description"
  [ "${desc_len:-0}" -le 1024 ] || fail "$s/SKILL.md: description ${desc_len} chars (>1024)"
done

# --- 3. Budgets (bytes ~ 4x tokens) -----------------------------------------
check_budget() { # file max label
  [ -f "$1" ] || return 0
  size=$(wc -c < "$1" | tr -d ' ')
  [ "$size" -le "$2" ] || fail "$3 over budget: $size > $2 bytes ($1)"
}
for f in "$REFS"/corpus/*.md;     do check_budget "$f" 14336 "corpus";    done
for f in "$REFS"/checklists/*.md; do check_budget "$f" 10240 "checklist"; done
for f in "$REFS"/adapters/*.md;   do check_budget "$f" 8192  "adapter";   done
check_budget "$REFS/index.md"            6144 "index"
check_budget "$REFS/doctrine.md"         8192 "doctrine"
check_budget "$REFS/trees-containers.md" 8192 "tree"
check_budget "$REFS/trees-controls.md"   8192 "tree"
check_budget "$REFS/adaptation.md"       8192 "adaptation"

# --- 4. Contract headers + corpus anchors ------------------------------------
for f in "$REFS"/corpus/*.md "$REFS"/checklists/*.md "$REFS"/tables/*.md "$REFS"/adapters/*.md \
         "$REFS/doctrine.md" "$REFS/corrections.md" "$REFS/trees-containers.md" \
         "$REFS/trees-controls.md" "$REFS/adaptation.md" "$REFS/versions.md"; do
  [ -f "$f" ] || continue
  head -2 "$f" | grep -q 'hig-snapshot:' || fail "no hig-snapshot header: $f"
done
for f in "$REFS"/corpus/*.md; do
  [ -f "$f" ] || continue
  n_sections=$(grep -c '^## ' "$f")
  n_src=$(grep -c '<!-- src: ' "$f")
  [ "$n_src" -ge "$n_sections" ] || warn "$(basename "$f"): $n_sections sections but $n_src src comments"
  grep -n '^## ' "$f" | grep -vE '^[0-9]+:## [a-z0-9][a-z0-9-]*$' | while read -r line; do
    warn "$(basename "$f"): non-slug section header: $line"
  done
done

# --- 5. src: tag targets exist ----------------------------------------------
grep -rho 'src: tables/[a-z-]*\.md' "$REFS"/checklists/ 2>/dev/null | sort -u | sed 's/^src: //' | while read -r t; do
  [ -f "$REFS/$t" ] || fail "checklist cites missing table: $t"
done

# --- 6. Sibling references resolve -------------------------------------------
for s in hig-design hig-review; do
  grep -q '\.\./hig/references/' "$SUITE_DIR/$s/SKILL.md" || warn "$s/SKILL.md never references ../hig/references/"
done
grep -rho '\.\./hig/references/[a-zA-Z0-9_/.-]*\.md' "$SUITE_DIR"/hig-design/SKILL.md "$SUITE_DIR"/hig-review/SKILL.md 2>/dev/null \
  | sort -u | sed 's|^\.\./hig/||' | while read -r p; do
  [ -f "$SUITE_DIR/hig/$p" ] || fail "SKILL.md references missing file: hig/$p"
done

# --- 7. 27-beta delta discipline ----------------------------------------------
# 27 mentions must sit in a 'promote on GA' delta block OR carry explicit gating
# language (version-gated press claim, factual version-history notes).
grep -rln 'iOS 27\|macOS 27\|Golden Gate' "$REFS"/corpus/ 2>/dev/null | while read -r f; do
  ungated=$(grep -n 'iOS 27\|macOS 27\|Golden Gate' "$f" \
    | grep -iv 'promote on GA\|version-gated\|press\|jumped\|generation\|valid for the 26\|<!-- src:' || true)
  [ -z "$ungated" ] || warn "$(basename "$f") has ungated 27/Golden Gate mention(s): $(echo "$ungated" | head -1 | cut -c1-80)"
done

# --- 8. Live smoke test (skips gracefully offline) ----------------------------
if command -v curl >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
  body=$(curl -fsS -m 10 -A "Mozilla/5.0 (Macintosh) hig-suite-validate" \
    "https://developer.apple.com/tutorials/data/design/human-interface-guidelines/buttons.json" 2>/dev/null)
  if [ -n "$body" ]; then
    echo "$body" | jq -e '.primaryContentSections' >/dev/null 2>&1 \
      || fail "live smoke: buttons.json fetched but schema changed (.primaryContentSections missing)"
  else
    warn "live smoke skipped (no network or fetch failed)"
  fi
else
  warn "live smoke skipped (curl/jq unavailable)"
fi

echo "----"
FAILS=$([ -f "$CNT_DIR/fail" ] && wc -l < "$CNT_DIR/fail" | tr -d ' ' || echo 0)
WARNS=$([ -f "$CNT_DIR/warn" ] && wc -l < "$CNT_DIR/warn" | tr -d ' ' || echo 0)
echo "validate: $FAILS failure(s), $WARNS warning(s)"
[ "$FAILS" -eq 0 ] || exit 1
