#!/usr/bin/env python3
"""Surface audited supplementary texts inside the Chapter 1 Companion."""

from __future__ import annotations

import json
from collections import OrderedDict
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[2]
SOURCE_PATH = ROOT / "website" / "content" / "source_foundations.json"
TARGET = Path("textbook/chapter-01-companion.html")
MARKER = 'data-chapter1-reference-shelf="true"'


def load_records() -> list[dict[str, Any]]:
    raw = json.loads(SOURCE_PATH.read_text(encoding="utf-8"))
    if not isinstance(raw, list):
        raise RuntimeError("source_foundations.json must be an array")
    return [dict(item) for item in raw if isinstance(item, dict)]


def audited_sources() -> list[dict[str, Any]]:
    grouped: OrderedDict[str, dict[str, Any]] = OrderedDict()
    for packet in load_records():
        for raw_source in packet.get("sources", []):
            if not isinstance(raw_source, dict):
                continue
            source = dict(raw_source)
            name = str(source.get("name", "")).strip()
            if not name:
                continue
            entry = grouped.setdefault(
                name,
                {
                    "name": name,
                    "url": str(source.get("url", "")),
                    "scope": str(source.get("scope", "")),
                    "uses": 0,
                },
            )
            entry["uses"] = int(entry["uses"]) + 1
            if not entry["scope"] and source.get("scope"):
                entry["scope"] = str(source["scope"])
    return list(grouped.values())


def shelf_html() -> str:
    cards = []
    for source in audited_sources():
        cards.append(
            '<article>'
            f'<h3><a href="{source["url"]}">{source["name"]} ↗</a></h3>'
            f'<p>{source["scope"]}</p>'
            f'<small>Used by {source["uses"]} audited Chapter 1 foundation packet(s).</small>'
            '</article>'
        )
    return f"""
<section {MARKER}>
  <div class="section-heading"><span>Reference shelf</span><h2>Supplementary texts, kept below the main book.</h2></div>
  <p class="muted">These are supporting references already attached to audited Chapter 1 foundation packets. They explain details that Chewi can reasonably treat as background; they are not parallel replacements for <em>Log-Concave Sampling</em>. The shelf grows as later Chapter 1 sections receive the same source audit.</p>
  <div class="companion-support-grid">{''.join(cards)}</div>
</section>
"""


def enrich_site(output: Path) -> None:
    target = output / TARGET
    if not target.exists():
        raise RuntimeError(f"Chapter 1 Companion missing: {TARGET.as_posix()}")
    text = target.read_text(encoding="utf-8")
    if MARKER in text:
        return
    insert_before = '<section class="companion-tools">'
    if insert_before not in text:
        raise RuntimeError("cannot locate Chapter 1 companion tool section")
    text = text.replace(insert_before, shelf_html() + insert_before, 1)
    target.write_text(text, encoding="utf-8", newline="\n")
    check = target.read_text(encoding="utf-8")
    if MARKER not in check or "Karatzas--Shreve" not in check:
        raise RuntimeError("Chapter 1 reference shelf validation failed")
