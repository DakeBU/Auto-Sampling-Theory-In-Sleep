#!/usr/bin/env python3
"""Add the live SampleWiki Example Cases chapter to the generated ASTIS site."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any

import astis_site

ROOT = Path(__file__).resolve().parents[2]
CONFIG_PATH = ROOT / "website" / "content" / "samplewiki_example_cases.json"
MANIFEST_PATH = ROOT / "research-wiki" / "source-index" / "SampleWiki_manifest.json"
CASES_PATH = ROOT / "research-wiki" / "source-index" / "SampleWiki_cases.json"


def load_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))


def object_state(path: Path) -> dict[str, Any] | None:
    if not path.exists():
        return None
    raw = load_json(path)
    return raw if isinstance(raw, dict) else None


def lifecycle_html(stages: list[str]) -> str:
    rows = []
    explanations = {
        "discovered": "The watcher found a page or result row.",
        "sourcePinned": "URL and cryptographic source fingerprints are fixed.",
        "normalized": "ASTIS writes an original mathematical restatement and assumption audit.",
        "leanTarget": "The exact Lean proposition and reusable leaf boundary are chosen.",
        "compiled": "The pinned Lean toolchain accepts the proof.",
        "sourceReviewed": "A reviewer checks theorem meaning against the pinned source.",
        "assimilated": "The theorem and proof-technique leaves enter the reusable ASTIS graph.",
    }
    for index, stage in enumerate(stages, start=1):
        rows.append(
            f"""<article class="info-card">
  <div class="depth-number">{index:02d}</div>
  <h3><code>{astis_site.esc(stage)}</code></h3>
  <p>{astis_site.esc(explanations.get(stage, ""))}</p>
</article>"""
        )
    return "".join(rows)


def page_rows(manifest: dict[str, Any]) -> str:
    pages = [page for page in manifest.get("pages", []) if isinstance(page, dict)]
    if not pages:
        return '<p class="muted">No source pages are present in the committed snapshot.</p>'
    rows = []
    for page in pages[:80]:
        title = str(page.get("title") or page.get("url") or "Untitled page")
        url = str(page.get("url", ""))
        headings = page.get("headings", [])
        heading_text = " · ".join(
            str(item.get("text", ""))
            for item in headings[:4]
            if isinstance(item, dict) and item.get("text")
        )
        rows.append(
            "<tr>"
            f'<td><a href="{astis_site.esc(url)}">{astis_site.esc(title)}</a></td>'
            f"<td>{astis_site.esc(heading_text or '—')}</td>"
            f"<td><code>{astis_site.esc(str(page.get('visible_text_sha256', ''))[:12])}</code></td>"
            "</tr>"
        )
    return (
        '<div class="table-wrap"><table><thead><tr>'
        "<th>Source page</th><th>Headings</th><th>Text fingerprint</th>"
        "</tr></thead><tbody>"
        + "".join(rows)
        + "</tbody></table></div>"
    )


def case_rows(cases_manifest: dict[str, Any]) -> str:
    cases = [case for case in cases_manifest.get("cases", []) if isinstance(case, dict)]
    if not cases:
        return '<p class="muted">No row-level cases are present in the committed case manifest.</p>'
    rows = []
    for case in cases[:100]:
        url = str(case.get("source_page", ""))
        case_id = str(case.get("id", ""))
        model = str(case.get("algorithm_or_model", ""))
        setting = str(case.get("setting_title", case.get("setting_slug", "")))
        result_class = str(case.get("result_class", ""))
        review = str(case.get("review_state", ""))
        stage = str(case.get("verification_stage", "sourcePinned"))
        row_hash = str(case.get("row_sha256", ""))[:12]
        rows.append(
            "<tr>"
            f'<td><a href="{astis_site.esc(url)}"><code>{astis_site.esc(case_id)}</code></a></td>'
            f"<td>{astis_site.esc(setting)}</td>"
            f"<td>{astis_site.esc(result_class)}</td>"
            f"<td>{astis_site.esc(model)}</td>"
            f"<td>{astis_site.esc(review)}</td>"
            f"<td><code>{astis_site.esc(stage)}</code></td>"
            f"<td><code>{astis_site.esc(row_hash)}</code></td>"
            "</tr>"
        )
    return (
        '<div class="table-wrap"><table><thead><tr>'
        "<th>Case ID</th><th>Setting</th><th>Class</th><th>Algorithm / model</th>"
        "<th>Upstream review mark</th><th>ASTIS stage</th><th>Row fingerprint</th>"
        "</tr></thead><tbody>"
        + "".join(rows)
        + "</tbody></table></div>"
    )


def render_chapter(
    config: dict[str, Any],
    manifest: dict[str, Any] | None,
    cases_manifest: dict[str, Any] | None,
) -> str:
    page_count = 0 if manifest is None else int(manifest.get("page_count", 0))
    case_count = 0 if cases_manifest is None else int(cases_manifest.get("case_count", 0))
    tree_hash = "" if cases_manifest is None else str(cases_manifest.get("case_tree_sha256", ""))

    if manifest is None and cases_manifest is None:
        source_state = """
