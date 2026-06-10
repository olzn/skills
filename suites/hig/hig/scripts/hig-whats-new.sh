#!/bin/sh
# hig-whats-new.sh [--probe] [snapshot-date] — diff Apple's design change log against
# the suite snapshot. Primary: scrape https://developer.apple.com/design/whats-new/.
# Fallback (--probe): compare customMetadata alert dates of the ~10 hot slugs.
# Cross-references changed slugs against src: tags to name derived files needing review.
# Exit: 0 ok · 1 usage/network · 2 PARSE FAIL (result UNKNOWN — never "no changes").
# Deps: curl, jq, python3 (stdlib only). POSIX sh.

set -u
DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
REFS="$DIR/../references"
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15"
PROBE=0 SNAP=""
for arg in "$@"; do
  case "$arg" in
    --probe) PROBE=1 ;;
    [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) SNAP="$arg" ;;
    *) echo "usage: hig-whats-new.sh [--probe] [snapshot-date YYYY-MM-DD]" >&2; exit 1 ;;
  esac
done
if [ -z "$SNAP" ]; then
  SNAP=$(sed -n 's/.*hig-snapshot: *\([0-9][0-9-]*\).*/\1/p' "$REFS/versions.md" 2>/dev/null | head -1)
  [ -n "$SNAP" ] || { echo "ERROR: no snapshot date given and none readable from $REFS/versions.md" >&2; exit 1; }
fi
TMP="$(mktemp)" || exit 1
trap 'rm -f "$TMP"' EXIT INT TERM

fetch() { # $1=url → body in $TMP, status in $CODE; retries with backoff on 429/5xx
  CODE=000
  for delay in 0 2 4; do
    [ "$delay" -gt 0 ] && sleep "$delay"
    CODE=$(curl -sS -m 30 -A "$UA" -o "$TMP" -w '%{http_code}' "$1" 2>/dev/null) || CODE=000
    case "$CODE" in 429|5??) continue ;; *) return ;; esac
  done
}

crossref() { # $@ = changed HIG slugs → derived files carrying their src: tags
  [ $# -eq 0 ] && return 0
  printf '\n== Derived files needing review (src: tags under hig/references/) ==\n'
  for slug in "$@"; do
    files=$(grep -rl "src:.*$slug" "$REFS" 2>/dev/null)
    if [ -n "$files" ]; then
      echo "$slug:"; printf '%s\n' "$files" | sed "s|^$REFS/|  |"
    else
      echo "$slug: no derived files tagged — check whether the corpus needs a new section"
    fi
  done
}

if [ "$PROBE" = 1 ]; then
  HOT="tab-bars toolbars search-fields sidebars buttons color app-icons materials scroll-views menus"
  echo "== Probe: customMetadata alert dates vs snapshot $SNAP =="
  parsed=0; changed=""
  for slug in $HOT; do
    fetch "https://developer.apple.com/tutorials/data/design/human-interface-guidelines/$slug.json"
    alert=""
    [ "$CODE" = 200 ] && alert=$(jq -r '.metadata.customMetadata["alert-date"] // empty' "$TMP" 2>/dev/null)
    [ -n "$alert" ] || { echo "$slug: UNREADABLE (HTTP $CODE)"; continue; }
    parsed=$((parsed + 1))
    if expr "$alert" ">" "$SNAP" >/dev/null; then
      echo "$slug: CHANGED $alert — $(jq -r '.metadata.customMetadata["alert-text"] // "?"' "$TMP")"
      changed="$changed $slug"
    else
      echo "$slug: unchanged (last alert $alert)"
    fi
  done
  [ "$parsed" -gt 0 ] || { echo "PARSE FAIL: 0 readable alert dates across hot slugs — endpoint or schema drift; result is UNKNOWN, not 'no changes'" >&2; exit 2; }
  crossref $changed
  exit 0
fi

fetch "https://developer.apple.com/design/whats-new/"
[ "$CODE" = 200 ] || { echo "ERROR: HTTP $CODE fetching design/whats-new (after retries)" >&2; exit 1; }
OUT=$(python3 - "$TMP" "$SNAP" <<'PYEOF'
import re, sys
html = open(sys.argv[1], encoding="utf-8", errors="replace").read()
snap = sys.argv[2]
MONTHS = {m: i + 1 for i, m in enumerate(("January February March April May June "
          "July August September October November December").split())}
entries = []
for block in re.findall(r'<tr class="topic-item">(.*?)</tr>', html, re.S):
    d = re.search(r'class="topic-date">\s*([^<]+?)\s*<', block)
    a = re.search(r'<a href="([^"]+)"[^>]*>(.*?)</a>', block, re.S)
    if not (d and a):
        continue
    norm = " ".join(d.group(1).split())  # normalise double-space dates: 'June  8' -> 'June 8'
    m = re.match(r'([A-Za-z]+) (\d{1,2}), (\d{4})$', norm)
    if not m or m.group(1) not in MONTHS:
        continue
    iso = "%s-%02d-%02d" % (m.group(3), MONTHS[m.group(1)], int(m.group(2)))
    k = re.search(r'class="topic-data">([^<]*)<', block)
    kind = (k.group(1) if k else "").replace("searchterm", "").strip().lower() or "?"
    href = a.group(1).split("#")[0].split("?")[0].rstrip("/")
    title = " ".join(re.sub(r"<[^>]+>", "", a.group(2)).split())
    desc = re.search(r'topic-description">(.*?)</span>', block, re.S)
    ref = href.rsplit("/", 1)[-1] if "/human-interface-guidelines/" in href else href
    entries.append((iso, kind, ref, title,
                    " ".join(re.sub(r"<[^>]+>", "", desc.group(1)).split()) if desc else ""))
if not entries:  # hard parse assertion — empty result means broken scraper, not a quiet site
    print("PARSE FAIL: 0 dated entries parsed from design/whats-new — page markup changed; "
          "result is UNKNOWN, not 'no changes'", file=sys.stderr)
    sys.exit(2)
new = sorted((e for e in entries if e[0] > snap), reverse=True)
print("== design/whats-new entries since %s (parsed %d dated entries) ==" % (snap, len(entries)))
if not new:
    print("No entries newer than %s — parse OK (%d older entries seen)." % (snap, len(entries)))
    sys.exit(0)
for iso, kind, ref, title, desc in new:
    print("%s  %-9s %-26s %s — %s" % (iso, kind, ref, title, desc))
slugs = sorted({e[2] for e in new if e[1] == "guidance" and "/" not in e[2]})
if slugs:
    print("slugs: " + " ".join(slugs))
PYEOF
)
rc=$?
printf '%s\n' "$OUT"
[ "$rc" -eq 0 ] || exit "$rc"
crossref $(printf '%s\n' "$OUT" | sed -n 's/^slugs: //p')
