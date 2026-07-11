# Installer and maintenance entry points for claude-templates.
# Deterministic file operations only — judgment (Setup Q&A, adoption merge)
# stays with Claude inside the target project.

PREFIX ?= agent

.PHONY: help assemble new adopt

help:
	@echo "claude-templates — installer"
	@echo ""
	@echo "  make new    DEST=~/devel/myapp CHARTER=greenfield|legacy [MODULES=\"product-audience living-docs data-migration\"] [PREFIX=agent]"
	@echo "      Start a NEW project: compose the charter (with optional add-on modules) into DEST/PREFIX/,"
	@echo "      copy the appliance requirement, and seed CLAUDE.md, .claude/memory/, ideas/inbox.md and the"
	@echo "      graduate-idea skill. Never overwrites; aborts if DEST already has a CLAUDE.md."
	@echo ""
	@echo "  make adopt  DEST=~/devel/existing [PREFIX=agent]"
	@echo "      EXISTING project: copy the template set (charters, requirement, adoption guide) into"
	@echo "      DEST/PREFIX/ plus the adopt-template skill. Touches nothing else — the non-destructive"
	@echo "      merge runs later, inside Claude, with every conflict raised to you."
	@echo ""
	@echo "  make assemble"
	@echo "      Regenerate the shipped composed charters from templates/charters/sources/ (maintainers)."

assemble:
	python3 tools/assemble.py --all

new:
	@sh tools/install.sh new "$(DEST)" "$(CHARTER)" "$(MODULES)" "$(PREFIX)"

adopt:
	@sh tools/install.sh adopt "$(DEST)" "" "" "$(PREFIX)"
