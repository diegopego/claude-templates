# Charter assembly manifest

Which sources compose each self-contained charter under `templates/charters/`.
The `assemble-charters` skill reads this, fills `CHARTER_CORE.md` with the
listed modules' variables and slots, and writes the composed deliverable.
Later modules in a list win when two define the same slot.

| Composed charter | Core | Phase-1 module | Add-on modules |
|---|---|---|---|
| `CHARTER_GREENFIELD.md` | `CHARTER_CORE.md` | `MODULE_DISCOVERY_GREENFIELD.md` | — |
| `CHARTER_LEGACY_TRANSFORMATION.md` | `CHARTER_CORE.md` | `MODULE_EXTRACTION_LEGACY.md` | `MODULE_DATA_MIGRATION.md` |

Notes:

- A greenfield project that inherits data may add `MODULE_DATA_MIGRATION.md` to its row — the module is pluggable by design.
- Every module referenced here must define each variable and non-empty slot the composed charter needs; a slot no module fills is emitted empty (and its line dropped).
