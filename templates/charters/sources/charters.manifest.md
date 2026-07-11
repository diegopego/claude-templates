# Charter assembly manifest

Which sources compose each self-contained charter under `templates/charters/`.
The `assemble-charters` skill reads this, fills `CHARTER_CORE.md` with the
listed modules' variables and slots, and writes the composed deliverable.
Later modules in a list win when two define the same slot;
`project_parameters_extra` is the exception — every module's rows are
appended, in list order, to the Project Parameters table.

| Composed charter | Core | Phase-1 module | Add-on modules |
|---|---|---|---|
| `CHARTER_GREENFIELD.md` | `CHARTER_CORE.md` | `MODULE_DISCOVERY_GREENFIELD.md` | — |
| `CHARTER_LEGACY_TRANSFORMATION.md` | `CHARTER_CORE.md` | `MODULE_EXTRACTION_LEGACY.md` | `MODULE_DATA_MIGRATION.md` |

## Add-on modules (opt-in per project)

The shipped composed charters are deliberately **minimal**. A project that
wants more adds modules to its charter's row and re-runs assembly (inside the
adopting repo, asking the agent to compose is enough — assembly is a
deterministic prose-merge):

- `MODULE_DATA_MIGRATION.md` — migration & cutover rules. Always on for legacy; add it to greenfield when the project imports inherited data.
- `MODULE_PRODUCT_AUDIENCE.md` — the project is a product for an audience: multi-tenant from v1, domain separated from instance. Leave off for internal/bespoke tools.
- `MODULE_LIVING_DOCS.md` — curated changelogs + living product doc + landing page with a Setup-designed skin and a publish approval loop.

Notes:

- Every module referenced in a row must define each variable and non-empty slot the composed charter needs; a slot no module fills is emitted empty (and its line dropped).
