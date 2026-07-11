# Inbox

The owner's scratchpad. Jot rough ideas here in any language, any quality — this is the one file in the repo exempt from the artifact-language rule.

An entry **graduates** when it becomes a proper spec in this directory (`Status: draft`); remove it from the inbox in the same change. The agent never reorganizes, rewrites, or deletes inbox entries on its own — graduation happens only when the owner asks.

---

## Re-adoção / upgrade de versão do template em projeto que já adotou uma versão anterior (fricção do Milestone 6, orderboard, 2026-07-11)

Cenário que a adoção de hoje não cobre: o projeto **já adotou uma versão anterior destes templates**. O CLAUDE.md dele já é a instância preenchida e auto-suficiente do charter (de transformação legada, no caso — ele mesmo diz "if the two ever differ, this file wins"), a `.claude/memory/` já segue as convenções, e o kit `agent/` que acabou de entrar traz uma versão **mais nova** do mesmo charter. Não é adoção "do zero" nem "projeto com instruções próprias alheias" — é **reconciliação de versões**: decidir quais articulações mais novas do charter dobrar no CLAUDE.md antes de desmontar o kit.

O `GUIDE_ADOPTION` / `adopt-template` só conhece dois casos ("sem instruções" → seed; "instruções próprias" → merge não-destrutivo). Falta um terceiro: **upgrade de uma instância de template já existente**. Sem ele, o skill trata a instância antiga do nosso próprio charter como se fosse instrução estranha e faz um merge genérico em vez de um diff de versão.

Sub-problema que apareceu e enganou o skill: **decisões de adoções passadas viram lei sem terem sido arquiteturais.** Em orderboard, o `REQUIREMENT_PORTABLE_APPLIANCE` foi removido no commit c55680b "só para evitar conflito" com a tentativa antiga — e foi parar no `decisions.md` como se fosse decisão. O skill releu isso como "skip, não reintroduzir". O dono corrigiu: não foi decisão arquitetural, a tentativa usou uma versão antiga dos templates, quer recomeçar do zero. Ou seja, numa re-adoção as entradas de decision-log da tentativa anterior deveriam ser **provisórias / re-confirmadas**, não vinculantes — sobretudo remoções feitas por conflito.

Direções para uma futura rodada de Q&A:
- **Carimbo de versão** no template (versão/commit no charter composto, ou marcador na instância adotada / `.claude/memory/`) para uma re-adoção detectar "você está na versão X, o kit é a versão Y" e rodar um diff de upgrade em vez de merge do zero.
- **Terceiro modo** em GUIDE_ADOPTION / adopt-template: "upgrade de instância de template existente", distinto de "sem instruções" e "instruções alheias".
- Ao re-adotar, **tratar decisões anteriores como provisórias** (re-confirmar com o dono); talvez marcar, no momento da adoção, o que é conflito-evitado vs. arquitetura genuína, para não fossilizar workarounds.
- Resolução imediata em orderboard: recomeçar do zero (a tentativa anterior era de versão antiga; a remoção do portable-appliance não foi arquitetural) — ignorar o "skip" de c55680b e reavaliar o requirement em branco.

*(empty — jot the next rough idea here)*

*(previous entries graduated to [language-setup.md](language-setup.md), [audience-aware-changelogs.md](audience-aware-changelogs.md), [product-not-bespoke.md](product-not-bespoke.md), [adopt-into-existing-project.md](adopt-into-existing-project.md), [living-product-doc.md](living-product-doc.md), [setup-scaffolds-project.md](setup-scaffolds-project.md), [landing-publishing.md](landing-publishing.md), [adaptive-setup-questions.md](adaptive-setup-questions.md), [idea-inbox.md](idea-inbox.md), [spec-driven-work.md](spec-driven-work.md), and [lifecycle-cli.md](lifecycle-cli.md); the 2026-07-10 cluster refined [living-product-doc.md](living-product-doc.md), [landing-publishing.md](landing-publishing.md), [setup-scaffolds-project.md](setup-scaffolds-project.md), and [audience-aware-changelogs.md](audience-aware-changelogs.md))*
