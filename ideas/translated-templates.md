# translated-templates

Status: agreed
Applies to: this repo (meta-project tooling), possibly a future module for template-consuming projects

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

- Should this graduate into a reusable module/skill that template-consuming projects can adopt for their own documents?
