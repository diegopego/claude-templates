# Changelog

Curated for template adopters, one entry per significant change (newest first). The git history is the full technical record underneath. Entries before 2026-07-11 live in the old `changelog/` directory, reachable in git history.

## 2026-07-11 — Adopted projects keep the `graduate-idea` skill

Adoption now leaves a project with the skills its charter actually prescribes. `make adopt` installs **`graduate-idea`** (the idea-inbox/graduation practice every charter carries) and seeds an empty `ideas/inbox.md` if the project has none — additively, never overwriting. Before, adoption shipped only the one-shot `adopt-template`, which the merge removes at teardown, so an adopted project ended up with **no skills at all** — including the one its own `CLAUDE.md` told it to use. `graduate-idea` (and `update-living-docs` if you adopt the living-docs module) is permanent; only `adopt-template` and the delivery kit are torn down.

## 2026-07-11 — New skill: `update-living-docs` builds and maintains your living docs

`MODULE_LIVING_DOCS` now ships an executable arm. The new **`update-living-docs`** embeddable skill runs the whole living-documentation pipeline — the dual changelogs (technical + audience), the living product doc, and the landing page — so the practice is automated, not just described. Two modes: **rebuild** regenerates the whole set from your project's current state (the path for a large project adopting the pipeline mid-life, or a forced re-creation — it reconciles an existing changelog into the technical/audience split and seeds the audience changelog from what the product does today), and **update** folds a single change in incrementally. The landing still publishes only behind the approval loop. The skill is delivered with the module: `make new … MODULES="living-docs"` installs it, and it travels in the adoption kit so a project that adopts the module gets it too.

## 2026-07-11 — Adoption cleans up after itself

Adopting into an existing project now ends tidily. Once the merge is done, each template section you chose to **keep** lands in a single versioned home — under `.claude/` by default (e.g. `.claude/requirements/`), referenced by your merged `CLAUDE.md` — and the delivered kit (the `agent/` folder) plus the one-shot `adopt-template` skill are removed. No more duplicate copies of a requirement sitting in both `agent/` and your repo, quietly drifting apart. Both the adoption guide and the `adopt-template` skill gained an explicit final teardown step; the installer is unchanged. Surfaced by the first real adoption.

## 2026-07-11 — Installer: `make new` / `make adopt` with a destination

Adoption is now one command from a clone of this repo. `make new DEST=~/devel/myapp CHARTER=greenfield|legacy [MODULES="product-audience living-docs data-migration"]` composes the charter (add-on modules included on demand) into a namespaced `agent/` folder (`PREFIX=` overrides), copies the appliance requirement, and seeds the working kit — `CLAUDE.md` wired to the charter, `.claude/memory/`, `ideas/inbox.md`, and the `graduate-idea` skill. `make adopt DEST=~/devel/existing` delivers the template set plus the `adopt-template` skill and touches nothing else. Nothing is ever overwritten. Under the hood, charter assembly is now a deterministic script (`tools/assemble.py`) — the same engine regenerates the shipped charters and backs the repo's freshness checks — and the template repo itself installs its own skills with `make adopt DEST=.` (it is its own first adopter). A new `templates/CLAUDE_MD.template.md` deliverable is the stub `make new` instantiates.

Field fixes from the first real install: `DEST=~/…` now works (the literal `~` shells pass through is expanded by the installer), and the installer, README, landing, and skills catalog now say the missing step out loud — skills load at session startup, so a Claude Code session already open in the target project needs **`/reload-skills`** before it can run the installed skill.

## 2026-07-11 — Public landing page on GitHub Pages

The template catalog now has a public landing at **https://diegopego.github.io/claude-templates/** — a rendered view of the repo's `README.md`, regenerated with every adopter-facing commit (hook-enforced). It replaces the previous private Artifact page.

## 2026-07-11 — Rewrite: minimal charters, opt-in modules, leaner meta-project

The whole template set was re-authored from scratch in its ideal form. If you copied a charter before this date, the practices are the same in spirit — but slimmer, deduplicated, and with the heavyweight opinions made optional.

- **Charters slimmed** from 18 sections to 12 (greenfield) / 13 (legacy). The Q&A-round method is now defined once, inside the Method section; *Idea inbox* and *Spec-driven work* merged into one *Ideas & specs* section; *Memory*, *Roadmap & decision log* merged into one. No practice was weakened — the text just says each thing once.
- **Opinionated practices became opt-in add-on modules** instead of mandatory core: `MODULE_PRODUCT_AUDIENCE` (product for an audience, multi-tenant from v1, domain vs. instance) and `MODULE_LIVING_DOCS` (dual changelogs, living product doc, designed landing page with a publish approval loop). Add a module to your charter's manifest row and re-run assembly when your project is that kind of project. `MODULE_DATA_MIGRATION` remains built into the legacy charter and addable to greenfield.
- **The legacy charter's extraction rules gained "Classify on extraction"**: every extracted rule is tagged domain | instance-config | workaround, so instance values become configuration even without the product-audience module.
- **The Project CLI requirement was parked.** `REQUIREMENT_PROJECT_CLI.md` (a spec for a single-door lifecycle CLI) moved back to the idea stage (`ideas/lifecycle-cli.md`, deferred) until a real adopting project wants to build it. The charters no longer reference it.
- **Brazilian Portuguese translations were dropped.** Templates ship in English only; translations return when an adopting project asks for them.
- **One changelog instead of two.** This file replaces the previous `changelog/maintainer.md` + `changelog/adopter.md` pair.
