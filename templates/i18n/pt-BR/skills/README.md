> [!NOTE]
> Arquivo gerado — tradução de [`templates/skills/README.md`](../../../skills/README.md). O inglês é a fonte de verdade; não edite esta tradução manualmente. Regenerada pela skill `translate-templates`.

# Templates de Skills

**Templates de skills** embutíveis — skills reutilizáveis do Claude Code que um projeto adotante copia para o próprio `.claude/skills/`. Elas vivem aqui, nunca no `.claude/skills/` deste repositório, exatamente para permanecerem inertes no meta-projeto (uma skill sob `.claude/skills/` seria ativada automaticamente aqui).

## Convenção para um template de skill embutível

Um template de skill é um diretório cujo contrato espelha o de uma skill normal do Claude Code, mais um marcador de que ela é feita para ser copiada:

- **`templates/skills/<name>/SKILL.md`** — um diretório por skill; `<name>` é kebab-case e corresponde ao gatilho de ativação da skill.
- **Frontmatter YAML primeiro** — `name` (o nome kebab-case) e `description` (uma linha, escrita para que o Claude escolha a skill no momento certo: o que ela faz *e* quando usá-la).
- **Uma nota de adoção no topo** — a primeira linha do corpo é um blockquote marcando o arquivo como template e instruindo o adotante a copiar o diretório para `.claude/skills/<name>/`. Escrita para ser inofensiva se deixada no lugar após a cópia.
- **Corpo escrito para o agente do adotante** — as instruções se dirigem ao agente rodando dentro do projeto adotante, referenciando os arquivos daquele projeto (`ideas/inbox.md`, `.claude/memory/`, o charter dele), não nada deste repositório.

Para adotar uma: copie `templates/skills/<name>/` para o `.claude/skills/<name>/` do seu projeto. Essa é toda a instalação.

## Skills disponíveis

- **`graduate-idea/`** — gradua uma ideia crua do `ideas/inbox.md` em uma spec de verdade: roda uma rodada de Q&A para resolver perguntas que mudam o resultado, registra as decisões, redige a spec, adiciona-a ao roadmap e remove a entrada do inbox. Faz par com a prática de *Inbox de ideias* do charter.
- **`adopt-template/`** — traz estes templates para um projeto que já existe, sem perder suas instruções: inventaria o `CLAUDE.md` atual e os docs de convenção, classifica cada seção do charter e cada requisito (manter / adaptar / já-coberto / pular), leva todo conflito ao dono e produz um `CLAUDE.md` mesclado mais um `.claude/memory/` semeado. Automatiza o `guides/GUIDE_ADOPTION.md`.
