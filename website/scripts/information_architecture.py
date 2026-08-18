#!/usr/bin/env python3
"""Apply the reader-first Samplinglib information architecture after site generation."""

from __future__ import annotations

import json
import re
import shutil
from html import escape
from pathlib import Path
from typing import Any

import astis_site


ROOT = Path(__file__).resolve().parents[2]
SOURCE_EDITION = ROOT / "website" / "content" / "source_edition.json"
SOURCE_CSS = ROOT / "website" / "static" / "information-architecture.css"
SAMPLEWIKI_CASES = ROOT / "research-wiki" / "source-index" / "SampleWiki_cases.json"
STYLE_NAME = "information-architecture.css"
IA_VERSION = "2"


def load_json(path: Path) -> dict[str, Any]:
    raw = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(raw, dict):
        raise RuntimeError(f"expected JSON object: {path}")
    return raw


def rel_prefix(rel_path: str) -> str:
    parent = Path(rel_path).parent
    return "../" * len(parent.parts)


def normalized_rel(path: Path, output: Path) -> str:
    return path.relative_to(output).as_posix()


def exact_current(rel_path: str, target: str) -> str:
    return ' aria-current="page"' if rel_path == target else ""


def source_current(rel_path: str, source: str) -> str:
    if source == "book":
        active = (
            rel_path.startswith("textbook/")
            or rel_path in {"learning-path/index.html", "calculation-route.html", "rigorous-details.html"}
        )
    else:
        active = rel_path.startswith("example-cases/samplewiki")
    return ' aria-current="page"' if active else ""


def current_chapter(rel_path: str) -> int | None:
    match = re.search(r"textbook/chapter-(\d{2})", rel_path)
    return int(match.group(1)) if match else None


def chapter_toc(edition: dict[str, Any], rel_path: str, prefix: str) -> str:
    chapters = [dict(item) for item in edition.get("chapters", [])]
    parts = [dict(item) for item in edition.get("parts", [])]
    current = current_chapter(rel_path)
    rows: list[str] = []

    for part_index, part in enumerate(parts):
        start = int(part["book_page"])
        stop = int(parts[part_index + 1]["book_page"]) if part_index + 1 < len(parts) else 10**9
        part_chapters = [ch for ch in chapters if start <= int(ch["book_page"]) < stop]
        if not part_chapters:
            continue
        rows.append(
            f'<div class="toc-part compact"><span>Part {int(part["number"])}</span>{escape(str(part["title"]))}</div>'
        )
        for chapter in part_chapters:
            number = int(chapter["number"])
            chapter_path = f"textbook/chapter-{number:02d}.html"
            active = ' aria-current="page"' if current == number and rel_path == chapter_path else ""
            rows.append(
                f'<a class="compact-chapter-link" href="{prefix}{chapter_path}"{active}>'
                f'<span>{number:02d}</span><strong>{escape(str(chapter["title"]))}</strong></a>'
            )
            if current == number:
                section_rows = []
                for raw_section in chapter.get("sections", []):
                    section = dict(raw_section)
                    sid = str(section["id"])
                    slug = sid.replace(".", "-")
                    section_path = f"textbook/chapter-{number:02d}/section-{slug}.html"
                    section_active = exact_current(rel_path, section_path)
                    section_rows.append(
                        f'<a href="{prefix}{section_path}"{section_active}>'
                        f'<span>{escape(sid)}</span>{escape(str(section["title"]))}</a>'
                    )
                rows.append(f'<nav class="current-chapter-sections">{"".join(section_rows)}</nav>')

    open_attr = " open" if rel_path.startswith("textbook/") else ""
    return (
        f'<details class="book-nav"{open_attr}><summary>Book contents</summary>'
        f'<div class="book-toc compact-book-toc">{"".join(rows)}</div></details>'
    )


