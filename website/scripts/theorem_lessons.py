#!/usr/bin/env python3
"""Render rigorous, beginner-facing lessons for completed Chewi source theorems.

This layer is intentionally source-facing.  Each card begins with a faithful
statement of the numbered Chewi result and why it matters, then gives a
mathematical proof, then the standard details the book suppresses, and only
then exposes the Lean dependency DAG.  Classical textbooks are supplementary
foundation references; they never replace Chewi as the canonical source.

The renderer is presentation-only.  It does not alter Registry, source
correspondence, or completion status.  Those evidence layers must be promoted
separately after the Lean/focused-test gate is green.
"""

from __future__ import annotations

import argparse
import html
import json
import re
from collections import defaultdict
from pathlib import Path
from urllib.parse import quote


ROOT = Path(__file__).resolve().parents[2]
CONTENT = ROOT / "website" / "content"
DEFAULT_OUTPUT = ROOT / "_site"
START = "<!-- ASTIS_THEOREM_LESSONS_START -->"
END = "<!-- ASTIS_THEOREM_LESSONS_END -->"


def esc(value: object) -> str:
    return html.escape(str(value), quote=True)


def slugify(value: str) -> str:
    value = re.sub(r"[^a-zA-Z0-9]+", "-", value).strip("-").lower()
    return value or "entry"


def list_html(values: object) -> str:
    return "<ul>" + "".join(f"<li>{esc(value)}</li>" for value in list(values)) + "</ul>"


def section_path(output: Path, section: str) -> Path:
    try:
        chapter = int(section.split(".", 1)[0])
    except ValueError as exc:
        raise RuntimeError(f"invalid section id: {section}") from exc
    return output / "textbook" / f"chapter-{chapter:02d}" / f"section-{slugify(section)}.html"


def normalize_sources(item: dict[str, object]) -> list[dict[str, str]]:
    normalized: list[dict[str, str]] = []
    for index, candidate in enumerate(item.get("foundation_sources", [])):
        if not isinstance(candidate, dict):
            raise RuntimeError(f"{item['id']}: foundation source #{index} is not an object")
        missing = sorted({"name", "url", "scope"}.difference(candidate))
        if missing:
            raise RuntimeError(f"{item['id']}: foundation source #{index} is missing {missing}")
        source = {key: str(candidate[key]).strip() for key in ("name", "url", "scope")}
        if not source["name"] or not source["scope"] or not source["url"].startswith("https://"):
            raise RuntimeError(f"{item['id']}: invalid foundation source #{index}")
        normalized.append(source)
    if not normalized:
        raise RuntimeError(f"{item['id']}: at least one foundation source is required")
    return normalized


def normalize_layers(item: dict[str, object]) -> list[dict[str, object]]:
    result: list[dict[str, object]] = []
    for index, candidate in enumerate(item.get("lean_layers", [])):
        if not isinstance(candidate, dict):
            raise RuntimeError(f"{item['id']}: Lean layer #{index} is not an object")
        missing = sorted({"title", "role", "declarations"}.difference(candidate))
        if missing:
            raise RuntimeError(f"{item['id']}: Lean layer #{index} is missing {missing}")
        declarations = [str(value).strip() for value in candidate["declarations"]]
        if not declarations or any(not value for value in declarations):
            raise RuntimeError(f"{item['id']}: Lean layer #{index} has no declarations")
        result.append(
            {
                "title": str(candidate["title"]).strip(),
                "role": str(candidate["role"]).strip(),
                "declarations": declarations,
            }
        )
    if not result:
        raise RuntimeError(f"{item['id']}: at least one Lean layer is required")
    return result


