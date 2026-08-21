#!/usr/bin/env python3
"""Install the final paper-like SampleWiki casebook stylesheet."""

from __future__ import annotations

import html
import posixpath
import shutil
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "_site"
STYLE_PATH = ROOT / "website" / "static" / "samplewiki-casebook-polish.css"
STYLE_NAME = "samplewiki-casebook-polish.css"


def _href(rel_path: str) -> str:
    start = posixpath.dirname(rel_path) or "."
    return posixpath.relpath(f"assets/{STYLE_NAME}", start=start)


def _inject(path: Path, output: Path) -> None:
    rel_path = path.relative_to(output).as_posix()
    text = path.read_text(encoding="utf-8")
    if STYLE_NAME in text:
        return
    marker = "</head>"
    if marker not in text:
        raise RuntimeError(f"{rel_path}: head marker missing for SampleWiki casebook polish")
    link = f'  <link rel="stylesheet" href="{html.escape(_href(rel_path), quote=True)}">\n'
    path.write_text(text.replace(marker, link + marker, 1), encoding="utf-8", newline="\n")


def enrich_site(output: Path = DEFAULT_OUTPUT) -> None:
    assets = output / "assets"
    assets.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(STYLE_PATH, assets / STYLE_NAME)

    overview = output / "example-cases" / "samplewiki.html"
    if overview.exists():
        _inject(overview, output)

    directory = output / "example-cases" / "samplewiki"
    if directory.exists():
        for path in sorted(directory.rglob("*.html")):
            _inject(path, output)


if __name__ == "__main__":
    enrich_site()
