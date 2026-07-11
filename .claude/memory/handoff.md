# Handoff

Written 2026-07-11, at the close of the session that incorporated the **last 2 of 6** Setup→changelog→landing cluster specs (`landing-publishing` + the `living-product-doc` rewiring). For a successor with zero conversation context: read `roadmap.md` first, then this.

## Current state

- Branch `master` (we always work directly on master — see `decisions.md`). This incorporation is **staged but NOT yet committed** — awaiting the owner's explicit commit authorization (never commit without it). The prior committed tip is `2574ce1`.
- **What this session did** — took the two remaining cluster specs into template text; **the six-spec cluster is now fully incorporated**:
  - **`landing-publishing`** → a **focused Setup addition** to `CHARTER_CORE.md` (owner Q&A): a new *Setup scaffolding* bullet **Landing skin, designed once** + a mention in the Method §0 *Setup* bullet ("…generate the initial project, and design the landing skin…"). Introduces the project's public **landing page** (rendered view of its living product documentation, written for the *Primary users*), its **design interview** (theme/reference-site/palette/audience/stack, scripted-then-adaptive, Claude Design default + hand-authored fallback), skin-fixed-once vs. content-regenerated, and the approval loop — content pipeline pointing to `REQUIREMENT_PROJECT_CLI.md`. It is an **in-section bullet, so no section renumbering** (greenfield still 1–18, legacy 1–18/19). Applied surgically to both composed charters + both pt-BR mirrors; verified no heading changes.
  - **`living-product-doc` rewiring** → **meta-project tooling only** (no template change). Rewired `.claude/skills/update-product-doc/SKILL.md` to work by **delta from a versioned last-processed-commit marker** (new file `.claude/memory/last-processed-commit.md`, seeded at `2574ce1`) **driven by the target-audience changelog** (`changelog/adopter.md`), advancing the marker to HEAD and staging it with `README.md`; the skill's *Published landing page* section now spells out the approval loop. Marker indexed in `MEMORY.md`.
  - Root `README.md` gained a *A living landing page* practice bullet + a landing-skin clause in the New-project adopt step; both changelogs updated; `decisions.md` entry added; both specs marked `incorporated`; roadmap updated.
- **Q&A round this session** settled two questions (in `decisions.md`): (1) landing-publishing enters the charter as a **focused Setup addition**, not a full new section (the living-doc/landing charter section stays deferred); (2) the pre-commit **hook stays as-is** — the marker is the skill's input mechanism only; a marker-freshness hook rule is deferred.
- The rendered **Artifact** landing (same URL `…/artifact/213558f8-…`, Nord skin) is **NOT yet republished** — held for the owner's approval per the landing approval loop. The canonical `README.md` is current. To update the Artifact: fetch the URL via WebFetch to recover the skin, edit content, republish to the same URL after approval.
- `ideas/inbox.md` is empty.

## Next steps (roadmap → Milestone 3 tail, then Milestone 4)

The cluster is done. Remaining open items on the roadmap:

1. **Older open questions** — `product-not-bespoke` (per-tenant vs. whole-system backup/restore in `REQUIREMENT_PORTABLE_APPLIANCE.md`; tenant provisioning as a v1 feature vs. migration-seeded tenant #1); `translated-templates` (graduate into a reusable module?); `living-product-doc` tail (pt-BR landing page? graduate the living-manual practice into a charter section / embeddable skill for adopters).
2. **Deferred this session** — a marker-freshness rule in `check-freshness.sh`; GitHub Pages as the landing's public primary (Artifact-only today). Build-for-today: add when warranted.
3. **Milestone 4** — next skill template: automate `GUIDE_ADOPTION.md` into an `adopt-template` skill.

## Commit ritual (before authorizing a commit)

The staged set for THIS incorporation: `templates/charters/CHARTER_GREENFIELD.md` + `CHARTER_LEGACY_TRANSFORMATION.md` (composed), `templates/charters/sources/CHARTER_CORE.md`, `templates/i18n/pt-BR/charters/*` (both), root `README.md`, `changelog/maintainer.md` + `changelog/adopter.md`, `ideas/living-product-doc.md` + `ideas/landing-publishing.md`, `.claude/skills/update-product-doc/SKILL.md`, `.claude/memory/*` (decisions, roadmap, handoff, MEMORY, last-processed-commit). The pre-commit hook checks 4 rules (sources→composed staged, EN→pt-BR pairs, changelog on templates/ideas changes, README on adopter-facing changes) — all satisfied.

## Dead ends / cautions

- **Do not regenerate composed charters with an ad-hoc script.** For source edits: apply the same edit surgically to both composed charters + both pt-BR mirrors, then verify with `git diff templates/charters/*.md | grep '^[+-]## '` that no headings/numbering changed and a non-heading diff to confirm only intended prose changed. This session's addition was an in-section bullet (no renumbering); verified clean.
- **The `update-product-doc` skill is now delta/marker-driven, not staged-diff-driven.** It reads `.claude/memory/last-processed-commit.md`, processes the delta since that SHA (primary input = `changelog/adopter.md`), updates `README.md`, and advances the marker to HEAD + stages it. When run pre-commit the marker points at the commit's parent; reprocessing is idempotent for a current-state doc, so nothing double-counts.
- **pt-BR terms in use:** greenfield oracle = "product owner"; legacy oracle = "autor do sistema"; section titles — *Working through questions* = "Trabalhando por perguntas", *Setup scaffolding* = "Scaffolding no Setup", *Changelogs* = "Changelogs"; *Primary users* param = "usuários primários". New landing terms: "skin da landing", "identidade visual", "entrevista de design", "loop de aprovação".
- Conversation with the owner in pt-BR; every artifact (including this file) in English.
