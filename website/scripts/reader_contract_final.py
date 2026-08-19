#!/usr/bin/env python3
"""Final public-reader contract for Samplinglib.

This wrapper deliberately separates presentation cleanup from source evidence.
It reuses ``math_first_reader`` for theorem/equation layout, then applies an
ASTIS-owned formula layer to canonical Chapter 1 source cards. Audited source
metadata is never rewritten: formula supplements are presentation restatements
keyed by stable source-correspondence ids.
"""

from __future__ import annotations

import json
import re
import shutil
from pathlib import Path
from typing import Any

import math_first_reader as base


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "_site"
SOURCE_CSS = ROOT / "website" / "static" / "reader-contract-final.css"
STYLE_NAME = "reader-contract-final.css"
DIAGNOSTIC = ROOT / ".astis" / "reader-contract-errors.txt"
FORMULA_SUPPLEMENTS = ROOT / "website" / "content" / "chapter1_formula_supplements.json"
SOURCE_CORRESPONDENCE = ROOT / "website" / "content" / "source_correspondence.json"
FORMULA_FIRST_SECTIONS = ("1.1", "1.2", "1.3", "1.4")


def _write_diagnostic(message: str) -> None:
    DIAGNOSTIC.parent.mkdir(parents=True, exist_ok=True)
    DIAGNOSTIC.write_text(message.rstrip() + "\n", encoding="utf-8")


def _load_list(path: Path) -> list[dict[str, Any]]:
    raw = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(raw, list):
        raise RuntimeError(f"{path.relative_to(ROOT)} must contain a JSON list")
    return [dict(item) for item in raw if isinstance(item, dict)]


def _source_entries() -> dict[str, dict[str, Any]]:
    entries = _load_list(SOURCE_CORRESPONDENCE)
    return {str(item.get("id", "")): item for item in entries if item.get("id")}


def _formula_supplements() -> dict[str, dict[str, Any]]:
    entries = _load_list(FORMULA_SUPPLEMENTS)
    return {str(item.get("id", "")): item for item in entries if item.get("id")}


def validate_page(path: Path, text: str) -> list[str]:
    errors: list[str] = []
    visible = base.visible_text(text)
    cjk = base.CJK_RE.search(visible)
    if cjk:
        start = max(0, cjk.start() - 60)
        errors.append(
            f"{path}: visible non-English/CJK text: "
            f"{visible[start:cjk.start() + 60]!r}"
        )
    if "**" in visible:
        errors.append(f"{path}: leaked Markdown bold marker '**'")
    if re.search(r"\bE\[\s*M_[^\]]*\|\s*F_", visible):
        errors.append(f"{path}: raw conditional-expectation formula leaked outside MathJax")
    return errors


def _safe_replace_lesson_block(text: str, rendered: str) -> str:
    """Replace generated lesson HTML without interpreting LaTeX backslashes."""
    pattern = re.compile(
        re.escape(base.LESSON_START) + r".*?" + re.escape(base.LESSON_END),
        re.S,
    )
    if pattern.search(text):
        return pattern.sub(lambda _match: rendered, text, count=1)
    marker = '<nav class="reader-pagination"'
    if marker not in text:
        raise RuntimeError("reader pagination marker missing while inserting theorem lessons")
    return text.replace(marker, rendered + "\n" + marker, 1)


def _patch_base_gate() -> None:
    # ``base.validate`` and ``base.enrich_site`` resolve these helpers by global
    # lookup. Patch only presentation hooks; source and Lean evidence stay intact.
    base.validate_page = validate_page
    base.replace_lesson_block = _safe_replace_lesson_block


def _remove_undergrad_ladders(output: Path) -> None:
    chapter = output / "textbook" / "chapter-01"
    for path in chapter.glob("section-*.html"):
        text = path.read_text(encoding="utf-8")
        text = base.strip_between(text, base.UNDERGRAD_START, base.UNDERGRAD_END)
        path.write_text(text, encoding="utf-8", newline="\n")