def load_items() -> list[dict[str, object]]:
    path = CONTENT / "theorem_lessons.json"
    raw = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(raw, list):
        raise RuntimeError("theorem_lessons.json must contain a list")
    required = {
        "id", "section", "number", "source_kind", "title", "source_url",
        "source_page", "statement_label", "source_statement", "why_it_matters",
        "intuition", "formula", "source_assumptions", "formal_contracts",
        "proof_steps", "hidden_details", "foundation_sources", "lean_layers",
        "focused_test",
    }
    seen: set[str] = set()
    items: list[dict[str, object]] = []
    for index, candidate in enumerate(raw):
        if not isinstance(candidate, dict):
            raise RuntimeError(f"theorem lesson #{index} is not an object")
        missing = sorted(required.difference(candidate))
        if missing:
            raise RuntimeError(f"theorem lesson {candidate.get('id', index)!r} is missing {missing}")
        item = dict(candidate)
        item_id = str(item["id"]).strip()
        if item_id in seen:
            raise RuntimeError(f"duplicate theorem lesson id: {item_id}")
        seen.add(item_id)
        if not str(item["source_url"]).startswith("https://"):
            raise RuntimeError(f"{item_id}: source_url must use https")
        if not list(item["source_assumptions"]) or not list(item["formal_contracts"]):
            raise RuntimeError(f"{item_id}: source/formal assumptions must be explicit")
        steps = list(item["proof_steps"])
        if not steps:
            raise RuntimeError(f"{item_id}: proof_steps must be non-empty")
        for step_index, step in enumerate(steps):
            if not isinstance(step, dict) or not str(step.get("title", "")).strip() or not str(step.get("text", "")).strip():
                raise RuntimeError(f"{item_id}: malformed proof step #{step_index}")
        if not list(item["hidden_details"]):
            raise RuntimeError(f"{item_id}: hidden_details must be non-empty")
        normalize_sources(item)
        normalize_layers(item)
        items.append(item)
    return items


def declaration_url_map(output: Path) -> dict[str, str]:
    path = output / "search-index.json"
    if not path.exists():
        raise RuntimeError("generated search-index.json is missing before theorem-lesson enrichment")
    raw = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(raw, list):
        raise RuntimeError("generated search-index.json must contain a list")
    result: dict[str, str] = {}
    allowed = ("theorems/", "declarations/", "modules/")
    for row in raw:
        if not isinstance(row, dict):
            continue
        name = str(row.get("name", "")).strip()
        url = str(row.get("url", "")).strip()
        if name and url.startswith(allowed):
            result[name] = url
    return result


def source_links(item: dict[str, object]) -> str:
    rows = []
    for source in normalize_sources(item):
        rows.append(
            '<li class="foundation-reference">'
            f'<a href="{esc(source["url"])}" target="_blank" rel="noreferrer">{esc(source["name"])}</a>'
            f'<span> — {esc(source["scope"])}</span></li>'
        )
    return '<ul class="foundation-reference-list">' + "".join(rows) + "</ul>"


def declaration_link(declaration: str, output: Path) -> str:
    url = declaration_url_map(output).get(declaration)
    short = declaration.rsplit(".", 1)[-1]
    if url:
        return (
            f'<a href="../../{esc(url)}" data-theorem-lean-declaration="{esc(declaration)}">'
            f'<code>{esc(short)}</code><span>open exact Lean declaration →</span></a>'
        )
    return (
        f'<a href="../../declarations/index.html?search={quote(declaration)}" '
        f'data-theorem-lean-declaration="{esc(declaration)}" data-unresolved-card="true">'
        f'<code>{esc(short)}</code><span>find in declaration catalog →</span></a>'
    )


def render_layers(item: dict[str, object], output: Path) -> str:
    nodes = []
    for index, layer in enumerate(normalize_layers(item), 1):
        links = "".join(declaration_link(value, output) for value in layer["declarations"])
        nodes.append(
            f'<article class="theorem-dag-node" data-dag-order="{index}">'
            f'<div class="card-meta">Layer {index:02d}</div><h4>{esc(layer["title"])}</h4>'
            f'<p>{esc(layer["role"])}</p><div class="decl-links prerequisite-decl-links">{links}</div></article>'
        )
    return '<div class="theorem-dag">' + "".join(nodes) + "</div>"


