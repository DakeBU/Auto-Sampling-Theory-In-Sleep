#!/usr/bin/env python3
"""Build the reader-facing SampleWiki library from pinned source manifests.

The source watcher owns provenance.  This layer owns reading order only:
settings, row-level frontier statements, proof availability, and exact ASTIS
formalization status.  It never promotes a source-pinned row to a proved result.
"""

from __future__ import annotations

import json
import posixpath
import re
import shutil
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any

import astis_site


ROOT = Path(__file__).resolve().parents[2]
CONFIG_PATH = ROOT / "website" / "content" / "samplewiki_example_cases.json"
READER_PATH = ROOT / "website" / "content" / "samplewiki_reader.json"
MANIFEST_PATH = ROOT / "research-wiki" / "source-index" / "SampleWiki_manifest.json"
CASES_PATH = ROOT / "research-wiki" / "source-index" / "SampleWiki_cases.json"
SOURCE_STYLE = ROOT / "website" / "static" / "samplewiki-reader.css"
STYLE_NAME = "samplewiki-reader.css"

OVERVIEW = "example-cases/samplewiki.html"
PROGRESS = "example-cases/samplewiki/progress.html"
FRONTIER = "example-cases/samplewiki/frontier.html"


def load_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))


def load_object(path: Path) -> dict[str, Any]:
    raw = load_json(path)
    if not isinstance(raw, dict):
        raise RuntimeError(f"expected JSON object: {path}")
    return raw


def slugify(value: str) -> str:
    return re.sub(r"[^A-Za-z0-9]+", "-", value).strip("-").lower() or "case"


def case_slug(case_id: str) -> str:
    value = case_id
    prefix = "ASTIS-SW-"
    if value.startswith(prefix):
        value = value[len(prefix):]
    return slugify(value)


def setting_path(setting_slug: str) -> str:
    return f"example-cases/samplewiki/settings/{slugify(setting_slug)}.html"


def case_path(case_id: str) -> str:
    return f"example-cases/samplewiki/cases/{case_slug(case_id)}.html"


def href_from(current: str, target: str) -> str:
    start = posixpath.dirname(current) or "."
    return posixpath.relpath(target, start=start)


def esc(value: object) -> str:
    return astis_site.esc(value)


def source_refs(case: dict[str, Any]) -> list[dict[str, str]]:
    refs: list[dict[str, str]] = []
    for raw in case.get("source_refs", []):
        if isinstance(raw, dict) and raw.get("url"):
            refs.append(
                {
                    "label": str(raw.get("label") or raw.get("url")),
                    "url": str(raw.get("url")),
                }
            )
    return refs


def literature_open(case: dict[str, Any]) -> bool:
    return str(case.get("result_class", "")).strip().lower() == "lower unknown"


def source_review_label(case: dict[str, Any]) -> str:
    value = str(case.get("review_state", "")).strip()
    return value or "Unmarked"


def source_stage(case: dict[str, Any]) -> str:
    return str(case.get("verification_stage", "sourcePinned")) or "sourcePinned"


def claim_sentence(case: dict[str, Any]) -> str:
    setting = str(case.get("setting_title", "this setting"))
    model = str(case.get("algorithm_or_model", "the recorded method"))
    if literature_open(case):
        return (
            f"Open frontier under {setting}: SampleWiki records the matching lower-bound "
            f"problem for {model} as unknown."
        )
    return (
        f"Under {setting}, SampleWiki records the following comparison-row claim for "
        f"{model}."
    )


def expression_html(label: str, raw: object) -> str:
    value = str(raw or "").strip()
    if not value:
        value = "Not specified in the pinned row."
    if value.lower() == "unknown":
        return (
            '<div class="sw-expression sw-expression-open">'
            f"<span>{esc(label)}</span><strong>Unknown</strong></div>"
        )
    return (
        '<div class="sw-expression">'
        f"<span>{esc(label)}</span><div>{esc(value)}</div></div>"
    )


