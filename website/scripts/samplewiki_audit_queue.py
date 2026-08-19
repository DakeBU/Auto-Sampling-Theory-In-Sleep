#!/usr/bin/env python3
"""Render the 34-row primary-source audit queue on SampleWiki progress."""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any

import astis_site


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "_site"
CASES_PATH = ROOT / "research-wiki" / "source-index" / "SampleWiki_cases.json"
AUDIT_PATH = ROOT / "website" / "content" / "samplewiki_frontier_audit.json"
PROGRESS = "example-cases/samplewiki/progress.html"


def load_object(path: Path) -> dict[str, Any]:
    raw = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(raw, dict):
        raise RuntimeError(f"expected JSON object: {path}")
    return raw


def esc(value: object) -> str:
    return astis_site.esc(value)


def slugify(value: str) -> str:
    return re.sub(r"[^A-Za-z0-9]+", "-", value).strip("-").lower() or "case"


def case_href(case_id: str) -> str:
    value = case_id.removeprefix("ASTIS-SW-")
    return f"cases/{slugify(value)}.html"


def literature_open(case: dict[str, Any]) -> bool:
    return str(case.get("result_class", "")).strip().lower() == "lower unknown"


def source_label(case: dict[str, Any]) -> str:
    labels: list[str] = []
    for raw in case.get("source_refs", []):
        if isinstance(raw, dict):
            label = str(raw.get("label", "")).strip()
            if label:
                labels.append(label)
    return " · ".join(labels) if labels else "No primary theorem pinned"


def audit_state(case: dict[str, Any], audits: dict[str, Any]) -> tuple[str, str, str]:
    case_id = str(case.get("id", ""))
    if literature_open(case):
        return "literature-open", "No theorem: matching bound unknown", "—"
    raw = audits.get(case_id)
    if isinstance(raw, dict):
        return "audited", str(raw.get("theorem_label", "")), str(raw.get("phase", ""))
    return "audit pending", "Exact theorem/corollary pending", "after source audit"


def queue_html(cases: list[dict[str, Any]], audits: dict[str, Any]) -> str:
    rows: list[str] = []
    counts = {"audited": 0, "audit pending": 0, "literature-open": 0}
    for case in cases:
        state, theorem, phase = audit_state(case, audits)
        counts[state] += 1
        case_id = str(case.get("id", ""))
        rows.append(
            '<tr class="sw-source-audit-row" data-source-audit-state="'
            + esc(state)
            + '">'
            + f'<td><a href="{esc(case_href(case_id))}">{esc(case.get("algorithm_or_model", ""))}</a></td>'
            + f'<td>{esc(case.get("setting_title", ""))}</td>'
            + f'<td>{esc(source_label(case))}</td>'
            + f'<td><strong>{esc(state)}</strong></td>'
            + f'<td>{esc(theorem)}</td>'
            + f'<td><code>{esc(phase)}</code></td>'
            + '</tr>'
        )
    return f"""
<section class="sw-source-audit-queue" data-samplewiki-audit-queue="true">
  <div class="section-heading"><span>Literature audit</span><h2>34-row primary-source theorem queue</h2></div>
  <p class="sw-truth-note">A pinned comparison row is not yet an audited theorem. This table separates exact theorem/proof reading from Lean formalization.</p>
  <section class="sw-metrics" aria-label="Primary-source audit coverage">
    <div><strong>{counts['audited']}</strong><span>theorem/proof audited</span></div>
    <div><strong>{counts['audit pending']}</strong><span>exact theorem audit pending</span></div>
    <div><strong>{counts['literature-open']}</strong><span>literature-open</span></div>
    <div><strong>{len(cases)}</strong><span>total SampleWiki rows</span></div>
  </section>
  <div class="table-wrap sw-progress-table"><table>
    <thead><tr><th>Bound / method</th><th>Setting</th><th>Pinned paper / theorem trail</th><th>Source audit</th><th>Exact theorem</th><th>Phase</th></tr></thead>
    <tbody>{''.join(rows)}</tbody>
  </table></div>
</section>
"""


def enrich_site(output: Path = DEFAULT_OUTPUT) -> None:
    cases_manifest = load_object(CASES_PATH)
    registry = load_object(AUDIT_PATH)
    cases = [dict(item) for item in cases_manifest.get("cases", []) if isinstance(item, dict)]
    audits = registry.get("case_audits", {})
    if not isinstance(audits, dict):
        raise RuntimeError("samplewiki_frontier_audit.case_audits must be an object")

    path = output / PROGRESS
    if not path.exists():
        raise RuntimeError("generated SampleWiki progress page is missing")
    text = path.read_text(encoding="utf-8")
    if 'data-samplewiki-audit-queue="true"' not in text:
        marker = '<section class="sw-formalization-roadmap"'
        position = text.find(marker)
        if position < 0:
            raise RuntimeError("SampleWiki dependency roadmap marker missing")
        text = text[:position] + queue_html(cases, audits) + text[position:]
        path.write_text(text, encoding="utf-8", newline="\n")

    final = path.read_text(encoding="utf-8")
    errors: list[str] = []
    if final.count('class="sw-source-audit-row"') != len(cases):
        errors.append("primary-source audit queue does not contain all 34 rows")
    expected_audited = sum(isinstance(audits.get(str(case.get("id", ""))), dict) for case in cases)
    expected_open = sum(literature_open(case) for case in cases)
    expected_pending = len(cases) - expected_audited - expected_open
    for marker in (
        f'<strong>{expected_audited}</strong><span>theorem/proof audited</span>',
        f'<strong>{expected_pending}</strong><span>exact theorem audit pending</span>',
        f'<strong>{expected_open}</strong><span>literature-open</span>',
    ):
        if marker not in final:
            errors.append(f"SampleWiki audit queue missing coverage marker: {marker}")
    if errors:
        raise RuntimeError("SampleWiki primary-source audit queue failed:\n- " + "\n- ".join(errors))


if __name__ == "__main__":
    enrich_site()
