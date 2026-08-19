#!/usr/bin/env python3
"""Strengthen the canonical textbook reader into a self-contained math text.

The public reader should remain useful when every Lean/foundation disclosure is
collapsed.  This layer therefore patches the final Chapter 1 source-card
renderer so that

* each Chewi result is led by its exact displayed mathematical statement;
* source proof/derivation equations are attached even when the statement came
  from audited ``latex_statement`` metadata rather than a formula supplement;
* equation proofs are collapsed by default and provenance is explicit;
* prose summaries become quiet explanatory sentences, never giant headings;
* reader validation checks statement/proof order and the two regressions that
  motivated this contract (martingale conditional expectation and Itô L2
  completion).

This file is presentation-only.  It never upgrades a source/Lean status and it
never labels an ASTIS expansion as a proof supplied by Chewi.
"""

from __future__ import annotations

import html
import re
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "_site"
SOURCE_CSS = ROOT / "website" / "static" / "textbook-math-contract.css"
STYLE_NAME = "textbook-math-contract.css"
FORMULA_FIRST_SECTIONS = ("1.1", "1.2", "1.3", "1.4")


def esc(value: object) -> str:
    return html.escape(str(value), quote=True)


def _proof_renderer(reader: Any, source_id: str, proof: dict[str, Any] | None) -> str:
    if not proof:
        return ""
    steps = proof.get("steps", [])
    if not isinstance(steps, list) or not steps:
        return ""

    provenance = str(proof.get("source_status", "source_proof"))
    if provenance == "astis_expansion":
        summary = "ASTIS formal expansion"
        origin = (
            "Chewi does not supply this expanded proof here.  The equations below are the "
            "ASTIS proof expansion and are not attributed to the book."
        )
    else:
        summary = "Proof in equations"
        origin = (
            "Mathematical proof / derivation corresponding to the source result, with ASTIS Lean "
            "lemmas shown only as a secondary correspondence."
        )

    rendered: list[str] = []
    for index, raw in enumerate(steps, 1):
        if not isinstance(raw, dict):
            continue
        latex = str(raw.get("formula", "")).strip()
        if not latex:
            continue
        lean_names = [str(name) for name in raw.get("lean", []) if str(name).strip()]
        lean_html = ""
        if lean_names:
            lean_html = (
                '<div class="source-proof-lean"><span>Lean correspondence</span> '
                + " · ".join(f'<code>{reader.base.esc(name)}</code>' for name in lean_names)
                + "</div>"
            )
        rendered.append(
            '<div class="source-proof-step">'
            f'<div class="source-proof-index">{index}</div>'
            '<div class="source-proof-equation">'
            f'<div class="formula source-proof-formula">\\[{reader.base.esc(latex)}\\]</div>'
            f'{lean_html}</div></div>'
        )
    if not rendered:
        return ""

    return (
        '<details class="reader-disclosure source-proof-disclosure" '
        f'data-source-proof="{reader.base.esc(source_id)}">'
        f'<summary>{summary}</summary>'
        '<div class="disclosure-body">'
        f'<p class="source-proof-origin">{esc(origin)}</p>'
        '<div class="source-equation-proof">'
        + "".join(rendered)
        + "</div></div></details>"
    )


