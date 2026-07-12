# Roadmap

Single source of direction. Every session starts by reading this file and ends by updating it. Work not listed here is scope creep until the owner adds it. Closed milestones live in `roadmap-archive.md` (currently: 1 — structure, 2 — modularization, 3 — ideas backlog, 4 — skill templates, 5 — the 2026-07-11 rewrite).

## Milestone 6 — Validation in a real project

The templates have never been adopted outside this repo; further meta-refinement has diminishing returns until they are. This milestone exists to generate real friction data.

- [x] Publish the landing on GitHub Pages (`docs/index.html`, hook-enforced freshness against README.md) — activated by the owner 2026-07-11, replacing the Artifact
- [x] Installer: `make new`/`make adopt DEST=…` + deterministic assembler (`tools/assemble.py`) + self-adoption (`make adopt DEST=.` installed the skill working copies here) (2026-07-11)
- [x] Run the self-adoption **merge** (2026-07-12) — every charter section, module and requirement given a tagged disposition (`decisions.md`, *Self-adoption merge*); `CLAUDE.md` gained *Method* and *Proving the tooling*, plus the session-handoff rule; stamped in `.claude/memory/template-version.md`. First real exercise of both the merge and the architectural/conflict-avoided tag
- [x] Adopt a charter / run `adopt-template` in a real project — **orderboard** (`~/devel/nogueira/orderboard`, 2026-07-12): first out-of-repo run, and the first exercise of the *Upgrade* branch. Unstamped older instance → charter (legacy + living-docs) confirmed, stamped at `29468ef`, reconciled up to `3e09fd2`. The version diff folded **nothing** into its `CLAUDE.md` (only the adoption machinery had changed) — which is the branch working: the previous re-adoption rebuilt its whole instruction layer because nothing could tell it what had actually changed. Surfaced one genuine gap: `MODULE_PRODUCT_AUDIENCE` had never been offered to it (old kits shipped only the living-docs source) — offered now, dispositioned *already covered*
- [ ] Record every friction point during adoption and the first weeks of use (what the agent ignored, what felt like ceremony, what was missing) — as inbox notes in this repo
  - 2026-07-12 — two frictions from the first upgrade, in `ideas/inbox.md`: retroactive stamping needs detective work to find the source commit (the owner does not know a SHA), and delivering a kit is churn when the templates clone is on the same machine
  - 2026-07-12 — **the third adopter, and the richest friction yet**: `~/devel/nogueira-adjustments` was mapped against the charter without being touched. Because it was built independently and is unusually well-articulated, it works as a re-derivation of the charter — and where the two disagree, it is mostly **the charter** that is wrong. Six defects, with evidence, in `adopter-nogueira-adjustments.md`. Milestone 7 executes them
