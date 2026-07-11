> [!NOTE]
> Arquivo gerado — tradução de [`templates/requirements/REQUIREMENT_PROJECT_CLI.md`](../../../requirements/REQUIREMENT_PROJECT_CLI.md). O inglês é a fonte de verdade; não edite esta tradução manualmente. Regenerada pela skill `translate-templates`.

# Requisito Geral: A CLI do Projeto

> A porta única para o ciclo de vida de um projeto guiado por charter. Referenciada pelo *Scaffolding no Setup* do charter; um projeto real ou uma toolchain compartilhada constrói a ferramenta — este documento a especifica.

## Princípio

Uma única ferramenta cobre todo o ciclo de vida, para que os passos rodem na ordem certa e nada seja pulado em silêncio.
A CLI é **interativa e prompt-first**, no estilo da CLI `claude` — uma conversa, não um lote de flags.
Ela é um **orquestrador fino e determinístico sobre o Claude e as skills embutíveis**: é dona da superfície de comandos, do tratamento de argumentos e dos rituais de ordenação; os passos que exigem julgamento rodam como conversas com o Claude e skills por baixo. As fases conversacionais do charter permanecem a autoridade no julgamento; a CLI operacionaliza o scaffolding determinístico, a fiação e o sequenciamento ao redor delas.

## Superfície de comandos

Todo projeto expõe estes subcomandos (as flags exatas são escolha da implementação):

| Comando | Contrato |
|---|---|
| `setup` | Roda a entrevista de Setup (passo 0) — Parâmetros do Projeto, stack de tecnologia, público-alvo, skin da landing — e **faz o scaffolding** do projeto: esqueleto + configuração para a stack escolhida, um `CLAUDE.md` que referencia o charter, e um `.claude/memory/` semeado. Entrega o *Scaffolding no Setup* do charter. |
| `adopt` | Traz as práticas para um projeto **existente** via o merge não-destrutivo do `GUIDE_ADOPTION.md`: inventaria as instruções existentes → propõe o merge → aplica sob aprovação. Nunca sobrescreve; todo conflito é exposto ao owner. |
| `update-docs` | Roda o pipeline de documentação guiado por delta a partir de um marcador versionado de último-commit-processado: changelogs técnico + do público → documento vivo do produto → landing page, terminando no loop de aprovação de publicação (intenção → preview → aprovação → publicação). Avança o marcador quando conclui. |
| `graduate-idea` | Conduz uma entrada do `ideas/inbox.md` pela sua rodada de Q&A até uma spec acordada + entrada no roadmap — a skill `graduate-idea` exposta como comando. |

## Invariantes (obrigatórias em qualquer implementação)

- **Interativa, prompt-first.** Modelada na `claude`: os passos que exigem julgamento rodam como conversas com o Claude que a CLI conduz — ela sequencia e faz a fiação, não os substitui.
- **Um orquestrador fino, não um segundo cérebro.** A CLI é dona da superfície de comandos, do tratamento de argumentos e dos rituais de ordenação (ex.: assemble → update-docs → translate → changelog). O julgamento fica nas fases do charter e nas skills.
- **Invoca as skills; nunca as absorve.** Cada subcomando **invoca** a skill embutível correspondente (`graduate-idea`, `update-product-doc`, …), que continua usável de forma autônoma dentro do Claude Code. A CLI é um segundo ponto de entrada para as mesmas skills, não uma reimplementação delas.
- **Os rituais rodam na ordem, nada é pulado.** A CLI garante a sequência para que nenhum passo — assemble, translate, changelog, refresh da landing — seja descartado em silêncio.
- **O hook de pre-commit continua sendo a rede de segurança.** A CLI é o caminho feliz que roda os rituais na ordem; o hook de freshness do repositório permanece como uma **rede de segurança** que barra um commit que pulou um passo (ex.: um feito sem a CLI). CLI e hook são cinto-e-suspensório, não um-ou-outro.
- **A config é versionada no repositório.** O estado local da CLI — o marcador de último-commit-processado, os tokens de skin da landing, as escolhas de stack registradas — vive sob `.claude/`, versionado com o código (consistente com a *Memória versionada, dentro do repositório* do charter). Um clone recém-feito carrega tudo o que a CLI precisa.
- **A publicação passa pelo loop de aprovação.** O `update-docs` nunca publica a landing em silêncio: declaração de intenção → preview renderizado → aprovação do owner → publicação.

## Não-objetivos (fora do escopo deste requisito)

- **Distribuição & runtime.** A linguagem de implementação, o caminho de instalação e o empacotamento da CLI são escolha do projeto que a constrói, deliberadamente não especificados aqui.
- **Flags exatas e formato do arquivo de config.** Os contratos dos subcomandos são fixos; a superfície precisa de flags e o formato em disco da config são detalhes de implementação.
- **Substituir o julgamento.** A CLI não toma decisões de produto, escopo ou arquitetura; essas ficam nas rodadas de Q&A do charter.
- **Uma fonte de verdade paralela.** A CLI lê e avança a mesma memória do repositório, changelogs e specs; não introduz um armazenamento próprio.

## Definição de pronto

Um desenvolvedor com um checkout recém-feito consegue:

1. Fazer `setup` de um novo projeto e obter um esqueleto **que roda, com scaffolding** ligado a um charter e um `.claude/memory/` semeado.
2. Fazer `adopt` das práticas em um repositório existente **sem perder suas instruções**.
3. Rodar `update-docs` para regenerar os changelogs, o documento vivo e a landing a partir do delta desde a última execução, e publicar **somente após aprovação**.
4. Rodar `graduate-idea` para transformar uma nota do inbox em uma spec acordada + entrada no roadmap.

Cada comando roda sua skill ou fase de charter por baixo; nenhum pula um passo do ritual em silêncio. A CLI nunca consome mais esforço do que o projeto que serve.
