# Changelog — maintainer

Technical changelog for whoever maintains this repository. Each entry ends with a plain-language addendum and, when needed, a jargon glossary. Newest first.

## 2026-07-11 — Incorporated landing-publishing + rewired the living-doc skill (last 2 of 6 cluster specs)

- Final incorporation from the Setup→changelog→landing cluster, taking the two remaining specs together — they complete the same landing/living-doc pipeline. **The six-spec cluster is now fully in template text.**
  - **landing-publishing** (from `ideas/landing-publishing.md`) → a **focused Setup addition** to `CHARTER_CORE`, per an owner Q&A: a new *Setup scaffolding* bullet, **Landing skin, designed once**, plus a mention in the Method §0 *Setup* bullet. It introduces the project's public **landing page** (the rendered view of its living product documentation, written for the *Primary users*) and its **design interview** (theme/reference-site/palette/audience/stack, scripted-then-adaptive, Claude Design default + hand-authored fallback), the skin fixed once vs. content regenerated forever, with the content pipeline + approval loop pointing to `REQUIREMENT_PROJECT_CLI.md`. Deliberately **not** a whole new living-doc/landing section — that stays deferred (roadmap).
  - **living-product-doc rewiring** (from `ideas/living-product-doc.md`) → **meta-project tooling only** (no template change). Rewired `.claude/skills/update-product-doc/` to work by **delta from a versioned last-processed-commit marker** (`.claude/memory/last-processed-commit.md`, seeded at the then-HEAD) **driven by the target-audience changelog** (`changelog/adopter.md`), instead of the pre-commit staged diff; it advances the marker to HEAD and stages it with `README.md`. The skill's *Published landing page* section now spells out the approval loop (intent → preview → approval → publish). Per an owner Q&A, the **pre-commit hook stays as-is** (rule 4: adopter-facing change ⇒ `README.md` staged); a marker-freshness hook rule is deferred.
- **Assembly:** the *Setup scaffolding* addition is an in-section bullet, so **no section renumbering** — greenfield stays 1–18, legacy 1–18/19. Applied surgically to both composed charters and both pt-BR mirrors; verified no heading/numbering changes. Root `README.md` gained a *A living landing page* practice bullet and a landing-skin clause in the New-project adopt step; the marker file is indexed in `MEMORY.md`.
- Marked `ideas/landing-publishing.md` and `ideas/living-product-doc.md` **incorporated**; roadmap and handoff updated; decision recorded. The rendered **Artifact** landing republish is **held for owner approval** per the landing approval loop.

**In plain language:** we finished writing the last two of the six agreed ideas into the templates. First, a project's charter now says its Setup step also designs the *skin* (the look) of a public landing page once — through a short design interview — while the page's words are regenerated from an always-current product summary and only go live after you approve them. Second, we rewired our own helper that keeps this repo's front page current: instead of only looking at what's staged for the next commit, it now tracks the last commit it processed in a small file and catches up on everything since, using the users' changelog as its guide. The commit-guard hook is unchanged. We rebuilt both copy-ready charters and their Portuguese versions with the new Setup paragraph, refreshed the front page, and left the web landing to await your approval.

**Glossary:** *skin* — the fixed visual identity (design system, palette, layout) as opposed to the content that fills it; *last-processed-commit marker* — a small versioned file holding the last commit a skill has already reflected, so it can resume from there; *delta* — the set of changes between that marker and now; *idempotent* — running it twice changes nothing the first run didn't (safe to reprocess); *approval loop* — state intent → show a preview → wait for OK → publish.

## 2026-07-11 — Incorporated Setup-scaffolding + specified the project CLI (both charters + new requirement)

- Second incorporation from the Setup→changelog→landing cluster, taking two **interlocking** specs together (`setup-scaffolds-project` + `lifecycle-cli`) into template text:
  - **Setup scaffolding** (from `ideas/setup-scaffolds-project.md`) — a new `CHARTER_CORE` section beside *Working through questions*, plus an expanded Method §0 *Setup* bullet: Setup now settles the stack/tech choices and **generates a minimum runnable project** (stack skeleton + config, a `CLAUDE.md` referencing the charter, a seeded `.claude/memory/`). The charter's tech picks are **stated, overridable defaults** confirmed at Setup — *Stack philosophy*'s opener now says so. New Setup Exit: "and the project scaffolded."
  - **Project CLI** (from `ideas/lifecycle-cli.md`) — a **new deliverable**, `REQUIREMENT_PROJECT_CLI.md`: a `claude`-styled, interactive single-door CLI over `setup`/`adopt`/`update-docs`/`graduate-idea`, specified as a thin orchestrator (Principle · command table · invariants · non-goals · definition of done). We ship the spec; a real project builds it.
