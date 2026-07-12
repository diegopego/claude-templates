# Upgrade ergonomics — a command for the diff, a date for the unstamped

Status: incorporated (2026-07-12 — `make upgrade` in the installer, the timestamp rule in `GUIDE_ADOPTION.md` step 1 and the skill's Upgrade branch)
Applies to: the installer (`Makefile`, `tools/install.sh`), `templates/guides/GUIDE_ADOPTION.md`, `templates/skills/adopt-template/SKILL.md`

Graduated from the two frictions the first real upgrade produced (orderboard, 2026-07-12). The Upgrade branch's *judgment* held up; its *mechanics* were manual.

## Behavior

**1. `make upgrade DEST=… ` — installs nothing.**
Run from a clone of the template repository against a project that already adopted:

- reads the project's stamp, `DEST/.claude/memory/template-version.md`;
- prints the **template files that changed** between that commit and the clone's `HEAD`, and the new commit to stamp;
- if the project has **no stamp**, resolves the source commit by date (below) and says so;
- **copies nothing into `DEST`** — no `agent/` kit, so nothing to tear down afterwards.

`make adopt` is unchanged: it still delivers the kit, because an adopter without the templates clone needs the text on disk. An upgrade needs a diff, not a copy.

**2. An unstamped instance is dated, not investigated.**
Every project predating the stamp still knows *when* it adopted — its own git history has the `Adopt…` commit. The source is the templates commit that was `HEAD` **at that instant**:

```sh
git -C <project>   log -1 --format=%cI --grep='[Aa]dopt'      # 2026-07-12T01:35:32-03:00
git -C <templates> rev-list -1 --before=2026-07-12T01:35:32-03:00 HEAD   # -> 29468ef
```

The **instant**, not the day: a template repo can ship several commits in one day, so a date-granular bound resolves to the last of them — text the project never saw. (This is not theoretical. The first cut of `make upgrade` bounded by date, and on orderboard it resolved to *today's* HEAD and cheerfully reported "already up to date"; the timestamp bound reproduces `29468ef`, the commit found by hand.)

`make upgrade` does this automatically when the stamp is missing. The agent shows the resulting diff summary to the owner and confirms before writing the stamp — a wrong bound yields a visibly wrong diff, so the confirmation is cheap and the failure is loud. When the timestamp resolves to nothing (a project that applied an old kit long after it was cut), fall back to a content search: `git log -S "<a characteristic phrase from a charter section>" -- templates/`.

## Why

The first upgrade worked, but two of its steps were done by hand: finding orderboard's source commit meant cross-referencing its git dates against the templates' history and recognizing feature signals ("its skills were installed by a template-side fix — that only exists from `29468ef` on"). The owner cannot be asked for a SHA; he does not know one. A rule that depends on the agent being clever is a rule that fails on a tired Tuesday.

And the kit: `make adopt` delivers `agent/`, the merge tears it down. On an *upgrade*, with the clone already on the machine, that round trip buys nothing — the reconciliation reads a diff between two commits, and both are in the clone.

## Example

```
$ make upgrade DEST=~/devel/nogueira/orderboard
Upgrade check for ~/devel/nogueira/orderboard (nothing will be installed)

  stamped at   29468ef (2026-07-11)   legacy charter, modules: living-docs
  clone is at  3e09fd2 (2026-07-12)

Template text changed between them:
  templates/guides/GUIDE_ADOPTION.md
  templates/skills/adopt-template/SKILL.md
  templates/skills/README.md

No charter, module, or requirement changed — nothing to fold into CLAUDE.md.
Next: open Claude Code in the project and say "Upgrade the templates in this project."
```

## Open questions

- None.
