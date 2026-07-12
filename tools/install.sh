#!/bin/sh
# Deterministic file layer for the claude-templates adoption skill.
#
#   tools/install.sh new     DEST CHARTER MODULES
#   tools/install.sh adopt   DEST MODULES KEEPS
#   tools/install.sh upgrade DEST                   (installs nothing — it is a read)
#
# This script performs FILE OPERATIONS ONLY. Every judgment — which charter fits,
# which modules a project wants, what each section's disposition is, which
# conflicts to raise — belongs to the `adopt-template` skill, which runs in a
# session *in this repository* with the target as an additional working directory
# and calls this script once the owner has approved the plan.
#
# There is no delivery kit: nothing is copied into a target only to be torn down
# again. What lands in a project is exactly what that project keeps.
#
# Never overwrites an existing file (except the explicit self-adoption refresh).

set -eu

REPO=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
MODE=${1:-}
DEST=${2:-}
ARG3=${3:-}
ARG4=${4:-}

fail() { echo "error: $*" >&2; exit 1; }
note() { echo "  $*"; }

[ -n "$MODE" ] || fail "mode missing (new|adopt|upgrade)"
[ -n "$DEST" ] || fail "DEST is required"

# A DEST passed through from a Makefile or a skill can arrive with a literal ~.
case "$DEST" in
  "~")   DEST=$HOME ;;
  "~/"*) DEST=$HOME/${DEST#"~/"} ;;
esac

install_file() { # src dst [force]
  if [ -e "$2" ]; then
    if [ "${3:-}" = force ]; then
      cp "$1" "$2"
      note "refreshed       $2"
    else
      note "skip (exists)   $2"
    fi
  else
    mkdir -p "$(dirname "$2")"
    cp "$1" "$2"
    note "installed       $2"
  fi
}

seed_file() { # dst  (content on stdin)
  if [ -e "$1" ]; then
    note "skip (exists)   $1"
    cat >/dev/null
  else
    mkdir -p "$(dirname "$1")"
    cat > "$1"
    note "seeded          $1"
  fi
}

# Only two skills are embeddable — the ones an adopted project keeps and runs.
# `adopt-template` is machinery of *this* repo (.claude/skills/), not a
# deliverable: adoption is driven from here, so it never travels.
install_skill() { # name [force]
  install_file "$REPO/templates/skills/$1/SKILL.md" "$DEST/.claude/skills/$1/SKILL.md" "${2:-}"
}

# A module that ships a paired skill brings it with it.
install_paired_skills() { # modules
  case " $1 " in
    *" living-docs "*) install_skill update-living-docs ;;
  esac
}

template_commit() {
  if git -C "$REPO" rev-parse --short HEAD >/dev/null 2>&1; then
    printf '%s (%s)' \
      "$(git -C "$REPO" rev-parse --short HEAD)" \
      "$(git -C "$REPO" log -1 --date=short --format=%cd)"
  else
    printf 'unknown (not a git checkout)'
  fi
}

seed_inbox() {
  seed_file "$DEST/ideas/inbox.md" <<'EOF'
# Idea inbox

Owner's scratchpad — any language, draft quality, one line per idea. The agent never reorganizes, rewrites, or deletes entries; an idea graduates into a spec only when the owner asks.
EOF
}

case "$MODE" in

new)
  CHARTER=$ARG3
  MODULES=$ARG4
  case "$CHARTER" in
    greenfield) CHARTER_FILE="CHARTER_GREENFIELD.md" ;;
    legacy)     CHARTER_FILE="CHARTER_LEGACY_TRANSFORMATION.md" ;;
    *) fail "CHARTER must be 'greenfield' or 'legacy'" ;;
  esac
  command -v python3 >/dev/null 2>&1 || fail "python3 is required to compose the charter"
  [ -e "$DEST/CLAUDE.md" ] && fail "$DEST already has a CLAUDE.md — that is an existing project; use 'adopt'"

  mkdir -p "$DEST"
  echo "Installing the $CHARTER charter into $DEST"

  # Everything the templates put in a project lives under .claude/ — one
  # convention for both modes. The charter's relative link to ../requirements/
  # resolves from .claude/charter/ to .claude/requirements/ unchanged.
  CHARTER_DST="$DEST/.claude/charter/$CHARTER_FILE"
  if [ -e "$CHARTER_DST" ]; then
    note "skip (exists)   $CHARTER_DST"
  else
    mkdir -p "$(dirname "$CHARTER_DST")"
    MODULES_CSV=$(printf '%s' "$MODULES" | tr ' ' ',')
    python3 "$REPO/tools/assemble.py" --charter "$CHARTER" --modules "$MODULES_CSV" --out "$CHARTER_DST" >/dev/null
    note "composed        $CHARTER_DST${MODULES:+  (modules: $MODULES)}"
  fi

  install_file "$REPO/templates/requirements/REQUIREMENT_PORTABLE_APPLIANCE.md" \
               "$DEST/.claude/requirements/REQUIREMENT_PORTABLE_APPLIANCE.md"

  if [ -e "$DEST/CLAUDE.md" ]; then
    note "skip (exists)   $DEST/CLAUDE.md"
  else
    sed '1,/-->$/d' "$REPO/templates/CLAUDE_MD.template.md" \
      | sed "s|{{CHARTER_PATH}}|.claude/charter/$CHARTER_FILE|g" > "$DEST/CLAUDE.md"
    note "seeded          $DEST/CLAUDE.md"
  fi

  seed_file "$DEST/.claude/memory/roadmap.md" <<'EOF'
