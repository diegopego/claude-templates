# setup-scaffolds-project

Status: draft
Applies to: core (Setup phase, both charters)

## Behavior

At **Setup (step 0)**, beyond confirming the Project Parameters, the agent asks about the **technology stack, language, and related choices** and **generates a complete initial project setup** from the answers: the project skeleton and configuration appropriate to the chosen stack (e.g. strict `tsconfig`, test runner, lint, a functional-core / imperative-shell folder layout), the working-agreement wiring (a `CLAUDE.md` referencing the charter), and a seeded `.claude/memory/` (roadmap + decisions + index). Setup bootstraps the project so Discover/Understand and Build can begin — it does not just record parameters.

## Why

A Setup that only confirms parameters leaves the project a blank folder. The stack and language choices determine the scaffolding; capturing them at Setup and generating the skeleton removes a manual gap before real work starts.

## Example

Answers "Node + strict TypeScript, UI in pt-BR" → Setup generates `tsconfig` (strict), a test runner, lint config, a `src/` core/shell skeleton, `CLAUDE.md` referencing the charter, and a seeded `.claude/memory/`.

## Open questions

- How much to scaffold vs. defer (anti-over-engineering — no speculative structure): minimum runnable skeleton only, or also CI / appliance stubs?
- When the owner picks a stack other than the default strict TypeScript, how far does the generated setup adapt?
- Does the scaffolding step run inside Setup, or does Setup only gather answers and a first Build slice creates the skeleton?
