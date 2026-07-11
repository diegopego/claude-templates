> [!NOTE]
> Arquivo gerado — tradução de [`templates/skills/graduate-idea/SKILL.md`](../../../../skills/graduate-idea/SKILL.md). O inglês é a fonte de verdade; não edite esta tradução manualmente. Regenerada pela skill `translate-templates`.

---
name: graduate-idea
description: Gradua uma ideia crua do `ideas/inbox.md` em uma spec de verdade — roda uma rodada de Q&A para resolver toda pergunta que muda o resultado, registra as decisões, redige a spec, adiciona-a ao roadmap e remove a entrada do inbox. Use quando o dono pedir para graduar, promover, formalizar ou "specar" uma ideia do inbox.
---

# graduate-idea

> **Template de skill embutível.** Copie este diretório para o `.claude/skills/graduate-idea/` do seu projeto; o agente então a roda sempre que o dono pedir para graduar uma ideia do inbox. Esta nota é inofensiva se deixada no lugar.

O projeto mantém um **inbox de ideias** em `ideas/inbox.md` — o rascunho do dono para ideias meio-formadas (veja a seção *Inbox de ideias* do charter). Capturar uma ideia é um append de uma linha e não precisa de skill. **Graduar** uma é o passo valioso, e esta skill o conduz: uma nota crua vira uma spec bem-formada, com suas decisões rastreáveis, e conquista um lugar no roadmap.

## Quando rodar

Quando o dono pedir para graduar / promover / formalizar / "specar" uma entrada específica do inbox. Só aquela entrada — nunca gradue, reorganize, reescreva ou apague uma entrada que o dono não nomeou.

## O que fazer

1. **Localize a entrada** que o dono nomeou em `ideas/inbox.md`. Se estiver ambíguo qual é, pergunte.
2. **Rode uma rodada de Q&A** — a que seu charter define em *Trabalhando por perguntas*. Levante **toda pergunta que mudaria o resultado da ideia**, agrupadas em uma rodada, cada uma com as opções que você enxerga e sua recomendação. Comece pelas perguntas que você já sabe que precisa fazer (a linha de base roteirizada), depois adicione desdobramentos que as respostas revelarem (adaptativo). Pare quando não restar pergunta que o dono considere bloqueante. *Se a ideia não tiver perguntas que mudam o resultado, pule direto para o passo 4.*
3. **Registre as resoluções** em `.claude/memory/decisions.md` — uma entrada: o que foi decidido, por quê, e a alternativa rejeitada mais forte. As decisões são registradas **antes** de a spec ser redigida, para que a spec reflita terreno já assentado.
4. **Redija a spec** no formato que seu charter prescreve para suas specs fonte-ouro (greenfield *specs* / legacy *padrões-ouro*), no local de specs do projeto. Reflita toda pergunta resolvida; liste as genuinamente residuais em *Perguntas abertas*. Um esqueleto padrão útil quando o projeto não tiver um: uma linha `Status:` (`draft | agreed | incorporated`), uma linha `Applies to:`, então **Comportamento** ("quando X, o agente/sistema deve Y") · **Por quê** · **Exemplo** · **Perguntas abertas**. A spec alcança `agreed` quando nenhuma pergunta que muda o resultado permanece em aberto.
5. **Remova a entrada graduada** do `ideas/inbox.md` **na mesma alteração** — a graduação move a ideia, não a copia.
6. **Adicione a spec ao `.claude/memory/roadmap.md`** como escopo aceito. O inbox propõe escopo; o roadmap o aceita.

## Regras

- **Só sob comando do dono.** Nunca gradue uma entrada sem ser pedido, e nunca toque em outras entradas do inbox ao graduar uma.
- **Capturar não é esta skill.** Anotar uma ideia nova no inbox é um simples append de uma linha — não invoque a graduação para isso.
- **Respostas viram artefatos.** Toda pergunta resolvida vai para `decisions.md`, a spec ou a memória do repositório — rastreável a esta rodada. Uma resposta não escrita não aconteceu.
- **Artefatos em inglês.** A spec, a entrada de decisão e a linha do roadmap são em inglês (pelo protocolo de idiomas); só o próprio inbox pode estar em qualquer idioma.
- **Sem commits sem autorização.** Prepare a alteração (spec, decisões, roadmap, edição do inbox) e pare; commitar exige o aval explícito e por instância do dono.
