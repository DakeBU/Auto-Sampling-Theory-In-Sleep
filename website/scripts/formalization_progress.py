#!/usr/bin/env python3
"""Project-level formalization progress for the three Samplinglib routes.

The detailed SampleWiki progress view is produced by the SampleWiki reader
pipeline.  This final overlay lifts that page out of the SampleWiki subtree,
adds the two textbook routes, exposes the small shared Lean floor between
routes, and keeps every route behind the same ASTIS verification workflow.
"""

from __future__ import annotations

import posixpath
import re
import shutil
from html import escape
from pathlib import Path
from urllib.parse import urlsplit, urlunsplit

import astis_site
import library_shelves


ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUTPUT = ROOT / "_site"
SOURCE_CSS = ROOT / "website" / "static" / "formalization-progress.css"
STYLE_NAME = "formalization-progress.css"
HARNESS = ROOT / "website" / "static" / "astis-harness-current.svg"
HARNESS_NAME = "astis-harness-current.svg"

OVERVIEW = "progress/index.html"
SAMPLEWIKI_ROUTE = "progress/samplewiki-route.html"
RIEMANNIAN_ROUTE = "progress/riemannian-optimization.html"
FIRST_ORDER_ROUTE = "progress/first-order-optimization.html"
OLD_SAMPLEWIKI_PROGRESS = "example-cases/samplewiki/progress.html"

PRIVATE_PUBLIC_MARKERS = (
    "ZDD-style",
    "categorical or functor-like",
    "alternative minimal supports",
)


def prefix(rel: str) -> str:
    return "../" * len(Path(rel).parent.parts)


def href_from(current: str, target: str) -> str:
    start = posixpath.dirname(current) or "."
    return posixpath.relpath(target, start=start)


def current(rel: str, target: str) -> str:
    return ' aria-current="page"' if rel == target else ""


def add_style(text: str, rel: str, style_name: str) -> str:
    href = f"{prefix(rel)}assets/{style_name}"
    if href in text:
        return text
    if "</head>" not in text:
        raise RuntimeError(f"{rel}: missing </head>")
    return text.replace("</head>", f'  <link rel="stylesheet" href="{href}">\n</head>', 1)


def progress_sidebar(rel: str) -> str:
    p = prefix(rel)
    return f"""<section class="sidebar-group sidebar-progress" data-formalization-progress="1">
  <h2><a href="{p}{OVERVIEW}">Current Progress</a></h2>
  <nav class="progress-route-nav">
    <a href="{p}{SAMPLEWIKI_ROUTE}"{current(rel, SAMPLEWIKI_ROUTE)}>SampleWiki Route</a>
    <a href="{p}{RIEMANNIAN_ROUTE}"{current(rel, RIEMANNIAN_ROUTE)}>Riemannian Optimization</a>
    <a href="{p}{FIRST_ORDER_ROUTE}"{current(rel, FIRST_ORDER_ROUTE)}>First-Order Optimization</a>
  </nav>
</section>"""


def insert_progress_sidebar(text: str, rel: str) -> str:
    text = re.sub(
        r'<section class="sidebar-group sidebar-progress".*?</section>',
        progress_sidebar(rel),
        text,
        count=1,
        flags=re.S,
    )
    if 'class="sidebar-group sidebar-progress"' in text:
        return text
    pattern = re.compile(r'(<section class="sidebar-group sidebar-libraries".*?</section>)', re.S)
    if not pattern.search(text):
        raise RuntimeError(f"{rel}: Libraries sidebar missing before Current Progress insertion")
    return pattern.sub(lambda match: match.group(1) + "\n" + progress_sidebar(rel), text, count=1)


def patch_site_nav(text: str, rel: str) -> str:
    p = prefix(rel)
    href = f"{p}{OVERVIEW}"
    pattern = re.compile(r'(<nav class="site-nav"[^>]*>)(.*?)(</nav>)', re.S)
    match = pattern.search(text)
    if not match:
        return text
    body = match.group(2)
    if re.search(r'href="[^"]*progress/index\.html"', body):
        return text
    active = ' aria-current="page"' if rel.startswith("progress/") else ""
    link = f'<a href="{href}"{active}>Current Progress</a>'
    replacement = match.group(1) + body + link + match.group(3)
    return text[: match.start()] + replacement + text[match.end() :]


