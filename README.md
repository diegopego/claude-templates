# claude-templates

Reusable working agreements that bootstrap **Claude-driven software projects** — one document gives your AI coding agent a disciplined method (phased discovery, written specs, prototypes, tested delivery) instead of improvising. The product is prompt text: charters, add-on modules, requirements, a guide, and embeddable skills — there is no application to install.

## Install

Clone this repo, open Claude Code **here**, add your project as a working directory, and say what you want:

```sh
git clone https://github.com/diegopego/claude-templates
cd claude-templates
claude                       # then, in the session:  /add-dir ~/path/to/your-project
```

> *"adopt the templates into ~/path/to/your-project"* — an existing project
> *"start a new project at ~/path/to/new-project"* — greenfield
> *"upgrade the templates in ~/path/to/your-project"* — already on an older version

That is the whole install. The agent reads your project, works out which of the three situations you are in, **puts a plan to you before writing anything**, and then writes into your project's working tree. It **never commits there** — your project's own session does that, when you say so. Nothing is ever overwritten.

**Nothing is delivered into your repo to be cleaned up later.** What lands in your project is exactly what your project keeps.

## What happens when you adopt

- **Existing project** — a **non-destructive merge**. The agent inventories your current instructions, classifies each template section as keep / adapt / already-covered / skip per [`GUIDE_ADOPTION.md`](templates/guides/GUIDE_ADOPTION.md), and raises every conflict to you instead of overwriting. You get a merged `CLAUDE.md` in your own voice, a seeded `.claude/memory/`, each kept requirement in one versioned home under `.claude/`, and the `graduate-idea` skill. Code and infrastructure changes are deferred to your roadmap, so the running system is never touched by surprise.
- **New project** — composes your charter (plus any add-on modules) into `.claude/charter/`, seeds a `CLAUDE.md` wired to it, `.claude/memory/`, `ideas/inbox.md` and the skills. The charter's **Setup** step then confirms every parameter with you (stated defaults, never silent assumptions) and **scaffolds a minimum runnable project**, so real work starts against something that already runs.
- **Already adopted an earlier version?** — an **upgrade**, not a re-merge. Every install is stamped with the version it came from (`.claude/memory/template-version.md`), together with what you did with each section and where it landed — so the agent reconciles **only what changed** between your version and the new one. Your own instructions are never re-litigated, and questions you already answered are not asked again. Adopted before stamping existed? Your repo still knows *when* it adopted, and the source commit is dated from that. Anything a past adoption dropped merely to avoid a clash — rather than because you decided against it — comes back to you for a fresh decision instead of quietly hardening into a rule. And a section we delete upstream is never silently deleted from your project: if you have real rules living in it, you keep them, as yours.

Templates improve **from** their adopters: where a real project's practice turned out to be better than the charter, the charter is what got fixed. Friction you hit is worth reporting.

## What you get

- **Charters** — one working agreement per project, [`templates/charters/`](templates/charters/). Pick exactly one, copy it in, fill the **Project Parameters** block:
  - [`CHARTER_GREENFIELD.md`](templates/charters/CHARTER_GREENFIELD.md) — building a new application from scratch: interrogate the vision, turn it into written specs, prototype, then build tested slices. The main risk fought is building the wrong thing confidently.
  - [`CHARTER_LEGACY_TRANSFORMATION.md`](templates/charters/CHARTER_LEGACY_TRANSFORMATION.md) — extracting the knowledge inside an existing system (spreadsheet, old app, paper process) and rebuilding it as a modern application: one or more golden sources, operated rather than merely read, with traceable extraction and a planned cutover.
- **Add-on modules** — [`templates/charters/sources/`](templates/charters/sources/). The shipped charters are deliberately **minimal**; a project that wants more composes these in (ask the agent to re-run assembly with the module added to your charter's row in [`charters.manifest.md`](templates/charters/sources/charters.manifest.md)):
  - `MODULE_PRODUCT_AUDIENCE` — your project is a product for an audience: multi-tenant *and* multi-user from v1 (your organization is tenant #1, a person belongs to several tenants with a role in each), domain rules separated from instance configuration.
  - `MODULE_LIVING_DOCS` — curated changelogs for maintainers and users, plus a living product doc rendered as a landing page whose skin is designed once at Setup and whose every publish passes your approval. Its pipeline is automated by the `update-living-docs` skill (rebuild + update).
- **Requirements** — [`templates/requirements/`](templates/requirements/):
  - [`REQUIREMENT_PORTABLE_APPLIANCE.md`](templates/requirements/REQUIREMENT_PORTABLE_APPLIANCE.md) — every application must be destroyable and rebuildable on a fresh machine from `repo + secrets + backup` in under 30 minutes.
- **Adoption guide** — [`templates/guides/GUIDE_ADOPTION.md`](templates/guides/GUIDE_ADOPTION.md): the non-destructive merge above, the new-project path, and the upgrade path, written out in full. It is the authority the adoption skill executes.
- **Embeddable skills** — [`templates/skills/`](templates/skills/): Claude Code skills that land in your project's `.claude/skills/` and stay:
  - **`graduate-idea`** — drives a rough idea from the inbox through a Q&A round into an agreed spec on the roadmap. Installed by every adoption.
  - **`update-living-docs`** — the executable arm of `MODULE_LIVING_DOCS`, and installed only with that module: builds and keeps your living docs current — the dual changelogs, the living product doc, and its landing page. Two modes: **rebuild** (regenerate the whole set from your project's current state — for a large project adopting the pipeline mid-life, or a forced re-creation) and **update** (fold one change in incrementally); the landing publishes only behind an approval loop.

  The **adoption skill itself is not one of them.** It runs in the templates clone, not in your repo — one door, and nothing to uninstall afterwards.

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
