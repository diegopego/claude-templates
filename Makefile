# Installer and maintenance entry points for claude-templates.
# Deterministic file operations only — judgment (Setup Q&A, adoption merge)
# stays with Claude inside the target project.

PREFIX ?= agent

.PHONY: help assemble new adopt upgrade

help:
	@echo "claude-templates — installer"
	@echo ""
	@echo "  make new    DEST=~/devel/myapp CHARTER=greenfield|legacy [MODULES=\"product-audience living-docs data-migration\"] [PREFIX=agent]"
	@echo "      Start a NEW project: compose the charter (with optional add-on modules) into DEST/PREFIX/,"
	@echo "      copy the appliance requirement, and seed CLAUDE.md, .claude/memory/, ideas/inbox.md and the"
	@echo "      graduate-idea skill. Never overwrites; aborts if DEST already has a CLAUDE.md."
	@echo ""
	@echo "  make adopt  DEST=~/devel/existing [PREFIX=agent]"
	@echo "      EXISTING project: copy the template set (charters + all module sources, requirement,"
	@echo "      adoption guide, paired skills) into DEST/PREFIX/, stamped with this repo's commit, plus"
	@echo "      the adopt-template skill. Touches nothing else — the merge (or, for a project already on"
	@echo "      an older version, the upgrade diff) runs later inside Claude, with every conflict raised"
	@echo "      to you."
	@echo ""
	@echo "  make upgrade DEST=~/devel/already-adopted"
	@echo "      A project that already adopted an EARLIER version: read its stamp (or date it from its own"
	@echo "      adoption commit), then print which template text changed since — and what to stamp next."
	@echo "      Installs NOTHING: an upgrade needs a diff, not a copy, so there is no kit to tear down."
	@echo ""
	@echo "  make assemble"
	@echo "      Regenerate the shipped composed charters from templates/charters/sources/ (maintainers)."

assemble:
	python3 tools/assemble.py --all

new:
	@sh tools/install.sh new "$(DEST)" "$(CHARTER)" "$(MODULES)" "$(PREFIX)"

adopt:
	@sh tools/install.sh adopt "$(DEST)" "" "" "$(PREFIX)"

upgrade:
	@sh tools/install.sh upgrade "$(DEST)"
