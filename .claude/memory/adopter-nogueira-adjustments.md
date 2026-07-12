# Third adopter — nogueira-adjustments (friction report + adoption record)

Written 2026-07-12 from a session in **orderboard**, which had read access to both repos but could not do the work. **Executed 2026-07-12** from this repo: all six corrections shipped (`3b1eea8`), and the upgrade ran in that project (uncommitted there, by design).

> **Correction, made during execution — the premise below was wrong on one point.** This project was **not** built independently of these templates. Its own session log records the truth: *"2026-07-09 — Owner charter absorbed into CLAUDE.md (cherry-pick from the owner's legacy-transformation template)"*. Its adoption commit (`d44c07d`, `2026-07-09T22:39:29-03:00`) dates it to **claude-templates @ `1bbf79a`** — the very first commit of this repo. That also explains the byte-identical `REQUIREMENT_PORTABLE_APPLIANCE.md`: it was copied, and that file has zero changed lines since `1bbf79a`. So it is an **old unstamped adopter**, and what it got was an **upgrade**, not a first adoption.
>
> **The six corrections survive this intact — and are better evidenced by it.** They rest on its ADRs **0031** (operate the sheet), **0032** (v1 starts empty) and **0033** (two golden sources), all dated 2026-07-12, i.e. *three days after* it absorbed the charter. They are not a coincidental re-derivation; they are a project that **had** the charter, hit reality, and contradicted it. A charter contradicted in practice by the project running it is the strongest defect report there is. What dies is only the "independent re-derivation" framing — read the report below with that substitution.

`~/devel/nogueira-adjustments` is the templates' **third adopter** and the roadmap's *"record every friction point during adoption"* item, delivered.

## What the project is

A pre-code, spec-driven reconstruction of a residential-appraisal Google Sheets workbook into a multi-tenant SaaS (USPAP, US/Texas: cost, sales-comparison, income/GRM approaches). 162 tracked files, **no application source yet**; current phase is design-finalization with the appraiser. Same owner, same domain family as orderboard, same stack intent (strict TS, TDD, functional core), and the **same portable-appliance requirement — byte-identical to ours, sitting at its repo root**, hand-copied at some point.

Its instruction layer is a single `CLAUDE.md` with a section literally titled *"Working agreements (owner charter, adopted 2026-07-09)"*, written independently of these templates. It already covers, in its own words: roles, roadmap discipline, decision-log discipline, language protocol, git authorization, secrets, TDD/pyramid/functional-core, anti-over-engineering, thin wrappers around domain-touching dependencies, and the portable appliance. Its `.claude/` is **empty** — zero harness conflicts; every collision is at the level of *text and practice*, not files.

Where it keeps things (and keeps them well): direction in `specs/07-roadmap.md` + `specs/analysis/next-work-todo.md` (an ordered live queue), decisions as **34 numbered ADRs** in `specs/decisions/`, open questions in a single registry `specs/analysis/open-questions.md`, goldens in `specs/fixtures/`, the prototype in `specs/prototype/` with a `make verify` gate (29 checks, 16 screens).

## The six charter defects it exposed

Ordered by how much they change the templates. Each is a **template correction**, not a per-project disposition — writing them as "architectural" dispositions in two separate repos would encode the same mismatch twice.

**1. Data migration is not charter material at all — and it hides a real conflation.**
`MODULE_DATA_MIGRATION` is wired to legacy by the manifest (*"Always on for legacy"*). This project migrates **nothing**: its ADR 0032 says v1 starts empty — no import feature, no reconciliation of row counts or money totals, no freeze date, no dual-write; that workstream is *deleted*, not deferred. Yet it **still has a cutover** (both systems run in parallel; the sheet becomes a read-only archive once the app is trusted). So the module bundles two independent concerns, and only one of them is universal:

- **Cutover** — *the legacy system stays live and keeps changing while the app is built; decide when it freezes, whether the two run in parallel, and re-verify the extracted rules against the source before switching over* — is true of **every** legacy transformation, including one that imports zero rows. It belongs in `MODULE_EXTRACTION_LEGACY`.
- **Historical-data migration** — profile dirty data, imports-as-features, reconcile row counts and money totals — is a **project** concern. Owner's call, explicit: *"eu nem queria que migração de dados do sistema legado fizesse parte deste template."*

→ **Delete `MODULE_DATA_MIGRATION.md`**, move the cutover bullet into `MODULE_EXTRACTION_LEGACY`, and drop it from the manifest, the add-on list, the `adopt` file list in `tools/install.sh`, and the guide. A project that inherits history writes those rules itself — which is exactly what orderboard already does in its own `CLAUDE.md` (see the caution below).

