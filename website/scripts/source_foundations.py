#!/usr/bin/env python3
"""Attach classical foundation references to formal Chewi source blocks.

Chewi remains the canonical theorem/definition spine.  This post-build layer
adds a clearly separated disclosure explaining which standard references fill
in hypotheses or proof steps that the source intentionally leaves implicit.
It never changes Registry, source correspondence, completion status, or Lean
ownership.

The mapping is stored separately in ``website/content/source_foundations.json``
so supplementary references cannot be confused with Chewi provenance.  Every
mapping must resolve to exactly one existing source-correspondence row and one
generated source block; otherwise the build fails rather than silently
attaching a reference to the wrong theorem.
"""

from __future__ import annotations

import argparse
import html
import json
import re
from collections import defaultdict
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
CONTENT = ROOT / "website" / "content"
DEFAULT_OUTPUT = ROOT / "_site"
START_PREFIX = "<!-- ASTIS_SOURCE_FOUNDATION_START:"
END_PREFIX = "<!-- ASTIS_SOURCE_FOUNDATION_END:"


def esc(value: object) -> str:
    return html.escape(str(value), quote=True)


def final_reader_detail_html(value: object) -> str:
    """Return the detail text after the final reader's visible-math cleanup.

    Foundation packets are inserted before the source-first reader normalizes
    legacy ASCII inequalities into MathJax. Validation runs after that final
    reader pass, so it must recognize the mathematically identical rendered
    form rather than requiring stale ``&lt;=`` text to survive in public HTML.
    This helper mirrors only the narrow relation rewrites used by the final
    reader; it does not weaken presence checks for the surrounding prose.
    """

    rendered = esc(value)
    replacements = (
        ("{tau &lt;= t}", r"\(\{\tau\le t\}\)"),
        ("tau &lt;= t", r"\(\tau\le t\)"),
        ("s &lt;= t", r"\(s\le t\)"),
        ("t &lt;= T", r"\(t\le T\)"),
    )
    for old, new in replacements:
        rendered = rendered.replace(old, new)
    return rendered


def slugify(value: str) -> str:
    value = re.sub(r"[^a-zA-Z0-9]+", "-", value).strip("-").lower()
    return value or "entry"


def section_path(output: Path, chapter: int, section: str) -> Path:
    return output / "textbook" / f"chapter-{chapter:02d}" / f"section-{slugify(section)}.html"


def load_correspondence() -> dict[str, dict[str, object]]:
    raw = json.loads((CONTENT / "source_correspondence.json").read_text(encoding="utf-8"))
    if not isinstance(raw, list):
        raise RuntimeError("source_correspondence.json must contain a list")
    rows: dict[str, dict[str, object]] = {}
    for candidate in raw:
        if not isinstance(candidate, dict) or "id" not in candidate:
            raise RuntimeError("every source-correspondence row must be an object with an id")
        source_id = str(candidate["id"])
        if source_id in rows:
            raise RuntimeError(f"duplicate source-correspondence id: {source_id}")
        rows[source_id] = dict(candidate)
    return rows


def normalize_source(source_id: str, index: int, candidate: object) -> dict[str, str]:
    if not isinstance(candidate, dict):
        raise RuntimeError(f"{source_id}: source #{index} is not an object")
    missing = sorted({"name", "url", "scope"}.difference(candidate))
    if missing:
        raise RuntimeError(f"{source_id}: source #{index} is missing {missing}")
    name = str(candidate["name"]).strip()
    url = str(candidate["url"]).strip()
    scope = str(candidate["scope"]).strip()
    if not name or not scope:
        raise RuntimeError(f"{source_id}: source #{index} has an empty name or scope")
    if not url.startswith("https://"):
        raise RuntimeError(f"{source_id}: source #{index} must use an https URL")
    return {"name": name, "url": url, "scope": scope}


def load_foundations() -> list[dict[str, object]]:
    correspondence = load_correspondence()
    path = CONTENT / "source_foundations.json"
    raw = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(raw, list):
        raise RuntimeError("source_foundations.json must contain a list")
    seen: set[str] = set()
    result: list[dict[str, object]] = []
    for index, candidate in enumerate(raw):
        if not isinstance(candidate, dict):
            raise RuntimeError(f"source foundation #{index} is not an object")
        missing = sorted({"source_correspondence_id", "hidden_details", "sources"}.difference(candidate))
        if missing:
            raise RuntimeError(f"source foundation #{index} is missing {missing}")
        source_id = str(candidate["source_correspondence_id"]).strip()
        if source_id in seen:
            raise RuntimeError(f"duplicate source foundation id: {source_id}")
        seen.add(source_id)
        if source_id not in correspondence:
            raise RuntimeError(f"foundation mapping has no source-correspondence row: {source_id}")
        hidden = [str(value).strip() for value in candidate["hidden_details"]]
        if not hidden or any(not value for value in hidden):
            raise RuntimeError(f"{source_id}: hidden_details must be a non-empty string list")
        sources = [normalize_source(source_id, i, value) for i, value in enumerate(candidate["sources"])]
        if not sources:
            raise RuntimeError(f"{source_id}: at least one foundation source is required")
        result.append(
            {
                "source_correspondence_id": source_id,
                "hidden_details": hidden,
                "sources": sources,
            }
        )
    return result


