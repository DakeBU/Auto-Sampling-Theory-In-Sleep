#!/usr/bin/env python3
"""Add peer-level Boumal and Beck textbook shelves to Samplinglib."""

from __future__ import annotations

import re
import shutil
from html import escape
from pathlib import Path

import astis_site


ROOT = Path(__file__).resolve().parents[2]
SOURCE_CSS = ROOT / "website" / "static" / "library-shelves.css"
STYLE_NAME = "library-shelves.css"

BOUMAL_URL = "https://www.nicolasboumal.net/book/"
BECK_URL = "https://epubs.siam.org/doi/book/10.1137/1.9781611974997"
OPTLIB_URL = "https://github.com/optsuite/optlib"
CVXLEAN_URL = "https://github.com/verified-optimization/CvxLean"

BOUMAL = (
    "Introduction",
    "Simple examples",
    "Embedded geometry: first order",
    "First-order optimization algorithms",
    "Embedded geometry: second order",
    "Second-order optimization algorithms",
    "Embedded submanifolds: examples",
    "General manifolds",
    "Quotient manifolds",
    "Additional tools",
    "Geodesic convexity",
)

BECK = (
    "Vector spaces",
    "Extended real-valued functions",
    "Subgradients",
    "Conjugate functions",
    "Smoothness and strong convexity",
    "The proximal operator",
    "Spectral functions",
    "Primal and dual projected subgradient methods",
    "Mirror descent",
    "The proximal gradient method",
    "The block proximal gradient method",
    "Dual-based proximal gradient methods",
    "The generalized conditional gradient method",
    "Alternating minimization",
    "ADMM",
)


def prefix(rel: str) -> str:
    return "../" * len(Path(rel).parent.parts)


def current(rel: str, stem: str) -> str:
    return ' aria-current="page"' if rel.startswith(stem) else ""


def libraries_sidebar(rel: str) -> str:
    p = prefix(rel)
    return f"""<section class="sidebar-group sidebar-libraries" data-library-shelves="1">
  <h2><a href="{p}libraries/index.html">Libraries</a></h2>
  <nav class="source-hubs library-source-hubs">
    <a class="source-hub" href="{p}textbook/index.html"{current(rel, "textbook/")}><span class="source-hub-title">Log-Concave Sampling</span><small>Chewi · textbook graph</small></a>
    <a class="source-hub" href="{p}example-cases/samplewiki.html"{current(rel, "example-cases/samplewiki")}><span class="source-hub-title">SampleWiki</span><small>sampling frontier cases</small></a>
    <a class="source-hub" href="{p}libraries/riemannian-optimization/index.html"{current(rel, "libraries/riemannian-optimization/")}><span class="source-hub-title">Riemannian Optimization</span><small>Boumal · 11 chapters</small></a>
    <a class="source-hub" href="{p}libraries/first-order-optimization/index.html"{current(rel, "libraries/first-order-optimization/")}><span class="source-hub-title">First-Order Optimization</span><small>Beck · Optlib · CvxLean</small></a>
  </nav>
</section>"""


def replace_sidebar(text: str, rel: str) -> str:
    pattern = re.compile(r'<section class="sidebar-group sidebar-libraries".*?</section>', re.S)
    changed, count = pattern.subn(libraries_sidebar(rel), text, count=1)
    if count:
        return changed

    start = text.find('<div class="sidebar-contents">')
    end = text.find('<div class="sidebar-utility">', start)
    if start < 0 or end < 0:
        raise RuntimeError(f"{rel}: sidebar not found")
    p = prefix(rel)
    fallback = f"""<div class="sidebar-contents" data-library-shelves="1">
{libraries_sidebar(rel)}
<section class="sidebar-group"><h2>Proof graph</h2><nav>
<a href="{p}lean-foundations.html">Proof Atlas</a>
<a href="{p}underlying-lean-graph/index.html">Underlying Lean Graph</a>
<a href="{p}implementation-map/index.html">Implementation map</a>
</nav></section>
<section class="sidebar-group"><h2>Project</h2><nav>
<a href="{p}workflow/index.html">ASTIS Harness</a>
<a href="{p}contribute/index.html">Contribute</a>
<a href="{p}attribution/index.html">Attribution</a>
</nav></section>
</div>
"""
    return text[:start] + fallback + text[end:]


def add_style(text: str, rel: str) -> str:
    href = f"{prefix(rel)}assets/{STYLE_NAME}"
    if href in text:
        return text
    if "</head>" not in text:
        raise RuntimeError(f"{rel}: missing </head>")
    return text.replace("</head>", f'  <link rel="stylesheet" href="{href}">\n</head>', 1)


