# Roadmap archive

Closed milestones, moved here when they completed (archive by milestone, not task by task). The live roadmap is `roadmap.md`.

## Milestone 1 — Meta-project structure (v0) ✅ (2026-07-10)

- [x] Root CLAUDE.md describing the meta-project (2026-07-10)
- [x] Reorganize deliverables into `templates/charters/` and `templates/requirements/`, with a catalog README (2026-07-10)
- [x] `ideas/` spec format established, first three specs written (2026-07-10)
- [x] Versioned in-repo memory (`.claude/memory/`) and audience changelogs (`changelog/`) (2026-07-10)
- [x] pt-BR translation pipeline: `translate-templates` skill + pre-commit freshness hook (2026-07-10) *(pipeline removed in the 2026-07-11 rewrite)*

## Milestone 2 — Charter modularization ✅ (2026-07-10)

- [x] Decompose the two charters into a shared core (`templates/charters/sources/CHARTER_CORE.md`) plus pluggable modules
- [x] `MODULE_DISCOVERY_GREENFIELD` — phase 1 = Discover; specs are the golden standard
- [x] `MODULE_EXTRACTION_LEGACY` — phase 1 = Understand; golden source, traceability, conflict arbitration
- [x] `MODULE_DATA_MIGRATION` — migration + cutover, pluggable (useful even in greenfield projects that import data)
- [x] Assembly story: composed charter generated per project via the `assemble-charters` skill (core + slots), preserving the single-file copy experience; freshness enforced by the pre-commit hook
- [x] Rebuild both charters as compositions; verified lossless by diff

## Milestone 3 — Ideas backlog ✅ (2026-07-11)

All then-open ideas graduated and incorporated into template text across 2026-07-10/11: `product-not-bespoke` (multi-tenant default + the two honesty boundaries), `adopt-into-existing-project` (→ `GUIDE_ADOPTION.md`), `language-setup` (→ Setup step 0), `living-product-doc` + `landing-publishing` (→ living landing + `update-product-doc` pipeline), `audience-aware-changelogs` (→ Changelogs section), `spec-driven-work`, `setup-scaffolds-project`, `lifecycle-cli` (→ `REQUIREMENT_PROJECT_CLI.md`), `adaptive-setup-questions` (→ the Q&A-round method), `idea-inbox` (→ Idea inbox section + `graduate-idea` skill), `translated-templates` (stays meta-tooling). Full trail in `decisions.md`.

*Note: the 2026-07-11 rewrite later reshaped several of these outcomes — multi-tenant and living-docs became opt-in modules, the CLI requirement was parked, translations were dropped. See `decisions.md` → "Rewrite from scratch in ideal form".*

## Milestone 4 — Skill templates ✅ (2026-07-11)

- [x] Embeddable skill-template convention defined under `templates/skills/` (2026-07-10)
- [x] First skill template: `graduate-idea` (2026-07-10)
- [x] Second skill template: `adopt-template`, automating `GUIDE_ADOPTION.md` (2026-07-11)

## Milestone 5 — Rewrite in ideal form ✅ (2026-07-11)

- [x] Full from-scratch rewrite: minimal charter core (12/13 sections), Q&A rounds defined once, `MODULE_PRODUCT_AUDIENCE` + `MODULE_LIVING_DOCS` as opt-in add-ons, pt-BR pipeline dropped, single `CHANGELOG.md`, landing machinery replaced by hook + republish ritual, `REQUIREMENT_PROJECT_CLI` parked to `ideas/lifecycle-cli.md`, catalog merged into root `README.md`, incorporated specs deleted, hook simplified. See `decisions.md` → "Rewrite from scratch in ideal form".
