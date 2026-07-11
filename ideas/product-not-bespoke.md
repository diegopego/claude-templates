# product-not-bespoke

Status: incorporated
Applies to: core (both charters; extraction rules apply to legacy)

## Behavior

Unless the owner explicitly declares otherwise, the agent treats every project as **a product for an audience** — the primary users named in the Project Parameters — never as a bespoke solution for the interlocutor's organization. Concretely:

- The Project Parameters block gains a **Product scope** row (*product for an audience* | *internal/bespoke tool*). When left unstated, the agent assumes *product for an audience* and declares that assumption in the scope proposal, where the owner can correct it cheaply.
- **The product is multi-tenant from v1**: it is born serving multiple customer organizations. The interlocutor's organization is tenant #1, not the product boundary.
- During Discover/Understand, the agent separates **domain** from **instance**: rules general to the domain versus values and particularities of the interlocutor's organization (or of the legacy system's single production deployment).
- During legacy extraction, every extracted rule is classified — **domain | instance-config | workaround** — in the golden standards (alongside the traceability citation), *and* a consolidated **instance-configuration document** gathers the instance values; at migration it becomes tenant #1's configuration profile.
- During Align, when the agent cannot tell whether a rule is domain-general or interlocutor-specific, that is a mandatory Q&A question — never an inference.

## Why

Real failure mode observed by the owner: in past projects Claude interpreted the mission as a solution specific to the interlocutor, or inferred that from the production legacy system presented. A legacy system is *one customer's instance*, not the product boundary; hardcoding its specifics forecloses the product.

## Example

A legacy appraisal spreadsheet carries the interlocutor company's name, tax configuration, and workflow quirks. Extraction classifies those as instance-config of tenant #1 — the product serves appraisers in general.

## Tension with anti-over-engineering (resolved)

Anti-over-engineering says "build for today's requirements"; this spec makes multi-tenancy a deliberate, owner-decided exception: tenancy is treated as a *today requirement* of every product, because retrofitting it is among the most expensive migrations there is. The exception does not extend further — feature speculation remains forbidden; being a product is not a license to build a platform.

## Open questions

None — both resolved in the 2026-07-11 Q&A round (see `decisions.md`) and incorporated into the *Multi-tenant from v1* bullet of `CHARTER_CORE`:

- **Backup/restore is whole-system only.** `REQUIREMENT_PORTABLE_APPLIANCE.md` is unchanged; per-tenant export/import is a product feature a project decides at Align, not an appliance invariant.
- **v1 includes a minimal, operator-level tenant-creation path** (command or admin action); self-service onboarding stays on the roadmap until demand calls for it. Tenant #1 may still be seeded by migration — but a second tenant must be creatable.
