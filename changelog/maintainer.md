# Changelog — maintainer

Technical changelog for whoever maintains this repository. Each entry ends with a plain-language addendum and, when needed, a jargon glossary. Newest first.

## 2026-07-10 — Meta-project structure, translation pipeline, dogfooded memory

- Moved deliverables into `templates/charters/` and `templates/requirements/` (`git mv`, history preserved); relative links between charters and the appliance requirement updated to `../requirements/`.
- Added `templates/README.md` as the deliverable catalog.
- Created `ideas/` with the behavior-spec format (`Status: draft | agreed | incorporated`, `Applies to`, Behavior/Why/Example/Open questions) and three specs: `language-setup`, `audience-aware-changelogs`, `translated-templates`.
- Implemented the pt-BR pipeline: `.claude/skills/translate-templates/SKILL.md` regenerates `templates/i18n/pt-BR/**` (mirrored paths, generated-file header, prose translated, code/identifiers kept in English); `.claude/hooks/check-freshness.sh` wired as a `PreToolUse` hook on `Bash` in `.claude/settings.json` blocks `git commit` when an English template is staged without its pt-BR counterpart, or when `templates/`/`ideas/` change without a staged `changelog/` update.
- Dogfooded the charters' memory practice: `.claude/memory/` with `roadmap.md` (4 milestones), `decisions.md` (5 entries), `MEMORY.md` index. No project facts outside the repo.
- Rewrote the root `CLAUDE.md`: layout, naming conventions, anti-contamination rules, memory rule, commit ritual.

**In plain language:** the repository got its definitive shape. The finished templates live in their own shelf (`templates/`), clearly separated from the workshop (ideas, notes, internal memory). Every template written in English now automatically gets a Portuguese twin, and a guard refuses to record changes when the twin — or this diary — was forgotten. The project also started following its own advice: its plans and decisions are written in files inside the repository, never in anyone's head.

**Glossary:** *hook* — a small program the agent's tooling runs automatically at a given moment (here: right before recording changes in git); *staged* — the set of files marked to be included in the next git commit; *dogfooding* — using on ourselves the practices we recommend to others.
