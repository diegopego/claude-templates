---
name: adopt-template
description: Install, adopt, or upgrade these templates in another project — from a session in THIS repository, with the target as an additional working directory. Inventories the target's existing instructions, branches into new / adopt / upgrade, classifies every charter section, module and requirement with the owner, then writes the merged CLAUDE.md and seeded .claude/memory/ into the target (never committing there). Use when the owner asks to adopt, bring in, merge, install, or upgrade these templates in another project.
---

# adopt-template

**One door.** Starting a project, adopting into an existing one, and upgrading one are the same skill, run **here — in the templates clone** — with the target project as an additional working directory. Nothing is delivered into the target to be torn down again: what lands there is exactly what it keeps.

This skill is **machinery of this repository**, not an embeddable deliverable. It is authored here, under `.claude/skills/`, alongside `assemble-charters` — it never travels into an adopter. The authority it executes is [`templates/guides/GUIDE_ADOPTION.md`](../../../templates/guides/GUIDE_ADOPTION.md); read it when a judgment call is not covered below.

## Before anything

**The target must be an additional working directory** for this session, or you cannot read or write it. If it is not, say so and ask the owner to add it (`/add-dir <path>`) rather than working around it.

Then, from this repo, run the deterministic layer's **read**:

```sh
sh tools/install.sh upgrade <target>     # a read; installs nothing
```

It prints the target's stamp (or dates an unstamped instance from its own adoption commit) and the template text that changed since. It is the cheapest possible inventory, and it is the first evidence about which branch you are in.

## 1. Inventory — before touching anything

Read every instruction source in the target: `CLAUDE.md`, `AGENTS.md`, `.cursorrules`, `CONTRIBUTING`, convention docs, and `.claude/memory/template-version.md`. Catalog what the project already says. The inventory decides the branch:

- **No instructions at all** → **new**. Compose a charter and seed the project.
- **`.claude/memory/template-version.md` exists** → **upgrade**. Reconcile only the version delta.
- **The project's own instructions** → **adopt** (the merge). But **check provenance first** (below) — a project can be an unstamped adopter and not know it.

### Provenance — check it, do not assume independence

A project whose `CLAUDE.md` looks self-written may still be an **old, unstamped adopter**: someone copied charter text into it by hand, long before stamping existed. Treat that as an upgrade, not a first adoption, or you will ask the owner to re-decide what he already decided.

Cheap checks, in order — one of them is usually decisive:

- `git -C <target> log --oneline --all | grep -i 'adopt\|charter'` and the project's own session notes / work logs. A line like *"charter absorbed into CLAUDE.md"* settles it.
- A requirement file that is **byte-identical** to one of ours (`diff <target>/… templates/requirements/…`) is a copy, not a coincidence.
- Charter phrasing surviving verbatim in its `CLAUDE.md`: `git log -S "<a characteristic phrase>" -- templates/`.

If it *is* an unstamped adopter, date it from the instant of its adoption commit (`tools/install.sh upgrade` does this automatically when there is no stamp) and **tell the owner what you found** — the branch is his call, and the honest record matters more than the shortest path. A charter rewritten between then and now can make the delta effectively the whole charter, in which case you classify every section anyway; what changes is what the stamp records.

## 2. Classify — every section, with the owner

Pick the charter that fits (`CHARTER_GREENFIELD` for continued new-feature work; `CHARTER_LEGACY_TRANSFORMATION` when the project is itself replacing a legacy system) and offer the add-on modules — `MODULE_PRODUCT_AUDIENCE`, `MODULE_LIVING_DOCS` — **only** where the project is that kind of project. The shipped charters are minimal by design.

For **each charter section, each offered module, and each requirement**, record exactly one disposition:

- **keep as-is** — the project has no equivalent; adopt the template's text;
- **adapt** — the project already does this informally; rephrase it into the template's framing, keeping the project's specifics;
- **already covered** — the project's instruction is equivalent or better; leave it, note the overlap;
- **skip** — not applicable; record *why*.

And **tag** each one:

- **architectural** — a genuine choice about this project (*this does not fit us, and here is why*). It stands on a future upgrade.
- **conflict-avoided** — it exists only to stop the template colliding with what was already there. It re-opens on a future upgrade, because the collision may be gone.

Untagged, a workaround reads as law the next time around.

**A template is a menu, not a mandate**, and the traffic runs both ways: when a project's own practice is better than the charter's, the disposition is *already covered* **and the charter is what needs fixing** — record that as an inbox note here (`ideas/inbox.md`). Three of the charter's rules arrived exactly that way.