def badge(label: str, css: str = "gray") -> str:
    return f'<span class="status status-{css}">{escape(label)}</span>'


def cards(chapters: tuple[str, ...]) -> str:
    return "".join(
        f"""<article class="library-chapter-card">
<div class="library-chapter-number">{i:02d}</div>
<div><div class="card-meta">{badge("scaffold")}</div>
<h2><a href="chapter-{i:02d}.html">{escape(title)}</a></h2>
<p>Source map, theorem nodes, upstream matches, and exact Lean correspondence will be attached here.</p></div>
</article>"""
        for i, title in enumerate(chapters, 1)
    )


def index_body(
    *,
    eyebrow: str,
    title: str,
    lede: str,
    source: str,
    chapters: tuple[str, ...],
    contract: str,
) -> str:
    return f"""
<section class="page-hero compact library-book-hero">
<div class="eyebrow">{escape(eyebrow)}</div><h1>{escape(title)}</h1>
<p class="lede">{escape(lede)}</p>
<div class="library-meta-row"><span><strong>Status</strong>chapter environment established</span>
<a href="{escape(source)}">Primary source ↗</a></div>
</section>
<section class="library-integration-note">
<div class="section-heading"><span>Formalization contract</span><h2>Map first, reuse first, prove only real gaps.</h2></div>
<p>{escape(contract)}</p>
<div class="library-status-key">{badge("reuse", "blue")}{badge("adapt", "yellow")}{badge("missing", "orange")}{badge("out of scope")}</div>
</section>
<section><div class="section-heading"><span>Book contents</span><h2>Chapter scaffolds</h2></div>
<div class="library-chapter-list">{cards(chapters)}</div></section>
"""


def chapter_body(library: str, number: int, title: str, source: str, upstream: str) -> str:
    return f"""
<section class="page-hero compact library-chapter-hero">
<div class="eyebrow">{escape(library)} · Chapter {number:02d}</div>
<h1>{escape(title)}</h1>
<p class="lede">Stable source-facing chapter environment for the shared Samplinglib graph.</p>
<div class="tag-row">{badge("scaffold")}<span>source map</span><span>Lean graph pending</span></div>
</section>
<section class="library-chapter-contract">
<div class="section-heading"><span>Planned route</span><h2>Source → theorem map → reusable Lean nodes</h2></div>
<div class="library-contract-grid">
<article><span>01</span><h3>Source audit</h3><p>Definitions, theorems, assumptions, proof route, and exact anchors.</p></article>
<article><span>02</span><h3>Upstream alignment</h3><p>{escape(upstream)}</p></article>
<article><span>03</span><h3>Frontier Cells</h3><p>Only genuinely missing mathematical edges become theorem-sized tasks.</p></article>
<article><span>04</span><h3>Graph placement</h3><p>Dependencies, consumers, cross-library bridges, and compression candidates.</p></article>
</div><p><a href="{escape(source)}">Primary source ↗</a></p>
</section>
<section class="ia-project-note">This page establishes a stable source route and truth boundary; it does not claim a completed formalization.</section>
"""


