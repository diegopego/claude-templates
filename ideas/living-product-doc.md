# living-product-doc

Status: agreed
Applies to: this repo (meta-project tooling) now; candidate template practice for projects built from a charter

## Behavior

The repo keeps a **living product document** — the root `README.md` — that is the **source of truth** for the product's current state, written for its users (here, template adopters): what the templates are, what they offer, and how to adopt them. It is present-tense and always current, distinct from the `changelog/` (which is history). A published landing page (e.g. a rendered Artifact) can later be derived from this document — the markdown file is canonical.

A skill, `update-product-doc`, is run **before each commit**: it analyzes the staged diff and updates the landing page to reflect any user-facing change — translating "what changed in the repo" into "what this means for a user of the product." The pre-commit hook requires the landing page to be staged when the adopter-facing deliverables change (composed charters, requirements, guides, catalog).

## Why

Adopters need a document that answers "what is this and how do I use it, right now" and never goes stale. The changelog answers "what changed, when" — a different question. Without a living current-state doc, the truth about the product lives scattered across commits.

## Distinct from audience-aware-changelogs

Two artifacts, one mechanism: the changelog is chronological history; the living manual is current state. The same pre-commit skill moment feeds both from the staged diff. This keeps `ideas/audience-aware-changelogs.md` separate rather than merged.

## Template-practice facet

A project built from a charter would keep its own living user manual / landing page, updated each commit by an embedded skill that expresses changes in end-user terms. Tracked for later (see roadmap) — like `translated-templates`, this is dogfooded here first, then considered as a template deliverable.

## Location note

The landing page is the **root `README.md`**, not under `templates/` — it documents *our* product and must not be copied into adopter repos (anti-contamination). The catalog stays at `templates/README.md`.

## Open questions

- pt-BR landing page? The root README is a meta-project artifact (English per repo rule); revisit if a Portuguese landing page is wanted (it is outside the `translate-templates` scope, which covers only `templates/`).
- When to graduate the template-practice facet into an actual charter section / embeddable skill.
