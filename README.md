# claude-templates

Reusable working agreements that bootstrap **Claude-driven software projects**. Copy one document into your repo, fill in a short parameters block, and your AI coding agent has a disciplined method to follow — phased discovery, written specs, prototypes, tested delivery — instead of improvising.

The product here is prompt text: charters, requirements, and guides. There is no application to install.

> This is the living landing page — the current state of what the templates offer. For the history of changes, see [`changelog/`](changelog/).

## What you get

- **Charters** — one working agreement per project, [`templates/charters/`](templates/charters/):
  - **Greenfield** — building a new application from scratch: interrogate the vision, turn it into written specs, prototype, then build tested slices.
  - **Legacy transformation** — extracting the knowledge inside an existing system (spreadsheet, old app, paper process) and rebuilding it as a modern application, with data migration and cutover.
- **Requirements** — [`templates/requirements/`](templates/requirements/):
  - **Portable appliance** — every application must be destroyable and rebuildable on a fresh machine from `repo + secrets + backup` in under 30 minutes.
  - **Project CLI** — one interactive, `claude`-styled tool that runs a project's whole lifecycle (`setup` · `adopt` · `update-docs` · `graduate-idea`) as a thin orchestrator over Claude and the skills, so the rituals run in order and nothing is silently skipped.
- **Adoption guide** — [`templates/guides/GUIDE_ADOPTION.md`](templates/guides/GUIDE_ADOPTION.md): bring these practices into a project that already exists and works, without losing the instructions it already has.
- **Embeddable skills** — [`templates/skills/`](templates/skills/): drop-in Claude Code skills an adopting project copies into its own `.claude/skills/`. Two so far: **`graduate-idea`**, which drives a rough idea from the inbox through its Q&A round into an agreed spec on the roadmap; and **`adopt-template`**, which runs the adoption guide for you — inventorying an existing project's instructions, classifying each template section, and producing a merged `CLAUDE.md` with every conflict raised to you.

The full index is the catalog at [`templates/README.md`](templates/README.md). Every template also ships a generated Brazilian Portuguese version under [`templates/i18n/pt-BR/`](templates/i18n/pt-BR/) — the English file is the source of truth.

## How to adopt

- **New project** — pick the charter that fits, copy it into your repo, and reference it from your project's `CLAUDE.md`. The charter opens with a **Setup** step: the agent confirms every project parameter with you (languages, product scope, users, …) *and* settles your stack and language, then **scaffolds a runnable project** — skeleton, config, a `CLAUDE.md` wired to the charter, and seeded memory — so real work starts against a project that already runs, not a blank folder. Setup also runs a short design interview to fix your landing page's visual skin, once.
- **Existing project** — follow the adoption guide, or drop in the **`adopt-template`** skill and let the agent run it: either way it inventories your current instructions, keeps or adapts each template section, raises every conflict to you instead of overwriting, and defers code/infra changes to a roadmap so the running system is never touched by surprise.

## What the charters give a project

- A phased method — **Setup → Discover/Understand → Align → Specify → Prototype → Build** — where the agent always states which phase it is in.
- **Q&A rounds** as the engine that moves each phase forward — related questions asked together, each with options and a recommendation, a scripted baseline then adaptive follow-ups, and every answer written down as a spec or a decision. Defined once so the agent asks well instead of guessing.
- **Product for an audience, not a bespoke tool** — what you build is a multi-tenant product from v1; the first organization is tenant #1, and its specifics become configuration, not hardcoded behavior.
- **Setup that scaffolds** — Setup doesn't just record parameters; it generates a minimum runnable project from your answers, and the charter's tech picks are **recommended, overridable defaults you confirm at Setup**, never silent assumptions.
- **Modern strict TypeScript** as the recommended default, used to encode business rules in the type system.
- **Anti-over-engineering** — boring solutions, few dependencies, seams not scaffolding.
- **Functional core, imperative shell** with TDD; agreed specs are the test oracles.
- **Versioned in-repo memory** — roadmap and decision log live in the repo, so a fresh clone can resume the work.
- **Two changelogs, two rhythms** — a technical changelog (updated every commit, git history as its raw record) and one written for your product's users (curated per significant change); the users' changelog is the natural source for an always-current product summary.
- **A living landing page** — that always-current summary is rendered into a public landing page whose **visual skin is designed once at Setup** (a short design interview — theme, palette, a reference site you like — with Claude Design) and whose content then regenerates from the summary as the product changes. Every publish passes an **approval loop**: you see the intent in words, then a preview, and nothing goes public without your OK.
- **Idea inbox** — a scratchpad for half-formed ideas that graduates, on request, into a proper spec through a Q&A round; the inbox is where scope is proposed, the roadmap where it is accepted. The `graduate-idea` skill automates the ritual.
- **Spec-driven work** — every non-trivial task becomes a short spec before it is built; when a requirement can't be pinned down, the agent asks up front in a Q&A round instead of guessing and encoding the guess.
- **Portable-appliance** delivery and **explicit git authorization** (the agent never commits on its own).

## Languages

Templates are authored in English (the source of truth) with generated pt-BR translations. In your own project the charter's language protocol lets you converse in your language while keeping engineering artifacts in English and user-facing text in your users' language.