def write_pages(output: Path) -> None:
    home = """
<section class="page-hero compact library-index-hero">
<div class="eyebrow">Samplinglib · four first-class libraries</div>
<h1>One formal graph across sampling and optimization.</h1>
<p class="lede">Textbooks provide stable coordinate systems; SampleWiki inserts frontier results into the same reusable theorem graph.</p>
</section>
<section class="library-index-grid">
<article class="library-index-card library-active"><div class="portal-kicker">Textbook</div><h2>Log-Concave Sampling</h2><p>Chewi's source-aligned textbook graph.</p><a class="button primary" href="../textbook/index.html">Open textbook</a></article>
<article class="library-index-card library-active"><div class="portal-kicker">Research frontier</div><h2>SampleWiki</h2><p>Source-pinned frontier results inserted into the reusable graph.</p><a class="button primary" href="../example-cases/samplewiki.html">Open SampleWiki</a></article>
<article class="library-index-card"><div class="portal-kicker">Chapter scaffold</div><h2>Riemannian Optimization</h2><p>Boumal's eleven-chapter geometry and optimization route.</p><a class="button" href="riemannian-optimization/index.html">Open library</a></article>
<article class="library-index-card"><div class="portal-kicker">Scaffold + upstream reuse</div><h2>First-Order Optimization</h2><p>Beck aligned with Optlib and CvxLean.</p><a class="button" href="first-order-optimization/index.html">Open library</a></article>
</section>
<section class="ia-project-note"><strong>Truth boundary.</strong> Scaffold means public chapter routes and source boundaries, not completed Lean proofs.</section>
"""
    astis_site.write_page(output, "libraries/index.html", astis_site.page("Libraries", "libraries/index.html", home, active="Libraries"))

    boumal = index_body(
        eyebrow="Riemannian Optimization Library · Boumal",
        title="An Introduction to Optimization on Smooth Manifolds",
        lede="A chapter-by-chapter graph for smooth-manifold geometry, Riemannian algorithms, and Euclidean-to-manifold transfer.",
        source=BOUMAL_URL,
        chapters=BOUMAL,
        contract="Search Mathlib and Samplinglib geometry interfaces before opening new proofs; make every convention bridge explicit.",
    )
    astis_site.write_page(output, "libraries/riemannian-optimization/index.html", astis_site.page("Riemannian Optimization", "libraries/riemannian-optimization/index.html", boumal, active="Libraries"))
    for i, title in enumerate(BOUMAL, 1):
        path = f"libraries/riemannian-optimization/chapter-{i:02d}.html"
        body = chapter_body("Riemannian Optimization", i, title, BOUMAL_URL, "Search Mathlib and local geometry interfaces; adapt only real statement or convention differences.")
        astis_site.write_page(output, path, astis_site.page(f"Riemannian Optimization {i}: {title}", path, body, active="Libraries"))

    beck = index_body(
        eyebrow="First-Order Optimization Library · Beck",
        title="First-Order Methods in Optimization",
        lede="A convex-analysis and algorithm graph connected to Optlib theorem nodes and CvxLean problem transformations.",
        source=BECK_URL,
        chapters=BECK,
        contract="Classify every source node as reuse, adapt, missing, or out of scope. Keep upstream provenance and toolchain adapters explicit.",
    ) + f"""
<section><div class="section-heading"><span>Formal upstreams</span><h2>Audited sources, not opaque copies.</h2></div>
<div class="upstream-library-grid">
<article><h3>Optlib</h3><p>Convex analysis, proximal maps, first-order algorithms, acceleration, block methods, and ADMM.</p><a href="{OPTLIB_URL}">Open Optlib ↗</a></article>
<article><h3>CvxLean</h3><p>Formal optimization problems, equivalence, reduction, relaxation, and verified transformations.</p><a href="{CVXLEAN_URL}">Open CvxLean ↗</a></article>
</div></section>
"""
    astis_site.write_page(output, "libraries/first-order-optimization/index.html", astis_site.page("First-Order Optimization", "libraries/first-order-optimization/index.html", beck, active="Libraries"))
    for i, title in enumerate(BECK, 1):
        path = f"libraries/first-order-optimization/chapter-{i:02d}.html"
        body = chapter_body("First-Order Optimization", i, title, BECK_URL, "Search Mathlib, Optlib, and CvxLean; record exact matches, adapters, and missing nodes.")
        astis_site.write_page(output, path, astis_site.page(f"First-Order Optimization {i}: {title}", path, body, active="Libraries"))


def four_portals() -> str:
    return """
<section class="source-portal-grid source-portal-grid-four" aria-label="Primary mathematical libraries">
<article class="source-portal source-portal-book"><div class="portal-kicker">Textbook</div><h2>Log-Concave Sampling</h2><p>Chewi's source-aligned textbook graph.</p><div class="portal-actions"><a class="button primary" href="textbook/index.html">Read the book</a></div></article>
<article class="source-portal source-portal-wiki"><div class="portal-kicker">Research frontier</div><h2>SampleWiki</h2><p>Source-pinned frontier results and theorem-sized graph insertions.</p><div class="portal-actions"><a class="button primary" href="example-cases/samplewiki.html">Explore SampleWiki</a></div></article>
<article class="source-portal source-portal-riemannian"><div class="portal-kicker">Chapter scaffold</div><h2>Riemannian Optimization</h2><p>Boumal's eleven chapters on geometry and manifold algorithms.</p><div class="portal-actions"><a class="button" href="libraries/riemannian-optimization/index.html">Open library</a></div></article>
<article class="source-portal source-portal-optimization"><div class="portal-kicker">Scaffold + upstreams</div><h2>First-Order Optimization</h2><p>Beck's fifteen chapters aligned with Optlib and CvxLean.</p><div class="portal-actions"><a class="button" href="libraries/first-order-optimization/index.html">Open library</a></div></article>
</section>
"""


