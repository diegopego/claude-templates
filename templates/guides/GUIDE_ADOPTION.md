# Adoption Guide — Bringing the Templates into an Existing Project

A reusable, self-contained procedure for adopting these templates' practices into a **project that already exists and already works** — which may or may not already use Claude — **without losing the instructions it already has**. The project keeps running; only its instruction and practice layer is reconciled and extended.

This is not the legacy charter. [CHARTER_LEGACY_TRANSFORMATION.md](../charters/CHARTER_LEGACY_TRANSFORMATION.md) extracts a legacy *business system's* knowledge to build a new application, retiring the old one. Here the software project is the thing being kept — adoption is a **non-destructive merge** of the instruction layer, not a rewrite.

To use: run this procedure inside the target repo with the template set available (`make adopt DEST=<repo>` from a clone of the template repository delivers the set and the `adopt-template` skill in one step). The agent presents proposals; the owner decides. Nothing here overrides the standing rule that the agent **never commits without explicit authorization**.

---

## Principle

The existing project is the source of truth about what works. The templates offer better-articulated practices. Adoption **complements and adapts** what exists — it never overwrites it silently, and it never forces a template section that does not fit.

## Three situations, one door

The inventory (step 1) decides which of three the project is in:

| What the inventory finds | Branch |
| --- | --- |
| No instruction files | [No existing instructions](#no-existing-instructions) — seed, nothing to preserve |
| Instructions the project wrote itself | The non-destructive merge, below |
| `.claude/memory/template-version.md` — the project already runs an **earlier version of these templates** | [Upgrade](#upgrade--the-project-already-runs-an-earlier-version) — reconcile the version diff, not the whole charter |

## The non-destructive merge

1. **Inventory first.** Read the existing `CLAUDE.md` (or `AGENTS.md`, `CONTRIBUTING`, `.cursorrules`, ad-hoc convention docs) and catalog the current rules *before touching anything*. If the inventory finds nothing — the project does not use Claude yet — there is no merge to do: skip to [No existing instructions](#no-existing-instructions). If it finds a **template-version stamp** — or a `CLAUDE.md` that is unmistakably a filled-in instance of one of these charters — this is not a merge either: skip to [Upgrade](#upgrade--the-project-already-runs-an-earlier-version).

2. **Classify each template section against the project.** For every section of the chosen charter (plus any add-on module and each requirement being considered), decide and record one of:
   - **keep as-is** — adopt the template's version verbatim (the project has no equivalent);
   - **adapt** — the project already does this informally; rephrase the existing rule into the template's framing, keeping the project's specifics;
   - **already covered** — the project's existing instruction is equivalent or better; leave it, note the overlap;
   - **skip** — not applicable to this project; record *why*, so the decision is legible later.

   The template is a menu, not a mandate.

   **Tag every disposition** *architectural* or *conflict-avoided*. A disposition is **architectural** when it is a genuine choice about this project — *this practice does not fit us, and here is why*. It is **conflict-avoided** when it exists only to stop the incoming template from colliding with what was already there. The tag is what a future upgrade acts on: architectural dispositions stand, conflict-avoided ones re-open once the collision they dodged is gone (see the Upgrade branch). Without the tag, a workaround written into the decision log becomes indistinguishable from a decision — and the next adoption will obey it as law.

3. **Conflicts: always ask.** When an existing instruction conflicts with a template practice, **stop and put it to the owner with a recommendation** — batched with the other open questions, in the Q&A round the charters define in their Method section. Neither side wins automatically — nothing is silently overwritten, and nothing is silently kept.

4. **Separate two layers.**
   - **Instruction-layer adoption** — merging `CLAUDE.md`, memory conventions, roadmap/decision-log structure — is safe and immediate: it changes how the agent works, not how the software runs.
   - **Practice adoption that changes code or infrastructure** — e.g. the portable-appliance requirement ([REQUIREMENT_PORTABLE_APPLIANCE.md](../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md)), the testing methodology, a stack migration — **does not happen during the merge**. It becomes incremental, owner-approved work on the roadmap. The running system is not touched to satisfy a template.

5. **Produce the output.**
   - A **merged `CLAUDE.md`** that layers the adopted template practices over the preserved project instructions.
   - A seeded **`.claude/memory/`**: a `roadmap.md` splitting *adopted now* from *deferred* practices, a `decisions.md`, and a `MEMORY.md` index.
   - A **decision-log entry** recording, per section, what was kept / adapted / skipped and why, each tagged *architectural* or *conflict-avoided*. The adoption itself is traceable.
   - A **template-version stamp**, `.claude/memory/template-version.md`: the source commit of the template set (the delivered kit carries it — see its `TEMPLATE_VERSION.md`), the charter adopted, the modules adopted, and a pointer to the dispositions in the decision log. The kit is torn down in step 6; this file is what survives, and it is what a re-adoption reads.
   - **A single versioned home for every kept deliverable.** A requirement (or other standalone reference doc) classified *keep* is copied into the project under `.claude/` by default (e.g. `.claude/requirements/`), referenced by the merged `CLAUDE.md` — and, when it describes a code/infra practice, by the roadmap item that will apply it later (step 4). The owner may choose another path to match the project's conventions; what matters is **one owner, versioned**. The charter and any adopted modules are folded into `CLAUDE.md`, not kept as separate files.

6. **Tear down the delivery kit.** Once every kept deliverable has its versioned home, the delivered template set has done its job. Remove the install folder (`agent/` by default — wherever `make adopt`'s `PREFIX` placed it) and remove the one-shot `adopt-template` skill (or leave it inert). This keeps the migrated copy the *single* owner: a lingering kit is a second copy of everything, and two copies invite the drift the adoption just resolved. The permanent, charter-prescribed skills the installer delivered — `graduate-idea`, plus `update-living-docs` if the living-docs module was adopted — **stay** in `.claude/skills/`; only `adopt-template` and the kit are one-shot.

7. **Prove by functioning.** After the instruction merge, the project still builds and its tests still pass. Adoption is proven by the project continuing to work — not by the merge looking clean.

## Choosing what to adopt

- Pick the charter that matches the project's situation: [CHARTER_GREENFIELD.md](../charters/CHARTER_GREENFIELD.md) for continued new-feature work, [CHARTER_LEGACY_TRANSFORMATION.md](../charters/CHARTER_LEGACY_TRANSFORMATION.md) if the project is itself replacing a legacy system.
- The shipped charters are **minimal**; add-on modules (`MODULE_PRODUCT_AUDIENCE`, `MODULE_LIVING_DOCS`, `MODULE_DATA_MIGRATION` — see the sources' `charters.manifest.md`) are adopted à la carte, only when the project is that kind of project. The kit delivers the charter **sources** whole, so a module's text is on hand to fold into `CLAUDE.md`. A module that ships a paired skill — `MODULE_LIVING_DOCS` ↔ `update-living-docs` — brings that skill with it: install it into `.claude/skills/` when you adopt the module.
- Adopt requirements à la carte too. A requirement classified **skip** is recorded, not deleted from consideration — it can move onto the roadmap later.

## No existing instructions

If the inventory in step 1 finds no instruction files, there is nothing to preserve and no conflicts to resolve. Adoption reduces to: choose a charter, fill its Project Parameters (confirming each value with the owner, per the charter's Setup step), seed `.claude/memory/` (roadmap + decisions + index + the template-version stamp), and — for any code/infra practice — put it on the roadmap rather than applying it immediately. The two-layer rule (step 4), the kit teardown (step 6), and *prove by functioning* (step 7) still hold — even here the delivered kit is removed once the seeding is done.

## Upgrade — the project already runs an earlier version

A project that adopted these templates once will be re-adopted every time they improve. Its `CLAUDE.md` **is** the filled-in charter the last adoption produced, its `.claude/memory/` already follows the conventions, and the kit that just arrived carries a *newer* version of that same text. Treating this as a merge makes the agent argue with its own charter and re-ask the owner questions he already answered. It is a **version reconciliation**, and it reconciles only the delta.

1. **Read the stamp.** `.claude/memory/template-version.md` gives the source commit the project came from, its charter, and its adopted modules. If the project is plainly an instance of an older charter but carries no stamp (it was adopted before stamping existed), say so, confirm with the owner which charter and modules it came from, and write the stamp before continuing.

2. **Diff the two versions.** The delivered kit records its own commit in `TEMPLATE_VERSION.md`. What changed between them is the entire scope of the upgrade — from a clone of the template repository, literally `git diff <stamped-commit>..<kit-commit> -- templates/`. Template text the project already carries unchanged is **not** re-litigated, and the project's own sections — the ones it wrote itself — are never questioned.

3. **Classify the delta, same vocabulary.** Each changed charter section, each newly available module, each new or revised requirement gets one disposition — keep as-is / adapt / already covered / skip-with-reason — tagged *architectural* or *conflict-avoided*, exactly as in the merge. Conflicts still go to the owner in one batched Q&A round.

4. **Re-open the provisional dispositions.** From the earlier adoption's decision log:
   - **architectural** dispositions stand — do not reopen them unless the owner does;
   - **conflict-avoided** dispositions are **provisional** — put each back to the owner, because the collision it dodged may not exist in the new version;
   - **untagged** entries predate the tag: treat them as conflict-avoided and re-confirm.

5. **Finish like any adoption.** The two-layer rule holds (no code or infrastructure is touched to satisfy a template — it goes on the roadmap), the kit is torn down, the project still builds and passes its tests. Rewrite `.claude/memory/template-version.md` to the kit's commit, and record the upgrade in the decision log.

## Definition of done

- Every charter section, chosen module, and requirement has a recorded disposition (keep / adapt / already-covered / skip-with-reason), each tagged *architectural* or *conflict-avoided*.
- No existing instruction was changed without the owner deciding the conflict.
- `CLAUDE.md` and `.claude/memory/` reflect the merged result; the decision log explains it; `.claude/memory/template-version.md` records the version adopted.
- On an upgrade: only the version delta was reconciled, and every conflict-avoided (or untagged) disposition from the previous adoption was re-confirmed with the owner.
- Each kept deliverable has a single versioned home (under `.claude/` by default); the delivery kit (`agent/`) and the one-shot `adopt-template` skill are removed, leaving no duplicate copies.
- The project builds and passes its tests exactly as it did before the merge.
- Code/infra practice adoption lives on the roadmap, not in surprise edits to the running system.
