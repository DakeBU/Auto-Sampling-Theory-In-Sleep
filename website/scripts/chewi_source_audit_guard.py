#!/usr/bin/env python3
"""Keep unaudited Chewi correspondence rows out of theorem presentation.

Later-chapter correspondence metadata may exist before ASTIS has transcribed the
exact source statement.  Those rows are useful to the audit/graph pipeline, but
they are not mathematics for the public reader.  This final guard therefore
removes only already-visible source passages that still lack audited LaTeX.
Once an exact statement is audited, the normal theorem-first reader renders it.
"""

from __future__ import annotations

import re
from pathlib import Path

import chewi_source_first_contract as contract


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "_site"


def enrich_site(output: Path = DEFAULT_OUTPUT) -> None:
    sources = contract._by_id(contract.SOURCE_CORRESPONDENCE)
    supplements = contract._by_id(contract.FORMULA_SUPPLEMENTS)
    grouped: dict[str, list[tuple[str, dict[str, object]]]] = {}

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
        for source_id, _source in rows:
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
            if not matches:
                continue

            # Do not leave a theorem-shaped placeholder containing the source
            # anchor: the strict renderer would (correctly) try to reconstruct it
            # as a theorem.  Metadata remains in source_correspondence.json and
            # the graph; the public mathematical reader simply omits it.
            match = matches[0]
            text = text[: match.start()] + text[match.end() :]
            changed = True

        if changed:
            path.write_text(text, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    enrich_site()