def sidebar_html(edition: dict[str, Any], rel_path: str) -> str:
    prefix = rel_prefix(rel_path)
    return f"""<div class="sidebar-contents" data-ia-version="{IA_VERSION}">
<section class="sidebar-group sidebar-libraries">
  <h2>Libraries</h2>
  <nav class="source-hubs">
    <a class="source-hub" href="{prefix}textbook/index.html"{source_current(rel_path, 'book')}>
      <span class="source-hub-title">Log-Concave Sampling</span>
      <small>Chewi textbook · 12 chapters</small>
    </a>
    <a class="source-hub" href="{prefix}example-cases/samplewiki.html"{source_current(rel_path, 'samplewiki')}>
      <span class="source-hub-title">SampleWiki</span>
      <small>Live sampling frontier · source-pinned cases</small>
    </a>
  </nav>
</section>
{chapter_toc(edition, rel_path, prefix)}
<section class="sidebar-group">
  <h2>Chapter 1 companion</h2>
  <nav>
    <a href="{prefix}textbook/chapter-01-companion.html"{exact_current(rel_path, 'textbook/chapter-01-companion.html')}>Companion guide</a>
    <a href="{prefix}learning-path/index.html"{exact_current(rel_path, 'learning-path/index.html')}>Study guide</a>
    <a href="{prefix}textbook/chapter-01-matrix.html"{exact_current(rel_path, 'textbook/chapter-01-matrix.html')}>Formalization status</a>
  </nav>
</section>
<section class="sidebar-group">
  <h2>Proof graph</h2>
  <nav>
    <a href="{prefix}lean-foundations.html"{exact_current(rel_path, 'lean-foundations.html')}>Proof Atlas</a>
    <a href="{prefix}implementation-map/index.html"{exact_current(rel_path, 'implementation-map/index.html')}>Implementation map</a>
    <a href="{prefix}declarations/index.html"{exact_current(rel_path, 'declarations/index.html')}>Lean declarations</a>
    <a href="{prefix}source-correspondence.html"{exact_current(rel_path, 'source-correspondence.html')}>Source map</a>
  </nav>
</section>
<section class="sidebar-group">
  <h2>Build</h2>
  <nav>
    <a href="{prefix}live/index.html"{exact_current(rel_path, 'live/index.html')}>Live formalization</a>
    <a href="{prefix}workflow/index.html"{exact_current(rel_path, 'workflow/index.html')}>ASTIS harness</a>
  </nav>
</section>
<details class="sidebar-more">
  <summary>Project</summary>
  <nav>
    <a href="{prefix}roadmap/index.html">Roadmap</a>
    <a href="{prefix}contribute/index.html">Contribute</a>
    <a href="{prefix}related-systems/index.html">Related systems</a>
    <a href="{prefix}attribution/index.html">Attribution</a>
    <a href="{prefix}maintenance.html">Verification workflow</a>
  </nav>
</details>
</div>
      """


def replace_sidebar(text: str, edition: dict[str, Any], rel_path: str) -> str:
    start_marker = '<div class="sidebar-contents">'
    end_marker = '<div class="sidebar-utility">'
    start = text.find(start_marker)
    end = text.find(end_marker, start)
    if start < 0 or end < 0:
        raise RuntimeError(f"cannot locate sidebar contents in {rel_path}")
    return text[:start] + sidebar_html(edition, rel_path) + text[end:]


def replace_main(text: str, main_html: str, rel_path: str) -> str:
    start_marker = '<main id="content">'
    start = text.find(start_marker)
    end = text.find("</main>", start)
    if start < 0 or end < 0:
        raise RuntimeError(f"cannot locate main content in {rel_path}")
    return text[:start] + start_marker + main_html + "</main>" + text[end + len("</main>"):]


def replace_document_title(text: str, title: str) -> str:
    text = re.sub(r"<title>.*?</title>", f"<title>{escape(title)} · Samplinglib</title>", text, count=1, flags=re.S)
    text = re.sub(
        r'<meta property="og:title" content=".*?">',
        f'<meta property="og:title" content="{escape(title)} · Samplinglib">',
        text,
        count=1,
        flags=re.S,
    )
    return text


