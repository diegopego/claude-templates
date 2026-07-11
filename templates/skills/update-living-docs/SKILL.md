---
name: update-living-docs
description: Build and maintain a project's living documentation — dual changelogs (technical + audience), a living product doc, and its landing page. Two modes — **rebuild** regenerates the whole set from the project's current state (first adoption of the pipeline, a large in-progress project, or a forced re-creation), reconciling an existing changelog into the technical/audience split; **update** folds one change into the pipeline incrementally. The landing publishes only behind an approval loop. Use when a project adopts MODULE_LIVING_DOCS, when its public face has drifted, or after an adopter-facing change. The executable arm of MODULE_LIVING_DOCS.
---

# update-living-docs

> **Embeddable skill template.** Copy this directory into the target project's `.claude/skills/update-living-docs/`. It automates the pipeline `MODULE_LIVING_DOCS` describes — a project adopts this skill together with that module. This note is harmless to leave in place.

This skill runs the **living documentation pipeline**: `change → audience changelog → living product doc → landing page`. It keeps two changelogs for two readers and a public face that is always current — the practice `MODULE_LIVING_DOCS` prescribes; this skill is how you execute it. The module is the authority; if the two ever differ, the module wins. Nothing publishes silently — the landing passes an **approval loop** every time.

## Two modes

- **rebuild** — regenerate the whole living-docs set from the project's **current state**. Use it when the pipeline does not exist yet (the project just adopted `MODULE_LIVING_DOCS`), when adopting into a **large project already in progress** (months of history, an existing changelog), or when the owner wants to **force a re-creation** (the docs drifted, or a big refactor made incremental updates untrustworthy). The "start from what the product *is* today" path.
- **update** — fold a **single change** (or the delta since the docs were last refreshed) into the pipeline, incrementally. The everyday path once the set exists.

Both modes end in the same place: a current living product doc and a regenerated landing, behind the approval loop.

## rebuild — from the current state

1. **Reconcile the changelog into two.** A project in progress usually already has one changelog, almost always **technical** (dev-facing, per-commit). In a Q&A round with the owner:
   - keep the existing file as the **technical changelog** — rename it if its name is ambiguous, so the split is legible; never discard the history;
   - create the **audience changelog** for the *Primary users* (Project Parameters), curated per significant change. Recommend a clear name (e.g. `docs/whats-new.md`, `CHANGELOG_USERS.md`) and let the owner choose.
2. **Seed the audience changelog honestly.** Do **not** fabricate a granular per-change past from hundreds of commits — that is low-fidelity noise. Seed it with **one baseline entry** describing what the product does *today* for its users. Optionally backfill a handful of **major milestones** from the technical changelog or release tags — only if the owner wants them and the source is reliable.
3. **Regenerate the current-state artifacts in full.** Build the **living product doc** from the product as it is now — code, existing docs, the technical changelog, the owner — present-tense, "what the product is," never "what changed." Then regenerate the **landing content** from that doc.
4. **Skin first if there is none.** If the project has no landing skin yet, it is **designed once** through the design interview `MODULE_LIVING_DOCS` describes (theme, reference site, palette, *Primary users*; Claude Design default, hand-authored HTML/CSS the fallback) — run that, or point the owner to it, before rendering. From then on the skin is fixed; only content regenerates.
5. **Approval loop, then publish** (below).

## update — one change at a time

1. **Scope the delta** — what changed since the docs were last refreshed (from git: the range since the last commit that touched the landing/changelog, or a range the owner gives).
2. **Technical changelog** — record the change for maintainers (per commit; git history is its raw record); group dense entries and add a plain-language addendum.
3. **Audience changelog** — for each change ask *does this change what the product does for its users, or how they use it?* If yes, write it at the *Primary users'* level — related commits grouped into one coherent story, not a diff stream.
4. **Living product doc** — revise the current-state summary so it reads as if the product had always been this way. The audience changelog is its primary input.
5. **Landing** — regenerate the content from the living doc into the fixed skin (never redesign ad hoc).
6. **Approval loop, then publish** (below).

## Approval loop (both modes)

Never publish silently:

1. **State the intent in text** — what will change on the landing and why, in the readers' terms.
2. **Render the preview** — regenerate the landing view from the living doc into the stable skin.
3. **Wait for the owner's approval.**
4. **Publish** — only then push the landing live.

Updating the markdown or the living doc is *not* publishing; the loop gates the outward-facing page, which may lag the source until the owner approves.

## Rules

- **Two readers, never merged.** Technical changelog → maintainers, per commit. Audience changelog → *Primary users*, per significant change; it is the source for every user-facing summary.
- **Current-state doc, not a changelog.** The living product doc says what the product *is now*; it never narrates changes.
- **Rebuild regenerates; update edits.** Rebuild is a full regeneration from current state (safe to re-run — the current-state artifacts are idempotent); update is a surgical incremental fold. Reach for rebuild when incremental trust is gone, not for routine changes.
- **Skin fixed, content live.** Designed once at Setup, held stable; only content regenerates. A rebrand is a deliberate re-run of the design interview, never an ad-hoc edit.
- **Never publish silently.** Every landing publish passes the approval loop.
- **Language.** User-facing docs follow the *User-facing language* parameter; other artifacts follow the project's language protocol.
- **No commits or publishes without authorization.** Prepare the updates and stop; committing and publishing need the owner's explicit go-ahead.
