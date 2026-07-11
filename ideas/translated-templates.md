# translated-templates

Status: incorporated
Applies to: this repo (meta-project tooling)

## Behavior

Every template under `templates/` (English, the source of truth) has a generated Brazilian Portuguese counterpart at the mirrored path under `templates/i18n/pt-BR/`, committed alongside it. When a commit stages a change to an English template without staging its pt-BR counterpart, the pre-commit hook blocks the commit and points to the `translate-templates` skill.

## Why

The owner reviews and shares templates in Portuguese, but English must remain the single source of truth for the deliverables. Generated, committed, hook-enforced translations keep both without manual discipline.

## Decisions

- Mechanism: translation is done by the `translate-templates` skill (translation needs an LLM; a shell hook can only *detect* staleness, not fix it). The hook in `.claude/settings.json` enforces freshness at commit time.
- Location: `templates/i18n/pt-BR/` mirroring the English tree — keeps deliverable directories clean and scales to other languages.
- Translations are committed (everything in this repo is versioned).
- Prose is translated; identifiers, commands, file names, and code blocks stay in English; each translation carries a generated-file header.

## Open questions

None — resolved in the 2026-07-11 Q&A round (see `decisions.md`): this stays **meta-project tooling**, not a reusable module/skill, until an adopting project actually asks for translated documents of its own. The charters' language protocol already covers adopters' language needs; reopening is cheap if demand appears.
