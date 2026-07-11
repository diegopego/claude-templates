# Changelog — template adopter

For people who copy these templates into their own projects. Only changes that affect how you find, choose, or use a template appear here. Newest first.

## 2026-07-11 — Your charter now covers two changelogs and a spec before each task

- Both charters gained two sections — you get them by copying the same single charter file:
  - **Changelogs.** Your project keeps a **technical changelog** (updated every commit, with the git history underneath) and a **changelog for your product's users** (curated, grouping related changes so it isn't noisy). The users' changelog is the source for an always-current summary of your product.
  - **Spec-driven work.** For any non-trivial task, the agent writes a **short spec before it builds**, and asks you the questions that matter up front instead of guessing. Trivial fixes (a rename, a typo) skip the ceremony.
- Nothing else changes in how you adopt: copy the charter, fill the parameters, go. The pt-BR versions are updated to match.
- Two of the four items from the previous "coming next" note are now live (these two); the **project CLI** and the **approve-before-publish landing page** are still planned.

## 2026-07-10 — Settled (coming next): spec-per-task, one project CLI, and how your changelogs & landing will work

- The earlier "Planned:" setup/changelog/landing sketches are now **agreed** — the shape is settled and will be written into the templates next. What's coming:
  - **A short spec before each real task.** For any non-trivial piece of work, the agent will write a brief spec first and ask you the questions that matter up front, instead of guessing and coding.
  - **One project command-line tool.** A single CLI — styled after Claude's own — will run your project's whole lifecycle: set it up, adopt these practices into an existing repo, update your changelogs and landing page, and graduate inbox ideas.
  - **Two changelogs on different rhythms.** A technical one (updated every commit) and one written for your product's users (curated, grouped so it isn't noisy). Your users' changelog is what keeps your landing page current.
  - **You approve the landing before it publishes.** Each update shows you what's about to change in words, then as a preview, and waits for your OK before going live (private preview + a public web page).
- Still nothing to copy yet — these are agreed plans; the templates you copy are unchanged until they're incorporated.

## 2026-07-10 — New: an idea inbox your project can keep, and a drop-in skill to work through it

- Both charters gained an **Idea inbox** practice: keep an `ideas/inbox.md` scratchpad for half-formed ideas, and when you're ready, ask the agent to **graduate** one — it runs a round of questions (each with options and a recommendation), writes down the decisions, turns the note into a proper spec, and adds it to your roadmap. The inbox is where scope is proposed; the roadmap is where it's accepted.
- New **embeddable skill** at `templates/skills/graduate-idea/`: copy the folder into your project's `.claude/skills/` and the agent runs that graduation ritual on request. It's the first of a new kind of drop-in skill (see `templates/skills/README.md`); a pt-BR version is under `templates/i18n/pt-BR/skills/`.
- You still copy the same single charter file — the new section travels inside it.

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
