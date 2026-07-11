# idea-inbox

Status: agreed
Applies to: core (both charters); `templates/skills/` (new `graduate-idea` skill — first embeddable skill template)

> **Agreed (2026-07-10).** Graduated from the inbox after a Q&A round; the five outcome-changing questions are settled in `decisions.md` and reflected below. Ready to incorporate into `CHARTER_CORE.md` + a `graduate-idea` skill.

## Behavior

A project that adopts the charters gets a lightweight **idea intake** practice on top of the roadmap/decisions/memory it already carries:

- **Capture.** The repo keeps `ideas/inbox.md` — the oracle's scratchpad. Rough ideas are jotted there in any language, at draft quality (the one file exempt from the English-artifact rule). The agent never reorganizes, rewrites, or deletes inbox entries on its own; the inbox belongs to the oracle. Capture needs no tooling — it is a one-line append.
- **Graduate.** On the oracle's request, an entry graduates into a spec. The agent first runs a **Q&A round** (the one defined in *Working through questions* — batched, options + recommendation, scripted-baseline-then-adaptive), surfacing every question that would change the idea's outcome and resolving it with the oracle. It records the resolutions in `decisions.md`, then writes the idea up in the charter's ordinary golden-source `spec_term` and **removes the entry from the inbox in the same change**. With no outcome-changing question left open, graduation proceeds straight through.
- **No new artifact type.** What graduation produces is an ordinary spec — greenfield *specs*, legacy *golden standards* — not a bespoke format. An inbox note is a *proposal* for scope; graduation is how a proposal earns its place on the roadmap.
- **Relationship to the roadmap.** The inbox is the pre-roadmap staging area: raw ideas live there until graduation turns them into an agreed spec plus a roadmap entry. This keeps the roadmap rule intact — the inbox is where scope is *proposed*, the roadmap where it is *accepted*; a raw note is not yet committed work.

The graduation ritual also ships as an embeddable skill, **`graduate-idea`**, under `templates/skills/`. An adopter copies the skill directory into their project's `.claude/skills/`; running it drives the Q&A round → spec → roadmap flow. This is the **first `templates/skills/` entry**, and it sets the convention for embeddable skill templates: a `templates/skills/<name>/SKILL.md` carrying a leading "copy me into `.claude/skills/`" adoption note, kebab-case name matching its activation trigger.

## Why

Direction lives in the roadmap and the decision log, but there was no sanctioned front door for half-formed ideas — they either interrupt the work in flight or get lost. An inbox gives the oracle a zero-friction place to offload, and the graduation ritual converts raw notes into well-formed specs through the same Q&A discipline the charters already prescribe. The meta-project has run this exact loop since day one and it works; this graduates the practice itself into the product so every adopter inherits it.

## Example

The oracle jots `- customers keep asking for CSV export of invoices` into `ideas/inbox.md` mid-sprint and moves on. Two days later: "graduate the CSV-export idea." The agent opens a Q&A round — *which entities? which columns? per-tenant filename convention? streamed or synchronous for large accounts?* — each question with options and a recommendation. The answers land in `decisions.md`; the agent drafts an `invoice-csv-export` spec, adds it to the roadmap, and deletes the inbox line in the same commit. The rough note has become buildable scope with its decisions traceable.

## Open questions

(none — the five outcome-changing questions were resolved in the 2026-07-10 Q&A round; see `decisions.md`. Refinements, if any, surface during incorporation.)
