# adopt-into-existing-project

Status: agreed
Applies to: new deliverable `GUIDE_ADOPTION.md` (a new `GUIDE_` type, home `templates/guides/`); interacts with every charter and requirement, and with the module selection enabled by Milestone 2

## Behavior

A common situation the templates do not yet serve: an **existing, working software project** — which may or may not already use Claude — that wants to adopt these best practices **without losing the instructions it already has**. This is not the legacy charter (which extracts a legacy business system's knowledge to build a *new* app, retiring the old one); here the project keeps running and only its instruction/practice layer is adopted, reconciled, and extended.

`GUIDE_ADOPTION.md` prescribes a **non-destructive merge**:

1. **Inventory first.** Read the existing `CLAUDE.md` and any convention/instruction files; catalog the current rules before touching anything. If the inventory finds nothing (the project does not use Claude yet), the guide still applies — there is simply no merge to do: pick a charter, seed memory and roadmap, done.
2. **Classify each template section against the project**: *keep as-is* / *adapt to the template's framing* / *already covered by the project* / *not applicable — skip, with the reason recorded*. The template is a menu, not a mandate.
3. **Conflict rule: always ask.** When an existing instruction conflicts with a template practice, stop and put it to the owner with a recommendation — neither side wins automatically. Nothing is silently overwritten, and nothing is silently kept.
4. **Two layers, separated.** *Instruction-layer adoption* (merging `CLAUDE.md`, memory conventions) is safe and immediate. *Practice adoption that implies real code/infra changes* (portable-appliance, testing methodology) does not touch the running system during the merge — it becomes incremental, owner-approved roadmap work.
5. **Output.** A merged `CLAUDE.md` layering template practices over the preserved project instructions; a seeded `.claude/memory/` (roadmap of adopted-now vs. deferred practices); and a decision-log entry recording what was kept, adapted, or skipped and why — the adoption itself is traceable.
6. **Prove by functioning.** The project still builds and passes its tests after the instruction merge; adoption is proven by the project continuing to work, not by the merge looking clean.

## Why

Owner-observed gap: bringing these practices into an existing repo risks clobbering or contradicting instructions that already keep a live project working. Adoption must complement and adapt, not replace.

## Example

A Node service already has a `CLAUDE.md` with deploy conventions and a house lint style. Adoption keeps those verbatim, adapts its informal "write tests" note into the charter's testing-methodology framing, skips the portable-appliance requirement as not-applicable (it deploys via an existing platform), and puts "evaluate in-repo memory" on the roadmap rather than imposing it.

## Resolved (2026-07-10 Q&A)

- **Conflict default:** always ask — every conflict is surfaced to the owner with a recommendation; neither existing instruction nor template practice wins automatically.
- **No-instructions case:** in scope — the same guide covers it; inventory finds nothing, so there is no merge, just charter selection + memory/roadmap seeding.
- **Heavy practices (code/infra):** instruction-layer adoption is immediate; any practice that changes code or infra (e.g. portable-appliance) always goes to the roadmap as owner-approved incremental work, never touched during the merge.
- **Sequencing:** Milestone 2 already landed, so the guide is written against the modular charters — adoption can select applicable modules.

## Open questions

- None blocking. Future: whether the guide graduates into an `adopt-template` skill (roadmap Milestone 4).
