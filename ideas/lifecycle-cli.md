# Lifecycle CLI — the single door to a charter-driven project

Status: deferred
Applies to: a future `REQUIREMENT_PROJECT_CLI.md` deliverable (existed as one from 2026-07-11 until the same-day rewrite, when it was parked back here — see `.claude/memory/decisions.md`, *Rewrite from scratch in ideal form*)

## Behavior

When a project wants its whole lifecycle behind one tool, it builds an interactive, prompt-first CLI styled after `claude` — a **thin, deterministic orchestrator over Claude and the embeddable skills**, never a second brain:

- `setup` — runs the charter's Setup interview (Project Parameters, stack) and scaffolds the minimum runnable project.
- `adopt` — runs the `GUIDE_ADOPTION.md` non-destructive merge for an existing project.
- `update-docs` — regenerates changelogs / living doc / landing from the delta since its last run (a versioned last-processed-commit marker), ending in a publish approval loop. Only meaningful for projects using `MODULE_LIVING_DOCS`.
- `graduate-idea` — the `graduate-idea` skill surfaced as a command.

Invariants settled in the 2026-07-11 Q&A rounds: each subcommand **invokes** the matching skill (which stays usable stand-alone); the CLI sequences rituals so nothing is silently skipped, with any pre-commit hook as backstop; its config is versioned in-repo under `.claude/`; publishing always passes intent → preview → approval; distribution/runtime and exact flags are implementation concerns.

## Why

A single door keeps the rituals in order without the owner memorizing them. But it is a spec for software no adopter has asked to build — shipping it as a normative deliverable was speculation.

## Reactivation criterion

A real adopting project wants to build the tool. Then this spec graduates back into a `REQUIREMENT_PROJECT_CLI.md` deliverable (the full earlier text is in git history at `templates/requirements/REQUIREMENT_PROJECT_CLI.md`, commit `600a06b` and earlier).

## Open questions

- None while deferred.
