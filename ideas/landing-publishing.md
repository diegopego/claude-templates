# landing-publishing

Status: draft
Applies to: the living landing page (this repo now; template practice for adopter projects). The Setup design-interview step touches core (Setup phase).

## Behavior

The landing page has **two layers**, decided at different times — the skin is designed once; the content is regenerated forever:

- **Skin (visual identity) — chosen once at Setup.** During Setup (step 0) the agent runs a short **design interview** — theme, reference/example site, palette, target audience, technology stack — and generates the landing's visual template (design system, palette, layout, components) from the answers. The interview follows the scripted-then-adaptive pattern (see [adaptive-setup-questions.md](adaptive-setup-questions.md)): a fixed baseline of design questions, then Claude-generated follow-ups. **Claude Design** is the default tool for iterating the visual step; hand-authored HTML/CSS is the fallback. A later rebrand is a deliberate re-run of the design interview, not an ad-hoc edit.
- **Content — regenerated continuously.** The landing's content is a **rendered view of the living product document** (the markdown stays the source of truth — see [living-product-doc.md](living-product-doc.md)). The `update-product-doc` skill re-renders the living-doc into the chosen skin on every relevant change.

**Publishing to two targets** — an **Artifact** (fast, private until shared) and **GitHub Pages** (a stable public URL served from the repo). The `update-product-doc` skill regenerates the rendered view from the living-doc and republishes to both.

Palette: **Nord** is this repo's own choice (already applied to its landing page); adopter projects pick their palette in the Setup design interview.

## Why

Separating the **skin** (a design act, decided once) from the **content** (derived, regenerated from the living-doc) reconciles "the landing is a rendered view of the living-doc" with "the landing should look designed for its audience." Setup fixes the skin so it doesn't drift on every content change; the pipeline fills the content so it never goes stale. An Artifact gives a quick, private preview; GitHub Pages gives a stable, shareable public URL tied to the repo. Claude Design removes hand-CSS from the visual iteration. All keep the markdown living-doc canonical.

## Example

This repo: landing page published as an Artifact (`https://claude.ai/code/artifact/213558f8-c877-4046-8476-714e542a855e`, Nord palette chosen by the owner). Its skin was hand-authored — a meta-project runs no Setup interview on itself; an adopter project would run the Setup design interview and default to Claude Design. GitHub Pages target pending.

## Open questions

- GitHub Pages setup: needs a public repo + Pages config + a README→HTML build step — run by CI or by the `update-product-doc` skill? How is it kept in sync with the Artifact?
- Does Pages become the primary public channel once set up, with the Artifact as preview?
- How much of the generated skin is captured as reusable design tokens (so `update-product-doc` re-renders into it deterministically) vs. re-derived each publish?
- pt-BR landing page (carried over from `living-product-doc`)?
