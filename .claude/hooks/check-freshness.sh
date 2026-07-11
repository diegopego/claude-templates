#!/bin/sh
# PreToolUse hook (matcher: Bash). Blocks `git commit` when the staged set is
# inconsistent with the repo's freshness rules:
#   1. A charter source (templates/charters/sources/) is staged without the
#      composed charters — run the assemble-charters skill.
#   2. templates/ or ideas/ change without CHANGELOG.md staged.
#   3. An adopter-facing deliverable changes without the landing source
#      (root README.md) staged.
#   4. README.md changes without the rendered landing (docs/index.html)
#      staged — regenerate it from README.md.
# Exit 2 blocks the tool call and feeds stderr back to the agent.

set -eu

input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty' 2>/dev/null || true)
[ -n "$cmd" ] || exit 0

case "$cmd" in
  *"git commit"*) ;;
  *) exit 0 ;;
esac

cd "${CLAUDE_PROJECT_DIR:-.}"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

staged=$(git diff --cached --name-only)
[ -n "$staged" ] || exit 0

# Rule 1: editing a charter source requires the composed charters to be rebuilt
# and staged. Assembly is deterministic (tools/assemble.py), so when python3 is
# available the check is structural: regenerate and byte-compare against the
# staged composed files. Otherwise fall back to a staging-presence check.
if printf '%s\n' "$staged" | grep -q '^templates/charters/sources/'; then
  if command -v python3 >/dev/null 2>&1 && [ -f tools/assemble.py ]; then
    tmp=$(mktemp -d)
    trap 'rm -rf "$tmp"' EXIT
    if ! python3 tools/assemble.py --all --outdir "$tmp" >/dev/null 2>&1; then
      echo "Commit blocked: tools/assemble.py failed on the current sources — fix the sources or the script." >&2
      exit 2
    fi
    for composed in CHARTER_GREENFIELD.md CHARTER_LEGACY_TRANSFORMATION.md; do
      if ! git show ":templates/charters/$composed" > "$tmp/staged-$composed" 2>/dev/null \
         || ! cmp -s "$tmp/$composed" "$tmp/staged-$composed"; then
        {
          echo "Commit blocked: charter sources changed but the staged templates/charters/$composed does not match their composition."
          echo "Run 'make assemble', then stage templates/charters/."
        } >&2
        exit 2
      fi
    done
  else
    for composed in \
      templates/charters/CHARTER_GREENFIELD.md \
      templates/charters/CHARTER_LEGACY_TRANSFORMATION.md; do
      if ! printf '%s\n' "$staged" | grep -qx "$composed"; then
        {
          echo "Commit blocked: charter sources changed but $composed is not staged."
          echo "Run 'make assemble', then stage templates/charters/."
        } >&2
        exit 2
      fi
    done
  fi
fi

# Rule 2: templates/ or ideas/ changed without a changelog entry.
# ideas/inbox.md is the owner's scratchpad — jotting a note there does not
# warrant a changelog entry.
if printf '%s\n' "$staged" | grep -E '^(templates|ideas)/' | grep -qv '^ideas/inbox\.md$' \
   && ! printf '%s\n' "$staged" | grep -qx 'CHANGELOG.md'; then
  {
    echo "Commit blocked: templates/ or ideas/ changed but CHANGELOG.md is not staged."
    echo "Update CHANGELOG.md for this change, then stage it."
  } >&2
  exit 2
fi

# Rule 3: an adopter-facing deliverable (charters incl. sources, requirements,
# guides, skills) changed — the landing source (root README.md) must be
# revisited and staged in the same commit.
if printf '%s\n' "$staged" | grep -q '^templates/' \
   && ! printf '%s\n' "$staged" | grep -qx 'README.md'; then
  {
    echo "Commit blocked: adopter-facing deliverables changed but the landing source (README.md) is not staged."
    echo "Refresh README.md to reflect the change, then stage it."
  } >&2
  exit 2
fi

# Rule 4: README.md changed — the rendered landing served by GitHub Pages
# (docs/index.html) must be regenerated from it and staged alongside.
if printf '%s\n' "$staged" | grep -qx 'README.md' \
   && ! printf '%s\n' "$staged" | grep -qx 'docs/index.html'; then
  {
    echo "Commit blocked: README.md changed but the rendered landing (docs/index.html) is not staged."
    echo "Regenerate docs/index.html from README.md (skin stays fixed), then stage it."
  } >&2
  exit 2
fi

exit 0
