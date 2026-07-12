---
name: adopt-template
description: Adopt these templates into an existing project without losing its current instructions — inventory the project's `CLAUDE.md` (and any convention docs), classify each charter section and requirement as keep/adapt/already-covered/skip, raise every conflict to the owner, then produce a merged `CLAUDE.md` and seeded `.claude/memory/`. Also handles an upgrade: a project already running an earlier version of these templates reconciles only the version diff. Use when the owner asks to adopt, bring in, merge, or upgrade these templates in a project that already exists.
---

# adopt-template

> **Embeddable skill template.** Copy this directory into the target project's `.claude/skills/adopt-template/`, with the template set (charters, requirements, `guides/GUIDE_ADOPTION.md`) available in the working set. The agent then runs it when the owner asks to adopt the templates. This note is harmless to leave in place.

This skill drives the **Adoption Guide** (`GUIDE_ADOPTION.md`) — the non-destructive merge that brings the templates' practices into a project that **already exists and already works**, which may or may not already use Claude, **without losing the instructions it already has**. The running system is not touched to satisfy a template; only its instruction and practice layer is reconciled and extended. The guide is the authority; this skill is how you execute it, step by step, with the owner deciding.

## When to run

When the owner asks to adopt / bring in / merge / "set up these templates in" / **upgrade the templates in** a project that already exists. Adoption is a one-time reconciliation of the instruction layer, not ongoing work — run it once per project, then tear down the delivered kit and remove this skill (or leave it inert) — the final step below. A project already running an older version of these templates runs the **upgrade** branch instead (step 1a), and the same teardown applies afterwards.

## What to do

Follow the guide's non-destructive merge. Read `GUIDE_ADOPTION.md` first if it is in the working set — these steps mirror it.

1. **Inventory first, before touching anything.** Read every existing instruction source: `CLAUDE.md`, `AGENTS.md`, `.cursorrules`, `CONTRIBUTING`, and any ad-hoc convention docs. Catalog the current rules. The inventory decides which of three branches you are in:
   - **Nothing found** — the project does not use Claude yet: jump to *No existing instructions* below.
   - **`.claude/memory/template-version.md` found**, or a `CLAUDE.md` that is unmistakably a filled-in instance of one of these charters — the project already runs an **earlier version of these templates**: jump to *Upgrade* below. Do **not** run the merge; it would make you argue with your own charter and re-ask the owner questions he already answered.
   - **The project's own instructions** — run the merge, from step 2.

2. **Pick the charter that fits, then classify every section against the project.** Choose `CHARTER_GREENFIELD.md` for continued new-feature work, or `CHARTER_LEGACY_TRANSFORMATION.md` if the project is itself replacing a legacy system. The shipped charters are minimal — offer the add-on modules (`MODULE_PRODUCT_AUDIENCE`, `MODULE_LIVING_DOCS`) only where the project is that kind of project; the kit carries the charter **sources**, so each module's text is on hand to fold into `CLAUDE.md`. A module that ships a paired skill — `MODULE_LIVING_DOCS` ↔ `update-living-docs` — brings that skill with it: install it into `.claude/skills/` from the kit when you adopt the module. For **each section of that charter, each chosen module, and each requirement**, record exactly one disposition:
   - **keep as-is** — the project has no equivalent; adopt the template's version verbatim;
   - **adapt** — the project already does this informally; rephrase the existing rule into the template's framing, keeping the project's specifics;
   - **already covered** — the project's instruction is equivalent or better; leave it, note the overlap;
   - **skip** — not applicable; record *why*, so the decision stays legible.

   The template is a menu, not a mandate. A **skip** is recorded, not deleted from consideration — it can move onto the roadmap later.

   **Tag each disposition** *architectural* (a genuine choice about this project — *this does not fit us, and here is why*) or **conflict-avoided** (it exists only to stop the template from colliding with what was already there). A future upgrade acts on the tag: architectural dispositions stand, conflict-avoided ones re-open once the collision is gone. Untagged, a workaround reads as law on the next adoption.

3. **Conflicts: always ask.** When an existing instruction conflicts with a template practice, **stop and put it to the owner with a recommendation** — batched with the other open questions, in the Q&A round the charter defines in its Method section. Neither side wins automatically: nothing is silently overwritten, nothing is silently kept.

4. **Separate the two layers — and never cross them during the merge.**
   - **Instruction-layer adoption** (merging `CLAUDE.md`, memory conventions, roadmap / decision-log structure) is safe and immediate: it changes how the agent works, not how the software runs. Do it now.
   - **Practice adoption that would change code or infrastructure** (the portable-appliance requirement, a testing methodology, a stack migration) **does not happen during the merge.** It becomes incremental, owner-approved work seeded onto the roadmap. The running system is not edited to satisfy a template.

5. **Produce the output.**
   - A **merged `CLAUDE.md`** that layers the adopted template practices over the preserved project instructions.
   - A seeded **`.claude/memory/`**: a `roadmap.md` splitting *adopted now* from *deferred* practices, a `decisions.md`, and a `MEMORY.md` index.
   - A **decision-log entry** recording, per section, what was kept / adapted / skipped and why, each tagged *architectural* or *conflict-avoided*. The adoption itself is traceable.
   - A **template-version stamp** at `.claude/memory/template-version.md`: the template set's source commit (the kit carries it in `TEMPLATE_VERSION.md`), the charter adopted, the modules adopted, and a pointer to the dispositions in the decision log. The kit goes away at teardown; this file is what a future re-adoption reads to run an upgrade instead of a from-scratch merge.
   - **A single versioned home for every kept deliverable.** A requirement (or other standalone reference doc) classified *keep* is copied into the project under `.claude/` by default (e.g. `.claude/requirements/`), referenced by the merged `CLAUDE.md` — and, for a code/infra practice, by the roadmap item that will apply it later (step 4). The owner may repath to match the project's conventions; what matters is **one owner, versioned**. The charter and any adopted modules fold into `CLAUDE.md`, not separate files.

