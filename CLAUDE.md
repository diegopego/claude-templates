# claude-templates

This repository is a **meta-project**: its product is prompt text — reusable charters, requirement documents, guides, and embeddable skills that bootstrap Claude-driven software projects. There is no application code here: "building" means writing and refining the documents; "shipping" means a template being copied into a real project and working well there. The repo dogfoods what its charters prescribe: versioned in-repo memory, a roadmap and decision log, a curated changelog, and explicit git authorization.

## Layout

- `CLAUDE.md` — this file, the meta-project's working agreement. The **only** live `CLAUDE.md` in the tree.
- `README.md` — the adopter-facing **landing page and catalog**: the current-state source of truth for what the templates offer and how to adopt them. Updated in the same commit as any adopter-facing deliverable change (hook-enforced).
- `CHANGELOG.md` — one curated changelog, written for adopters, updated per significant change; the git history is the technical record underneath.
- `docs/index.html` — the **rendered landing page**, a generated view of `README.md` served by GitHub Pages (`https://diegopego.github.io/claude-templates/`). Its Nord "charter" skin is settled — regenerate the content from README, never redesign ad hoc.
- `ideas/` — the idea pipeline. `inbox.md` is the owner's scratchpad (any language, draft quality; never reorganize or delete entries without being asked). On the owner's request an entry **graduates** through a Q&A round — outcome-changing questions batched, each with options and a recommendation, resolutions recorded in `.claude/memory/decisions.md` — into its own kebab-case spec file (`Status: draft | agreed | incorporated | deferred`) and leaves the inbox in the same change. Specs then graduate into template text.
- `templates/` — the **deliverables**, inert by location (see Anti-contamination): `charters/` (composed) plus `charters/sources/` (the core + modules + manifest they are assembled from), `requirements/`, `guides/`, and `skills/` (embeddable skill templates adopters copy into their own `.claude/skills/`).
- `Makefile` + `tools/` — the **installer** (`make new` / `make adopt` with `DEST=…`) and the deterministic charter assembler (`tools/assemble.py`, the single implementation behind `make assemble`, module composition at install time, and the hook's freshness check).
- `.claude/` — tooling and memory of the meta-project itself: the pre-commit freshness hook, the `assemble-charters` skill, `memory/`, and skill **working copies** installed by self-adoption (see Anti-contamination).

## Anti-contamination

The templates contain imperative, instruction-shaped text. None of it governs this repo:

- **Nothing under `templates/` is an instruction for working here** — it is product being edited.
- **Never create a file named `CLAUDE.md` outside the root.** Claude Code auto-loads such files; a future CLAUDE.md template must be named `CLAUDE_MD.template.md`.
- **Skills are authored only in `templates/skills/`, never under `.claude/`.** The one sanctioned exception: `make adopt DEST=.` installs **working copies** of the embeddable skills into `.claude/skills/` — this repo is its own adopter #1 (the virtuous cycle: improve the templates here, use them here). Never edit a working copy; edit the source in `templates/skills/` and re-run `make adopt DEST=.` to refresh it.
- Naming marks the boundary: deliverables are `SCREAMING_SNAKE.md` with a type prefix (`CHARTER_`, `MODULE_`, `REQUIREMENT_`, `GUIDE_`); meta-project files are lowercase `kebab-case.md`.

## Memory — everything versioned, nothing outside the repo

All project knowledge lives in `.claude/memory/`, versioned with the repo: `roadmap.md` (single source of direction — read it at session start, update it at session end; closed milestones move to `roadmap-archive.md`), `decisions.md` (what/why/rejected alternative; reversals are new entries), `MEMORY.md` (index). **Do not store project facts in the agent's global memory** — a fresh clone must be enough to resume work.

## Languages

Conversation with the owner happens in **Brazilian Portuguese**; every artifact in this repo (templates, ideas, changelog, memory, commit messages) is written in **English**. Templates ship in English only — translations return when an adopting project asks for them.

## Commit ritual

Before any commit: if a charter source changed, regenerate the composed charters (`assemble-charters` skill); if `templates/` or `ideas/` changed, update `CHANGELOG.md`; if an adopter-facing deliverable changed (composed charters, requirements, guides, skills), refresh `README.md`; if `README.md` changed, regenerate `docs/index.html` from it — all staged in the same commit. The pre-commit hook blocks commits that skip a step. Publishing happens on `git push` (GitHub Pages serves `docs/` from `master`), so the push authorization **is** the publish approval. And as always: **never `git commit` or `git push` without explicit, per-instance authorization from the owner.**

## Editing the templates

- **Charters are generated — edit the sources, never the composed files.** The composed `templates/charters/CHARTER_*.md` are assembled from `templates/charters/sources/` (a shared `CHARTER_CORE.md` plus pluggable modules, per `charters.manifest.md`). Edit the shared spine in the core, the divergent parts in the modules, then run `assemble-charters`.
- **Composed charters ship minimal by design.** Opinionated practices (`MODULE_PRODUCT_AUDIENCE`, `MODULE_LIVING_DOCS`, `MODULE_DATA_MIGRATION` for greenfield) are opt-in add-ons a project composes in — do not fold them back into the core.
- **Composed templates must stay self-contained**: each must work when copied alone into a foreign repo (relative links only to files that travel with it, e.g. `../requirements/`). No `{{ }}` or `SLOT` markers may leak into a composed file.
- **Requirements, guides, and skills** are hand-authored deliverables, not generated.
- **Direction** lives in `.claude/memory/roadmap.md`. Current focus: validate the templates in a real project before growing them further.