def compact_status(case: dict[str, Any], reader: dict[str, Any]) -> str:
    case_id = str(case.get("id", ""))
    if case_id == str(reader.get("active_case_id", "")):
        return "partial Lean proof"
    if literature_open(case):
        return "literature-open"
    return source_stage(case)


def proof_availability(case: dict[str, Any], reader: dict[str, Any]) -> str:
    if str(case.get("id", "")) == str(reader.get("active_case_id", "")):
        return "ASTIS proof segment available"
    if source_refs(case):
        return "source reference pinned"
    return "no primary proof source pinned"


def badges(case: dict[str, Any], reader: dict[str, Any]) -> str:
    bits = [
        f'<span class="sw-badge">{esc(str(case.get("result_class", "result")))}</span>',
        f'<span class="sw-badge sw-badge-muted">{esc(source_review_label(case))}</span>',
        f'<span class="sw-badge sw-badge-stage">{esc(compact_status(case, reader))}</span>',
    ]
    return '<div class="sw-badges">' + "".join(bits) + "</div>"


def source_links_html(case: dict[str, Any]) -> str:
    refs = source_refs(case)
    links = [
        f'<a href="{esc(str(case.get("source_page", "")))}">SampleWiki setting ↗</a>'
    ]
    links.extend(f'<a href="{esc(ref["url"])}">{esc(ref["label"])} ↗</a>' for ref in refs)
    return '<div class="sw-source-links">' + "".join(links) + "</div>"


def render_lifecycle(stages: list[str]) -> str:
    return (
        '<div class="sw-lifecycle">'
        + "".join(f"<span><code>{esc(stage)}</code></span>" for stage in stages)
        + "</div>"
    )


def setting_cards(
    current: str,
    pages: list[dict[str, Any]],
    cases_by_setting: dict[str, list[dict[str, Any]]],
    reader: dict[str, Any],
) -> str:
    cards: list[str] = []
    for page in pages:
        slug = str(page.get("setting_slug", ""))
        cases = cases_by_setting.get(slug, [])
        known = sum(not literature_open(case) for case in cases)
        open_count = sum(literature_open(case) for case in cases)
        partial = sum(compact_status(case, reader) == "partial Lean proof" for case in cases)
        cards.append(
            '<a class="sw-setting-card" href="'
            + esc(href_from(current, setting_path(slug)))
            + '">'
            + f'<span class="sw-setting-index">{len(cards)+1:02d}</span>'
            + f'<h2>{esc(page.get("setting_title", slug))}</h2>'
            + '<div class="sw-setting-counts">'
            + f"<span>{len(cases)} rows</span><span>{known} known/cited</span>"
            + (f"<span>{open_count} literature-open</span>" if open_count else "")
            + (f"<span>{partial} partial Lean proof</span>" if partial else "")
            + "</div></a>"
        )
    return '<div class="sw-setting-grid">' + "".join(cards) + "</div>"


def active_case_block(
    current: str,
    cases: list[dict[str, Any]],
    reader: dict[str, Any],
) -> str:
    active_id = str(reader.get("active_case_id", ""))
    case = next((item for item in cases if str(item.get("id", "")) == active_id), None)
    meta = reader.get("active_case", {})
    if not case or not isinstance(meta, dict):
        return '<p class="muted">No active formalization focus is registered.</p>'
    compiled = meta.get("compiled_segment", {})
    if not isinstance(compiled, dict):
        compiled = {}
    return f"""
<article class="sw-focus-card">
  <div class="sw-kicker">Current formalization focus</div>
  <h2>{esc(case.get("algorithm_or_model", "Active SampleWiki case"))}</h2>
  {badges(case, reader)}
  <div class="formula sw-display">\\[{esc(meta.get("statement_latex", ""))}\\]</div>
  <p>{esc(meta.get("statement_note", ""))}</p>
  <div class="sw-focus-row">
    <span><strong>{esc(compiled.get("status", "partial"))}</strong> {esc(compiled.get("title", ""))}</span>
    <span><strong>{len(meta.get("open_interfaces", []))}</strong> analytic interfaces remain</span>
  </div>
  <a class="text-link" href="{esc(href_from(current, case_path(active_id)))}">Read the theorem and proof frontier →</a>
</article>
"""


