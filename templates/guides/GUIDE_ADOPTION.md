# Adoption Guide — Bringing the Templates into a Project

A reusable procedure for putting these templates to work in a project — one that already exists and already works (**without losing the instructions it already has**), or one that does not exist yet. The project keeps running; only its instruction and practice layer is reconciled and extended.

This is not the legacy charter. [CHARTER_LEGACY_TRANSFORMATION.md](../charters/CHARTER_LEGACY_TRANSFORMATION.md) extracts a legacy *business system's* knowledge to build a new application, retiring the old one. Here the software project is the thing being kept — adoption is a **non-destructive merge** of the instruction layer, not a rewrite.

---

## One door: adoption runs from the templates repository

**Clone the templates, open Claude Code *there*, and add the target project as an additional working directory** (`/add-dir <path>`). Then say what you want:

> *"adopt the templates into ~/devel/myapp"* · *"upgrade the templates in ~/devel/myapp"* · *"start a new project at ~/devel/myapp"*

The `adopt-template` skill — machinery of the templates repo, not something installed in your project — inventories the target, works out which of the three situations you are in, puts a plan to you, and writes into the target only once you approve it. It calls `tools/install.sh` for the file operations; all judgment stays in the conversation.

**There is no delivery kit.** Nothing is copied into the project to be torn down afterwards; what lands there is exactly what the project keeps. And nothing is ever committed in the target: that project's own session, under its own charter, authorizes its own commit.

*(If the clone is not on the machine, the templates are plain Markdown — copying the files by hand still works, because the installer only ever adds files. There is no supported second door, and no plan to build one until an adopter asks.)*

## Principle

The existing project is the source of truth about what works. The templates offer better-articulated practices. Adoption **complements and adapts** what exists — it never overwrites it silently, and it never forces a template section that does not fit.

And the traffic runs both ways. When a project's own practice is **better** than the charter's, the disposition is *already covered* — **and the charter is what needs fixing.** Several of the charter's rules arrived exactly that way, from adopters who had contradicted it in practice and been right.

## Three situations

The inventory decides which:

