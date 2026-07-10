<!--
SOURCE MODULE — not a deliverable. Fills the phase-1 (Understand) variant of
CHARTER_CORE.md. Pair it with MODULE_DATA_MIGRATION.md (see
charters.manifest.md) — this module leaves the data_migration slot to that
one. Content of a slot runs from its ===SLOT: name=== marker to the next ===.
-->

# Module — Extraction (Legacy)

Phase-1 variant for **transforming an existing system** (spreadsheet, desktop app, old codebase, paper process). The legacy system is the golden source: extract its knowledge with traceability, arbitrate conflicts, and treat its single production deployment as one customer's instance — not the product boundary.

===VARS===
charter_title = Legacy System Transformation
method_flavor = transformation
oracle = system author
phase1 = Understand
spec_term = golden standards
section_source_of_truth_title = Golden source, not a mirror
specify_phase_title = Golden standards

===SLOT: intro===
A reusable, self-contained working agreement for an AI coding agent (Claude Code or similar) tasked with **analyzing a legacy system — a spreadsheet, a desktop app, an old codebase, a paper process — and transforming it into a modern application**.

===SLOT: project_parameters===
| Parameter | Value |
|---|---|
| Legacy system (golden source) | *(spreadsheet / legacy app / document set that runs the business today)* |
| Access method | *(API + credentials, exported files, source code, screenshots…)* |
| Embedded logic locations | *(formulas, macros, Apps Scripts, stored procedures — where the rules hide)* |
| Domain expert role | *(the specialist hat the agent wears, e.g. senior residential appraiser)* |
| System author / oracle | *(who answers Q&A rounds — usually the user)* |
| Primary users | *(who operates the app day to day)* |
| Product scope | *(product for an audience — default | internal/bespoke tool)* |
| Conversation language | *(e.g. Brazilian Portuguese)* |
| Artifact language | English (default) |
| User-facing language | *(UI copy and generated business documents — often the users' language, not English)* |
| Stack | Modern strict TypeScript (default) |
| Prototyping tool | *(e.g. Claude Design)* |

===SLOT: source_of_truth===
The legacy system is the **golden standard**: it encodes how the business actually runs. The mission is to **extract the architecture, concepts, workflows, and rules behind it** — then redesign them as a proper application. Do not replicate the legacy system's shape or inherit its limitations; replicate its *knowledge*. Where the current process is manual, look for what the app can automate. Treat embedded logic (formulas, scripts, macros, triggers) as primary business-rule documentation — often the only accurate one.

Three rules keep the extraction honest:

- **A copy, not production.** The author provides the legacy system as a copy; the live system stays with the author, untouched. The agent has read/write access to the copy — writing is welcome to probe behavior (run a formula, exercise a script) — but the copy is still the golden source: keep writes deliberate and reversible so extraction evidence stays valid, and remember the copy drifts from live production (the cutover re-verification in the data-migration rules exists for exactly that).
- **Traceability.** Every extracted rule cites where it came from — sheet/tab/cell, formula, script function, or the Q&A round that established it.
- **Conflicts are surfaced, never silently resolved.** When embedded logic contradicts manual practice, or historical data contradicts the current process, bring it to an Align round; the system author arbitrates.

===SLOT: method_phase_one===
1. **Understand** — map the legacy system's structure, data, and embedded logic; draft the domain model and a first-pass concept inventory. *Exit: draft model and concept inventory presented to the system author.*

===SLOT: method_align===
Q&A rounds with the system's author to resolve ambiguities, confirm extracted concepts, and separate essential rules from workarounds forced by the old medium. Answers are recorded in repo memory. *Exit: no open question the author considers blocking.*

===SLOT: method_specify===
record the agreed business rules with the legacy system as the source of truth, each v1 feature with acceptance criteria. These documents become the spec and the test oracles, and include an explicit **not-in-v1 list** — restraint written down is restraint enforceable. *Exit: golden standards approved by the author.*

===SLOT: method_build===
implement the application per the stack and testing rules below, validating against the golden standards (and against real legacy data where available). *Exit: v1 acceptance criteria demonstrated by tests, migration reconciled per the data-migration rules below, and the appliance criteria met — deploy, backup, and an exercised restore per [REQUIREMENT_PORTABLE_APPLIANCE.md](../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md).*

===SLOT: extra_roles===

===SLOT: roles_first_pass===
After the first pass over the legacy system

===SLOT: instance_extraction===
- **Classify on extraction.** Every extracted rule is tagged **domain | instance-config | workaround** in the golden standards (alongside its traceability citation), and the instance values are consolidated into an instance-configuration document that becomes tenant #1's configuration profile at migration.

===SLOT: anti_over_eng_intro===

===SLOT: anti_over_eng_extra===

===SLOT: testing_integration_targets===
DB, APIs, legacy-source adapters

===SLOT: testing_oracle===
Golden standards from phase 3 become executable test oracles; where feasible, verify outputs against real data from the legacy system.

===SLOT: roadmap_scope===
the milestones toward v1, each with its ordered near-term tasks — including the migration & cutover work from the data-migration section

===SLOT: roadmap_origin===
concept inventory

===SLOT: decisions_overflow===
golden-standard material

===SLOT: secrets===
Credentials may live in the working directory but are **always gitignored**; private keys are never printed, logged, or committed. Plaintext secrets discovered in the legacy system (a common find) are flagged immediately, and any app feature replacing them gets real secret handling — encryption at rest, access control, audit trail. Secrets must also survive host loss: the restore procedure declares exactly which secrets it needs (see [REQUIREMENT_PORTABLE_APPLIANCE.md](../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md)).

Secrets are not the only sensitive find: legacy systems routinely hold PII and tax/financial records. Flag them during Understand; features that absorb them get access control and an audit trail, designed in Build — not bolted on.