def remove_legacy_samplewiki_injection(text: str) -> str:
    return re.sub(
        r"\s*<section data-samplewiki-example-cases=\"true\".*?</section>",
        "",
        text,
        flags=re.S,
    )


def add_style(text: str, rel_path: str) -> str:
    prefix = rel_prefix(rel_path)
    href = f"{prefix}assets/{STYLE_NAME}"
    if href in text:
        return text
    marker = "</head>"
    if marker not in text:
        raise RuntimeError(f"cannot inject IA stylesheet into {rel_path}")
    return text.replace(marker, f'  <link rel="stylesheet" href="{href}">\n{marker}', 1)


def samplewiki_counts() -> tuple[str, str]:
    if not SAMPLEWIKI_CASES.exists():
        return "Live", "hourly source watch"
    try:
        data = load_json(SAMPLEWIKI_CASES)
    except (OSError, ValueError, RuntimeError):
        return "Live", "hourly source watch"
    case_count = int(data.get("case_count", len(data.get("cases", []))))
    setting_count = int(data.get("setting_count", len(data.get("settings", []))))
    return str(case_count), f"cases across {setting_count} settings"


def home_main() -> str:
    sw_value, sw_label = samplewiki_counts()
    return f"""
<section class="ia-home-hero">
  <div class="eyebrow">Samplinglib · formal sampling theory</div>
  <h1>Sampling theory, readable and verified.</h1>
  <p class="lede">Two mathematical sources feed one reusable Lean proof graph. Read the mathematics first; open rigor and machine-level detail only when you need them.</p>
</section>
<section class="source-portal-grid" aria-label="Primary mathematical sources">
  <article class="source-portal source-portal-book">
    <div class="portal-kicker">Primary textbook</div>
    <h2>Log-Concave Sampling</h2>
    <p>Sinho Chewi's book, reconstructed section by section with beginner explanations, hidden analytic contracts, source correspondence, and Lean evidence.</p>
    <div class="portal-metric"><strong>12</strong><span>chapters</span></div>
    <div class="portal-actions"><a class="button primary" href="textbook/index.html">Read the book</a><a href="textbook/chapter-01-companion.html">Chapter 1 companion →</a></div>
  </article>
  <article class="source-portal source-portal-wiki">
    <div class="portal-kicker">Live research frontier</div>
    <h2>SampleWiki</h2>
    <p>Current sampling results become source-pinned cases, then reviewed Lean targets and reusable proof-technique nodes in the same formal graph.</p>
    <div class="portal-metric"><strong>{escape(sw_value)}</strong><span>{escape(sw_label)}</span></div>
    <div class="portal-actions"><a class="button primary" href="example-cases/samplewiki.html">Explore SampleWiki</a><a href="lean-foundations.html">See the shared proof graph →</a></div>
  </article>
</section>
<section class="ia-shortcuts" aria-label="Reader shortcuts">
  <a href="learning-path/index.html"><span>Study</span><strong>How to read the book</strong></a>
  <a href="lean-foundations.html"><span>Understand</span><strong>Proof Atlas</strong></a>
  <a href="implementation-map/index.html"><span>Audit</span><strong>Implementation map</strong></a>
</section>
<section class="zoom-explainer">
  <div class="section-heading"><span>Progressive disclosure</span><h2>Three zoom levels, one proof.</h2></div>
  <div class="zoom-grid">
    <article><span>01</span><h3>Mathematics</h3><p>Definitions, theorem statements, intuition, and proof route in natural language.</p></article>
    <article><span>02</span><h3>Proof graph</h3><p>Shared lemmas and proof-technique nodes show what really carries the argument.</p></article>
    <article><span>03</span><h3>Lean</h3><p>Exact declarations, hypotheses, dependencies, consumers, source lines, and tests.</p></article>
  </div>
</section>
<section class="ia-project-note">
  <strong>ASTIS principle.</strong> A compiled leaf is evidence for that leaf only. Chapters and source cases turn blue only when their own mathematical route and source-fidelity gates are closed.
</section>
"""


