---
name: update-product-doc
description: Update the living product document (root README.md) before a commit, so it always reflects the product's current state for its users (template adopters). Run before committing changes to adopter-facing deliverables; the pre-commit hook blocks such commits when README.md is not staged.
---

# update-product-doc

The root `README.md` is the **living source of truth** for what this product is and how to use it — present-tense, always current, written for template adopters. This skill keeps it that way. It is a *current-state* document, not a changelog: describe what the product **is now**, never "what changed" (that is `changelog/`).

## When to run

Before any commit that touches the adopter-facing surface: composed charters (`templates/charters/CHARTER_*.md`), requirements (`templates/requirements/`), guides (`templates/guides/`), or the catalog (`templates/README.md`). The pre-commit hook blocks these commits unless `README.md` is staged.

## What to do

1. Read the staged diff: `git diff --cached` (and `git diff --cached --name-only` for scope).
2. For each staged change to an adopter-facing deliverable, ask: **does this change what the product offers a user, or how they adopt it?** Translate the repo change into user terms — a new/removed deliverable, a new phase or practice a charter now prescribes, a changed adoption step.
3. Update the matching part of `README.md` to describe the **new current state**. Add, revise, or remove prose so the document reads as if the product had always been this way. Do not append dated entries; do not narrate the change.
4. If a staged deliverable change has **no** user-facing effect (e.g. a wording normalization), make no content change — but say so, so the author knows the landing page was considered. (The hook still expects `README.md` staged; if there is genuinely nothing to update, that is a signal the change may not be adopter-facing after all.)

## Rules

- English (the root README is a meta-project artifact; the artifact-language rule applies — the pt-BR exception covers only `templates/`).
- Keep it a landing page: what the templates are → what you get → how to adopt → what the charters give a project. Link to the catalog and the guide; don't duplicate their full text.
- Source of truth: a published/rendered landing page (Artifact) may be derived from this file later, so keep the markdown clean and self-describing.

## After updating

Stage `README.md` together with the deliverable changes so the pre-commit hook passes.
