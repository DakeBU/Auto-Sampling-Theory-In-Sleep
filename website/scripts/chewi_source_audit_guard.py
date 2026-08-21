#!/usr/bin/env python3
"""Keep unaudited Chewi correspondence rows out of theorem presentation.

Later-chapter correspondence metadata may exist before ASTIS has transcribed the
exact source statement. Those rows are useful to the audit/graph pipeline, but
they are not mathematics for the public reader. This final guard therefore
removes already-visible source passages that still lack audited LaTeX, including
older untagged cards recoverable only from the exact source anchor. Once an exact
statement is audited, the normal theorem-first reader renders it.
"""

from __future__ import annotations

import re
from pathlib import Path
from typing import Any

import chewi_source_first_contract as contract


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "_site"


def _legacy_card_bounds(text: str, source: dict[str, Any]) -> tuple[int, int] | None:
    """Locate an older untagged source card by its exact canonical source anchor."""

    try:
        anchor = contract.reader._source_anchor(source)
    except Exception:
        return None
    if not anchor:
        return None
    anchor_at = text.find(anchor)
    if anchor_at < 0:
        return None
    section_start = text.rfind("<section", 0, anchor_at)
    section_close = text.find("</section>", anchor_at)
    if section_start < 0 or section_close < 0:
        return None
    return section_start, section_close + len("</section>")


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
                raise RuntimeError(
                    f"{path.relative_to(output)}: duplicate unaudited source card {source_id}"
                )
            if len(matches) == 1:
                match = matches[0]
                text = text[: match.start()] + text[match.end() :]
                changed = True
                continue

            # Older reader passes may omit data-source-id but still emit the
            # canonical source anchor. Remove the whole enclosing source section
            # so the strict source-first renderer cannot later mistake roadmap
            # metadata for a theorem awaiting reconstruction.
            legacy = _legacy_card_bounds(text, source)
            if legacy is None:
                continue
            start, end = legacy
            text = text[:start] + text[end:]
            changed = True

        if changed:
            path.write_text(text, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    enrich_site()
