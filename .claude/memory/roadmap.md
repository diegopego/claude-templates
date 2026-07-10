# Roadmap

Single source of direction. Every session starts by reading this file and ends by updating it. Work not listed here is scope creep until the owner adds it.

## Milestone 1 — Meta-project structure (v0)

- [x] Root CLAUDE.md describing the meta-project (2026-07-10)
- [x] Reorganize deliverables into `templates/charters/` and `templates/requirements/`, with a catalog README (2026-07-10)
- [x] `ideas/` spec format established, first three specs written (2026-07-10)
- [x] Versioned in-repo memory (`.claude/memory/`) and audience changelogs (`changelog/`) (2026-07-10)
- [x] pt-BR translation pipeline: `translate-templates` skill + pre-commit freshness hook (2026-07-10)

## Milestone 2 — Charter modularization

- [ ] Decompose the two charters into a shared core (phases 2–5, roles, languages, stack, anti-over-engineering, testing, memory, roadmap, git, handoff, secrets) plus pluggable modules
- [ ] `MODULE_DISCOVERY_GREENFIELD` — phase 1 = Discover; specs are the golden standard
- [ ] `MODULE_EXTRACTION_LEGACY` — phase 1 = Understand; golden source, traceability, conflict arbitration
- [ ] `MODULE_DATA_MIGRATION` — migration + cutover, pluggable (useful even in greenfield projects that import data)
- [ ] Decide the assembly story: composed charter generated per project (preferred — preserves the single-file copy experience) vs. copying the file set
- [ ] Rebuild `CHARTER_GREENFIELD` and `CHARTER_LEGACY_TRANSFORMATION` as thin compositions; verify no behavior was lost against the current monolithic versions

## Milestone 3 — Ideas backlog

- [ ] Incorporate `ideas/product-not-bespoke.md` (agreed 2026-07-10) into both charters — Product scope parameter, multi-tenant-from-v1, domain/instance separation, extraction classification; natural fit alongside the Milestone 2 modularization
- [ ] Resolve `product-not-bespoke` open questions: per-tenant backup/restore vs. whole-system in `REQUIREMENT_PORTABLE_APPLIANCE.md`; tenant provisioning as v1 feature vs. migration-seeded tenant #1
- [ ] Mature `ideas/language-setup.md` (draft → agreed) and incorporate into the charters
- [ ] Mature `ideas/audience-aware-changelogs.md` (draft → agreed); decide core section vs. new module
- [ ] Decide whether `translated-templates` graduates into a reusable module for template-consuming projects

## Milestone 4 — Skill templates (future)

- [ ] Define what an embeddable skill template looks like under `templates/skills/`