def patch_reader_contract(reader: Any) -> None:
    """Patch ``reader_contract_final`` before its ``enrich_site`` runs.

    The stock reader attaches a proof supplement only while it is injecting a
    *missing* statement formula.  That omits proofs for audited cards whose
    statement already comes from ``source_correspondence.latex_statement``.
    We preserve its formula logic but add a second, source-id-safe proof pass.
    """

    def render_proof(source_id: str, proof: dict[str, Any] | None) -> str:
        return _proof_renderer(reader, source_id, proof)

    reader._render_proof_supplement = render_proof

    def inject_formula_and_proof_supplements(output: Path) -> None:
        sources = reader._source_entries()
        supplements = reader._formula_supplements()
        proofs = reader._proof_supplements()
        errors: list[str] = []

        unknown_proofs = sorted(set(proofs) - set(sources))
        errors.extend(
            f"proof supplement has no source-correspondence item: {item}"
            for item in unknown_proofs
        )

        # First keep the stock rule: supplements fill only missing public
        # statement displays and never overwrite an audited latex_statement.
        for source_id, supplement in supplements.items():
            source = sources.get(source_id)
            if source is None:
                errors.append(f"formula supplement has no source-correspondence item: {source_id}")
                continue
            section = str(source.get("section", ""))
            if section not in reader.FORMULA_FIRST_SECTIONS:
                continue
            if str(source.get("latex_statement", "")).strip():
                continue

            path = reader.base.section_path(output, section)
            if not path.exists():
                errors.append(f"missing generated section for formula supplement {source_id}: {path}")
                continue
            text = path.read_text(encoding="utf-8")
            marker = f'data-source-formula="{reader.base.esc(source_id)}"'
            if marker in text:
                continue
            anchor = reader._source_anchor(source)
            if anchor not in text:
                errors.append(
                    f"{path.relative_to(output)}: cannot locate source card for formula supplement {source_id}"
                )
                continue
            replacement = (
                '<section class="source-passage formula-first-source" '
                f'data-source-id="{reader.base.esc(source_id)}">'
                f'<div class="passage-label">{reader.base.esc(source.get("source_kind", ""))}</div>'
                f'<h2>{reader.base.esc(source.get("source_summary", ""))}</h2>'
                + reader._render_formula_supplement(
                    source_id, supplement, proofs.get(source_id)
                )
            )
            text = text.replace(anchor, replacement, 1)
            path.write_text(text, encoding="utf-8", newline="\n")

        # Second pass: attach proof equations to cards whose statement formula
        # was already present (typically from audited latex_statement metadata).
        for source_id, proof in proofs.items():
            source = sources.get(source_id)
            if source is None:
                continue
            section = str(source.get("section", ""))
            if section not in reader.FORMULA_FIRST_SECTIONS:
                continue
            path = reader.base.section_path(output, section)
            if not path.exists():
                errors.append(f"missing generated section for proof supplement {source_id}: {path}")
                continue
            text = path.read_text(encoding="utf-8")
            proof_marker = f'data-source-proof="{reader.base.esc(source_id)}"'
            if proof_marker in text:
                continue
            rendered = render_proof(source_id, proof)
            if not rendered:
                continue

            # Formula-supplement cards already carry a stable source id.
            tagged_start = re.search(
                rf'<section class="[^"]*\bsource-passage\b[^"]*"[^>]*data-source-id="{re.escape(reader.base.esc(source_id))}"[^>]*>',
                text,
            )
            if tagged_start:
                start = tagged_start.start()
                close = text.find("</section>", tagged_start.end())
            else:
                anchor = reader._source_anchor(source)
                start = text.find(anchor)
                close = text.find("</section>", start + len(anchor)) if start >= 0 else -1
            if start < 0 or close < 0:
                errors.append(
                    f"{path.relative_to(output)}: cannot locate source card for proof supplement {source_id}"
                )
                continue
            text = text[:close] + rendered + text[close:]
            path.write_text(text, encoding="utf-8", newline="\n")

        if errors:
            raise RuntimeError("formula/proof supplement injection failed:\n- " + "\n- ".join(errors))

    reader._inject_formula_supplements = inject_formula_and_proof_supplements


def _source_card_pattern(source_id: str) -> re.Pattern[str]:
    return re.compile(
        rf'<section class="[^"]*\bsource-passage\b[^"]*"[^>]*data-source-id="{re.escape(esc(source_id))}"[^>]*>.*?</section>',
        flags=re.S,
    )


def _reframe_card(card: str, source: dict[str, Any]) -> str:
    kind = esc(source.get("source_kind", ""))
    summary = esc(source.get("source_summary", ""))
    old_header = re.compile(
        r'<div class="passage-label">.*?</div>\s*<h2>.*?</h2>',
        flags=re.S,
    )
    card = old_header.sub(
        '<header class="source-result-header">'
        f'<div class="source-result-kind">{kind}</div>'
        '</header>',
        card,
        count=1,
    )

    # Avoid duplicating a summary if an earlier generator already placed the
    # same sentence as ordinary prose.
    summary_html = f'<p class="source-result-summary">{summary}</p>'
    card = card.replace(summary_html, "")

    # Mathematical statement must precede prose.  The final reader guarantees
    # source-formula coverage, so failure to find it is a validation error.
    formula = re.search(
        r'<div class="formula source-formula[^"]*"[^>]*>.*?</div>',
        card,
        flags=re.S,
    )
    if formula:
        insert_at = formula.end()
        card = card[:insert_at] + summary_html + card[insert_at:]
    return card


