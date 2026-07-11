# Roadmap

Single source of direction. Every session starts by reading this file and ends by updating it. Work not listed here is scope creep until the owner adds it.

## Milestone 1 — Meta-project structure (v0)

- [x] Root CLAUDE.md describing the meta-project (2026-07-10)
- [x] Reorganize deliverables into `templates/charters/` and `templates/requirements/`, with a catalog README (2026-07-10)
- [x] `ideas/` spec format established, first three specs written (2026-07-10)
- [x] Versioned in-repo memory (`.claude/memory/`) and audience changelogs (`changelog/`) (2026-07-10)
- [x] pt-BR translation pipeline: `translate-templates` skill + pre-commit freshness hook (2026-07-10)

## Milestone 2 — Charter modularization ✅ (2026-07-10)

- [x] Decompose the two charters into a shared core (`templates/charters/sources/CHARTER_CORE.md`: phases, roles, product-for-an-audience, languages, stack, anti-over-engineering, testing, memory, roadmap, git, handoff, secrets) plus pluggable modules
- [x] `MODULE_DISCOVERY_GREENFIELD` — phase 1 = Discover; specs are the golden standard
- [x] `MODULE_EXTRACTION_LEGACY` — phase 1 = Understand; golden source, traceability, conflict arbitration
- [x] `MODULE_DATA_MIGRATION` — migration + cutover, pluggable (useful even in greenfield projects that import data)
- [x] Assembly story: composed charter generated per project via the `assemble-charters` skill (core + slots), preserving the single-file copy experience; freshness enforced by the pre-commit hook
- [x] Rebuild both charters as compositions; verified lossless by diff (only intended additions: Product scope row, product-for-an-audience section, extraction classification, renumbering)

## Milestone 3 — Ideas backlog

- [x] Incorporate `ideas/product-not-bespoke.md` (agreed 2026-07-10) into both charters — landed in `CHARTER_CORE.md` (Product scope parameter, multi-tenant-from-v1, domain/instance separation) with the extraction-classification bullet in `MODULE_EXTRACTION_LEGACY`
- [ ] Resolve `product-not-bespoke` open questions: per-tenant backup/restore vs. whole-system in `REQUIREMENT_PORTABLE_APPLIANCE.md`; tenant provisioning as v1 feature vs. migration-seeded tenant #1
- [x] `ideas/adopt-into-existing-project.md` agreed (2026-07-10) and authored as `templates/guides/GUIDE_ADOPTION.md` (new `GUIDE_` type) — conflict rule = always ask; no-instructions case in scope; code/infra practices deferred to roadmap
- [x] `ideas/language-setup.md` agreed + incorporated (2026-07-10) — broadened to a **Setup (step 0)** phase in `CHARTER_CORE.md` that walks the whole Project Parameters block, confirming every value (languages, Product scope, …) instead of silent defaults
- [x] `ideas/living-product-doc.md` agreed + built (2026-07-10) — living landing page (root `README.md`) kept current by the `update-product-doc` skill; hook rule 4 enforces it on adopter-facing deliverable changes
- [ ] Decide whether `translated-templates` graduates into a reusable module for template-consuming projects
- [x] Publish a rendered landing page for this repo (dogfooding, 2026-07-10) — Artifact derived from `README.md`, republished by `update-product-doc`
- [x] `ideas/idea-inbox.md` graduated (agreed) + incorporated (2026-07-10) — new **Idea inbox** section in `CHARTER_CORE.md` (inbox scratchpad + graduation ritual reusing the existing `spec_term`; the pre-roadmap staging area). Shipped alongside the first embeddable skill, `templates/skills/graduate-idea/` (see Milestone 4)

### Setup + changelog→landing pipeline — cluster **incorporated** ✅ (2026-07-11)

