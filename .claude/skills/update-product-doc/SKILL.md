---
name: update-product-doc
description: Update the living product document (root README.md) so it always reflects the product's current state for its users (template adopters). Works by delta from a versioned last-processed-commit marker, driven by the target-audience changelog — run on demand or before committing adopter-facing deliverable changes; the pre-commit hook blocks such commits when README.md is not staged.
---

# update-product-doc

The root `README.md` is the **living source of truth** for what this product is and how to use it — present-tense, always current, written for template adopters. This skill keeps it that way. It is a *current-state* document, not a changelog: describe what the product **is now**, never "what changed" (that is `changelog/`).

## When to run

On demand, or as part of the commit ritual, whenever the adopter-facing surface has moved since the skill last ran: composed charters (`templates/charters/CHARTER_*.md`), requirements (`templates/requirements/`), guides (`templates/guides/`), or the catalog (`templates/README.md`). The skill is **not tied to a single commit** — it processes the whole repo delta since a versioned marker, so it can also be run over an interval. When run before a commit that touches an adopter-facing deliverable, the pre-commit hook still requires `README.md` to be staged.

## How the delta works

The skill works from a **last-processed-commit marker**, not the staged diff:

- The marker lives at [`.claude/memory/last-processed-commit.md`](../../memory/last-processed-commit.md) and holds one commit SHA — the last commit whose changes are already reflected in `README.md`.
- The **primary input is the target-audience changelog** (`changelog/adopter.md`) — the interpretation layer that already frames each change in the users' terms. The raw diff is a secondary source, for structural current-state content no single changelog entry produces (e.g. a new "how to adopt" step).

## What to do

1. Read the marker SHA `M` from `.claude/memory/last-processed-commit.md`. Compute the delta window since `M`: `git log M..HEAD` and `git diff M` (the latter, with no `--cached`, spans committed-since-`M` **and** any staged/working changes when run before a commit).
2. Read the `changelog/adopter.md` entries added in that window — that is what the product's users are being told changed. Cross-check against `git diff M -- templates/` for adopter-facing deliverable changes (charters, requirements, guides, catalog) the changelog may not fully capture.
3. For each change, ask: **does this change what the product offers a user, or how they adopt it?** Translate it into user terms — a new/removed deliverable, a new phase or practice a charter now prescribes, a changed adoption step.
4. Update the matching part of `README.md` to describe the **new current state**. Add, revise, or remove prose so the document reads as if the product had always been this way. Do not append dated entries; do not narrate the change.
5. If a change in the window has **no** user-facing effect (e.g. a wording normalization), make no content change for it — but say so, so the author knows the landing page was considered.
6. **Advance the marker.** Write the current `HEAD` SHA into `.claude/memory/last-processed-commit.md` and stage it alongside `README.md`. When run before a commit, `HEAD` is the parent of the commit being made, so that commit's own changes are re-seen on the next run — but a current-state document is **idempotent** under reprocessing (the second pass finds `README.md` already describes them and changes nothing), so nothing is double-counted.

## Rules

- English (the root README is a meta-project artifact; the artifact-language rule applies — the pt-BR exception covers only `templates/`).
- Keep it a landing page: what the templates are → what you get → how to adopt → what the charters give a project. Link to the catalog and the guide; don't duplicate their full text.
- Source of truth: a published/rendered landing page (Artifact) may be derived from this file later, so keep the markdown clean and self-describing.

## Published landing page

A rendered landing page is derived from `README.md` and published as an Artifact — the canonical URL is `https://claude.ai/code/artifact/213558f8-c877-4046-8476-714e542a855e` (private to the owner unless shared). The HTML is a **generated view**, not versioned (README stays the single source of truth). The **skin** (design system, Nord palette) is settled once and held stable across redeploys; only the **content** re-renders from `README.md`.

Publishing passes an **approval loop** — never republish silently:

1. **State the intent in text** — what is about to change on the landing and why, in the reader's terms.
2. **Render the preview** — regenerate the HTML view from `README.md` into the stable skin.
3. **Wait for the owner's approval.**
4. **Publish** — only then republish to the same URL (pass it as `url` from a fresh conversation; the same file path keeps the URL within one conversation).

Updating `README.md` (the canonical markdown) is not publishing; the loop gates the outward-facing Artifact, which may lag the markdown until the owner approves.

## After updating

Stage `README.md` **and** the advanced marker (`.claude/memory/last-processed-commit.md`) together with the deliverable changes so the pre-commit hook passes and the next run starts from the right point.
