#!/bin/sh
# hig-scan.sh — thin grep/awk candidate scanner for the HIG suite (spec D12).
# hig-snapshot: 2026-06-10 · baseline: iOS 26.x / macOS 26.x · src: _practice, _precedents, components-selection-input
# Layer-1 recall only (lightscape two-layer pattern): every row is a CANDIDATE for
# model judgment against hig/references/checklists/ — never a finding. Tiers are
# provisional: 1 rejection-risk · 2 feels-broken · 3 feels-non-native.
# Positive compliance markers: a line containing hig-ok or data-native-emulation is
# never flagged; per-rule suppressors (e.g. relativeTo:, --token: definitions) below.
# Known nets it does NOT cast: rem/em type sizes, multi-line CSS selectors, glass in
# the content layer, copy/flow issues — the checklists cover those by reading.
# Usage: hig-scan.sh <path> [swiftui|html|auto]   (default auto)
ROOT=${1:?usage: hig-scan.sh <path> [swiftui|html|auto]}
MEDIUM=${2:-auto}
[ -e "$ROOT" ] || { echo "hig-scan: no such path: $ROOT" >&2; exit 2; }
case $MEDIUM in swiftui|html|auto) ;; *) echo "hig-scan: medium must be swiftui|html|auto" >&2; exit 2 ;; esac

# emit <id> <tier> <extra-suppress-ERE|''> — format grep "file:line:text" as table rows
emit() {
  awk -v id="$1" -v tier="$2" -v skip="$3" '
    /hig-ok|data-native-emulation/ { next }
    skip != "" && $0 ~ skip { next }
    { split($0, a, ":")
      sub(/^[^:]*:[^:]*:[[:space:]]*/, "")
      if (length($0) > 56) $0 = substr($0, 1, 53) "..."
      printf "%-14s | %s | %s:%s | %s\n", id, tier, a[1], a[2], $0 }'
}
# g <id> <tier> <pattern> <suppress|''> <find -name args...> — per-line presence rule
g() {
  _i=$1; _t=$2; _p=$3; _s=$4; shift 4
  find "$ROOT" -type f \( "$@" \) -exec grep -nE "$_p" /dev/null {} + 2>/dev/null | emit "$_i" "$_t" "$_s"
}
# absent <id> <tier> <pattern> <message> <find -name args...> — per-file absence rule
absent() {
  _i=$1; _t=$2; _p=$3; _m=$4; shift 4
  find "$ROOT" -type f \( "$@" \) -exec grep -LE "$_p" {} + 2>/dev/null \
    | awk -v id="$_i" -v tier="$_t" -v msg="$_m" '{ printf "%-14s | %s | %s:- | %s\n", id, tier, $0, msg }'
}
# tree_absent — same, but one row only if NO file in the whole target matches
tree_absent() {
  _i=$1; _t=$2; _p=$3; _m=$4; shift 4
  n=$(find "$ROOT" -type f \( "$@" \) -exec grep -lE "$_p" {} + 2>/dev/null | awk 'END { print NR }')
  [ "${n:-0}" -eq 0 ] && printf '%-14s | %s | %s:- | %s\n' "$_i" "$_t" "$ROOT" "$_m"
}

DO_HTML=0; DO_SWIFT=0
case $MEDIUM in
  html) DO_HTML=1 ;;
  swiftui) DO_SWIFT=1 ;;
  auto)
    [ "$(find "$ROOT" -type f \( -name '*.html' -o -name '*.htm' -o -name '*.css' \) 2>/dev/null | awk 'END{print NR}')" -gt 0 ] && DO_HTML=1
    [ "$(find "$ROOT" -type f \( -name '*.swift' -o -name '*.plist' \) 2>/dev/null | awk 'END{print NR}')" -gt 0 ] && DO_SWIFT=1 ;;
esac

echo "hig-scan ($MEDIUM): CANDIDATES, NOT FINDINGS — judge each against the checklists"
echo "RULE-ID        | tier | file:line | excerpt"

