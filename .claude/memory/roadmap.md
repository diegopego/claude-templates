# Roadmap

Single source of direction. Every session starts by reading this file and ends by updating it. Work not listed here is scope creep until the owner adds it. Closed milestones live in `roadmap-archive.md` (currently: 1 — structure, 2 — modularization, 3 — ideas backlog, 4 — skill templates, 5 — the 2026-07-11 rewrite).

## Milestone 6 — Validation in a real project (current)

The templates have never been adopted outside this repo; further meta-refinement has diminishing returns until they are. This milestone exists to generate real friction data.

- [x] Publish the landing on GitHub Pages (`docs/index.html`, hook-enforced freshness against README.md) — activated by the owner 2026-07-11, replacing the Artifact
- [x] Installer: `make new`/`make adopt DEST=…` + deterministic assembler (`tools/assemble.py`) + self-adoption (`make adopt DEST=.` installed the skill working copies here) (2026-07-11)
- [x] Run the self-adoption **merge** (2026-07-12) — every charter section, module and requirement given a tagged disposition (`decisions.md`, *Self-adoption merge*); `CLAUDE.md` gained *Method* and *Proving the tooling*, plus the session-handoff rule; stamped in `.claude/memory/template-version.md`. First real exercise of both the merge and the architectural/conflict-avoided tag
- [x] Adopt a charter / run `adopt-template` in a real project — **orderboard** (`~/devel/nogueira/orderboard`, 2026-07-12): first out-of-repo run, and the first exercise of the *Upgrade* branch. Unstamped older instance → charter (legacy + living-docs) confirmed, stamped at `29468ef`, reconciled up to `3e09fd2`. The version diff folded **nothing** into its `CLAUDE.md` (only the adoption machinery had changed) — which is the branch working: the previous re-adoption rebuilt its whole instruction layer because nothing could tell it what had actually changed. Surfaced one genuine gap: `MODULE_PRODUCT_AUDIENCE` had never been offered to it (old kits shipped only the living-docs source) — offered now, dispositioned *already covered*
- [ ] Record every friction point during adoption and the first weeks of use (what the agent ignored, what felt like ceremony, what was missing) — as inbox notes in this repo
  - 2026-07-12 — two frictions from the first upgrade, in `ideas/inbox.md`: retroactive stamping needs detective work to find the source commit (the owner does not know a SHA), and delivering a kit is churn when the templates clone is on the same machine
- [x] `ideas/template-upgrade.md` graduated **and incorporated** (2026-07-12) — the third adoption mode: provenance stamp (`.claude/memory/template-version.md`, commit SHA written by the installer), the *upgrade* branch in `GUIDE_ADOPTION` + `adopt-template` reconciling a version diff, architectural-vs-conflict-avoided disposition tags, and an adoption kit that ships `charters/sources/` whole with every paired skill. Both 2026-07-11 inbox frictions closed at once; **still unproven in a real project** — the next orderboard re-adoption is its first test
- [ ] Iterate the template text from that friction; only then consider new deliverables
  - 2026-07-11 — first friction fixed (orderboard install): adoption now tears down its delivery kit and gives each kept deliverable a single versioned home under `.claude/` (`GUIDE_ADOPTION.md` + `adopt-template`); installer unchanged
  - 2026-07-11 — second friction fixed: `make adopt DEST=.` now force-refreshes the self-adopted skill working copies (`tools/install.sh`), so the CLAUDE.md refresh path works without a manual `rm`
  - 2026-07-11 — third friction fixed: the living-docs pipeline (change → audience changelog → living doc → landing) is now automated by the new `update-living-docs` skill (rebuild + update), the executable arm of MODULE_LIVING_DOCS — it was prose-only after the rewrite removed `update-product-doc`
  - 2026-07-11 — fourth friction fixed: `make adopt` now installs the permanent `graduate-idea` skill (+ seeds an empty inbox), not just the one-shot `adopt-template` — orderboard was left with no skills at all after teardown

## Parked (reactivate on demand)

- `ideas/lifecycle-cli.md` — the project CLI spec; graduates back to a `REQUIREMENT_` when a real adopter wants to build it (its docs-pipeline part is now covered by the `update-living-docs` skill; the single-door CLI itself stays parked)
- pt-BR (or other) translations — return when an adopting project asks
- Living-manual practice as a charter section beyond `MODULE_LIVING_DOCS`
