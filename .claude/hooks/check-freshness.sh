#!/bin/sh
# PreToolUse hook (matcher: Bash). Blocks `git commit` when the staged set is
# inconsistent with the repo's freshness rules:
#   1. A charter source (templates/charters/sources/) is staged without the
#      composed charters — run the assemble-charters skill.
#   2. templates/ or ideas/ change without CHANGELOG.md staged.
#   3. An adopter-facing deliverable changes without the landing page
#      (root README.md) staged.
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
# and staged (assembly is deterministic — regenerate with assemble-charters).
if printf '%s\n' "$staged" | grep -q '^templates/charters/sources/'; then
  for composed in \
    templates/charters/CHARTER_GREENFIELD.md \
    templates/charters/CHARTER_LEGACY_TRANSFORMATION.md; do
    if ! printf '%s\n' "$staged" | grep -qx "$composed"; then
      {
        echo "Commit blocked: charter sources changed but $composed is not staged."
        echo "Run the assemble-charters skill, then stage templates/charters/."
      } >&2
      exit 2
    fi
  done
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
# guides, skills) changed — the landing page (root README.md) must be
# revisited and staged in the same commit.
if printf '%s\n' "$staged" | grep -q '^templates/' \
   && ! printf '%s\n' "$staged" | grep -qx 'README.md'; then
  {
    echo "Commit blocked: adopter-facing deliverables changed but the landing page (README.md) is not staged."
    echo "Refresh README.md to reflect the change, then stage it."
  } >&2
  exit 2
fi

exit 0
