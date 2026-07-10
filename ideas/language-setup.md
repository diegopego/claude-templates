# language-setup

Status: incorporated
Applies to: core (both charters)

## Behavior

The charters gain a **Setup (step 0)** phase, before Discover/Understand: the agent walks the whole **Project Parameters** block with the oracle and confirms every value — never assuming a default silently. Blank rows are filled by asking; where a default applies (Product scope → *product for an audience*, artifact language → English), the agent states the assumption so the oracle can correct it. Languages (conversation, artifacts, user-facing) are confirmed as part of this pass, not silently defaulted.

## Why

The language protocol — and the product-scope default — only work if the parameters are actually set. The table had the rows, but nothing made choosing them an explicit step; a skipped row silently fell back to whatever the agent assumed.

## Example

A Brazilian project: conversation in pt-BR, artifacts in English, UI copy in pt-BR. Without the Setup step, an agent might write UI copy in English because the parameter row was left as placeholder text.

## Resolved

- Broadened from languages-only to the whole Project Parameters block (owner, 2026-07-10): a single Setup step-0 covers languages, Product scope, domain expert role, and every other parameter — one home for "don't assume a parameter."
- Incorporated into `CHARTER_CORE.md` (Method, phase 0).