- **Two open questions settled in a Q&A round with the owner** (in `decisions.md`): the CLI **orchestrates the rituals while the pre-commit hook stays the backstop**; the CLI **invokes** the embeddable skills (they stay usable stand-alone), rather than absorbing them as subcommands.
- **Reassembled** both composed charters (greenfield now **1–18**, legacy **1–19**, sequential — new *Setup scaffolding* is §4, later sections +1). **Retranslated** both pt-BR charters and added the pt-BR requirement; the catalog (`templates/README.md`) and its pt-BR mirror gained the new requirement.
- **Landing page** (`README.md`): "What you get" now groups the two requirements (appliance + CLI); "How to adopt → New project" says Setup scaffolds; a new *Setup that scaffolds* practice bullet. The rendered **Artifact** landing was **republished to the same URL after owner approval** (Nord skin unchanged), per the landing approval loop.
- Marked `ideas/setup-scaffolds-project.md` and `ideas/lifecycle-cli.md` **incorporated** (4 of 6 cluster specs now in template text; 2 remain: landing-publishing and the living-product-doc rewiring); roadmap updated; decision recorded.

**In plain language:** we wrote two more of the six agreed ideas into the actual charters — the two that fit together. A project's Setup step no longer just records settings; it picks the tech with you (the charter's choices are suggestions you can swap, not silent defaults) and generates a starter project that already runs. We also wrote the spec for a single command-line tool that runs a project's whole lifecycle — set up, adopt, update docs, graduate ideas — and settled two questions about it with you: the tool runs the routines in order while the existing commit-guard stays as a safety net, and it calls the drop-in skills you already have rather than replacing them. We rebuilt both copy-ready charters and their Portuguese versions, added the new requirement (also in Portuguese), refreshed the front page, and — after your approval — re-published the web landing to the same address.

**Glossary:** *scaffold* — generate the initial project skeleton and config; *orchestrator* — a tool that runs other tools/steps in the right order without doing their work; *backstop* — a safety net that catches a mistake the happy path was meant to prevent; *invoke (a skill)* — call it rather than reimplement it; *composed charter* — the single self-contained file adopters copy, generated from the core + modules.

## 2026-07-11 — Incorporated Spec-driven work + Changelogs into `CHARTER_CORE` (both charters)

