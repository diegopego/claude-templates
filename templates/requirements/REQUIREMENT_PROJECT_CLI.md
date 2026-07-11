# General Requirement: The Project CLI

> The single door to a charter-driven project's lifecycle. Referenced by the charter's *Setup scaffolding*; a real project or a shared toolchain builds the tool — this document specifies it.

## Principle

One tool covers the whole lifecycle, so the steps run in the right order and nothing is silently skipped.
The CLI is **interactive and prompt-first**, styled after the `claude` CLI — a conversation, not a batch of flags.
It is a **thin, deterministic orchestrator over Claude and the embeddable skills**: it owns the command surface, argument handling, and the ordering rituals; the judgment-heavy steps run as Claude conversations and skills underneath. The charter's conversational phases stay authoritative for judgment; the CLI operationalizes the deterministic scaffolding, wiring, and sequencing around them.

## Command surface

Every project exposes these subcommands (exact flags are the implementation's choice):

| Command | Contract |
|---|---|
| `setup` | Runs the Setup (step 0) interview — Project Parameters, technology stack, target audience, landing skin — and **scaffolds** the project: skeleton + config for the chosen stack, a `CLAUDE.md` referencing the charter, and a seeded `.claude/memory/`. Delivers the charter's *Setup scaffolding*. |
| `adopt` | Brings the practices into an **existing** project via the non-destructive merge in `GUIDE_ADOPTION.md`: inventory existing instructions → propose merge → apply on approval. Never overwrites; every conflict is surfaced to the owner. |
| `update-docs` | Runs the delta-driven documentation pipeline from a versioned last-processed-commit marker: technical + audience changelogs → living product doc → landing page, ending in the publish approval loop (intent → preview → approval → publish). Advances the marker when it completes. |
| `graduate-idea` | Drives an `ideas/inbox.md` entry through its Q&A round into an agreed spec + roadmap entry — the `graduate-idea` skill surfaced as a command. |

## Invariants (mandatory in any implementation)

- **Interactive, prompt-first.** Modeled on `claude`: the judgment-heavy steps run as Claude conversations the CLI drives — it sequences and wires them, it does not replace them.
- **A thin orchestrator, not a second brain.** The CLI owns the command surface, argument handling, and the ordering rituals (e.g. assemble → update-docs → translate → changelog). The judgment stays in the charter phases and the skills.
- **Invokes the skills; never absorbs them.** Each subcommand **invokes** the matching embeddable skill (`graduate-idea`, `update-product-doc`, …), which stays usable stand-alone inside Claude Code. The CLI is a second entry point to the same skills, not a reimplementation of them.
- **Rituals run in order, nothing skipped.** The CLI guarantees the sequence so no step — assemble, translate, changelog, landing refresh — is silently dropped.
- **The pre-commit hook stays the backstop.** The CLI is the happy path that runs the rituals in order; the repository's pre-commit freshness hook remains as a **safety net** that blocks a commit which skipped a step (e.g. one made without the CLI). CLI and hook are belt-and-suspenders, not either/or.
- **Config is versioned in the repo.** Project-local CLI state — the last-processed-commit marker, the landing skin tokens, the recorded stack choices — lives under `.claude/`, versioned with the code (consistent with the charter's *Versioned, in-repo memory*). A fresh clone carries everything the CLI needs.
- **Publishing passes the approval loop.** `update-docs` never publishes the landing silently: statement of intent → rendered preview → owner approval → publish.

## Non-goals (out of scope for this requirement)

- **Distribution & runtime.** The CLI's implementation language, install path, and packaging are the building project's choice, deliberately unspecified here.
- **Exact flags and config-file format.** The subcommand contracts are fixed; their precise flag surface and the on-disk shape of the config are implementation details.
- **Replacing judgment.** The CLI makes no product, scope, or architecture decisions; those stay in the charter's Q&A rounds.
- **A parallel source of truth.** The CLI reads and advances the same repo memory, changelogs, and specs; it introduces no store of its own.

## Definition of done

A developer with a fresh checkout can:

1. `setup` a new project and get a **runnable, scaffolded** skeleton wired to a charter and a seeded `.claude/memory/`.
2. `adopt` the practices into an existing repo **without losing its instructions**.
3. `update-docs` to regenerate the changelogs, living doc, and landing from the delta since the last run, and publish **only after approval**.
4. `graduate-idea` to turn an inbox note into an agreed spec + roadmap entry.

Each command runs its underlying skill or charter phase; none silently skips a ritual step. The CLI never consumes more effort than the project it serves.
