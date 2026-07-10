# language-setup

Status: draft
Applies to: core (both charters)

## Behavior

When a charter is instantiated in a new project (Project Parameters being filled), the agent explicitly asks the owner which languages apply — conversation, artifacts, user-facing text — instead of assuming defaults silently. The chosen values are recorded in the Project Parameters block during setup.

## Why

The language protocol only works if the parameters are actually set. Today the table has language rows, but nothing makes choosing them an explicit setup step — a skipped row silently falls back to whatever the agent assumes.

## Example

A Brazilian project: conversation in pt-BR, artifacts in English, UI copy in pt-BR. Without an explicit setup question, an agent might write UI copy in English because the parameter row was left as placeholder text.

## Open questions

- Should the charters gain a short "Setup" section (step 0, before Discover/Understand) that walks through the whole Project Parameters block, not just languages?