- Took two of the just-`agreed` specs into template text — the first incorporation from the Setup→changelog→landing cluster:
  - **Changelogs** (from `ideas/audience-aware-changelogs.md`) — a new `CHARTER_CORE` section: two curated changelogs on a **split cadence** (technical **per commit** with git history underneath; audience **curated per significant change**). The audience is the **existing `Primary users` parameter** — no new Project Parameters row, to avoid duplicating a value the block already carries. Placed in the record-keeping cluster, after *Roadmap & decision log*.
  - **Spec-driven work** (from `ideas/spec-driven-work.md`) — a new `CHARTER_CORE` section beside *Idea inbox*: every non-trivial task becomes a mini-spec before implementation (in the charter's `spec_term`), gaps trigger an immediate Q&A round, trivial mechanical changes are exempt. It reuses *Working through questions* and frames itself as the *Idea inbox* machine pointed at tasks.
- **Reassembled** both composed charters (surgical, verified): greenfield now **1–17**, legacy **1–18**, sequential. **Retranslated** both pt-BR charters — new *Changelogs* and *Trabalho orientado a especificações* sections, renumbered to match.
- **Landing page** (`README.md`): added *Two changelogs, two rhythms* and *Spec-driven work* to "What the charters give a project." The rendered **Artifact** republish is **held for approval** — the newly-agreed landing approval loop (`ideas/landing-publishing.md`) says every publish is previewed and approved first.
- Marked `ideas/spec-driven-work.md` and `ideas/audience-aware-changelogs.md` **incorporated**; roadmap updated; decision recorded.

**In plain language:** we wrote two of the six agreed ideas into the actual charters. Now every project built from a charter is told to keep two changelogs (a detailed one for developers, updated each commit, and a curated one for the product's users) and to write a short spec for each real task before coding — asking you up front whenever something's unclear. We rebuilt the two copy-ready charters and their Portuguese versions, renumbered the sections, and refreshed the front page. We did **not** re-publish the web landing yet — from now on that waits for your preview and approval.

**Glossary:** *incorporate* — write an agreed idea into the actual template text (as opposed to it living only as a spec in `ideas/`); *split cadence* — the two changelogs update on different schedules; *`spec_term`* — the charter's word for its golden-source specs (greenfield "specs", legacy "golden standards"); *reassemble* — regenerate the composed charters from the core + modules.

## 2026-07-10 — Graduated the Setup→changelog→landing cluster to `agreed` (2 Q&A rounds) + 2 new specs

- The **five newest inbox entries** turned out to be refinements of the pending draft cluster; graduated together in a **two-round Q&A** (all resolutions in `decisions.md` → *Graduated the Setup→changelog→landing inbox cluster*). Inbox emptied; graduated list extended.
- Existing specs moved **draft → `agreed`**:
  - `ideas/setup-scaffolds-project.md` — tech stack is the **developer's choice at Setup**; the charter's picks become recommended, overridable defaults (never silent assumptions); scaffold is a minimum runnable skeleton only.
  - `ideas/audience-aware-changelogs.md` — two changelogs are a **`CHARTER_CORE` section** (not a module); **split cadence** (technical per commit, target-audience curated per significant change); target audience is a Setup Project Parameters row.
  - `ideas/landing-publishing.md` — **approval loop on every publish** (intent-in-text → preview → approval → publish); GitHub Pages public primary + Artifact preview; skin captured as reusable design tokens.
  - `ideas/living-product-doc.md` — the update skill works by **delta from a versioned last-processed-commit marker**, not the pre-commit staged diff.
- **Two new specs, straight to `agreed`**:
  - `ideas/spec-driven-work.md` (was inbox #3) — every non-trivial task becomes a **mini-spec before implementation**; gaps trigger an immediate Q&A round; reuses `spec_term` + *Working through questions*. Incorporates as a new `CHARTER_CORE` section beside *Idea inbox*.
  - `ideas/lifecycle-cli.md` (was inbox #4, escalated by the owner to **full lifecycle**) — a single-door project CLI (`setup`/`adopt`/`update-docs`/`graduate-idea`) styled after `claude`. We ship the spec; it graduates into `REQUIREMENT_PROJECT_CLI.md`.
- **No template text changed** — this is a pipeline-only change (`ideas/` + `.claude/memory/`). Incorporation into `CHARTER_CORE`/requirements (each with the full assemble → landing → translate → changelog ritual) is the roadmap's next step.

**In plain language:** the owner dropped five new notes in the idea inbox; each turned out to sharpen a plan we already had in progress. In two rounds of questions-with-recommendations we settled all of them and wrote the decisions down. Six ideas are now "agreed" (ready to be written into the actual templates next): setup picks the tech with you and scaffolds the project; there are two changelogs on different rhythms; the landing page waits for your approval before publishing and updates itself from what changed since last time; every real task gets a short spec before coding; and there'll be one project command-line tool that runs the whole lifecycle. Nothing in the copied templates changed yet — that's the next step.

**Glossary:** *graduate* — turn an inbox note into a formal spec via a Q&A round; *agreed* — the spec's decisions are settled, ready to be written into template text; *marker (last-processed-commit)* — a saved pointer to the last commit a tool handled, so it can process only what changed since; *scaffold* — generate the initial project skeleton and config; *full lifecycle* — setup, adoption, doc/landing updates, and idea graduation, all under one tool.

## 2026-07-10 — Idea-inbox practice added to the charters, plus the first embeddable skill (`graduate-idea`)

- Graduated the inbox entry *"make the idea-ingestion system part of the template"* after a Q&A round (five outcome-changing questions settled in `decisions.md`): home = `CHARTER_CORE`; scope = inbox + graduation ritual reusing the existing `spec_term`; ship a skill now (owner override); skill covers graduation only; this skill defines the skill-template convention. Spec at `ideas/idea-inbox.md` (`Status: agreed`), removed from `ideas/inbox.md` in the same change.
- Added an **Idea inbox** section to `CHARTER_CORE.md` (new section 12 greenfield / 13 legacy), beside *Roadmap & decision log*: `ideas/inbox.md` as the owner's scratchpad + a graduation ritual (Q&A round → the charter's existing golden-source `spec_term` + a roadmap entry). Reuses the existing spec machinery — no new artifact type. Framed as the pre-roadmap staging area (scope *proposed* vs. *accepted*).
- Shipped the **first embeddable skill template**: `templates/skills/graduate-idea/SKILL.md` (graduation only — capture is a one-line append). It also **defines the skill-template convention** (`templates/skills/<name>/SKILL.md`, a leading "copy into `.claude/skills/`" adoption note, kebab-case name), documented in a new `templates/skills/README.md` — closes the first half of Milestone 4.
- Catalog (`templates/README.md`) Skills section is no longer "reserved"; it lists `graduate-idea`. Reassembled both composed charters (sections renumbered — greenfield now 1–15, legacy 1–16) and verified sequential numbering; regenerated pt-BR for both charters, both READMEs, and the new skill; updated the root `README.md` landing page (new *Idea inbox* practice + *Embeddable skills* offering).

**In plain language:** the owner liked how this repo collects rough ideas in an "inbox" file and later turns each into a proper spec — so we made that a feature adopters get too. Their charter now describes keeping an idea inbox and a ritual for "graduating" a note into a spec (ask the questions that matter, write down the decisions, add it to the plan). We also shipped the first ready-made skill a project can drop in to run that ritual, and used it to set the pattern for future drop-in skills.

**Glossary:** *graduate* — turn a rough inbox note into a formal spec via a Q&A round; *embeddable skill* — a reusable Claude Code skill an adopter copies into their project's `.claude/skills/`; *spec_term* — the charter's word for its golden-source specs (greenfield "specs", legacy "golden standards").

## 2026-07-10 — Defined the Q&A-round method once in the charter core (and dogfooded it)

- The owner didn't understand the "question-and-answer flow." It was under-documented: **"Q&A round" was used ~8× across the charters but never defined**, and the mechanics were scattered (options+recommendation only in `CLAUDE.md`; scripted-then-adaptive only in the `adaptive-setup-questions` draft, Setup-only).
- Added a **Working through questions** section to `CHARTER_CORE.md` (new section 3 in both composed charters) that defines a Q&A round once: batched · options + a recommendation · scripted-baseline-then-adaptive · answers become durable artifacts with traceability · a round closes at the phase's *Exit*. The Method phase list now points to it.
- `CLAUDE.md`: the inbox-graduation rule now runs the **same** method — processing an entry is a Q&A round whose resolutions are recorded in `decisions.md` before the spec is drafted. Explicitly framed as dogfooding.
- `ideas/adaptive-setup-questions.md` marked **incorporated** and broadened from Setup-only to the general method.
- Regenerated both composed charters via `assemble-charters` (new section 3; later sections renumbered — greenfield now 1–14, legacy 1–15) and verified sequential numbering.

**In plain language:** the charters kept saying the agent should work through "Q&A rounds" with you, but never explained what that means — so we wrote it down in one place: ask related questions together, each with options and a recommendation, start from a fixed list then follow up based on your answers, and write every answer down where it belongs. Our own repo now follows the same recipe when it turns one of your inbox notes into a spec.

**Glossary:** *Q&A round* — a batch of questions the agent asks to turn an open decision into a written, agreed one; *dogfood* — using our own prescribed practice on this repo itself.

## 2026-07-10 — Landing skin decided at Setup; scripted-then-adaptive Setup questions (drafts)

- Resolved two new inbox entries with the owner and moved them out of the inbox:
  - Extended `ideas/landing-publishing.md` into a **two-layer** model — the landing's **skin** (visual identity: theme, palette, layout) is designed **once at Setup** via a design interview (Claude Design the default tool); the **content** is the living-doc rendered into that skin, regenerated forever. Settled that "site" here means the landing (= living-doc rendered), not a separate site or the product frontend.
  - New draft `ideas/adaptive-setup-questions.md` — a **general Setup mechanism**: a scripted baseline of questions (guaranteed coverage) followed by Claude-generated adaptive follow-ups (context depth). Used by parameter confirmation, scaffolding, and the landing design interview alike.
- Recorded both decisions and the rejected alternatives (site-as-product-frontend; a dedicated site-template spec; adaptive-questions scoped only to the site) in `decisions.md`; added both to the Milestone 3 pipeline in `roadmap.md`.

**In plain language:** we decided how a project's landing page gets its look. The look (colors, layout) is chosen once, early, by asking the owner a few design questions — with Claude Design doing the visual part; after that the page's words are always regenerated from the living front-page document, so the look stays put and the content stays fresh. Separately, we wrote down a way of asking Setup questions: a fixed list first so nothing basic is missed, then smart follow-up questions the agent invents based on the answers. Both are still drafts.

**Glossary:** *skin* — the visual identity (palette, layout, components) as opposed to the content; *design interview* — the round of questions that fixes the skin; *scripted-then-adaptive* — a fixed question list followed by generated follow-ups.

## 2026-07-10 — Graduated a Setup + changelog→landing pipeline cluster (drafts)

- Graduated an inbox cluster into separate specs after a design conversation that converged the model:
  - `ideas/setup-scaffolds-project.md` (new draft) — Setup asks stack/language and generates a complete project setup.
  - `ideas/audience-aware-changelogs.md` (revised) — narrowed from multi-audience to **two curated changelogs**: technical (with git history as its raw record) + target-audience.
  - `ideas/landing-publishing.md` (new draft) — Claude Design prototyping; publish to Artifact + GitHub Pages.
  - `ideas/living-product-doc.md` (refined) — model is now a **pipeline**: target-audience changelog → living-doc → single landing page; `update-product-doc` will consume the changelog entry rather than the raw diff (rewiring pending).
- Recorded the consolidated model and the rejected alternatives (multi-audience; git-history-only; per-audience landing) in `decisions.md`.

**In plain language:** we talked through how project setup, changelogs, the front page, and the published landing page fit together, and wrote it down as a set of related draft ideas. The agreed shape: setup gathers the project's basics and scaffolds it; there are two changelogs (one for developers, one for the product's users); the users' changelog feeds the always-current front page, which becomes the landing page. Nothing is wired into the templates yet — these are drafts to refine next.

**Glossary:** *scaffold* — generate the initial project skeleton and config; *pipeline* — a chain where each stage is produced from the previous one (changelog → front page → landing page).

## 2026-07-10 — Published a rendered landing page for this repo (dogfooding)

- Applied the `living-product-doc` practice to claude-templates itself: published a rendered landing page as an Artifact (`https://claude.ai/code/artifact/213558f8-c877-4046-8476-714e542a855e`, private unless shared), derived from the root `README.md`.
- The HTML is a **generated view**, not versioned — README stays the single source of truth. The `update-product-doc` skill now documents republishing to the same URL when README changes.
- Design: a "charter" visual identity (serif display + monospace structural voice + § seal + honest numbered method) in the **Nord palette** (Polar Night / Snow Storm grounds, Frost accent), theme-aware for light/dark.

**In plain language:** we used our own new practice on ourselves — turned the front-page markdown into an actual web page and published it. The web page is regenerated from the markdown, so there's still only one place to edit.

## 2026-07-10 — Living landing page (root README.md) + update-product-doc skill

- Graduated `ideas/living-product-doc.md` to `agreed` and built it: the root `README.md` is now the living, current-state, adopter-facing source of truth (distinct from `changelog/` history and from `templates/README.md` catalog).
- New skill `.claude/skills/update-product-doc/`: run before a commit, it reads the staged diff and updates `README.md` to reflect user-facing impact — present tense, not a changelog.
- Hook rule 4: a commit that changes an adopter-facing deliverable (composed charters, requirements, guides, catalog) is blocked unless the root `README.md` is staged. Sources and translations are excluded.
- `CLAUDE.md` updated: layout (root README as living landing page), the `.claude/` skill list, and the commit ritual (assemble → update landing page → translate → changelog).
- Kept `audience-aware-changelogs` as a separate idea (owner decision): changelog is history, the landing page is current state; the same pre-commit moment can feed both.

**In plain language:** the repo now has a front page (`README.md`) that always describes what the templates are and how to use them, as they are right now. A helper keeps it accurate: before each commit that changes what users get, it reads the change and updates the front page in plain user terms. This is different from the changelog, which is the dated history — the front page is the always-current picture.

**Glossary:** *living document / landing page* — a file that is continuously kept in sync with the current state, rather than a log of past changes; *adopter-facing* — the parts a person copying the templates actually sees and uses (charters, requirements, guides, catalog).

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
