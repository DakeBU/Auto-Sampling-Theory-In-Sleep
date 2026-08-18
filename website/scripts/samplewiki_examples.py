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


def load_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))


def manifest_state() -> dict[str, Any] | None:
    if not MANIFEST_PATH.exists():
        return None
    raw = load_json(MANIFEST_PATH)
    return raw if isinstance(raw, dict) else None


def lifecycle_html(stages: list[str]) -> str:
    rows = []
    explanations = {
        "discovered": "The watcher found a page or semantic block.",
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


def candidate_rows(manifest: dict[str, Any]) -> str:
    candidates = [
        page
        for page in manifest.get("pages", [])
        if isinstance(page, dict) and page.get("candidate_kinds")
    ]
    if not candidates:
        return (
            '<p class="muted">The committed snapshot contains no automatically '
            "classified candidate page. This does not prove that the source has "
            "no mathematical cases; semantic review may still identify them.</p>"
        )
    rows = []
    for page in candidates[:60]:
        title = str(page.get("title") or page.get("url") or "Untitled page")
        url = str(page.get("url", ""))
        kinds = ", ".join(str(value) for value in page.get("candidate_kinds", []))
        block_count = len(page.get("semantic_blocks", []))
        rows.append(
            "<tr>"
            f'<td><a href="{astis_site.esc(url)}">{astis_site.esc(title)}</a></td>'
            f"<td>{astis_site.esc(kinds)}</td>"
            f"<td>{block_count}</td>"
            f"<td><code>{astis_site.esc(str(page.get('visible_text_sha256', ''))[:12])}</code></td>"
            "</tr>"
        )
    suffix = ""
    if len(candidates) > 60:
        suffix = (
            f'<p class="muted">Showing 60 of {len(candidates)} automatically '
            "classified candidate pages.</p>"
        )
    return (
        '<div class="table-wrap"><table><thead><tr>'
        "<th>Source page</th><th>Detected kinds</th><th>Semantic blocks</th>"
        "<th>Text fingerprint</th></tr></thead><tbody>"
        + "".join(rows)
        + "</tbody></table></div>"
        + suffix
    )


def render_chapter(config: dict[str, Any], manifest: dict[str, Any] | None) -> str:
    if manifest is None:
        source_state = """
<section class="note">
  <h2>Bootstrap source state</h2>
  <p>No committed SampleWiki source manifest exists yet. This means the watcher
  has not produced its first accepted snapshot on this branch; it is not a
  claim that SampleWiki is empty or offline. ASTIS therefore makes no
  mathematical claim about current SampleWiki cases on this page.</p>
</section>
"""
        metrics = """
<div class="metric-row">
  <div><strong>—</strong><span>pinned pages</span></div>
  <div><strong>—</strong><span>candidate pages</span></div>
  <div><strong>—</strong><span>semantic blocks</span></div>
  <div><strong>pending</strong><span>tree fingerprint</span></div>
</div>
"""
        candidates = (
            '<p class="muted">Candidate inventory becomes visible after the '
            "first successful scheduled source snapshot.</p>"
        )
    else:
        truncated = bool(manifest.get("truncated"))
        source_state = f"""
<section class="note">
  <h2>Committed source state</h2>
  <p>The page inventory below comes from the deterministic SampleWiki watcher.
  It is provenance metadata, not a proof certificate. The crawl is
  <strong>{"truncated at the configured page cap" if truncated else "complete within the watcher boundary"}</strong>.
  Any source fingerprint change reopens triage before affected cases regain
  source-reviewed status.</p>
</section>
"""
        metrics = f"""
<div class="metric-row">
  <div><strong>{int(manifest.get("page_count", 0))}</strong><span>pinned pages</span></div>
  <div><strong>{int(manifest.get("candidate_page_count", 0))}</strong><span>candidate pages</span></div>
  <div><strong>{int(manifest.get("semantic_block_count", 0))}</strong><span>semantic blocks</span></div>
  <div><strong><code>{astis_site.esc(str(manifest.get("tree_sha256", ""))[:12])}</code></strong><span>tree fingerprint</span></div>
</div>
"""
        candidates = candidate_rows(manifest)

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
  <div class="section-heading"><span>Live inventory</span><h2>Automatically detected candidate pages</h2></div>
  <p>The watcher stores URLs, bounded headings, semantic-block metadata, and
  cryptographic fingerprints. It does not automatically copy an upstream proof
  into ASTIS or declare the page mathematically formalized.</p>
  {candidates}
</section>
<section class="two-column">
  <div>
    <h2>How one case becomes Lean</h2>
    {astis_site.list_html([
        "Pin the exact source page or semantic block.",
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
  <p>A new source URL is discovery progress. A source-pinned ASTIS restatement
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
            "Live SampleWiki problem-to-Lean formalization lane for ASTIS and Samplinglib"
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
  <p>Track a live stream of problems and proofs without collapsing source
  discovery, Lean compilation, semantic review, and DAG assimilation.</p>
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
    manifest = manifest_state()

    astis_site.write_page(
        output,
        "example-cases/samplewiki.html",
        render_chapter(config, manifest),
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
        "manifest_present": manifest is not None,
        "tree_sha256": "" if manifest is None else manifest.get("tree_sha256", ""),
        "page_count": 0 if manifest is None else manifest.get("page_count", 0),
        "candidate_page_count": (
            0 if manifest is None else manifest.get("candidate_page_count", 0)
        ),
        "semantic_block_count": (
            0 if manifest is None else manifest.get("semantic_block_count", 0)
        ),
        "page": "example-cases/samplewiki.html",
    }
    site_data_path.write_text(
        json.dumps(site_data, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
        newline="\n",
    )