def render_proof_steps(item: dict[str, object]) -> str:
    rows = []
    for step in item["proof_steps"]:
        rows.append(
            f'<article class="proof-step"><h4>{esc(step["title"])}</h4><p>{esc(step["text"])}</p></article>'
        )
    return '<div class="proof-route theorem-proof-route">' + "".join(rows) + "</div>"


def render_card(item: dict[str, object], output: Path) -> str:
    return f"""
<article class="textbook-block theorem-lesson-card" id="{esc(item['id'])}" data-chewi-theorem="{esc(item['number'])}">
  <section class="source-passage theorem-source-passage">
    <div class="passage-label">{esc(item['source_kind'])} · Chewi source theorem · {esc(item['source_page'])}</div>
    <h2>{esc(item['title'])}</h2>
    <div class="note theorem-provenance"><strong>Provenance.</strong> Chewi is the canonical theorem source. ASTIS uses a source-faithful paraphrase with normalized notation, then supplies omitted mathematical details and Lean evidence separately.</div>
    <h3>{esc(item['statement_label'])}</h3>
    <p class="theorem-statement">{esc(item['source_statement'])}</p>
    <div class="formula source-formula">\\[{esc(item['formula'])}\\]</div>
    <h3>Why this theorem is here</h3><p>{esc(item['why_it_matters'])}</p>
    <h3>Intuition before proof</h3><p>{esc(item['intuition'])}</p>
    <a class="source-anchor" href="{esc(item['source_url'])}">Open the canonical source page ↗</a>
  </section>
  <details class="reader-disclosure rigor-disclosure theorem-proof" open>
    <summary>Full mathematical proof · no Lean required</summary>
    <div class="disclosure-body">
      <div class="reader-columns"><div><h3>Assumptions in the source</h3>{list_html(item['source_assumptions'])}</div>
      <div><h3>Formal contracts ASTIS keeps explicit</h3>{list_html(item['formal_contracts'])}</div></div>
      <h3>Proof route</h3>{render_proof_steps(item)}
    </div>
  </details>
  <details class="reader-disclosure foundation-disclosure theorem-hidden-details" open>
    <summary>What the textbook leaves implicit · classical foundations</summary>
    <div class="disclosure-body">
      <h3>Hidden mathematical steps</h3>{list_html(item['hidden_details'])}
      <h3>Where to learn those steps rigorously</h3>
      <p class="muted">These references explain standard infrastructure. They do not change Chewi's theorem statement and they do not count as Lean proof closure.</p>
      {source_links(item)}
    </div>
  </details>
  <details class="reader-disclosure lean-disclosure theorem-lean-dag">
    <summary>Optional · inspect the Lean proof DAG</summary>
    <div class="disclosure-body">
      <p>Read top to bottom. Earlier nodes are reusable infrastructure; the last node is the source-facing theorem. The focused smoke test is <code>{esc(item['focused_test'])}</code>.</p>
      {render_layers(item, output)}
    </div>
  </details>
</article>"""


def render_section(items: list[dict[str, object]], output: Path) -> str:
    cards = "".join(render_card(item, output) for item in items)
    return f"""{START}
<section class="source-theorem-lessons" id="source-theorem-lessons">
  <div class="section-heading"><span>Source theorem lessons</span><h2>Read the theorem first; open Lean only if you want it</h2></div>
  <p class="section-intro">Each completed source theorem below is presented in four layers: the Chewi statement and purpose, a standalone mathematical proof, the classical details the book suppresses, and a collapsed Lean dependency DAG.</p>
  {cards}
</section>
{END}"""


def strip_existing(text: str) -> str:
    return re.sub(re.escape(START) + r".*?" + re.escape(END), "", text, flags=re.DOTALL)


