#!/usr/bin/env python3
"""Overlay primary-paper theorem/proof audits on generated SampleWiki reader pages.

The row manifest remains the provenance source of truth.  This layer records a
strictly stronger reading state: a primary theorem/corollary and its proof route
have actually been audited.  Missing audits remain visibly pending.
"""

from __future__ import annotations

import json
import re
from pathlib import Path
from typing import Any

import astis_site


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "_site"
AUDIT_PATH = ROOT / "website" / "content" / "samplewiki_frontier_audit.json"
CASES_PATH = ROOT / "research-wiki" / "source-index" / "SampleWiki_cases.json"
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


def case_path(case_id: str) -> str:
    value = case_id.removeprefix("ASTIS-SW-")
    return f"example-cases/samplewiki/cases/{slugify(value)}.html"


def proof_equations_html(audit: dict[str, Any]) -> str:
    rows: list[str] = []
    for index, raw in enumerate(audit.get("proof_equations", []), start=1):
        if not isinstance(raw, dict):
            continue
        rows.append(
            '<div class="sw-proof-step sw-source-proof-equation">'
            f'<span>{index:02d}</span>'
            f'<div><div class="formula sw-display">\\[{esc(raw.get("latex", ""))}\\]</div>'
            f'<p class="sw-equation-note">{esc(raw.get("meaning", ""))}</p></div>'
            '<code>source equation</code></div>'
        )
    if not rows:
        return '<p class="sw-truth-note">The exact source theorem is audited, but no additional proof equation is asserted here.</p>'
    return '<div class="sw-proof-steps">' + "".join(rows) + "</div>"


def audit_block(case_id: str, audit: dict[str, Any]) -> str:
    prerequisites = "".join(
        f"<li>{esc(item)}</li>" for item in audit.get("prerequisites", [])
    )
    return f"""
<section class="sw-source-theorem-audit" data-source-theorem-audit="{esc(case_id)}">
  <div class="section-heading"><span>Primary-source audit</span><h2>{esc(audit.get("theorem_label", "Source theorem"))}</h2></div>
  <dl class="sw-facts">
    <div><dt>Paper / book</dt><dd>{esc(audit.get("source_title", ""))}</dd></div>
    <div><dt>Version</dt><dd>{esc(audit.get("source_version", ""))}</dd></div>
    <div><dt>Audit</dt><dd><code>{esc(audit.get("audit_status", "pending"))}</code></dd></div>
    <div><dt>Source proof</dt><dd>{esc(audit.get("source_proof_status", "not audited"))}</dd></div>
    <div><dt>Formalization phase</dt><dd><code>{esc(audit.get("phase", ""))}</code></dd></div>
  </dl>
  <p><a class="text-link" href="{esc(audit.get("source_url", ""))}">Open exact primary source ↗</a></p>
  <div class="sw-proof-label">Source theorem statement</div>
  <div class="formula sw-display sw-source-theorem-statement">\\[{esc(audit.get("statement_latex", ""))}\\]</div>
  <div class="section-heading"><span>Equation-level proof map</span><h3>What the cited source actually uses</h3></div>
  {proof_equations_html(audit)}
  <div class="sw-two-column sw-audit-dependencies">
    <div><h3>Prerequisites before Lean assembly</h3><ul class="sw-open-interfaces">{prerequisites}</ul></div>
    <div><h3>Next Lean target</h3><p>{esc(audit.get("lean_target", ""))}</p></div>
  </div>
</section>
"""


def phase_plan_html(audit_registry: dict[str, Any]) -> str:
    cards: list[str] = []
    for raw in audit_registry.get("formalization_phases", []):
        if not isinstance(raw, dict):
            continue
        items = "".join(f"<li>{esc(item)}</li>" for item in raw.get("items", []))
        cards.append(
            '<article class="sw-frontier-card sw-formalization-phase">'
            f'<div class="sw-kicker">Phase {esc(raw.get("id", ""))} · {esc(raw.get("status", ""))}</div>'
            f'<h2>{esc(raw.get("title", ""))}</h2><ol class="sw-proof-route">{items}</ol></article>'
        )
    return f"""
<section class="sw-formalization-roadmap" data-samplewiki-formalization-roadmap="true">
  <div class="section-heading"><span>Dependency order</span><h2>Formalize shared mathematics before frontier assemblies.</h2></div>
  <p class="sw-truth-note">The order below is a theorem-DAG order, not a ranking of papers. A frontier result waits when it depends on an unfinished Chewi or shared Samplinglib node.</p>
  <div class="sw-frontier-grid">{''.join(cards)}</div>
</section>
"""


