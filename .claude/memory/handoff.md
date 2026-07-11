# Handoff

Written 2026-07-11, at the close of the session that built the second embeddable skill, `adopt-template`. For a successor with zero conversation context: read `roadmap.md` first, then this.

## Current state

- Branch `master` (we always work directly on master — see `decisions.md`). This work is **staged but NOT yet committed** — the owner had not authorized a commit at handoff time. Working tree tip is `0e77455`. The staged set (9 files) passes the pre-commit freshness hook (verified via a hook dry-run, exit 0).
- **What this session did** — kicked off **Milestone 4's next candidate**: shipped `templates/skills/adopt-template/`, the second embeddable skill, automating `templates/guides/GUIDE_ADOPTION.md`.
  - `templates/skills/adopt-template/SKILL.md` — drives the guide's six-step non-destructive merge (inventory → classify keep/adapt/already-covered/skip → conflicts-always-ask → two-layer separation → merged `CLAUDE.md` + seeded `.claude/memory/` → prove-by-functioning). Follows the skill-template convention (frontmatter first, leading copy-me blockquote, body addressed to the adopter's agent).
  - **Design choice worth knowing** (in `decisions.md`): this skill runs *at adoption time*, before any charter is present, so it references the template set (`GUIDE_ADOPTION.md`, the charters) **by name, not by relative path** — paths break once the dir is copied into a foreign `.claude/skills/`. Contrast `graduate-idea`, which runs inside an already-adopted project and can say "your charter."
  - Catalog `templates/skills/README.md` + landing `README.md` (the *Embeddable skills* bullet now lists both skills; the *Existing project* adopt step notes the skill can run the guide). Both pt-BR mirrors regenerated. Both changelogs updated. Roadmap Milestone 4 item checked off.
- **Marker** advanced `2574ce1` → `0e77455` (current HEAD) as part of the landing update; the intervening `9a39229`/`0e77455` are already reflected in `README.md` (idempotent).
- The rendered **Artifact** landing was **not** republished this session — the landing content changed (two skills now listed), so it *should* be republished after owner approval per the approval loop. Canonical `README.md` is current. To update: fetch the Artifact URL via **WebFetch** (returns full raw HTML incl. the Nord `<style>` skin), edit only content, republish to the same URL (`…/artifact/213558f8-…`) after approval. Favicon 📜 (keep stable).
- `ideas/inbox.md` is empty.

## Next steps (roadmap → Milestone 3 tail + Milestone 4)

1. **Commit this session's work** once authorized (see the ritual below), then **republish the Artifact landing** after owner approval (content changed: two skills).
2. **Older open questions** — `product-not-bespoke` (per-tenant vs. whole-system backup/restore in `REQUIREMENT_PORTABLE_APPLIANCE.md`; tenant provisioning as a v1 feature vs. migration-seeded tenant #1); `translated-templates` (graduate into a reusable module?); `living-product-doc` tail (pt-BR landing page? graduate the living-manual practice into a charter section / embeddable skill).
3. **Deferred infra** — a marker-freshness rule in `check-freshness.sh`; GitHub Pages as the landing's public primary (Artifact-only today). Build-for-today: add when warranted.
4. **Milestone 4 tail** — the next skill candidate is open (a commit-ritual skill, or maturing the open questions above).

## Commit ritual (before authorizing a commit)

Staged set for THIS change (all 9 already staged, hook passes): `templates/skills/adopt-template/SKILL.md` + `templates/skills/README.md` (EN), `templates/i18n/pt-BR/skills/adopt-template/SKILL.md` + `templates/i18n/pt-BR/skills/README.md` (pt-BR), root `README.md`, `changelog/maintainer.md` + `changelog/adopter.md`, `.claude/memory/*` (roadmap, decisions, handoff, last-processed-commit). No charter source changed → no assembly needed. The hook's 4 rules (sources→composed, EN→pt-BR pairs, changelog on templates/ideas changes, README on adopter-facing changes) are all satisfied.

## Dead ends / cautions

- **The freshness hook's rule 4 does NOT fire on `templates/skills/README.md`** — its regex covers only top-level `templates/README.md`, charters, requirements, and guides. The landing was still updated by hand because a new embeddable skill is genuinely adopter-facing. If a future change *only* touches `templates/skills/` and you want the landing refreshed, do it deliberately; the hook won't force it.
- **Skill templates are copied into foreign repos** — never give them relative links into this repo's tree (they break on copy). Reference the charter/guide/template set by name, as `graduate-idea` and `adopt-template` both do.
- **pt-BR terms in use:** `adopt-template` skill uses "dono" for the owner (matching `graduate-idea`), though the pt-BR *guide* uses "owner"; adoption vocabulary from the pt-BR guide — "merge não-destrutivo", "manter/adaptar/já coberto/pular", "disposição", "cardápio, não um mandato", "Prove pelo funcionamento", "Trabalhando por perguntas".
- Conversation with the owner in pt-BR; every artifact (including this file) in English.
