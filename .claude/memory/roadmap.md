# Roadmap

Single source of direction. Every session starts by reading this file and ends by updating it. Work not listed here is scope creep until the owner adds it. Closed milestones live in `roadmap-archive.md` (currently: 1 — structure, 2 — modularization, 3 — ideas backlog, 4 — skill templates, 5 — the 2026-07-11 rewrite).

## Milestone 6 — Validation in a real project (current)

The templates have never been adopted outside this repo; further meta-refinement has diminishing returns until they are. This milestone exists to generate real friction data.

- [x] Publish the landing on GitHub Pages (`docs/index.html`, hook-enforced freshness against README.md) — activated by the owner 2026-07-11, replacing the Artifact
- [x] Installer: `make new`/`make adopt DEST=…` + deterministic assembler (`tools/assemble.py`) + self-adoption (`make adopt DEST=.` installed the skill working copies here) (2026-07-11)
- [ ] Run the self-adoption **merge**: classify each charter section against this repo's `CLAUDE.md` via the installed `adopt-template` skill, record dispositions in the decision log
- [ ] Adopt a charter (or run `adopt-template`) in one real project of the owner's
- [ ] Record every friction point during adoption and the first weeks of use (what the agent ignored, what felt like ceremony, what was missing) — as inbox notes in this repo
- [ ] Iterate the template text from that friction; only then consider new deliverables
  - 2026-07-11 — first friction fixed (orderboard install): adoption now tears down its delivery kit and gives each kept deliverable a single versioned home under `.claude/` (`GUIDE_ADOPTION.md` + `adopt-template`); installer unchanged

## Parked (reactivate on demand)

- `ideas/lifecycle-cli.md` — the project CLI spec; graduates back to a `REQUIREMENT_` when a real adopter wants to build it
- pt-BR (or other) translations — return when an adopting project asks
- Living-manual practice as a charter section beyond `MODULE_LIVING_DOCS`
