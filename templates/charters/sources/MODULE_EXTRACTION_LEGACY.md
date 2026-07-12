<!--
SOURCE MODULE — not a deliverable. Fills the phase-1 (Understand) variant of
CHARTER_CORE.md, plus the cutover slot. Self-sufficient: it needs no other
module. Content of a slot runs from its ===SLOT: name=== marker to the next
===. Consumed by the `assemble-charters` skill per charters.manifest.md.
-->

# Module — Extraction (Legacy)

Phase-1 variant for **transforming an existing system** (spreadsheet, desktop app, old codebase, paper process). The golden sources are the standard: extract their knowledge with traceability, classify what is domain and what is instance, and arbitrate conflicts with the system author.

===VARS===
charter_title = Legacy System Transformation
method_flavor = transformation
oracle = system author
phase1 = Understand
spec_term = golden standards
section_source_of_truth_title = Golden sources, not a mirror
specify_phase_title = Golden standards

===SLOT: intro===
A reusable, self-contained working agreement for an AI coding agent (Claude Code or similar) tasked with **analyzing a legacy system — a spreadsheet, a desktop app, an old codebase, a paper process — and transforming it into a modern application**.

===SLOT: project_parameters===
| Parameter | Value |
|---|---|
| Golden sources | *(every system that encodes how the business runs today — the spreadsheet, the legacy app, the document set, a licensed reference manual. Name each one; where two can disagree, say which wins)* |
| Access method | *(per source: API + credentials, exported files, source code, screenshots…)* |
| Embedded logic locations | *(formulas, macros, Apps Scripts, stored procedures — where the rules hide)* |
| Domain expert role | *(the specialist hat the agent wears, e.g. senior residential appraiser)* |
| System author / oracle | *(who answers Q&A rounds — usually the user)* |
| Primary users | *(who operates the app day to day)* |
| Conversation language | *(e.g. Brazilian Portuguese)* |
| Artifact language | English (default) |
| User-facing language | *(UI copy and generated business documents — often the users' language, not English)* |
| Stack | Modern strict TypeScript (default) |
| Prototyping tool | *(e.g. Claude Design)* |

===SLOT: source_of_truth===
The **golden sources** named in the Project Parameters encode how the business actually runs. There is usually more than one — the workbook that operates the business *and* the licensed manual its rates were transcribed from; the desktop app *and* the scripts bolted onto it — so name each one individually, and where two can disagree, record which one wins. The mission is to **extract the architecture, concepts, workflows, and rules behind them** — then redesign those as a proper application. Do not replicate a legacy system's shape or inherit its limitations; replicate its *knowledge*. Where the current process is manual, look for what the app can automate. Treat embedded logic (formulas, scripts, macros, triggers) as primary business-rule documentation — often the only accurate one.

Six rules keep the extraction honest:

- **A copy, not production.** The author provides each golden source as a copy; the live system stays with the author, untouched. The agent has read/write access to the copy — writing is expected, not merely tolerated (see the next two rules) — and the copy starts drifting from live production the moment it is handed over, which is what the cutover re-verification exists for.
- **Operate it; don't just read it.** Reading a system does not find its defects. Drive it through whatever surface it exposes — a REST API, an MCP server, a browser driver against its UI, a script harness — and observe what it *does*: change an input, force an edge case, watch what recalculates. One changed dropdown can expose an error that a month of reading formulas would not. Probing writes are deliberate, reversible, and residue-free: **snapshot → write → recalculate → read → restore**.
- **The copy gets corrected.** Extraction finds genuine errors in the golden source — a mistyped rate, a formula that breaks on an edge case. They are neither silently worked around nor silently fixed: each is reported to the {{ oracle }} with its evidence, corrected in the copy once agreed, and **reconciled by the author back into production**, who then re-provides the copy. A correction is a traceable extraction output like any other.
- **Traceability.** Every extracted rule cites **which source** it came from and where inside it — sheet/tab/cell, formula, script function, manual edition and page, or the Q&A round that established it.
- **Classify on extraction.** Every extracted rule is tagged **domain | instance-config | workaround** in the golden standards, alongside its citation: rules general to the domain are kept as behavior; values particular to today's operation become configuration, never hardcoded; workarounds forced by the old medium are named so they are not faithfully rebuilt.
- **Conflicts are surfaced, never silently resolved.** When embedded logic contradicts manual practice, when historical data contradicts the current process, or when **two golden sources disagree**, bring it to an Align round; the {{ oracle }} arbitrates. A precedence rule agreed once in the Project Parameters settles that pair for good — anything it does not cover is a question, never an inference.

===SLOT: method_phase_one===
1. **Understand** — map the golden sources' structure, data, and embedded logic, **operating them** rather than only reading them; draft the domain model and a first-pass concept inventory. *Exit: draft model and concept inventory presented to the system author.*

===SLOT: method_align===
Q&A rounds with the system's author to resolve ambiguities, confirm extracted concepts, arbitrate disagreements between golden sources, and separate essential rules from workarounds forced by the old medium. Answers are recorded in repo memory. *Exit: no open question the author considers blocking.*

===SLOT: method_specify===
record the agreed business rules with the golden sources as the source of truth, each v1 feature with acceptance criteria. These documents become the spec and the test oracles, and include an explicit **not-in-v1 list** — restraint written down is restraint enforceable. *Exit: golden standards approved by the author.*

===SLOT: method_build===
implement the application per the stack and testing rules below, validating against the golden standards (and against real legacy data where available). *Exit: v1 acceptance criteria demonstrated by tests, the cutover agreed with the {{ oracle }}, and the appliance criteria met — deploy, backup, and an exercised restore per [REQUIREMENT_PORTABLE_APPLIANCE.md](../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md).*

===SLOT: extra_roles===

===SLOT: roles_first_pass===
After the first pass over the golden sources

===SLOT: anti_over_eng_intro===

===SLOT: anti_over_eng_extra===

===SLOT: testing_integration_targets===
DB, APIs, legacy-source adapters

===SLOT: testing_oracle===
Golden standards from the Golden standards phase become executable test oracles; where feasible, verify outputs against real data from the legacy system.

===SLOT: cutover===
## Cutover

The legacy system stays live — and keeps changing — while the app is built. That is true even of a project that inherits **zero** historical records, so it is planned regardless: decide when the legacy system freezes, whether the two run in parallel and for how long, and what makes the new app trusted enough to switch to. Before switching over, **re-verify the extracted rules against the source** — the copy the extraction was built from has been drifting from production ever since it was provided.

**Inherited historical data is out of scope for this charter.** If the app must carry records over from the legacy system, that import is a feature like any other: it is specified in the golden standards with acceptance criteria, and it goes on the roadmap. A project that starts empty owes none of it.

===SLOT: roadmap_scope===
the milestones toward v1, each with its ordered near-term tasks — including the cutover work

===SLOT: roadmap_origin===
concept inventory

===SLOT: decisions_overflow===
golden-standard material

===SLOT: secrets===
Credentials may live in the working directory but are **always gitignored**; private keys are never printed, logged, or committed. Plaintext secrets discovered in the legacy system (a common find) are flagged immediately, and any app feature replacing them gets real secret handling — encryption at rest, access control, audit trail. Secrets must also survive host loss: the restore procedure declares exactly which secrets it needs (see [REQUIREMENT_PORTABLE_APPLIANCE.md](../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md)).

Secrets are not the only sensitive find: legacy systems routinely hold PII and tax/financial records. Flag them during Understand; features that absorb them get access control and an audit trail, designed in Build — not bolted on.
