# Changelog

Curated for template adopters, one entry per significant change (newest first). The git history is the full technical record underneath. Entries before 2026-07-11 live in the old `changelog/` directory, reachable in git history.

## 2026-07-12 — The legacy charter, corrected by a third project that never used it

A third project — built independently, with its own well-articulated working agreements — was mapped against the charter section by section. Where the two disagreed, it was mostly the **charter** that was wrong. Six corrections, and the ones you will notice:

- **Your golden source may not be alone.** The charter assumed one legacy system. Real projects have several — a workbook *and* the licensed manual its rates were transcribed from; a sheet *and* the scripts bolted onto it. Name each source in the Project Parameters, say which one wins where two can disagree, and cite **which** source every extracted rule came from. Two golden sources that contradict each other is a question for you, never something the agent quietly resolves.
- **The agent should *operate* your legacy system, not just read it.** Reading formulas does not find defects — driving the thing does. The charter now tells the agent to exercise the system through whatever surface it has (an API, a browser driver, a script harness), change an input, force an edge case, and watch what recalculates. Probing writes are welcome but disciplined: snapshot → write → recalculate → read → restore, no residue. This came from a project where a single dropdown change exposed an error that months of reading would not have.
- **Extraction corrects the copy.** *"A copy, not production"* used to read as *never touch it*. In practice extraction finds genuine errors in the golden source — one project measured 22 in a single tab. Now: report each with evidence, fix it in the copy, and you reconcile it back into production and re-provide the copy. A correction is a traceable output of extraction, not a violation of it.
- **Data migration is gone; cutover stays.** The legacy charter no longer carries an import methodology. It bundled two things that only looked alike: **cutover** — the old system keeps running while the app is built, so plan the freeze, the parallel run, and a re-verification of the rules before switching — is true even of a project that inherits **zero** rows, and it is now its own charter section. **Historical data** is your project's business: if you carry records over, that import is a feature you specify and roadmap like any other. If you already run an older version and you *do* migrate history, keep your section — the upgrade should record that as a decision, not drop it.
- **Multi-tenant now says how users relate to tenants.** `MODULE_PRODUCT_AUDIENCE` mandated multi-tenancy and left the model to you. It now states it: a person belongs to **one or more** tenants with a role in each, one shared user base, every permission hanging off the membership (user × tenant × role) rather than the user. So a session has a *current* tenant, every query is scoped by membership, and inviting an existing user into a second tenant does not create a second account. Cheap now, expensive to retrofit.
- **Changelogs are curated, not per commit.** `MODULE_LIVING_DOCS` asked for a technical changelog *per commit* — a hand-maintained duplicate of `git log` that rots. Both changelogs are now curated **per significant change**, with the git history as the raw record underneath.

## 2026-07-12 — `make upgrade`: one command for the version diff, no kit to install

The upgrade path gets its own command, from the first real run of it. **`make upgrade DEST=…`** reads your project's stamp, prints exactly which template files changed since — and whether any of them is charter text that would fold into your `CLAUDE.md` — and tells you the commit to stamp next. It **installs nothing**: an upgrade needs a diff, not a copy, so there is no delivery kit to tear down afterwards (`make adopt` still ships one, for adopters who do not have the template clone at hand).

**Adopted before stamping existed?** You are not asked for a commit hash you cannot know. Your repo still records *when* it adopted, and the command resolves the source commit from that instant — then shows you the diff so a wrong guess is visibly wrong before anything is written.

## 2026-07-12 — Re-adopting a newer version is now an upgrade, not a re-merge

If you adopted these templates and later re-run `make adopt` with a newer version, the agent used to treat your `CLAUDE.md` — which *is* the filled-in charter it produced last time — as if it were foreign instructions, and ask you to re-decide the whole thing. No longer:

- **Every install is stamped.** `make adopt` marks the delivered kit with the template repo's commit, and adoption records it in your project as `.claude/memory/template-version.md` (source commit, charter, modules, a pointer to the dispositions). `make new` seeds it directly. The kit is torn down; the stamp survives.
- **A third branch: upgrade.** [`GUIDE_ADOPTION.md`](templates/guides/GUIDE_ADOPTION.md) and the `adopt-template` skill now recognize three situations, not two — no instructions (seed), your own instructions (merge), and *an earlier version of these templates* (upgrade). The upgrade reconciles **only the diff between your version and the kit's**; text you already carry unchanged, and every section you wrote yourself, is left alone.
- **Workarounds stop hardening into law.** Each disposition an adoption records is now tagged *architectural* (you decided this) or *conflict-avoided* (it only dodged a collision). On upgrade the architectural ones stand and the conflict-avoided ones come back to you — because the clash they dodged may not exist anymore. Untagged entries from an older adoption are re-confirmed. This came from a real adoption where a requirement dropped purely to avoid a clash was later read back as a binding *skip*.
- **The kit ships every module.** Adoption now delivers the charter sources whole — all add-on modules plus the manifest, and each module's paired skill — so adopting `MODULE_PRODUCT_AUDIENCE` or `MODULE_DATA_MIGRATION` à la carte finally has the source text it needs. Previously only `MODULE_LIVING_DOCS` travelled.

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