- [x] `ideas/template-upgrade.md` graduated **and incorporated** (2026-07-12) — the third adoption mode: provenance stamp (`.claude/memory/template-version.md`, commit SHA written by the installer), the *upgrade* branch in `GUIDE_ADOPTION` + `adopt-template` reconciling a version diff, architectural-vs-conflict-avoided disposition tags, and an adoption kit that ships `charters/sources/` whole with every paired skill. Both 2026-07-11 inbox frictions closed at once; **still unproven in a real project** — the next orderboard re-adoption is its first test
- [x] Iterate the template text from that friction (2026-07-12) — `ideas/upgrade-ergonomics.md` graduated **and incorporated**: `make upgrade DEST=…` (reads the stamp, dates an unstamped instance from its own adoption commit's *timestamp*, prints the changed template files, installs nothing), with the same rule in the guide's Upgrade step 1 and the skill. The friction loop closed for the first time: real adoption → inbox note → spec → template text
- [ ] Only now consider new deliverables — and prefer more adopters over more text
  - 2026-07-11 — first friction fixed (orderboard install): adoption now tears down its delivery kit and gives each kept deliverable a single versioned home under `.claude/` (`GUIDE_ADOPTION.md` + `adopt-template`); installer unchanged
  - 2026-07-11 — second friction fixed: `make adopt DEST=.` now force-refreshes the self-adopted skill working copies (`tools/install.sh`), so the CLAUDE.md refresh path works without a manual `rm`
  - 2026-07-11 — third friction fixed: the living-docs pipeline (change → audience changelog → living doc → landing) is now automated by the new `update-living-docs` skill (rebuild + update), the executable arm of MODULE_LIVING_DOCS — it was prose-only after the rewrite removed `update-product-doc`
  - 2026-07-11 — fourth friction fixed: `make adopt` now installs the permanent `graduate-idea` skill (+ seeds an empty inbox), not just the one-shot `adopt-template` — orderboard was left with no skills at all after teardown

## Milestone 7 — Charter corrections from the third adopter (current)

Milestone 6 said *prefer more adopters over more text*. The third adopter obliged: it produced six corrections the templates could not have found by introspection. **Do them before adopting into it** — otherwise the kit ships text we already know is wrong, and the stamp points at a commit we immediately owe an upgrade from. Evidence, dispositions and the full adoption plan: **`adopter-nogueira-adjustments.md`** — read it before starting, and review it critically rather than executing it on faith.

Charters are generated: edit `templates/charters/sources/`, then `make assemble`. Never hand-edit a composed charter. `tools/` is exercised, not reviewed — run the installer into a throwaway destination before committing a change to it.

- [x] **Delete data migration from the templates** (2026-07-12) — `MODULE_DATA_MIGRATION.md` removed from the sources, the manifest, the add-on list, the `adopt` file list, `GUIDE_ADOPTION.md`, both `adopt-template` skills, `assemble-charters`, the assembler's aliases and the Makefile help. **Cutover became its own charter section** (§8 of the legacy charter), filled from `MODULE_EXTRACTION_LEGACY` through the core slot renamed `data_migration` → `cutover`; it names the historical-data boundary in one line rather than smuggling the methodology back. A *third* stale reference turned up beyond the two the plan listed (in the *a copy, not production* rule). Decisions logged
- [x] **Golden sources are plural** (2026-07-12) — named individually in the Project Parameters with a precedence rule; traceability cites *which* source; two golden sources disagreeing is an Align question. Section title now *Golden sources, not a mirror*
- [x] **The copy gets corrected** (2026-07-12) — errors found in the golden source are reported with evidence, fixed in the copy, reconciled by the author into production, and the copy re-provided; a traceable extraction output
- [x] **Operate the legacy system, don't just read it** (2026-07-12) — its own extraction rule (snapshot → write → recalculate → read → restore), and *Understand* now says operate, not map
- [x] **`MODULE_PRODUCT_AUDIENCE`: the membership model** (2026-07-12) — multi-tenant *and* multi-user; one shared user base, permissions on the membership (user × tenant × role), with the three consequences both adopters hit spelled out
- [x] **`MODULE_LIVING_DOCS`: cadence** (2026-07-12) — both changelogs curated per significant change; git history named as the raw record
- [x] `make assemble` + installer exercised end to end (2026-07-12) — `make new` (legacy bare, and with both add-on modules), `make adopt` into a throwaway with a pre-existing `CLAUDE.md` (15 files, down from 16; `CLAUDE.md` untouched), `make upgrade` round-tripping the stamp; `MODULES="data-migration"` now fails with a clean *unknown module*. Greenfield recomposed byte-identical
- [ ] **Owner authorizes the commit** — everything above is in the working tree, unstaged
- [ ] **Adopt into nogueira-adjustments** — `make adopt DEST=~/devel/nogueira-adjustments`, then the merge runs inside that project (its own session commits it; this project never commits there). Decisions already taken and the expected disposition matrix are in `adopter-nogueira-adjustments.md`
- [ ] **Upgrade orderboard** — `make upgrade DEST=~/devel/nogueira/orderboard` and fold the same corrections in

## Parked (reactivate on demand)

- `ideas/lifecycle-cli.md` — the project CLI spec; graduates back to a `REQUIREMENT_` when a real adopter wants to build it (its docs-pipeline part is now covered by the `update-living-docs` skill; the single-door CLI itself stays parked)
- pt-BR (or other) translations — return when an adopting project asks
- Living-manual practice as a charter section beyond `MODULE_LIVING_DOCS`
