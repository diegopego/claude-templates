# Changelog — maintainer

Technical changelog for whoever maintains this repository. Each entry ends with a plain-language addendum and, when needed, a jargon glossary. Newest first.

## 2026-07-10 — Setup (step 0) phase added to the charters (language-setup incorporated)

- Incorporated `ideas/language-setup.md` (now `Status: incorporated`), broadened by owner decision from languages-only to a **Setup phase (step 0)** in `CHARTER_CORE.md`, before Discover/Understand. The agent walks the whole Project Parameters block with the oracle and confirms every value; blank rows are asked, defaults (Product scope → product-for-an-audience, artifact language → English) are stated for correction.
- Reassembled both composed charters and retranslated their pt-BR counterparts. Phase numbering: Setup is 0, so "phase 3" and "phases 2–4" references elsewhere remain correct.

**In plain language:** every project built from a charter now begins with an explicit setup step where the agent confirms the project's settings (which languages, whether it's a product or a bespoke tool, who the users are, …) with the owner instead of quietly guessing. It closes the gap where a left-blank setting used to be filled by assumption.

## 2026-07-10 — GUIDE_ADOPTION.md authored (adopt-into-existing-project agreed)

- Took `ideas/adopt-into-existing-project.md` to `Status: agreed` after a Q&A round, then authored the deliverable `templates/guides/GUIDE_ADOPTION.md` (first `GUIDE_` type; new `templates/guides/` directory).
- Resolved decisions (in `decisions.md`): conflict rule is **always ask** — no default winner between an existing instruction and a template practice; the guide also covers projects with **no existing instructions** (charter selection + memory seeding, no merge); code/infra practices (portable-appliance, etc.) **defer to the roadmap**, never applied during the merge.
- Guide structure: non-destructive merge (inventory → classify keep/adapt/already-covered/skip → always-ask conflicts → two layers → traceable output → prove by functioning), a no-instructions branch, and a definition of done.
- Catalog (`templates/README.md`) gained a **Guides** section; pt-BR translation of the guide and README added; roadmap Milestone 3 item checked off.

**In plain language:** we wrote the how-to for bringing these practices into a project that already exists and works. Its core promise: nothing already in the project is changed behind the owner's back — every clash is raised as a question, and anything that would alter the running software is scheduled, not done on the spot.

**Glossary:** *inventory* — reading and listing what instructions the project already has before changing anything; *disposition* — the recorded decision (keep / adapt / already-covered / skip) for each template section.

## 2026-07-10 — Charters modularized (core + slots) and product-not-bespoke incorporated

- Decomposed both charters into `templates/charters/sources/`: `CHARTER_CORE.md` (shared spine with `{{ vars }}` + `<!-- SLOT -->` markers), `MODULE_DISCOVERY_GREENFIELD.md`, `MODULE_EXTRACTION_LEGACY.md`, and the pluggable `MODULE_DATA_MIGRATION.md`, wired by `charters.manifest.md`.
- New `assemble-charters` skill generates the self-contained composed charters (`templates/charters/CHARTER_*.md`) — the files adopters copy — from those sources; it numbers sections at assembly, so a charter that omits a slotted section still numbers cleanly.
- Incorporated `ideas/product-not-bespoke.md` into the core in the same pass: a new **Product for an audience** section and a **Product scope** parameter row in both charters, plus a **Classify on extraction** bullet (domain | instance-config | workaround) in the legacy charter. Composed output verified **lossless by diff** vs. the previous monolithic charters (only these intended additions + section renumbering + a few wording normalizations that survive renumbering).
- pt-BR: composed charters retranslated; `translate-templates` scope now excludes `templates/charters/sources/` (build inputs are not adopter-facing, so not translated).
- Hook: added rule 1 — staging a charter source without restaging the composed charters blocks the commit (assembly is deterministic); charter sources are excluded from the pt-BR-counterpart rule. Verified all rules with an isolated temp-index test.
- `CLAUDE.md` updated: layout (sources vs. composed), commit ritual (assemble → translate → changelog), and "Editing the templates" (edit sources, never composed).

**In plain language:** the two charters used to repeat about 70% of the same text, kept in sync by hand. Now that shared text lives in one place (a "core"), and the parts that differ live in small plug-in pieces; a tool stitches them back into the two complete, copy-ready charters. In the same move we folded in the earlier decision that every project is a multi-tenant product. We proved by comparison that nothing in the delivered charters was lost — only the intended additions were made.

**Glossary:** *core + slots* — one shared document with labeled gaps that smaller modules fill in; *assemble* — mechanically combine the core and modules into the final document; *lossless* — the regenerated output contains everything the original did.