def _rewrite_one_url(url: str, old_rel: str, new_rel: str) -> str:
    if not url or url.startswith(("#", "/", "//", "mailto:", "tel:", "data:", "javascript:")):
        return url
    parsed = urlsplit(url)
    if parsed.scheme or parsed.netloc or not parsed.path:
        return url
    old_parent = posixpath.dirname(old_rel) or "."
    target = posixpath.normpath(posixpath.join(old_parent, parsed.path))
    new_parent = posixpath.dirname(new_rel) or "."
    rebased = posixpath.relpath(target, start=new_parent)
    return urlunsplit(("", "", rebased, parsed.query, parsed.fragment))


def rebase_local_urls(text: str, old_rel: str, new_rel: str) -> str:
    pattern = re.compile(r'(?P<attr>href|src)="(?P<url>[^"]+)"')

    def repl(match: re.Match[str]) -> str:
        url = _rewrite_one_url(match.group("url"), old_rel, new_rel)
        return f'{match.group("attr")}="{url}"'

    return pattern.sub(repl, text)


def retarget_legacy_progress_links(text: str, rel: str) -> str:
    pattern = re.compile(r'href="(?P<url>[^"]+)"')

    def repl(match: re.Match[str]) -> str:
        url = match.group("url")
        if not url or url.startswith(("#", "/", "//", "mailto:", "tel:", "data:", "javascript:")):
            return match.group(0)
        parsed = urlsplit(url)
        if parsed.scheme or parsed.netloc or not parsed.path:
            return match.group(0)
        resolved = posixpath.normpath(posixpath.join(posixpath.dirname(rel) or ".", parsed.path))
        if resolved != OLD_SAMPLEWIKI_PROGRESS:
            return match.group(0)
        new_path = href_from(rel, SAMPLEWIKI_ROUTE)
        new_url = urlunsplit(("", "", new_path, parsed.query, parsed.fragment))
        return f'href="{new_url}"'

    return pattern.sub(repl, text)


def workflow_block(current_rel: str) -> str:
    p = prefix(current_rel)
    return f"""
<section class="progress-workflow" data-progress-verification-workflow="true">
  <div class="section-heading"><span>Verification Workflow</span><h2>All three routes publish through the same gate.</h2></div>
  <div class="progress-flow" aria-label="Verification workflow">
    <span>source audit</span><b>→</b><span>search & reuse</span><b>→</b><span>Frontier Cell if missing</span><b>→</b><span>focused test</span><b>→</b><span>independent review</span><b>→</b><span>stabilize & merge</span>
  </div>
  <p>A route is not marked complete merely because a local proof exists. Source-facing nodes also need statement fidelity review, the repository verification gates, and regeneration of the shared graph/index before publication.</p>
  <a class="button" href="{p}workflow/index.html">Open ASTIS Harness</a>
</section>
"""


def overview_body() -> str:
    return f"""
<section class="page-hero compact progress-hero" data-current-progress="overview">
  <div class="eyebrow">Samplinglib · Current Progress</div>
  <h1>Three formalization routes, one verified Lean floor.</h1>
  <p class="lede">The routes advance mostly in parallel. They share a declaration only when the mathematical statement and interface really coincide; otherwise the route keeps a small explicit adapter instead of forcing one formulation onto another.</p>
</section>
<section class="progress-route-grid" aria-label="Formalization routes">
  <article class="progress-route-card"><div class="portal-kicker">Dependency-first frontier route</div><h2>SampleWiki Route</h2><p>The existing shortest preparation path toward useful SampleWiki theorems. It prioritizes the textbook and analytic prerequisites that unlock frontier cases earliest.</p><a class="button primary" href="samplewiki-route.html">Open route</a></article>
  <article class="progress-route-card"><div class="portal-kicker">Textbook route</div><h2>Riemannian Optimization</h2><p>Boumal chapter formalization, with an explicit intersection checkpoint at Chewi §2.5 Riemannian Manifolds and any genuinely shared differential-geometric foundations.</p><a class="button" href="riemannian-optimization.html">Open route</a></article>
  <article class="progress-route-card"><div class="portal-kicker">Textbook + upstream route</div><h2>First-Order Optimization</h2><p>Beck aligned with Mathlib, Optlib and CvxLean, with candidate intersections at Chewi §4.3, Chapter 8 and Chapter 10.</p><a class="button" href="first-order-optimization.html">Open route</a></article>
</section>
<section class="progress-intersections">
  <div class="section-heading"><span>Shared Lean floor</span><h2>Parallel above; coordinated where foundations meet.</h2></div>
  <div class="progress-overlap-grid">
    <article><span>Geometry checkpoint</span><h3>Chewi §2.5 ↔ Boumal</h3><p>Riemannian manifolds, tangent-space/differential interfaces and related analytic lemmas are candidate shared foundations. Reuse is accepted only after statement and convention compatibility are checked.</p></article>
    <article><span>Optimization checkpoint</span><h3>Chewi §4.3 / Ch. 8 / Ch. 10 ↔ Beck</h3><p>Convex-optimization arguments, proximal structure, stochastic/coordinate methods and mirror geometry may meet Beck/Optlib/CvxLean and SampleWiki. The common node is shared only when it is genuinely the same theorem.</p></article>
    <article><span>Collision rule</span><h3>One canonical shared theorem, not three copies</h3><p>Search first. Exact match → reuse. Near match → canonical core plus route adapter. Missing shared fact → one shared Frontier Cell. Conflicting conventions stay explicit rather than silently overwriting an existing declaration.</p></article>
  </div>
</section>
{workflow_block(OVERVIEW)}
"""


