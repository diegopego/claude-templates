<!--
SOURCE MODULE — not a deliverable. Add-on module: turns the project into a
product for an audience — multi-tenant from v1, domain separated from
instance. Pluggable: add it to a charter's manifest row when the project is
a product serving multiple customer organizations, and leave it off for an
internal or bespoke tool. Supplies a "Product for an audience" section and a
Product scope row for the Project Parameters table. Consumed by the
`assemble-charters` skill per charters.manifest.md.
-->

# Module — Product for an audience

===SLOT: project_parameters_extra===
| Product scope | *(product for an audience — default with this module | internal/bespoke tool)* |

===SLOT: product_audience===
## Product for an audience, not a bespoke tool

Unless the {{ oracle }} explicitly declares otherwise, treat the project as a **product for an audience** — the primary users named in the Project Parameters — never as a bespoke solution for the interlocutor's organization. When the **Product scope** row is left unstated, assume *product for an audience* and declare that assumption where the {{ oracle }} can correct it cheaply.

- **Multi-tenant from v1.** The product is born serving multiple customer organizations; the interlocutor's organization is tenant #1, not the product boundary. Retrofitting tenancy later is among the most expensive migrations there is, so it counts as a today-requirement — a deliberate exception to "build for today" (see Anti-over-engineering), and the exception does not extend to speculative features. Two boundaries keep the exception honest: **v1 includes a minimal, operator-level tenant-creation path** (a command or admin action is enough — tenancy no second tenant can exercise is scaffolding, not a feature), while self-service onboarding stays on the roadmap until demand calls for it; and **backup/restore stays whole-system** (see [REQUIREMENT_PORTABLE_APPLIANCE.md](../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md)) — per-tenant export/import is a product feature a project decides at Align, not an appliance invariant.
- **Domain, not instance.** Separate rules general to the domain from the values and particularities of the interlocutor's organization. Instance specifics become configuration, never hardcoded behavior — in a legacy transformation, the instance-configuration values extracted from the golden source become tenant #1's configuration profile.
- **Ask, don't infer.** When it is unclear whether a rule is domain-general or interlocutor-specific, that is a mandatory Align question — never an inference.
