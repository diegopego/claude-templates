# Skill Templates

Embeddable **skill templates** — reusable Claude Code skills an adopting project copies into its own `.claude/skills/`. They live here, never in this repo's `.claude/skills/`, precisely so they stay inert in the meta-project (a skill under `.claude/skills/` would auto-activate here).

## Convention for an embeddable skill template

A skill template is a directory whose contract mirrors a normal Claude Code skill, plus a marker that it is meant to be copied:

- **`templates/skills/<name>/SKILL.md`** — one directory per skill; `<name>` is kebab-case and matches the skill's activation trigger.
- **YAML frontmatter first** — `name` (the kebab-case name) and `description` (one line, written so Claude picks the skill at the right moment: what it does *and* when to use it).
- **A leading adoption note** — the first line of the body is a blockquote marking the file as a template and telling the adopter to copy the directory into `.claude/skills/<name>/`. It is written to be harmless if left in place after copying.
- **Body written for the adopter's agent** — the instructions address the agent running inside the adopting project, referencing that project's files (`ideas/inbox.md`, `.claude/memory/`, its charter) by name rather than by relative path (paths break when the directory is copied into a foreign repo).

To adopt one: copy `templates/skills/<name>/` into your project's `.claude/skills/<name>/` (or let `make new` / `make adopt` do it). That is the whole install — but skills load at session startup, so if a Claude Code session is already open in the project, run `/reload-skills` there before asking for the skill.

## Available skills

- **`graduate-idea/`** — graduate a rough idea from `ideas/inbox.md` into a proper spec: runs a Q&A round to resolve outcome-changing questions, records the decisions, drafts the spec, adds it to the roadmap, and removes the inbox entry. Pairs with the charter's *Ideas & specs* practice.
- **`adopt-template/`** — bring these templates into a project that already exists, without losing its instructions: inventories the current `CLAUDE.md` and convention docs, classifies each charter section, chosen module, and requirement (keep / adapt / already-covered / skip), raises every conflict to the owner, and produces a merged `CLAUDE.md` plus seeded `.claude/memory/`. Automates `guides/GUIDE_ADOPTION.md`.
