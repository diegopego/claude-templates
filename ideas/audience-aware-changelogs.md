# audience-aware-changelogs

Status: draft
Applies to: core (candidate new module: DOCUMENTATION_BY_AUDIENCE)

## Behavior

At every commit, the agent consolidates the changes into (1) a technical changelog with a plain-language addendum explaining jargon and complex passages, and (2) one changelog per target audience declared in the Project Parameters, each written at that audience's level of knowledge and interest. The same audience mapping applies to the Align Q&A documents and to the design cycle (e.g. Claude Design reviews): each audience gets the questions and answers adapted to its level — design iterations are part of the alignment cycle and must be documented like it.

## Why

A single technical document excludes non-technical stakeholders from the alignment cycle — exactly the people the charters treat as oracles.

## Example

Harbour: core developer, application developer, end user. An appraisal system: appraiser, end user, system administrator.

## Open questions

- Do target audiences become a row in the Project Parameters block?
- Changelog per commit or per milestone (per commit may be noisy)?
- Is this a core section or a pluggable module referenced by both charters?