**2. The golden source is not necessarily singular.**
The Project Parameters row and the source-of-truth section both say *"the legacy system"*, one system. This project has **two**: the workbook *and* the NBCM cost manual (licensed primary material the author transcribed the cost tabs from — and the manual wins where they disagree, ADR 0033). Orderboard likewise has the sheet plus 23 Apps Script files. The owner states it plainly: it is common for **more than one system to serve as golden standard**.
→ Make it **one or more golden sources**, named individually in the parameters; make traceability cite **which source** a rule came from; and make a disagreement *between* two golden sources an Align question, never an inference.

**3. "A copy, not production" is incomplete — the copy gets *corrected*.**
Today the rule implies the copy is probed but never deliberately changed, which reads as a prohibition. The owner's standing practice is the opposite and better: extraction **finds genuine errors in the golden source** (this project measured 22 in one cost tab), those errors are **fixed**, and the author reconciles them into production and re-provides the copy. The correction is a first-class extraction output, traceable like any other finding.
→ Say so. Cross-project: this is the owner's general pattern for every legacy system he provides.

**4. The charter reads the legacy system; it should *operate* it.**
Understand says *"map the structure, data, and embedded logic"* — a reading exercise. The owner's actual method is interactive: **drive the old system** through whatever surface it exposes (REST API, MCP server, Playwright against its UI, a script harness) and observe what it *does*. This project proved the point — the 3-story fireplace `#N/A` surfaced only by changing one dropdown, and its ADR 0031 mandates *"operate the sheet, don't just read it"* with a **snapshot → write → recalc → read → restore** discipline that leaves no residue. Reading alone does not find defects.
→ Add it as an extraction rule, paired with #3 (probing writes are welcome: deliberate, reversible, residue-free).

**5. `MODULE_PRODUCT_AUDIENCE` says "multi-tenant from v1" and never says how users relate to tenants.**
Both adopters needed the same model and the module supplies none. The owner's default product shape, stated generally: **multi-tenant *and* multi-user — a person belongs to one or more companies, with a different role per company** (employee, CEO, CTO, shareholder…), mirroring the real world.
→ Identity boundary = a **single shared user base**; authorization boundary = the **membership** (user × tenant × role), never the user record. Worth stating the consequences, because both projects hit them: a session has a *current* tenant, not a permanent one; every domain query is scoped by membership; inviting an existing user into a second tenant must not create a second account. Orderboard already decided exactly this — the module is behind its own adopter.

**6. `MODULE_LIVING_DOCS` has the wrong cadence.**
It says the technical changelog is *"updated per commit"*. Orderboard, running the pipeline for real, already writes *"curated per significant change; the git history is its raw record underneath"* — and it is right: a per-commit changelog is a hand-maintained duplicate of `git log`, and it rots.
→ Align the module to **curated per significant change** for both changelogs, naming git history as the raw record. The template catching up to its adopter.

## Caution — deleting the migration module touches orderboard

Orderboard **does** migrate history (`IMPORT*` tabs, two entities, *"reconcile row counts and money totals"*). Deleting the module does **not** delete orderboard's section: its `CLAUDE.md` is self-sufficient and keeps those rules as a **project** rule. Its upgrade must record that consciously (*architectural*), not silently drop it. Also note the standing caution in `handoff.md` — *never fold the add-on modules back into the greenfield manifest row* — is unaffected: this removes a module, it does not fold one in.

## Then: adopt into nogueira-adjustments

Only after the corrections are assembled and committed, so the delivered kit carries the corrected text and the stamp points at the right commit.

```sh
make adopt DEST=~/devel/nogueira-adjustments
```

**Dry-run already verified** (2026-07-12): the installer only adds files and never overwrites; all target paths are **absent** in that repo today, so the run emits zero `skip (exists)` lines. It does not touch its `CLAUDE.md` (that path exists only in `new` mode, which aborts when a `CLAUDE.md` is present) and ships no hooks or `settings.json`. After the deletion it delivers 15 files instead of 16.

### Merge decisions already taken by the owner — do not re-ask

