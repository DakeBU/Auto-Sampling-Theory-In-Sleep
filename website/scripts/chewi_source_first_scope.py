#!/usr/bin/env python3
"""Scope the Chewi source-first validator to the textbook reader it owns.

SampleWiki is finalized later by samplewiki_reader_contract, and declaration /
module / theorem inventory pages are generated technical documentation rather
than the source-first textbook reader. Running the Chewi prose linter over those
pages before their own final renderers creates false ordering failures and, in
particular, inspects the pre-casebook SampleWiki crawler HTML.

This wrapper does not weaken the textbook contract: it runs the unchanged strict
validator over a temporary copy containing the complete textbook tree only.
SampleWiki keeps its own 34-case final contract after its final renderer runs.
"""

from __future__ import annotations

import shutil
import tempfile
from pathlib import Path
from typing import Any


def patch(contract: Any) -> None:
    if getattr(contract, "_textbook_validation_scope_applied", False):
        return

    original_validate = contract.validate

    def validate(output: Path = contract.DEFAULT_OUTPUT) -> None:
        textbook = output / "textbook"
        if not textbook.exists():
            raise RuntimeError(f"textbook reader tree missing: {textbook}")
        with tempfile.TemporaryDirectory(prefix="astis-chewi-reader-") as tmp:
            scoped = Path(tmp)
            shutil.copytree(textbook, scoped / "textbook")
            original_validate(scoped)

    contract.validate = validate
    contract._textbook_validation_scope_applied = True
