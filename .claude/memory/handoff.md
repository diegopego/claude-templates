# Handoff

Written 2026-07-11, at the close of the session that incorporated **Setup-scaffolding + the project CLI** (specs 3 & 4 of the cluster). For a successor with zero conversation context: read `roadmap.md` first, then this.

## Current state

- Branch `master` (we always work directly on master — see `decisions.md`). This incorporation is **committed** — `b91b0b1` *Incorporate Setup-scaffolding + the project CLI into the templates* (18 files, pre-commit hook passed), plus a small follow-up commit correcting the landing-republish status lines. Working tree clean.
- **What this session did** — took `ideas/setup-scaffolds-project.md` + `ideas/lifecycle-cli.md` (interlocking) into template text:
  - `CHARTER_CORE.md`: new **Setup scaffolding** section (composed §4 both charters), expanded Method §0 *Setup* bullet, and a *Stack philosophy* overridable-default clause. Composed charters reassembled by the surgical method (greenfield **1–18**, legacy **1–19**, sequential); pt-BR retranslated.
  - New deliverable **`REQUIREMENT_PROJECT_CLI.md`** (EN + pt-BR) + catalog entry (EN + pt-BR). A `claude`-styled single-door CLI (`setup`/`adopt`/`update-docs`/`graduate-idea`), specified as a thin orchestrator; we ship the spec only.
  - Root `README.md` landing updated; both changelogs updated; `decisions.md` entry added; both specs marked `incorporated`; roadmap updated.
- **Q&A round this session** settled two open questions from `lifecycle-cli.md` (in `decisions.md`): CLI **orchestrates the rituals, the pre-commit hook stays the backstop**; CLI **invokes** the embeddable skills (they stay stand-alone), not absorbs-them-as-subcommands.
- The rendered **Artifact landing was republished after owner approval** (2026-07-11, same URL `…/artifact/213558f8-…`, Nord skin unchanged, new Project-CLI card + Setup-scaffolding content) per the landing approval loop. Canonical `README.md` is current. The Artifact HTML is not versioned in the repo (by design); to update it a successor fetches the URL via WebFetch to recover the skin, edits content, and republishes to the same URL.
- `ideas/inbox.md` is empty.

## Next steps (roadmap → Milestone 3, "Setup + changelog→landing pipeline")

**2 of 6 cluster specs remain `agreed`, awaiting incorporation** (each carries the ritual: assemble → landing → translate → changelog — though these two are skill/tooling + charter-prose, not charter reassembly):

1. **`ideas/living-product-doc.md` rewiring** — change `.claude/skills/update-product-doc/` to consume the audience-changelog entry + a **last-processed-commit marker** under `.claude/memory/`, instead of the staged diff. Skill/tooling change, not charter text. (The `REQUIREMENT_PROJECT_CLI.md` already describes this delta-driven behavior for `update-docs` — align the skill to it.)
2. **`ideas/landing-publishing.md`** — formalize skin-at-Setup + the approval loop into template text (already practiced here, but not prescribed where adopters see it). Likely a `CHARTER_CORE` addition and/or a note in the CLI requirement.

Also open (older): `product-not-bespoke` open questions (per-tenant backup/restore; tenant provisioning), `translated-templates` module question — see roadmap Milestone 3 head. Milestone 4: `adopt-template` skill.

## Commit ritual (before authorizing a commit)

Stage together: `templates/charters/` (composed), `templates/charters/sources/CHARTER_CORE.md`, `templates/requirements/REQUIREMENT_PROJECT_CLI.md`, `templates/README.md`, `templates/i18n/**`, root `README.md`, `changelog/*.md`, `ideas/*.md`, `.claude/memory/*`. The pre-commit hook checks 4 rules (sources→composed staged, EN→pt-BR pairs, changelog on templates/ideas changes, README on adopter-facing changes).

## Dead ends / cautions

- **Do not regenerate composed charters with an ad-hoc script.** The reliable method for source edits: apply the same edit surgically to both composed charters + both pt-BR mirrors (rewrite the full file when a new section shifts numbering), then verify with `git diff | grep '^[+-]## '` that only intended headings changed and numbering is sequential, and a non-heading diff to confirm only intended prose changed. This session used that method and verified clean.
- **pt-BR terms in use:** greenfield = "especificações"/"Especificar"/"product owner"; legacy = "padrões-ouro"/"Padrões-ouro"/"autor do sistema"; phase-1 legacy verb = "Compreender". Section titles: spec-driven = "Trabalho orientado a especificações"; **new: Setup scaffolding = "Scaffolding no Setup"** (referenced verbatim in the Setup bullet, Stack philosophy, and the CLI requirement).
- Conversation with the owner in pt-BR; every artifact (including this file) in English.
