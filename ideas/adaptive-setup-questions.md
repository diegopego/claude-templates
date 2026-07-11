# adaptive-setup-questions

Status: incorporated
Applies to: core (all Q&A rounds, both charters)

> **Incorporated (2026-07-10).** Broadened from a Setup-only mechanism into the general **Q&A-round** method, now defined once in `CHARTER_CORE.md` → *Working through questions* (batched · options + recommendation · scripted-baseline-then-adaptive · answers become artifacts). The scripted-then-adaptive shape below is the third bullet of that section; it is no longer Setup-specific. The meta-project mirrors it in `CLAUDE.md` (graduating an inbox entry runs the same round). The residual *Open questions* remain to refine.

## Behavior

Setup (step 0) gathers its answers in **two passes**:

1. **Scripted baseline** — a fixed roadmap of questions the agent always asks, guaranteeing a floor of coverage: the Project Parameters block, stack/language, target audience, information sources, and — for the landing — theme/palette/reference-site (see [setup-scaffolds-project.md](setup-scaffolds-project.md) and [landing-publishing.md](landing-publishing.md)).
2. **Adaptive follow-ups** — after the baseline, the agent uses the answers and the project context to generate additional, targeted questions, going deeper only where the answers warrant it (e.g. "multi-tenant + healthcare → ask about data residency"). No fixed script for this pass.

Follow-ups are asked in rounds, each with options and a recommendation (the repo's established Q&A style), and stop when the agent has what it needs to proceed — not padded to a quota. This is a **general Setup mechanism**: confirming parameters, scaffolding the project, and the landing design interview all use it.

## Why

A purely scripted interview misses project-specific concerns the agent couldn't enumerate in advance; a purely free-form one has no floor and skips basics. Scripted-then-adaptive gets both: guaranteed baseline coverage plus context-sensitive depth.

## Example

Baseline captures "Node + strict TypeScript, multi-tenant, target audience = clinics." The adaptive pass then asks about per-tenant data isolation, health-data regulatory constraints, and whether clinics self-onboard — none on the fixed script, all implied by the baseline answers.

## Open questions

- How many adaptive rounds before it becomes fatiguing — a soft cap, or purely "until the agent has enough"?
- Does the adaptive pass ever revise/reopen a baseline answer, or only add new questions?
- Are the generated follow-ups and their answers logged (e.g. into `.claude/memory/`) so a re-run of Setup is reproducible?