## 2026-07-10 — Inbox graduation: adopt-into-existing-project (draft)

- `ideas/inbox.md` entry graduated to `ideas/adopt-into-existing-project.md` (`Status: draft`) after a Q&A round selected the form. Concern: adopting the templates into an existing, working project without losing its instructions — a third axis, distinct from both charters (the project keeps running; only its instruction/practice layer is merged).
- Decided form: a new standalone deliverable, `templates/guides/GUIDE_ADOPTION.md`, under a new `GUIDE_` type prefix (recorded in `decisions.md`; naming convention in `CLAUDE.md` updated). Rejected a charter section and a skill-first approach.
- Roadmap: authoring task added to Milestone 3 (gated on resolving the spec's open questions); Milestone 4 notes the guide as the first `templates/skills/` automation candidate.
- Left at `draft`, not `agreed`: the conflict-resolution default (existing-instructions-win-and-surface) and three other open questions still gate the draft→agreed transition, per the graduation rule.

**In plain language:** the owner wants to bring these practices into projects that already exist and already work — without trampling the notes and rules those projects already rely on. We agreed this deserves its own how-to document (a new "adoption guide" kind of template) that merges the new practices in gently instead of overwriting. The document isn't written yet; we recorded the plan and the questions still to settle before writing it.

**Glossary:** *brownfield* — an existing project with history and constraints, as opposed to *greenfield* (a blank start); *non-destructive merge* — combining new material with existing content without deleting or overwriting what's already there.

## 2026-07-10 — First inbox graduation: product-not-bespoke (agreed)

- `ideas/inbox.md` entry graduated to `ideas/product-not-bespoke.md`, and straight to `Status: agreed` after a Q&A round with the owner: product-for-an-audience is the default scope (assumption declared in the scope proposal when unstated); **products are multi-tenant from v1** (owner's call, against the recommended single-tenant-configurable — recorded in `decisions.md`); legacy extraction classifies each rule as domain | instance-config | workaround *and* consolidates instance values into tenant #1's configuration profile.
- Roadmap Milestone 3 gained the incorporation task and the two remaining open questions (per-tenant backup/restore; tenant provisioning in v1).
- Hook exemption added earlier today: `ideas/inbox.md` no longer requires a changelog entry to commit (scratchpad jots aren't changes).

**In plain language:** the owner dropped a rough note in the idea inbox; it became a formal spec through a short round of questions and answers. The agreed rule: everything built from these templates is a product meant to serve many customer organizations from day one — the person asking for it is just the first customer, and whatever is specific to them becomes settings, not hardwired behavior.

**Glossary:** *tenant* — one customer organization inside a shared product; *multi-tenant* — a product built to serve many such organizations from one installation; *bespoke* — made-to-measure for a single client.

## 2026-07-10 — Meta-project structure, translation pipeline, dogfooded memory

- Moved deliverables into `templates/charters/` and `templates/requirements/` (`git mv`, history preserved); relative links between charters and the appliance requirement updated to `../requirements/`.
- Added `templates/README.md` as the deliverable catalog.
- Created `ideas/` with the behavior-spec format (`Status: draft | agreed | incorporated`, `Applies to`, Behavior/Why/Example/Open questions) and three specs: `language-setup`, `audience-aware-changelogs`, `translated-templates`.
- Implemented the pt-BR pipeline: `.claude/skills/translate-templates/SKILL.md` regenerates `templates/i18n/pt-BR/**` (mirrored paths, generated-file header, prose translated, code/identifiers kept in English); `.claude/hooks/check-freshness.sh` wired as a `PreToolUse` hook on `Bash` in `.claude/settings.json` blocks `git commit` when an English template is staged without its pt-BR counterpart, or when `templates/`/`ideas/` change without a staged `changelog/` update.
- Dogfooded the charters' memory practice: `.claude/memory/` with `roadmap.md` (4 milestones), `decisions.md` (5 entries), `MEMORY.md` index. No project facts outside the repo.
- Rewrote the root `CLAUDE.md`: layout, naming conventions, anti-contamination rules, memory rule, commit ritual.

**In plain language:** the repository got its definitive shape. The finished templates live in their own shelf (`templates/`), clearly separated from the workshop (ideas, notes, internal memory). Every template written in English now automatically gets a Portuguese twin, and a guard refuses to record changes when the twin — or this diary — was forgotten. The project also started following its own advice: its plans and decisions are written in files inside the repository, never in anyone's head.

**Glossary:** *hook* — a small program the agent's tooling runs automatically at a given moment (here: right before recording changes in git); *staged* — the set of files marked to be included in the next git commit; *dogfooding* — using on ourselves the practices we recommend to others.
