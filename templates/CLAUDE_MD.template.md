<!-- TEMPLATE — instantiated by `tools/install.sh new` as the target project's CLAUDE.md.
     {{CHARTER_PATH}} is replaced with the composed charter's relative path
     (.claude/charter/CHARTER_*.md).
     Named CLAUDE_MD.template.md so Claude Code never auto-loads it here. -->
# Project working agreement

This project is governed by the agent charter at [{{CHARTER_PATH}}]({{CHARTER_PATH}}). **Read it before any work** — it defines the method (phases and Q&A rounds), the stack philosophy, testing, memory, and git rules.

- **Current phase: Setup (phase 0) has not run yet.** Begin there — walk the Project Parameters block with the owner, settle the stack, then scaffold the minimum runnable project, per the charter's Method section.
- **Memory** lives in `.claude/memory/` (`roadmap.md` · `decisions.md` · `MEMORY.md` index): read the roadmap at session start, update it at session end. Project knowledge never goes to the agent's global memory.
- **Ideas**: `ideas/inbox.md` is the owner's scratchpad — never reorganize or delete entries; graduate one only when the owner asks (the `graduate-idea` skill runs the ritual).
- **Git**: never `git commit` or `git push` without explicit, per-instance authorization from the owner.