def overview_body(
    manifest: dict[str, Any],
    cases_manifest: dict[str, Any],
    config: dict[str, Any],
    reader: dict[str, Any],
) -> str:
    cases = [dict(x) for x in cases_manifest.get("cases", []) if isinstance(x, dict)]
    pages = [dict(x) for x in cases_manifest.get("pages", []) if isinstance(x, dict)]
    cases_by_setting: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for case in cases:
        cases_by_setting[str(case.get("setting_slug", ""))].append(case)
    open_count = sum(literature_open(case) for case in cases)
    referenced = sum(bool(source_refs(case)) for case in cases)
    stage_counts = Counter(source_stage(case) for case in cases)
    return f"""
<section class="page-hero compact sw-hero">
  <div class="eyebrow">SampleWiki · live sampling frontier</div>
  <h1>SampleWiki</h1>
  <p class="lede">Read the sampling frontier by assumptions. Every comparison-row claim has its own statement, provenance, proof availability, and ASTIS formalization status.</p>
  <div class="hero-actions">
    <a class="button primary" href="{esc(config.get("source_url", ""))}">Open SampleWiki ↗</a>
    <a class="button" href="{esc(href_from(OVERVIEW, PROGRESS))}">Current progress</a>
    <a class="button" href="{esc(href_from(OVERVIEW, FRONTIER))}">Open frontier</a>
  </div>
</section>
<section class="sw-metrics" aria-label="SampleWiki snapshot">
  <div><strong>{int(cases_manifest.get("setting_count", len(pages)))}</strong><span>settings</span></div>
  <div><strong>{int(cases_manifest.get("case_count", len(cases)))}</strong><span>source rows</span></div>
  <div><strong>{referenced}</strong><span>rows with references</span></div>
  <div><strong>{open_count}</strong><span>literature-open rows</span></div>
</section>
<section>
  <div class="section-heading"><span>Reading directory</span><h2>Choose the assumptions first.</h2></div>
  {setting_cards(OVERVIEW, pages, cases_by_setting, reader)}
</section>
<section>
  <div class="section-heading"><span>Lean frontier</span><h2>Current formalization focus</h2></div>
  {active_case_block(OVERVIEW, cases, reader)}
</section>
<section class="sw-two-column">
  <div>
    <div class="section-heading"><span>Source snapshot</span><h2>Pinned, not silently copied.</h2></div>
    <dl class="sw-facts">
      <div><dt>Pages</dt><dd>{int(manifest.get("page_count", 0))}</dd></div>
      <div><dt>Source tree</dt><dd><code>{esc(str(manifest.get("tree_sha256", ""))[:16])}</code></dd></div>
      <div><dt>Case tree</dt><dd><code>{esc(str(cases_manifest.get("case_tree_sha256", ""))[:16])}</code></dd></div>
      <div><dt>Row stage</dt><dd>{esc(", ".join(f"{k}: {v}" for k, v in sorted(stage_counts.items())))}</dd></div>
    </dl>
  </div>
  <div>
    <div class="section-heading"><span>Truth boundary</span><h2>Source status ≠ proof status.</h2></div>
    <p>A checked or cited paper is source evidence. A <code>sourcePinned</code> row is a reproducible claim. A compiled Lean segment proves only that segment. Scientific assimilation requires semantic source review.</p>
    {render_lifecycle([str(x) for x in config.get("lifecycle", [])])}
  </div>
</section>
"""


