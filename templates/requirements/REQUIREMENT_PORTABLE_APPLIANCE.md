# General Requirement: Applications as Portable Appliances

> Applies to every application in this workspace unless a project states otherwise.

## Principle

The server is disposable. The backup is the system.
Every application must be destroyable and rebuildable on a fresh machine from: repository + secrets + backup.

## Acceptance criterion (definition of done)

A person with no prior context, following only the README, must be able to:

1. Provision the system on a fresh machine (VM, VPS, or bare metal) with a few commands.
2. Restore a backup and have a working system with intact data.
3. Complete 1 + 2 in under 30 minutes.

The restore flow must be exercised, not merely documented. A backup that has never been restored does not count as a backup.

## Invariants (mandatory in any stack)

- **Data outlives containers.** Persistent state lives in explicit volumes on the host. No data may depend on a container's lifecycle.
- **Backups are logical and portable.** A single artifact containing: logical database dump + persistent files + metadata (versions, date, app). Restorable on another host/provider.
- **Secrets are part of the system.** They must survive host loss (secrets manager, vault, or documented procedure). Restore must explicitly declare which secrets it requires.
- **External state is documented.** DNS, TLS, networking, firewall: everything living outside containers that migration depends on must be listed in the README.
- **Portable across providers.** No mandatory dependency on a specific cloud, managed database, or heavyweight orchestrator.

## Standard operational interface

Every project exposes these commands (Makefile, bin/, or rake — per project):

| Command    | Contract |
|------------|----------|
| `setup`    | Validates and prepares the target machine (dependencies, volumes, networking). |
| `deploy`   | Publishes the application; brings up/validates accessory services and volumes. |
| `backup`   | Produces the single, verifiable backup artifact. |
| `restore`  | Restores the artifact on a fresh machine; fails with a clear message if a prerequisite is missing. |
| `transfer` | Machine-to-machine migration = backup + copy + restore. Composition, not a new feature. |
| `doctor`   | Diagnostics: dependencies, connectivity, volumes, secrets, versions, permissions. |

Backup artifact contract: declare consistency (transactional dump or app paused) and version compatibility (e.g., a Postgres N dump restores on N or N+1).

## Default stack (overridable per project)

- Deploy: **Kamal** + Docker.
- Database: **PostgreSQL** as a Kamal accessory, with a persistent volume on the host.
- Accessories are managed separately from app deploys; no zero-downtime assumptions.
- Backup/restore/transfer are **not** Kamal features — the project implements them.

## Non-goals (do not implement unless explicitly requested)

- Kubernetes, Nomad, Swarm, Coolify, CapRover.
- High availability, zero-downtime database, replication, automatic failover.
- `doctor` as continuous monitoring (it is a point-in-time diagnostic).
- Sophisticated backup rotation/retention in prototypes (documenting off-host copies is enough).

## Priority in prototypes

1. `deploy` + `backup` + `restore` — these prove the appliance thesis.
2. `transfer` — composition of the above.
3. `doctor` — may start as a README checklist and become a command later.

The appliance layer must never consume more effort than the application itself.
