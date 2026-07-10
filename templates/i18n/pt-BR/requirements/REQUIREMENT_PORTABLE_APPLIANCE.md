> [!NOTE]
> Arquivo gerado — tradução de [`templates/requirements/REQUIREMENT_PORTABLE_APPLIANCE.md`](../../../requirements/REQUIREMENT_PORTABLE_APPLIANCE.md). O inglês é a fonte de verdade; não edite esta tradução manualmente. Regenerada pela skill `translate-templates`.

# Requisito Geral: Aplicações como Appliances Portáteis

> Aplica-se a toda aplicação neste workspace, salvo declaração em contrário de um projeto.

## Princípio

O servidor é descartável. O backup é o sistema.
Toda aplicação deve poder ser destruída e reconstruída em uma máquina nova a partir de: repositório + segredos + backup.

## Critério de aceitação (definição de pronto)

Uma pessoa sem contexto prévio, seguindo apenas o README, deve conseguir:

1. Provisionar o sistema em uma máquina nova (VM, VPS ou bare metal) com poucos comandos.
2. Restaurar um backup e ter um sistema funcionando com dados intactos.
3. Completar 1 + 2 em menos de 30 minutos.

O fluxo de restore deve ser exercitado, não apenas documentado. Um backup que nunca foi restaurado não conta como backup.

## Invariantes (obrigatórios em qualquer stack)

- **Os dados sobrevivem aos containers.** Estado persistente vive em volumes explícitos no host. Nenhum dado pode depender do ciclo de vida de um container.
- **Backups são lógicos e portáteis.** Um artefato único contendo: dump lógico do banco + arquivos persistentes + metadados (versões, data, app). Restaurável em outro host/provedor.
- **Segredos fazem parte do sistema.** Devem sobreviver à perda do host (secrets manager, vault ou procedimento documentado). O restore deve declarar explicitamente quais segredos requer.
- **Estado externo é documentado.** DNS, TLS, rede, firewall: tudo que vive fora dos containers e de que a migração depende deve estar listado no README.
- **Portátil entre provedores.** Nenhuma dependência obrigatória de uma nuvem específica, banco gerenciado ou orquestrador pesado.

## Interface operacional padrão

Todo projeto expõe estes comandos (Makefile, bin/ ou rake — por projeto):

| Comando    | Contrato |
|------------|----------|
| `setup`    | Valida e prepara a máquina alvo (dependências, volumes, rede). |
| `deploy`   | Publica a aplicação; sobe/valida serviços acessórios e volumes. |
| `backup`   | Produz o artefato de backup único e verificável. |
| `restore`  | Restaura o artefato em uma máquina nova; falha com mensagem clara se faltar um pré-requisito. |
| `transfer` | Migração máquina-a-máquina = backup + cópia + restore. Composição, não uma feature nova. |
| `doctor`   | Diagnóstico: dependências, conectividade, volumes, segredos, versões, permissões. |

Contrato do artefato de backup: declarar consistência (dump transacional ou app pausado) e compatibilidade de versões (ex.: um dump de Postgres N restaura em N ou N+1).

## Stack padrão (substituível por projeto)

- Deploy: **Kamal** + Docker.
- Banco de dados: **PostgreSQL** como acessório do Kamal, com volume persistente no host.
- Acessórios são gerenciados separadamente dos deploys do app; sem premissas de zero-downtime.
- Backup/restore/transfer **não** são features do Kamal — o projeto os implementa.

## Não-objetivos (não implementar salvo pedido explícito)

- Kubernetes, Nomad, Swarm, Coolify, CapRover.
- Alta disponibilidade, banco com zero downtime, replicação, failover automático.
- `doctor` como monitoramento contínuo (é um diagnóstico pontual).
- Rotação/retenção sofisticada de backups em protótipos (documentar cópias fora do host basta).

## Prioridade em protótipos

1. `deploy` + `backup` + `restore` — estes provam a tese do appliance.
2. `transfer` — composição dos anteriores.
3. `doctor` — pode começar como checklist no README e virar comando depois.

A camada de appliance nunca deve consumir mais esforço do que a própria aplicação.