def progress_body(
    manifest: dict[str, Any],
    cases_manifest: dict[str, Any],
    reader: dict[str, Any],
) -> str:
    cases = [dict(x) for x in cases_manifest.get("cases", []) if isinstance(x, dict)]
    active_id = str(reader.get("active_case_id", ""))
    rows: list[str] = []
    for case in cases:
        cid = str(case.get("id", ""))
        rows.append(
            "<tr>"
            f'<td><a href="{esc(href_from(PROGRESS, case_path(cid)))}">{esc(case.get("algorithm_or_model", ""))}</a></td>'
            f"<td>{esc(case.get('setting_title', ''))}</td>"
            f"<td>{esc(case.get('result_class', ''))}</td>"
            f"<td>{esc(source_review_label(case))}</td>"
            f"<td><code>{esc(source_stage(case))}</code></td>"
            f"<td>{esc(compact_status(case, reader))}</td>"
            "</tr>"
        )
    active_case = next((c for c in cases if str(c.get("id", "")) == active_id), None)
    return f"""
<section class="page-hero compact sw-hero">
  <div class="eyebrow">SampleWiki · status</div>
  <h1>Current progress</h1>
  <p class="lede">The source frontier and the Lean frontier are tracked separately.</p>
  <p><a class="text-link" href="{esc(href_from(PROGRESS, OVERVIEW))}">← SampleWiki directory</a></p>
</section>
<section class="sw-metrics">
  <div><strong>{int(manifest.get("page_count", 0))}</strong><span>pinned pages</span></div>
  <div><strong>{int(cases_manifest.get("case_count", len(cases)))}</strong><span>row-level claims</span></div>
  <div><strong>{sum(literature_open(c) for c in cases)}</strong><span>literature-open</span></div>
  <div><strong>{1 if active_case else 0}</strong><span>cases with compiled proof segment</span></div>
</section>
<section>
  <div class="section-heading"><span>Formal proof frontier</span><h2>What is actually compiled?</h2></div>
  {active_case_block(PROGRESS, cases, reader)}
</section>
<section>
  <div class="section-heading"><span>All rows</span><h2>34 source claims, exact status</h2></div>
  <div class="table-wrap sw-progress-table"><table>
    <thead><tr><th>Claim</th><th>Setting</th><th>Class</th><th>Source review</th><th>Source stage</th><th>ASTIS proof status</th></tr></thead>
    <tbody>{''.join(rows)}</tbody>
  </table></div>
</section>
<section class="note">
  <h2>Snapshot identity</h2>
  <p><code>{esc(str(manifest.get("tree_sha256", "")))}</code><br><code>{esc(str(cases_manifest.get("case_tree_sha256", "")))}</code></p>
</section>
"""


def frontier_body(
    cases_manifest: dict[str, Any],
    reader: dict[str, Any],
) -> str:
    cases = [dict(x) for x in cases_manifest.get("cases", []) if isinstance(x, dict)]
    open_cases = [case for case in cases if literature_open(case)]
    active = reader.get("active_case", {})
    if not isinstance(active, dict):
        active = {}
    open_cards = []
    for case in open_cases:
        cid = str(case.get("id", ""))
        open_cards.append(
            f"""
<article class="sw-frontier-card">
  <div class="sw-kicker">{esc(case.get("setting_title", ""))}</div>
  <h2>{esc(case.get("algorithm_or_model", "Open lower bound"))}</h2>
  {expression_html("Target", case.get("guarantee"))}
  <p>No matching lower bound is pinned by SampleWiki. ASTIS preserves this row as <strong>literature-open</strong>; it is not replaced by a synthetic bound.</p>
  <a class="text-link" href="{esc(href_from(FRONTIER, case_path(cid)))}">Read the exact frontier row →</a>
</article>"""
        )
    interfaces = "".join(
        f"<li>{esc(item)}</li>" for item in active.get("open_interfaces", [])
    )
    return f"""
<section class="page-hero compact sw-hero">
  <div class="eyebrow">SampleWiki · open problems</div>
  <h1>Open frontier</h1>
  <p class="lede">Separate literature-open mathematical questions from ASTIS formalization gaps.</p>
  <p><a class="text-link" href="{esc(href_from(FRONTIER, OVERVIEW))}">← SampleWiki directory</a></p>
</section>
<section>
  <div class="section-heading"><span>Literature frontier</span><h2>{len(open_cases)} matching lower bounds remain unknown.</h2></div>
  <div class="sw-frontier-grid">{''.join(open_cards)}</div>
</section>
<section>
  <div class="section-heading"><span>Formalization frontier</span><h2>Ideal proximal chain: analytic bridge still open.</h2></div>
  <div class="formula sw-display">\\[{esc(active.get("statement_latex", ""))}\\]</div>
  <ul class="sw-open-interfaces">{interfaces}</ul>
  <p>The reciprocal-KL telescoping tail is compiled; these analytic interfaces are the remaining route to the full source theorem.</p>
  <a class="text-link" href="{esc(href_from(FRONTIER, case_path(str(reader.get("active_case_id", "")))))}">Open the active proof frontier →</a>
</section>
"""


