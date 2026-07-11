---
name: assemble-charters
description: Regenerate the self-contained charters under templates/charters/ from their sources in templates/charters/sources/ (CHARTER_CORE.md + modules, per charters.manifest.md). Use after editing any charter source, or when the pre-commit freshness hook blocks a commit. Pass --all to rebuild every charter.
---

# assemble-charters

The charters adopters copy (`templates/charters/CHARTER_*.md`) are **generated** from `templates/charters/sources/`. Edit the sources; never edit a composed charter by hand.

## Inputs

- `templates/charters/sources/CHARTER_CORE.md` — the shared spine with `{{ variables }}` and `<!-- SLOT: name -->` markers.
- `templates/charters/sources/MODULE_*.md` — each defines an optional `===VARS===` block (`name = value` lines) and `===SLOT: name===` blocks (content runs to the next `===` marker). Phase-1 modules define the variables; add-on modules usually define only slots.
- `templates/charters/sources/charters.manifest.md` — maps each composed charter to its core + ordered module list, and catalogs the opt-in add-on modules.

## Assembly (per manifest row)

1. Collect variables and slot contents from the row's modules, in order; a later module wins on a key it redefines — except `project_parameters_extra`, where every module's rows are **appended in list order** (they extend the Project Parameters table).
2. In `CHARTER_CORE.md`: replace every `{{ var }}` with its value, and every `<!-- SLOT: name -->` with the slot's content (empty string if no module supplies it).
3. Normalize whitespace: exactly one blank line between sections; drop any line that became empty because its slot was empty; no leading/trailing blank lines.
4. **Number the sections**: walk the `##` headings top to bottom, skip `## Project Parameters`, and prefix each remaining one with its sequential number (`## 1. …`, `## 2. …`), so a charter that omits a slotted section (e.g. one composed without an add-on module) still numbers cleanly.
5. Strip the source-only HTML comment header. Write the result to `templates/charters/<ComposedName>.md`.

## Rules

- Relative links in the sources already target `../requirements/…`, which resolves from `templates/charters/` — keep them verbatim.
- The composed file is self-contained: a reader must never need the sources. No `{{ }}` or `SLOT` markers may survive into the output.
- Determinism: same sources → same composed output. This lets the freshness hook regenerate and diff.
- The shipped charters stay **minimal** (see the manifest); an adopting project that wants `MODULE_PRODUCT_AUDIENCE`, `MODULE_LIVING_DOCS`, or `MODULE_DATA_MIGRATION` adds the module to its row and re-runs this assembly in its own copy — do not add them to the shipped rows here.

## After assembling

Stage `templates/charters/` together with the updated `CHANGELOG.md` and root `README.md` (if the change is adopter-facing) so the pre-commit hook passes.
