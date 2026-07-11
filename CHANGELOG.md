# Changelog

Curated for template adopters, one entry per significant change (newest first). The git history is the full technical record underneath. Entries before 2026-07-11 live in the old `changelog/` directory, reachable in git history.

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
