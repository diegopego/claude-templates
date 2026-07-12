# Inbox

The owner's scratchpad. Jot rough ideas here in any language, any quality — this is the one file in the repo exempt from the artifact-language rule.

An entry **graduates** when it becomes a proper spec in this directory (`Status: draft`); remove it from the inbox in the same change. The agent never reorganizes, rewrites, or deletes inbox entries on its own — graduation happens only when the owner asks.

---

## Carimbar retroativamente exige trabalho de detetive (fricção do primeiro upgrade real, orderboard, 2026-07-12)

O ramo de upgrade manda: "sem stamp mas claramente instância antiga → confirme com o dono de qual charter e módulos veio, e carimbe". Na prática o charter e os módulos deu para inferir do CLAUDE.md dele em segundos. **O commit de origem, não.** Tive que cruzar as datas do git do orderboard com o histórico do claude-templates e reconhecer pistas de feature ("as skills foram instaladas por um fix template-side" → só existe a partir de 29468ef) para chegar num SHA. O dono não sabe um SHA de cor — perguntar a ele não resolve.

Direções: um comando/heurística que localize o commit de origem comparando o texto do charter adotado contra o histórico dos templates (`git log -S` numa frase característica de cada seção), ou aceitar um carimbo aproximado ("não anterior a X") e diffar por baixo, ou simplesmente reconhecer que a primeira re-adoção de uma instância sem carimbo é um custo único — carimbe com o commit atual e siga.

## Para um upgrade, entregar o kit é churn (fricção, orderboard, 2026-07-12)

O `make adopt` entrega um kit em `agent/` que o merge desmonta no fim. Num **upgrade**, com o clone dos templates na mesma máquina, o kit é puro ida-e-volta: o que eu precisei foi `git diff <stamp>..HEAD -- templates/` direto no clone — nem instalei o kit no orderboard. O guia e a skill ainda pressupõem o kit (o `TEMPLATE_VERSION.md` dele é a "outra ponta" do diff). Talvez um `make upgrade DEST=…` que não instale nada e só imprima o diff + o commit atual, ou o guia dizendo explicitamente "se você tem o clone dos templates, o diff basta; o kit só existe para quem não tem".

*(empty — jot the next rough idea here)*

*(previous entries graduated to [language-setup.md](language-setup.md), [audience-aware-changelogs.md](audience-aware-changelogs.md), [product-not-bespoke.md](product-not-bespoke.md), [adopt-into-existing-project.md](adopt-into-existing-project.md), [living-product-doc.md](living-product-doc.md), [setup-scaffolds-project.md](setup-scaffolds-project.md), [landing-publishing.md](landing-publishing.md), [adaptive-setup-questions.md](adaptive-setup-questions.md), [idea-inbox.md](idea-inbox.md), [spec-driven-work.md](spec-driven-work.md), and [lifecycle-cli.md](lifecycle-cli.md); the 2026-07-10 cluster refined [living-product-doc.md](living-product-doc.md), [landing-publishing.md](landing-publishing.md), [setup-scaffolds-project.md](setup-scaffolds-project.md), and [audience-aware-changelogs.md](audience-aware-changelogs.md); the two 2026-07-11 adoption frictions graduated together to [template-upgrade.md](template-upgrade.md))*
