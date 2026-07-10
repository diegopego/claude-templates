# claude-templates

This repository is a **meta-project**: its product is prompt text — reusable `CLAUDE.md` templates, agent charters, and requirement documents that bootstrap Claude-driven software projects. In the future it may also ship other reusable agent assets (skills, workflows). There is no application code here: "building" means writing and refining the documents; "shipping" means a template being copied into a real project and working well there.

This repo dogfoods the practices its own charters prescribe: versioned in-repo memory, a roadmap and decision log, audience-specific changelogs, and explicit git authorization.

## Layout

- `CLAUDE.md` — this file, the meta-project's working agreement. The **only** live `CLAUDE.md` in the tree.
- `README.md` (root) — the **living landing page**: the current-state, adopter-facing source of truth for what the templates offer and how to adopt them. Kept current by the `update-product-doc` skill; distinct from `changelog/` (history) and from `templates/README.md` (the catalog).
- `ideas/` — the idea pipeline. `inbox.md` is the owner's scratchpad (any language, draft quality; never reorganize or delete entries without being asked). On the owner's request an entry **graduates** into its own spec file — kebab-case, with `Status: draft | agreed | incorporated`, `Applies to`, and Behavior ("when X, the agent should Y") / Why / Example / Open questions sections — and is removed from the inbox in the same change. When graduating, the agent drafts the spec with its *Open questions* filled in; any open question that would change the template text must be resolved with the owner — in a round of questions with options and a recommendation — before the spec moves from `draft` to `agreed`. With no outcome-changing questions, graduation proceeds straight through. Specs then graduate into template text.
- `changelog/` — audience-specific changelogs, updated **on every commit that touches `templates/` or `ideas/`** (the pre-commit hook enforces this): `maintainer.md` (technical, with a plain-language addendum and jargon glossary) and `adopter.md` (impact on people who use the templates).
- `templates/` — the **deliverables**, inert by location (see Anti-contamination). `README.md` is the catalog; `charters/` holds the composed charters (generated) plus `charters/sources/` (the core + modules + manifest they are assembled from); `requirements/` holds the requirement documents; `guides/` holds process guides (e.g. `GUIDE_ADOPTION.md`); `i18n/pt-BR/` holds generated translations; `skills/` is reserved for future embeddable skill templates.
- `.claude/` — tooling and memory of the meta-project itself, never deliverables: `settings.json` + `hooks/check-freshness.sh` (pre-commit freshness checks), `skills/assemble-charters/` (assembles the composed charters from sources), `skills/translate-templates/` (regenerates translations), `skills/update-product-doc/` (keeps the root `README.md` landing page current), `memory/` (see Memory).

## Anti-contamination

The templates contain imperative, instruction-shaped text. None of it governs this repo:

- **Nothing under `templates/` is an instruction for working here** — it is product being edited.
- **Never create a file named `CLAUDE.md` outside the root.** Claude Code auto-loads such files; a future CLAUDE.md template must be named `CLAUDE_MD.template.md`.
- **Never place deliverables under `.claude/`** (skills there activate in this repo); embeddable skill templates go to `templates/skills/`.
- Naming marks the boundary: deliverables are `SCREAMING_SNAKE.md` with a type prefix (`CHARTER_`, `REQUIREMENT_`, future `MODULE_` and `GUIDE_`); meta-project files are lowercase `kebab-case.md`.

## Memory — everything versioned, nothing outside the repo

All project knowledge lives in `.claude/memory/`, versioned with the repo: `roadmap.md` (single source of direction — read it at session start, update it at session end), `decisions.md` (what/why/rejected alternative, reversals are new entries), `MEMORY.md` (index). **Do not store project facts in the agent's global memory** — a fresh clone must be enough to resume work.

## Languages & translations

Conversation with the owner happens in **Brazilian Portuguese**; every artifact in this repo (templates, ideas, changelogs, memory, commit messages) is written in **English**. The one exception: `templates/i18n/pt-BR/` holds **generated** pt-BR translations of every template, mirroring the English tree. English is the source of truth — never edit a translation by hand; regenerate with the `translate-templates` skill.

## Commit ritual

Before any commit that touches `templates/` or `ideas/`: if a charter source changed, reassemble the composed charters (`assemble-charters` skill); if an adopter-facing deliverable changed (composed charters, requirements, guides, catalog), refresh the living landing page (`update-product-doc` skill → root `README.md`); then regenerate stale translations (`translate-templates` skill) and update both files in `changelog/`. The order matters — assemble, then update the landing page, then translate. The pre-commit hook blocks commits that skip any step. And as always: **never `git commit` or `git push` without explicit, per-instance authorization from the owner.**

## Editing the templates

- **Charters are generated — edit the sources, never the composed files.** The composed `templates/charters/CHARTER_*.md` are assembled from `templates/charters/sources/` (a shared `CHARTER_CORE.md` plus pluggable modules, per `charters.manifest.md`). Edit the shared spine in the core, the divergent parts in the modules, then run `assemble-charters`. The consistency between the two charters is now structural, not a manual discipline.
- **Composed templates must stay self-contained**: each composed charter must work when copied alone into a foreign repo (relative links only to files that travel with it, e.g. `../requirements/`). No `{{ }}` or `SLOT` markers may leak into a composed file.
- **Requirements** (`templates/requirements/`) are hand-authored deliverables, not generated.
- **Direction**: the modular decomposition (Milestone 2) is done. `MODULE_DATA_MIGRATION.md` is pluggable — a greenfield project that inherits data can add it. Next: the adoption guide (`GUIDE_ADOPTION.md`) and maturing the remaining `ideas/`. See `.claude/memory/roadmap.md`.