def case_card(
    current: str,
    case: dict[str, Any],
    reader: dict[str, Any],
) -> str:
    cid = str(case.get("id", ""))
    return f"""
<article class="sw-case-card">
  <div class="sw-case-head">
    <div><div class="sw-kicker">{esc(case.get("result_class", ""))} · row {esc(case.get("source_row", ""))}</div>
    <h2>{esc(case.get("algorithm_or_model", ""))}</h2></div>
    {badges(case, reader)}
  </div>
  <p class="sw-claim">{esc(claim_sentence(case))}</p>
  <div class="sw-expression-grid">
    {expression_html("Complexity / rate", case.get("complexity"))}
    {expression_html("Guarantee / target", case.get("guarantee"))}
  </div>
  <div class="sw-case-footer"><span>{esc(proof_availability(case, reader))}</span>
  <a href="{esc(href_from(current, case_path(cid)))}">Read statement and proof status →</a></div>
</article>
"""


def setting_body(
    rel_path: str,
    setting: dict[str, Any],
    cases: list[dict[str, Any]],
    reader: dict[str, Any],
) -> str:
    open_count = sum(literature_open(case) for case in cases)
    return f"""
<section class="page-hero compact sw-hero">
  <div class="eyebrow">SampleWiki · setting</div>
  <h1>{esc(setting.get("setting_title", ""))}</h1>
  <p class="lede">{len(cases)} comparison-row claims under one assumption regime.</p>
  <div class="hero-actions">
    <a class="button primary" href="{esc(setting.get("source_page", ""))}">Open source setting ↗</a>
    <a class="button" href="{esc(href_from(rel_path, OVERVIEW))}">SampleWiki directory</a>
  </div>
</section>
<section class="sw-metrics">
  <div><strong>{len(cases)}</strong><span>rows</span></div>
  <div><strong>{sum(not literature_open(c) for c in cases)}</strong><span>known/cited rows</span></div>
  <div><strong>{open_count}</strong><span>literature-open rows</span></div>
  <div><strong>{sum(compact_status(c, reader) == "partial Lean proof" for c in cases)}</strong><span>partial Lean proofs</span></div>
</section>
<section>
  <div class="section-heading"><span>Frontier statements</span><h2>Results in source-table order</h2></div>
  <div class="sw-case-list">{''.join(case_card(rel_path, case, reader) for case in cases)}</div>
</section>
<section class="note">
  <h2>Setting provenance</h2>
  <p>Table fingerprint <code>{esc(str(setting.get("table_sha256", "")))}</code>. A changed fingerprint reopens source triage; it does not invalidate already-correct local Lean lemmas.</p>
</section>
"""


