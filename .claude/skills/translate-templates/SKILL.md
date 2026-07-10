---
name: translate-templates
description: Regenerate the Brazilian Portuguese translations of the English templates under templates/ into templates/i18n/pt-BR/. Use before committing template changes, or when the pre-commit freshness hook blocks a commit. Pass --all to retranslate everything regardless of what changed.
---

# translate-templates

Regenerate the pt-BR mirror of the template deliverables. English is the source of truth; translations are generated artifacts and are committed.

## Scope

1. Determine which files to translate:
   - Default: every `templates/**/*.md` (excluding `templates/i18n/` and `templates/charters/sources/`) that is new, modified, or staged per `git status`, plus any whose counterpart under `templates/i18n/pt-BR/` is missing.
   - With `--all`: every `templates/**/*.md` excluding `templates/i18n/` and `templates/charters/sources/`.
   - **Charter sources are not translated.** `templates/charters/sources/` holds the build inputs (core + modules); only the composed charters under `templates/charters/` are adopter-facing and get a pt-BR counterpart. Regenerate composed charters with `assemble-charters` before translating.
2. For each source file `templates/<path>`, write the translation to `templates/i18n/pt-BR/<path>` (same relative path and file name — file names are not translated).

## Translation rules

- Translate prose to Brazilian Portuguese, keeping the document structure (headings hierarchy, tables, lists, emphasis) identical to the source.
- Keep in English: code blocks, inline code, identifiers, commands, file names, link targets, and established technical terms that Brazilian developers use untranslated (commit, deploy, backup, pipeline…) — use judgment: the reader is a Brazilian software professional.
- Relative links must keep working from the translated file's location: links between templates point to the pt-BR counterpart (e.g. `../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md` still resolves inside `i18n/pt-BR/`); links to files that exist only in English get `../../` adjusted to reach the English original.
- Start every translated file with this header block, verbatim:

  ```markdown
  > [!NOTE]
  > Arquivo gerado — tradução de [`<relative path to English source>`](<relative path>). O inglês é a fonte de verdade; não edite esta tradução manualmente. Regenerada pela skill `translate-templates`.
  ```

- Never edit the English source while translating; if the source has a defect, stop and report it instead.

## After translating

Remind the session to `git add` the regenerated files together with their English sources so the pre-commit freshness hook passes.
