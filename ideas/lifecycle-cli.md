# lifecycle-cli

Status: incorporated
Applies to: a new `REQUIREMENT_` deliverable (the CLI is specified here; adopter projects / a toolchain implement it). Touches core (Setup phase) and the update/adopt skills.

## Behavior

The templates specify a **project CLI** — the single door to a charter-driven project's lifecycle, styled after the `claude` CLI (interactive, prompt-first). One tool covers the whole lifecycle rather than a scatter of scripts and skills:

- **`setup`** — runs the Setup (step 0) interview (Project Parameters, tech stack, target audience, design) and **scaffolds** the project: skeleton + config for the chosen stack, `CLAUDE.md` referencing the charter, and a seeded `.claude/memory/` (see [setup-scaffolds-project.md](setup-scaffolds-project.md)).
- **`adopt`** — brings the practices into an existing project via the non-destructive merge (see `GUIDE_ADOPTION.md`): inventory existing instructions → propose merge → apply with approval.
- **`update-docs`** — runs the delta-driven documentation pipeline: technical + target-audience changelogs → living-product-doc → landing page, with the publish approval loop (see [living-product-doc.md](living-product-doc.md), [audience-aware-changelogs.md](audience-aware-changelogs.md), [landing-publishing.md](landing-publishing.md)).
- **`graduate-idea`** — drives an inbox idea through its Q&A round into an agreed spec + roadmap entry (the existing `graduate-idea` skill, surfaced as a command).

The CLI is a thin, deterministic **orchestrator over Claude and the embeddable skills** — it owns the command surface, argument handling, and the ordering rituals (e.g. assemble → update-docs → translate → changelog), while the judgment-heavy steps run as Claude conversations / skills underneath. The charter's conversational phases stay authoritative for judgment; the CLI operationalizes the deterministic scaffolding, wiring, and sequencing around them.

## Why

A project has many variations, and its lifecycle steps (setup, adopt, doc updates, idea graduation) are today spread across separate skills and manual rituals. A single CLI gives the developer one predictable entry point — like `claude` itself — that guarantees the steps run in the right order and nothing (translation, changelog, landing refresh) is silently skipped. Specifying it now (rather than deferring) pins the command surface so the skills and charter phases can be designed to plug into it.

## Example

`myproj setup` → interview + scaffold a runnable Node/strict-TS project. Later, `myproj update-docs` → regenerates the changelogs and landing from the delta since the last-processed-commit marker, previews the landing, waits for approval, publishes. `myproj adopt` in a legacy repo → inventories its `CLAUDE.md`, proposes a merge, applies on approval.

## Resolved (Q&A round, 2026-07-10)

- **Specify now** (against the agent's recommendation to defer as a future direction) — the owner wants the CLI pinned down now.
- **Scope: full lifecycle** — the single door for setup, adopt, doc/landing updates, idea graduation (not Setup-only, not a thin convenience wrapper). Rejected: Setup+scaffold-only (too narrow for the owner's intent) and a pure wrapper with no orchestration rituals.
- **We ship the specification, not the implementation** — as a meta-project (text only, no application code), the deliverable graduates into a `REQUIREMENT_` (e.g. `REQUIREMENT_PROJECT_CLI.md`); a real project or a shared toolchain builds the CLI.

## Open questions

- Command surface details: exact subcommand names and flags, and how project-local config is stored/read.
- Relationship to the embeddable skills: does the CLI **invoke** the skills, or do the skills become **subcommands** of the CLI (leaning: invoke, so skills stay usable stand-alone inside Claude Code).
- Distribution/runtime of the CLI (language, install path) — an implementation concern for the project that builds it, deliberately left out of the `REQUIREMENT_`.
- Does the CLI subsume the pre-commit hook's rituals, or run alongside it?
