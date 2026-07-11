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

### Setup + changelog→landing pipeline (graduated 2026-07-10, drafts)

- [ ] `ideas/setup-scaffolds-project.md` (draft → agreed → incorporate): Setup asks stack/language and generates a complete project setup
- [ ] `ideas/audience-aware-changelogs.md` (revised draft → agreed): two curated changelogs — technical (git history underneath) + target-audience; audience captured at Setup; decide core section vs. module
- [ ] `ideas/living-product-doc.md` refinement: rewire `update-product-doc` to consume the target-audience changelog entry (not the raw diff); landing stays single, for the target audience
- [ ] `ideas/landing-publishing.md` (draft → agreed): now a **two-layer** model — the *skin* (visual identity) is designed once at Setup via a design interview (Claude Design default); the *content* is the living-doc rendered into that skin. Publish to Artifact + GitHub Pages, keep in sync
- [x] `ideas/adaptive-setup-questions.md` **incorporated** (2026-07-10): broadened from a Setup mechanism into the general **Q&A-round** method — a new *Working through questions* section in `CHARTER_CORE.md` defines the round once (batched · options + recommendation · scripted-baseline-then-adaptive · answers become artifacts); phases point to it, and `CLAUDE.md` runs the same method when graduating an inbox entry (dogfooding). Composed charters regenerated + renumbered
- [ ] `living-product-doc` open questions: pt-BR landing page? graduate the living-manual practice into a charter section / embeddable skill for adopters

## Milestone 4 — Skill templates (future)

- [ ] Define what an embeddable skill template looks like under `templates/skills/`
- [ ] First candidate: automate `GUIDE_ADOPTION.md` into an `adopt-template` skill (inventory existing CLAUDE.md → propose merge → apply with approval)
