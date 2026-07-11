<!--
SOURCE MODULE — not a deliverable. Fills the phase-1 (Discover) variant of
CHARTER_CORE.md. Consumed by the `assemble-charters` skill per
charters.manifest.md. Content of a slot runs from its ===SLOT: name===
marker to the next === marker.
-->

# Module — Discovery (Greenfield)

Phase-1 variant for **building a new application from scratch**: the vision is the only source of truth, so written specs become the golden standard.

===VARS===
charter_title = Greenfield Project
method_flavor = discovery
oracle = product owner
phase1 = Discover
spec_term = specs
section_source_of_truth_title = Vision first, code last
specify_phase_title = Specify

===SLOT: intro===
A reusable, self-contained working agreement for an AI coding agent (Claude Code or similar) tasked with **building a new application from scratch** — no legacy system to inherit from, only a vision, a problem, and a product owner.

===SLOT: project_parameters===
| Parameter | Value |
|---|---|
| Product vision | *(one paragraph: the problem, who has it, what success looks like)* |
| Product owner / oracle | *(who answers Q&A rounds and approves decisions — usually the user)* |
| Domain expert role | *(the specialist hat the agent wears, e.g. senior logistics analyst)* |
| Primary users | *(who uses the product day to day)* |
| Conversation language | *(e.g. Brazilian Portuguese)* |
| Artifact language | English (default) |
| User-facing language | *(language of UI copy and generated documents — the primary users' language)* |
| Stack | Modern strict TypeScript (default) |
| Prototyping tool | *(e.g. Claude Design)* |

===SLOT: source_of_truth===
With no legacy system to mine, the risk inverts: instead of inheriting accidental complexity, the danger is **building the wrong thing confidently**. Requirements here are hypotheses until the product owner confirms them. Every phase before Build exists to make the domain model earn its shape through questions, written decisions, and prototypes — not through code that is expensive to unwind.

===SLOT: method_phase_one===
1. **Discover** — interrogate the vision: actors, workflows, entities, invariants, integrations, non-goals. Draft a domain model and a scope proposal (including an explicit *not-in-v1* list). *Exit: draft model and scope proposal presented to the product owner.*

===SLOT: method_align===
Q&A rounds with the product owner to resolve ambiguities and rank what matters. Challenge scope: the smallest product that delivers the vision wins. *Exit: no open question the owner considers blocking; priorities ranked.*

===SLOT: method_specify===
record the agreed business rules and domain decisions as written specs, each v1 feature with acceptance criteria. Significant technical decisions go to the decision log, each with its why and the rejected alternative. With no legacy source of truth, **these documents are the golden standard** and become the test oracles. When a later product-owner decision contradicts a spec, the owner's decision wins and the spec is updated in the same session — a stale golden standard is worse than none. *Exit: specs approved by the owner.*

===SLOT: method_build===
implement incrementally per the stack and testing rules below, thinnest end-to-end slice first, validating each slice against the specs. *Exit: v1 acceptance criteria demonstrated by tests, and the appliance criteria met — deploy, backup, and an exercised restore per [REQUIREMENT_PORTABLE_APPLIANCE.md](../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md).*

===SLOT: extra_roles===
 a **senior product thinker** (scope, priority, user value),

===SLOT: roles_first_pass===
After Discover

===SLOT: anti_over_eng_intro===
Greenfield is where over-engineering breeds — there is no legacy weight to restrain ambition. 

===SLOT: anti_over_eng_extra===
 No feature enters v1 without the product owner asking for it.

===SLOT: testing_integration_targets===
DB, external APIs

===SLOT: testing_oracle===
The specs from the Specify phase are the test oracles — every agreed rule maps to at least one test.

===SLOT: roadmap_scope===
the milestones toward the vision, each with its ordered near-term tasks

===SLOT: roadmap_origin===
scope proposal

===SLOT: decisions_overflow===
spec material

===SLOT: secrets===
Credentials may live in the working directory but are **always gitignored**; private keys are never printed, logged, or committed. Secret handling is designed in from the start — encryption at rest, access control, audit trail where the domain calls for it. Secrets must also survive host loss: the restore procedure declares exactly which secrets it needs (see [REQUIREMENT_PORTABLE_APPLIANCE.md](../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md)).

Sensitive data goes beyond credentials: if the domain handles PII or tax/financial records, name them during Discover, and give the features that hold them access control and an audit trail — designed in Build, not bolted on.
