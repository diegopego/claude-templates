# audience-aware-changelogs

Status: agreed
Applies to: core (new `CHARTER_CORE` section — Changelogs)

## Behavior

The agent maintains **two curated changelogs** (not one per every stakeholder — just these two):

1. a **technical changelog** — with a plain-language addendum explaining jargon and complex passages; the raw underlying record is the **git history** itself, which the curated technical changelog groups and summarizes. **Cadence: per commit** — updated on every commit (git history is its lastro underneath);
2. a **target-audience changelog** — written at the product users' level of knowledge and interest. **Cadence: curated per significant change** — it groups related commits into one entry so the end user is not flooded with fine-grained noise.

The **target audience** is captured at **Setup** (a Project Parameters row). The target-audience changelog is the *interpretation layer* that feeds the living-product-doc → landing page (see [living-product-doc.md](living-product-doc.md)). To frame each change well, the agent determines the best information sources — git log, tests, the code itself — and asks the owner what it still needs.

## Why

Two levels keep everyone informed without proliferation: developers/maintainers read the technical changelog (backed by git history), product users read the target-audience changelog — which also drives the current-state doc and the landing page. The split cadence matches each reader: maintainers want per-commit granularity; end users want a curated story, not every commit.

## Example

This repo dogfoods exactly this: [changelog/maintainer.md](../changelog/maintainer.md) (technical) + [changelog/adopter.md](../changelog/adopter.md) (target audience). A Harbour project: a technical changelog + an end-user changelog.

## Resolved (Q&A round, 2026-07-10)

- **Cadence:** technical **per commit**, target-audience **curated per significant change** (grouping commits). Rejected: both-per-commit (noisy for the audience view) and both-per-milestone (technical loses fine granularity).
- **Core vs. module:** a **`CHARTER_CORE` section**, not a pluggable module — every project wants a technical + a target-audience changelog, universal like memory/roadmap/decisions.
- **Declaring the audience at Setup:** the target audience is a **Project Parameters row**, confirmed during Setup (step 0) alongside the other parameters; the preferred information sources are chosen by the agent per change (git log / tests / code) and it asks the owner for what it still needs.

## Open questions

- (none blocking; graduates into template text — a new `CHARTER_CORE` Changelogs section, with the Setup phase gaining the target-audience Project Parameters row)
