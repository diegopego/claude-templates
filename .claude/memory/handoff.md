# Handoff

Written 2026-07-12, **in this repo**, by the session that executed the six charter corrections the previous (orderboard-based) planning session had only designed.

## State

**All six corrections are done and staged; nothing is committed.** The working tree carries the whole of Milestone 7's first half — sources, composed charters, tooling, guide, skills, README, landing, CHANGELOG, four `decisions.md` entries, roadmap. The pre-commit freshness hook passes (`CLAUDE_PROJECT_DIR=$(pwd) .claude/hooks/check-freshness.sh` → 0). The commit awaits the owner's authorization; **that is the next action**, and the two adoption steps depend on it because the stamp must point at a commit that contains the corrected text.

The plan in `adopter-nogueira-adjustments.md` was reviewed critically before execution, as the previous handoff demanded, and it held up on both of its flagged risks:

- **The empty slot composes clean.** `expand_slots` in `tools/assemble.py` drops a line only when it holds *nothing but* empty slots; `<!-- SLOT: cutover -->## Memory, roadmap & decisions` keeps its heading. Greenfield recomposed byte-identical, which is the proof.
- **Orderboard is self-sufficient.** Its `CLAUDE.md` §*Data migration & cutover* states those rules in its own terms (`IMPORT*` tabs, ATC/TPA, money totals). Deleting the module upstream removes nothing from it.

Two things the plan did not predict:

- A **third** stale reference to the deleted module, inside the *a copy, not production* rule (the plan listed only `method_build` and `roadmap_scope`).
- **The cutover got its own section**, not a bullet in the extraction rules list. The list keeps the *extraction* honest — six rules already — and cutover is project sequencing. The core's `data_migration` slot was renamed `cutover` and is now filled by `MODULE_EXTRACTION_LEGACY`.

## Next

`roadmap.md` → Milestone 7, the two open items:

1. **Adopt into nogueira-adjustments** — `make adopt DEST=~/devel/nogueira-adjustments`, then the merge runs *inside* that project. Decisions already taken (do not re-ask) and the expected disposition matrix: `adopter-nogueira-adjustments.md`. Its two deferred consequences — the membership data model and the living-docs pipeline — are roadmap items *there*, not merge edits.
2. **Upgrade orderboard** — `make upgrade DEST=~/devel/nogueira/orderboard`. The genuinely new text for it is **operate-it-don't-read-it** (its Apps Script analysis was a reading exercise and its sheet is a writable copy) and the corrected copy rule. Its migration section is an **architectural keep** — the module is gone upstream, its rules are not.

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