def milestones(items: list[tuple[str, str, str]]) -> str:
    return '<div class="progress-milestones">' + ''.join(
        f'<article><div class="progress-milestone-head"><span>{escape(status)}</span><b>{index:02d}</b></div><h3>{escape(title)}</h3><p>{escape(copy)}</p></article>'
        for index, (status, title, copy) in enumerate(items, 1)
    ) + '</div>'


def riemannian_body() -> str:
    items = [
        ("scaffold", "Book map and stable chapter environment", "Boumal's eleven chapters have stable public routes and source boundaries; this is not a claim of completed Lean formalization."),
        ("planned", "Shared geometry floor", "Audit Mathlib and existing Samplinglib geometry first. Chewi §2.5 is the explicit cross-route checkpoint before any duplicate manifold foundation is introduced."),
        ("planned", "Boumal Chapters 1–4", "Definitions, examples, embedded first-order geometry, and first-order Riemannian optimization algorithms."),
        ("planned", "Boumal Chapters 5–6", "Embedded second-order geometry and second-order optimization algorithms."),
        ("planned", "Boumal Chapters 7–11", "Embedded submanifolds, general and quotient manifolds, additional tools, and geodesic convexity."),
    ]
    return f"""
<section class="page-hero compact progress-hero" data-current-progress="riemannian">
  <div class="eyebrow">Current Progress · Riemannian Optimization Route</div><h1>Riemannian Optimization</h1>
  <p class="lede">Boumal's textbook advances as its own route. The route shares low-level Lean only after semantic compatibility has been checked, especially around Chewi §2.5 Riemannian Manifolds.</p>
  <p><a href="index.html">← All routes</a> · <a href="../libraries/riemannian-optimization/index.html">Open textbook scaffold</a></p>
</section>
<section><div class="section-heading"><span>Route milestones</span><h2>Chapter progress without duplicate foundations.</h2></div>{milestones(items)}</section>
<section class="progress-shared-policy"><h2>Intersection contract</h2><p>A Boumal theorem does not become a Chewi theorem merely because both use manifolds. Exact shared foundations live once in the common Lean layer; source-facing theorems remain attached to their own source and use adapters when conventions differ.</p></section>
{workflow_block(RIEMANNIAN_ROUTE)}
"""


def first_order_body() -> str:
    items = [
        ("scaffold", "Book map and upstream register", "Beck's fifteen chapters have stable routes; Optlib and CvxLean are explicit upstream sources rather than opaque copied code."),
        ("planned", "Beck Chapters 1–7", "Vector spaces, extended-real functions, subgradients, conjugates, smoothness/strong convexity, proximal operators, and spectral functions."),
        ("planned", "Beck Chapters 8–10", "Projected subgradient methods, mirror descent, and proximal gradient methods. These are high-value intersection checkpoints for sampling."),
        ("planned", "Beck Chapters 11–15", "Block/dual proximal methods, conditional gradient, alternating minimization, and ADMM."),
        ("planned", "Sampling intersection audit", "Compare against Chewi §4.3, Chapter 8 and Chapter 10, and against relevant SampleWiki cases. Reuse only exact theorem-level matches; otherwise introduce an explicit adapter."),
    ]
    return f"""
<section class="page-hero compact progress-hero" data-current-progress="first-order">
  <div class="eyebrow">Current Progress · First-Order Optimization Route</div><h1>First-Order Optimization</h1>
  <p class="lede">Beck provides the textbook spine; Mathlib, Optlib and CvxLean are searched before new declarations are created. Sampling intersections are recorded explicitly instead of being duplicated inside separate route folders.</p>
  <p><a href="index.html">← All routes</a> · <a href="../libraries/first-order-optimization/index.html">Open textbook scaffold</a></p>
</section>
<section><div class="section-heading"><span>Route milestones</span><h2>Reuse first; formalize only the real gaps.</h2></div>{milestones(items)}</section>
<section class="progress-shared-policy"><h2>Intersection contract</h2><p>Chewi's convex/proximal/mirror arguments and Beck's optimization results can share a lower-level theorem only when hypotheses, objects and conclusions agree. Optlib/CvxLean matches are version- and convention-audited; route-specific wrappers stay small and visible.</p></section>
{workflow_block(FIRST_ORDER_ROUTE)}
"""