| What the inventory finds | Branch |
| --- | --- |
| No instruction files | [New project](#new-project) — compose and seed; nothing to preserve |
| Instructions the project wrote itself | [The non-destructive merge](#the-non-destructive-merge) |
| `.claude/memory/template-version.md` — an **earlier version of these templates** | [Upgrade](#upgrade--the-project-already-runs-an-earlier-version) — reconcile the version diff, not the whole charter |

### Check provenance — do not assume independence

A project whose `CLAUDE.md` looks entirely self-written **may still be an old, unstamped adopter**: someone copied charter text into it by hand, before stamping existed. Merging it as if it were foreign asks the owner to re-decide what he already decided. Three cheap checks, one of which is usually decisive:

- its git history and session notes — *"charter absorbed into CLAUDE.md"* settles it;
- a requirement file **byte-identical** to one of ours is a copy, not a coincidence;
- charter phrasing surviving verbatim in its `CLAUDE.md` (`git log -S "<characteristic phrase>" -- templates/`).

If it is one, date it from the **instant** of its adoption commit and treat it as an upgrade. Tell the owner what you found — the honest record matters more than the shortest path.

## The non-destructive merge

1. **Inventory first, before touching anything.** Read the existing `CLAUDE.md` (or `AGENTS.md`, `CONTRIBUTING`, `.cursorrules`, ad-hoc convention docs) and catalog the current rules. Check provenance (above).

2. **Classify each template section against the project.** For every section of the chosen charter, every add-on module offered, and every requirement, decide and record exactly one of:
   - **keep as-is** — adopt the template's version (the project has no equivalent);
   - **adapt** — the project already does this informally; rephrase it into the template's framing, keeping the project's specifics;
   - **already covered** — the project's existing instruction is equivalent or better; leave it, note the overlap;
   - **skip** — not applicable to this project; record *why*, so the decision stays legible.

   The template is a menu, not a mandate.

   **Tag every disposition** *architectural* or *conflict-avoided*. A disposition is **architectural** when it is a genuine choice about this project — *this practice does not fit us, and here is why*. It is **conflict-avoided** when it exists only to stop the incoming template from colliding with what was already there. The tag is what a future upgrade acts on: architectural dispositions stand; conflict-avoided ones re-open once the collision they dodged is gone. Without the tag, a workaround becomes indistinguishable from a decision — and the next adoption obeys it as law.

3. **Conflicts: always ask.** When an existing instruction conflicts with a template practice, **stop and put it to the owner with a recommendation** — batched with the other open questions, in the Q&A round the charters define in their Method section. Neither side wins automatically: nothing is silently overwritten, and nothing is silently kept.

4. **Separate two layers, and never cross them during the merge.**
   - **Instruction-layer adoption** — the merged `CLAUDE.md`, memory conventions, roadmap/decision-log structure — is safe and immediate: it changes how the agent works, not how the software runs.
   - **Practice adoption that changes code or infrastructure** — the portable-appliance requirement ([REQUIREMENT_PORTABLE_APPLIANCE.md](../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md)), a testing methodology, a stack migration, a data-model consequence such as multi-tenant membership — **does not happen during the merge**. It becomes incremental, owner-approved work on the project's roadmap. The running system is not touched to satisfy a template.

5. **Produce the output**, into the target's working tree, after the owner approves the plan:
   - A **merged `CLAUDE.md`** layering the adopted practices over the preserved project instructions, in the project's own voice.
   - A seeded **`.claude/memory/`**: a `MEMORY.md` index, `handoff.md`, and the stamp (step 6). Seed `roadmap.md` and `decisions.md` **only if the project has no home for direction and decisions already** — if it has better ones (a `specs/` tree, numbered ADRs), point the index at them. A second source of direction is exactly the failure the memory rule exists to prevent.
   - A **decision-log entry** — in whatever decision log the project actually uses — recording every disposition and its tag. The adoption itself is traceable.
   - **A single versioned home for every kept deliverable.** A requirement classified *keep* lands under `.claude/requirements/`, referenced by the merged `CLAUDE.md` — and, when it describes a code/infra practice, by the roadmap item that will apply it later. The charter and any adopted modules are folded **into `CLAUDE.md`**, not kept as separate files.

6. **Stamp it — a manifest, not a marker.** `.claude/memory/template-version.md` records the **source commit** and a **disposition table**: for each charter section, module and requirement — the disposition, its tag, and **where it landed** (the `CLAUDE.md` heading, or the file under `.claude/`). That is what a future upgrade reads: it can recompose the charter *at the adopted commit*, diff it against the current one, and for each changed section already know whether this project took it, adapted it, or refused it — and where to look.

   Keep `- **Source commit**: claude-templates @ <sha>` as the single machine-readable line; history and narrative go in prose below it.

   **Nothing is written into the project's `CLAUDE.md` to mark text as ours.** Adopted text is deliberately adapted into the project's own terms and then evolves under the project's own charter; a marker claiming ownership of a line is a lie one edit later, and it pollutes the file the agent reads every session.

7. **Prove by functioning.** The project still builds and its tests still pass, exactly as before. Adoption is proven by the project continuing to work — not by the merge looking clean.

8. **Feed the loop back.** Friction, gaps, and any place the charter turned out to be wrong become inbox notes **in the templates repo**. That is how the templates improve; an adoption that produces no notes probably was not examined.

## Choosing what to adopt

- Pick the charter that matches the project: [CHARTER_GREENFIELD.md](../charters/CHARTER_GREENFIELD.md) for continued new-feature work, [CHARTER_LEGACY_TRANSFORMATION.md](../charters/CHARTER_LEGACY_TRANSFORMATION.md) if the project is itself replacing a legacy system.
- The shipped charters are **minimal**; add-on modules (`MODULE_PRODUCT_AUDIENCE`, `MODULE_LIVING_DOCS` — see the sources' `charters.manifest.md`) are adopted à la carte, only when the project is that kind of project. A module that ships a paired skill — `MODULE_LIVING_DOCS` ↔ `update-living-docs` — brings that skill with it.
- Adopt requirements à la carte too. A requirement classified **skip** is recorded, not deleted from consideration — it can move onto the roadmap later.

## New project

Nothing to preserve, no conflicts to resolve. The charter is composed with the chosen modules into `.claude/charter/`, `CLAUDE.md` is wired to it, and `.claude/memory/`, `ideas/inbox.md` and the `graduate-idea` skill are seeded. Then run the charter's **Setup** phase with the owner: confirm every Project Parameter (state defaults, never assume silently), settle the stack, scaffold the minimum runnable project.

The two-layer rule still holds — a code/infra practice goes on the roadmap rather than being applied on day one.

## Upgrade — the project already runs an earlier version

Its `CLAUDE.md` **is** the filled-in charter the last adoption produced, and its `.claude/memory/` already follows the conventions. Treating this as a fresh merge makes the agent argue with its own charter and re-ask the owner questions he already answered. It is a **version reconciliation**, and it reconciles only the delta.

1. **Read the stamp.** `.claude/memory/template-version.md` gives the source commit, the charter, the modules, and the disposition manifest.

   **No stamp?** A project adopted before stamping existed still knows *when* it adopted — its own git history has the adoption commit. The source is the template commit that was `HEAD` **at that instant** (the instant, not the day: a template repo can ship several commits in one day, and a date-granular bound resolves to the last of them — text the project never saw). `tools/install.sh upgrade <project>` does this for you. Show the owner the resulting diff summary and confirm the charter and modules before writing the stamp — a wrong bound produces a visibly wrong diff. If the timestamp resolves to nothing, search by content: `git log -S "<a characteristic phrase from a charter section>" -- templates/`.

2. **Diff the two versions.** `git diff <stamped-commit>..HEAD -- templates/` is the entire scope of the upgrade. Template text the project already carries unchanged is **not** re-litigated, and the project's own sections are never questioned.

3. **Classify the delta, same vocabulary.** Each changed charter section, each newly available module, each new or revised requirement gets one disposition, tagged *architectural* or *conflict-avoided*, exactly as in the merge. Conflicts go to the owner in one batched Q&A round.

4. **Re-open the provisional dispositions** from the previous stamp's manifest:
   - **architectural** ones stand — do not reopen them unless the owner does;
   - **conflict-avoided** ones are **provisional** — put each back to the owner, because the collision it dodged may not exist in the new version;
   - **untagged** ones predate the tag: treat them as conflict-avoided and re-confirm.

5. **A section deleted upstream is not automatically deleted here.** When template text the project adopted disappears from a later version, that is a question, not an instruction: the project may have real rules living in it. If it keeps them, they become **its own** — say so in its `CLAUDE.md`, so the next upgrade does not read them as orphaned template text and propose dropping them.

6. **Finish like any adoption.** The two-layer rule holds; the project still builds and passes its tests; rewrite the stamp to the new commit with an updated manifest, and record the upgrade in the project's decision log. Nothing is committed in the target.

## Definition of done

- Every charter section, offered module, and requirement has a recorded disposition (keep / adapt / already-covered / skip-with-reason), each tagged *architectural* or *conflict-avoided*.
- The branch was chosen from evidence — including a provenance check — not from the project's appearance.
- No existing instruction was changed without the owner deciding the conflict.
- `CLAUDE.md`, the project's decision log, and `.claude/memory/template-version.md` (with the disposition manifest) reflect the result.
- On an upgrade: only the version delta was reconciled; every conflict-avoided (or untagged) disposition was re-confirmed; text deleted upstream was consciously kept or consciously dropped.
- Each kept deliverable has a single versioned home under `.claude/`.
- The project builds and passes its tests exactly as it did before. **Nothing was committed in it.**
- Code/infra practice adoption lives on the project's roadmap, not in surprise edits to the running system.
