# claude-templates

Reusable working agreements that bootstrap **Claude-driven software projects**. Copy one document into your repo, fill in a short parameters block, and your AI coding agent has a disciplined method to follow — phased discovery, written specs, prototypes, tested delivery — instead of improvising.

The product here is prompt text: charters, add-on modules, requirements, a guide, and embeddable skills. There is no application to install.

> This is the living landing page — the current state of what the templates offer. For the history of changes, see [`CHANGELOG.md`](CHANGELOG.md).

## What you get

- **Charters** — one working agreement per project, [`templates/charters/`](templates/charters/). Pick exactly one, copy it in, fill the **Project Parameters** block:
  - [`CHARTER_GREENFIELD.md`](templates/charters/CHARTER_GREENFIELD.md) — building a new application from scratch: interrogate the vision, turn it into written specs, prototype, then build tested slices. The main risk fought is building the wrong thing confidently.
  - [`CHARTER_LEGACY_TRANSFORMATION.md`](templates/charters/CHARTER_LEGACY_TRANSFORMATION.md) — extracting the knowledge inside an existing system (spreadsheet, old app, paper process) and rebuilding it as a modern application, with traceable extraction, data migration, and cutover.
- **Add-on modules** — [`templates/charters/sources/`](templates/charters/sources/). The shipped charters are deliberately **minimal**; a project that wants more composes these in (ask the agent to re-run assembly with the module added to your charter's row in [`charters.manifest.md`](templates/charters/sources/charters.manifest.md)):
  - `MODULE_PRODUCT_AUDIENCE` — your project is a product for an audience: multi-tenant from v1 (your organization is tenant #1, with an operator-level way to create the next one), domain rules separated from instance configuration.
  - `MODULE_LIVING_DOCS` — curated changelogs for maintainers and users, plus a living product doc rendered as a landing page whose skin is designed once at Setup and whose every publish passes your approval.
  - `MODULE_DATA_MIGRATION` — migration and cutover rules; built into the legacy charter, addable to a greenfield project that imports inherited data.
- **Requirements** — [`templates/requirements/`](templates/requirements/):
  - [`REQUIREMENT_PORTABLE_APPLIANCE.md`](templates/requirements/REQUIREMENT_PORTABLE_APPLIANCE.md) — every application must be destroyable and rebuildable on a fresh machine from `repo + secrets + backup` in under 30 minutes.
- **Adoption guide** — [`templates/guides/GUIDE_ADOPTION.md`](templates/guides/GUIDE_ADOPTION.md): bring these practices into a project that already exists and works, without losing the instructions it already has.
- **Embeddable skills** — [`templates/skills/`](templates/skills/): drop-in Claude Code skills an adopting project copies into its own `.claude/skills/`:
  - **`graduate-idea`** — drives a rough idea from the inbox through a Q&A round into an agreed spec on the roadmap.
  - **`adopt-template`** — runs the adoption guide for you: inventories an existing project's instructions, classifies each template section, and produces a merged `CLAUDE.md` with every conflict raised to you.

Templates are authored in **English** (translations return when an adopter asks for them).

## How to adopt

The repo ships an **installer** — clone it and run `make` with your project's destination (files land in a namespaced `agent/` folder by default, override with `PREFIX=…`; nothing is ever overwritten):

```sh
make new   DEST=~/devel/myapp CHARTER=greenfield   # or legacy; add MODULES="product-audience living-docs"
make adopt DEST=~/devel/existing-project
```

- **New project** (`make new`) — composes the charter (with any add-on modules) into `DEST/agent/charters/`, copies the appliance requirement, and seeds the kit: a `CLAUDE.md` wired to the charter, `.claude/memory/`, `ideas/inbox.md`, and the `graduate-idea` skill. Then open Claude Code in the project and say *"read CLAUDE.md and start Setup"* — the charter's **Setup** step confirms every parameter with you (stated defaults, never silent assumptions) and **scaffolds a minimum runnable project**, so real work starts against a project that already runs.
- **Existing project** (`make adopt`) — copies the template set and the **`adopt-template`** skill into the project and touches nothing else. Then ask the agent to adopt: it inventories your current instructions, keeps or adapts each template section per the [adoption guide](templates/guides/GUIDE_ADOPTION.md), raises every conflict to you instead of overwriting, and defers code/infra changes to a roadmap so the running system is never touched by surprise.

No `make`? Copying the files by hand works exactly the same — the installer is convenience, not machinery: composed charters travel with `requirements/` (relative links), skills go into `.claude/skills/`.

## What the charters give a project

- A phased method — **Setup → Discover/Understand → Align → Specify → Prototype → Build** — where the agent always states which phase it is in.
- **Q&A rounds** as the engine that moves each phase forward — related questions asked together, each with options and a recommendation, a scripted baseline then adaptive follow-ups, and every answer written down as a spec or a decision. Defined once, in the Method section, so the agent asks well instead of guessing.
- **Modern strict TypeScript** as the recommended default stack — confirmed or replaced at Setup, never assumed silently — used to encode business rules in the type system.
- **Anti-over-engineering** — boring solutions, few dependencies, seams not scaffolding.
- **Functional core, imperative shell** with TDD; the agreed specs are the test oracles.
- **Versioned in-repo memory** — roadmap and decision log live in the repo, so a fresh clone can resume the work.
- **Ideas & specs** — a scratchpad inbox that graduates ideas into proper specs through a Q&A round, and spec-driven work: every non-trivial task becomes a short spec before it is built.
- **Portable-appliance** delivery and **explicit git authorization** (the agent never commits on its own).

The opinionated practices — multi-tenancy from v1, dual changelogs, a designed landing page — are **opt-in modules**, not defaults: you add them when your project is that kind of project.
