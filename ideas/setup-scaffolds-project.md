# setup-scaffolds-project

Status: incorporated
Applies to: core (Setup phase, both charters). Delivered by the Setup CLI (see [lifecycle-cli.md](lifecycle-cli.md)).

## Behavior

At **Setup (step 0)**, beyond confirming the Project Parameters, the agent asks about the **technology stack, language, and related choices** and **generates a complete initial project setup** from the answers: the project skeleton and configuration appropriate to the chosen stack (e.g. strict `tsconfig`, test runner, lint, a functional-core / imperative-shell folder layout), the working-agreement wiring (a `CLAUDE.md` referencing the charter), and a seeded `.claude/memory/` (roadmap + decisions + index). Setup bootstraps the project so Discover/Understand and Build can begin — it does not just record parameters.

**Tech choices are the developer's, made at Setup.** The charter's stack picks (strict TypeScript, functional-core / imperative-shell, a test runner) are **recommended defaults — stated and overridable**, never silent assumptions. The developer chooses during Setup; the agent surfaces each pick as a recommendation the developer can accept or replace. This is the existing "never assume a parameter" Setup rule applied to the technology rows.

## Why

A Setup that only confirms parameters leaves the project a blank folder. The stack and language choices determine the scaffolding; capturing them at Setup and generating the skeleton removes a manual gap before real work starts. Making the tech picks explicit choices (not baked-in defaults) keeps the templates from imposing the author's biased technology preferences on every project.

## Example

Answers "Node + strict TypeScript, UI in pt-BR" → Setup generates `tsconfig` (strict), a test runner, lint config, a `src/` core/shell skeleton, `CLAUDE.md` referencing the charter, and a seeded `.claude/memory/`. Had the developer answered "Go", the same Setup step would present Go-idiomatic defaults instead of the TypeScript ones.

## Resolved (Q&A round, 2026-07-10)

- **How much to scaffold vs. defer:** minimum runnable skeleton only — no speculative CI, appliance, or infra stubs (anti-over-engineering). A stub is added when a today-requirement calls for it, not on spec.
- **Adapting to a non-default stack:** the generated setup adapts to the chosen stack — the charter's picks are recommendations surfaced at Setup, and the developer's choice drives what is generated (see the tech-choices paragraph above).
- **Where scaffolding runs:** inside Setup, delivered by the Setup CLI (see [lifecycle-cli.md](lifecycle-cli.md)) — Setup both gathers the answers and generates the skeleton, so Build starts against a runnable project rather than creating the skeleton as its first slice.

## Open questions

- (none blocking; graduates into template text — a `CHARTER_CORE` Setup addition plus the CLI requirement)
