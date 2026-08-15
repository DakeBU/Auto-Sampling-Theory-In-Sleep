#!/usr/bin/env python3
"""Render ASTIS-owned implicit prerequisite theorems into textbook pages.

Chewi source blocks and ASTIS supplemental results have different provenance.
The main site generator renders the source route.  This post-build layer adds
only results that are *not* stated as standalone results in the textbook but
are genuinely consumed by its calculation rules.  Every card therefore shows
an ASTIS provenance label, a LaTeX statement, all explicit assumptions, a
mathematical proof, downstream source consumers, and optional Lean links.

The script is deliberately presentation-only: it never changes Registry,
source-correspondence, completion-matrix, or Lean status.
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
START = "<!-- ASTIS_IMPLICIT_PREREQUISITES_START -->"
END = "<!-- ASTIS_IMPLICIT_PREREQUISITES_END -->"


def esc(value: object) -> str:
    return html.escape(str(value), quote=True)


def slugify(value: str) -> str:
    value = re.sub(r"[^a-zA-Z0-9]+", "-", value).strip("-").lower()
    return value or "entry"


def load_items() -> list[dict[str, object]]:
    path = CONTENT / "implicit_prerequisites.json"
    raw = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(raw, list):
        raise RuntimeError("implicit_prerequisites.json must contain a list")
    required = {
        "id",
        "section",
        "title",
        "provenance",
        "why_needed",
        "latex_statement",
        "assumptions",
        "proof",
        "used_for",
        "lean_declarations",
        "lean_status",
    }
    seen: set[str] = set()
    items: list[dict[str, object]] = []
    for index, candidate in enumerate(raw):
        if not isinstance(candidate, dict):
            raise RuntimeError(f"implicit prerequisite #{index} is not an object")
        missing = sorted(required.difference(candidate))
        if missing:
            raise RuntimeError(
                f"implicit prerequisite {candidate.get('id', index)!r} is missing {missing}"
            )
        item_id = str(candidate["id"])
        if item_id in seen:
            raise RuntimeError(f"duplicate implicit prerequisite id: {item_id}")
        seen.add(item_id)
        if str(candidate["provenance"]) != "ASTIS implicit prerequisite":
            raise RuntimeError(
                f"{item_id}: supplemental theorem must be labeled 'ASTIS implicit prerequisite'"
            )
        if str(candidate["lean_status"]) not in {"compiled", "frontier"}:
            raise RuntimeError(f"{item_id}: invalid lean_status")
        if not str(candidate["latex_statement"]).strip():
            raise RuntimeError(f"{item_id}: missing LaTeX statement")
        if not str(candidate["proof"]).strip():
            raise RuntimeError(f"{item_id}: missing mathematical proof")
        if not list(candidate["assumptions"]):
            raise RuntimeError(f"{item_id}: missing explicit assumptions")
        if not list(candidate["used_for"]):
            raise RuntimeError(f"{item_id}: missing source consumers")
        items.append(dict(candidate))
    return items


def section_path(output: Path, section: str) -> Path:
    try:
        chapter = int(section.split(".", 1)[0])
    except ValueError as exc:
        raise RuntimeError(f"invalid section id: {section}") from exc
    return output / "textbook" / f"chapter-{chapter:02d}" / f"section-{slugify(section)}.html"


def list_html(values: object) -> str:
    return "<ul>" + "".join(f"<li>{esc(value)}</li>" for value in list(values)) + "</ul>"


def lean_links(item: dict[str, object]) -> str:
    declarations = [str(value) for value in item["lean_declarations"]]
    if not declarations:
        return '<p class="muted">Lean frontier: no completed ASTIS declaration is claimed yet.</p>'
    links = []
    for declaration in declarations:
        slug = slugify(declaration)
        short = declaration.rsplit(".", 1)[-1]
        links.append(
            f'<a href="../../theorems/{slug}.html"><code>{esc(short)}</code></a>'
        )
    return '<div class="decl-links">' + "".join(links) + "</div>"


def render_card(item: dict[str, object]) -> str:
    status = str(item["lean_status"])
    status_html = (
        '<span class="status status-green">compiled Lean support</span>'
        if status == "compiled"
        else '<span class="status status-orange">Lean frontier</span>'
    )
    return f"""
