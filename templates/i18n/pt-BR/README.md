> [!NOTE]
> Arquivo gerado — tradução de [`templates/README.md`](../../README.md). O inglês é a fonte de verdade; não edite esta tradução manualmente. Regenerada pela skill `translate-templates`.

# Catálogo de Templates

Entregáveis deste repositório: documentos autocontidos feitos para serem copiados para um projeto real e referenciados a partir do `CLAUDE.md` daquele projeto. Nada neste diretório é instrução para trabalhar *neste* repositório.

## Charters (`charters/`)

Acordos de trabalho para um agente de codificação por IA. Escolha exatamente um por projeto, copie-o e preencha o bloco **Parâmetros do Projeto**.

- **`CHARTER_GREENFIELD.md`** — construir uma nova aplicação do zero. Não há fonte de verdade legada: a visão é interrogada em rodadas de Q&A, especificações escritas se tornam o padrão-ouro, e o principal risco combatido é construir a coisa errada com confiança.
- **`CHARTER_LEGACY_TRANSFORMATION.md`** — transformar um sistema existente (planilha, app desktop, base de código antiga, processo em papel) em uma aplicação moderna. O sistema legado é a fonte-ouro: o conhecimento é extraído com rastreabilidade, conflitos são arbitrados pelo autor do sistema, e a migração de dados/cutover faz parte da entrega.

## Requisitos (`requirements/`)

Documentos de requisitos transversais, referenciados pelos charters e reutilizáveis por conta própria.

- **`REQUIREMENT_PORTABLE_APPLIANCE.md`** — toda aplicação é um appliance portátil: o servidor é descartável, o backup é o sistema, e `repositório + segredos + backup` deve reconstruir tudo em uma máquina nova em menos de 30 minutos.
- **`REQUIREMENT_PROJECT_CLI.md`** — a CLI de porta única do projeto: uma única ferramenta interativa, no estilo do `claude`, que roda todo o ciclo de vida (`setup` · `adopt` · `update-docs` · `graduate-idea`) como um orquestrador fino sobre o Claude e as skills embutíveis, para que os rituais rodem na ordem e nada seja pulado em silêncio.

## Guias (`guides/`)

Procedimentos para usar os próprios templates.

- **`GUIDE_ADOPTION.md`** — trazer estas práticas para um projeto existente e funcionando sem perder as instruções que ele já tem: um merge não-destrutivo que inventaria o que existe, adapta ou pula seções do template, expõe todo conflito ao owner e mantém o projeto funcionando.

## Traduções (`i18n/`)

Versões em português do Brasil geradas de cada template, espelhando a árvore inglesa sob `i18n/pt-BR/`. Os arquivos em inglês são a fonte de verdade; edite-os e regenere as traduções (veja o `CLAUDE.md` do repositório). Nunca edite uma tradução à mão.

## Skills (`skills/`)

Skills embutíveis do Claude Code que um projeto adotante copia para o próprio `.claude/skills/`. Elas vivem aqui — nunca no `.claude/skills/` deste repositório — exatamente para permanecerem inertes no meta-projeto. Veja `skills/README.md` para a convenção de template de skill.

- **`graduate-idea/`** — gradua uma ideia crua do `ideas/inbox.md` em uma spec de verdade: roda uma rodada de Q&A para resolver toda pergunta que muda o resultado, registra as decisões, redige a spec, adiciona-a ao roadmap e remove a entrada do inbox. Faz par com a prática de *Inbox de ideias* do charter.