| Question | Decision |
|---|---|
| Charter | **legacy-transformation** |
| Modules | **`MODULE_PRODUCT_AUDIENCE` + `MODULE_LIVING_DOCS`** (data-migration no longer exists) |
| Homes for direction/decisions | **Keep the project's** — `specs/07-roadmap.md`, `specs/analysis/next-work-todo.md`, ADRs in `specs/decisions/`. Do **not** create `.claude/memory/roadmap.md` or `decisions.md` there; `.claude/memory/` gets only `MEMORY.md` (an index pointing into `specs/`), `handoff.md`, `template-version.md`. Disposition: *already covered / architectural* |
| Adoption ADR | The disposition matrix is recorded as a **new ADR in `specs/decisions/`** (that project's decision-log format), which `template-version.md` points at |
| Appliance requirement | Byte-identical, already at its repo root — **keep it there**, do not move it under `.claude/`. *Conflict-avoided* |
| Idea inbox + `graduate-idea` | **Adopt.** Graduation writes into `specs/` + an ADR — never a parallel registry |
| Prototype seed data | Owner's call (private repo). Hard rule only: **no credentials** in any published artifact |

### Expected dispositions (a proposal for the owner to arbitrate, not a decided outcome)

- **keep as-is** — Project Parameters block (it has none); **classify on extraction** (domain \| instance-config \| workaround — a real gap: it has P4 *semantics-not-cells* but no 3-way tag, and the tag is directly useful to the NBCM tables as instance-config and the 22 transcription errors as workaround); **session handoff** (genuinely missing); **idea inbox**.
- **adapt** — Q&A rounds (already batched in `open-questions.md` §9.x; adopt the explicit *options + a recommendation* discipline); **product-for-an-audience** (instruction now, data model later — below).
- **already covered / architectural** — the corrected copy rule, operate-it-don't-read-it (this project *invented* it; the charter is the one catching up), traceability, conflicts-surfaced, cutover, the phased method (its Phase A/V/B/0–8, ADR 0017 — map names onto it, do not renumber), roles, language, stack philosophy, anti-over-engineering, testing, git authorization, secrets, memory/roadmap/decisions homes.

### Two things the merge must NOT do — they come after, with the owner

1. **Membership model → roadmap, not a merge edit.** The project already calls itself a multi-tenant SaaS (ADR 0034) and its P7 isolates per user/organization, but `specs/03-data-model.md` does not express **user × tenant × role**. Adopt the *text*; then put the data-model consequence to the owner as a batched Q&A round with a recommendation. It is an ADR + a spec change + a roadmap item. This is the one adoption consequence that can move its build — retrofitting tenancy is the expensive migration.
2. **Living docs → adopt the module and the skill, but do not run the pipeline.** Propose it as a roadmap item. Guard-rails, into its merged `CLAUDE.md` (not merely a review checklist):
   - **NBCM licensing (its ADR 0034).** The line is *using* the cost data versus *distributing the book*. Computed results with citations (edition + printed page) are exactly what the ADR blesses — **quoting is allowed**. Forbidden: the tables as **data** (bulk export, table API, "browse the manual" screen, an audit view dumping a whole table), any verbatim or derived extract entering git (its history was purged with `git filter-repo` on 2026-07-10 for precisely this), and the pipeline ever reading `references/` as a content source.
   - **No credentials** — passwords, keys, service-account paths, or the sheet URL — in any published artifact.
   - Its prototype's seed data carries real Texas addresses and the author's e-mail (`tools/package-prototype.sh` already warns). The repo is private; the owner keeps that judgment.
   - `rebuild` mode must **reconcile** the dated session log at the bottom of `specs/analysis/next-work-todo.md` (*"append a dated line per session that edits this file"*) rather than duplicate it — then propose retiring it, since `handoff.md` and a curated `docs/CHANGELOG.md` supersede a hand-maintained per-file edit log.

### Finish

Tear down the kit (`agent/` + the one-shot `adopt-template` skill) **before anything is staged**, so the 15 delivered files never reach its history — while `.claude/` (empty and untracked there today) **must** be added to its commit. Prove by functioning: `make verify` green (29 checks, 16 screens). Then `make upgrade DEST=~/devel/nogueira-adjustments` must report *"already up to date"* — that round-trips the stamp through the installer's own parser. That project's own session authorizes its commit; this one never commits there.

## Then: fold the corrections into orderboard

```sh
make upgrade DEST=~/devel/nogueira/orderboard
```
Stamped at `29468ef`, reconciled to `3e09fd2`. The delta reaches it as: the corrected copy rule and **operate-it-interactively** (genuinely new for it — its Apps Script analysis was a reading exercise, and its sheet is a writable copy that should be driven); plural golden sources (already true); the membership model (already decided — the text now matches); the changelog cadence (already complies); and the data-migration deletion (**keep its own section** — see the caution above).
