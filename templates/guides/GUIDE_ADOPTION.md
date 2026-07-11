# Adoption Guide — Bringing the Templates into an Existing Project

A reusable, self-contained procedure for adopting these templates' practices into a **project that already exists and already works** — which may or may not already use Claude — **without losing the instructions it already has**. The project keeps running; only its instruction and practice layer is reconciled and extended.

This is not the legacy charter. [CHARTER_LEGACY_TRANSFORMATION.md](../charters/CHARTER_LEGACY_TRANSFORMATION.md) extracts a legacy *business system's* knowledge to build a new application, retiring the old one. Here the software project is the thing being kept — adoption is a **non-destructive merge** of the instruction layer, not a rewrite.

To use: run this procedure inside the target repo with the template set available (`make adopt DEST=<repo>` from a clone of the template repository delivers the set and the `adopt-template` skill in one step). The agent presents proposals; the owner decides. Nothing here overrides the standing rule that the agent **never commits without explicit authorization**.

---

## Principle

The existing project is the source of truth about what works. The templates offer better-articulated practices. Adoption **complements and adapts** what exists — it never overwrites it silently, and it never forces a template section that does not fit.

## The non-destructive merge

1. **Inventory first.** Read the existing `CLAUDE.md` (or `AGENTS.md`, `CONTRIBUTING`, `.cursorrules`, ad-hoc convention docs) and catalog the current rules *before touching anything*. If the inventory finds nothing — the project does not use Claude yet — there is no merge to do: skip to [No existing instructions](#no-existing-instructions).

2. **Classify each template section against the project.** For every section of the chosen charter (plus any add-on module and each requirement being considered), decide and record one of:
   - **keep as-is** — adopt the template's version verbatim (the project has no equivalent);
   - **adapt** — the project already does this informally; rephrase the existing rule into the template's framing, keeping the project's specifics;
   - **already covered** — the project's existing instruction is equivalent or better; leave it, note the overlap;
   - **skip** — not applicable to this project; record *why*, so the decision is legible later.

   The template is a menu, not a mandate.

3. **Conflicts: always ask.** When an existing instruction conflicts with a template practice, **stop and put it to the owner with a recommendation** — batched with the other open questions, in the Q&A round the charters define in their Method section. Neither side wins automatically — nothing is silently overwritten, and nothing is silently kept.

4. **Separate two layers.**
   - **Instruction-layer adoption** — merging `CLAUDE.md`, memory conventions, roadmap/decision-log structure — is safe and immediate: it changes how the agent works, not how the software runs.
   - **Practice adoption that changes code or infrastructure** — e.g. the portable-appliance requirement ([REQUIREMENT_PORTABLE_APPLIANCE.md](../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md)), the testing methodology, a stack migration — **does not happen during the merge**. It becomes incremental, owner-approved work on the roadmap. The running system is not touched to satisfy a template.

5. **Produce the output.**
   - A **merged `CLAUDE.md`** that layers the adopted template practices over the preserved project instructions.
   - A seeded **`.claude/memory/`**: a `roadmap.md` splitting *adopted now* from *deferred* practices, a `decisions.md`, and a `MEMORY.md` index.
   - A **decision-log entry** recording, per section, what was kept / adapted / skipped and why. The adoption itself is traceable.
   - **A single versioned home for every kept deliverable.** A requirement (or other standalone reference doc) classified *keep* is copied into the project under `.claude/` by default (e.g. `.claude/requirements/`), referenced by the merged `CLAUDE.md` — and, when it describes a code/infra practice, by the roadmap item that will apply it later (step 4). The owner may choose another path to match the project's conventions; what matters is **one owner, versioned**. The charter and any adopted modules are folded into `CLAUDE.md`, not kept as separate files.

6. **Tear down the delivery kit.** Once every kept deliverable has its versioned home, the delivered template set has done its job. Remove the install folder (`agent/` by default — wherever `make adopt`'s `PREFIX` placed it) and remove the one-shot `adopt-template` skill (or leave it inert). This keeps the migrated copy the *single* owner: a lingering kit is a second copy of everything, and two copies invite the drift the adoption just resolved.

7. **Prove by functioning.** After the instruction merge, the project still builds and its tests still pass. Adoption is proven by the project continuing to work — not by the merge looking clean.

## Choosing what to adopt

- Pick the charter that matches the project's situation: [CHARTER_GREENFIELD.md](../charters/CHARTER_GREENFIELD.md) for continued new-feature work, [CHARTER_LEGACY_TRANSFORMATION.md](../charters/CHARTER_LEGACY_TRANSFORMATION.md) if the project is itself replacing a legacy system.
- The shipped charters are **minimal**; add-on modules (`MODULE_PRODUCT_AUDIENCE`, `MODULE_LIVING_DOCS`, `MODULE_DATA_MIGRATION` — see the sources' `charters.manifest.md`) are adopted à la carte, only when the project is that kind of project. A module that ships a paired skill — `MODULE_LIVING_DOCS` ↔ `update-living-docs` — brings that skill with it: install it into `.claude/skills/` when you adopt the module.
- Adopt requirements à la carte too. A requirement classified **skip** is recorded, not deleted from consideration — it can move onto the roadmap later.

## No existing instructions

If the inventory in step 1 finds no instruction files, there is nothing to preserve and no conflicts to resolve. Adoption reduces to: choose a charter, fill its Project Parameters (confirming each value with the owner, per the charter's Setup step), seed `.claude/memory/` (roadmap + decisions + index), and — for any code/infra practice — put it on the roadmap rather than applying it immediately. The two-layer rule (step 4), the kit teardown (step 6), and *prove by functioning* (step 7) still hold — even here the delivered kit is removed once the seeding is done.

## Definition of done

- Every charter section, chosen module, and requirement has a recorded disposition (keep / adapt / already-covered / skip-with-reason).
- No existing instruction was changed without the owner deciding the conflict.
- `CLAUDE.md` and `.claude/memory/` reflect the merged result; the decision log explains it.
- Each kept deliverable has a single versioned home (under `.claude/` by default); the delivery kit (`agent/`) and the one-shot `adopt-template` skill are removed, leaving no duplicate copies.
- The project builds and passes its tests exactly as it did before the merge.
- Code/infra practice adoption lives on the roadmap, not in surprise edits to the running system.
