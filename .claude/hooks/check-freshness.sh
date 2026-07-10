#!/bin/sh
# PreToolUse hook (matcher: Bash). Blocks `git commit` when the staged set is
# inconsistent with the repo's freshness rules:
#   1. A charter source (templates/charters/sources/) is staged without the
#      composed charters — run the assemble-charters skill.
#   2. An English template is staged without its pt-BR counterpart.
#   3. templates/ or ideas/ change without any changelog/ update.
# Charter sources are inputs, not deliverables: they are not translated and
# are excluded from rule 2. Exit 2 blocks the tool call and feeds stderr back
# to the agent.

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
        echo "Run the assemble-charters skill, then stage templates/charters/ (and re-translate)."
      } >&2
      exit 2
    fi
  done
fi

# Rule 2: an English deliverable staged without its pt-BR counterpart. Charter
# sources are build inputs, not deliverables — they are not translated.
missing=""
for f in $(printf '%s\n' "$staged" | grep -E '^templates/.*\.md$' | grep -v '^templates/i18n/' | grep -v '^templates/charters/sources/' || true); do
  pt="templates/i18n/pt-BR/${f#templates/}"
  if ! printf '%s\n' "$staged" | grep -qx "$pt"; then
    missing="$missing
  $f -> $pt"
  fi
done

if [ -n "$missing" ]; then
  {
    echo "Commit blocked: English templates staged without their pt-BR counterparts:$missing"
    echo "Run the translate-templates skill, then stage templates/i18n/pt-BR/ alongside the sources."
  } >&2
  exit 2
fi

# ideas/inbox.md is the owner's scratchpad — jotting a note there does not
# warrant a changelog entry.
if printf '%s\n' "$staged" | grep -E '^(templates|ideas)/' | grep -qv '^ideas/inbox\.md$' \
   && ! printf '%s\n' "$staged" | grep -q '^changelog/'; then
  {
    echo "Commit blocked: templates/ or ideas/ changed but no changelog/ file is staged."
    echo "Update changelog/maintainer.md and changelog/adopter.md for this change, then stage them."
  } >&2
  exit 2
fi

exit 0
