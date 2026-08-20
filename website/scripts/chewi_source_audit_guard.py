#!/usr/bin/env python3
"""Keep unaudited Chewi source rows out of theorem-card presentation.

A later-chapter correspondence row may exist for roadmap/audit purposes before
ASTIS has transcribed the exact displayed source statement.  Such metadata must
not be rendered as a theorem card and then guessed into LaTeX.  This pass
replaces only already-visible, stable-id source passages lacking audited LaTeX
with a quiet source-audit placeholder.  Once a statement is audited (either on
the correspondence row or in the formula supplements), the normal source-first
reader contract takes over automatically.
"""

from __future__ import annotations

import re
from pathlib import Path
from typing import Any

import chewi_source_first_contract as contract


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "_site"


def _pending_card(source_id: str, source: dict[str, Any]) -> str:
    source_url = str(source.get("source_url", "")).strip()
    kind = str(source.get("source_kind", "Source result")).strip() or "Source result"
    link = (
        f'<p><a href="{contract.esc(source_url)}">Open the canonical source anchor ↗</a></p>'
        if source_url else ""
    )
    return (
        '<section class="textbook-block source-audit-pending" '
        f'data-source-audit-id="{contract.esc(source_id)}">'
        '<div class="passage-label">Source theorem audit pending</div>'
        f'<h2>{contract.esc(kind)}</h2>'
        '<p>The exact displayed statement has not yet passed ASTIS source audit. '
        'This correspondence row therefore stays out of theorem-card presentation '
        'rather than being paraphrased into an invented formula.</p>'
        f'{link}</section>'
    )


def enrich_site(output: Path = DEFAULT_OUTPUT) -> None:
    sources = contract._by_id(contract.SOURCE_CORRESPONDENCE)
    supplements = contract._by_id(contract.FORMULA_SUPPLEMENTS)
    grouped: dict[str, list[tuple[str, dict[str, Any]]]] = {}
    for source_id, source in sources.items():
        try:
            contract._formula_for(source_id, source, supplements)
            continue
        except RuntimeError:
            pass
        grouped.setdefault(str(source.get("section", "")), []).append((source_id, source))

    for section, rows in grouped.items():
        try:
            path = contract.base.section_path(output, section)
        except Exception:
            continue
        if not path.exists():
            continue
        text = path.read_text(encoding="utf-8")
        changed = False
        for source_id, source in rows:
            stable = re.compile(
                rf'<section class="[^"]*\bsource-passage\b[^"]*"[^>]*'
                rf'data-source-id="{re.escape(contract.esc(source_id))}"[^>]*>.*?</section>',
                flags=re.S,
            )
            matches = list(stable.finditer(text))
            if len(matches) > 1:
                raise RuntimeError(f"{path.relative_to(output)}: duplicate unaudited source card {source_id}")
            if not matches:
                continue
            match = matches[0]
            replacement = _pending_card(source_id, source)
            text = text[:match.start()] + replacement + text[match.end():]
            changed = True
        if changed:
            path.write_text(text, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    enrich_site()
