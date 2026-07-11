# Inbox

The owner's scratchpad. Jot rough ideas here in any language, any quality — this is the one file in the repo exempt from the artifact-language rule.

An entry **graduates** when it becomes a proper spec in this directory (`Status: draft`); remove it from the inbox in the same change. The agent never reorganizes, rewrites, or deletes inbox entries on its own — graduation happens only when the owner asks.

---

## Refresh de working-copy de skill não funciona (fricção do Milestone 6, self-adoption — 2026-07-11)

O CLAUDE.md manda "editar a fonte em `templates/skills/` e re-rodar `make adopt DEST=.` para atualizar a working copy". Mas o instalador **nunca sobrescreve** (`install_file` faz skip quando o destino existe — `tools/install.sh:34`), então re-rodar dá `skip (exists)` e a cópia fica stale. Hoje o único jeito é `rm` a working copy e reinstalar (foi o que precisei fazer ao atualizar o `adopt-template` depois de editar a fonte).

Caminhos para resolver (decisão do dono):
- Self-adoption **sempre sobrescreve** as working copies de skill — são geradas, não autoradas, diferente do never-overwrite que protege os arquivos do adotante; OU
- um flag `FORCE=`/`--refresh` no instalador; OU
- corrigir só a frase do CLAUDE.md para "remova a working copy e re-rode".

*(empty — jot the next rough idea here)*

*(previous entries graduated to [language-setup.md](language-setup.md), [audience-aware-changelogs.md](audience-aware-changelogs.md), [product-not-bespoke.md](product-not-bespoke.md), [adopt-into-existing-project.md](adopt-into-existing-project.md), [living-product-doc.md](living-product-doc.md), [setup-scaffolds-project.md](setup-scaffolds-project.md), [landing-publishing.md](landing-publishing.md), [adaptive-setup-questions.md](adaptive-setup-questions.md), [idea-inbox.md](idea-inbox.md), [spec-driven-work.md](spec-driven-work.md), and [lifecycle-cli.md](lifecycle-cli.md); the 2026-07-10 cluster refined [living-product-doc.md](living-product-doc.md), [landing-publishing.md](landing-publishing.md), [setup-scaffolds-project.md](setup-scaffolds-project.md), and [audience-aware-changelogs.md](audience-aware-changelogs.md))*