def active_proof_html(reader: dict[str, Any]) -> str:
    active = reader.get("active_case", {})
    if not isinstance(active, dict):
        return ""
    compiled = active.get("compiled_segment", {})
    if not isinstance(compiled, dict):
        compiled = {}
    route = "".join(
        f"<li>{esc(step)}</li>" for step in active.get("source_proof_route", [])
    )
    proof_steps = []
    for index, raw in enumerate(compiled.get("proof_steps", []), start=1):
        if not isinstance(raw, dict):
            continue
        proof_steps.append(
            '<div class="sw-proof-step">'
            f'<span>{index:02d}</span><div class="formula sw-display">\\[{esc(raw.get("latex", ""))}\\]</div>'
            f'<code>{esc(raw.get("lean", ""))}</code></div>'
        )
    interfaces = "".join(
        f"<li>{esc(item)}</li>" for item in active.get("open_interfaces", [])
    )
    return f"""
<section>
  <div class="section-heading"><span>Available natural-language proof</span><h2>Source proof route</h2></div>
  <ol class="sw-proof-route">{route}</ol>
</section>
<section>
  <div class="section-heading"><span>Compiled segment</span><h2>{esc(compiled.get("title", ""))}</h2></div>
  <p>Assume the analytic part has established the one-step inequality</p>
  <div class="formula sw-display">\\[{esc(compiled.get("hypothesis_latex", ""))}\\]</div>
  <div class="sw-proof-steps">{''.join(proof_steps)}</div>
  <p>Hence</p>
  <div class="formula sw-display sw-conclusion">\\[{esc(compiled.get("conclusion_latex", ""))}\\]</div>
  <p class="sw-lean-assembly">Lean assembly: <code>{esc(compiled.get("assembly_lean", ""))}</code></p>
</section>
<section>
  <div class="section-heading"><span>Remaining proof obligations</span><h2>Analytic interface</h2></div>
  <ul class="sw-open-interfaces">{interfaces}</ul>
</section>
"""


def generic_proof_html(case: dict[str, Any]) -> str:
    refs = source_refs(case)
    if refs:
        note = (
            "A source reference is pinned, but ASTIS has not yet normalized a natural-language "
            "proof skeleton for this row."
        )
    else:
        note = (
            "No primary proof source is pinned for this row. ASTIS therefore publishes no "
            "proof reconstruction."
        )
    return f"""
<section>
  <div class="section-heading"><span>Proof availability</span><h2>Not yet normalized in ASTIS</h2></div>
  <p>{esc(note)}</p>
</section>
<section>
  <div class="section-heading"><span>Lean status</span><h2>No source-facing proof yet</h2></div>
  <p><code>{esc(source_stage(case))}</code> · dependency status <code>{esc(case.get("dependency_status", "untriaged"))}</code>.</p>
</section>
"""


def case_body(
    rel_path: str,
    case: dict[str, Any],
    reader: dict[str, Any],
) -> str:
    cid = str(case.get("id", ""))
    active = cid == str(reader.get("active_case_id", ""))
    active_meta = reader.get("active_case", {}) if active else {}
    if not isinstance(active_meta, dict):
        active_meta = {}
    refs = source_refs(case)
    ref_rows = "".join(
        f'<li><a href="{esc(ref["url"])}">{esc(ref["label"])}</a></li>' for ref in refs
    ) or "<li>No primary reference pinned in this row.</li>"
    statement_formula = ""
    if active and active_meta.get("statement_latex"):
        statement_formula = (
            f'<div class="formula sw-display">\\[{esc(active_meta.get("statement_latex", ""))}\\]</div>'
        )
    open_label = (
        '<div class="sw-open-label">Literature-open: matching bound unknown</div>'
        if literature_open(case)
        else ""
    )
    proof = active_proof_html(reader) if active else generic_proof_html(case)
    return f"""
<section class="page-hero compact sw-hero">
  <div class="eyebrow">SampleWiki · {esc(case.get("setting_title", ""))}</div>
  <h1>{esc(case.get("algorithm_or_model", ""))}</h1>
  {badges(case, reader)}
  <p><a class="text-link" href="{esc(href_from(rel_path, setting_path(str(case.get("setting_slug", "")))))}">← {esc(case.get("setting_title", ""))}</a></p>
</section>
<section class="sw-statement">
  <div class="section-heading"><span>Source-pinned claim</span><h2>Statement</h2></div>
  {open_label}
  <p>{esc(claim_sentence(case))}</p>
  {statement_formula}
  <div class="sw-expression-grid">
    {expression_html("Complexity / rate", case.get("complexity"))}
    {expression_html("Guarantee / target", case.get("guarantee"))}
  </div>
  <p class="sw-truth-note">This is a reproducible SampleWiki row. Until semantic normalization is complete, ASTIS does not silently strengthen it into a reviewed theorem statement.</p>
</section>
{proof}
<section class="sw-two-column">
  <div>
    <div class="section-heading"><span>References</span><h2>Source trail</h2></div>
    <ul>{ref_rows}</ul>
    {source_links_html(case)}
  </div>
  <div>
    <div class="section-heading"><span>Provenance</span><h2>Exact row identity</h2></div>
    <dl class="sw-facts">
      <div><dt>Case ID</dt><dd><code>{esc(cid)}</code></dd></div>
      <div><dt>Row</dt><dd>{esc(case.get("source_row", ""))}</dd></div>
      <div><dt>Row SHA</dt><dd><code>{esc(str(case.get("row_sha256", ""))[:16])}</code></dd></div>
      <div><dt>ASTIS stage</dt><dd><code>{esc(source_stage(case))}</code></dd></div>
    </dl>
  </div>
</section>
"""


