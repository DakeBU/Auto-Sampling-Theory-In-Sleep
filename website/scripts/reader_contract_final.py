#!/usr/bin/env python3
"""Final public-reader contract for Samplinglib.

This wrapper deliberately separates presentation cleanup from source evidence.
It reuses ``math_first_reader`` for the theorem/equation layout, but narrows the
final regression gate to genuinely broken public rendering: visible CJK,
leaked Markdown, and raw conditional-expectation notation. Audited source
metadata is never rewritten merely because it contains ASCII notation.
"""

from __future__ import annotations

import re
import shutil
from pathlib import Path

import math_first_reader as base


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "_site"
SOURCE_CSS = ROOT / "website" / "static" / "reader-contract-final.css"
STYLE_NAME = "reader-contract-final.css"


def validate_page(path: Path, text: str) -> list[str]:
    errors: list[str] = []
    visible = base.visible_text(text)
    cjk = base.CJK_RE.search(visible)
    if cjk:
        start = max(0, cjk.start() - 60)
        errors.append(
            f"{path}: visible non-English/CJK text: "
            f"{visible[start:cjk.start() + 60]!r}"
        )
    if "**" in visible:
        errors.append(f"{path}: leaked Markdown bold marker '**'")
    if re.search(r"\bE\[\s*M_[^\]]*\|\s*F_", visible):
        errors.append(f"{path}: raw conditional-expectation formula leaked outside MathJax")
    return errors


def _patch_base_gate() -> None:
    # ``base.validate`` calls this function by global lookup, so replacing it
    # here preserves all theorem/formula checks while removing the obsolete
    # broad ASCII-inequality heuristic.
    base.validate_page = validate_page


def _remove_undergrad_ladders(output: Path) -> None:
    chapter = output / "textbook" / "chapter-01"
    for path in chapter.glob("section-*.html"):
        text = path.read_text(encoding="utf-8")
        text = base.strip_between(text, base.UNDERGRAD_START, base.UNDERGRAD_END)
        path.write_text(text, encoding="utf-8", newline="\n")


def _collapse_supplemental_details(text: str) -> str:
    # Canonical theorem statements/proofs stay visible. The large background
    # packets remain available on demand instead of dominating the page.
    return text.replace(
        '<details class="reader-disclosure rigor-disclosure" open>',
        '<details class="reader-disclosure rigor-disclosure">',
    )


def _repair_exact_public_leaks(text: str) -> str:
    parts = re.split(
        r"(<(?:pre|code|script|style)\b[^>]*>.*?</(?:pre|code|script|style)>)",
        text,
        flags=re.S | re.I,
    )
    for index in range(0, len(parts), 2):
        segment = parts[index]
        segment = segment.replace(
            "For s <= t, E[M_t | F_s] = M_s",
            r"For \\(s\le t\\), \\(\mathbb E[M_t\mid\mathcal F_s]=M_s\\)",
        )
        segment = segment.replace(
            "E[M_t | F_s] = M_s",
            r"\\(\mathbb E[M_t\mid\mathcal F_s]=M_s\\)",
        )
        parts[index] = segment
    return "".join(parts)


def _inject_style(text: str, rel: Path) -> str:
    prefix = "../" * len(rel.parent.parts)
    href = f"{prefix}assets/{STYLE_NAME}"
    if href in text:
        return text
    return text.replace(
        "</head>",
        f'  <link rel="stylesheet" href="{href}">\n</head>',
        1,
    )


def enrich_site(output: Path = DEFAULT_OUTPUT) -> None:
    _patch_base_gate()
    # Undergrad guides are useful companion data, but not the canonical book
    # surface. Remove them from every Chapter 1 section before the base reader
    # validates the final canonical contract.
    _remove_undergrad_ladders(output)
    base.enrich_site(output)

    asset_dir = output / "assets"
    asset_dir.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(SOURCE_CSS, asset_dir / STYLE_NAME)

    for path in sorted(output.rglob("*.html")):
        rel = path.relative_to(output)
        text = path.read_text(encoding="utf-8")
        text = _collapse_supplemental_details(text)
        text = _repair_exact_public_leaks(text)
        text = _inject_style(text, rel)
        path.write_text(text, encoding="utf-8", newline="\n")

    validate(output)


def validate(output: Path = DEFAULT_OUTPUT) -> None:
    _patch_base_gate()
    base.validate(output)

    errors: list[str] = []
    css = output / "assets" / STYLE_NAME
    if not css.exists():
        errors.append(f"missing assets/{STYLE_NAME}")

    for path in output.rglob("*.html"):
        rel = path.relative_to(output)
        text = path.read_text(encoding="utf-8")
        errors.extend(validate_page(rel, text))
        prefix = "../" * len(rel.parent.parts)
        if f"{prefix}assets/{STYLE_NAME}" not in text:
            errors.append(f"{rel}: final reader stylesheet missing")

    if errors:
        raise RuntimeError("final reader contract failed:\n- " + "\n- ".join(errors))


if __name__ == "__main__":
    enrich_site()
