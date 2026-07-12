# Handoff

Written 2026-07-12, at the close of the session that closed **Milestone 6 — Validation in a real project**. For a successor with zero conversation context: read `roadmap.md` first, then `decisions.md` (the four 2026-07-12 entries), then this.

## Current state

Everything below is **committed and pushed** (`236c68e`); the landing at `https://diegopego.github.io/claude-templates/` is live with it.

Milestone 6 is fully closed. The templates were exercised outside this repo for the first time, and the friction loop — *real adoption → inbox note → spec → template text* — ran end to end for the first time. What that produced, in order:

1. **Re-adoption became an upgrade** (`ideas/template-upgrade.md`, incorporated). Installs are stamped with the template repo's commit (`.claude/memory/template-version.md`; the kit carries `TEMPLATE_VERSION.md`); `GUIDE_ADOPTION` + `adopt-template` gained a third branch that reconciles only the version diff; dispositions are tagged **architectural** or **conflict-avoided**, and the conflict-avoided ones re-open on upgrade; the adoption kit now ships `charters/sources/` whole with every paired skill.
2. **Self-adoption merge** (`decisions.md`, *Self-adoption merge*). All 17 dispositions recorded; `CLAUDE.md` gained *Method* (the repo's real lifecycle: capture → graduate → incorporate → **validate in an adopter**), *Proving the tooling*, the session-handoff rule, and the **commit-rights-end-here** rule. This repo is stamped as its own adopter #1.
3. **First real upgrade: orderboard** (`~/devel/nogueira/orderboard`, the owner's legacy-charter project). Unstamped older instance → dated, stamped at `29468ef`, reconciled up to `3e09fd2`. **The diff folded nothing into its `CLAUDE.md`** — only the adoption machinery had changed — which is the branch working: the previous re-adoption had rebuilt its entire instruction layer because nothing could tell it what had actually changed.
4. **`make upgrade`** (`ideas/upgrade-ergonomics.md`, incorporated), graduated from the two frictions that run produced.

## Next steps

1. The roadmap's remaining item is deliberately a brake: **prefer more adopters over more text.** The templates now have two real users (this repo, orderboard) and one closed friction loop. A third adopter teaches more than another section.
2. **Uncommitted, in a foreign repo:** orderboard has three files in its working tree from the upgrade — `.claude/memory/template-version.md` (new), `decisions.md`, `MEMORY.md`. Its own session commits them; **this project never commits there** (see `CLAUDE.md` → *Commit ritual*).

## Dead ends / cautions

- **A date bound is not a timestamp bound.** `make upgrade`'s first cut dated an unstamped instance by the *day* of its adoption commit; on orderboard that resolved to the template repo's HEAD of the same day and reported "already up to date" — silently skipping the diff. It uses `%cI` (the instant) now. Any future date arithmetic against the template history has this trap.
- **Charters are generated** — edit `templates/charters/sources/`, then `assemble-charters`. The composed files are never hand-edited.
- **Shipped charters stay minimal** — never fold `MODULE_PRODUCT_AUDIENCE` / `MODULE_LIVING_DOCS` / `MODULE_DATA_MIGRATION` back into the greenfield manifest row; adopters compose them in.
- **Skill templates get copied into foreign repos** — reference the charter/guide/template set by name, never by relative path.
- **`tools/` is exercised, not reviewed** (`CLAUDE.md` → *Proving the tooling*): run `make new` / `make adopt` / `make upgrade` into a throwaway destination before committing a change to them. Today's bug was invisible in the diff and obvious on the first run.
- Old artifacts (pt-BR tree, dual changelogs, `update-product-doc`, `REQUIREMENT_PROJECT_CLI.md`) live only in git history (≤ `600a06b`). Do not resurrect them without the reactivation criteria in `roadmap.md` → *Parked*.
- Conversation with the owner in pt-BR; every artifact (including this file) in English.