The five newest inbox entries turned out to refine this cluster; graduated together in a two-round Q&A (see `decisions.md` → *Graduated the Setup→changelog→landing inbox cluster*). **All 6 specs are now in template text** — incorporated across three passes on 2026-07-11: Spec-driven + Changelogs, then Setup-scaffolding + the project CLI, then landing-publishing + the living-product-doc rewiring (each carried the full ritual: assemble → landing → translate → changelog).

- [x] `ideas/setup-scaffolds-project.md` **incorporated (2026-07-11)** — new `CHARTER_CORE` *Setup scaffolding* section (§4 both charters) + expanded Method §0 Setup bullet + *Stack philosophy* overridable-default clause; tech picks are the developer's choice at Setup; minimum runnable skeleton only. Shipped with the CLI requirement.
- [x] `ideas/audience-aware-changelogs.md` **incorporated (2026-07-11)** — new `CHARTER_CORE` *Changelogs* section (greenfield §12 / legacy §13); split cadence; audience = existing *Primary users* parameter (no new row)
- [x] `ideas/living-product-doc.md` refinement **incorporated (2026-07-11)** — `update-product-doc` rewired to work by **delta from a versioned last-processed-commit marker** (`.claude/memory/last-processed-commit.md`) driven by the target-audience changelog, advancing the marker each run (meta-project tooling; template-practice facet stays deferred). Owner Q&A: pre-commit hook left unchanged, marker-freshness rule deferred (see below)
- [x] `ideas/landing-publishing.md` **incorporated (2026-07-11)** — a **focused Setup addition** to `CHARTER_CORE` (owner Q&A): *Landing skin, designed once* bullet + Method §0 mention — landing page, design interview, skin-fixed-once vs. content-regenerated, approval loop, content pipeline → `REQUIREMENT_PROJECT_CLI.md`. A full living-doc/landing charter section was **not** added (deferred). GitHub Pages public target still pending (Artifact-only today)
- [x] `ideas/spec-driven-work.md` **incorporated (2026-07-11)** — new `CHARTER_CORE` *Spec-driven work* section beside *Idea inbox* (greenfield §14 / legacy §15)
- [x] `ideas/lifecycle-cli.md` **incorporated (2026-07-11)** — new deliverable `REQUIREMENT_PROJECT_CLI.md` (single-door `setup`/`adopt`/`update-docs`/`graduate-idea` CLI styled after `claude`, specified as a thin orchestrator). Q&A settled: CLI orchestrates + hook is backstop; CLI invokes the skills. Catalog + landing + pt-BR updated. We ship the spec only.
- [x] `ideas/adaptive-setup-questions.md` **incorporated** (2026-07-10): broadened from a Setup mechanism into the general **Q&A-round** method — a new *Working through questions* section in `CHARTER_CORE.md` defines the round once (batched · options + recommendation · scripted-baseline-then-adaptive · answers become artifacts); phases point to it, and `CLAUDE.md` runs the same method when graduating an inbox entry (dogfooding). Composed charters regenerated + renumbered
- [ ] `living-product-doc` open questions: pt-BR landing page? graduate the living-manual practice into a charter section / embeddable skill for adopters
- [ ] Deferred (2026-07-11 owner Q&A): a **marker-freshness rule** in `check-freshness.sh` (block a commit that leaves the last-processed-commit marker behind); GitHub Pages as the landing's public primary (Artifact-only today). Build-for-today: add when warranted

## Milestone 4 — Skill templates (in progress)

- [x] Define what an embeddable skill template looks like under `templates/skills/` (2026-07-10) — convention set by the first entry, `graduate-idea`: one `templates/skills/<name>/SKILL.md` per skill, YAML frontmatter first, a leading "copy me into `.claude/skills/`" adoption note, kebab-case name matching the activation trigger; documented in `templates/skills/README.md`
- [x] First skill template shipped: `graduate-idea` — drives an inbox idea through its Q&A round into an agreed spec + roadmap entry (pairs with the charter's *Idea inbox* practice)
- [ ] Next candidate: automate `GUIDE_ADOPTION.md` into an `adopt-template` skill (inventory existing CLAUDE.md → propose merge → apply with approval)
