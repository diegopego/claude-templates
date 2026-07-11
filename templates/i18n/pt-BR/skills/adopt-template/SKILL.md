> [!NOTE]
> Arquivo gerado — tradução de [`templates/skills/adopt-template/SKILL.md`](../../../../skills/adopt-template/SKILL.md). O inglês é a fonte de verdade; não edite esta tradução manualmente. Regenerada pela skill `translate-templates`.

---
name: adopt-template
description: Adota estes templates em um projeto existente sem perder suas instruções atuais — inventaria o `CLAUDE.md` do projeto (e quaisquer docs de convenção), classifica cada seção do charter e cada requisito como manter/adaptar/já-coberto/pular, leva todo conflito ao dono e então produz um `CLAUDE.md` mesclado e um `.claude/memory/` semeado. Use quando o dono pedir para adotar, trazer ou mesclar estes templates em um projeto que já existe.
---

# adopt-template

> **Template de skill embutível.** Copie este diretório para o `.claude/skills/adopt-template/` do projeto alvo, com o conjunto de templates (charters, requisitos, `guides/GUIDE_ADOPTION.md`) disponível no working set. O agente então a roda quando o dono pedir para adotar os templates. Esta nota é inofensiva se deixada no lugar.

Esta skill conduz o **Guia de Adoção** (`GUIDE_ADOPTION.md`) — o merge não-destrutivo que traz as práticas dos templates para um projeto que **já existe e já funciona**, que pode ou não já usar o Claude, **sem perder as instruções que ele já tem**. O sistema rodando não é tocado para satisfazer um template; apenas sua camada de instrução e prática é reconciliada e estendida. O guia é a autoridade; esta skill é como você o executa, passo a passo, com o dono decidindo.

## Quando rodar

Quando o dono pedir para adotar / trazer / mesclar / "configurar estes templates em" um projeto que já existe. A adoção é uma reconciliação única da camada de instrução, não um trabalho contínuo — rode-a uma vez por projeto, depois remova a skill ou deixe-a inerte.

## O que fazer

Siga o merge não-destrutivo do guia. Leia o `GUIDE_ADOPTION.md` primeiro se ele estiver no working set — estes passos o espelham.

1. **Inventário primeiro, antes de tocar em qualquer coisa.** Leia toda fonte de instrução existente: `CLAUDE.md`, `AGENTS.md`, `.cursorrules`, `CONTRIBUTING` e quaisquer docs de convenção ad-hoc. Catalogue as regras atuais. **Se o inventário não achar nada** — o projeto ainda não usa Claude — não há merge a fazer: pule para *Sem instruções existentes* abaixo.

2. **Escolha o charter que se encaixa, depois classifique cada seção contra o projeto.** Escolha o `CHARTER_GREENFIELD.md` para trabalho contínuo de novas features, ou o `CHARTER_LEGACY_TRANSFORMATION.md` se o próprio projeto está substituindo um sistema legado. Para **cada seção desse charter e cada requisito**, registre exatamente uma disposição:
   - **manter como está** — o projeto não tem equivalente; adote a versão do template literalmente;
   - **adaptar** — o projeto já faz isso informalmente; reformule a regra existente na formulação do template, mantendo as especificidades do projeto;
   - **já coberto** — a instrução do projeto é equivalente ou melhor; deixe-a, anote a sobreposição;
   - **pular** — não se aplica; registre o *porquê*, para que a decisão fique legível.

   O template é um cardápio, não um mandato. Um **pular** é registrado, não descartado — pode ir para o roadmap depois.

3. **Conflitos: sempre pergunte.** Quando uma instrução existente conflita com uma prática do template, **pare e leve ao dono com uma recomendação** — agrupado com as outras perguntas em aberto, na rodada de Q&A que o charter define em *Trabalhando por perguntas*. Nenhum lado vence automaticamente: nada é sobrescrito em silêncio, nada é mantido em silêncio.

4. **Separe as duas camadas — e nunca as cruze durante o merge.**
   - **Adoção da camada de instrução** (merge do `CLAUDE.md`, convenções de memória, estrutura de roadmap / decision log) é segura e imediata: muda como o agente trabalha, não como o software roda. Faça-a agora.
   - **Adoção de prática que mudaria código ou infraestrutura** (o requisito de appliance portátil, uma metodologia de testes, uma migração de stack) **não acontece durante o merge.** Vira trabalho incremental aprovado pelo dono, semeado no roadmap. O sistema rodando não é editado para satisfazer um template.

5. **Produza a saída.**
   - Um **`CLAUDE.md` mesclado** que sobrepõe as práticas adotadas do template às instruções preservadas do projeto.
   - Um **`.claude/memory/`** semeado: um `roadmap.md` separando *adotado agora* de *adiado*, um `decisions.md`, e um índice `MEMORY.md`.
   - Uma **entrada de decision log** registrando, por seção, o que foi mantido / adaptado / pulado e por quê. A adoção em si é rastreável.

6. **Prove pelo funcionamento.** Depois do merge de instrução, confirme que o projeto ainda buildar e seus testes ainda passam **exatamente como antes** — a adoção se prova pelo projeto continuar funcionando, não pelo merge parecer limpo.

## Definição de pronto

- Toda seção de charter e todo requisito têm uma disposição registrada (manter / adaptar / já-coberto / pular-com-motivo).
- Nenhuma instrução existente foi alterada sem o dono decidir o conflito.
- `CLAUDE.md` e `.claude/memory/` refletem o resultado mesclado; o decision log o explica.
- O projeto buildar e passa nos testes exatamente como antes do merge.
- A adoção de práticas de código / infra vive no roadmap, não em edições-surpresa no sistema rodando.

## Regras

- **Não-destrutivo, sempre.** Nunca sobrescreva uma instrução existente em silêncio e nunca force uma seção do template que não se encaixa. O projeto existente é a fonte de verdade sobre o que funciona; os templates oferecem práticas mais bem articuladas para complementá-lo.
- **Conflitos vão para o dono.** Todo conflito é levantado com uma recomendação e resolvido pelo dono — é o mesmo alinhamento guiado por Q&A que os charters prescrevem.
- **Não toque no sistema rodando.** Mudanças de código e infraestrutura são itens de roadmap para aprovação futura, nunca parte do merge.
- **Respostas viram artefatos.** Toda disposição e todo conflito resolvido vai para o decision log ou a memória semeada — rastreável a esta adoção.
- **Artefatos em inglês.** O `CLAUDE.md` mesclado, as entradas de decisão, o roadmap e o índice de memória seguem o protocolo de idiomas do projeto (inglês por padrão); só um rascunho voltado ao dono pode estar em outro idioma.
- **Sem commits sem autorização.** Prepare os arquivos mesclados e pare; commitar exige o aval explícito e por instância do dono.