6. **Tear down the delivery kit.** Once every kept deliverable has its versioned home, remove the delivered template set (the install folder — `agent/` by default, wherever `PREFIX` placed it) and remove this one-shot skill (or leave it inert). A lingering kit is a second copy of everything the merge just took a single owner for — two copies invite the drift adoption exists to prevent. Only `adopt-template` and the kit are one-shot: the permanent skills the installer delivered — `graduate-idea`, plus `update-living-docs` if the living-docs module was adopted — stay in `.claude/skills/`.

7. **Prove by functioning.** After the instruction merge, confirm the project still builds and its tests still pass **exactly as before** — adoption is proven by the project continuing to work, not by the merge looking clean.

## No existing instructions

If step 1 finds no instruction files, there is nothing to preserve and no conflicts to resolve. Adoption reduces to: choose a charter, fill its Project Parameters (confirming each value with the owner, per the charter's Setup step), seed `.claude/memory/` (roadmap + decisions + index + the template-version stamp), and put any code/infra practice onto the roadmap rather than applying it immediately. The two-layer rule (step 4), the kit teardown (step 6), and *prove by functioning* (step 7) still hold.

## Upgrade — the project already runs an earlier version of these templates

Its `CLAUDE.md` *is* the filled-in charter a previous adoption produced. Reconcile **only the delta** between the version it came from and the version in the kit — never the whole charter, and never the project's own sections.

0. **`make upgrade DEST=<project>`**, from a clone of the template repository, does steps 1–2 for you and **installs nothing** (an upgrade needs a diff, not a copy — no kit to deliver, none to tear down). Without the clone, the kit `make adopt` delivers carries its own commit in `TEMPLATE_VERSION.md`, which is the other end of the diff.
1. **Read the stamp.** `.claude/memory/template-version.md` gives the source commit, the charter, and the modules the project adopted.

   **No stamp but plainly an older instance?** Do not investigate — date it. The project's own git history has its `Adopt…` commit, and the source is the template commit that was `HEAD` **at that instant** (`git -C <project> log -1 --format=%cI --grep='[Aa]dopt'`, then `git -C <templates> rev-list -1 --before=<that timestamp> HEAD`). Use the *instant*, not the day: a template repo can ship several commits in one day, and a date bound would resolve to the last of them — text the project never saw. Show the owner the diff summary and confirm the charter and modules before writing the stamp; a wrong bound yields a visibly wrong diff. If the timestamp resolves to nothing, search by content: `git log -S "<a characteristic phrase from a charter section>" -- templates/`.
2. **Diff the versions.** `git diff <stamped-commit>..HEAD -- templates/` in the template clone is the whole scope of the upgrade. Unchanged text the project already carries is not re-litigated.
3. **Classify the delta** — each changed charter section, each newly available module, each new or revised requirement — with the same four dispositions and the same *architectural* / *conflict-avoided* tag as step 2 of the merge. Conflicts go to the owner in one batched Q&A round.
4. **Re-open the provisional dispositions** from the earlier adoption's decision log: **architectural** ones stand (do not reopen unless the owner does); **conflict-avoided** ones are provisional — put each back to the owner, since the collision it dodged may be gone in the new version; **untagged** ones predate the tag — treat them as conflict-avoided and re-confirm. A requirement dropped merely to dodge a clash must not fossilize as law.
5. **Finish like any adoption.** Two-layer rule (code/infra practice → roadmap, never edited here), kit teardown, prove by functioning. Rewrite `.claude/memory/template-version.md` to the kit's commit and record the upgrade in the decision log.

## Definition of done

- Every charter section, chosen module, and requirement has a recorded disposition (keep / adapt / already-covered / skip-with-reason), each tagged *architectural* or *conflict-avoided*.
- No existing instruction was changed without the owner deciding the conflict.
- `CLAUDE.md` and `.claude/memory/` reflect the merged result; the decision log explains it; `.claude/memory/template-version.md` records the version adopted.
- On an upgrade: only the version delta was reconciled, and every conflict-avoided (or untagged) disposition from the previous adoption was re-confirmed with the owner.
- Each kept deliverable has a single versioned home (under `.claude/` by default); the delivery kit and the one-shot `adopt-template` skill are removed, leaving no duplicate copies.
- The project builds and passes its tests exactly as it did before the merge.
- Code / infra practice adoption lives on the roadmap, not in surprise edits to the running system.

## Rules

- **Non-destructive, always.** Never overwrite an existing instruction silently and never force a template section that does not fit. The existing project is the source of truth about what works; the templates offer better-articulated practices to complement it.
- **Upgrade reconciles the delta, never the charter.** When the project already runs an earlier version, re-classifying text it already carries is not thoroughness — it is asking the owner to re-decide what he already decided.
- **Conflicts go to the owner.** Every conflict is raised with a recommendation and resolved by the owner — this is the same Q&A-driven alignment the charters prescribe.
- **Don't touch the running system.** Code and infrastructure changes are roadmap items for later approval, never part of the merge.
- **Answers become artifacts.** Every disposition and every resolved conflict lands in the decision log or seeded memory — traceable to this adoption.
- **English artifacts.** The merged `CLAUDE.md`, decision entries, roadmap, and memory index follow the project's language protocol (English by default); only an owner-facing scratchpad may be in another language.
- **No commits without authorization.** Prepare the merged files and stop; committing needs the owner's explicit per-instance go-ahead.