def replace_generic_proof(text: str, block: str) -> tuple[str, bool]:
    pattern = re.compile(
        r'<section>\s*<div class="section-heading"><span>Proof availability</span>'
        r'<h2>Not yet normalized in ASTIS</h2></div>.*?</section>',
        flags=re.S,
    )
    if pattern.search(text):
        return pattern.sub(lambda _m: block, text, count=1), True
    return text, False


def inject_after_statement(text: str, block: str) -> str:
    pattern = re.compile(r'(<section class="sw-statement">.*?</section>)', flags=re.S)
    if not pattern.search(text):
        raise RuntimeError("SampleWiki statement section missing while injecting source audit")
    return pattern.sub(lambda m: m.group(1) + block, text, count=1)


def enrich_site(output: Path = DEFAULT_OUTPUT) -> None:
    registry = load_object(AUDIT_PATH)
    manifest = load_object(CASES_PATH)
    cases = [dict(item) for item in manifest.get("cases", []) if isinstance(item, dict)]
    known_ids = {str(case.get("id", "")) for case in cases}
    audits = registry.get("case_audits", {})
    if not isinstance(audits, dict):
        raise RuntimeError("samplewiki_frontier_audit.case_audits must be an object")

    errors: list[str] = []
    rendered = 0
    for case_id, raw in audits.items():
        if not isinstance(raw, dict):
            errors.append(f"{case_id}: audit must be an object")
            continue
        if case_id not in known_ids:
            errors.append(f"{case_id}: audited case is not in the pinned 34-row manifest")
            continue
        for field in ("theorem_label", "source_title", "source_url", "statement_latex", "audit_status", "source_proof_status", "lean_target", "phase"):
            if not str(raw.get(field, "")).strip():
                errors.append(f"{case_id}: missing audit field {field}")
        path = output / case_path(case_id)
        if not path.exists():
            errors.append(f"{case_id}: generated case page missing")
            continue
        text = path.read_text(encoding="utf-8")
        block = audit_block(case_id, raw)
        text, replaced = replace_generic_proof(text, block)
        if not replaced:
            text = inject_after_statement(text, block)
        path.write_text(text, encoding="utf-8", newline="\n")
        rendered += 1

    progress = output / PROGRESS
    if not progress.exists():
        errors.append("SampleWiki progress page missing")
    else:
        text = progress.read_text(encoding="utf-8")
        marker = '<section>\n  <div class="section-heading"><span>All rows</span>'
        if marker not in text:
            errors.append("SampleWiki progress page All rows marker missing")
        else:
            text = text.replace(marker, phase_plan_html(registry) + marker, 1)
            progress.write_text(text, encoding="utf-8", newline="\n")

    # Reader-level truth contract for this first source-audit packet.
    if rendered < 6:
        errors.append(f"expected at least 6 audited frontier cases in the first packet, rendered {rendered}")
    if progress.exists():
        progress_text = progress.read_text(encoding="utf-8")
        for phase in "ABCDEFGHI":
            if f"Phase {phase}" not in progress_text:
                errors.append(f"SampleWiki dependency roadmap missing Phase {phase}")

    for case_id, raw in audits.items():
        path = output / case_path(case_id)
        if not path.exists():
            continue
        text = path.read_text(encoding="utf-8")
        for marker in (
            f'data-source-theorem-audit="{case_id}"',
            str(raw.get("theorem_label", "")),
            str(raw.get("source_proof_status", "")),
            "Source theorem statement",
            "Next Lean target",
        ):
            if marker not in text:
                errors.append(f"{case_id}: generated source audit missing {marker!r}")

    omitted_id = "ASTIS-SW-SETTING-HOLDER-SMOOTH-LOG-CONCAVE-BEST-UPPER-FORS-PROXIMAL-SAMPLER"
    omitted_path = output / case_path(omitted_id)
    if omitted_path.exists() and "proof omitted" not in omitted_path.read_text(encoding="utf-8"):
        errors.append("G.1(3): source proof omission must remain explicit")

    if errors:
        raise RuntimeError("SampleWiki frontier audit validation failed:\n- " + "\n- ".join(errors))


if __name__ == "__main__":
    enrich_site()