## 3. Put it to the owner — in plan mode, before writing anything

Present the whole thing as **one batched Q&A round**: the branch you are in and why, the charter, the modules, the disposition table, and every conflict — each with **options and a recommendation**, so the owner decides from a position rather than a blank page. Conflicts are never resolved silently in either direction: nothing is overwritten, nothing is quietly kept.

**Two layers, and never cross them during the merge:**

- **Instruction-layer adoption** (the merged `CLAUDE.md`, memory conventions, roadmap/decision-log structure) is safe and immediate — it changes how the agent works, not how the software runs. Do it now.
- **Practice adoption that would change code or infrastructure** (the portable-appliance requirement, a testing methodology, a stack migration, a data-model consequence like multi-tenant membership) **does not happen here.** It becomes an owner-approved item on the target's roadmap. The running system is not edited to satisfy a template.

Write into the target only after the owner approves the plan.

## 4. Write — into the target's working tree

**Judgment (you write these):**

- the **merged `CLAUDE.md`** — the adopted practices layered over the project's preserved instructions, in *its* voice and with *its* specifics;
- the seeded **`.claude/memory/`** — `MEMORY.md` index, `handoff.md`, and `template-version.md` (below). Seed `roadmap.md` / `decisions.md` **only if the project has no home for direction and decisions already**. If it has better ones — a `specs/` tree, numbered ADRs — say so in the index and point into them. A second source of direction is the exact failure the memory rule exists to prevent;
- an entry in whatever **decision log the project actually uses**, recording the dispositions.

**File operations (the script does these), after approval:**

```sh
sh tools/install.sh adopt <target> "<modules>" "<kept requirements>"
# e.g. sh tools/install.sh adopt ~/devel/app "living-docs" "REQUIREMENT_PORTABLE_APPLIANCE.md"
```

It installs only what the project keeps: each kept requirement into `.claude/requirements/`, the permanent `graduate-idea` skill, `update-living-docs` when the living-docs module was adopted, and an empty `ideas/inbox.md`. It never overwrites.

For a **new** project: `sh tools/install.sh new <target> greenfield|legacy "<modules>"` composes the charter into `.claude/charter/`, seeds `CLAUDE.md`, memory, inbox and skills, then run the charter's Setup phase with the owner.

## 5. The stamp is a manifest, not a marker

`.claude/memory/template-version.md` carries the **source commit** and a **disposition table** — for each charter section, module and requirement: the disposition, its tag, and **where it landed** in the target (the `CLAUDE.md` heading, or the file under `.claude/`).

That is what a future upgrade reads. With it, an upgrade can recompose the charter *at the adopted commit*, diff it against the current one, and for each changed section already know whether this project took it, adapted it or refused it — and where to look. Keep **`- **Source commit**: claude-templates @ <sha>`** as the single machine-readable line (`tools/install.sh` parses exactly that); everything else — history, narrative — goes in prose below it.

**Nothing is written into the target's `CLAUDE.md` to mark text as ours.** Adopted text is deliberately *adapted* into the project's own terms and then evolves under the project's own charter; a marker claiming ownership of a line is a lie one edit later, and it pollutes the file the agent reads every session.

## 6. Finish

- **Prove by functioning.** Confirm the target still builds and its tests still pass exactly as before. Adoption is proven by the project continuing to work, not by the merge looking clean.
- **Never commit in the target.** Leave the changes in its working tree, list them, and say plainly that the project's own session — under its own charter — authorizes its own commit. This holds even when the owner is the same person.
- **Feed the loop back.** Friction, gaps, and any place the charter was wrong go into `ideas/inbox.md` **here**. That is how the templates improve.

## Definition of done

- Every charter section, offered module and requirement has a disposition (keep / adapt / already-covered / skip-with-reason), each tagged *architectural* or *conflict-avoided*.
- The branch (new / adopt / upgrade) was chosen from evidence, including a provenance check — not from the target's appearance.
- No existing instruction was changed without the owner deciding the conflict.
- The target's `CLAUDE.md`, its decision log, and `.claude/memory/template-version.md` (with the disposition manifest) reflect the result.
- On an upgrade: only the version delta was reconciled, and every *conflict-avoided* (or untagged) disposition from the previous adoption was re-confirmed with the owner.
- Code/infra practice adoption is on the target's roadmap, not in surprise edits to its running system.
- The target builds and passes its tests as it did before. Nothing was committed there.
