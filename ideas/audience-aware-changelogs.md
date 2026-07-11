# audience-aware-changelogs

Status: draft
Applies to: core (candidate new module: DOCUMENTATION_BY_AUDIENCE)

## Behavior

At every commit, the agent maintains **two curated changelogs** (not one per every stakeholder — just these two):

1. a **technical changelog** — with a plain-language addendum explaining jargon and complex passages; the raw underlying record is the **git history** itself, which the curated technical changelog groups and summarizes;
2. a **target-audience changelog** — written at the product users' level of knowledge and interest.

The **target audience** is captured at **Setup** (a Project Parameters row). The target-audience changelog is the *interpretation layer* that feeds the living-product-doc → landing page (see [living-product-doc.md](living-product-doc.md)). To frame each change well, the agent determines the best information sources — git log, tests, the code itself — and asks the owner what it still needs.

## Why

Two levels keep everyone informed without proliferation: developers/maintainers read the technical changelog (backed by git history), product users read the target-audience changelog — which also drives the current-state doc and the landing page.

## Example

This repo dogfoods exactly this: [changelog/maintainer.md](../changelog/maintainer.md) (technical) + [changelog/adopter.md](../changelog/adopter.md) (target audience). A Harbour project: a technical changelog + an end-user changelog.

## Open questions

- Changelog per commit or per milestone (per commit may be noisy)?
- Is this a core section or a pluggable module referenced by both charters?
- Exactly how the target audience and the preferred information sources are declared at Setup.