def strip_existing(text: str) -> str:
    pattern = re.compile(
        re.escape(START_PREFIX) + r"[^>\n]+ -->.*?" + re.escape(END_PREFIX) + r"[^>\n]+ -->",
        re.DOTALL,
    )
    return pattern.sub("", text)


def source_marker(source: dict[str, object]) -> str:
    return (
        f'<div class="passage-label">{esc(source["source_kind"])}</div>'
        f'<h2>{esc(source["source_summary"])}</h2>'
    )


def render_block(item: dict[str, object]) -> str:
    source_id = str(item["source_correspondence_id"])
    hidden = "<ul>" + "".join(f"<li>{esc(value)}</li>" for value in item["hidden_details"]) + "</ul>"
    sources = "<ul class=\"foundation-reference-list\">" + "".join(
        '<li class="foundation-reference">'
        f'<a href="{esc(source["url"])}" target="_blank" rel="noreferrer">{esc(source["name"])}</a>'
        f'<span> — {esc(source["scope"])}</span></li>'
        for source in item["sources"]
    ) + "</ul>"
    return f"""
{START_PREFIX}{source_id} -->
<details class="reader-disclosure foundation-disclosure" data-source-foundation="{esc(source_id)}">
  <summary>Foundation references · what Chewi leaves implicit</summary>
  <div class="disclosure-body">
    <p class="note"><strong>Provenance.</strong> Chewi is still the theorem/definition source. The references below are supplementary explanations for standard stochastic-analysis infrastructure; they neither alter the source statement nor replace ASTIS Lean proof obligations.</p>
    <h3>Details ASTIS makes explicit</h3>
    {hidden}
    <h3>Classical references and their role</h3>
    {sources}
  </div>
</details>
{END_PREFIX}{source_id} -->"""


def enrich_site(output: Path = DEFAULT_OUTPUT) -> int:
    correspondence = load_correspondence()
    foundations = load_foundations()
    grouped: dict[Path, list[dict[str, object]]] = defaultdict(list)
    for item in foundations:
        source = correspondence[str(item["source_correspondence_id"])]
        grouped[
            section_path(output, int(source["chapter"]), str(source["section"]))
        ].append(item)

    changed = 0
    for path, items in grouped.items():
        if not path.exists():
            raise RuntimeError(f"generated textbook page does not exist: {path}")
        text = strip_existing(path.read_text(encoding="utf-8"))
        for item in items:
            source_id = str(item["source_correspondence_id"])
            source = correspondence[source_id]
            marker = source_marker(source)
            count = text.count(marker)
            if count != 1:
                raise RuntimeError(
                    f"{path}: expected exactly one generated block for {source_id}; found {count}"
                )
            marker_pos = text.index(marker)
            close_pos = text.find("</section>", marker_pos + len(marker))
            if close_pos < 0:
                raise RuntimeError(f"{path}: source passage for {source_id} has no closing section")
            close_pos += len("</section>")
            text = text[:close_pos] + render_block(item) + text[close_pos:]
        path.write_text(text, encoding="utf-8")
        changed += 1

    data_dir = output / "data"
    data_dir.mkdir(parents=True, exist_ok=True)
    (data_dir / "source-foundations.json").write_text(
        json.dumps(foundations, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    return changed


def validate_site(output: Path = DEFAULT_OUTPUT) -> list[str]:
    errors: list[str] = []
    try:
        correspondence = load_correspondence()
        foundations = load_foundations()
    except Exception as exc:
        return [str(exc)]
    for item in foundations:
        source_id = str(item["source_correspondence_id"])
        source = correspondence[source_id]
        path = section_path(output, int(source["chapter"]), str(source["section"]))
        if not path.exists():
            errors.append(f"missing generated textbook page: {path}")
            continue
        text = path.read_text(encoding="utf-8")
        if text.count(f'data-source-foundation="{esc(source_id)}"') != 1:
            errors.append(f"{path}: missing or duplicated foundation disclosure for {source_id}")
        for detail in item["hidden_details"]:
            candidates = (esc(detail), final_reader_detail_html(detail))
            if not any(candidate in text for candidate in candidates):
                errors.append(f"{path}: {source_id} missing hidden detail: {detail}")
        for source_ref in item["sources"]:
            if f'href="{esc(source_ref["url"])}"' not in text:
                errors.append(f"{path}: {source_id} missing foundation URL for {source_ref['name']}")
            if esc(source_ref["scope"]) not in text:
                errors.append(f"{path}: {source_id} missing foundation scope for {source_ref['name']}")
    data_path = output / "data" / "source-foundations.json"
    if not data_path.exists():
        errors.append("generated data/source-foundations.json is missing")
    return errors


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", default=str(DEFAULT_OUTPUT))
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    output = Path(args.output).resolve()
    if args.check:
        errors = validate_site(output)
        for error in errors:
            print(f"ERROR: {error}")
        return 1 if errors else 0
    changed = enrich_site(output)
    print(f"Rendered source foundation references into {changed} textbook section(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
