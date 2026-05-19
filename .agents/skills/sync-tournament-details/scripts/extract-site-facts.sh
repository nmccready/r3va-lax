#!/usr/bin/env bash
# Read-only: print every line in `mentioned_in` files that references a given
# tournament key from manifest.yaml. Used by the agent as the "current site
# state" half of the drift diff.
#
# Usage: extract-site-facts.sh <tournament-key>
#   e.g. extract-site-facts.sh legends-richmond-rumble

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
REPO_ROOT="$(cd "$SKILL_DIR/../../.." && pwd)"

usage() {
  echo "Usage: $(basename "$0") <tournament-key>" >&2
  echo "  Available keys (from manifest.yaml):" >&2
  awk '/^  - key:/ { print "    " $3 }' "$SKILL_DIR/manifest.yaml" >&2
  exit 2
}

[ $# -eq 1 ] || usage
key="$1"

# Tournament-key → search patterns. Keep the patterns broad enough to catch
# renames in either direction (e.g. "Legends Rumble" without "Richmond").
case "$key" in
  legends-eastern-invitational)
    pattern='Legends.*Eastern|Eastern Invitational|Invitational.*Jun|Jun 27.28|June 27.28'
    ;;
  freedom-lax-fest)
    pattern='Freedom Lax|Lax Fest|Havelock|Jul 11.12|July 11.12'
    ;;
  rivercity-sportsplex)
    pattern='RiverCity|River City|SportsPlex'
    ;;
  *)
    echo "Unknown key: $key" >&2
    usage
    ;;
esac

cd "$REPO_ROOT"

# Pull `mentioned_in:` paths for this key out of the YAML without a YAML parser.
# Awk walks the manifest, switches into "active" mode when it sees our key, and
# emits lines from the mentioned_in list until it hits the next top-level item.
files=$(awk -v target="$key" '
  /^  - key:/ { active = ($3 == target) ? 1 : 0; in_mentioned = 0; next }
  active && /^    mentioned_in:/ { in_mentioned = 1; next }
  active && in_mentioned && /^      - / { print $2; next }
  active && in_mentioned && /^    [a-z]/ { in_mentioned = 0 }
' "$SKILL_DIR/manifest.yaml")

if [ -z "$files" ]; then
  echo "No mentioned_in files for key '$key' in manifest.yaml" >&2
  exit 1
fi

echo "# Site references to '$key'"
echo "# Pattern: $pattern"
echo
for f in $files; do
  if [ ! -f "$f" ]; then
    echo "## $f  (MISSING)"
    continue
  fi
  matches=$(grep -nE "$pattern" "$f" || true)
  if [ -n "$matches" ]; then
    echo "## $f"
    echo "$matches"
    echo
  fi
done