def add_style(text: str, rel_path: str) -> str:
    href = href_from(rel_path, f"assets/{STYLE_NAME}")
    if href in text:
        return text
    if "</head>" not in text:
        raise RuntimeError(f"cannot add SampleWiki reader stylesheet to {rel_path}")
    return text.replace(
        "</head>",
        f'  <link rel="stylesheet" href="{esc(href)}">\n</head>',
        1,
    )


def write_reader_page(
    output: Path,
    rel_path: str,
    title: str,
    body: str,
    description: str,
) -> None:
    text = astis_site.page(
        title,
        rel_path,
        body,
        description=description,
        active="Textbook",
    )
    astis_site.write_page(output, rel_path, add_style(text, rel_path))


def validate_site(
    output: Path,
    cases_manifest: dict[str, Any],
    reader: dict[str, Any],
) -> None:
    errors: list[str] = []
    cases = [dict(x) for x in cases_manifest.get("cases", []) if isinstance(x, dict)]
    pages = [dict(x) for x in cases_manifest.get("pages", []) if isinstance(x, dict)]
    expected = [OVERVIEW, PROGRESS, FRONTIER]
    expected.extend(setting_path(str(page.get("setting_slug", ""))) for page in pages)
    expected.extend(case_path(str(case.get("id", ""))) for case in cases)

    for rel_path in expected:
        path = output / rel_path
        if not path.exists():
            errors.append(f"missing SampleWiki reader page: {rel_path}")
            continue
        text = path.read_text(encoding="utf-8")
        if STYLE_NAME not in text:
            errors.append(f"{rel_path}: SampleWiki stylesheet missing")
        if "**" in text:
            errors.append(f"{rel_path}: leaked Markdown marker")

    overview = output / OVERVIEW
    if overview.exists():
        text = overview.read_text(encoding="utf-8")
        for marker in ("Choose the assumptions first.", "Current formalization focus", "Source status ≠ proof status."):
            if marker not in text:
                errors.append(f"{OVERVIEW}: missing reader marker {marker!r}")

    progress = output / PROGRESS
    if progress.exists() and progress.read_text(encoding="utf-8").count("<tr>") < len(cases):
        errors.append(f"{PROGRESS}: not all row-level cases appear in progress table")

    open_cases = [case for case in cases if literature_open(case)]
    frontier = output / FRONTIER
    if frontier.exists():
        text = frontier.read_text(encoding="utf-8")
        for case in open_cases:
            if str(case.get("algorithm_or_model", "")) not in text:
                errors.append(f"{FRONTIER}: literature-open case missing: {case.get('id')}")

    active_id = str(reader.get("active_case_id", ""))
    active_page = output / case_path(active_id)
    if active_page.exists():
        text = active_page.read_text(encoding="utf-8")
        for marker in (
            "Source proof route",
            "Reciprocal-KL telescoping tail",
            "linear_growth_of_step_growth",
            "reciprocal_growth_implies_inverse_time_bound",
            "IdealProximalChain.kl_rate_from_reciprocal_step",
            "Remaining proof obligations",
        ):
            if marker not in text:
                errors.append(f"{active_page.relative_to(output)}: missing active proof marker {marker!r}")

    if len(open_cases) != 4:
        errors.append(
            f"SampleWiki lower-unknown contract changed: expected 4 literature-open rows, found {len(open_cases)}"
        )
    if int(cases_manifest.get("case_count", len(cases))) != len(cases):
        errors.append("SampleWiki case_count does not match row inventory")
    if int(cases_manifest.get("setting_count", len(pages))) != len(pages):
        errors.append("SampleWiki setting_count does not match setting inventory")

    if errors:
        raise RuntimeError("SampleWiki reader validation failed:\n- " + "\n- ".join(errors))