def study_guide_main(edition: dict[str, Any]) -> str:
    chapters = [dict(item) for item in edition.get("chapters", [])]
    part_blocks: list[str] = []
    parts = [dict(item) for item in edition.get("parts", [])]
    for index, part in enumerate(parts):
        start = int(part["book_page"])
        stop = int(parts[index + 1]["book_page"]) if index + 1 < len(parts) else 10**9
        links = []
        for chapter in chapters:
            if start <= int(chapter["book_page"]) < stop:
                number = int(chapter["number"])
                links.append(
                    f'<a href="../textbook/chapter-{number:02d}.html"><span>{number:02d}</span><strong>{escape(str(chapter["title"]))}</strong></a>'
                )
        part_blocks.append(
            f'<details class="study-part"{" open" if index == 0 else ""}><summary>Part {int(part["number"])} · {escape(str(part["title"]))}</summary>'
            f'<div class="study-chapter-links">{"".join(links)}</div></details>'
        )
    return f"""
<section class="page-hero compact ia-compact-hero">
  <div class="eyebrow">Log-Concave Sampling · reader guide</div>
  <h1>Study Guide</h1>
  <p class="lede">The book is the main route. Use the companion when a chapter moves too quickly; use the Proof Atlas only when you want to see the reusable formal structure underneath.</p>
</section>
<section class="study-route" aria-label="Recommended reading route">
  <a href="../textbook/index.html"><span>01</span><strong>Read the textbook</strong><small>Canonical chapter order</small></a>
  <a href="../textbook/chapter-01-companion.html"><span>02</span><strong>Open a companion</strong><small>Prerequisites and hidden steps</small></a>
  <a href="../lean-foundations.html"><span>03</span><strong>Open the Proof Atlas</strong><small>Shared roots before exact Lean</small></a>
</section>
<section>
  <div class="section-heading"><span>Start here</span><h2>Chapter 1 builds the common language.</h2></div>
  <div class="chapter-one-route">
    <a href="../textbook/chapter-01/section-1-1.html"><span>1.1</span><strong>Stochastic calculus</strong><small>Brownian motion · Itô · stopping</small></a>
    <a href="../textbook/chapter-01/section-1-2.html"><span>1.2</span><strong>Markov semigroups</strong><small>Generator · Γ · PI/LSI</small></a>
    <a href="../textbook/chapter-01/section-1-3.html"><span>1.3</span><strong>Optimal transport</strong><small>Couplings · W₂ · geodesics</small></a>
    <a href="../textbook/chapter-01/section-1-4.html"><span>1.4</span><strong>Gradient flow</strong><small>Dynamics meet Wasserstein geometry</small></a>
  </div>
</section>
<section>
  <div class="section-heading"><span>Whole book</span><h2>Twelve chapters, collapsed by part.</h2></div>
  <div class="study-parts">{"".join(part_blocks)}</div>
</section>
<section class="ia-project-note">Long declaration lists intentionally do not live on this page. They belong in the <a href="../lean-foundations.html">Proof Atlas</a> and <a href="../implementation-map/index.html">Implementation Map</a>.</section>
"""


