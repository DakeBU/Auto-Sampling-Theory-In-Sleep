#!/usr/bin/env python3
"""Render the widened ASTIS public scope and acceleration/geometry route.

This is a late presentation overlay only. It never promotes a conceptual mirror
or Lean prototype into the formal dependency DAG.
"""

from __future__ import annotations

import json
from html import escape
from pathlib import Path

import astis_site


ROOT = Path(__file__).resolve().parents[2]
PROGRAM = ROOT / "Libraries" / "acceleration-geometry-program.json"
ROUTE = "research-routes/acceleration-geometry/index.html"
PROJECT_SUBTITLE = (
    "An Automated Theorem Proving System and Visualized Lean Library for "
    "Sampling, Optimisation, and Geometry"
)
LIBRARY_SUBTITLE = "Verified Sampling, Optimisation, Geometry Theory in Lean"


def _program() -> dict:
    return json.loads(PROGRAM.read_text(encoding="utf-8"))


def _badge(kind: str) -> str:
    css = {
        "formal-lean": "blue",
        "lean-prototype": "gray",
        "source-theorem": "green",
        "proof-pattern-transfer": "yellow",
        "research-hypothesis": "orange",
    }.get(kind, "gray")
    return f'<span class="status status-{css}">{escape(kind)}</span>'


def _route_page(output: Path) -> None:
    data = _program()
    truth = "".join(_badge(row["id"]) for row in data["truth_classes"])
    textbooks = "".join(
        f'''<article id="{escape(row['id'])}">
        <div class="card-meta">Textbook · {escape(row['library'])}</div>
        <h3>{escape(row['source_anchor'])}</h3><p>{escape(row['role'])}</p>
        </article>'''
        for row in data["textbook_placement"]
    )
    spine = "".join(
        f'''<article><div class="card-meta">{escape(row['status'])}</div>
        <h3>{escape(row['id'])}</h3><p>{escape(row['role'])}</p>
        {f'<p><code>{escape(row["prototype_file"])}</code></p>' if row.get('prototype_file') else ''}
        </article>'''
        for row in data["shared_lean_spine"]
    )
    literature = "".join(
        f'''<article><h3>{escape(line['id'].removeprefix('line:').replace('-', ' ').title())}</h3>
        <ol>{''.join(f'<li><a href="{escape(src["url"])}"><strong>{escape(src["title"])}</strong></a><br><small>{escape(src["authors"])}</small><br>{escape(src["role"])}</li>' for src in line['mainline'])}</ol>
        {f'<p class="note">{escape(line["separation_rule"])}</p>' if line.get('separation_rule') else ''}
        {f'<p class="note">{escape(line["migration_rule"])}</p>' if line.get('migration_rule') else ''}
        </article>'''
        for line in data["literature_lines"]
    )
    edges = "".join(
        f'''<article><div class="card-meta">{_badge(edge['truth_class'])}</div>
        <h3>{escape(edge['id'])}</h3>
        <p><strong>Schema.</strong> {escape(edge['formula'])}</p>
        <p><strong>Mechanism.</strong> {escape(edge['mechanism'])}</p>
        <p><strong>Boundary.</strong> {escape(edge['failure_boundary'])}</p></article>'''
        for edge in data["hypergraph_extension"]
    )
    execution = "".join(f"<li>{escape(item)}</li>" for item in data["execution_order"])
    body = f'''
<section class="page-hero compact">
  <div class="eyebrow">Samplinglib · Lean-first cross-library route</div>
  <h1>Acceleration × Geometry Shared Spine</h1>
  <p class="lede">Formalize the common certificate algebra once, attach explicit geometry-specific adapters, and only then compress verified structure into the Functor Hypergraph.</p>
  <p><a class="button primary" href="../../libraries/optimisation/index.html">Start from Optimisation Textbook</a>
     <a class="button" href="../../lean-foundations.html?view=functor">Open Functor Hypergraph</a></p>
</section>
<section class="library-integration-note">
  <div class="section-heading"><span>Truth contract</span><h2>Similarity is not theorem implication.</h2></div>
  <p>Nesterov and underdamped Langevin are not identified as the same dynamics; Katyusha does not become a sampling theorem by analogy; nonquadratic norms are not silently relabelled as Riemannian metrics.</p>
  <div class="library-status-key">{truth}</div>
</section>
<section><div class="section-heading"><span>Textbook placement</span><h2>Optimisation produces; geometry and sampling adapt.</h2></div><div class="library-chapter-list">{textbooks}</div></section>
<section><div class="section-heading"><span>Shared Lean floor</span><h2>One concise substrate, explicit adapters.</h2></div><div class="library-chapter-list">{spine}</div></section>
<section class="library-integration-note"><div class="section-heading"><span>Literature line</span><h2>Proof architectures and kinetic-sampling acceleration.</h2></div><div class="library-chapter-list">{literature}</div></section>
<section><div class="section-heading"><span>Functor Hypergraph</span><h2>Typed transport relations.</h2></div><div class="library-chapter-list">{edges}</div></section>
<section class="library-integration-note"><div class="section-heading"><span>Execution DAG</span><h2>Lean before transport; transport before speculation.</h2></div><ol>{execution}</ol><p><a href="../../workflow/index.html">ASTIS Harness</a> · <a href="../../lean-foundations.html?view=functor">Underlying graph</a></p></section>
'''
    page = astis_site.page(
        "Acceleration × Geometry Shared Spine",
        ROUTE,
        body,
        active="Lean Foundations",
        description="Lean-first acceleration route across Optimisation, Riemannian Optimisation, Optimal Transport, and Sampling.",
    )
    astis_site.write_page(output, ROUTE, page)


