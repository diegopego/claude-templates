# Handoff

Written 2026-07-12, **in this repo**, by the session that executed the six charter corrections the previous (orderboard-based) planning session had only designed.

## State

**Milestone 7 is closed.** The six corrections shipped (`3b1eea8`, pushed — the landing is live with them), and **both adopters are now on that version**: `make upgrade` reports *already up to date* for nogueira-adjustments and orderboard alike. Both upgrades are **uncommitted in their own working trees**, as the charter requires — each project's own session authorizes its own commit. Nothing here is blocked.

**Milestone 8 (host-side adoption) is current**, spec agreed in `ideas/host-side-adoption.md` — but its own sequencing note is now spent: it said *do the orderboard upgrade first under the current flow, and let the next adoption be the first host-side run.* The orderboard upgrade is done, so Milestone 8 is clear to start, and the next adoption is its exercise.

**Uncommitted here**: the Milestone 8 spec and its decision entry (from a parallel session), the two new inbox frictions, and this memory update. The freshness hook passes.

### The premise that broke

nogueira-adjustments was **not** an independent re-derivation of the charter. Its own session log says the charter was cherry-picked into it on 2026-07-09, and its adoption commit's timestamp dates that to **`1bbf79a` — this repo's first commit**. It is an old unstamped adopter; it got an **upgrade**, not a first adoption. The byte-identical appliance requirement was a copy, not a coincidence (that file has zero changed lines since `1bbf79a`).

**The six corrections survive this, better evidenced than before.** They rest on its ADRs 0031/0032/0033, all written 2026-07-12 — three days *after* it absorbed the charter. Not a coincidental re-derivation: a project that **had** the charter, hit reality, and contradicted it. `adopter-nogueira-adjustments.md` is corrected in place; the "re-derivation" framing is the only casualty.

The lesson worth keeping: **check provenance before believing a project is independent.** The evidence was one grep away in its own working notes, and the whole value framing of the milestone rested on it.

The plan in `adopter-nogueira-adjustments.md` was reviewed critically before execution, as the previous handoff demanded, and it held up on both of its flagged risks:

- **The empty slot composes clean.** `expand_slots` in `tools/assemble.py` drops a line only when it holds *nothing but* empty slots; `<!-- SLOT: cutover -->## Memory, roadmap & decisions` keeps its heading. Greenfield recomposed byte-identical, which is the proof.
- **Orderboard is self-sufficient.** Its `CLAUDE.md` §*Data migration & cutover* states those rules in its own terms (`IMPORT*` tabs, ATC/TPA, money totals). Deleting the module upstream removes nothing from it.

Two things the plan did not predict:

- A **third** stale reference to the deleted module, inside the *a copy, not production* rule (the plan listed only `method_build` and `roadmap_scope`).
- **The cutover got its own section**, not a bullet in the extraction rules list. The list keeps the *extraction* honest — six rules already — and cutover is project sequencing. The core's `data_migration` slot was renamed `cutover` and is now filled by `MODULE_EXTRACTION_LEGACY`.

## Next

`roadmap.md` → **Milestone 8 — Host-side adoption**. Read `ideas/host-side-adoption.md` first; the tasks are already broken out. Two cautions specific to it, beyond the standing ones below:

- **The kit's abolition touches `tools/install.sh`, the Makefile, and the README's whole install story.** That is the largest single change to the tooling so far, and *Proving the tooling* applies with full force — exercise all three modes into a throwaway before committing.
- **`template-version.md` is being redesigned into a disposition manifest.** Both adopters' stamps are hand-written today (and orderboard's was hand-fixed to keep `Source commit` machine-readable — see the inbox friction). Whatever shape the manifest takes, it must be able to *read* the two stamps that already exist in the wild, or those two projects need a migration.

**Waiting on their own sessions, not on us:**

- **nogueira-adjustments** — `CLAUDE.md` (+57, −0), ADR 0035 + its README entry, two queue items, `.claude/` (untracked — must be `git add`ed), `ideas/inbox.md`. Its `handoff.md` explains it all. **The membership model is its top queue item and the one thing that can move its build** — settle it before Phase 0 hardens the schema.
- **orderboard** — `CLAUDE.md` + its four memory files. **Its extraction was never validated by operating the sheet** (its OAuth scope is still read-only), and its golden standards — derived from that reading — are the oracles M5 will harden into tests. There is an M4 item there to widen the scope and drive the sheet before that happens. This is the most consequential thing either upgrade surfaced.

## Dead ends / cautions

- **Charters are generated** — edit `templates/charters/sources/`, then `make assemble`. Never hand-edit a composed charter.
- **`tools/` is exercised, not reviewed.** This session ran `make new` (bare + both modules), `make adopt` into a throwaway with a pre-existing `CLAUDE.md`, and `make upgrade`. Keep doing that.
- **The freshness hook fires on *any* `git commit` run through Bash**, including one inside an unrelated throwaway repo used to test the installer — it blocked a `git init && git commit` in `/tmp`. Harmless once you know it, and a good inbox note: the hook should probably scope itself to this repo.
- **`make upgrade` only sees committed history.** It diffs `<stamp>..HEAD` — uncommitted corrections are invisible to it. That is why the commit gates the two adoptions.
- **A date bound is not a timestamp bound** — `make upgrade` dates an unstamped instance from its adoption commit's `%cI` (the instant). Any future date arithmetic against the template history has this trap.
- **Shipped charters stay minimal** — never fold `MODULE_PRODUCT_AUDIENCE` / `MODULE_LIVING_DOCS` into the manifest rows; adopters compose them in.
- **Skill templates get copied into foreign repos** — reference the charter/guide set by name, never by relative path.
- **This project never commits in a foreign repo.** The adopting project's own session authorizes its own commit. Orderboard may still have the three files from its earlier upgrade uncommitted.
- Old artifacts (pt-BR tree, dual changelogs, `update-product-doc`, `REQUIREMENT_PROJECT_CLI.md`) live only in git history (≤ `600a06b`); reactivation criteria in `roadmap.md` → *Parked*.
- Conversation with the owner in pt-BR; every artifact (including this file) in English.

## Open, not decided

Unchanged from the previous handoff, and still not part of Milestone 7: the owner floated moving orderboard's direction and decisions out of `.claude/memory/roadmap.md` + `decisions.md` into a `specs/`-based layout, because that is what nogueira-adjustments does (a live ordered queue + numbered ADRs) and he prefers it. If **both** adopters prefer `specs/` homes, the charter's *Memory, roadmap & decisions* section is what is wrong, and the fix belongs here rather than in two per-project dispositions. **Decide the charter's rule first, then migrate.** Needs its own Q&A round.
