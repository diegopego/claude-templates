# adopt-into-existing-project

Status: draft
Applies to: new deliverable `GUIDE_ADOPTION.md` (a new `GUIDE_` type, home `templates/guides/`); interacts with every charter and requirement, and with the Milestone 2 modularization

## Behavior

A common situation the templates do not yet serve: an **existing, working software project** — which may or may not already use Claude — that wants to adopt these best practices **without losing the instructions it already has**. This is not the legacy charter (which extracts a legacy business system's knowledge to build a *new* app, retiring the old one); here the project keeps running and only its instruction/practice layer is adopted, reconciled, and extended.

`GUIDE_ADOPTION.md` prescribes a **non-destructive merge**:

1. **Inventory first.** Read the existing `CLAUDE.md` and any convention/instruction files; catalog the current rules before touching anything.
2. **Classify each template section against the project**: *keep as-is* / *adapt to the template's framing* / *already covered by the project* / *not applicable — skip, with the reason recorded*. The template is a menu, not a mandate.
3. **Conflict rule (proposed default): existing instructions win.** A working project's rules encode hard-won reality; conflicts are surfaced to the owner, never silently overwritten — the same "conflicts are surfaced" stance the legacy charter takes.
4. **Two layers, separated.** *Instruction-layer adoption* (merging `CLAUDE.md`, memory conventions) is safe and immediate. *Practice adoption that implies real code/infra changes* (portable-appliance, testing methodology) does not touch the running system now — it becomes incremental, owner-approved roadmap work.
5. **Output.** A merged `CLAUDE.md` layering template practices over the preserved project instructions; a seeded `.claude/memory/` (roadmap of adopted-now vs. deferred practices); and a decision-log entry recording what was kept, adapted, or skipped and why — the adoption itself is traceable.
6. **Prove by functioning.** The project still builds and passes its tests after the instruction merge; adoption is proven by the project continuing to work, not by the merge looking clean.

## Why

Owner-observed gap: bringing these practices into an existing repo risks clobbering or contradicting instructions that already keep a live project working. Adoption must complement and adapt, not replace.

## Example

A Node service already has a `CLAUDE.md` with deploy conventions and a house lint style. Adoption keeps those verbatim, adapts its informal "write tests" note into the charter's testing-methodology framing, skips the portable-appliance requirement as not-applicable (it deploys via an existing platform), and puts "evaluate in-repo memory" on the roadmap rather than imposing it.

## Open questions

- Confirm the conflict default (existing-wins-and-surface) — this changes the guide's core behavior, so it gates `draft → agreed`.
- No-instructions case: when the existing project has no `CLAUDE.md` yet, does this guide cover it too (inventory finds nothing → closer to dropping in a charter), or is that out of scope?
- Sequencing vs. Milestone 2: author the guide against today's monolithic charters now, then enrich it once charters are modularized (adoption becomes "select applicable modules + merge")?
- Interaction with requirements that imply real change (portable-appliance): always defer to roadmap, or let the owner opt into immediate adoption?