def proof_atlas_main() -> str:
    return """
<section class="page-hero compact ia-compact-hero">
  <div class="eyebrow">Shared formal graph · reader view</div>
  <h1>Proof Atlas</h1>
  <p class="lede">See the mathematical structure before the code. Source claims from the textbook and SampleWiki meet in shared proof roots; exact Lean declarations are the final zoom level, not the first.</p>
</section>
<section class="atlas-layers" aria-label="Three proof graph zoom levels">
  <article class="atlas-layer source-layer">
    <div class="atlas-layer-label"><span>01</span><strong>Source claims</strong></div>
    <div class="atlas-source-grid"><a href="textbook/index.html">Log-Concave Sampling</a><a href="example-cases/samplewiki.html">SampleWiki</a></div>
  </article>
  <div class="atlas-arrow" aria-hidden="true">↓</div>
  <article class="atlas-layer">
    <div class="atlas-layer-label"><span>02</span><strong>Mathematical proof nodes</strong></div>
    <p>Definitions, lemmas, proof techniques, and theorem interfaces. Repeated ideas are shared rather than copied into every chapter or example case.</p>
  </article>
  <div class="atlas-arrow" aria-hidden="true">↓</div>
  <article class="atlas-layer">
    <div class="atlas-layer-label"><span>03</span><strong>Exact Lean nodes</strong></div>
    <p>Open a theorem card only when you need the precise type, hypotheses, imports, dependencies, consumers, source location, and test evidence.</p>
    <div class="atlas-actions"><a href="declarations/index.html">Browse declarations →</a><a href="implementation-map/index.html">Open implementation map →</a></div>
  </article>
</section>
<section>
  <div class="section-heading"><span>Chapter 1 shared spine</span><h2>Four clusters, not one giant DAG.</h2></div>
  <div class="proof-cluster-grid">
    <article class="proof-cluster"><span>1.1</span><h3>Stochastic calculus</h3><p>Brownian motion → adapted/progressive processes → Itô integral → stopping/localization → Itô processes.</p><div class="root-tags"><code>BrownianMotion</code><code>ProgressiveL2</code><code>CanonicalLocalization</code></div></article>
    <article class="proof-cluster"><span>1.2</span><h3>Semigroups & inequalities</h3><p>Transition kernels → semigroup → generator → reversibility/Γ → Poincaré and log-Sobolev dissipation.</p><div class="root-tags"><code>MarkovSemigroup</code><code>OperatorGenerator</code><code>CarreDuChamp</code></div></article>
    <article class="proof-cluster"><span>1.3</span><h3>Optimal transport</h3><p>Couplings → transport cost → W₂ → interpolation/geodesics → geodesic convexity.</p><div class="root-tags"><code>Transport</code><code>WassersteinSpace</code><code>DisplacementInterpolation</code></div></article>
    <article class="proof-cluster"><span>1.4+</span><h3>Gradient flow & algorithms</h3><p>KL/Fisher dissipation and Wasserstein geometry feed convergence proofs, discretizations, complexity results, and SampleWiki cases.</p><div class="root-tags"><code>KLDensity</code><code>SemigroupDecay</code><code>ExampleCases</code></div></article>
  </div>
</section>
<section class="atlas-status-section">
  <div class="section-heading"><span>Status semantics</span><h2>Color the node that was actually proved.</h2></div>
  <div class="status-legend"><span class="status status-blue">compiled local node</span><span class="status status-orange">open analytic bridge</span><span class="status status-gray">source / reference node</span></div>
  <p>A chapter is not blue because one leaf compiled. A SampleWiki row is not assimilated because a theorem-shaped Lean statement elaborates. Status follows the exact node and its verification gate.</p>
</section>
<details class="ia-disclosure">
  <summary>Where did the old “Lean Foundations” packet go?</summary>
  <div><p>The cutoff-to-generator packet is still available through the formal library. It is now treated as one implementation example rather than the default mental model for the whole project.</p><p><a href="implementation-map/index.html">Open the Implementation Map</a> · <a href="declarations/index.html">Browse exact declarations</a></p></div>
</details>
"""


