#!/bin/sh
# hig-fetch.sh <slug> — fetch one HIG page via Apple's DocC JSON API and render
# headings/paragraphs/lists/tables to markdown on stdout.
# Exit: 0 ok · 1 usage/network · 3 bad payload · 4 slug not found (likely rename).
# Deps: curl, jq, python3 (stdlib only). POSIX sh.

set -u
SLUG="${1:-}"
[ -n "$SLUG" ] || { echo "usage: hig-fetch.sh <slug>  (e.g. hig-fetch.sh tab-bars)" >&2; exit 1; }
BASE="https://developer.apple.com/tutorials/data/design/human-interface-guidelines"
URL="$BASE/$SLUG.json"
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Safari/605.1.15"
TMP="$(mktemp)" || exit 1
trap 'rm -f "$TMP"' EXIT INT TERM

# Retry with backoff (sleep 2, 4) on 429/5xx; other codes return immediately.
CODE=000
for delay in 0 2 4; do
  [ "$delay" -gt 0 ] && sleep "$delay"
  CODE=$(curl -sS -m 30 -A "$UA" -o "$TMP" -w '%{http_code}' "$URL" 2>/dev/null) || CODE=000
  case "$CODE" in 429|5??) continue ;; *) break ;; esac
done

case "$CODE" in
  200) : ;;
  404) echo "ERROR: HTTP 404 for slug '$SLUG' — page may have been renamed; re-fetch the root TOC ($BASE.json) and search its references for the new slug" >&2
       exit 4 ;;
  000) echo "ERROR: network failure fetching $URL (curl failed after retries)" >&2; exit 1 ;;
  *)   echo "ERROR: HTTP $CODE for $URL after retries" >&2; exit 1 ;;
esac

jq -e . "$TMP" >/dev/null 2>&1 \
  || { echo "ERROR: response for '$SLUG' is not valid JSON (API markup drift?)" >&2; exit 3; }
jq -e '.primaryContentSections' "$TMP" >/dev/null 2>&1 \
  || { echo "ERROR: '$SLUG' JSON has no .primaryContentSections (schema changed or non-article page)" >&2; exit 3; }

python3 - "$TMP" <<'PYEOF'
import json, sys

doc = json.load(open(sys.argv[1]))
refs = doc.get("references", {})

def inline(nodes):
    out = []
    for n in nodes or []:
        t = n.get("type")
        if t == "text":
            out.append(n.get("text", ""))
        elif t == "codeVoice":
            out.append("`%s`" % n.get("code", ""))
        elif t == "strong":
            out.append("**%s**" % inline(n.get("inlineContent")))
        elif t == "emphasis":
            out.append("*%s*" % inline(n.get("inlineContent")))
        elif t == "reference":
            r = refs.get(n.get("identifier", ""), {})
            out.append(n.get("overridingTitle") or r.get("title")
                       or n.get("identifier", "").rsplit("/", 1)[-1])
        elif n.get("inlineContent"):  # newTerm etc.; images carry no text
            out.append(inline(n["inlineContent"]))
    return "".join(out)

def block_text(blocks):
    return " ".join(inline(b.get("inlineContent")) for b in blocks or []
                    if b.get("type") == "paragraph").strip()

def walk(blocks, depth=0):
    pad = "  " * depth
    for b in blocks or []:
        t = b.get("type")
        if t == "heading":
            print("\n" + "#" * max(b.get("level", 2), 1) + " " + b.get("text", ""))
        elif t == "paragraph":
            txt = inline(b.get("inlineContent"))
            if txt.strip():
                print("\n" + pad + txt if not depth else pad + txt)
        elif t in ("unorderedList", "orderedList"):
            print("")
            for i, item in enumerate(b.get("items", []), 1):
                bullet = "-" if t == "unorderedList" else "%d." % i
                print("%s%s %s" % (pad, bullet, block_text(item.get("content"))))
                rest = [c for c in item.get("content", [])
                        if c.get("type") != "paragraph"]
                walk(rest, depth + 1)
        elif t == "termList":
            print("")
            for item in b.get("items", []):
                term = inline(item.get("term", {}).get("inlineContent"))
                print("%s- **%s** — %s" % (pad, term,
                      block_text(item.get("definition", {}).get("content"))))
        elif t == "aside":
            print("\n> **%s:** %s" % (b.get("name") or b.get("style", "Note"),
                                      block_text(b.get("content"))))
        elif t == "table":
            rows = b.get("rows", [])
            if rows:
                print("")
                for i, row in enumerate(rows):
                    cells = [block_text(cell) for cell in row]
                    print(pad + "| " + " | ".join(cells) + " |")
                    if i == 0 and b.get("header") == "row":
                        print(pad + "|" + "---|" * len(cells))
        elif t == "row":  # column layout — flatten
            for col in b.get("columns", []):
                walk(col.get("content"), depth)

meta = doc.get("metadata", {})
custom = meta.get("customMetadata", {})
print("# %s" % meta.get("title", "?"))
print("<!-- alert-date: %s · alert: %s · platforms: %s -->" % (
    custom.get("alert-date", "?"), custom.get("alert-text", "?"),
    custom.get("supported-platforms", "?")))
abstract = inline(doc.get("abstract"))
if abstract:
    print("\n" + abstract)
for section in doc.get("primaryContentSections", []):
    if section.get("kind") == "content":
        walk(section.get("content"))
PYEOF