def write_page(output: Path, rel: str, title: str, body: str, description: str) -> None:
    text = astis_site.page(title, rel, body, active="Progress", description=description)
    astis_site.write_page(output, rel, text)


def lift_samplewiki_progress(output: Path) -> None:
    old_path = output / OLD_SAMPLEWIKI_PROGRESS
    if not old_path.exists():
        raise RuntimeError("final SampleWiki progress page is missing before route lift")
    text = old_path.read_text(encoding="utf-8")
    text = rebase_local_urls(text, OLD_SAMPLEWIKI_PROGRESS, SAMPLEWIKI_ROUTE)
    text = re.sub(r"<title>.*?</title>", "<title>SampleWiki Route · Current Progress · Samplinglib</title>", text, count=1, flags=re.S)
    text = text.replace("<h1>Source audit and Lean progress</h1>", "<h2>Source audit and Lean progress</h2>", 1)
    banner = f"""
<section class="page-hero compact progress-hero progress-samplewiki-banner" data-current-progress="samplewiki">
  <div class="eyebrow">Current Progress · SampleWiki Route</div>
  <h1>SampleWiki Route</h1>
  <p class="lede">The dependency-first shortest preparation path toward useful SampleWiki results. The detailed source-audit and Lean frontier below is preserved from the existing SampleWiki progress view.</p>
  <p><a href="index.html">← All routes</a> · <a href="../example-cases/samplewiki.html">Open SampleWiki</a></p>
</section>
"""
    marker = '<main id="content">'
    if marker not in text:
        raise RuntimeError("lifted SampleWiki route is missing main content")
    text = text.replace(marker, marker + banner, 1)
    new_path = output / SAMPLEWIKI_ROUTE
    new_path.parent.mkdir(parents=True, exist_ok=True)
    new_path.write_text(text, encoding="utf-8", newline="\n")

    alias_body = f"""
<section class="page-hero compact"><div class="eyebrow">Current Progress</div><h1>SampleWiki Route</h1><p class="lede">This progress view has moved to the project-level Current Progress section.</p><p><a class="button primary" href="../../{SAMPLEWIKI_ROUTE}">Open SampleWiki Route</a></p></section>
"""
    alias = astis_site.page("SampleWiki Route — moved", OLD_SAMPLEWIKI_PROGRESS, alias_body, active="Progress")
    alias = alias.replace(
        "</head>",
        f'  <link rel="canonical" href="../../{SAMPLEWIKI_ROUTE}">\n  <meta http-equiv="refresh" content="0; url=../../{SAMPLEWIKI_ROUTE}">\n</head>',
        1,
    )
    old_path.write_text(alias, encoding="utf-8", newline="\n")


def home_blocks() -> str:
    return """
<section class="home-progress" data-formalization-progress-home="true">
  <div class="section-heading"><span>Current Progress</span><h2>Three routes, coordinated at the shared Lean floor.</h2></div>
  <div class="home-progress-grid">
    <a href="progress/samplewiki-route.html"><strong>SampleWiki Route</strong><span>dependency-first path to frontier results</span></a>
    <a href="progress/riemannian-optimization.html"><strong>Riemannian Optimization</strong><span>Boumal textbook route</span></a>
    <a href="progress/first-order-optimization.html"><strong>First-Order Optimization</strong><span>Beck + Optlib + CvxLean route</span></a>
  </div>
  <p><a class="button" href="progress/index.html">Open Current Progress</a></p>
</section>
<section class="home-harness" data-harness-home="true">
  <div class="section-heading"><span>ASTIS Harness</span><h2>One verification workflow for every route.</h2></div>
  <p>Parallel formalization is allowed; publication is not. Shared lemmas are reused or coordinated as canonical Frontier Cells, then independently reviewed and stabilized before they enter Samplinglib.</p>
  <figure><img src="assets/astis-harness-current.svg" alt="ASTIS Harness theorem-driven verification workflow"></figure>
  <p><a class="button" href="workflow/index.html">Open Harness</a></p>
</section>
"""


