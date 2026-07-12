#!/bin/sh
# Installer for the claude-templates deliverables. Called by the Makefile:
#   tools/install.sh new     DEST CHARTER MODULES PREFIX
#   tools/install.sh adopt   DEST ""      ""      PREFIX
#   tools/install.sh upgrade DEST                        (installs nothing)
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

[ -n "$MODE" ] || fail "mode missing (new|adopt|upgrade)"
[ -n "$DEST" ] || fail "DEST is required, e.g. make $MODE DEST=~/devel/myapp"

# `make adopt DEST=~/...` reaches us with a literal ~ (shells only expand it
# in real assignments) — expand it ourselves.
case "$DEST" in
  "~")   DEST=$HOME ;;
  "~/"*) DEST=$HOME/${DEST#"~/"} ;;
esac

# Copy a single file. Skips when the destination exists, unless the caller
# passes "force" as the third argument — self-adoption uses that to refresh its
# own generated skill working copies from source.
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

install_skill() { # name [force]
  install_file "$REPO/templates/skills/$1/SKILL.md" "$DEST/.claude/skills/$1/SKILL.md" "${2:-}"
}

# Provenance of the delivered kit: the template repo's commit. A later
# re-adoption reads it to reconcile a version diff (`git diff <sha>..HEAD --
# templates/`) instead of re-merging the whole charter from scratch. The
# adoption merge folds this into the project as
# .claude/memory/template-version.md, which survives the kit teardown.
template_commit() {
  if git -C "$REPO" rev-parse --short HEAD >/dev/null 2>&1; then
    printf '%s (%s)' \
      "$(git -C "$REPO" rev-parse --short HEAD)" \
      "$(git -C "$REPO" log -1 --date=short --format=%cd)"
  else
    printf 'unknown (not a git checkout)'
  fi
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
- [template-version.md](template-version.md) — which version of the templates these instructions came from
EOF
  seed_file "$DEST/ideas/inbox.md" <<'EOF'
# Idea inbox

Owner's scratchpad — any language, draft quality, one line per idea. The agent never reorganizes, rewrites, or deletes entries; an idea graduates into a spec only when the owner asks.
EOF
  # Provenance stamp. `new` has no adoption merge to fold it in, so it is
  # written straight into project memory — the same file a later re-adoption
  # reads to run an upgrade diff instead of a from-scratch merge.
  seed_file "$DEST/.claude/memory/template-version.md" <<EOF
# Template version

Which version of the claude-templates set this project's instructions came from.
A re-adoption reads this to reconcile only what changed since — see the adoption
guide's *Upgrade* branch. Update it whenever an upgrade is completed.

- **Source commit**: claude-templates @ $(template_commit)
- **Charter**: $CHARTER
- **Modules**: ${MODULES:-none}
- **Dispositions**: seeded by \`make new\` — no adoption merge ran, so every charter section is *keep as-is*
EOF
  install_skill graduate-idea
  # MODULE_LIVING_DOCS ships a paired skill; install it when that module is composed in.
  case " $MODULES " in
    *" living-docs "*) install_skill update-living-docs ;;
  esac

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
    # installed — force-refreshed from source each run, so editing a skill in
    # templates/skills/ and re-running this is how the working copy updates.
    # Authoring still happens only in templates/skills/.
    echo "Self-adoption: refreshing skill working copies in .claude/skills/ from templates/skills/"
    install_skill graduate-idea force
    install_skill adopt-template force

    echo ""
    echo "Done. Next step: run /reload-skills in the open session (or restart it — skills load at startup), then ask Claude in this repo:"
    echo "  \"Adopt the templates in templates/ into this project.\"  (non-destructive merge against CLAUDE.md)"
    exit 0
  fi

  echo "Installing the template set into $DEST for adoption (prefix: $PREFIX/)"

  # Reference set the merge classifies against; relative links stay valid.
  # The charter *sources* travel whole — every add-on module plus the manifest —
  # so the merge can fold in any opt-in module à la carte (the guide promises
  # this), and so an upgrade can diff the project against the module text it
  # actually adopted. Each module that ships a paired skill brings it along.
  for f in charters/CHARTER_GREENFIELD.md charters/CHARTER_LEGACY_TRANSFORMATION.md \
           charters/sources/CHARTER_CORE.md \
           charters/sources/MODULE_DISCOVERY_GREENFIELD.md \
           charters/sources/MODULE_EXTRACTION_LEGACY.md \
           charters/sources/MODULE_DATA_MIGRATION.md \
           charters/sources/MODULE_PRODUCT_AUDIENCE.md \
           charters/sources/MODULE_LIVING_DOCS.md \
           charters/sources/charters.manifest.md \
           requirements/REQUIREMENT_PORTABLE_APPLIANCE.md guides/GUIDE_ADOPTION.md \
           skills/update-living-docs/SKILL.md; do
    install_file "$REPO/templates/$f" "$DEST/$PREFIX/$f"
  done

  # Provenance of this kit. The merge folds it into the project as
  # .claude/memory/template-version.md (filling in the charter, the modules and
  # the dispositions it actually adopted); the kit itself is torn down.
  cat > "$DEST/$PREFIX/TEMPLATE_VERSION.md" <<EOF
# Kit provenance

This template set was delivered from **claude-templates @ $(template_commit)**.

The adoption merge records this commit in the project as
\`.claude/memory/template-version.md\`, together with the charter and modules it
adopted. That file outlives this kit: a later re-adoption reads it, diffs the two
versions (\`git -C <templates> diff <commit>..HEAD -- templates/\`) and reconciles
only what changed — instead of re-merging the whole charter from scratch.
EOF
  note "stamped         $DEST/$PREFIX/TEMPLATE_VERSION.md"
  install_skill adopt-template
  # graduate-idea is a permanent, charter-prescribed skill (the idea-inbox
  # practice) — install it to stay, unlike the one-shot adopt-template the merge
  # removes at teardown. Seed an empty inbox only if the project has none.
  install_skill graduate-idea
  seed_file "$DEST/ideas/inbox.md" <<'EOF'
# Idea inbox

Owner's scratchpad — any language, draft quality, one line per idea. The agent never reorganizes, rewrites, or deletes entries; an idea graduates into a spec only when the owner asks.
EOF

  echo ""
  echo "Done. Nothing existing was overwritten — the installer only adds files. Next step: open Claude Code in $DEST and say:"
  echo "  \"Adopt the templates in $PREFIX/ into this project.\"  (runs the adopt-template skill)"
  echo "It merges non-destructively against the project's own instructions — or, if the project already"
  echo "runs an older version of these templates (.claude/memory/template-version.md), reconciles only"
  echo "the diff between that version and this kit."
  echo "(If a Claude Code session is already open there, run /reload-skills first — or restart the session, which always works.)"
  ;;

upgrade)
  # Reconciles a project that already adopted an earlier version. It is a *read*:
  # nothing is copied into DEST, so there is no kit to tear down afterwards. The
  # upgrade needs a diff between two commits, and both live in this clone.
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
    # template commit that was HEAD at the *instant* of the project's last
    # adoption commit. The instant matters, not the day: a template repo can ship
    # several commits in one day, and a date-granular bound would resolve to the
    # last of them — i.e. to text the project never saw.
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
  echo "Next: open Claude Code in $DEST and say:"
  echo "  \"Upgrade the templates in this project.\"  (runs the adopt-template skill's Upgrade branch)"
  ;;

*)
  fail "unknown mode '$MODE' (new|adopt|upgrade)"
  ;;
esac
