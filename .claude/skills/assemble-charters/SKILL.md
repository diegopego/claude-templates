---
name: assemble-charters
description: Regenerate the self-contained charters under templates/charters/ from their sources in templates/charters/sources/ (CHARTER_CORE.md + modules, per charters.manifest.md). Use after editing any charter source, or when the pre-commit freshness hook blocks a commit. Pass --all to rebuild every charter.
---

# assemble-charters

The charters adopters copy (`templates/charters/CHARTER_*.md`) are **generated** from `templates/charters/sources/`. Edit the sources; never edit a composed charter by hand.

## How to run

Assembly is implemented by a deterministic script — run it, do not prose-merge by hand:

```
make assemble            # = python3 tools/assemble.py --all
```

`tools/assemble.py` is the single implementation of the templating (`{{ vars }}`, `<!-- SLOT: name -->`, `===VARS===`/`===SLOT===` blocks, `project_parameters_extra` row appending, section numbering that skips *Project Parameters*). The same script powers `make new` (composing a charter with add-on modules at install time) and the pre-commit hook's freshness check (regenerate + byte-compare). If the script cannot express a new source construct, extend the script — never fall back to hand-editing the composed output.

## Rules

- Relative links in the sources already target `../requirements/…`, which resolves from `templates/charters/` — keep them verbatim.
- The composed file is self-contained: a reader must never need the sources. No `{{ }}` or `SLOT` markers may survive into the output (the script aborts if one would).
- Determinism: same sources → same composed output, byte for byte — that is what the hook diffs against.
- The shipped charters stay **minimal** (see the manifest); an adopting project that wants `MODULE_PRODUCT_AUDIENCE`, `MODULE_LIVING_DOCS`, or `MODULE_DATA_MIGRATION` composes them into its own copy (`make new … MODULES=…`) — do not add them to the shipped rows here.

## After assembling

Stage `templates/charters/` together with the updated `CHANGELOG.md` and root `README.md` + `docs/index.html` (if the change is adopter-facing) so the pre-commit hook passes.
