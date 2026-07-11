# Changelog — template adopter

For people who copy these templates into their own projects. Only changes that affect how you find, choose, or use a template appear here. Newest first.

## 2026-07-10 — The charters now spell out how the agent works through questions with you

- Both charters gained a **Working through questions** section: the agent works through "Q&A rounds" (a term the charters used everywhere but never explained). A round now means — related questions asked together, each with options and a recommendation so you decide from a position not a blank page, a fixed baseline followed by smart follow-ups based on your answers, and every answer written down where it belongs. This makes the discovery/alignment steps predictable instead of relying on you to know the ritual.

## 2026-07-10 — Planned: your landing page gets a look chosen at setup, and smarter setup questions

- Drafted (not yet active) how your landing page will get its visual identity: early in setup the agent asks a few design questions — theme, colors, an example site you like, your audience — and builds the look once (with Claude Design). After that, the page's content is regenerated from your live front-page document, so the look stays consistent and the words stay current. Also drafted: setup asks a fixed list of questions first (so nothing basic is missed), then follows up with smart, project-specific questions. Drafts only — nothing in the templates you copy changes yet.

## 2026-07-10 — Planned: setup that scaffolds, and a changelog that becomes your landing page

- Drafted (not yet active) how a charter's Setup step will do more for you: ask your stack and language and generate a starting project setup, and capture who your product is for. From there, a changelog written for your users keeps a live front page current, which is what gets published as your landing page — with a Nord look and a choice of a private preview or a public web page. These are drafts being refined; nothing changes in the templates you copy yet.

## 2026-07-10 — A published landing page

- claude-templates now has a rendered landing page (a real web page, not just the markdown), published from the same `README.md` source. It's private to the maintainer for now; the markdown front page in the repo remains the thing that's always current.

## 2026-07-10 — A front page that stays current

- The repo now has a root `README.md` landing page that always describes, in plain terms, what the templates are and how to adopt them — kept in sync as the templates evolve. If you want the quick "what is this and how do I start", read it first; the catalog (`templates/README.md`) remains the detailed index.

## 2026-07-10 — Charters now start with a Setup step

- Both charters gained a **Setup (step 0)** before the discovery/understand phase: the agent confirms every row of the Project Parameters block with you — languages, Product scope, domain expert role, and the rest — instead of silently assuming a default. Fewer surprises from a setting left as placeholder text.

## 2026-07-10 — New: an adoption guide for existing projects

- Added `templates/guides/GUIDE_ADOPTION.md`. If you already have a working project — with or without a `CLAUDE.md` — this guide walks through adopting these practices **without losing your existing instructions**: it inventories what you have, keeps/adapts/skips each template section, and raises every conflict to you instead of overwriting anything. Changes that would touch your running code or infrastructure are put on a roadmap for your approval, not applied during adoption.
- A pt-BR version is available under `templates/i18n/pt-BR/guides/`.

## 2026-07-10 — Charters now cover multi-tenant products; same file to copy

- Both charters gained a **Product for an audience, not a bespoke tool** section and a **Product scope** row in Project Parameters. The default stance: what you build is a product for an audience, **multi-tenant from v1** — the organization asking for it is tenant #1, and its specifics become configuration, not hardcoded behavior. Set *Product scope* to `internal/bespoke tool` if that is genuinely what you want.
- The legacy charter adds a **Classify on extraction** rule: each extracted rule is tagged domain / instance-config / workaround, and instance values become tenant #1's configuration profile at migration.
- Nothing you do changes: you still copy a single self-contained `templates/charters/CHARTER_*.md` into your project. Under the hood those files are now generated from shared sources, but that is invisible to adopters — keep copying the composed charter as before.

## 2026-07-10 — New locations, catalog, and Portuguese versions

- Templates moved: charters now live in `templates/charters/`, cross-cutting requirements in `templates/requirements/`. If you bookmarked old paths, update them.
- New catalog at `templates/README.md` tells you what each template is for and when to pick it.
- Every template now has a Brazilian Portuguese version under `templates/i18n/pt-BR/`, mirroring the English paths. The English file remains the source of truth — copy the English one into your project; the pt-BR version exists for reading and review.
- No content changes to the charters or the portable-appliance requirement themselves (only the link between them was updated for the new layout).
