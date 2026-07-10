# Changelog — template adopter

For people who copy these templates into their own projects. Only changes that affect how you find, choose, or use a template appear here. Newest first.

## 2026-07-10 — Charters now cover multi-tenant products; same file to copy

- Both charters gained a **Product for an audience, not a bespoke tool** section and a **Product scope** row in Project Parameters. The default stance: what you build is a product for an audience, **multi-tenant from v1** — the organization asking for it is tenant #1, and its specifics become configuration, not hardcoded behavior. Set *Product scope* to `internal/bespoke tool` if that is genuinely what you want.
- The legacy charter adds a **Classify on extraction** rule: each extracted rule is tagged domain / instance-config / workaround, and instance values become tenant #1's configuration profile at migration.
- Nothing you do changes: you still copy a single self-contained `templates/charters/CHARTER_*.md` into your project. Under the hood those files are now generated from shared sources, but that is invisible to adopters — keep copying the composed charter as before.

## 2026-07-10 — New locations, catalog, and Portuguese versions

- Templates moved: charters now live in `templates/charters/`, cross-cutting requirements in `templates/requirements/`. If you bookmarked old paths, update them.
- New catalog at `templates/README.md` tells you what each template is for and when to pick it.
- Every template now has a Brazilian Portuguese version under `templates/i18n/pt-BR/`, mirroring the English paths. The English file remains the source of truth — copy the English one into your project; the pt-BR version exists for reading and review.
- No content changes to the charters or the portable-appliance requirement themselves (only the link between them was updated for the new layout).
