---
name: assemble-charters
description: Regenerate the self-contained charters under templates/charters/ from their sources in templates/charters/sources/ (CHARTER_CORE.md + modules, per charters.manifest.md). Use after editing any charter source, or when the pre-commit freshness hook blocks a commit. Pass --all to rebuild every charter.
---

# assemble-charters

The charters adopters copy (`templates/charters/CHARTER_*.md`) are **generated** from `templates/charters/sources/`. Edit the sources; never edit a composed charter by hand.

## Inputs

- `templates/charters/sources/CHARTER_CORE.md` — the shared spine with `{{ variables }}` and `<!-- SLOT: name -->` markers.
- `templates/charters/sources/MODULE_*.md` — each defines a `===VARS===` block (`name = value` lines) and `===SLOT: name===` blocks (content runs to the next `===` marker).
- `templates/charters/sources/charters.manifest.md` — maps each composed charter to its core + ordered module list.

## Assembly (per manifest row)

1. Collect variables and slot contents from the row's modules, in order; a later module wins on a key it redefines.
2. In `CHARTER_CORE.md`: replace every `{{ var }}` with its value, and every `<!-- SLOT: name -->` with the slot's content (empty string if no module supplies it).
3. Normalize whitespace: exactly one blank line between sections; drop any line that became empty because its slot was empty; no leading/trailing blank lines.
4. **Number the sections**: walk the `##` headings top to bottom and prefix each with its sequential number (`## 1. …`, `## 2. …`), so a charter that omits a slotted section (e.g. greenfield without data-migration) still numbers cleanly.
5. Strip the source-only HTML comment header. Write the result to `templates/charters/<ComposedName>.md`.

## Rules

- Relative links in the sources already target `../requirements/…`, which resolves from `templates/charters/` — keep them verbatim.
- The composed file is self-contained: a reader must never need the sources. No `{{ }}` or `SLOT` markers may survive into the output.
- Determinism: same sources → same composed output. This lets the freshness hook regenerate and diff.

## After assembling

The composed charters changed, so their pt-BR translations are now stale: run the `translate-templates` skill, then stage `templates/charters/`, `templates/i18n/`, and the updated `changelog/` together so the pre-commit hook passes.