def companion_body() -> str:
    return """
<section class="page-hero compact ia-compact-hero">
  <div class="eyebrow">Log-Concave Sampling · Chapter 1</div>
  <h1>Chapter 1 Companion</h1>
  <p class="lede">Use this page when the source moves faster than your background. The main chapter remains canonical; the companion tells you which foundation to open and why it matters.</p>
  <div class="hero-actions"><a class="button primary" href="chapter-01.html">Read Chapter 1</a><a class="button" href="../learning-path/index.html">Open Study Guide</a></div>
</section>
<section class="companion-grid">
  <article><span>1.1</span><h2>Stochastic calculus</h2><p>Random paths, filtrations, Itô integration, stopping/localization, Itô's formula, and SDEs.</p><a href="chapter-01/section-1-1.html">Open the primer →</a></article>
  <article><span>1.2</span><h2>Markov semigroups</h2><p>Kernels, semigroups, generators, reversibility, carré du champ, PI/LSI, and Bakry–Émery.</p><a href="chapter-01/section-1-2.html">Open semigroup theory →</a></article>
  <article><span>1.3</span><h2>Optimal transport</h2><p>Couplings, transport cost, Wasserstein distance, duality, curves, and geodesics.</p><a href="chapter-01/section-1-3.html">Open optimal transport →</a></article>
  <article><span>1.4</span><h2>Wasserstein gradient flow</h2><p>The conceptual bridge from Langevin dynamics to geometry on probability distributions.</p><a href="chapter-01/section-1-4.html">Open the gradient-flow bridge →</a></article>
</section>
<section>
  <div class="section-heading"><span>What the section pages add</span><h2>Supplement only where the source is terse.</h2></div>
  <div class="companion-support-grid">
    <article><h3>Beginner story</h3><p>Each active Chapter 1 section starts from the mathematical question before introducing notation.</p></article>
    <article><h3>Hidden prerequisites</h3><p>Measure-theory, integration, stopping-time, approximation, and topology lemmas are exposed where the book uses them implicitly.</p></article>
    <article><h3>Classical references</h3><p>Reference packets explain which standard source supplies the background theorem and what role it plays.</p></article>
    <article><h3>Lean expansion</h3><p>The exact declaration is optional. Open it only after the natural-language proof route is clear.</p></article>
  </div>
</section>
<section class="companion-tools">
  <a href="chapter-01-matrix.html"><span>Status</span><strong>Chapter 1 formalization status</strong><small>Source item by source item</small></a>
  <a href="../rigorous-details.html"><span>Rigor</span><strong>Hidden mathematical contracts</strong><small>Why the steps are legal</small></a>
  <a href="../lean-foundations.html"><span>Graph</span><strong>Proof Atlas</strong><small>Shared roots and Lean zoom</small></a>
</section>
"""


def write_companion(output: Path) -> None:
    page_text = astis_site.page(
        "Chapter 1 Companion",
        "textbook/chapter-01-companion.html",
        companion_body(),
        active="Textbook:1",
        description="Chapter 1 companion for Log-Concave Sampling: prerequisites, hidden steps, references, and proof graph navigation.",
    )
    astis_site.write_page(output, "textbook/chapter-01-companion.html", page_text)


def transform_page(text: str, edition: dict[str, Any], rel_path: str) -> str:
    text = remove_legacy_samplewiki_injection(text)

    if rel_path == "index.html":
        text = replace_main(text, home_main(), rel_path)
        text = replace_document_title(text, "Home")
    elif rel_path == "learning-path/index.html":
        text = replace_main(text, study_guide_main(edition), rel_path)
        text = replace_document_title(text, "Study Guide")
    elif rel_path == "lean-foundations.html":
        text = replace_main(text, proof_atlas_main(), rel_path)
        text = replace_document_title(text, "Proof Atlas")
    elif rel_path == "textbook/index.html":
        text = text.replace(
            '<div class="eyebrow">Textbook spine</div>\n  <h1>A reconstructed learning route through <em>Log-Concave Sampling</em></h1>',
            '<div class="eyebrow">Primary textbook</div>\n  <h1>Log-Concave Sampling</h1>',
        )
        text = text.replace(
            '<p class="lede">Read the canonical August 9, 2026 edition section by section,\n  with rigorous analytic contracts and Lean evidence available on demand.</p>',
            '<p class="lede">Read Sinho Chewi\'s textbook in canonical chapter order, with beginner exposition, rigorous contracts, and Lean evidence available on demand.</p>',
        )
        text = replace_document_title(text, "Log-Concave Sampling")
    elif rel_path == "example-cases/samplewiki.html":
        text = text.replace("Example Cases — SampleWiki", "SampleWiki")
        text = text.replace(
            "Parallel chapter · live external examples · source-to-Lean",
            "Live sampling frontier · source-to-Lean",
        )
        text = replace_document_title(text, "SampleWiki")

    text = replace_sidebar(text, edition, rel_path)
    text = add_style(text, rel_path)
    return text


