#!/usr/bin/env python3
"""Normalize obvious paper-math ASCII leaks before final reader validation."""

from __future__ import annotations

import re
from pathlib import Path


DEFAULT_OUTPUT = Path(__file__).resolve().parents[2] / "_site"


def repair(text: str) -> str:
    # Supplementary infrastructure stays available but collapsed; the visible
    # mathematical spine is source statement -> equations -> proof.
    text = text.replace(
        '<details class="reader-disclosure rigor-disclosure" open>',
        '<details class="reader-disclosure rigor-disclosure">',
    )

    # Never touch source code, scripts, or styles.  In prose, <=/>= are not
    # acceptable mathematical typography; major theorem formulas are rendered
    # by MathJax in the final math-first layer.
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
        segment = segment.replace(" <= ", " ≤ ")
        segment = segment.replace(" >= ", " ≥ ")
        parts[index] = segment
    return "".join(parts)


def enrich_site(output: Path = DEFAULT_OUTPUT) -> None:
    for path in output.rglob("*.html"):
        path.write_text(repair(path.read_text(encoding="utf-8")), encoding="utf-8", newline="\n")


if __name__ == "__main__":
    enrich_site()
