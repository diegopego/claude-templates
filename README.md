# claude-templates

Reusable working agreements that bootstrap **Claude-driven software projects** — one document gives your AI coding agent a disciplined method (phased discovery, written specs, prototypes, tested delivery) instead of improvising. The product is prompt text: charters, add-on modules, requirements, a guide, and embeddable skills — there is no application to install.

## Install

Clone this repo and point the installer at your project's folder — that is the whole install:

```sh
git clone https://github.com/diegopego/claude-templates
cd claude-templates

make adopt DEST=~/path/to/your-project                    # existing project
make new   DEST=~/path/to/new-project CHARTER=greenfield  # or CHARTER=legacy
```

Then open Claude Code **in your project** and paste the prompt the installer just printed:

- **Existing project** → `Adopt the templates in agent/ into this project.`
- **New project** → `Read CLAUDE.md and start Setup.`

Done — the installer only adds files, **nothing is ever overwritten**. Already have a Claude Code session open in the project? Run **`/reload-skills`** there first (skills load at startup). No `make`? Copying the files by hand works exactly the same — the installer is convenience, not machinery.

## What happens when you adopt

- **Existing project** (`make adopt`) — a **non-destructive merge**. The agent inventories your current instructions, keeps or adapts each template section per [`GUIDE_ADOPTION.md`](templates/guides/GUIDE_ADOPTION.md), and raises every conflict to you instead of overwriting. Code and infrastructure changes are deferred to a roadmap, so the running system is never touched by surprise. When the merge is done it tidies up after itself: each section you keep lands in a single versioned home (under `.claude/` by default) and the one-shot delivery kit and `adopt-template` skill are removed — while the permanent `graduate-idea` skill (and `update-living-docs` if you took the living-docs module) stays.
- **New project** (`make new`) — composes your charter (plus any add-on modules) and seeds the kit: a `CLAUDE.md` wired to the charter, a `.claude/memory/`, an `ideas/inbox.md`, and the `graduate-idea` skill. The charter's **Setup** step then confirms every parameter with you (stated defaults, never silent assumptions) and **scaffolds a minimum runnable project**, so real work starts against something that already runs.

Files land in a namespaced `agent/` folder by default (override with `PREFIX=…`).

## What you get

- **Charters** — one working agreement per project, [`templates/charters/`](templates/charters/). Pick exactly one, copy it in, fill the **Project Parameters** block:
  - [`CHARTER_GREENFIELD.md`](templates/charters/CHARTER_GREENFIELD.md) — building a new application from scratch: interrogate the vision, turn it into written specs, prototype, then build tested slices. The main risk fought is building the wrong thing confidently.
  - [`CHARTER_LEGACY_TRANSFORMATION.md`](templates/charters/CHARTER_LEGACY_TRANSFORMATION.md) — extracting the knowledge inside an existing system (spreadsheet, old app, paper process) and rebuilding it as a modern application, with traceable extraction, data migration, and cutover.
- **Add-on modules** — [`templates/charters/sources/`](templates/charters/sources/). The shipped charters are deliberately **minimal**; a project that wants more composes these in (ask the agent to re-run assembly with the module added to your charter's row in [`charters.manifest.md`](templates/charters/sources/charters.manifest.md)):
  - `MODULE_PRODUCT_AUDIENCE` — your project is a product for an audience: multi-tenant from v1 (your organization is tenant #1, with an operator-level way to create the next one), domain rules separated from instance configuration.
  - `MODULE_LIVING_DOCS` — curated changelogs for maintainers and users, plus a living product doc rendered as a landing page whose skin is designed once at Setup and whose every publish passes your approval. Its pipeline is automated by the `update-living-docs` skill (rebuild + update).
  - `MODULE_DATA_MIGRATION` — migration and cutover rules; built into the legacy charter, addable to a greenfield project that imports inherited data.
- **Requirements** — [`templates/requirements/`](templates/requirements/):
  - [`REQUIREMENT_PORTABLE_APPLIANCE.md`](templates/requirements/REQUIREMENT_PORTABLE_APPLIANCE.md) — every application must be destroyable and rebuildable on a fresh machine from `repo + secrets + backup` in under 30 minutes.
- **Adoption guide** — [`templates/guides/GUIDE_ADOPTION.md`](templates/guides/GUIDE_ADOPTION.md): the non-destructive merge above, written out in full.
- **Embeddable skills** — [`templates/skills/`](templates/skills/): drop-in Claude Code skills an adopting project copies into its own `.claude/skills/`:
  - **`graduate-idea`** — drives a rough idea from the inbox through a Q&A round into an agreed spec on the roadmap.
  - **`adopt-template`** — runs the adoption guide for you: inventories an existing project's instructions, classifies each template section, and produces a merged `CLAUDE.md` with every conflict raised to you.
  - **`update-living-docs`** — the executable arm of `MODULE_LIVING_DOCS`: builds and keeps a project's living docs current — the dual changelogs, the living product doc, and its landing page. Two modes: **rebuild** (regenerate the whole set from the project's current state — for a large project adopting the pipeline mid-life, or a forced re-creation) and **update** (fold one change in incrementally); the landing publishes only behind an approval loop.

Templates are authored in **English** (translations return when an adopter asks for them).

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

> This is the living landing page — the current state of what the templates offer. For the history of changes, see [`CHANGELOG.md`](CHANGELOG.md).
