# claude-templates

This repository is a **meta-project**: its product is prompt text — reusable charters, requirement documents, guides, and embeddable skills that bootstrap Claude-driven software projects. There is no application code here: "building" means writing and refining the documents; "shipping" means a template being copied into a real project and working well there. The repo dogfoods what its charters prescribe: versioned in-repo memory, a roadmap and decision log, a curated changelog, and explicit git authorization.

## Layout

- `CLAUDE.md` — this file, the meta-project's working agreement. The **only** live `CLAUDE.md` in the tree.
- `README.md` — the adopter-facing **landing page and catalog**: the current-state source of truth for what the templates offer and how to adopt them. Updated in the same commit as any adopter-facing deliverable change (hook-enforced).
- `CHANGELOG.md` — one curated changelog, written for adopters, updated per significant change; the git history is the technical record underneath.
- `docs/index.html` — the **rendered landing page**, a generated view of `README.md` served by GitHub Pages (`https://diegopego.github.io/claude-templates/`). Its Nord "charter" skin is settled — regenerate the content from README, never redesign ad hoc.
- `ideas/` — the idea pipeline. `inbox.md` is the owner's scratchpad (any language, draft quality; never reorganize or delete entries without being asked). On the owner's request an entry **graduates** through a Q&A round — outcome-changing questions batched, each with options and a recommendation, resolutions recorded in `.claude/memory/decisions.md` — into its own kebab-case spec file (`Status: draft | agreed | incorporated | deferred`) and leaves the inbox in the same change. Specs then graduate into template text.
- `templates/` — the **deliverables**, inert by location (see Anti-contamination): `charters/` (composed) plus `charters/sources/` (the core + modules + manifest they are assembled from), `requirements/`, `guides/`, and `skills/` (embeddable skill templates adopters copy into their own `.claude/skills/`).
- `Makefile` + `tools/` — the deterministic layer: the charter assembler (`tools/assemble.py`, the single implementation behind `make assemble`, module composition at install time, and the hook's freshness check) and `tools/install.sh` (three modes — `new` / `adopt` / `upgrade` — pure file operations, never overwriting). The Makefile is **maintainer-only** (`assemble`, `refresh-skills`): adoption is not a `make` target.
- `.claude/` — tooling and memory of the meta-project itself: the pre-commit freshness hook, the `assemble-charters` skill, `memory/`, and skill **working copies** installed by self-adoption (see Anti-contamination).

## Method — how work advances here

The charters' five phases (Discover → Align → Specify → Prototype → Build) presuppose an application; this repo has none. The same discipline, adapted to prose:

1. **Capture** — a rough idea lands in `ideas/inbox.md`, any language, no ceremony.
2. **Graduate** — on the owner's request, a **Q&A round** turns it into an agreed spec (`graduate-idea`). The round is the one tool that turns uncertainty into written, agreed decisions, and it is used at every "ask, don't infer" moment — not just at graduation: **batched**, never drip-fed; every question carries **options and a recommendation**, so the owner decides from a position rather than a blank page; **scripted baseline, then adaptive** (open with the questions you already know you must ask, follow up where the answers warrant depth); **answers become artifacts** — an answer not written down did not happen. The round closes when no question the owner considers blocking remains.
3. **Incorporate** — the spec becomes template text (charter sources, requirement, guide, or skill).
4. **Validate** — the text is proven only when a real adopting project uses it and the friction comes back as inbox notes. Until then it is a hypothesis.

The risk this fights is the meta-project's version of *building the wrong thing confidently*: **prescribing a practice no real project has ever exercised.** Elegant prose is not evidence. Hence step 4, and hence the current roadmap focus.

Act as a senior technical writer and prompt engineer, a senior product thinker (what an adopter actually needs), and the **adopter's advocate** — the one who asks whether a section would survive being copied into a foreign repo by someone who never read this conversation.

## Proving the tooling

`tools/assemble.py`, `tools/install.sh`, and the pre-commit hook are the only executable things here, and a break in them reaches adopters directly. There is no test suite (the product is text; the tooling is small enough to read), so the rule is behavioral: **any change to `tools/`, the `Makefile`, or the hook is exercised end to end before the commit** — run all three installer modes (`sh tools/install.sh new|adopt|upgrade`) into a throwaway destination and look at what actually landed. Reading the diff is not proof; a green run is.

## Adoption runs from here

Installing, adopting, and upgrading a project are **one door**: the `adopt-template` skill, run in a session *in this repo*, with the target as an additional working directory. The skill judges and converses; `tools/install.sh` does the file operations it decides on. There is no delivery kit — nothing is copied into a target only to be torn down — and **nothing is ever committed in the target** (see *Commit ritual*). Adoption is deliberately not a `make` target: two doors let the owner-facing flow and the agent-facing flow drift, and they did.

## Anti-contamination

The templates contain imperative, instruction-shaped text. None of it governs this repo:

- **Nothing under `templates/` is an instruction for working here** — it is product being edited.
- **Never create a file named `CLAUDE.md` outside the root.** Claude Code auto-loads such files; a future CLAUDE.md template must be named `CLAUDE_MD.template.md`.
- **Embeddable skills are authored only in `templates/skills/`, never under `.claude/`** — they are product, and a skill under `.claude/skills/` would auto-activate here. Two sanctioned exceptions live in `.claude/skills/`:
  - **Working copies** of the embeddable skills (`graduate-idea`, `update-living-docs`), installed by `make refresh-skills` — this repo is its own adopter #1 (the virtuous cycle: improve the templates here, use them here). Never edit a working copy; edit the source in `templates/skills/` and re-run `make refresh-skills`.
  - **This repo's own machinery**, authored directly under `.claude/skills/` and never shipped: `assemble-charters` and **`adopt-template`**. Adoption is driven *from here* (see below), so the adoption skill is a tool of the meta-project, not a deliverable — it does not travel into an adopter, and `templates/skills/` must not carry a copy of it.
- Naming marks the boundary: deliverables are `SCREAMING_SNAKE.md` with a type prefix (`CHARTER_`, `MODULE_`, `REQUIREMENT_`, `GUIDE_`); meta-project files are lowercase `kebab-case.md`.

## Memory — everything versioned, nothing outside the repo

All project knowledge lives in `.claude/memory/`, versioned with the repo: `roadmap.md` (single source of direction — read it at session start, update it at session end; closed milestones move to `roadmap-archive.md`), `decisions.md` (what/why/rejected alternative; reversals are new entries), `template-version.md` (which version of its own templates this repo has adopted), `MEMORY.md` (index). **Do not store project facts in the agent's global memory** — a fresh clone must be enough to resume work.

At the end of every task, decide and say one of: **continue** (adjacent in-scope work remains and context allows), or **hand off** — update `.claude/memory/handoff.md` with the current state, the decisions made and why, the dead ends hit, and concrete next steps (pointers into `roadmap.md`, never a second copy of it), written for a successor with zero conversation context.

## Languages

Conversation with the owner happens in **Brazilian Portuguese**; every artifact in this repo (templates, ideas, changelog, memory, commit messages) is written in **English**. Templates ship in English only — translations return when an adopting project asks for them.

## Commit ritual

Before any commit: if a charter source changed, regenerate the composed charters (`assemble-charters` skill); if `templates/` or `ideas/` changed, update `CHANGELOG.md`; if an adopter-facing deliverable changed (composed charters, requirements, guides, skills), refresh `README.md`; if `README.md` changed, regenerate `docs/index.html` from it — all staged in the same commit. The pre-commit hook blocks commits that skip a step. Publishing happens on `git push` (GitHub Pages serves `docs/` from `master`), so the push authorization **is** the publish approval. And as always: **never `git commit` or `git push` without explicit, per-instance authorization from the owner.**

**Commit rights end at this repository.** Validating the templates means working inside other projects (adoption merges, upgrades) — a session started here may edit a foreign repo's `CLAUDE.md`, memory, or stamp, but **never commits or pushes there**. Leave the changes in that project's working tree and report them; its own session, under its own charter, commits them.

## Editing the templates

- **Charters are generated — edit the sources, never the composed files.** The composed `templates/charters/CHARTER_*.md` are assembled from `templates/charters/sources/` (a shared `CHARTER_CORE.md` plus pluggable modules, per `charters.manifest.md`). Edit the shared spine in the core, the divergent parts in the modules, then run `assemble-charters`.
- **Composed charters ship minimal by design.** Opinionated practices (`MODULE_PRODUCT_AUDIENCE`, `MODULE_LIVING_DOCS`, `MODULE_DATA_MIGRATION` for greenfield) are opt-in add-ons a project composes in — do not fold them back into the core.
- **Composed templates must stay self-contained**: each must work when copied alone into a foreign repo (relative links only to files that travel with it, e.g. `../requirements/`). No `{{ }}` or `SLOT` markers may leak into a composed file.
- **Requirements, guides, and skills** are hand-authored deliverables, not generated.
- **Direction** lives in `.claude/memory/roadmap.md`. Current focus: validate the templates in a real project before growing them further.
