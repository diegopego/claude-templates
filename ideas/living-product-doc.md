# living-product-doc

Status: incorporated (2026-07-11)
Applies to: this repo (meta-project tooling) now; candidate template practice for projects built from a charter

> Incorporated 2026-07-11: the `update-product-doc` skill was rewired to work by **delta from a versioned last-processed-commit marker** (`.claude/memory/last-processed-commit.md`) driven by the target-audience changelog, and to advance the marker on each run. This is meta-project tooling; the template-practice facet below stays deferred (see roadmap). The pre-commit hook was left unchanged (owner Q&A — see `decisions.md`). The adopter-facing pipeline is specified in [../templates/requirements/REQUIREMENT_PROJECT_CLI.md](../templates/requirements/REQUIREMENT_PROJECT_CLI.md) (`update-docs`).

## Behavior

The repo keeps a **living product document** — the root `README.md` — that is the **source of truth** for the product's current state, written for its users (here, template adopters): what the templates are, what they offer, and how to adopt them. It is present-tense and always current, distinct from the `changelog/` (which is history). A published landing page (e.g. a rendered Artifact) can later be derived from this document — the markdown file is canonical.

A skill, `update-product-doc`, keeps the living-doc current. The pre-commit hook requires the landing page to be staged when the adopter-facing deliverables change (composed charters, requirements, guides, catalog).

**Delta model (refined 2026-07-10, was inbox #1):** the skill works by **delta from a versioned last-processed-commit marker**, not the pre-commit staged diff. A marker (a field under `.claude/memory/`) records the last commit the skill processed; on each run the skill scans the repo delta since that marker, updates the manuals and landing page, and advances the marker to `HEAD`. This decouples the update from the commit moment — the skill can run on demand over an interval — while still fitting the pre-commit hook (a commit that leaves the marker behind is one the hook can flag). Rejected: the staged-diff model (tied to the commit, no interval) and deriving the delta from git history alone (fragile under history rewrites).

**Pipeline (refined 2026-07-10):** the update is driven by the **target-audience changelog**, not the raw diff — the flow is *target-audience changelog → living-product-doc → landing page*. The changelog is the interpretation layer (what changed, in the user's terms), the living-doc integrates those deltas into a curated current-state picture, and the landing page renders it (through the approval loop — see [landing-publishing.md](landing-publishing.md)). The landing page is **single, for the target audience** (not per-audience). This reconciles the earlier "landing derives from the living-doc" decision with the idea that the changelog drives the landing — it does so transitively, via the living-doc. *Rewiring `update-product-doc` to consume the target-audience changelog entry and the last-processed-commit marker (instead of re-reading the staged diff) was **incorporated 2026-07-11**.*

## Why

Adopters need a document that answers "what is this and how do I use it, right now" and never goes stale. The changelog answers "what changed, when" — a different question. Without a living current-state doc, the truth about the product lives scattered across commits.

## Relationship to the changelog

Still two distinct artifacts — the changelog is chronological history, the living-doc is curated current state — but they are now a **pipeline, not parallel**: the target-audience changelog is the input that updates the living-doc (see [audience-aware-changelogs.md](audience-aware-changelogs.md)). The living-doc is not a mechanical rollup of the changelog: it also holds structural current-state content (e.g. "how to adopt") that no single change produces.

## Template-practice facet

A project built from a charter would keep its own living user manual / landing page, updated each commit by an embedded skill that expresses changes in end-user terms. Tracked for later (see roadmap) — like `translated-templates`, this is dogfooded here first, then considered as a template deliverable.

## Location note

The landing page is the **root `README.md`**, not under `templates/` — it documents *our* product and must not be copied into adopter repos (anti-contamination). The catalog stays at `templates/README.md`.

## Published landing page

Done (2026-07-10, dogfooding): a rendered landing page derived from `README.md` is published as an Artifact at `https://claude.ai/code/artifact/213558f8-c877-4046-8476-714e542a855e` (private unless shared). The HTML is a generated view, not versioned; the `update-product-doc` skill republishes it to the same URL when README changes.

## Open questions

- pt-BR landing page? The root README is a meta-project artifact (English per repo rule); revisit if a Portuguese landing page is wanted (it is outside the `translate-templates` scope, which covers only `templates/`).
- When to graduate the template-practice facet into an actual charter section / embeddable skill.
- Publishing targets (Artifact + GitHub Pages) and Claude Design prototyping are speced separately in [landing-publishing.md](landing-publishing.md).
