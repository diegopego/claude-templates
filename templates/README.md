# Template Catalog

Deliverables of this repository: self-contained documents meant to be copied into a real project and referenced from that project's `CLAUDE.md`. Nothing in this directory is an instruction for working on *this* repo.

## Charters (`charters/`)

Working agreements for an AI coding agent. Pick exactly one per project, copy it in, fill the **Project Parameters** block.

- **`CHARTER_GREENFIELD.md`** — building a new application from scratch. There is no legacy source of truth: the vision is interrogated through Q&A rounds, written specs become the golden standard, and the main risk fought is building the wrong thing confidently.
- **`CHARTER_LEGACY_TRANSFORMATION.md`** — transforming an existing system (spreadsheet, desktop app, old codebase, paper process) into a modern application. The legacy system is the golden source: knowledge is extracted with traceability, conflicts are arbitrated by the system author, and data migration/cutover is part of the deliverable.

## Requirements (`requirements/`)

Cross-cutting requirement documents, referenced by the charters and reusable on their own.

- **`REQUIREMENT_PORTABLE_APPLIANCE.md`** — every application is a portable appliance: the server is disposable, the backup is the system, and `repo + secrets + backup` must rebuild everything on a fresh machine in under 30 minutes.
- **`REQUIREMENT_PROJECT_CLI.md`** — the single-door project CLI: one interactive, `claude`-styled tool that runs the whole lifecycle (`setup` · `adopt` · `update-docs` · `graduate-idea`) as a thin orchestrator over Claude and the embeddable skills, so the rituals run in order and nothing is silently skipped.

## Guides (`guides/`)

Procedures for using the templates themselves.

- **`GUIDE_ADOPTION.md`** — bring these practices into an existing, working project without losing the instructions it already has: a non-destructive merge that inventories what exists, adapts or skips template sections, surfaces every conflict to the owner, and keeps the project running.

## Translations (`i18n/`)

Generated Brazilian Portuguese versions of every template, mirroring the English tree under `i18n/pt-BR/`. The English files are the source of truth; edit those, then regenerate the translations (see the repo's `CLAUDE.md`). Never edit a translation by hand.

## Skills (`skills/`)

Embeddable Claude Code skills an adopting project copies into its own `.claude/skills/`. They live here — never in this repo's `.claude/skills/` — precisely so they stay inert in the meta-project. See `skills/README.md` for the skill-template convention.

- **`graduate-idea/`** — graduate a rough idea from `ideas/inbox.md` into a proper spec: runs a Q&A round to resolve every outcome-changing question, records the decisions, drafts the spec, adds it to the roadmap, and removes the inbox entry. Pairs with the charter's *Idea inbox* practice.
