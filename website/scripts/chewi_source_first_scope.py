#!/usr/bin/env python3
"""Scope the Chewi source-first validator to the textbook reader it owns.

SampleWiki is finalized later by samplewiki_reader_contract, and declaration /
module / theorem inventory pages are generated technical documentation rather
than the source-first textbook reader. Running the Chewi prose linter over those
pages before their own final renderers creates false ordering failures and, in
particular, inspects the pre-casebook SampleWiki crawler HTML.

This wrapper does not weaken the textbook contract: it first repairs a tiny set
of legacy reader-facing ASCII inequalities into MathJax while leaving code/pre
blocks untouched, then runs the unchanged strict validator over a temporary copy
containing the complete textbook tree only. SampleWiki keeps its own 34-case
final contract after its final renderer runs.
"""

from __future__ import annotations

import re
import shutil
import tempfile
from pathlib import Path
from typing import Any


SKIP_BLOCK_RE = re.compile(
    r"(<(?:pre|code|script|style)\b[^>]*>.*?</(?:pre|code|script|style)>)",
    flags=re.S | re.I,
)


def _normalize_legacy_visible_math(text: str) -> str:
    """Turn known legacy ASCII relations into reader-facing MathJax.

    Generated reader prose has already passed through HTML escaping, so the
    same visible relation may occur as either ``<=`` or ``&lt;=`` in the raw
    document.  Normalize both encodings, only in ordinary visible HTML segments.
    Lean/code blocks remain byte-for-byte untouched.  The unchanged strict
    validator runs afterwards and remains the authority on raw-math leakage.
    """

    parts = SKIP_BLOCK_RE.split(text)
    replacements = (
        ("{tau &lt;= t}", r"\(\{\tau\le t\}\)"),
        ("tau &lt;= t", r"\(\tau\le t\)"),
        ("s &lt;= t", r"\(s\le t\)"),
        ("t &lt;= T", r"\(t\le T\)"),
        ("{tau <= t}", r"\(\{\tau\le t\}\)"),
        ("tau <= t", r"\(\tau\le t\)"),
        ("s <= t", r"\(s\le t\)"),
        ("t <= T", r"\(t\le T\)"),
    )
    for index in range(0, len(parts), 2):
        segment = parts[index]
        for old, new in replacements:
            segment = segment.replace(old, new)
        parts[index] = segment
    return "".join(parts)


def patch(contract: Any) -> None:
    if getattr(contract, "_textbook_validation_scope_applied", False):
        return

    original_validate = contract.validate

    def validate(output: Path = contract.DEFAULT_OUTPUT) -> None:
        textbook = output / "textbook"
        if not textbook.exists():
            raise RuntimeError(f"textbook reader tree missing: {textbook}")

        # Repair the actual deployable textbook, not merely the validation copy.
        # This keeps the public reader and the strict validation target identical.
        for path in sorted(textbook.rglob("*.html")):
            text = path.read_text(encoding="utf-8")
            normalized = _normalize_legacy_visible_math(text)
            if normalized != text:
                path.write_text(normalized, encoding="utf-8", newline="\n")

        with tempfile.TemporaryDirectory(prefix="astis-chewi-reader-") as tmp:
            scoped = Path(tmp)
            shutil.copytree(textbook, scoped / "textbook")
            original_validate(scoped)

    contract.validate = validate
    contract._textbook_validation_scope_applied = True
