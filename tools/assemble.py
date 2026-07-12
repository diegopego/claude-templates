#!/usr/bin/env python3
"""Deterministic charter assembler.

Composes self-contained charters from templates/charters/sources/
(CHARTER_CORE.md + modules, per charters.manifest.md). Same sources ->
same output, byte for byte; this is the engine behind `make assemble`,
`make new` (module composition at install time), the assemble-charters
skill, and the pre-commit freshness check.

Usage:
  tools/assemble.py --all [--outdir DIR]
  tools/assemble.py --charter greenfield|legacy [--modules a,b] --out FILE

Module short names: product-audience, living-docs.
"""

import argparse
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
SOURCES = REPO / "templates" / "charters" / "sources"
CORE = SOURCES / "CHARTER_CORE.md"
MANIFEST = SOURCES / "charters.manifest.md"

CHARTER_KEYS = {
    "CHARTER_GREENFIELD.md": "greenfield",
    "CHARTER_LEGACY_TRANSFORMATION.md": "legacy",
}
MODULE_ALIASES = {
    "product-audience": "MODULE_PRODUCT_AUDIENCE.md",
    "living-docs": "MODULE_LIVING_DOCS.md",
}
# Slots whose contents accumulate across modules instead of last-wins.
APPEND_SLOTS = {"project_parameters_extra"}

SLOT_RE = re.compile(r"<!-- SLOT: ([a-z0-9_]+) -->")
VAR_RE = re.compile(r"\{\{ ([a-z0-9_]+) \}\}")


def parse_module(path: Path):
    """Return (vars: dict, slots: dict) from a MODULE_*.md file."""
    variables, slots = {}, {}
    section = None  # None | "VARS" | slot name
    buf = []

    def flush():
        nonlocal buf
        if section and section != "VARS":
            # Trim leading/trailing BLANK LINES only — trailing spaces on the
            # last content line are significant for inline slots.
            while buf and not buf[0].strip():
                buf.pop(0)
            while buf and not buf[-1].strip():
                buf.pop()
            slots[section] = "\n".join(buf)
        buf = []

    for line in path.read_text(encoding="utf-8").splitlines():
        if line.startswith("==="):
            flush()
            marker = line.strip("= ").strip()
            if marker == "VARS":
                section = "VARS"
            elif marker.startswith("SLOT:"):
                section = marker.split(":", 1)[1].strip()
            else:
                section = None
            continue
        if section == "VARS":
            if "=" in line and line.strip():
                name, value = line.split("=", 1)
                variables[name.strip()] = value.strip()
        elif section is not None:
            buf.append(line)
    flush()
    return variables, slots


def merge(modules):
    """Merge (vars, slots) over the module list; later wins, APPEND_SLOTS accumulate."""
    variables, slots = {}, {}
    for path in modules:
        mod_vars, mod_slots = parse_module(path)
        variables.update(mod_vars)
        for name, text in mod_slots.items():
            if name in APPEND_SLOTS and name in slots and slots[name] and text:
                slots[name] = slots[name] + "\n" + text
            else:
                slots[name] = text
    return variables, slots


def strip_header(text: str) -> str:
    """Drop the source-only leading HTML comment block."""
    lines = text.splitlines()
    if lines and lines[0].startswith("<!--"):
        for i, line in enumerate(lines):
            if line.rstrip().endswith("-->"):
                lines = lines[i + 1:]
                break
    while lines and not lines[0].strip():
        lines.pop(0)
    return "\n".join(lines)