def enrich_site(output: Path) -> None:
    config = load_object(CONFIG_PATH)
    reader = load_object(READER_PATH)
    manifest = load_object(MANIFEST_PATH)
    cases_manifest = load_object(CASES_PATH)

    cases = [dict(x) for x in cases_manifest.get("cases", []) if isinstance(x, dict)]
    pages = [dict(x) for x in cases_manifest.get("pages", []) if isinstance(x, dict)]
    cases_by_setting: dict[str, list[dict[str, Any]]] = defaultdict(list)
    for case in cases:
        cases_by_setting[str(case.get("setting_slug", ""))].append(case)

    asset_dir = output / "assets"
    asset_dir.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(SOURCE_STYLE, asset_dir / STYLE_NAME)

    write_reader_page(
        output,
        OVERVIEW,
        "SampleWiki",
        overview_body(manifest, cases_manifest, config, reader),
        "SampleWiki sampling frontier: settings, theorem claims, proof availability, and ASTIS Lean formalization status.",
    )
    write_reader_page(
        output,
        PROGRESS,
        "SampleWiki — Current progress",
        progress_body(manifest, cases_manifest, reader),
        "Current SampleWiki source snapshot and exact ASTIS formalization progress.",
    )
    write_reader_page(
        output,
        FRONTIER,
        "SampleWiki — Open frontier",
        frontier_body(cases_manifest, reader),
        "Literature-open SampleWiki questions and current ASTIS formalization gaps.",
    )

    for page in pages:
        setting_slug = str(page.get("setting_slug", ""))
        rel_path = setting_path(setting_slug)
        write_reader_page(
            output,
            rel_path,
            str(page.get("setting_title", setting_slug)),
            setting_body(rel_path, page, cases_by_setting.get(setting_slug, []), reader),
            f"SampleWiki setting: {page.get('setting_title', setting_slug)}.",
        )

    for case in cases:
        cid = str(case.get("id", ""))
        rel_path = case_path(cid)
        write_reader_page(
            output,
            rel_path,
            str(case.get("algorithm_or_model", cid)),
            case_body(rel_path, case, reader),
            f"SampleWiki source-pinned claim and ASTIS formalization status for {case.get('algorithm_or_model', cid)}.",
        )

    site_data_path = output / "data" / "site-data.json"
    site_data = load_object(site_data_path)
    site_data["samplewiki_example_cases"] = {
        "id": config.get("id", "samplewiki-example-cases"),
        "source_url": config.get("source_url", ""),
        "lane_status": config.get("lane_status", ""),
        "source_tree_sha256": manifest.get("tree_sha256", ""),
        "case_tree_sha256": cases_manifest.get("case_tree_sha256", ""),
        "page_count": manifest.get("page_count", 0),
        "case_count": cases_manifest.get("case_count", len(cases)),
        "setting_count": cases_manifest.get("setting_count", len(pages)),
        "literature_open_count": sum(literature_open(case) for case in cases),
        "active_case_id": reader.get("active_case_id", ""),
        "reader_pages": {
            "overview": OVERVIEW,
            "progress": PROGRESS,
            "frontier": FRONTIER,
        },
    }
    site_data_path.write_text(
        json.dumps(site_data, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
        newline="\n",
    )

    validate_site(output, cases_manifest, reader)
