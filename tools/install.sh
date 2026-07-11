#!/bin/sh
# Installer for the claude-templates deliverables. Called by the Makefile:
#   tools/install.sh new   DEST CHARTER MODULES PREFIX
#   tools/install.sh adopt DEST ""      ""      PREFIX
#
# Deterministic file installation only: it composes/copies documents and
# seeds inert scaffolding. All judgment (the Setup Q&A, the adoption merge)
# stays with Claude inside the target project. Never overwrites a file.

set -eu

REPO=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
MODE=${1:-}
DEST=${2:-}
CHARTER=${3:-}
MODULES=${4:-}
PREFIX=${5:-agent}

fail() { echo "error: $*" >&2; exit 1; }
note() { echo "  $*"; }

[ -n "$MODE" ] || fail "mode missing (new|adopt)"
[ -n "$DEST" ] || fail "DEST is required, e.g. make $MODE DEST=~/devel/myapp"

# `make adopt DEST=~/...` reaches us with a literal ~ (shells only expand it
# in real assignments) — expand it ourselves.
case "$DEST" in
  "~")   DEST=$HOME ;;
  "~/"*) DEST=$HOME/${DEST#"~/"} ;;
esac

# Copy a single file unless the destination already exists.
install_file() { # src dst
  if [ -e "$2" ]; then
    note "skip (exists)   $2"
  else
    mkdir -p "$(dirname "$2")"
    cp "$1" "$2"
    note "installed       $2"
  fi
}

# Write stdin to dst unless it already exists.
seed_file() { # dst
  if [ -e "$1" ]; then
    note "skip (exists)   $1"
    cat >/dev/null
  else
    mkdir -p "$(dirname "$1")"
    cat > "$1"
    note "seeded          $1"
  fi
}

install_skill() { # name
  install_file "$REPO/templates/skills/$1/SKILL.md" "$DEST/.claude/skills/$1/SKILL.md"
}

case "$MODE" in

new)
  case "$CHARTER" in
    greenfield) CHARTER_FILE="CHARTER_GREENFIELD.md" ;;
    legacy)     CHARTER_FILE="CHARTER_LEGACY_TRANSFORMATION.md" ;;
    *) fail "CHARTER must be 'greenfield' or 'legacy', e.g. make new DEST=... CHARTER=greenfield" ;;
  esac
  command -v python3 >/dev/null 2>&1 || fail "python3 is required to compose the charter"
  [ -e "$DEST/CLAUDE.md" ] && fail "$DEST already has a CLAUDE.md — this looks like an existing project; use 'make adopt DEST=$DEST' instead"

  mkdir -p "$DEST"
  echo "Installing the $CHARTER charter into $DEST (prefix: $PREFIX/)"

  # Charter, composed with the requested add-on modules.
  CHARTER_DST="$DEST/$PREFIX/charters/$CHARTER_FILE"
  if [ -e "$CHARTER_DST" ]; then
    note "skip (exists)   $CHARTER_DST"
  else
    mkdir -p "$(dirname "$CHARTER_DST")"
    MODULES_CSV=$(printf '%s' "$MODULES" | tr ' ' ',')
    python3 "$REPO/tools/assemble.py" --charter "$CHARTER" --modules "$MODULES_CSV" --out "$CHARTER_DST" >/dev/null
    note "composed        $CHARTER_DST${MODULES:+  (modules: $MODULES)}"
  fi

  # Requirement referenced by the charter (relative link ../requirements/).
  install_file "$REPO/templates/requirements/REQUIREMENT_PORTABLE_APPLIANCE.md" \
               "$DEST/$PREFIX/requirements/REQUIREMENT_PORTABLE_APPLIANCE.md"

  # CLAUDE.md stub wired to the charter.
  if [ -e "$DEST/CLAUDE.md" ]; then
    note "skip (exists)   $DEST/CLAUDE.md"
  else
    # Strip the template-only header comment (line 1 through the first -->),
    # then wire the charter path in.
    sed '1,/-->$/d' "$REPO/templates/CLAUDE_MD.template.md" \
      | sed "s|{{CHARTER_PATH}}|$PREFIX/charters/$CHARTER_FILE|g" > "$DEST/CLAUDE.md"
    note "seeded          $DEST/CLAUDE.md"
  fi

  # Versioned in-repo memory, idea inbox, graduation skill.
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
EOF
  seed_file "$DEST/ideas/inbox.md" <<'EOF'
# Idea inbox

Owner's scratchpad — any language, draft quality, one line per idea. The agent never reorganizes, rewrites, or deletes entries; an idea graduates into a spec only when the owner asks.
EOF
  install_skill graduate-idea

  echo ""
  echo "Done. Next step: open Claude Code in $DEST and say:"
  echo "  \"Read CLAUDE.md and start the charter's Setup phase.\""
  echo "(If a Claude Code session is already open there, run /reload-skills first — or restart the session, which always works.)"
  ;;

adopt)
  [ -d "$DEST" ] || fail "$DEST does not exist — 'make adopt' targets an existing project"
  DEST_ABS=$(CDPATH= cd -- "$DEST" && pwd)

  if [ "$DEST_ABS" = "$REPO" ]; then
    # Self-adoption: this repo is its own adopter #1 (the virtuous cycle —
    # improve the templates here, then use them here). The template set
    # already lives at templates/, so only the skills' working copies are
    # installed; authoring still happens only in templates/skills/.
    echo "Self-adoption: installing skill working copies into .claude/skills/ (template set already at templates/)"
    install_skill graduate-idea
    install_skill adopt-template

    echo ""
    echo "Done. Next step: run /reload-skills in the open session (or restart it — skills load at startup), then ask Claude in this repo:"
    echo "  \"Adopt the templates in templates/ into this project.\"  (non-destructive merge against CLAUDE.md)"
    exit 0
  fi

  echo "Installing the template set into $DEST for adoption (prefix: $PREFIX/)"

  # Reference set the merge classifies against; relative links stay valid.
  for f in charters/CHARTER_GREENFIELD.md charters/CHARTER_LEGACY_TRANSFORMATION.md \
           requirements/REQUIREMENT_PORTABLE_APPLIANCE.md guides/GUIDE_ADOPTION.md; do
    install_file "$REPO/templates/$f" "$DEST/$PREFIX/$f"
  done
  install_skill adopt-template

  echo ""
  echo "Done. Nothing of the existing project was touched. Next step: open Claude Code in $DEST and say:"
  echo "  \"Adopt the templates in $PREFIX/ into this project.\"  (runs the adopt-template skill's non-destructive merge)"
  echo "(If a Claude Code session is already open there, run /reload-skills first — or restart the session, which always works.)"
  ;;

*)
  fail "unknown mode '$MODE' (new|adopt)"
  ;;
esac