def expand_slots(text: str, slots: dict) -> str:
    out = []
    for line in text.splitlines():
        parts = SLOT_RE.split(line)
        if len(parts) == 1:
            out.append(line)
            continue
        # parts = [prefix, name, mid, name, ..., suffix]
        pieces, names = parts[0::2], parts[1::2]
        contents = [slots.get(n, "") for n in names]
        if all("\n" not in c for c in contents):
            joined = pieces[0]
            for content, piece in zip(contents, pieces[1:]):
                joined += content + piece
            # A line that held only empty slot(s) is dropped entirely.
            if joined.strip():
                out.append(joined)
            continue
        # Block content: emit prefix (if any), the block, then the suffix
        # on its own line separated by a blank line.
        prefix, suffix = pieces[0], pieces[-1]
        if prefix.strip():
            out.append(prefix)
        for i, content in enumerate(contents):
            if content:
                out.extend(content.splitlines())
                out.append("")  # breathing room; collapsed later
        if suffix.strip():
            out.append(suffix)
    return "\n".join(out)


def substitute_vars(text: str, variables: dict) -> str:
    def repl(match):
        name = match.group(1)
        if name not in variables:
            raise KeyError(f"undefined variable {{{{ {name} }}}}")
        return variables[name]
    return VAR_RE.sub(repl, text)


def collapse_blanks(text: str) -> str:
    lines, out, blank = text.splitlines(), [], False
    for line in lines:
        if line.strip() == "":
            if not blank:
                out.append("")
            blank = True
        else:
            out.append(line)
            blank = False
    while out and out[-1] == "":
        out.pop()
    return "\n".join(out) + "\n"


def number_sections(text: str) -> str:
    out, n = [], 0
    for line in text.splitlines():
        if line.startswith("## ") and not line.startswith("## Project Parameters"):
            n += 1
            line = f"## {n}. {line[3:]}"
        out.append(line)
    return "\n".join(out) + "\n"


def compose(module_paths):
    variables, slots = merge(module_paths)
    text = strip_header(CORE.read_text(encoding="utf-8"))
    text = expand_slots(text, slots)
    text = substitute_vars(text, variables)
    text = collapse_blanks(text)
    text = number_sections(text)
    leftover = SLOT_RE.search(text) or VAR_RE.search(text)
    if leftover:
        raise SystemExit(f"assembly error: unresolved marker {leftover.group(0)!r}")
    return text


def parse_manifest():
    """Return {composed_filename: [module Paths]} from the manifest table."""
    rows = {}
    for line in MANIFEST.read_text(encoding="utf-8").splitlines():
        cells = [c.strip() for c in line.strip().strip("|").split("|")]
        if len(cells) < 4 or not cells[0].startswith("`CHARTER_"):
            continue
        composed = cells[0].strip("`")
        modules = re.findall(r"`(MODULE_[A-Z_]+\.md)`", "|".join(cells[2:]))
        rows[composed] = [SOURCES / m for m in modules]
    if not rows:
        raise SystemExit("assembly error: no charter rows found in the manifest")
    return rows


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--all", action="store_true", help="regenerate every composed charter per the manifest")
    ap.add_argument("--outdir", type=Path, default=REPO / "templates" / "charters")
    ap.add_argument("--charter", choices=["greenfield", "legacy"])
    ap.add_argument("--modules", default="", help="comma-separated add-on short names")
    ap.add_argument("--out", type=Path)
    args = ap.parse_args()

    rows = parse_manifest()

    if args.all:
        args.outdir.mkdir(parents=True, exist_ok=True)
        for composed, modules in rows.items():
            (args.outdir / composed).write_text(compose(modules), encoding="utf-8")
            print(f"assembled {args.outdir / composed}")
        return

    if not args.charter or not args.out:
        ap.error("--charter and --out are required unless --all is given")
    composed_name = next(name for name, key in CHARTER_KEYS.items() if key == args.charter)
    modules = list(rows[composed_name])
    for short in filter(None, (s.strip() for s in args.modules.split(","))):
        if short not in MODULE_ALIASES:
            raise SystemExit(f"unknown module '{short}' (known: {', '.join(sorted(MODULE_ALIASES))})")
        path = SOURCES / MODULE_ALIASES[short]
        if path not in modules:
            modules.append(path)
    args.out.parent.mkdir(parents=True, exist_ok=True)
    args.out.write_text(compose(modules), encoding="utf-8")
    print(f"assembled {args.out}")


if __name__ == "__main__":
    main()
