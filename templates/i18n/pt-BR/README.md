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

## Traduções (`i18n/`)

Versões em português do Brasil geradas de cada template, espelhando a árvore inglesa sob `i18n/pt-BR/`. Os arquivos em inglês são a fonte de verdade; edite-os e regenere as traduções (veja o `CLAUDE.md` do repositório). Nunca edite uma tradução à mão.

## Skills (`skills/`)

Reservado para futuros templates de skills embarcáveis. Eles vivem aqui — nunca em `.claude/skills/` — exatamente para permanecerem inertes neste repositório.
