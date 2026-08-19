#!/usr/bin/env python3
"""Recover readable MathJax expressions from SampleWiki row text.

The pinned case manifest stores browser-visible comparison-row text.  KaTeX
extraction leaves a human rendering, the embedded TeX source, then another
human rendering.  This presentation-only pass extracts the embedded TeX for
reading while keeping the exact raw pinned row text in a disclosure.
"""

from __future__ import annotations

import html
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "_site"
SAMPLEWIKI_ROOT = Path("example-cases")

EXPRESSION_RE = re.compile(
    r'<div class="sw-expression">'
    r'<span>(?P<label>.*?)</span>'
    r'<div>(?P<raw>.*?)</div></div>',
    flags=re.S,
)


def math_fragment(value: str) -> str:
    """Extract the first complete TeX fragment from KaTeX-derived row text."""
    first = value.find("\\")
    if first < 0:
        return ""

    start = first
    while start > 0 and not value[start - 1].isspace():
        start -= 1

    braces = parens = brackets = 0
    index = start
    saw_backslash = False
    operator_suffixes = (
        "\\le", "\\ge", "=", "<", ">", "+", "-", "\\sim", "\\to", "\\asymp"
    )
    while index < len(value):
        char = value[index]
        if char == "\\":
            saw_backslash = True
        elif char == "{":
            braces += 1
        elif char == "}":
            braces = max(0, braces - 1)
        elif char == "(":
            parens += 1
        elif char == ")":
            parens = max(0, parens - 1)
        elif char == "[":
            brackets += 1
        elif char == "]":
            brackets = max(0, brackets - 1)

        if saw_backslash and char.isspace() and braces == parens == brackets == 0:
            cursor = index
            while cursor < len(value) and value[cursor].isspace():
                cursor += 1
            current = value[start:index].strip()
            if current == "\\widetilde" and cursor < len(value):
                index = cursor
                continue
            if current.endswith(operator_suffixes) and cursor < len(value):
                index = cursor
                continue
            return current
        index += 1
    return value[start:].strip()


def render_match(match: re.Match[str]) -> str:
    label = match.group("label")
    raw_html = match.group("raw")
    raw = html.unescape(re.sub(r"<[^>]+>", "", raw_html)).strip()
    latex = math_fragment(raw)
    if not latex:
        return match.group(0)
    return (
        '<div class="sw-expression">'
        f'<span>{label}</span>'
        f'<div class="formula sw-row-formula">\\[{html.escape(latex, quote=True)}\\]</div>'
        '<details class="sw-raw-row"><summary>Raw pinned row text</summary>'
        f'<div>{html.escape(raw, quote=True)}</div></details></div>'
    )


def enrich_site(output: Path = DEFAULT_OUTPUT) -> None:
    root = output / SAMPLEWIKI_ROOT
    if not root.exists():
        raise RuntimeError("generated SampleWiki reader root is missing")

    converted = 0
    for path in sorted(root.rglob("*.html")):
        text = path.read_text(encoding="utf-8")
        text, count = EXPRESSION_RE.subn(render_match, text)
        converted += count
        path.write_text(text, encoding="utf-8", newline="\n")

    if converted == 0:
        raise RuntimeError("SampleWiki math renderer found no row expressions")

    errors: list[str] = []
    for path in sorted(root.rglob("*.html")):
        text = path.read_text(encoding="utf-8")
        for match in EXPRESSION_RE.finditer(text):
            raw = html.unescape(match.group("raw"))
            if "\\" in raw:
                errors.append(
                    f"{path.relative_to(output)}: TeX-bearing row expression was not converted"
                )
                break
    if errors:
        raise RuntimeError("SampleWiki math rendering failed:\n- " + "\n- ".join(errors))


if __name__ == "__main__":
    enrich_site()