if [ "$DO_HTML" = 1 ]; then
  # Web idioms leaking into iOS-targeting prototypes. src: components-selection-input (toggles, pickers), _precedents §1.6 (neonwatty), _practice §1
  g HTML-SELECT 2 '<select[ >]' '' -name '*.html' -o -name '*.htm'
  g HTML-INPUT  2 'type="(checkbox|radio)"' '' -name '*.html' -o -name '*.htm'
  g HTML-BURGER 2 '(class|id)="[^"]*(hamburger|burger)[^"]*"|☰|&#9776;' '' -name '*.html' -o -name '*.htm' -o -name '*.css'
  g HTML-FAB    3 '(class|id)="[^"]*fab[^"]*"|floating-action' '' -name '*.html' -o -name '*.htm' -o -name '*.css'
  # Hard-coded values where semantic tokens expected. src: _practice §1 (dark mode, typography); --token: definition lines are the one legal home
  g HTML-GRAY 3 '#(666|777|888|999|808080|8[eE]8[eE]93|[aA]{3}|[bB]{3}|[cC]{3}|[dD]{3})' '\-\-[a-z-]*:' -name '*.css' -o -name '*.html'
  g HTML-TYPE 2 'font-size:[[:space:]]*(1[0-6]|[0-9])(\.[0-9]+)?px' '' -name '*.css' -o -name '*.html'
  # Native-feel scaffolding every iOS-targeting prototype needs. src: _practice §4 (HTML prototype checklist)
  absent HTML-VIEWPORT 2 'viewport-fit=cover' 'no viewport-fit=cover in viewport meta' -name '*.html' -o -name '*.htm'
  tree_absent HTML-SAFEAREA 2 'env\(safe-area-inset' 'env(safe-area-inset-*) used nowhere in target' -name '*.css' -o -name '*.html' -o -name '*.htm'
  tree_absent HTML-TAPHL 3 'webkit-tap-highlight-color' '-webkit-tap-highlight-color never cleared' -name '*.css' -o -name '*.html' -o -name '*.htm'
  # Fixed px heights on bar-like selectors (bars are content-driven, safe-area aware). src: _practice §1, §4
  find "$ROOT" -type f \( -name '*.css' -o -name '*.html' \) -exec awk '
    /hig-ok/ { next }
    /\{/ { sel = $0 }
    /(^|[^-])height:[[:space:]]*[0-9]+px/ && (sel ~ /(bar|nav|tab|header|footer|toolbar|dock)/ || $0 ~ /(bar|nav|tab|header|footer|toolbar|dock)/) {
      t = $0; gsub(/^[[:space:]]+/, "", t); if (length(t) > 53) t = substr(t, 1, 50) "..."
      printf "%-14s | 3 | %s:%d | %s\n", "HTML-BARPX", FILENAME, FNR, t }' {} \;
fi

if [ "$DO_SWIFT" = 1 ]; then
  # Liquid Glass mechanics. src: _practice §3, _precedents §2.3 (orchard G1/G2)
  g SW-BAR-BG 3 '\.toolbarBackground\(|UI(TabBar|NavigationBar|Toolbar)\.appearance\(\)' '' -name '*.swift'
  g SW-COMPAT 3 'UIDesignRequiresCompatibility' '' -name '*.swift' -o -name '*.plist'
  # Hard-coded colour and type vs semantic + Dynamic Type. src: _practice §1, _precedents §2.3 (orchard A2/C1/D1), §1.3 (lightscape TYP-01)
  g SW-COLOR 3 'Color\.(gray|black|white)([^A-Za-z]|$)|Color\((red|white):|foreground(Color|Style)\(\.(gray|black|white)\)' '' -name '*.swift'
  g SW-FONT  2 '\.font\(\.system\(size:' 'relativeTo:' -name '*.swift'
  # Navigation patterns + hit areas (<28pt fails even the macOS floor; iOS minimum is 44pt — judge per platform). src: _practice §1, components-selection-input bucket-wide
  g SW-NAVHIDE 2 'navigationBarHidden|navigationBarBackButtonHidden' '' -name '*.swift'
  g SW-NAVVIEW 3 'NavigationView[ ({]' '' -name '*.swift'
  g SW-HIT 2 '\.frame\([^)]*([wW]idth|[hH]eight): *(2[0-7]|1[0-9]|[0-9])(\.[0-9]+)?[ ,)]' '' -name '*.swift'
  # Motion + system-API hygiene. src: _practice §1 (Reduce Motion), spec D5 tier-1 list (ratings), spec D12 rule list (SiriKit→App Intents)
  g SW-MOTION 3 '\.repeatForever\(' 'educeMotion' -name '*.swift'
  g SW-RATING 1 'SKStoreReviewController|requestReview' '' -name '*.swift'
  g SW-SIRI   3 'import +Intents(UI)?$|INIntent' '' -name '*.swift'
  # Per-file glass grouping + hit-shape pairing. src: _practice §3 (GlassEffectContainer, contentShape)
  find "$ROOT" -type f -name '*.swift' -exec awk '
    /hig-ok/ { next }
    /\.glassEffect\(/ { n++; if (!f) f = FNR }
    /GlassEffectContainer/ { gc = 1 }
    /\.contentShape\(/ { cs = 1 }
    END {
      if (n >= 2 && !gc) printf "%-14s | 2 | %s:%d | %d glassEffect, no GlassEffectContainer\n", "SW-GLASS-GROUP", FILENAME, f, n
      if (n >= 1 && !cs) printf "%-14s | 2 | %s:%d | glassEffect without contentShape (taps hit label only)\n", "SW-GLASS-HIT", FILENAME, f
    }' {} \;
fi
exit 0