def patch_special(text: str, rel: str) -> str:
    if rel == "index.html":
        text, count = re.subn(r'<section class="source-portal-grid".*?</section>', four_portals(), text, count=1, flags=re.S)
        if count != 1:
            raise RuntimeError("index.html: library portal grid not found")
        text = text.replace("Two mathematical sources feed one reusable Lean proof graph.", "Four mathematical libraries feed one reusable Lean proof graph.")
    elif rel == "lean-foundations.html":
        text = text.replace(
            '<div class="atlas-source-grid"><a href="textbook/index.html">Log-Concave Sampling</a><a href="example-cases/samplewiki.html">SampleWiki</a></div>',
            '<div class="atlas-source-grid atlas-source-grid-four"><a href="textbook/index.html">Log-Concave Sampling</a><a href="example-cases/samplewiki.html">SampleWiki</a><a href="libraries/riemannian-optimization/index.html">Riemannian Optimization</a><a href="libraries/first-order-optimization/index.html">First-Order Optimization</a></div>',
        )
    elif rel == "attribution/index.html" and 'data-library-attribution="true"' not in text:
        block = f"""
<section class="library-attribution" data-library-attribution="true">
<div class="section-heading"><span>Textbooks and formal upstreams</span><h2>Additional Samplinglib library sources</h2></div>
<div class="upstream-library-grid">
<article><h3>Nicolas Boumal</h3><p><em>An Introduction to Optimization on Smooth Manifolds</em> supplies the Riemannian route.</p><a href="{BOUMAL_URL}">Book site ↗</a></article>
<article><h3>Amir Beck</h3><p><em>First-Order Methods in Optimization</em> supplies the first-order route.</p><a href="{BECK_URL}">SIAM page ↗</a></article>
<article><h3>Optlib</h3><p>Audited convex-analysis and algorithm theorem source.</p><a href="{OPTLIB_URL}">Repository ↗</a></article>
<article><h3>CvxLean</h3><p>Audited optimization-problem and transformation source.</p><a href="{CVXLEAN_URL}">Repository ↗</a></article>
</div></section>
"""
        end = text.rfind("</main>")
        if end < 0:
            raise RuntimeError("attribution/index.html: missing main")
        text = text[:end] + block + text[end:]
    return text


def transform(output: Path) -> None:
    for path in sorted(output.rglob("*.html")):
        rel = path.relative_to(output).as_posix()
        text = patch_special(path.read_text(encoding="utf-8"), rel)
        text = replace_sidebar(text, rel)
        text = add_style(text, rel)
        path.write_text(text, encoding="utf-8", newline="\n")


def validate(output: Path) -> None:
    errors: list[str] = []
    required = {
        "index.html": ("source-portal-grid-four", "Riemannian Optimization", "First-Order Optimization"),
        "libraries/index.html": ("four first-class libraries",),
        "libraries/riemannian-optimization/index.html": ("An Introduction to Optimization on Smooth Manifolds", "chapter environment established"),
        "libraries/first-order-optimization/index.html": ("First-Order Methods in Optimization", "Optlib", "CvxLean"),
        "attribution/index.html": ('data-library-attribution="true"', "Amir Beck", "Nicolas Boumal"),
    }
    forbidden = ("<strong>Owners</strong>", "Andi · Dake", "Dake · Huanjian · Andi", "ownership")
    for rel, markers in required.items():
        path = output / rel
        if not path.exists():
            errors.append(f"missing {rel}")
            continue
        text = path.read_text(encoding="utf-8")
        for marker in markers:
            if marker not in text:
                errors.append(f"{rel}: missing {marker}")
        for marker in forbidden:
            if marker in text:
                errors.append(f"{rel}: leaked internal assignment marker {marker!r}")
    for i in range(1, len(BOUMAL) + 1):
        if not (output / f"libraries/riemannian-optimization/chapter-{i:02d}.html").exists():
            errors.append(f"missing Boumal chapter {i}")
    for i in range(1, len(BECK) + 1):
        if not (output / f"libraries/first-order-optimization/chapter-{i:02d}.html").exists():
            errors.append(f"missing Beck chapter {i}")
    for path in output.rglob("*.html"):
        text = path.read_text(encoding="utf-8")
        start = text.find('<section class="sidebar-group sidebar-libraries"')
        stop = text.find("</section>", start)
        side = text[start:stop] if start >= 0 and stop >= 0 else ""
        if not all(name in side for name in ("Log-Concave Sampling", "SampleWiki", "Riemannian Optimization", "First-Order Optimization")):
            errors.append(f"{path.relative_to(output)}: incomplete Libraries sidebar")
            break
    if not (output / "assets" / STYLE_NAME).exists():
        errors.append("missing library-shelves.css")
    if errors:
        raise RuntimeError("library shelves validation failed:\n- " + "\n- ".join(errors))


def enrich_site(output: Path) -> None:
    write_pages(output)
    assets = output / "assets"
    assets.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(SOURCE_CSS, assets / STYLE_NAME)
    transform(output)
    validate(output)