<article class="textbook-block implicit-prerequisite-card" id="{esc(item['id'])}" data-provenance="astis-implicit-prerequisite">
  <section class="source-passage supplemental-passage">
    <div class="passage-label">ASTIS implicit prerequisite · not a standalone Chewi result</div>
    <h2>{esc(item['title'])}</h2>
    <p><strong>Why the textbook calculation needs this.</strong> {esc(item['why_needed'])}</p>
    <div class="formula source-formula">\\[{esc(item['latex_statement'])}\\]</div>
    <div>{status_html}</div>
  </section>
  <details class="reader-disclosure rigor-disclosure" open>
    <summary>Full theorem and mathematical proof</summary>
    <div class="disclosure-body">
      <h3>Assumptions</h3>{list_html(item['assumptions'])}
      <h3>Proof</h3><p>{esc(item['proof'])}</p>
      <h3>Where Chewi uses it implicitly</h3>{list_html(item['used_for'])}
    </div>
  </details>
  <details class="reader-disclosure lean-disclosure">
    <summary>View Lean formalization</summary>
    <div class="disclosure-body">
      <p>This is ASTIS supplemental infrastructure. Its Lean status does not alter the completion status of a Chewi source item.</p>
      {lean_links(item)}
    </div>
  </details>
</article>"""


def render_section(items: list[dict[str, object]]) -> str:
    compiled = sum(str(item["lean_status"]) == "compiled" for item in items)
    cards = "".join(render_card(item) for item in items)
    return f"""{START}
<section class="implicit-prerequisites" id="implicit-prerequisites">
  <div class="section-heading">
    <span>ASTIS makes the calculation rules explicit</span>
    <h2>Implicit prerequisite theorems and proofs</h2>
  </div>
  <div class="note">
    <strong>Provenance rule.</strong> These are not additional claims attributed to Chewi. They are the measure-theoretic, stochastic-process, and functional-analytic facts that the textbook calculation uses without promoting each one to a numbered standalone result. ASTIS states their assumptions and proofs explicitly; Lean details remain optional.
  </div>
  <p class="card-meta">{compiled}/{len(items)} prerequisite cards currently have compiled Lean support. A frontier card remains mathematically documented without being promoted to a compiled source result.</p>
  {cards}
</section>
{END}"""


def strip_existing(text: str) -> str:
    pattern = re.compile(re.escape(START) + r".*?" + re.escape(END), re.DOTALL)
    return pattern.sub("", text)


def enrich_site(output: Path = DEFAULT_OUTPUT) -> int:
    items = load_items()
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
        block = render_section(section_items)
        text = text.replace(marker, block + "\n" + marker, 1)
        path.write_text(text, encoding="utf-8")
        changed += 1

    data_dir = output / "data"
    data_dir.mkdir(parents=True, exist_ok=True)
    (data_dir / "implicit-prerequisites.json").write_text(
        json.dumps(items, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    return changed


def validate_site(output: Path = DEFAULT_OUTPUT) -> list[str]:
    errors: list[str] = []
    try:
        items = load_items()
    except Exception as exc:  # validation should report rather than crash
        return [str(exc)]
    grouped: dict[str, list[dict[str, object]]] = defaultdict(list)
    for item in items:
        grouped[str(item["section"])].append(item)
    for section, section_items in grouped.items():
        path = section_path(output, section)
        if not path.exists():
            errors.append(f"missing generated section for implicit prerequisites: {path}")
            continue
        text = path.read_text(encoding="utf-8")
        if text.count(START) != 1 or text.count(END) != 1:
            errors.append(f"{path}: implicit-prerequisite block is missing or duplicated")
        for item in section_items:
            item_id = str(item["id"])
            for required_text, label in (
                (f'id="{item_id}"', "card anchor"),
                ("ASTIS implicit prerequisite", "provenance"),
                ("Full theorem and mathematical proof", "proof disclosure"),
                (esc(item["latex_statement"]), "LaTeX statement"),
                (esc(item["proof"]), "proof text"),
                ("View Lean formalization", "Lean disclosure"),
            ):
                if required_text not in text:
                    errors.append(f"{path}: {item_id} missing {label}")
    data_path = output / "data" / "implicit-prerequisites.json"
    if not data_path.exists():
        errors.append("generated data/implicit-prerequisites.json is missing")
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
    print(f"Rendered implicit prerequisite proofs into {changed} textbook section(s).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
