# Maintainer entry points for claude-templates.
#
# There is no `make new` / `make adopt` / `make upgrade` any more: adoption has
# ONE door, and it is the `adopt-template` skill, run in a Claude Code session in
# this repository with the target project as an additional working directory. The
# skill decides, and calls tools/install.sh for the file operations. Two doors
# meant the owner-facing flow and the agent-facing flow could drift — and they did.
#
# To adopt, upgrade, or start a project, open Claude Code here and say:
#   "adopt the templates into ~/devel/myapp"
#   "upgrade the templates in ~/devel/myapp"
#   "start a new project at ~/devel/myapp"

.PHONY: help assemble refresh-skills

help:
	@echo "claude-templates — maintainer targets"
	@echo ""
	@echo "  make assemble"
	@echo "      Regenerate the shipped composed charters from templates/charters/sources/."
	@echo "      Run after editing any charter source; the pre-commit hook enforces freshness."
	@echo ""
	@echo "  make refresh-skills"
	@echo "      Self-adoption: refresh this repo's working copies of the embeddable skills"
	@echo "      (.claude/skills/) from their sources in templates/skills/. Never edit a working copy."
	@echo ""
	@echo "  Adoption is not a make target. Open Claude Code here and say:"
	@echo "      \"adopt the templates into ~/devel/myapp\"   (existing project)"
	@echo "      \"upgrade the templates in ~/devel/myapp\"   (already adopted, older version)"
	@echo "      \"start a new project at ~/devel/myapp\"     (greenfield)"

assemble:
	python3 tools/assemble.py --all

refresh-skills:
	@sh tools/install.sh adopt . "" ""