def validate_site(output: Path) -> None:
    errors: list[str] = []
    required = {
        "index.html": ("Log-Concave Sampling", "SampleWiki", "source-portal-grid"),
        "learning-path/index.html": ("Study Guide", "chapter-one-route"),
        "lean-foundations.html": ("Proof Atlas", "atlas-layers"),
        "textbook/chapter-01-companion.html": ("Chapter 1 Companion", "companion-grid"),
        "example-cases/samplewiki.html": ("<h1>SampleWiki</h1>",),
    }
    for rel_path, markers in required.items():
        path = output / rel_path
        if not path.exists():
            errors.append(f"missing IA page: {rel_path}")
            continue
        text = path.read_text(encoding="utf-8")
        for marker in markers:
            if marker not in text:
                errors.append(f"{rel_path}: missing marker {marker!r}")
        if f'data-ia-version="{IA_VERSION}"' not in text:
            errors.append(f"{rel_path}: sidebar IA marker missing")

    textbook = output / "textbook" / "index.html"
    if textbook.exists() and 'data-samplewiki-example-cases="true"' in textbook.read_text(encoding="utf-8"):
        errors.append("SampleWiki must not be injected inside the Log-Concave Sampling textbook index")

    for path in output.rglob("*.html"):
        text = path.read_text(encoding="utf-8")
        sidebar_start = text.find('<div class="sidebar-contents"')
        sidebar_end = text.find('<div class="sidebar-utility">', sidebar_start)
        sidebar = text[sidebar_start:sidebar_end] if sidebar_start >= 0 and sidebar_end >= 0 else ""
        if "Book Map" in sidebar:
            errors.append(f"{normalized_rel(path, output)}: legacy Book Map label remains in sidebar")
        if "Canonical book contents" in sidebar:
            errors.append(f"{normalized_rel(path, output)}: canonical contents remains a peer navigation item")
        if "Log-Concave Sampling" not in sidebar or "SampleWiki" not in sidebar:
            errors.append(f"{normalized_rel(path, output)}: both first-class sources are not visible in sidebar")

    css_path = output / "assets" / STYLE_NAME
    if not css_path.exists():
        errors.append(f"missing generated stylesheet: assets/{STYLE_NAME}")
    else:
        css = css_path.read_text(encoding="utf-8")
        for marker in ("overflow-x: clip", ".source-portal-grid", ".proof-cluster-grid", ".chapter-card > *"):
            if marker not in css:
                errors.append(f"IA stylesheet missing overflow/layout contract: {marker}")

    if errors:
        raise RuntimeError("information architecture validation failed:\n- " + "\n- ".join(errors))


def enrich_site(output: Path) -> None:
    edition = load_json(SOURCE_EDITION)
    write_companion(output)
    asset_dir = output / "assets"
    asset_dir.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(SOURCE_CSS, asset_dir / STYLE_NAME)

    for path in sorted(output.rglob("*.html")):
        rel_path = normalized_rel(path, output)
        original = path.read_text(encoding="utf-8")
        transformed = transform_page(original, edition, rel_path)
        path.write_text(transformed, encoding="utf-8", newline="\n")

    validate_site(output)
