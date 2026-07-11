---
name: graduate-idea
description: Graduate a rough idea from `ideas/inbox.md` into a proper spec — run a Q&A round to resolve every outcome-changing question, record the decisions, write the spec, add it to the roadmap, and remove the entry from the inbox. Use when the owner asks to graduate, promote, formalize, or "spec out" an inbox idea.
---

# graduate-idea

> **Embeddable skill template.** Copy this directory into your project's `.claude/skills/graduate-idea/`; the agent then runs it whenever the owner asks to graduate an inbox idea. This note is harmless to leave in place.

The project keeps an **idea inbox** at `ideas/inbox.md` — the owner's scratchpad of half-formed ideas (see the charter's *Idea inbox* section). Capturing an idea is a one-line append and needs no skill. **Graduating** one is the valuable step, and this skill drives it: a rough note becomes a well-formed spec with its decisions traceable, and earns a place on the roadmap.

## When to run

When the owner asks to graduate / promote / formalize / "spec out" a specific inbox entry. Only that entry — never graduate, reorganize, rewrite, or delete an entry the owner did not name.

## What to do

1. **Locate the entry** the owner named in `ideas/inbox.md`. If it is ambiguous which one, ask.
2. **Run a Q&A round** — the one your charter defines in *Working through questions*. Surface **every question that would change the idea's outcome**, batched into one round, each with the options you see and your recommendation. Open with the questions you already know you must ask (the scripted baseline), then add follow-ups the answers reveal (adaptive). Stop when no question the owner considers blocking remains. *If the idea has no outcome-changing questions, skip straight to step 4.*
3. **Record the resolutions** in `.claude/memory/decisions.md` — one entry: what was decided, why, and the strongest rejected alternative. Decisions are recorded **before** the spec is drafted, so the spec reflects settled ground.
4. **Draft the spec** in the form your charter prescribes for its golden-source specs (greenfield *specs* / legacy *golden standards*), in the project's spec location. Reflect every settled question; list any genuinely residual ones under *Open questions*. A useful default skeleton when the project has none: a `Status:` line (`draft | agreed | incorporated`), an `Applies to:` line, then **Behavior** ("when X, the agent/system should Y") · **Why** · **Example** · **Open questions**. The spec reaches `agreed` once no outcome-changing question is left open.
5. **Remove the graduated entry** from `ideas/inbox.md` **in the same change** — graduation moves the idea, it does not copy it.
6. **Add the spec to `.claude/memory/roadmap.md`** as accepted scope. The inbox proposes scope; the roadmap accepts it.

## Rules

- **Owner-driven only.** Never graduate an entry unprompted, and never touch other inbox entries while graduating one.
- **Capture is not this skill.** Jotting a new idea into the inbox is a plain one-line append — do not invoke graduation for it.
- **Answers become artifacts.** Every resolved question lands in `decisions.md`, the spec, or repo memory — traceable to this round. An answer not written down did not happen.
- **English artifacts.** The spec, decision entry, and roadmap line are English (per the language protocol); only the inbox itself may be in any language.
- **No commits without authorization.** Prepare the change (spec, decisions, roadmap, inbox edit) and stop; committing needs the owner's explicit per-instance go-ahead.
