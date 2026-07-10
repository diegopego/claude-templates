> [!NOTE]
> Arquivo gerado — tradução de [`templates/guides/GUIDE_ADOPTION.md`](../../../guides/GUIDE_ADOPTION.md). O inglês é a fonte de verdade; não edite esta tradução manualmente. Regenerada pela skill `translate-templates`.

# Guia de Adoção — Trazendo os Templates para um Projeto Existente

Um procedimento reutilizável e autocontido para adotar as práticas destes templates em um **projeto que já existe e já funciona** — que pode ou não já usar o Claude — **sem perder as instruções que ele já tem**. O projeto continua rodando; apenas sua camada de instrução e prática é reconciliada e estendida.

Isto não é o charter de legado. O [CHARTER_LEGACY_TRANSFORMATION.md](../charters/CHARTER_LEGACY_TRANSFORMATION.md) extrai o conhecimento de um *sistema de negócio* legado para construir uma aplicação nova, aposentando a antiga. Aqui o projeto de software é o que se preserva — a adoção é um **merge não-destrutivo** da camada de instrução, não uma reescrita.

Para usar: rode este procedimento dentro do repo alvo, com o conjunto de templates disponível. O agente apresenta propostas; o owner decide. Nada aqui anula a regra permanente de que o agente **nunca faz commit sem autorização explícita**.

---

## Princípio

O projeto existente é a fonte de verdade sobre o que funciona. Os templates oferecem práticas mais bem articuladas. A adoção **complementa e adapta** o que existe — nunca sobrescreve em silêncio, e nunca força uma seção do template que não se encaixa.

## O merge não-destrutivo

1. **Inventário primeiro.** Leia o `CLAUDE.md` existente (ou `AGENTS.md`, `CONTRIBUTING`, `.cursorrules`, documentos de convenção ad-hoc) e catalogue as regras atuais *antes de tocar em qualquer coisa*. Se o inventário não achar nada — o projeto ainda não usa Claude — não há merge a fazer: pule para [Sem instruções existentes](#sem-instruções-existentes).

2. **Classifique cada seção do template contra o projeto.** Para cada seção do charter escolhido (e cada requisito), decida e registre uma opção:
   - **manter como está** — adotar a versão do template literalmente (o projeto não tem equivalente);
   - **adaptar** — o projeto já faz isso informalmente; reformule a regra existente na formulação do template, mantendo as especificidades do projeto;
   - **já coberto** — a instrução existente do projeto é equivalente ou melhor; deixe-a, anote a sobreposição;
   - **pular** — não se aplica a este projeto; registre o *porquê*, para que a decisão fique legível depois.

   O template é um cardápio, não um mandato.

3. **Conflitos: sempre pergunte.** Quando uma instrução existente conflita com uma prática do template, **pare e leve ao owner com uma recomendação**. Nenhum lado vence automaticamente — nada é sobrescrito em silêncio, e nada é mantido em silêncio. É o mesmo alinhamento guiado por Q&A que os charters prescrevem.

4. **Separe duas camadas.**
   - **Adoção da camada de instrução** — merge do `CLAUDE.md`, convenções de memória, estrutura de roadmap/decision log — é segura e imediata: muda como o agente trabalha, não como o software roda.
   - **Adoção de prática que muda código ou infraestrutura** — ex.: o requisito de appliance portátil ([REQUIREMENT_PORTABLE_APPLIANCE.md](../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md)), a metodologia de testes, uma migração de stack — **não acontece durante o merge**. Vira trabalho incremental aprovado pelo owner no roadmap. O sistema rodando não é tocado para satisfazer um template.

5. **Produza a saída.**
   - Um **`CLAUDE.md` mesclado** que sobrepõe as práticas adotadas do template às instruções preservadas do projeto.
   - Um **`.claude/memory/`** semeado: um `roadmap.md` separando *adotado agora* de *adiado*, um `decisions.md`, e um índice `MEMORY.md`.
   - Uma **entrada de decision log** registrando, por seção, o que foi mantido / adaptado / pulado e por quê. A adoção em si é rastreável.

6. **Prove pelo funcionamento.** Depois do merge de instrução, o projeto ainda buildar e seus testes ainda passam. A adoção se prova pelo projeto continuar funcionando — não pelo merge parecer limpo.

## Escolhendo o que adotar

- Escolha o charter que corresponde à situação do projeto: [CHARTER_GREENFIELD.md](../charters/CHARTER_GREENFIELD.md) para trabalho contínuo de novas features, [CHARTER_LEGACY_TRANSFORMATION.md](../charters/CHARTER_LEGACY_TRANSFORMATION.md) se o próprio projeto está substituindo um sistema legado.
- Adote requisitos à la carte. Um requisito classificado como **pular** é registrado, não descartado — pode ir para o roadmap depois.

## Sem instruções existentes

Se o inventário do passo 1 não achar arquivos de instrução, não há nada a preservar e nenhum conflito a resolver. A adoção se reduz a: escolher um charter, preencher seus Parâmetros do Projeto, semear `.claude/memory/` (roadmap + decisions + índice) e — para qualquer prática de código/infra — colocá-la no roadmap em vez de aplicá-la imediatamente. A regra das duas camadas (passo 4) e o "prove pelo funcionamento" (passo 6) continuam valendo.

## Definição de pronto

- Toda seção de charter e todo requisito têm uma disposição registrada (manter / adaptar / já-coberto / pular-com-motivo).
- Nenhuma instrução existente foi alterada sem o owner decidir o conflito.
- `CLAUDE.md` e `.claude/memory/` refletem o resultado mesclado; o decision log o explica.
- O projeto buildar e passa nos testes exatamente como antes do merge.
- A adoção de práticas de código/infra vive no roadmap, não em edições-surpresa no sistema rodando.