<section class="note">
  <h2>Bootstrap source state</h2>
  <p>No committed SampleWiki source manifests exist yet. This means the watcher
  has not produced its first accepted snapshot on this branch; it is not a
  claim that SampleWiki is empty or offline. ASTIS therefore makes no
  mathematical claim about current SampleWiki cases on this page.</p>
</section>
"""
    else:
        source_state = """
<section class="note">
  <h2>Committed source state</h2>
  <p>The inventories below come from deterministic SampleWiki watchers. They are
  provenance metadata, not proof certificates. A changed result-row fingerprint
  reopens ASTIS triage and semantic review even when an older Lean declaration
  still compiles.</p>
</section>
"""

    metrics = f"""
<div class="metric-row">
  <div><strong>{page_count if manifest is not None else '—'}</strong><span>pinned pages</span></div>
  <div><strong>{case_count if cases_manifest is not None else '—'}</strong><span>row-level cases</span></div>
  <div><strong>{7 if cases_manifest is not None else '—'}</strong><span>tracked settings</span></div>
  <div><strong><code>{astis_site.esc(tree_hash[:12]) if tree_hash else 'pending'}</code></strong><span>case-tree fingerprint</span></div>
</div>
"""

    if cases_manifest is None:
        case_inventory = (
            '<p class="muted">The row-level case inventory appears after the first '
            "committed SampleWiki case snapshot. The source watcher still keeps "
            "crawl provenance separate from mathematical verification.</p>"
        )
    else:
        case_inventory = case_rows(cases_manifest)

    if manifest is None:
        page_inventory = (
            '<p class="muted">The source-page inventory appears after the first '
            "committed crawl snapshot.</p>"
        )
    else:
        page_inventory = page_rows(manifest)

    body = f"""
<section class="page-hero compact">
  <div class="eyebrow">Parallel chapter · live external examples · source-to-Lean</div>
  <h1>{astis_site.esc(config["title"])}</h1>
  <p class="lede">{astis_site.esc(config["goal"])}</p>
  <p><a class="button primary" href="{astis_site.esc(config["source_url"])}">Open SampleWiki ↗</a></p>
  {metrics}
</section>
{source_state}
<section>
  <div class="section-heading"><span>Truth boundary</span><h2>Seven gates, not one “verified” badge</h2></div>
  <p>{astis_site.esc(config["admission_rule"])}</p>
  <div class="card-grid four">{lifecycle_html(list(config["lifecycle"]))}</div>
</section>
<section>
  <div class="section-heading"><span>Live result frontier</span><h2>One comparison-table row = one ASTIS source case</h2></div>
  <p>SampleWiki is organized by sampling assumptions and comparison tables. The
  case watcher therefore pins each result row separately: its setting, result
  class, algorithm/model, source review mark, source links, and row fingerprint.
  A source-pinned row is still not a Lean theorem until the later gates pass.</p>
  {case_inventory}
</section>
<section>
  <div class="section-heading"><span>Source graph</span><h2>Same-origin pages behind the cases</h2></div>
  <p>The crawler separately records bounded page structure and cryptographic
  fingerprints. This lets ASTIS distinguish a navigation/prose edit from a
  changed mathematical row instead of treating the whole website as one blob.</p>
  {page_inventory}
