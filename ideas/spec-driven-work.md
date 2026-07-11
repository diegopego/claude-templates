# spec-driven-work

Status: incorporated
Applies to: core (new `CHARTER_CORE` section — Spec-driven work)

> **Incorporated 2026-07-11** into `CHARTER_CORE.md` as the *Spec-driven work* section, placed beside *Idea inbox*; composed charters reassembled (greenfield §14, legacy §15) and pt-BR retranslated.

## Behavior

Every non-trivial task is turned into a **spec before it is implemented**. A task does not go straight to code: the agent first writes a small spec — the same golden-source `spec_term` the charter already uses (Behavior "when X, do Y" / Why / Example / Open questions) — sized to the task. Implementation then follows the spec, and the spec is the thing reviewed and traced against.

When there is a **gap** — a requirement the agent cannot pin down well enough to write an ideal spec — it **asks the owner immediately** rather than guessing. This is the charter's existing **Q&A round** (*Working through questions*): questions batched, each with options and a recommendation, scripted-baseline-then-adaptive; the answers become part of the spec and the decision log.

This is the **same machine as the Idea inbox**, extended from *ideas* to *tasks*: the inbox matures a rough idea into a spec; spec-driven work does the same for a unit of work about to be built. Trivial, mechanical changes (a rename, a typo, a one-line fix with no behavioral ambiguity) are exempt — writing a spec for them is over-engineering.

## Why

Jumping from a vague task to code bakes unstated assumptions into the implementation, where they are expensive to find and correct. Forcing the task through a spec first surfaces the ambiguity **while it is still cheap** — as a question, not a bug — and leaves a traceable record of what was decided and why. It makes the Q&A round the default working mode, not a phase-one ritual.

## Example

Task: "add per-tenant rate limiting." Instead of coding, the agent drafts a spec: *Behavior* (limits per tenant, defaults, what happens at the limit), *Why*, *Example*, *Open questions*. It finds two gaps it cannot resolve well — the default limit, and whether limits are configurable per plan — and asks the owner in one batched Q&A round with options + a recommendation. The answers land in the spec; only then does implementation start.

## Relationship to existing practices

- **Idea inbox / `graduate-idea`** — same golden-source `spec_term` and the same graduation Q&A; the inbox is the *pre-roadmap* staging area for ideas, spec-driven work is the *pre-implementation* step for tasks. One vocabulary, two entry points.
- **Working through questions** — spec-driven work is the most common trigger of a Q&A round; the round's mechanics are defined once in that section and reused here.
- **Setup** — a project scaffolded at Setup already has the `spec_term` and memory wired, so spec-driven work has somewhere to write.

## Open questions

- Where the section sits relative to *Working through questions* and *Idea inbox* in `CHARTER_CORE` (adjacent, since all three share the Q&A-round machinery).
- Whether the "non-trivial" threshold needs a sharper, written test or stays a judgment call guided by the anti-over-engineering rule (leaning: judgment call).