def _reframe_source_cards(output: Path, reader: Any) -> None:
    sources = reader._source_entries()
    by_section: dict[str, list[tuple[str, dict[str, Any]]]] = {}
    for source_id, source in sources.items():
        section = str(source.get("section", ""))
        if section in FORMULA_FIRST_SECTIONS:
            by_section.setdefault(section, []).append((source_id, source))

    errors: list[str] = []
    for section, entries in by_section.items():
        path = reader.base.section_path(output, section)
        if not path.exists():
            errors.append(f"missing canonical textbook section {section}")
            continue
        text = path.read_text(encoding="utf-8")
        for source_id, source in entries:
            pattern = _source_card_pattern(source_id)
            matches = list(pattern.finditer(text))
            if len(matches) != 1:
                errors.append(
                    f"{path.relative_to(output)}: expected one source card {source_id}; found {len(matches)}"
                )
                continue
            match = matches[0]
            card = _reframe_card(match.group(0), source)
            text = text[:match.start()] + card + text[match.end():]
        path.write_text(text, encoding="utf-8", newline="\n")
    if errors:
        raise RuntimeError("source-card textbook reframing failed:\n- " + "\n- ".join(errors))


def _inject_style(text: str, rel: Path) -> str:
    prefix = "../" * len(rel.parent.parts)
    href = f"{prefix}assets/{STYLE_NAME}"
    if href in text:
        return text
    return text.replace("</head>", f'  <link rel="stylesheet" href="{href}">\n</head>', 1)


def validate(output: Path, reader: Any) -> None:
    errors: list[str] = []
    sources = reader._source_entries()
    for source_id, source in sources.items():
        section = str(source.get("section", ""))
        if section not in FORMULA_FIRST_SECTIONS:
            continue
        path = reader.base.section_path(output, section)
        if not path.exists():
            continue
        text = path.read_text(encoding="utf-8")
        match = _source_card_pattern(source_id).search(text)
        if not match:
            errors.append(f"{path.relative_to(output)}: missing textbook source card {source_id}")
            continue
        card = match.group(0)
        formula_at = card.find("source-formula")
        summary_at = card.find("source-result-summary")
        if formula_at < 0:
            errors.append(f"{path.relative_to(output)}: {source_id} has no displayed source statement")
        if summary_at >= 0 and formula_at >= summary_at:
            errors.append(f"{path.relative_to(output)}: {source_id} prose precedes the statement formula")
        if re.search(r'<h2>\s*' + re.escape(esc(source.get("source_summary", ""))) + r'\s*</h2>', card):
            errors.append(f"{path.relative_to(output)}: {source_id} still uses prose summary as a giant heading")

    section_11 = output / "textbook" / "chapter-01" / "section-1-1.html"
    if section_11.exists():
        text = section_11.read_text(encoding="utf-8")
        martingale = _source_card_pattern("chewi-1-1-definition-1-1-4").search(text)
        if not martingale or "\\mathbb E[M_t\\mid\\mathcal F_s]=M_s" not in martingale.group(0):
            errors.append(
                "section-1-1.html: Definition 1.1.4 must display the conditional-expectation equation"
            )
        completion = _source_card_pattern("chewi-1-1-theorem-1-1-8").search(text)
        if not completion:
            errors.append("section-1-1.html: Theorem 1.1.8 source card is missing")
        else:
            card = completion.group(0)
            if 'data-source-proof="chewi-1-1-theorem-1-1-8"' not in card:
                errors.append("section-1-1.html: Theorem 1.1.8 equation proof is missing")
            if "\\eta^{(n)}-\\eta^{(m)}" not in card:
                errors.append("section-1-1.html: Theorem 1.1.8 L2-Cauchy equation is missing")
        if "For s &lt;= t, E[M_t | F_s] = M_s" in text or "For s <= t, E[M_t | F_s] = M_s" in text:
            errors.append("section-1-1.html: raw ASCII martingale equation leaked into prose")

    if errors:
        raise RuntimeError("textbook math contract failed:\n- " + "\n- ".join(errors))


def enrich_site(output: Path, reader: Any) -> None:
    _reframe_source_cards(output, reader)
    asset_dir = output / "assets"
    asset_dir.mkdir(parents=True, exist_ok=True)
    (asset_dir / STYLE_NAME).write_text(SOURCE_CSS.read_text(encoding="utf-8"), encoding="utf-8")
    for path in sorted(output.rglob("*.html")):
        rel = path.relative_to(output)
        text = path.read_text(encoding="utf-8")
        text = _inject_style(text, rel)
        path.write_text(text, encoding="utf-8", newline="\n")
    validate(output, reader)


if __name__ == "__main__":
    import reader_contract_final

    enrich_site(DEFAULT_OUTPUT, reader_contract_final)