def _source_anchor(source: dict[str, Any]) -> str:
    return (
        '<section class="source-passage">'
        f'<div class="passage-label">{base.esc(source.get("source_kind", ""))}</div>'
        f'<h2>{base.esc(source.get("source_summary", ""))}</h2>'
    )


def _render_formula_supplement(source_id: str, supplement: dict[str, Any]) -> str:
    latex = str(supplement.get("formula", "")).strip()
    if not latex:
        raise RuntimeError(f"formula supplement {source_id} has an empty formula")
    return (
        f'<div class="formula source-formula formula-supplement" '
        f'data-source-formula="{base.esc(source_id)}">'
        f'\\[{base.esc(latex)}\\]</div>'
    )


def _inject_formula_supplements(output: Path) -> None:
    sources = _source_entries()
    supplements = _formula_supplements()
    errors: list[str] = []

    for source_id, supplement in supplements.items():
        source = sources.get(source_id)
        if source is None:
            errors.append(f"formula supplement has no source-correspondence item: {source_id}")
            continue
        section = str(source.get("section", ""))
        if section not in FORMULA_FIRST_SECTIONS:
            continue
        # An already audited latex_statement wins. Supplements only fill a
        # missing public display and never overwrite source evidence.
        if str(source.get("latex_statement", "")).strip():
            continue

        path = base.section_path(output, section)
        if not path.exists():
            errors.append(f"missing generated section for formula supplement {source_id}: {path}")
            continue
        text = path.read_text(encoding="utf-8")
        marker = f'data-source-formula="{base.esc(source_id)}"'
        if marker in text:
            continue
        anchor = _source_anchor(source)
        if anchor not in text:
            errors.append(
                f"{path.relative_to(output)}: cannot locate source card for formula supplement {source_id}"
            )
            continue
        replacement = (
            '<section class="source-passage formula-first-source" '
            f'data-source-id="{base.esc(source_id)}">'
            f'<div class="passage-label">{base.esc(source.get("source_kind", ""))}</div>'
            f'<h2>{base.esc(source.get("source_summary", ""))}</h2>'
            + _render_formula_supplement(source_id, supplement)
        )
        text = text.replace(anchor, replacement, 1)
        path.write_text(text, encoding="utf-8", newline="\n")

    if errors:
        raise RuntimeError("formula supplement injection failed:\n- " + "\n- ".join(errors))


def _move_existing_source_formulas_before_prose(output: Path) -> None:
    # The base generator historically emitted h2 -> prose -> formula. Canonical
    # mathematical reading is h2 -> formula -> one concise explanation.
    pattern = re.compile(
        r'(<section class="source-passage(?: [^"]*)?"[^>]*>'
        r'.*?<div class="passage-label">.*?</div><h2>.*?</h2>)'
        r'(<p>.*?</p>)'
        r'(<div class="formula source-formula(?: [^"]*)?"[^>]*>.*?</div>)'
        r'(</section>)',
        flags=re.S,
    )
    for section in FORMULA_FIRST_SECTIONS:
        path = base.section_path(output, section)
        if not path.exists():
            continue
        text = path.read_text(encoding="utf-8")
        text = pattern.sub(
            lambda match: match.group(1) + match.group(3) + match.group(2) + match.group(4),
            text,
        )
        path.write_text(text, encoding="utf-8", newline="\n")


def _collapse_supplemental_details(text: str) -> str:
    return text.replace(
        '<details class="reader-disclosure rigor-disclosure" open>',
        '<details class="reader-disclosure rigor-disclosure">',
    )


