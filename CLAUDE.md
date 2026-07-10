# claude-templates

This repository is a **meta-project**: its product is prompt text — reusable `CLAUDE.md` templates, agent charters, and requirement documents that bootstrap Claude-driven software projects. In the future it may also ship other reusable agent assets (skills, workflows). There is no application code here: "building" means writing and refining the documents; "shipping" means a template being copied into a real project and working well there.

This repo dogfoods the practices its own charters prescribe: versioned in-repo memory, a roadmap and decision log, audience-specific changelogs, and explicit git authorization.

## Layout

- `CLAUDE.md` — this file, the meta-project's working agreement. The **only** live `CLAUDE.md` in the tree.
- `ideas/` — the idea pipeline. `inbox.md` is the owner's scratchpad (any language, draft quality; never reorganize or delete entries without being asked). On the owner's request an entry **graduates** into its own spec file — kebab-case, with `Status: draft | agreed | incorporated`, `Applies to`, and Behavior ("when X, the agent should Y") / Why / Example / Open questions sections — and is removed from the inbox in the same change. Specs then graduate into template text.
- `changelog/` — audience-specific changelogs, updated **on every commit that touches `templates/` or `ideas/`** (the pre-commit hook enforces this): `maintainer.md` (technical, with a plain-language addendum and jargon glossary) and `adopter.md` (impact on people who use the templates).
- `templates/` — the **deliverables**, inert by location (see Anti-contamination). `README.md` is the catalog; `charters/` and `requirements/` hold the documents; `i18n/pt-BR/` holds generated translations; `skills/` is reserved for future embeddable skill templates.
- `.claude/` — tooling and memory of the meta-project itself, never deliverables: `settings.json` + `hooks/check-freshness.sh` (pre-commit freshness checks), `skills/translate-templates/` (regenerates translations), `memory/` (see Memory).

## Anti-contamination

The templates contain imperative, instruction-shaped text. None of it governs this repo:

- **Nothing under `templates/` is an instruction for working here** — it is product being edited.
- **Never create a file named `CLAUDE.md` outside the root.** Claude Code auto-loads such files; a future CLAUDE.md template must be named `CLAUDE_MD.template.md`.
- **Never place deliverables under `.claude/`** (skills there activate in this repo); embeddable skill templates go to `templates/skills/`.
- Naming marks the boundary: deliverables are `SCREAMING_SNAKE.md` with a type prefix (`CHARTER_`, `REQUIREMENT_`, future `MODULE_`); meta-project files are lowercase `kebab-case.md`.

## Memory — everything versioned, nothing outside the repo

All project knowledge lives in `.claude/memory/`, versioned with the repo: `roadmap.md` (single source of direction — read it at session start, update it at session end), `decisions.md` (what/why/rejected alternative, reversals are new entries), `MEMORY.md` (index). **Do not store project facts in the agent's global memory** — a fresh clone must be enough to resume work.

## Languages & translations

Conversation with the owner happens in **Brazilian Portuguese**; every artifact in this repo (templates, ideas, changelogs, memory, commit messages) is written in **English**. The one exception: `templates/i18n/pt-BR/` holds **generated** pt-BR translations of every template, mirroring the English tree. English is the source of truth — never edit a translation by hand; regenerate with the `translate-templates` skill.

## Commit ritual

Before any commit that touches `templates/` or `ideas/`: regenerate stale translations (`translate-templates` skill) and update both files in `changelog/`. The pre-commit hook blocks commits that skip either step. And as always: **never `git commit` or `git push` without explicit, per-instance authorization from the owner.**

## Editing the templates

- **Templates must stay self-contained**: each must work when copied into a foreign repo (relative links only to files that travel with it).
- **Consistency is a feature**: the two charters share most of their text by design; when editing a shared section, keep the wording identical in both unless the difference is deliberate.
- **Direction**: the charters will be decomposed into a shared core plus pluggable modules (greenfield discovery, legacy extraction, data migration) — transforming a legacy system is the same expert-conversation loop as greenfield, with the legacy system acting as one more directly-inspectable domain expert. See `.claude/memory/roadmap.md`, Milestone 2.