def _patch_branding(output: Path) -> None:
    replacements = (
        ("Auto-Sampling-Theory-In-Sleep: A Hierarchical Automated Theorem Proving System for Sampling Theory", f"Auto-Sampling-Theory-In-Sleep: {PROJECT_SUBTITLE}"),
        ("An Automated Theorem Proving System and Visualized Lean Library for Sampling Theory", PROJECT_SUBTITLE),
        ("Verified Sampling Theory in Lean", LIBRARY_SUBTITLE),
        ("Verified sampling theory in Lean", LIBRARY_SUBTITLE),
        ("verified sampling theory in Lean", LIBRARY_SUBTITLE),
    )
    public_textbook = (
        ("Chapter scaffolds", "Textbook chapters"),
        ("Chapter scaffold", "Textbook"),
        ("Finite-state source scaffold", "Textbook"),
        ("Source scaffold", "Textbook"),
        ('status-gray">scaffold</span>', 'status-gray">Textbook route</span>'),
    )
    for path in sorted(output.rglob("*.html")):
        text = path.read_text(encoding="utf-8")
        original = text
        for old, new in replacements:
            text = text.replace(old, new)
        if path.relative_to(output).as_posix().startswith("libraries/"):
            for old, new in public_textbook:
                text = text.replace(old, new)
        if text != original:
            path.write_text(text, encoding="utf-8", newline="\n")

    for path in sorted(output.rglob("*.json")):
        text = path.read_text(encoding="utf-8")
        original = text
        for old, new in replacements:
            text = text.replace(old, new)
        if text != original:
            path.write_text(text, encoding="utf-8", newline="\n")


def _insert(path: Path, marker: str, panel: str) -> None:
    if not path.exists():
        return
    text = path.read_text(encoding="utf-8")
    if marker in text:
        return
    if "</main>" not in text:
        raise RuntimeError(f"{path}: no </main> for acceleration route overlay")
    path.write_text(text.replace("</main>", panel + "\n</main>", 1), encoding="utf-8", newline="\n")