def enrich_site(output: Path = DEFAULT_OUTPUT) -> int:
    items = load_items()
    url_map = declaration_url_map(output)
    # A lesson marked for this compiled checkpoint may not contain fake Lean
    # destinations.  Fail before touching generated HTML if any node is absent.
    for item in items:
        for layer in normalize_layers(item):
            for declaration in layer["declarations"]:
                if declaration not in url_map:
                    raise RuntimeError(
                        f"{item['id']}: Lean declaration has no generated source destination: {declaration}"
                    )
    grouped: dict[str, list[dict[str, object]]] = defaultdict(list)
    for item in items:
        grouped[str(item["section"])].append(item)
    changed = 0
    for section, section_items in grouped.items():
        path = section_path(output, section)
        if not path.exists():
            raise RuntimeError(f"generated textbook page does not exist: {path}")
        text = strip_existing(path.read_text(encoding="utf-8"))
        marker = '<nav class="reader-pagination"'
        if marker not in text:
            raise RuntimeError(f"reader pagination marker missing in {path}")
        text = text.replace(marker, render_section(section_items, output) + "\n" + marker, 1)
        path.write_text(text, encoding="utf-8")
        changed += 1
    data_dir = output / "data"
    data_dir.mkdir(parents=True, exist_ok=True)
    (data_dir / "theorem-lessons.json").write_text(
        json.dumps(items, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    return changed


def validate_site(output: Path = DEFAULT_OUTPUT) -> list[str]:
    errors: list[str] = []
    try:
        items = load_items()
        url_map = declaration_url_map(output)
    except Exception as exc:
        return [str(exc)]
    grouped: dict[str, list[dict[str, object]]] = defaultdict(list)
    for item in items:
        grouped[str(item["section"])].append(item)
    for section, section_items in grouped.items():
        path = section_path(output, section)
        if not path.exists():
            errors.append(f"missing generated theorem-lesson section: {path}")
            continue
        text = path.read_text(encoding="utf-8")
        if text.count(START) != 1 or text.count(END) != 1:
            errors.append(f"{path}: theorem-lesson block is missing or duplicated")
        for item in section_items:
            item_id = str(item["id"])
            required = (
                (f'id="{esc(item_id)}"', "lesson anchor"),
                (esc(item["source_statement"]), "source statement"),
                (esc(item["why_it_matters"]), "why-it-matters text"),
                ("Full mathematical proof · no Lean required", "proof layer"),
                ("What the textbook leaves implicit · classical foundations", "hidden-details layer"),
                ("Optional · inspect the Lean proof DAG", "Lean DAG layer"),
                (f'href="{esc(item["source_url"])}"', "canonical source link"),
                (esc(item["focused_test"]), "focused test"),
            )
            for needle, label in required:
                if needle not in text:
                    errors.append(f"{path}: {item_id} missing {label}")
            for step in item["proof_steps"]:
                if esc(step["text"]) not in text:
                    errors.append(f"{path}: {item_id} missing proof step {step['title']}")
            for detail in item["hidden_details"]:
                if esc(detail) not in text:
                    errors.append(f"{path}: {item_id} missing hidden detail")
            for source in normalize_sources(item):
                if f'href="{esc(source["url"])}"' not in text or esc(source["scope"]) not in text:
                    errors.append(f"{path}: {item_id} missing foundation source {source['name']}")
            for layer in normalize_layers(item):
                for declaration in layer["declarations"]:
                    if declaration not in url_map:
                        errors.append(f"{path}: {item_id} unresolved Lean declaration {declaration}")
                    elif f'data-theorem-lean-declaration="{esc(declaration)}"' not in text:
                        errors.append(f"{path}: {item_id} missing Lean DAG link {declaration}")
    if not (output / "data" / "theorem-lessons.json").exists():
        errors.append("generated data/theorem-lessons.json is missing")
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
    print(f"Rendered source theorem lessons into {changed} textbook section(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