# Roadmap

Single source of direction. Every session starts by reading this file and ends by updating it. Work not listed here is scope creep until the owner adds it.

## Milestone 0 — Setup

- [ ] Run the charter's Setup phase: confirm every Project Parameter, settle the stack, scaffold the minimum runnable project
EOF
  seed_file "$DEST/.claude/memory/decisions.md" <<'EOF'
# Decision log

One short entry per architectural or directional decision: what was decided, why, and the strongest rejected alternative. Reversals are new entries pointing at the old one.
EOF
  seed_file "$DEST/.claude/memory/MEMORY.md" <<'EOF'
# Memory index

- [roadmap.md](roadmap.md) — single source of direction: milestones and near-term tasks
- [decisions.md](decisions.md) — decision log: what was decided, why, rejected alternatives
- [template-version.md](template-version.md) — which version of the templates these instructions came from, and what was done with each section
EOF
  seed_inbox
  # `new` runs no adoption merge, so every section is taken as-is — the manifest
  # says so explicitly rather than leaving a future upgrade to guess.
  seed_file "$DEST/.claude/memory/template-version.md" <<EOF
# Template version

Which version of the claude-templates set this project's instructions came from,
and what this project did with each part of it. An upgrade reads this file: it
recomposes the charter *at the source commit*, diffs it against the current one,
and for each changed section already knows whether this project took it, adapted
it, or refused it — and where it landed.