def _attach_context(output: Path) -> None:
    home = output / "index.html"
    if home.exists():
        text = home.read_text(encoding="utf-8")
        if "data-project-scope-title" not in text and "<h1>Samplinglib</h1>" in text:
            scope = f'''<h1 id="samplinglib">Samplinglib</h1>
<p class="lede" data-project-scope-title="1"><strong>{escape(LIBRARY_SUBTITLE)}</strong></p>
<p class="lede"><strong>Auto-Sampling-Theory-In-Sleep.</strong> {escape(PROJECT_SUBTITLE)}</p>'''
            home.write_text(text.replace("<h1>Samplinglib</h1>", scope, 1), encoding="utf-8", newline="\n")

    chapter_panels = {
        "05": ("acceleration-linear-coupling-route", "Nesterov → Linear Coupling shared producer", "Chewi Chapter 5 remains canonical; Allen-Zhu--Orecchia is attached as a supplementary proof architecture coupling primal gradient progress with dual mirror progress."),
        "10": ("acceleration-mirror-geometry-route", "Mirror/Bregman and duality-map layer", "Chapter 10 supplies the dual/mirror geometry consumed by Linear Coupling and later Riemannian, Banach/Finsler, Wasserstein, and Stein adapters."),
        "12": ("acceleration-katyusha-route", "Variance reduction → Katyusha → inexact progress", "Chapter 12 is the canonical stochastic home. Katyusha is a finite-sum optimisation theorem; anchor-distribution or snapshot-score sampling is only a research hypothesis."),
    }
    for chapter, (marker, title, text) in chapter_panels.items():
        panel = f'''<section data-route-marker="{marker}" class="library-integration-note"><div class="section-heading"><span>Supplementary route</span><h2>{title}</h2></div><p>{text}</p><p><a href="../../research-routes/acceleration-geometry/index.html#optimisation-ch{int(chapter)}">Open Acceleration × Geometry route</a></p></section>'''
        _insert(output / "libraries" / "optimisation" / f"chapter-{chapter}.html", marker, panel)

    adapters = (
        (output / "libraries" / "riemannian-optimization" / "index.html", "riemannian-acceleration-adapter", "Riemannian acceleration adapter", "Consume common certificate algebra through tangent/cotangent conversion, log/retraction, vector transport, and explicit curvature/retraction defects.", "../../research-routes/acceleration-geometry/index.html#riemannian-acceleration"),
        (output / "libraries" / "statistical-optimal-transport" / "index.html", "ot-acceleration-adapter", "Optimal-transport acceleration adapter", "Reuse the certificate/Lyapunov skeleton with continuity-equation velocities, OT displacement, displacement convexity, and moving-map identities.", "../../research-routes/acceleration-geometry/index.html#optimal-transport-acceleration"),
        (output / "textbook" / "index.html", "sampling-acceleration-adapter", "Sampling acceleration mainline", "Keep the Nesterov/kinetic structural mirror, continuous-time hypocoercive acceleration, and discrete-time sampler complexity as three distinct theorem layers.", "../research-routes/acceleration-geometry/index.html#sampling-acceleration"),
    )
    for path, marker, title, text, href in adapters:
        _insert(path, marker, f'''<section data-route-marker="{marker}" class="library-integration-note"><div class="section-heading"><span>Cross-library route</span><h2>{title}</h2></div><p>{text}</p><p><a href="{href}">Open Acceleration × Geometry route</a></p></section>''')

    _insert(
        output / "libraries" / "index.html",
        "acceleration-geometry-shared-spine",
        '''<section id="acceleration-geometry-shared-spine" class="library-integration-note"><div class="section-heading"><span>Cross-library proof route</span><h2>Acceleration × Geometry Shared Spine</h2></div><p>Linear Coupling, Katyusha, differing-norm acceleration, and kinetic-sampling acceleration share a typed route without conflating analogy with theorem implication.</p><p><a href="../research-routes/acceleration-geometry/index.html">Open route</a></p></section>''',
    )
    _insert(
        output / "lean-foundations.html",
        "acceleration-geometry-program",
        '''<section id="acceleration-geometry-program" class="library-integration-note"><div class="section-heading"><span>Typed transport program</span><h2>Acceleration × Geometry</h2></div><p>Inspect the common Lean prototypes, proof-pattern transports, source theorems, and research-only cross-geometry hypotheses separately.</p><p><a href="research-routes/acceleration-geometry/index.html">Open route</a></p></section>''',
    )


def enrich_site(output: Path) -> None:
    _route_page(output)
    _patch_branding(output)
    _attach_context(output)