def patch_home(text: str) -> str:
    if 'data-formalization-progress-home="true"' in text:
        return text
    pattern = re.compile(r'(<section class="source-portal-grid source-portal-grid-four".*?</section>)', re.S)
    if not pattern.search(text):
        raise RuntimeError("homepage four-library portal section missing")
    return pattern.sub(lambda match: match.group(1) + home_blocks(), text, count=1)


def transform_site(output: Path) -> None:
    for path in sorted(output.rglob("*.html")):
        rel = path.relative_to(output).as_posix()
        text = path.read_text(encoding="utf-8")
        text = library_shelves.replace_sidebar(text, rel)
        text = library_shelves.add_style(text, rel)
        text = insert_progress_sidebar(text, rel)
        text = patch_site_nav(text, rel)
        text = retarget_legacy_progress_links(text, rel)
        text = add_style(text, rel, STYLE_NAME)
        if rel == "index.html":
            text = patch_home(text)
        path.write_text(text, encoding="utf-8", newline="\n")


def validate(output: Path) -> None:
    errors: list[str] = []
    required = {
        OVERVIEW: ("Three formalization routes, one verified Lean floor.", "SampleWiki Route", "Riemannian Optimization", "First-Order Optimization", "Verification Workflow"),
        SAMPLEWIKI_ROUTE: ("Current Progress · SampleWiki Route", "SampleWiki Route", "Dependency-first formalization route"),
        RIEMANNIAN_ROUTE: ("Chewi §2.5", "Boumal Chapters 1–4", "Verification Workflow"),
        FIRST_ORDER_ROUTE: ("Chewi §4.3", "Chapter 8", "Chapter 10", "Optlib", "CvxLean", "Verification Workflow"),
        "index.html": ('data-formalization-progress-home="true"', 'data-harness-home="true"', HARNESS_NAME),
    }
    for rel, markers in required.items():
        path = output / rel
        if not path.exists():
            errors.append(f"missing {rel}")
            continue
        text = path.read_text(encoding="utf-8")
        for marker in markers:
            if marker not in text:
                errors.append(f"{rel}: missing {marker}")

    alias = output / OLD_SAMPLEWIKI_PROGRESS
    if not alias.exists() or SAMPLEWIKI_ROUTE not in alias.read_text(encoding="utf-8"):
        errors.append("legacy SampleWiki progress route is not a stable alias")

    for path in output.rglob("*.html"):
        rel = path.relative_to(output).as_posix()
        text = path.read_text(encoding="utf-8")
        if 'class="sidebar-group sidebar-progress"' not in text:
            errors.append(f"{rel}: Current Progress sidebar missing")
            break
        for marker in PRIVATE_PUBLIC_MARKERS:
            if marker in text:
                errors.append(f"{rel}: private research marker leaked: {marker}")

    css = (output / "assets" / "library-shelves.css").read_text(encoding="utf-8")
    for color in ("#7b61a8", "#a36f27"):
        if color in css.lower():
            errors.append(f"library stylesheet still contains route-specific hardcoded color {color}")
    if "var(--accent)" not in css:
        errors.append("library stylesheet does not inherit the shared accent theme")
    if not (output / "assets" / STYLE_NAME).exists():
        errors.append(f"missing assets/{STYLE_NAME}")
    if not (output / "assets" / HARNESS_NAME).exists():
        errors.append(f"missing assets/{HARNESS_NAME}")
    if errors:
        raise RuntimeError("formalization progress validation failed:\n- " + "\n- ".join(errors))


def enrich_site(output: Path = DEFAULT_OUTPUT) -> None:
    assets = output / "assets"
    assets.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(SOURCE_CSS, assets / STYLE_NAME)
    shutil.copyfile(HARNESS, assets / HARNESS_NAME)

    lift_samplewiki_progress(output)
    write_page(
        output,
        OVERVIEW,
        "Current Progress",
        overview_body(),
        "Samplinglib formalization progress across SampleWiki, Riemannian Optimization, and First-Order Optimization routes.",
    )
    write_page(
        output,
        RIEMANNIAN_ROUTE,
        "Riemannian Optimization — Current Progress",
        riemannian_body(),
        "Current Boumal/Riemannian Optimization formalization route and shared Lean checkpoints.",
    )
    write_page(
        output,
        FIRST_ORDER_ROUTE,
        "First-Order Optimization — Current Progress",
        first_order_body(),
        "Current Beck/first-order optimization formalization route and shared Lean checkpoints.",
    )
    transform_site(output)
    validate(output)


if __name__ == "__main__":
    enrich_site()