def _repair_exact_public_leaks(text: str) -> str:
    parts = re.split(
        r"(<(?:pre|code|script|style)\b[^>]*>.*?</(?:pre|code|script|style)>)",
        text,
        flags=re.S | re.I,
    )
    for index in range(0, len(parts), 2):
        segment = parts[index]
        segment = segment.replace(
            "For s <= t, E[M_t | F_s] = M_s",
            r"For \\(s\le t\\), \\(\mathbb E[M_t\mid\mathcal F_s]=M_s\\)",
        )
        segment = segment.replace(
            "E[M_t | F_s] = M_s",
            r"\\(\mathbb E[M_t\mid\mathcal F_s]=M_s\\)",
        )
        parts[index] = segment
    return "".join(parts)


def _inject_style(text: str, rel: Path) -> str:
    prefix = "../" * len(rel.parent.parts)
    href = f"{prefix}assets/{STYLE_NAME}"
    if href in text:
        return text
    return text.replace(
        "</head>",
        f'  <link rel="stylesheet" href="{href}">\n</head>',
        1,
    )


def _formula_coverage_errors(output: Path) -> list[str]:
    errors: list[str] = []
    sources = _source_entries()
    expected_by_section = {
        section: sum(1 for item in sources.values() if str(item.get("section", "")) == section)
        for section in FORMULA_FIRST_SECTIONS
    }
    card_pattern = re.compile(
        r'<section class="[^"]*\bsource-passage\b[^"]*"[^>]*>.*?</section>',
        flags=re.S,
    )
    for section in FORMULA_FIRST_SECTIONS:
        path = base.section_path(output, section)
        if not path.exists():
            errors.append(f"missing canonical formula-first section {section}")
            continue
        text = path.read_text(encoding="utf-8")
        cards = card_pattern.findall(text)
        expected = expected_by_section[section]
        if len(cards) != expected:
            errors.append(
                f"{path.relative_to(output)}: expected {expected} source cards, found {len(cards)}"
            )
        missing = [index + 1 for index, card in enumerate(cards) if "source-formula" not in card]
        if missing:
            errors.append(
                f"{path.relative_to(output)}: source cards without a displayed formula: {missing}"
            )
    return errors


def enrich_site(output: Path = DEFAULT_OUTPUT) -> None:
    if DIAGNOSTIC.exists():
        DIAGNOSTIC.unlink()
    try:
        _patch_base_gate()
        _remove_undergrad_ladders(output)
        base.enrich_site(output)

        # Complete the source-statement layer only after audited source cards
        # exist; the supplement registry never changes source provenance.
        _inject_formula_supplements(output)
        _move_existing_source_formulas_before_prose(output)

        asset_dir = output / "assets"
        asset_dir.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(SOURCE_CSS, asset_dir / STYLE_NAME)

        for path in sorted(output.rglob("*.html")):
            rel = path.relative_to(output)
            text = path.read_text(encoding="utf-8")
            text = _collapse_supplemental_details(text)
            text = _repair_exact_public_leaks(text)
            text = _inject_style(text, rel)
            path.write_text(text, encoding="utf-8", newline="\n")

        validate(output)
    except Exception as exc:
        _write_diagnostic(f"{type(exc).__name__}: {exc}")
        raise


def validate(output: Path = DEFAULT_OUTPUT) -> None:
    _patch_base_gate()
    try:
        base.validate(output)

        errors: list[str] = []
        css = output / "assets" / STYLE_NAME
        if not css.exists():
            errors.append(f"missing assets/{STYLE_NAME}")

        errors.extend(_formula_coverage_errors(output))

        for path in output.rglob("*.html"):
            rel = path.relative_to(output)
            text = path.read_text(encoding="utf-8")
            errors.extend(validate_page(rel, text))
            prefix = "../" * len(rel.parent.parts)
            if f"{prefix}assets/{STYLE_NAME}" not in text:
                errors.append(f"{rel}: final reader stylesheet missing")

        if errors:
            raise RuntimeError("final reader contract failed:\n- " + "\n- ".join(errors))
    except Exception as exc:
        _write_diagnostic(f"{type(exc).__name__}: {exc}")
        raise


if __name__ == "__main__":
    enrich_site()
