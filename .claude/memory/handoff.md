# Handoff

Written 2026-07-11, at the close of the session that rewrote the whole repo from scratch in its ideal form (owner-ordered: "reescreva do zero da forma ideal. eu assumo o risco."). For a successor with zero conversation context: read `roadmap.md` first, then `decisions.md` → *Rewrite from scratch in ideal form*, then this.

## Current state

- The rewrite is **complete in the working tree and NOT yet committed** — committing needs the owner's explicit per-instance authorization, as always.
- Shape after the rewrite: minimal composed charters (greenfield 12 sections, legacy 13) assembled from a slim `CHARTER_CORE.md` + phase-1 modules; opinionated practices live in opt-in add-ons `MODULE_PRODUCT_AUDIENCE` and `MODULE_LIVING_DOCS`; single root `CHANGELOG.md`; root `README.md` is landing + catalog in one; hook has 3 rules (sources→composed, templates|ideas→CHANGELOG, templates→README); no translations; `REQUIREMENT_PROJECT_CLI` parked at `ideas/lifecycle-cli.md`.
- The rewrite was committed as `befa4ab`. The landing then **moved from the Artifact to GitHub Pages** (owner's call): `docs/index.html` on `master`, Nord skin transferred unchanged, hook rule 4 keeps it fresh against `README.md`. The old Artifact (`…/artifact/213558f8-…`) is retired — Pages (`https://diegopego.github.io/claude-templates/`) is canonical.

## Next steps

1. Milestone 6 (roadmap): adopt the templates in a real project of the owner's and collect friction as inbox notes — no further meta-refinement before that.

## Dead ends / cautions

- **Assembly is prose-merge, done by the agent** following `.claude/skills/assemble-charters/SKILL.md`. `project_parameters_extra` rows are *appended* to the parameter table (not last-wins). Section numbering skips `## Project Parameters`.
- **Shipped charters stay minimal** — never fold `MODULE_PRODUCT_AUDIENCE` / `MODULE_LIVING_DOCS` back into the shipped manifest rows; adopters compose them into their own copies.
- **Skill templates are copied into foreign repos** — reference the charter/guide/template set by name, never by relative path.
- Old artifacts (pt-BR tree, dual changelogs, `update-product-doc`, marker, incorporated specs, `REQUIREMENT_PROJECT_CLI.md`) exist only in git history (≤ commit `600a06b`). Do not resurrect them without the reactivation criteria in `roadmap.md` → *Parked*.
- Conversation with the owner in pt-BR; every artifact (including this file) in English.
