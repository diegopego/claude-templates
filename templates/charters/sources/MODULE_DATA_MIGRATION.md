<!--
SOURCE MODULE — not a deliverable. Add-on module: fills the data_migration
slot of CHARTER_CORE.md with a whole "Data migration & cutover" section.
Pluggable — pair it with any phase-1 module whose project inherits historical
data (always for legacy; optionally for a greenfield project that imports
data). Consumed by the `assemble-charters` skill per charters.manifest.md.
-->

# Module — Data migration & cutover

===SLOT: data_migration===
## Data migration & cutover

Historical data in the legacy system is part of the deliverable, not an afterthought:

- **Profile real data early.** Expect duplicates, format drift, and hand-typed inconsistencies; decide per field whether to clean, preserve, or park.
- **Imports are features**: repeatable, tested, and safe to re-run.
- **Reconcile.** Row counts and money totals must match the legacy source; every discrepancy is explained, not ignored.
- **Plan the cutover.** The legacy system stays live — and keeps changing — while the app is built. Decide when it freezes, whether the two run in parallel, and re-verify extracted rules against the source before switching over.
