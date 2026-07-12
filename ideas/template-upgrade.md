# Template upgrade — re-adopting into a project that already runs an earlier version

Status: incorporated (2026-07-12 — `GUIDE_ADOPTION.md` *Upgrade* branch + disposition tags, `adopt-template` mirroring it, installer stamping and shipping the whole source set)
Applies to: `templates/guides/GUIDE_ADOPTION.md`, `templates/skills/adopt-template/SKILL.md`, and the installer (`tools/install.sh`, `Makefile`)

## Behavior

Adoption today knows two situations: a project with **no instructions** (seed it) and a project with **its own foreign instructions** (non-destructive merge). A third exists and is now the common one: the project **already adopted an earlier version of these templates**. Its `CLAUDE.md` *is* the filled-in instance of one of our charters, its `.claude/memory/` already follows the conventions, and the kit that just landed carries a *newer* version of the same text. That is not a merge against strange instructions — it is a **version reconciliation**, and treating it as a merge makes the agent argue with its own charter.

**1. The kit carries a provenance stamp; the merge folds it into project memory.**
`make adopt` records the template repo's **commit SHA** (plus its date) into the delivered kit. When the adoption merge finishes, it writes that provenance into the project as `.claude/memory/template-version.md` — source commit, the charter adopted, the modules adopted, and a pointer to the dispositions recorded in `decisions.md`. The kit is torn down; the stamp stays. It is what a later re-adoption reads.

**2. `adopt-template` gains a third branch: upgrade.**
Inventory (step 1 of the guide) now has three outcomes, not two:

| What the inventory finds | Branch |
| --- | --- |
| No instruction files | *No existing instructions* — seed |
| Instructions the project wrote itself | Non-destructive merge |
| A `template-version.md` stamp (or an unmistakable instance of one of our charters) | **Upgrade** |

The upgrade branch reconciles the **diff between the stamped version and the kit's version** — literally `git -C <templates> diff <stamp>..HEAD -- templates/` — instead of classifying the whole charter from scratch. Only what changed between the two versions reaches the owner; text the project already carries unchanged is not re-litigated. Everything else about adoption still holds: the same disposition vocabulary (keep / adapt / already-covered / skip-with-reason), the same batched Q&A round for every conflict, the same two-layer rule (no code or infrastructure touched during the reconciliation), the same *prove by functioning*. On completion the stamp is rewritten to the new commit.

If the project is plainly an instance of an older charter but carries no stamp — every project adopted before this spec — the agent says so, offers the upgrade branch, and asks the owner to confirm which charter and modules the instance came from, then stamps it.

**3. Dispositions are tagged, and conflict-avoided ones re-open on upgrade.**
Every disposition an adoption records in `decisions.md` is tagged either **architectural** (a genuine choice about this project: *this practice does not fit us, and here is why*) or **conflict-avoided** (a removal or compromise made only to stop the incoming template from colliding with what was already there). On upgrade:

- **architectural** dispositions stand — the agent does not reopen them unless the owner does;
- **conflict-avoided** dispositions are **provisional** — they return to the table, because the thing they dodged may not exist in the new version;
- **untagged** entries from an adoption that predates this spec are treated as conflict-avoided, i.e. re-confirmed.

**4. The kit ships the whole source set.**
For the upgrade diff to mean anything — and for the "adopt a module à la carte" the guide already promises to be real — `make adopt` delivers `templates/charters/sources/` **whole** (every `MODULE_*.md` plus `charters.manifest.md`) and **every paired skill**, not just `MODULE_LIVING_DOCS` and `update-living-docs`. Today's kit cannot fold in `MODULE_PRODUCT_AUDIENCE` or `MODULE_DATA_MIGRATION` because their source text never arrives.

## Why

The whole point of Milestone 6 is that a project adopts these templates *and keeps using them* — which means it will be re-adopted every time the templates improve. Without a version stamp the second adoption is blind: it cannot tell its own earlier output from the project's own instructions, so it redoes a merge it already did and asks the owner questions he already answered.

And without the architectural / conflict-avoided tag, the decision log fossilizes workarounds into law. That is not hypothetical: in orderboard, `REQUIREMENT_PORTABLE_APPLIANCE` was removed in commit c55680b purely to avoid a clash with an older adoption attempt, the removal was written into `decisions.md` like any other decision, and on the next adoption the skill dutifully read it as *skip — do not reintroduce*. The owner had to overrule it by hand. A decision log that cannot distinguish *we chose this* from *we ducked this* will keep producing that failure.

## Example

An owner re-runs `make adopt DEST=~/devel/orderboard` a month after the first adoption:

```
Inventory: .claude/memory/template-version.md found
  adopted from claude-templates @ 29468ef (2026-07-11)
  charter: legacy-transformation   modules: living-docs
  kit is @ a1b2c3d (2026-08-10) — 14 commits of template change

Upgrade reconciliation — 3 things changed in your charter's text since 29468ef:
  1. "Ideas & specs" gained the graduation-Q&A clause      → recommend: keep as-is
  2. "Changelogs" now names Primary users as the reader     → recommend: adapt
                                                              (your CLAUDE.md says "the team")
  3. New opt-in MODULE_DATA_MIGRATION is available          → recommend: skip
                                                              (you are not migrating data)

Re-opening 1 provisional disposition from the 2026-07-11 adoption:
  REQUIREMENT_PORTABLE_APPLIANCE — skipped [conflict-avoided, not architectural]
  The conflict it dodged is gone. Adopt it now, or skip again with a reason?
```

Nothing in `orderboard`'s own instructions — the sections the project wrote itself — is questioned. Only the delta.

## Open questions

- None. (An earlier framing asked whether the module-source delivery should graduate separately; the owner folded it in — see `.claude/memory/decisions.md`, 2026-07-12.)
