---
name: adopt-template
description: Adopt these templates into an existing project without losing its current instructions — inventory the project's `CLAUDE.md` (and any convention docs), classify each charter section and requirement as keep/adapt/already-covered/skip, raise every conflict to the owner, then produce a merged `CLAUDE.md` and seeded `.claude/memory/`. Use when the owner asks to adopt, bring in, or merge these templates into a project that already exists.
---

# adopt-template

> **Embeddable skill template.** Copy this directory into the target project's `.claude/skills/adopt-template/`, with the template set (charters, requirements, `guides/GUIDE_ADOPTION.md`) available in the working set. The agent then runs it when the owner asks to adopt the templates. This note is harmless to leave in place.

This skill drives the **Adoption Guide** (`GUIDE_ADOPTION.md`) — the non-destructive merge that brings the templates' practices into a project that **already exists and already works**, which may or may not already use Claude, **without losing the instructions it already has**. The running system is not touched to satisfy a template; only its instruction and practice layer is reconciled and extended. The guide is the authority; this skill is how you execute it, step by step, with the owner deciding.

## When to run

When the owner asks to adopt / bring in / merge / "set up these templates in" a project that already exists. Adoption is a one-time reconciliation of the instruction layer, not ongoing work — run it once per project, then remove the skill or leave it inert.

## What to do

Follow the guide's non-destructive merge. Read `GUIDE_ADOPTION.md` first if it is in the working set — these steps mirror it.

1. **Inventory first, before touching anything.** Read every existing instruction source: `CLAUDE.md`, `AGENTS.md`, `.cursorrules`, `CONTRIBUTING`, and any ad-hoc convention docs. Catalog the current rules. **If the inventory finds nothing** — the project does not use Claude yet — there is no merge to do: jump to *No existing instructions* below.

2. **Pick the charter that fits, then classify every section against the project.** Choose `CHARTER_GREENFIELD.md` for continued new-feature work, or `CHARTER_LEGACY_TRANSFORMATION.md` if the project is itself replacing a legacy system. For **each section of that charter and each requirement**, record exactly one disposition:
   - **keep as-is** — the project has no equivalent; adopt the template's version verbatim;
   - **adapt** — the project already does this informally; rephrase the existing rule into the template's framing, keeping the project's specifics;
   - **already covered** — the project's instruction is equivalent or better; leave it, note the overlap;
   - **skip** — not applicable; record *why*, so the decision stays legible.

   The template is a menu, not a mandate. A **skip** is recorded, not deleted from consideration — it can move onto the roadmap later.

3. **Conflicts: always ask.** When an existing instruction conflicts with a template practice, **stop and put it to the owner with a recommendation** — batched with the other open questions, in the Q&A round the charter defines under *Working through questions*. Neither side wins automatically: nothing is silently overwritten, nothing is silently kept.

4. **Separate the two layers — and never cross them during the merge.**
   - **Instruction-layer adoption** (merging `CLAUDE.md`, memory conventions, roadmap / decision-log structure) is safe and immediate: it changes how the agent works, not how the software runs. Do it now.
   - **Practice adoption that would change code or infrastructure** (the portable-appliance requirement, a testing methodology, a stack migration) **does not happen during the merge.** It becomes incremental, owner-approved work seeded onto the roadmap. The running system is not edited to satisfy a template.

5. **Produce the output.**
   - A **merged `CLAUDE.md`** that layers the adopted template practices over the preserved project instructions.
   - A seeded **`.claude/memory/`**: a `roadmap.md` splitting *adopted now* from *deferred* practices, a `decisions.md`, and a `MEMORY.md` index.
   - A **decision-log entry** recording, per section, what was kept / adapted / skipped and why. The adoption itself is traceable.

6. **Prove by functioning.** After the instruction merge, confirm the project still builds and its tests still pass **exactly as before** — adoption is proven by the project continuing to work, not by the merge looking clean.

## No existing instructions

If step 1 finds no instruction files, there is nothing to preserve and no conflicts to resolve. Adoption reduces to: choose a charter, fill its Project Parameters (confirming each value with the owner, per the charter's *Setup* step), seed `.claude/memory/` (roadmap + decisions + index), and put any code/infra practice onto the roadmap rather than applying it immediately. The two-layer rule (step 4) and *prove by functioning* (step 6) still hold.

## Definition of done

- Every charter section and requirement has a recorded disposition (keep / adapt / already-covered / skip-with-reason).
- No existing instruction was changed without the owner deciding the conflict.
- `CLAUDE.md` and `.claude/memory/` reflect the merged result; the decision log explains it.
- The project builds and passes its tests exactly as it did before the merge.
- Code / infra practice adoption lives on the roadmap, not in surprise edits to the running system.

## Rules

- **Non-destructive, always.** Never overwrite an existing instruction silently and never force a template section that does not fit. The existing project is the source of truth about what works; the templates offer better-articulated practices to complement it.
- **Conflicts go to the owner.** Every conflict is raised with a recommendation and resolved by the owner — this is the same Q&A-driven alignment the charters prescribe.
- **Don't touch the running system.** Code and infrastructure changes are roadmap items for later approval, never part of the merge.
- **Answers become artifacts.** Every disposition and every resolved conflict lands in the decision log or seeded memory — traceable to this adoption.
- **English artifacts.** The merged `CLAUDE.md`, decision entries, roadmap, and memory index follow the project's language protocol (English by default); only an owner-facing scratchpad may be in another language.
- **No commits without authorization.** Prepare the merged files and stop; committing needs the owner's explicit per-instance go-ahead.
