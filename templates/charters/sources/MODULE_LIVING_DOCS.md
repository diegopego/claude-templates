<!--
SOURCE MODULE — not a deliverable. Add-on module: gives the project a living
documentation pipeline — curated changelogs, a living product doc, and a
public landing page whose skin is designed once at Setup. Pluggable: add it
to a charter's manifest row when the project wants a public face kept
current; leave it off when git history and a README are enough. Consumed by
the `assemble-charters` skill per charters.manifest.md.
-->

# Module — Living documentation

===SLOT: living_docs===
## Living documentation

Change is recorded for two readers, and the product keeps an always-current public face:

- **Technical changelog** — for whoever maintains the code, updated **per commit**; the git history is its raw record underneath, which the curated entries group and summarize. Each entry ends with a plain-language addendum for any jargon or dense passage.
- **Audience changelog** — for the **Primary users** (Project Parameters), written at their level of knowledge and interest, curated **per significant change**: related commits grouped into a coherent story rather than a stream of diffs. It is the interpretation layer — the natural source for any user-facing summary of the product.
- **Living product doc & landing page.** The audience changelog feeds an always-current product summary, rendered as the project's public **landing page**. Its **visual skin is designed once, at Setup**, through a short design interview — theme, reference site, palette, target audience — run as a Q&A round, with **Claude Design** as the default tool and hand-authored HTML/CSS the fallback. The skin is then held stable (a rebrand is a deliberate re-run of the interview, not an ad-hoc edit) while the **content** regenerates from the living doc as the product changes. **Every publish passes an approval loop**: statement of intent → rendered preview → {{ oracle }} approval → publish. Nothing goes public silently.

This pipeline is executed by the **`update-living-docs`** skill — the module's automated arm, adopted together with it. It runs in two modes: **rebuild** regenerates the whole set from the project's current state (the path when a large project adopts the pipeline mid-life, or when a forced re-creation is needed), reconciling any existing changelog into the technical/audience split; **update** folds a single change in incrementally. Either way the two changelogs, the living doc, and the landing stay in sync, and the landing publishes only behind the approval loop above.