- **Source commit**: claude-templates @ $(template_commit)
- **Charter**: $CHARTER (\`.claude/charter/$CHARTER_FILE\`)
- **Modules**: ${MODULES:-none}

## Dispositions

Seeded by \`new\`: no adoption merge ran, so the charter was taken whole.

| Part | Disposition | Tag | Where it landed |
|---|---|---|---|
| every charter section | keep as-is | architectural | \`.claude/charter/$CHARTER_FILE\` (referenced by \`CLAUDE.md\`) |
| \`REQUIREMENT_PORTABLE_APPLIANCE\` | keep as-is | architectural | \`.claude/requirements/\` |

## Upgrading

From a clone of the template repo, in a Claude Code session **there**, with this
project as an additional working directory: *"upgrade the templates in <path>"*.
It reconciles only the diff between the source commit above and the clone's HEAD.
EOF
  install_skill graduate-idea
  install_paired_skills "$MODULES"

  echo ""
  echo "Done. Next step: open Claude Code in $DEST and say:"
  echo "  \"Read CLAUDE.md and start the charter's Setup phase.\""
  ;;

adopt)
  # Called by the adopt-template skill AFTER the owner approves the merge plan.
  # It installs only what the project KEEPS — there is no kit and no teardown.
  # The merged CLAUDE.md and the seeded memory are written by the skill itself:
  # they are judgment, not file copying.
  #
  #   MODULES — the add-on modules the project adopted (drives paired skills)
  #   KEEPS   — requirement basenames the merge classified as *keep*
  MODULES=$ARG3
  KEEPS=$ARG4

  [ -d "$DEST" ] || fail "$DEST does not exist — 'adopt' targets an existing project"
  DEST_ABS=$(CDPATH= cd -- "$DEST" && pwd)

  if [ "$DEST_ABS" = "$REPO" ]; then
    # Self-adoption: this repo is its own adopter #1. The template set already
    # lives at templates/, so only the working copies of the skills this repo
    # actually adopted are installed — force-refreshed from source, which is how
    # an edit to templates/skills/<name>/ reaches the working copy. Authoring
    # still happens only in templates/skills/.
    #
    # Only graduate-idea. NOT update-living-docs: the self-adoption merge
    # dispositioned MODULE_LIVING_DOCS *already covered* (the commit ritual is a
    # more specific statement of it), and this repo's landing is regenerated by
    # hand from README with a fixed skin — not the pipeline that skill drives.
    # Installing its working copy would auto-activate a skill this repo declined.
    # And NOT adopt-template: that is this repo's own machinery, authored
    # directly under .claude/skills/, not an embeddable deliverable.
    echo "Self-adoption: refreshing the adopted skills' working copies from templates/skills/"
    install_skill graduate-idea force
    echo ""
    echo "Done. Run /reload-skills in the open session (or restart it — skills load at startup)."
    exit 0
  fi

  echo "Installing the adopted deliverables into $DEST"

  for r in $KEEPS; do
    [ -f "$REPO/templates/requirements/$r" ] || fail "unknown requirement '$r'"
    install_file "$REPO/templates/requirements/$r" "$DEST/.claude/requirements/$r"
  done

  install_skill graduate-idea
  install_paired_skills "$MODULES"
  seed_inbox

  echo ""
  echo "Done. Nothing existing was overwritten — this script only adds files."
  echo "The merged CLAUDE.md, the seeded .claude/memory/ and the version stamp are the skill's"
  echo "job, not this script's. Nothing is committed in $DEST: that project's own session does that."
  ;;

upgrade)
  # A read, not an install: it reports the version diff the skill must reconcile.
  [ -d "$DEST" ] || fail "$DEST does not exist"
  git -C "$REPO" rev-parse --is-inside-work-tree >/dev/null 2>&1 \
    || fail "'upgrade' needs this template set to be a git checkout — it diffs template text between two commits"

  HEAD_SHA=$(git -C "$REPO" rev-parse --short HEAD)
  HEAD_DATE=$(git -C "$REPO" log -1 --date=short --format=%cd)
  STAMP="$DEST/.claude/memory/template-version.md"

  echo "Upgrade check for $DEST (nothing will be installed)"
  echo ""

  if [ -f "$STAMP" ]; then
    FROM=$(sed -n 's/.*\*\*Source commit\*\*:[^@]*@ \([0-9a-f]\{7,\}\).*/\1/p' "$STAMP" | head -1)
    [ -n "$FROM" ] || fail "found $STAMP but could not read a source commit from it — fix its '**Source commit**: … @ <sha>' line"
    note "stamped at   $FROM"
  else
    # No stamp: every pre-stamp instance still knows *when* it adopted. Take the
    # template commit that was HEAD at the *instant* of the project's adoption
    # commit. The instant matters, not the day: a template repo can ship several
    # commits in one day, and a date-granular bound would resolve to the last of
    # them — i.e. to text the project never saw.
    ADOPT_TS=$(git -C "$DEST" log -1 --format=%cI --grep='[Aa]dopt' 2>/dev/null || true)
    [ -n "$ADOPT_TS" ] || ADOPT_TS=$(git -C "$DEST" log -1 --format=%cI 2>/dev/null || true)
    [ -n "$ADOPT_TS" ] || fail "$DEST has no stamp and no git history to date it — stamp it by hand"
    FROM=$(git -C "$REPO" rev-list -1 --before="$ADOPT_TS" HEAD | cut -c1-7)
    [ -n "$FROM" ] || fail "no template commit predates $ADOPT_TS — try a content search: git -C $REPO log -S '<phrase from a charter section>' -- templates/"
    note "no stamp     — dated from the project's adoption commit ($ADOPT_TS) -> $FROM"
    note "             confirm the diff below looks right before stamping"
  fi

  note "clone is at  $HEAD_SHA ($HEAD_DATE)"
  echo ""

  CHANGED=$(git -C "$REPO" diff --name-only "$FROM..HEAD" -- templates/ 2>/dev/null || true)
  if [ -z "$CHANGED" ]; then
    echo "No template text changed since $FROM — the project is already up to date."
    echo "Nothing to reconcile; stamp it at $HEAD_SHA."
    exit 0
  fi

  echo "Template text changed between them:"
  printf '%s\n' "$CHANGED" | sed 's/^/  /'
  echo ""
  if printf '%s\n' "$CHANGED" | grep -qE '^templates/(charters|requirements)/'; then
    echo "Charter/requirement text changed — that is what folds into the project's CLAUDE.md."
  else
    echo "No charter, module, or requirement changed — nothing to fold into CLAUDE.md."
  fi
  echo ""
  echo "Reconcile it here, in this session: the skill diffs the two versions, classifies each change"
  echo "against the project's dispositions, and writes into $DEST only after you approve the plan."
  ;;

*)
  fail "unknown mode '$MODE' (new|adopt|upgrade)"
  ;;
esac
