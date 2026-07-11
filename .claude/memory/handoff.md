# Handoff

Written 2026-07-11, at the close of the session that (a) shipped the `adopt-template` skill and (b) closed the Milestone 3 tail via a four-question Q&A round. For a successor with zero conversation context: read `roadmap.md` first, then this.

## Current state

- Branch `master` (we always work directly on master — see `decisions.md`). Two clusters of work this session, both **committed**:
  1. `715c956` *Ship adopt-template skill* + `d1a9ae4` *status correction* — the second embeddable skill (`templates/skills/adopt-template/`, automating `GUIDE_ADOPTION.md`), catalog, landing, pt-BR, changelogs. Artifact republished after approval (two-skills content).
  2. `95af458` *Close Milestone 3 tail* — the Q&A-round closure (16 files, hook passed; see below). This handoff update is the follow-up **status correction** recording the post-commit landing republication.
- **The Q&A round** (all four resolutions + rejected alternatives in `decisions.md`, entry *Q&A round closes the Milestone 3 tail*):
  - Backup/restore stays **whole-system**; per-tenant export/import = product feature decided at Align. `REQUIREMENT_PORTABLE_APPLIANCE.md` unchanged.
  - **v1 includes a minimal, operator-level tenant-creation path**; self-service onboarding = roadmap-on-demand.
  - **`translated-templates` stays meta-project tooling** until an adopting project asks. Spec → incorporated.
  - **The landing's language is a Setup choice** (owner's own principle): the landing follows the *User-facing language* parameter already in the language protocol — no template change; this repo's choice is English. Living-manual charter-section graduation stays deferred (own roadmap item now).
- **Template text change:** one sentence block appended to the `CHARTER_CORE` *Multi-tenant from v1* bullet ("Two boundaries keep the exception honest: …" — operator-level tenant creation + whole-system backup, linking `../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md`). Applied surgically to the source + both composed charters + both pt-BR mirrors; verified no heading/numbering changes (`git diff … | grep '^[+-]## '` empty). pt-BR rendering: "Duas fronteiras mantêm a exceção honesta … caminho mínimo, de nível operador, para criar tenants … backup/restore permanece do sistema inteiro … no Alinhar".
- `ideas/product-not-bespoke.md` → **incorporated** (open questions resolved in place); `ideas/translated-templates.md` → **incorporated**; pt-BR-landing question struck through as resolved in `living-product-doc.md` + `landing-publishing.md`.
- Landing `README.md`: *Product for an audience* practice bullet gained the two boundaries. **Marker** advanced `0e77455` → `d1a9ae4` (full SHA verified via `git rev-parse`, not guessed). Roadmap updated.
- The **Artifact** landing **was republished to the same URL after owner approval** (2026-07-11; same URL `…/artifact/213558f8-…`, Nord skin unchanged, favicon 📜; one content edit — the *Product for an audience* practice card gained the two-boundaries sentence). The reconstructed HTML lives at this session's `scratchpad/landing.html`; from a fresh session, WebFetch the URL instead.
- `ideas/inbox.md` is empty.

## Next steps

1. **Deferred items** (all reaffirmed, none blocking): living-manual practice → charter section / embeddable skill; marker-freshness rule in `check-freshness.sh`; GitHub Pages as the landing's public primary. Build-for-today: add when warranted.
3. **Milestone 4 tail** — next skill candidate open (a commit-ritual skill was floated; or whatever the owner queues next). Milestone 3 is otherwise **fully closed**.

## Commit ritual (for the record — committed as `95af458`)

The Milestone-3-tail closure committed with: `templates/charters/sources/CHARTER_CORE.md` + both composed charters + both pt-BR mirrors, `ideas/product-not-bespoke.md` + `translated-templates.md` + `living-product-doc.md` + `landing-publishing.md`, root `README.md`, both `changelog/` files, `.claude/memory/*` (roadmap, decisions, handoff, last-processed-commit). Hook rules: 1 (source→composed ✓), 2 (EN→pt-BR ✓), 3 (changelog ✓), 4 (README ✓). No assembly script — the source edit was mirrored surgically (see cautions).

## Dead ends / cautions

- **Do not regenerate composed charters with an ad-hoc script.** For source edits: apply the same edit surgically to the source, both composed charters, and both pt-BR mirrors, then verify with `git diff templates/charters/ templates/i18n/pt-BR/charters/ | grep '^[+-]## '` that no headings/numbering changed. This session's edit was in-bullet — verified clean.
- **Never fabricate a SHA.** The marker takes the full 40-char SHA from `git rev-parse HEAD` — an abbreviated prefix from the commit output is not enough and inventing the tail corrupts the marker (caught and fixed this session).
- **The freshness hook's rule 4 does NOT fire on `templates/skills/README.md`** (regex covers only top-level `templates/README.md`, charters, requirements, guides). Update the landing deliberately when only `templates/skills/` changes.
- **Skill templates are copied into foreign repos** — reference the charter/guide/template set by name, never by relative path.
- **pt-BR terms in use:** greenfield oracle = "product owner"; legacy oracle = "autor do sistema"; Align = "Alinhar"; new this session: "caminho mínimo, de nível operador, para criar tenants", "backup/restore … do sistema inteiro", "andaime, não feature".
- Conversation with the owner in pt-BR; every artifact (including this file) in English.