</section>
<section class="two-column">
  <div>
    <h2>How one case becomes Lean</h2>
    {astis_site.list_html([
        "Pin the exact comparison-table result row and its source references.",
        "Write an original ASTIS mathematical restatement.",
        "Audit visible and hidden assumptions.",
        "Search Mathlib and Samplinglib before adding a leaf.",
        "Formalize missing reusable leaves bottom-up.",
        "Compile a thin source-facing assembly theorem.",
        "Review semantic fidelity against the pinned source.",
        "Assimilate theorem and proof-technique nodes into the shared DAG.",
    ])}
  </div>
  <div>
    <h2>Parallel-lane rule</h2>
    <p>{astis_site.esc(config["parallel_policy"])}</p>
    <p>The Example Cases lane may therefore keep advancing on source cases that
    depend only on stable <code>main</code> declarations while Chapter 1.1 and
    Chapter 1.2–1.3 continue independently.</p>
  </div>
</section>
<section class="note">
  <h2>What counts as progress?</h2>
  <p>A new source row is discovery progress. A source-pinned ASTIS restatement
  is specification progress. A compiled Lean theorem is formal proof progress.
  Semantic source review is fidelity progress. Only assimilation makes the
  theorem and its proof technique part of the reusable Samplinglib scientific
  graph. These states remain visible separately.</p>
</section>
"""
    return astis_site.page(
        str(config["title"]),
        "example-cases/samplewiki.html",
        body,
        description=(
            "Live SampleWiki result-to-Lean formalization lane for ASTIS and Samplinglib"
        ),
        active="Textbook",
    )


def inject_chapter_link(path: Path, href: str) -> None:
    if not path.exists():
        return
    text = path.read_text(encoding="utf-8")
    if 'data-samplewiki-example-cases="true"' in text:
        return
    block = f"""
<section data-samplewiki-example-cases="true" class="note">
  <div class="section-heading"><span>Parallel Example Cases</span><h2>SampleWiki → reviewed Lean cases</h2></div>
  <p>Track the live comparison frontier without collapsing source discovery,
  Lean compilation, semantic review, and DAG assimilation.</p>
  <p><a class="text-link" href="{astis_site.esc(href)}">Open the SampleWiki Example Cases chapter →</a></p>
</section>
"""
    marker = "</main>"
    if marker not in text:
        raise RuntimeError(f"cannot inject SampleWiki chapter link into {path}")
    path.write_text(text.replace(marker, block + marker, 1), encoding="utf-8", newline="\n")


def enrich_site(output: Path) -> None:
    config_raw = load_json(CONFIG_PATH)
    if not isinstance(config_raw, dict):
        raise RuntimeError("samplewiki_example_cases.json must be an object")
    config: dict[str, Any] = config_raw
    manifest = object_state(MANIFEST_PATH)
    cases_manifest = object_state(CASES_PATH)

    astis_site.write_page(
        output,
        "example-cases/samplewiki.html",
        render_chapter(config, manifest, cases_manifest),
    )
    inject_chapter_link(output / "index.html", "example-cases/samplewiki.html")
    inject_chapter_link(
        output / "textbook" / "index.html",
        "../example-cases/samplewiki.html",
    )
    inject_chapter_link(
        output / "learning-path" / "index.html",
        "../example-cases/samplewiki.html",
    )

    site_data_path = output / "data" / "site-data.json"
    site_data = load_json(site_data_path)
    if not isinstance(site_data, dict):
        raise RuntimeError("generated site-data.json must be an object")
    site_data["samplewiki_example_cases"] = {
        "id": config["id"],
        "source_url": config["source_url"],
        "lane_status": config["lane_status"],
        "source_manifest_present": manifest is not None,
        "case_manifest_present": cases_manifest is not None,
        "source_tree_sha256": "" if manifest is None else manifest.get("tree_sha256", ""),
        "case_tree_sha256": "" if cases_manifest is None else cases_manifest.get("case_tree_sha256", ""),
        "page_count": 0 if manifest is None else manifest.get("page_count", 0),
        "case_count": 0 if cases_manifest is None else cases_manifest.get("case_count", 0),
        "setting_count": 0 if cases_manifest is None else cases_manifest.get("setting_count", 0),
        "page": "example-cases/samplewiki.html",
    }
    site_data_path.write_text(
        json.dumps(site_data, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
        newline="\n",
    )
