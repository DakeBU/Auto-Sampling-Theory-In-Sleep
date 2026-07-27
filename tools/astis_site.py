#!/usr/bin/env python3
"""Build and validate the ASTIS Blueprint-style textbook website.

The generated status is deliberately not a second theorem registry.  Blue
declarations come from `TechnicalLemmas/Registry.lean`, are resolved against
the Lean source tree, and are covered by the repository's `lake build Tests`
gate.  Pedagogical prose and Chewi source correspondence live under
`website/content`.
"""

from __future__ import annotations

import argparse
import dataclasses
import html
import json
import re
import shutil
import sys
from collections import Counter, defaultdict
from pathlib import Path
from typing import Iterable
from urllib.parse import urlparse


ROOT = Path(__file__).resolve().parents[1]
WEBSITE = ROOT / "website"
CONTENT = WEBSITE / "content"
STATIC = WEBSITE / "static"
DIAGRAMS = WEBSITE / "diagrams"
REGISTRY = ROOT / "AutoSamplingTheory" / "TechnicalLemmas" / "Registry.lean"
TESTS = ROOT / "Tests" / "Basic.lean"
DEFAULT_OUTPUT = ROOT / "_site"
GITHUB_ROOT = "https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep/blob/main"
CHEWI_URL = "https://chewisinho.github.io/main.pdf"


@dataclasses.dataclass
class RegistryEntry:
    key: str
    local_decl: str
    upstream_decl: str
    upstream_file: str
    status: str
    tags: list[str]
    sald_use: str
    note: str
    source_file: str = ""
    source_line: int = 0
    source_text: str = ""
    docstring: str = ""
    explicit_test: bool = False
    dependencies: list[str] = dataclasses.field(default_factory=list)
    consumers: list[str] = dataclasses.field(default_factory=list)

    @property
    def short_name(self) -> str:
        return self.local_decl.rsplit(".", 1)[-1] if self.local_decl else self.key

    @property
    def namespace(self) -> str:
        return self.local_decl.rsplit(".", 1)[0] if "." in self.local_decl else ""

    @property
    def slug(self) -> str:
        return slugify(self.local_decl or self.key)

    @property
    def is_blue(self) -> bool:
        return self.status == "formalizedLocal" and bool(self.source_file)


def slugify(value: str) -> str:
    value = re.sub(r"[^a-zA-Z0-9]+", "-", value).strip("-").lower()
    return value or "entry"


def esc(value: object) -> str:
    return html.escape(str(value), quote=True)


def load_json(path: Path) -> object:
    return json.loads(path.read_text(encoding="utf-8"))


def parse_string(field: str, block: str) -> str:
    match = re.search(rf"\b{re.escape(field)}\s*:=\s*\"((?:[^\"\\]|\\.)*)\"", block)
    if not match:
        return ""
    return json.loads(f'"{match.group(1)}"')


def parse_registry() -> list[RegistryEntry]:
    text = REGISTRY.read_text(encoding="utf-8")
    blocks = re.findall(r"\{\s*key\s*:=.*?\n\s*\}", text, flags=re.S)
    entries: list[RegistryEntry] = []
    for block in blocks:
        status_match = re.search(r"status\s*:=\s*LemmaMemoryStatus\.(\w+)", block)
        tags_match = re.search(r"tags\s*:=\s*\[(.*?)\]", block, flags=re.S)
        tags = re.findall(r'"((?:[^"\\]|\\.)*)"', tags_match.group(1)) if tags_match else []
        entries.append(
            RegistryEntry(
                key=parse_string("key", block),
                local_decl=parse_string("localDecl", block),
                upstream_decl=parse_string("upstreamDecl", block),
                upstream_file=parse_string("upstreamFile", block),
                status=status_match.group(1) if status_match else "referenceOnly",
                tags=[json.loads(f'"{tag}"') for tag in tags],
                sald_use=parse_string("saldUse", block),
                note=parse_string("note", block),
            )
        )
    if not entries:
        raise RuntimeError(f"no registry entries parsed from {REGISTRY}")
    return entries


def lean_module_from_path(path: Path) -> str:
    return ".".join(path.relative_to(ROOT).with_suffix("").parts)


def source_index() -> tuple[dict[str, dict[str, object]], dict[str, str]]:
    """Index top-level Lean declarations by fully qualified and short names."""
    indexed: dict[str, dict[str, object]] = {}
    module_files: dict[str, str] = {}
    declaration_re = re.compile(
        r"^\s*(?:noncomputable\s+)?(?:private\s+)?"
        r"(?:theorem|lemma|def|abbrev|structure|class|inductive)\s+([A-Za-z0-9_'.]+)"
    )
    for path in sorted((ROOT / "AutoSamplingTheory").rglob("*.lean")):
        rel = path.relative_to(ROOT).as_posix()
        module = lean_module_from_path(path)
        module_files[module] = rel
        lines = path.read_text(encoding="utf-8").splitlines()
        namespace_stack: list[str] = []
        starts: list[tuple[int, str, list[str]]] = []
        for i, line in enumerate(lines):
            ns_match = re.match(r"^\s*namespace\s+([A-Za-z0-9_'.]+)\s*$", line)
            if ns_match:
                namespace_stack.append(ns_match.group(1))
                continue
            if re.match(r"^\s*end(?:\s+[A-Za-z0-9_'.]+)?\s*$", line) and namespace_stack:
                namespace_stack.pop()
                continue
            match = declaration_re.match(line)
            if match:
                starts.append((i, match.group(1), list(namespace_stack)))
        for pos, (start, name, namespaces) in enumerate(starts):
            end = starts[pos + 1][0] if pos + 1 < len(starts) else len(lines)
            full = name if "." in name else ".".join([*namespaces, name])
            doc_lines: list[str] = []
            cursor = start - 1
            while cursor >= 0 and not lines[cursor].strip():
                cursor -= 1
            if cursor >= 0 and "-/" in lines[cursor]:
                while cursor >= 0:
                    doc_lines.append(lines[cursor])
                    if "/--" in lines[cursor] or "/-!" in lines[cursor]:
                        break
                    cursor -= 1
                doc_lines.reverse()
            doc = "\n".join(doc_lines)
            doc = re.sub(r"^\s*/-[*!]?", "", doc)
            doc = re.sub(r"-/\s*$", "", doc).strip()
            source_text = "\n".join(lines[start:end]).rstrip()
            record = {
                "full_name": full,
                "short_name": name.rsplit(".", 1)[-1],
                "file": rel,
                "line": start + 1,
                "module": module,
                "source_text": source_text,
                "docstring": doc,
            }
            indexed[full] = record
    return indexed, module_files


def enrich_entries(entries: list[RegistryEntry]) -> tuple[list[RegistryEntry], dict[str, str]]:
    indexed, module_files = source_index()
    tests_text = TESTS.read_text(encoding="utf-8")
    by_short: dict[str, list[dict[str, object]]] = defaultdict(list)
    for record in indexed.values():
        by_short[str(record["short_name"])].append(record)

    for entry in entries:
        record = indexed.get(entry.local_decl)
        if record is None and entry.local_decl:
            candidates = by_short.get(entry.short_name, [])
            if len(candidates) == 1:
                record = candidates[0]
        if record:
            entry.source_file = str(record["file"])
            entry.source_line = int(record["line"])
            entry.source_text = str(record["source_text"])
            entry.docstring = str(record["docstring"])
        entry.explicit_test = entry.short_name in tests_text

    local_by_short = {
        entry.short_name: entry.local_decl
        for entry in entries
        if entry.local_decl and entry.source_text
    }
    for entry in entries:
        if not entry.source_text:
            continue
        deps: set[str] = set()
        for short, full in local_by_short.items():
            if full == entry.local_decl:
                continue
            if re.search(rf"(?<![A-Za-z0-9_']){re.escape(short)}(?![A-Za-z0-9_'])", entry.source_text):
                deps.add(full)
        entry.dependencies = sorted(deps)
    by_decl = {entry.local_decl: entry for entry in entries if entry.local_decl}
    for entry in entries:
        for dep in entry.dependencies:
            if dep in by_decl:
                by_decl[dep].consumers.append(entry.local_decl)
    for entry in entries:
        entry.consumers = sorted(set(entry.consumers))
    return entries, module_files


def test_registry_count() -> int | None:
    text = TESTS.read_text(encoding="utf-8")
    matches = re.findall(r"(?:exact|native_decide|decide).*?(\d+)", text)
    count_lines = [
        line for line in text.splitlines()
        if "technicalLemmaMemory" in line or "formalized" in line.lower() or "256" in line
    ]
    for line in reversed(count_lines):
        match = re.search(r"\b(\d{2,4})\b", line)
        if match:
            return int(match.group(1))
    return int(matches[-1]) if matches else None


def status_class(entry: RegistryEntry) -> str:
    if entry.is_blue:
        return "blue"
    return {
        "portCandidate": "purple",
        "sourceGap": "orange",
        "referenceOnly": "gray",
        "formalizedLocal": "orange",
    }.get(entry.status, "red")


def status_label(entry: RegistryEntry) -> str:
    if entry.is_blue:
        return "compiled ASTIS leaf"
    return {
        "portCandidate": "external port candidate",
        "sourceGap": "typed source gap",
        "referenceOnly": "external reference",
        "formalizedLocal": "registry/source mismatch",
    }.get(entry.status, "todo")


def badge(label: str, css: str) -> str:
    return f'<span class="status status-{esc(css)}">{esc(label)}</span>'


def list_html(items: Iterable[object], *, empty: str = "None recorded.") -> str:
    values = list(items)
    if not values:
        return f'<p class="muted">{esc(empty)}</p>'
    return "<ul>" + "".join(f"<li>{esc(value)}</li>" for value in values) + "</ul>"


def code_html(code: str, language: str = "lean") -> str:
    return f'<pre class="code-block"><code class="language-{esc(language)}">{esc(code)}</code></pre>'


NAV = [
    ("Home", "index.html"),
    ("Textbook", "textbook/index.html"),
    ("Implementation", "implementation-map/index.html"),
    ("Source map", "source-correspondence.html"),
    ("Dependencies", "dependency-explorer.html"),
    ("Progress", "progress.html"),
    ("Frontier", "frontier.html"),
    ("Learn Lean", "learn-lean.html"),
]


def relative_prefix(rel_path: str) -> str:
    return "../" * (len(Path(rel_path).parts) - 1)


def page(
    title: str,
    rel_path: str,
    body: str,
    *,
    description: str = "ASTIS textbook and Lean formalization",
    active: str = "",
    extra_head: str = "",
) -> str:
    prefix = relative_prefix(rel_path)
    nav = "".join(
        f'<a href="{prefix}{href}"{" aria-current=\"page\"" if label == active else ""}>{esc(label)}</a>'
        for label, href in NAV
    )
    return f"""<!doctype html>
<html lang="en" data-theme="blueprint" data-color-scheme="light">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="{esc(description)}">
  <meta property="og:title" content="{esc(title)} · ASTIS">
  <meta property="og:description" content="{esc(description)}">
  <meta property="og:image" content="{prefix}assets/astis-blueprint-og.png">
  <title>{esc(title)} · Auto-Sampling-Theory-In-Sleep</title>
  <link rel="stylesheet" href="{prefix}assets/styles.css">
  <script>
    window.MathJax = {{
      tex: {{inlineMath: [['\\\\(', '\\\\)']], displayMath: [['\\\\[', '\\\\]']]}},
      options: {{skipHtmlTags: ['script','noscript','style','textarea','pre','code']}}
    }};
  </script>
  <script defer src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
  {extra_head}
</head>
<body>
  <a class="skip-link" href="#content">Skip to content</a>
  <header class="site-header">
    <a class="brand" href="{prefix}index.html">
      <span class="brand-mark">A</span>
      <span><strong>ASTIS</strong><small>Log-Concave Sampling blueprint</small></span>
    </a>
    <button class="nav-toggle" aria-expanded="false" aria-controls="site-nav">Menu</button>
    <nav id="site-nav" class="site-nav" aria-label="Primary">{nav}</nav>
    <div class="display-controls">
      <label>Theme
        <select id="theme-select">
          <option value="blueprint">Blueprint</option>
          <option value="modern">Modern</option>
          <option value="bold">Bold</option>
        </select>
      </label>
      <button id="scheme-toggle" title="Toggle light and dark color scheme">◐</button>
    </div>
  </header>
  <main id="content">{body}</main>
  <footer>
    <p><strong>Auto-Sampling-Theory-In-Sleep</strong> · a faithful, dependency-aware reconstruction of Sinho Chewi's <em>Log-Concave Sampling</em>.</p>
    <p><a href="{prefix}attribution.html">Attribution and licensing</a> · <a href="{prefix}maintenance.html">Build and maintenance</a> · Generated from ASTIS-owned metadata.</p>
  </footer>
  <script src="{prefix}assets/app.js"></script>
</body>
</html>
"""


def write_page(output: Path, rel_path: str, content: str) -> None:
    target = output / rel_path
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(content, encoding="utf-8", newline="\n")


def diagram_block(name: str, caption: str) -> str:
    source = (DIAGRAMS / f"{name}.mmd").read_text(encoding="utf-8")
    return (
        f'<figure class="diagram"><pre class="mermaid">{esc(source)}</pre>'
        f"<figcaption>{esc(caption)}</figcaption></figure>"
    )


def render_home(chapters: list[dict[str, object]], entries: list[RegistryEntry]) -> str:
    blue = [entry for entry in entries if entry.is_blue]
    statuses = Counter(chapter["status"] for chapter in chapters)
    body = f"""
<section class="hero">
  <div class="eyebrow">Textbook · rigorous completion · Lean dependency tree</div>
  <h1>Learn log-concave sampling at the depth you need.</h1>
  <p class="lede">Auto-Sampling-Theory-In-Sleep rebuilds Sinho Chewi's
  <em>Log-Concave Sampling</em> as a student-facing textbook, an audit of the
  arguments that prose often suppresses, and a compiled Lean foundation.</p>
  <div class="hero-actions">
    <a class="button primary" href="textbook/chapter-01.html">Start Chapter 1</a>
    <a class="button" href="implementation-map/index.html">Open implementation map</a>
  </div>
  <div class="metric-row">
    <div><strong>{len(blue)}</strong><span>compiled local leaves</span></div>
    <div><strong>{len(chapters)}</strong><span>book chapters mapped</span></div>
    <div><strong>{statuses.get("active", 0)}</strong><span>active chapter frontier</span></div>
    <div><strong>3</strong><span>linked learning depths</span></div>
  </div>
</section>
<section>
  <div class="section-heading"><span>Choose a depth</span><h2>One route, three lenses</h2></div>
  <div class="depth-grid">
    <article class="depth-card calculation">
      <div class="depth-number">01</div><h3>Calculation Route</h3>
      <p>Follow the concepts, formulas, proof calculations, and complexity route with minimal interruption.</p>
      <a href="calculation-route.html">Read the mathematical spine →</a>
    </article>
    <article class="depth-card rigorous">
      <div class="depth-number">02</div><h3>Rigorous Details</h3>
      <p>Ask why a step is valid: measurability, integrability, approximation, domains, representatives, and limits.</p>
      <a href="rigorous-details.html">Open the hidden contracts →</a>
    </article>
    <article class="depth-card lean">
      <div class="depth-number">03</div><h3>Lean Foundations</h3>
      <p>Trace each compiled leaf to its exact statement, source line, dependencies, consumers, Registry entry, and test gate.</p>
      <a href="lean-foundations.html">Descend to Lean →</a>
    </article>
  </div>
</section>
<section class="split">
  <div>
    <div class="section-heading"><span>Current truth</span><h2>The frontier is not a slogan</h2></div>
    <p>Cycle 28 is the latest completed cycle in this worktree. The generic
    PiLp cutoff-gradient norm limit, source-field integrability handoff, and
    vector integral limit are blue. The next audit targets concrete
    generator-display integrability. Gibbs tails, whole-space weighted
    integration by parts, operator domains, and invariance remain separate red nodes.</p>
    <a class="text-link" href="frontier.html">Inspect the strict boundary →</a>
  </div>
  {diagram_block("current-frontier", "Current Chapter 1 frontier. Blue means compiled ASTIS declarations; red means unfinished mathematical edges.")}
</section>
<section>
  <div class="section-heading"><span>Book map</span><h2>Twelve connected chapters</h2></div>
  {diagram_block("chapter-spine", "The chapter spine is a learning dependency map, not a claim that every chapter is already formalized.")}
</section>
<section class="note copyright-note">
  <h2>Self-contained without pretending to be the source</h2>
  <p>The book draft exposes no explicit republication license. ASTIS therefore
  provides original, faithful exposition and exact source correspondence
  rather than reproducing long passages. Chewi did not author, endorse, or
  maintain this site.</p>
  <p><a href="{CHEWI_URL}">Open the original book</a> · <a href="attribution.html">Read the attribution and copyright policy</a></p>
</section>
"""
    return page("Home", "index.html", body, active="Home")


def chapter_status_badge(status: str) -> str:
    mapping = {
        "active": ("active frontier", "orange"),
        "partial": ("partially formalized", "yellow"),
        "planned": ("planned", "red"),
    }
    label, css = mapping.get(status, (status, "gray"))
    return badge(label, css)


def render_textbook_index(chapters: list[dict[str, object]]) -> str:
    cards = []
    for chapter in chapters:
        cards.append(
            f"""<article class="chapter-card">
  <div class="chapter-index">{int(chapter["number"]):02d}</div>
  <div>
    <div class="card-meta">Source pp. {esc(chapter["source_pages"])} · {chapter_status_badge(str(chapter["status"]))}</div>
    <h2><a href="{esc(chapter["id"])}.html">{esc(chapter["title"])}</a></h2>
    <p>{esc(chapter["goal"])}</p>
    <div class="tag-row">{''.join(f'<span>{esc(tag)}</span>' for tag in chapter["concepts"][:5])}</div>
  </div>
</article>"""
        )
    body = f"""
<section class="page-hero compact">
  <div class="eyebrow">Textbook spine</div>
  <h1>A reconstructed learning route through <em>Log-Concave Sampling</em></h1>
  <p class="lede">Each chapter can be read at calculation, rigorous-detail,
  or Lean-foundation depth. Page references point to the June 12, 2026 book draft.</p>
</section>
{diagram_block("chapter-spine", "Logical chapter dependencies and recommended route.")}
<section class="chapter-list">{''.join(cards)}</section>
"""
    return page("Textbook", "textbook/index.html", body, active="Textbook")


def chapter_source_entries(chapter_number: int, source_entries: list[dict[str, object]]) -> list[dict[str, object]]:
    return [entry for entry in source_entries if int(entry["chapter"]) == chapter_number]


def render_chapter(
    chapter: dict[str, object],
    source_entries: list[dict[str, object]],
    entries_by_decl: dict[str, RegistryEntry],
) -> str:
    mapped = chapter_source_entries(int(chapter["number"]), source_entries)
    route = "".join(
        f"""<article class="calculation-step">
  <span class="step-kicker">Step {i}</span><h3>{esc(step["title"])}</h3>
  <div class="formula">\\[{esc(step["formula"])}\\]</div><p>{esc(step["explanation"])}</p>
</article>"""
        for i, step in enumerate(chapter["calculation_route"], 1)
    )
    mappings = []
    for source in mapped:
        decls = []
        for decl in source["lean_declarations"]:
            entry = entries_by_decl.get(str(decl))
            if entry:
                decls.append(
                    f'<a class="decl-link" href="../theorems/{entry.slug}.html">{esc(entry.short_name)}</a>'
                )
            else:
                decls.append(f'<span class="status status-orange">unresolved metadata: {esc(decl)}</span>')
        mappings.append(
            f"""<article class="source-card">
  <div class="card-meta">{esc(source["source_kind"])} · p. {esc(source["page"])} · {badge(source["status"], "blue" if source["status"] == "compiled" else "red" if source["status"] == "todo" else "yellow")}</div>
  <h3>{esc(source["source_summary"])}</h3>
  <p>{esc(source["astis_exposition"])}</p>
  <div class="decl-links">{''.join(decls) if decls else '<span class="muted">No ASTIS-owned declaration mapped yet.</span>'}</div>
  <a href="{esc(source["source_url"])}">Precise source anchor ↗</a>
</article>"""
        )
    module_links = []
    for module in chapter["lean_modules"]:
        module_links.append(
            f'<a href="../modules/{slugify(str(module))}.html"><code>{esc(module)}</code></a>'
        )
    graph = diagram_block("chapter-01-dag", "Chapter 1 local dependency DAG.") if int(chapter["number"]) == 1 else diagram_block("shared-root-dag", "Shared ASTIS roots used across chapters.")
    body = f"""
<section class="page-hero compact chapter-hero">
  <div class="eyebrow">Chapter {int(chapter["number"]):02d} · source pp. {esc(chapter["source_pages"])}</div>
  <h1>{esc(chapter["title"])}</h1>
  <p class="lede">{esc(chapter["goal"])}</p>
  <div class="tag-row">{chapter_status_badge(str(chapter["status"]))}{''.join(f'<span>{esc(c)}</span>' for c in chapter["concepts"])}</div>
</section>
<nav class="in-page-nav" aria-label="Chapter sections">
  <a href="#guide">Guide</a><a href="#calculation">Calculation Route</a>
  <a href="#details">Rigorous Details</a><a href="#lean">Lean Foundations</a>
  <a href="#source-map">Source map</a><a href="#dependencies">Dependencies</a>
</nav>
<section id="guide" class="two-column">
  <div><h2>Chapter guide</h2><h3>Prerequisites</h3>{list_html(chapter["prerequisites"])}
  <h3>Recommended order</h3>{list_html(chapter["recommended_order"])}</div>
  <div><h2>Source sections</h2>{list_html(chapter["source_sections"])}
  <h3>Core concepts</h3>{list_html(chapter["concepts"])}</div>
</section>
<section class="two-column chapter-essentials">
  <div><div class="section-heading"><span>Vocabulary</span><h2>Core definitions</h2></div>{list_html(chapter["core_definitions"])}</div>
  <div><div class="section-heading"><span>Destination</span><h2>Major results</h2></div>{list_html(chapter["major_results"])}</div>
</section>
<section id="calculation">
  <div class="section-heading"><span>Depth 01</span><h2>Calculation Route</h2></div>
  <p class="section-intro">This is the shortest faithful route through the chapter's main proof calculations.</p>
  <div class="calculation-route">{route}</div>
</section>
<section id="details">
  <div class="section-heading"><span>Depth 02</span><h2>Why these steps are valid</h2></div>
  <div class="detail-grid">{''.join(f'<article><span>{i:02d}</span><p>{esc(detail)}</p></article>' for i, detail in enumerate(chapter["rigorous_details"], 1))}</div>
  <aside class="pitfall"><strong>Strict boundary.</strong> A concise textbook calculation is not promoted to a blue Lean result until its regularity, measurability, integrability, boundary, representative, and domain contracts have compiled.</aside>
</section>
<section id="lean">
  <div class="section-heading"><span>Depth 03</span><h2>Lean Foundations</h2></div>
  <p>The links below are the nearest existing ASTIS modules. A listed module is not a claim that every result in this chapter is complete.</p>
  <div class="module-links">{''.join(module_links)}</div>
</section>
<section id="source-map">
  <div class="section-heading"><span>Correspondence</span><h2>Book → exposition → detail packet → Lean</h2></div>
  <div class="source-grid">{''.join(mappings) if mappings else '<p class="note">This chapter is present in the textbook spine; fine-grained source entries are still being added and are not represented as compiled results.</p>'}</div>
</section>
<section id="dependencies">
  <div class="section-heading"><span>Architecture</span><h2>Dependencies and consumers</h2></div>
  {graph}
  <div class="two-column">
    <div><h3>Current red blockers</h3>{list_html(chapter["blockers"])}</div>
    <div><h3>Downstream consumers</h3>{list_html(chapter["consumers"])}</div>
  </div>
</section>
"""
    return page(
        f"Chapter {chapter['number']}: {chapter['title']}",
        f"textbook/{chapter['id']}.html",
        body,
        active="Textbook",
        description=str(chapter["goal"]),
    )


def render_calculation_route(chapters: list[dict[str, object]]) -> str:
    rows = []
    for chapter in chapters:
        first = chapter["calculation_route"][0]
        rows.append(
            f"""<article class="route-row">
  <div class="chapter-index">{int(chapter["number"]):02d}</div>
  <div><h2><a href="textbook/{esc(chapter["id"])}.html#calculation">{esc(chapter["title"])}</a></h2>
  <p>{esc(chapter["goal"])}</p><div class="formula compact-formula">\\[{esc(first["formula"])}\\]</div></div>
</article>"""
        )
    body = f"""
<section class="page-hero compact"><div class="eyebrow">Depth 01</div>
<h1>Calculation Route</h1>
<p class="lede">The mathematical spine: what to calculate, in which order, and why the result matters downstream. Open Depth 02 only when you need to audit a suppressed condition.</p></section>
{diagram_block("learning-path", "Recommended progressive-disclosure reading path.")}
<section class="route-list">{''.join(rows)}</section>
"""
    return page("Calculation Route", "calculation-route.html", body)


def render_rigorous_details(chapters: list[dict[str, object]]) -> str:
    categories = {
        "Measure and representatives": [
            "Measurability and strong measurability are stated for the actual codomain.",
            "Almost-everywhere representatives are fixed before applying pointwise calculus.",
            "Normalization, absolute continuity, and zero-density conventions are explicit."
        ],
        "Integrals and limits": [
            "Every Bochner integral has a proved Integrable hypothesis.",
            "Dominating functions are independent of the limiting parameter and integrable.",
            "Tonelli, Fubini, and interchange of limits identify their exact hypotheses."
        ],
        "Calculus and support": [
            "Genuine differentiability is separated from totalized fderiv values.",
            "Support, topological support, and compact support are not interchanged.",
            "Cutoff-gradient and main-term limits are proved as independent edges."
        ],
        "Operators and stochastic laws": [
            "A formal differential expression is not a closed generator.",
            "Core symmetry is not automatically symmetry on the generator domain.",
            "Stationary densities, stationary solutions, and invariant semigroup laws remain distinct."
        ]
    }
    cards = "".join(
        f"<article><h2>{esc(title)}</h2>{list_html(items)}</article>"
        for title, items in categories.items()
    )
    chapter_details = "".join(
        f"""<details><summary>Chapter {int(ch["number"])} · {esc(ch["title"])}</summary>
{list_html(ch["rigorous_details"])}
<a href="textbook/{esc(ch["id"])}.html#details">Open chapter detail layer →</a></details>"""
        for ch in chapters
    )
    body = f"""
<section class="page-hero compact"><div class="eyebrow">Depth 02</div>
<h1>Rigorous Details</h1><p class="lede">This layer answers the question a phrase such as “by approximation” leaves open: exactly which hypotheses make the step legal?</p></section>
<section class="detail-category-grid">{cards}</section>
<section><div class="section-heading"><span>Audit by chapter</span><h2>Hidden mathematical contracts</h2></div>
<div class="details-stack">{chapter_details}</div></section>
<section class="note"><h2>No promotion by prose</h2><p>A complete explanation can document a red node, but it does not make the node blue. Blue status is reserved for an ASTIS-owned declaration resolved in the source Registry and covered by the local Lean build gate.</p></section>
"""
    return page("Rigorous Details", "rigorous-details.html", body)


def render_lean_foundations(entries: list[RegistryEntry]) -> str:
    featured_names = [
        "radialSmoothCutoff_contDiff",
        "radialSmoothCutoff_fderiv_bound",
        "radialSmoothCutoff_hasCompactSupport",
        "radialSmoothCutoff_tendsto_one",
        "hasFDerivAt_radialSmoothCutoff_comp_toLp",
        "tendsto_integral_norm_fderiv_radialSmoothCutoff_comp_toLp_apply",
        "tendsto_integral_radialSmoothCutoff_comp_toLp_smul",
        "finiteEuclidean_langevinGenerator_basisDisplay",
    ]
    featured = [entry for name in featured_names for entry in entries if entry.short_name == name]
    cards = "".join(
        f"""<article class="theorem-mini">
  {badge(status_label(entry), status_class(entry))}
  <h3><a href="theorems/{entry.slug}.html"><code>{esc(entry.short_name)}</code></a></h3>
  <p>{esc(entry.note or entry.docstring or entry.sald_use)}</p>
  <span class="file-ref">{esc(entry.source_file)}:{entry.source_line}</span>
</article>"""
        for entry in featured
    )
    body = f"""
<section class="page-hero compact"><div class="eyebrow">Depth 03</div>
<h1>Lean Foundations</h1><p class="lede">Read the formalization as mathematics with explicit interfaces—not as an undifferentiated code dump.</p></section>
<section class="two-column">
  <div><h2>How to read a card</h2>
  <ol><li>Read the plain-language role and strict non-claims.</li>
  <li>Compare the exact Lean statement with the source correspondence.</li>
  <li>Inspect typeclasses and Mathlib-facing vocabulary.</li>
  <li>Follow ASTIS dependencies down and consumers up.</li>
  <li>Confirm Registry and test/build status.</li></ol></div>
  <div class="note"><h2>What “blue” means</h2><p>The declaration is ASTIS-owned, has status <code>formalizedLocal</code> in the compiled Lean Registry, resolves to a real source declaration, and is covered by <code>lake build Tests</code>. External code and prose-only nodes never become blue.</p></div>
</section>
<section><div class="section-heading"><span>Chapter 1 packet</span><h2>Cutoff-to-generator foundations</h2></div>
<div class="theorem-grid">{cards}</div></section>
{diagram_block("cutoff-packet", "The local theorem packet from a scalar profile to the generic vector cutoff-gradient limit.")}
<section class="note"><h2>Totalized APIs</h2><p>Mathlib defines <code>fderiv</code> everywhere, returning a default value when differentiability is unavailable. Therefore, an identity involving totalized <code>fderiv</code> is not evidence of genuine differentiability. ASTIS cards explicitly record when a theorem supplies <code>HasFDerivAt</code> or <code>DifferentiableAt</code>.</p></section>
"""
    return page("Lean Foundations", "lean-foundations.html", body)


def source_status_badge(status: str) -> str:
    if status == "compiled":
        return badge("compiled mapping", "blue")
    if status == "partial":
        return badge("partial mapping", "yellow")
    return badge("red source edge", "red")


def render_source_correspondence(
    source_entries: list[dict[str, object]],
    entries_by_decl: dict[str, RegistryEntry],
) -> str:
    rows = []
    for source in source_entries:
        decl_links = []
        for decl in source["lean_declarations"]:
            entry = entries_by_decl.get(str(decl))
            if entry:
                decl_links.append(
                    f'<a href="theorems/{entry.slug}.html"><code>{esc(entry.short_name)}</code></a>'
                )
            else:
                decl_links.append(f'<span class="status status-orange">{esc(decl)} unresolved</span>')
        rows.append(
            f"""<article id="{esc(source["id"])}" class="correspondence-card" data-status="{esc(source["status"])}" data-chapter="{int(source["chapter"])}">
  <header><div><span class="eyebrow">Chapter {int(source["chapter"])} · §{esc(source["section"])} · p. {esc(source["page"])}</span>
  <h2>{esc(source["source_kind"])}</h2></div>{source_status_badge(str(source["status"]))}</header>
  <div class="correspondence-flow">
    <div><h3>Source</h3><p>{esc(source["source_summary"])}</p><span class="wording">{esc(source["wording_status"])}</span></div>
    <div><h3>ASTIS exposition</h3><p>{esc(source["astis_exposition"])}</p></div>
    <div><h3>Rigorous packet</h3><p>{esc(source["rigorous_packet"])}</p></div>
    <div><h3>Lean</h3><div class="decl-links">{''.join(decl_links) if decl_links else '<span class="muted">No owned declaration yet.</span>'}</div></div>
  </div>
  <details><summary>Assumptions and consumers</summary>
    <div class="two-column"><div><h3>Source assumptions</h3>{list_html(source["source_assumptions"])}</div>
    <div><h3>Formal assumptions</h3>{list_html(source["formal_assumptions"])}</div></div>
    <h3>Downstream consumers</h3>{list_html(source["downstream_consumers"])}
  </details>
  <a class="source-anchor" href="{esc(source["source_url"])}">Open exact book anchor ↗</a>
</article>"""
        )
    body = f"""
<section class="page-hero compact"><div class="eyebrow">Traceable reconstruction</div>
<h1>Source Correspondence</h1><p class="lede">Every entry distinguishes Chewi's source, ASTIS paraphrase, ASTIS supplemental proof obligations, and compiled Lean declarations.</p></section>
{diagram_block("source-to-lean", "One-way provenance and two-way navigation between the book and the formalization.")}
<section class="toolbar" aria-label="Source correspondence filters">
  <label>Search <input id="card-search" type="search" placeholder="generator, Girsanov, p. 24…"></label>
  <label>Status <select id="status-filter"><option value="">All</option><option value="partial">Partial</option><option value="todo">Todo</option></select></label>
</section>
<section id="filterable-cards" class="correspondence-list">{''.join(rows)}</section>
"""
    return page("Source Correspondence", "source-correspondence.html", body, active="Source map")


def render_implementation_map(entries: list[RegistryEntry]) -> str:
    rows = []
    for entry in entries:
        dependencies = len(entry.dependencies)
        consumers = len(entry.consumers)
        rows.append(
            f"""<tr data-status="{status_class(entry)}" data-search="{esc(' '.join([entry.local_decl, entry.key, entry.upstream_decl, entry.upstream_file, ' '.join(entry.tags)]).lower())}">
  <td>{badge(status_label(entry), status_class(entry))}</td>
  <td><a href="../theorems/{entry.slug}.html"><code>{esc(entry.local_decl or entry.key)}</code></a><small>{esc(entry.key)}</small></td>
  <td>{esc(entry.source_file)}{f':{entry.source_line}' if entry.source_line else ''}</td>
  <td>{dependencies}</td><td>{consumers}</td>
  <td>{''.join(f'<span class="mini-tag">{esc(tag)}</span>' for tag in entry.tags[:5])}</td>
</tr>"""
        )
    counts = Counter(status_class(entry) for entry in entries)
    body = f"""
<section class="page-hero compact"><div class="eyebrow">All Registry entries</div>
<h1>Implementation Map</h1><p class="lede">A generated map from mathematical topic and Registry record to declaration, file, dependencies, consumers, source, and gate status.</p></section>
<section class="metric-row standalone">
  <div><strong>{counts["blue"]}</strong><span>compiled ASTIS leaves</span></div>
  <div><strong>{counts["purple"]}</strong><span>port candidates</span></div>
  <div><strong>{counts["orange"]}</strong><span>typed gaps or mismatches</span></div>
  <div><strong>{counts["gray"]}</strong><span>external references</span></div>
</section>
<section class="toolbar table-toolbar">
  <label>Search <input id="implementation-search" type="search" placeholder="declaration, tag, Mathlib source…"></label>
  <label>Status <select id="implementation-status"><option value="">All</option><option value="blue">Blue</option><option value="purple">Purple</option><option value="orange">Orange</option><option value="gray">Gray</option></select></label>
</section>
<div class="table-wrap"><table id="implementation-table">
<thead><tr><th>Status</th><th>Declaration / Registry key</th><th>Lean file</th><th>Deps</th><th>Consumers</th><th>Tags</th></tr></thead>
<tbody>{''.join(rows)}</tbody></table></div>
"""
    return page("Implementation Map", "implementation-map/index.html", body, active="Implementation")


def inferred_natural_statement(entry: RegistryEntry) -> str:
    if entry.docstring:
        return re.sub(r"\s+", " ", entry.docstring).strip()
    if entry.note:
        return entry.note
    return entry.sald_use or "No separate natural-language statement is recorded."


def lean_vocabulary(entry: RegistryEntry) -> list[str]:
    vocabulary = {
        "Integrable": "Bochner integrability: strong measurability plus finite integral norm",
        "IntegrableOn": "integrability restricted to a measurable-set interface",
        "Tendsto": "filter-level convergence with an explicit source and target filter",
        "HasFDerivAt": "a genuine Fréchet derivative at the stated point",
        "DifferentiableAt": "genuine differentiability, stronger than inspecting totalized fderiv",
        "fderiv": "Mathlib's totalized Fréchet-derivative value",
        "ContinuousLinearMap": "a bounded linear map carrying the derivative",
        "EuclideanSpace": "Mathlib's PiLp-wrapped finite Euclidean space",
        "WithLp": "the wrapper controlling the Lp norm instance",
        "Measure": "an explicit measure parameter or instance",
        "volume": "Lebesgue/Haar volume in the ambient finite-dimensional space",
        "ae": "an almost-everywhere proposition relative to a measure",
        "ENNReal": "extended nonnegative real values used by lintegrals",
        "HasCompactSupport": "compactness of the topological support",
        "Function.support": "the pointwise nonzero set, before topological closure",
        "ContinuousOn": "continuity restricted to a set",
        "ContDiff": "iterated Fréchet differentiability to the stated order",
    }
    return [
        f"{token}: {meaning}"
        for token, meaning in vocabulary.items()
        if token in entry.source_text
    ]


def proof_walkthrough(entry: RegistryEntry) -> list[str]:
    source = entry.source_text
    steps = [
        "Read the quantified variables and typeclass brackets as part of the mathematical statement; inferred arguments are not missing assumptions."
    ]
    tactic_meanings = [
        ("intro", "introduces quantified hypotheses into the local proof context"),
        ("have", "creates a named intermediate mathematical fact"),
        ("calc", "records an equality or inequality chain matching a paper calculation"),
        ("rw", "rewrites by an established identity"),
        ("simp", "normalizes through registered definitional and theorem rewrites"),
        ("apply", "reduces the goal to the hypotheses of a reusable theorem"),
        ("refine", "instantiates a reusable theorem while leaving explicit subgoals"),
        ("exact", "closes the current goal with an already typed term"),
        ("simpa", "closes the goal after a controlled simplification of a typed result"),
        ("filter_upwards", "moves an almost-everywhere or eventual statement into a pointwise local context"),
        ("tendsto", "uses a filter-convergence combinator rather than an informal limit"),
    ]
    found = []
    for token, meaning in tactic_meanings:
        if re.search(rf"(?<![A-Za-z0-9_']){re.escape(token)}(?![A-Za-z0-9_'])", source):
            found.append(f"`{token}` {meaning}.")
    steps.extend(found[:7])
    if len(steps) == 1:
        steps.append("The declaration is definition-like or term-style; its typed right-hand side is the proof object.")
    return steps


def hidden_contracts(entry: RegistryEntry) -> list[str]:
    text = " ".join([entry.note, entry.sald_use, " ".join(entry.tags), entry.source_text]).lower()
    contracts = []
    candidates = [
        ("measur", "Measurability is represented explicitly or must be supplied by a dependency."),
        ("integrab", "Integrability is an input or proved output; a displayed integral alone does not supply it."),
        ("fderiv", "Totalized `fderiv` values must not be read as a differentiability theorem."),
        ("differentiab", "Genuine differentiability is localized to the hypotheses shown in the Lean statement."),
        ("support", "Pointwise support, topological support, and compact support retain distinct meanings."),
        ("ae", "Almost-everywhere hypotheses depend on the stated measure and representative."),
        ("density", "Density statements retain normalization and absolute-continuity prerequisites."),
        ("gibbs", "A Gibbs expression is not automatically a probability law or an invariant law."),
        ("generator", "A formal generator display does not establish a closed operator domain."),
        ("cutoff", "A cutoff lemma does not by itself prove a whole-space integration-by-parts identity."),
        ("girsanov", "A finite cylinder identity is not automatically a path-space change-of-measure theorem."),
    ]
    for needle, statement in candidates:
        if needle in text and statement not in contracts:
            contracts.append(statement)
    return contracts[:7] or ["No additional hidden-contract keyword was inferred; the exact Lean hypotheses remain controlling."]


def theorem_card(
    entry: RegistryEntry,
    entries_by_decl: dict[str, RegistryEntry],
    source_links: list[dict[str, object]],
) -> str:
    deps = [
        f'<a href="{entries_by_decl[dep].slug}.html"><code>{esc(entries_by_decl[dep].short_name)}</code></a>'
        for dep in entry.dependencies if dep in entries_by_decl
    ]
    consumers = [
        f'<a href="{entries_by_decl[item].slug}.html"><code>{esc(entries_by_decl[item].short_name)}</code></a>'
        for item in entry.consumers if item in entries_by_decl
    ]
    source_url = f"{GITHUB_ROOT}/{entry.source_file}#L{entry.source_line}" if entry.source_file else ""
    mathlib_items = [entry.upstream_decl, entry.upstream_file]
    strict_note = (
        "This card records a compiled local declaration. Its mathematical scope is exactly the Lean statement below; "
        "the Registry note and source correspondence may describe motivation but do not strengthen it."
        if entry.is_blue else
        "This Registry record is not blue. It is an external candidate, reference, typed gap, or unresolved source mapping."
    )
    statement = entry.source_text or "-- No ASTIS-owned declaration source resolved."
    source_correspondence = [
        f'<a href="../source-correspondence.html#{esc(item["id"])}">'
        f'Chapter {int(item["chapter"])} §{esc(item["section"])} · {esc(item["source_kind"])}</a>'
        for item in source_links
    ]
    body = f"""
<section class="page-hero compact theorem-hero">
  <div class="eyebrow">Theorem card · {esc(entry.key)}</div>
  <h1><code>{esc(entry.short_name)}</code></h1>
  <div>{badge(status_label(entry), status_class(entry))} {'<span class="status status-green">explicit smoke test</span>' if entry.explicit_test else '<span class="status status-gray">covered by Tests build</span>'}</div>
  <p class="lede">{esc(inferred_natural_statement(entry))}</p>
</section>
<section class="theorem-layout">
  <article>
    <h2>Plain-English statement and role</h2>
    <p>{esc(inferred_natural_statement(entry))}</p>
    <div class="note"><strong>Scope guard.</strong> {esc(strict_note)}</div>
    <h2>Lean statement</h2>
    {code_html(statement)}
    {f'<p><a href="{esc(source_url)}">Open source at {esc(entry.source_file)}:{entry.source_line} ↗</a></p>' if source_url else ''}
    <h2>Proof architecture</h2>
    <p>{esc(entry.sald_use or "The declaration is a reusable technical leaf recorded by the ASTIS registry.")}</p>
    <h3>Lean proof walkthrough</h3>{list_html(proof_walkthrough(entry))}
    <h3>Why the statement has this shape</h3>
    <p>The declaration is kept at the reusable level recorded by its Registry tags and direct consumers. Explicit measures, spaces, wrappers, and regularity hypotheses expose interfaces that paper notation often infers. A theorem card explains those interfaces but never widens the compiled statement.</p>
    <h3>Hidden assumptions and non-claims</h3>{list_html(hidden_contracts(entry))}
  </article>
  <aside class="theorem-sidebar">
    <section><h2>Status</h2>
      <dl><dt>Registry</dt><dd><code>{esc(entry.status)}</code></dd>
      <dt>Source resolved</dt><dd>{'yes' if entry.source_file else 'no'}</dd>
      <dt>Compiled gate</dt><dd>{'lake build Tests' if entry.is_blue else 'not blue'}</dd>
      <dt>Explicit test</dt><dd>{'yes' if entry.explicit_test else 'module/build coverage'}</dd></dl>
    </section>
    <section><h2>Location</h2><dl><dt>Namespace</dt><dd><code>{esc(entry.namespace)}</code></dd>
      <dt>File</dt><dd><code>{esc(entry.source_file or "unresolved")}</code></dd>
      <dt>Line</dt><dd>{entry.source_line or "—"}</dd></dl></section>
    <section><h2>ASTIS dependencies</h2><div class="decl-links">{''.join(deps) if deps else '<span class="muted">No dependency found by the conservative source scanner.</span>'}</div></section>
    <section><h2>Consumers</h2><div class="decl-links">{''.join(consumers) if consumers else '<span class="muted">No Registry consumer found by the conservative source scanner.</span>'}</div></section>
    <section><h2>Mathlib / external correspondence</h2>{list_html([item for item in mathlib_items if item])}</section>
    <section><h2>Lean vocabulary and typeclasses</h2>{list_html(lean_vocabulary(entry), empty="No highlighted vocabulary token was inferred; inspect the exact statement.")}</section>
    <section><h2>Source correspondence</h2><div class="decl-links">{''.join(source_correspondence) if source_correspondence else '<span class="muted">No fine-grained Chewi anchor mapped yet.</span>'}</div></section>
    <section><h2>Tags</h2><div class="tag-row">{''.join(f'<span>{esc(tag)}</span>' for tag in entry.tags)}</div></section>
  </aside>
</section>
<section class="pitfall"><strong>Common pitfall.</strong> A wrapper or display identity is not a new analytic theorem merely because it has its own Lean name. Check the statement, hypotheses, and downstream consumers before interpreting its mathematical contribution.</section>
"""
    return page(entry.short_name, f"theorems/{entry.slug}.html", body)


def module_card(module: str, rel_file: str, module_entries: list[RegistryEntry]) -> str:
    rows = "".join(
        f"""<li>{badge(status_label(entry), status_class(entry))}
<a href="../theorems/{entry.slug}.html"><code>{esc(entry.short_name)}</code></a>
<span>{esc(entry.note)}</span></li>"""
        for entry in module_entries
    )
    gh_url = f"{GITHUB_ROOT}/{rel_file}"
    body = f"""
<section class="page-hero compact"><div class="eyebrow">Module card</div>
<h1><code>{esc(module)}</code></h1><p class="lede">{len(module_entries)} Registry declarations resolve to this Lean module.</p></section>
<section class="two-column"><div><h2>Source</h2><p><code>{esc(rel_file)}</code></p><p><a href="{esc(gh_url)}">Open module on GitHub ↗</a></p></div>
<div><h2>Status contract</h2><p>Individual declaration status is generated from the Registry and source resolution. Module presence alone does not make every planned chapter result blue.</p></div></section>
<section><h2>Declarations</h2><ul class="module-entry-list">{rows or '<li>No Registry declaration resolves to this module yet.</li>'}</ul></section>
"""
    return page(module, f"modules/{slugify(module)}.html", body)


def render_dependency_explorer(entries: list[RegistryEntry]) -> str:
    reusable = sorted(
        [entry for entry in entries if entry.is_blue],
        key=lambda item: (len(item.consumers), len(item.dependencies)),
        reverse=True,
    )[:18]
    rows = "".join(
        f"<tr><td><a href=\"theorems/{entry.slug}.html\"><code>{esc(entry.short_name)}</code></a></td><td>{len(entry.dependencies)}</td><td>{len(entry.consumers)}</td><td>{esc(', '.join(entry.tags[:4]))}</td></tr>"
        for entry in reusable
    )
    body = f"""
<section class="page-hero compact"><div class="eyebrow">Book and theorem DAGs</div>
<h1>Dependency Explorer</h1><p class="lede">Large graphs are split by function: chapter spine, shared roots, Chapter 1, current frontier, and local theorem packets.</p></section>
<section><h2>Book spine</h2>{diagram_block("chapter-spine", "Chapter-level learning dependencies.")}</section>
<section><h2>Shared-root DAG</h2>{diagram_block("shared-root-dag", "Reusable roots are displayed once and tagged by mathematical role.")}</section>
<section><h2>Chapter 1</h2>{diagram_block("chapter-01-dag", "Cutoff, integrability, weighted IBP, domains, and invariance remain separate nodes.")}</section>
<section><h2>Current frontier</h2>{diagram_block("current-frontier", "The current statement-audit boundary after Cycle 28.")}</section>
<section><h2>Cutoff theorem packet</h2>{diagram_block("cutoff-packet", "A local theorem-level DAG.")}</section>
<section><div class="section-heading"><span>Generated dependency signal</span><h2>Most reused Registry leaves</h2></div>
<p class="muted">Consumers are conservatively inferred from direct declaration-name references in ASTIS source. Namespace-qualified tactic indirection may make the count an under-approximation.</p>
<div class="table-wrap"><table><thead><tr><th>Declaration</th><th>Direct dependencies</th><th>Direct consumers</th><th>Tags</th></tr></thead><tbody>{rows}</tbody></table></div></section>
"""
    return page("Dependency Explorer", "dependency-explorer.html", body, active="Dependencies")


def render_progress(
    chapters: list[dict[str, object]],
    entries: list[RegistryEntry],
    source_entries: list[dict[str, object]],
) -> str:
    counts = Counter(status_class(entry) for entry in entries)
    source_counts = Counter(str(item["status"]) for item in source_entries)
    chapter_rows = "".join(
        f"""<tr><td>{int(ch["number"]):02d}</td><td><a href="textbook/{esc(ch["id"])}.html">{esc(ch["title"])}</a></td>
<td>{chapter_status_badge(str(ch["status"]))}</td><td>{len(ch["calculation_route"])}</td><td>{len(chapter_source_entries(int(ch["number"]), source_entries))}</td><td>{len(ch["blockers"])}</td></tr>"""
        for ch in chapters
    )
    total = len(entries)
    blue_pct = (100 * counts["blue"] / total) if total else 0
    body = f"""
<section class="page-hero compact"><div class="eyebrow">Generated status</div>
<h1>Progress</h1><p class="lede">Registry, source resolution, chapter metadata, and source correspondence are counted independently so documentation cannot masquerade as proof.</p></section>
<section class="metric-row standalone">
  <div><strong>{counts["blue"]}</strong><span>compiled local leaves</span></div>
  <div><strong>{total - counts["blue"]}</strong><span>non-blue Registry records</span></div>
  <div><strong>{len(source_entries)}</strong><span>source anchors</span></div>
  <div><strong>{len(chapters)}</strong><span>chapters</span></div>
</section>
<section class="progress-panel">
  <div><span>Registry entries resolved as compiled ASTIS declarations</span><strong>{blue_pct:.1f}%</strong></div>
  <div class="progress-track"><span style="width:{blue_pct:.2f}%"></span></div>
  <p>This percentage describes the technical-memory Registry, not completion of Chewi's entire book.</p>
</section>
{diagram_block("progress-pipeline", "Status is generated from shared repository truth; HTML is never the status authority.")}
<section><h2>Chapter coverage</h2><div class="table-wrap"><table>
<thead><tr><th>Ch.</th><th>Chapter</th><th>Formalization status</th><th>Calculation steps</th><th>Source entries</th><th>Red blockers</th></tr></thead>
<tbody>{chapter_rows}</tbody></table></div></section>
<section class="two-column"><div><h2>Registry status</h2>
{list_html([f"Blue compiled: {counts['blue']}", f"Purple port candidates: {counts['purple']}", f"Orange typed gaps/mismatches: {counts['orange']}", f"Gray references: {counts['gray']}"])}
</div><div><h2>Source mapping status</h2>
{list_html([f"Partial: {source_counts['partial']}", f"Todo: {source_counts['todo']}", f"Compiled mappings: {source_counts['compiled']}"])}
</div></section>
"""
    return page("Progress", "progress.html", body, active="Progress")


def render_frontier(entries_by_short: dict[str, RegistryEntry]) -> str:
    cycles = [
        ("25", "253", "Radial cutoff smoothness, support, compact support, exhaustion, all-scale derivative bound, PiLp bridge, and basis-trace identity.", "historical baseline"),
        ("26", "254", "Generic L1 norm limit for the PiLp-wrapped cutoff gradient.", "compiled"),
        ("27", "255", "Source-field integrability handoff needed by the cutoff-gradient term.", "compiled"),
        ("28", "256", "Generic vector cutoff-gradient integral tends to zero.", "compiled"),
    ]
    rows = "".join(
        f"<tr><td>{cycle}</td><td>{count}</td><td>{esc(result)}</td><td>{badge(label, 'blue' if label == 'compiled' else 'gray')}</td></tr>"
        for cycle, count, result, label in cycles
    )
    blue_names = [
        "tendsto_integral_norm_fderiv_radialSmoothCutoff_comp_toLp_apply",
        "tendsto_integral_radialSmoothCutoff_comp_toLp_smul",
        "integrable_expNeg_fderivCoordinateField_of_lintegral_expNeg_ne_top_of_fderiv_norm_le",
    ]
    links = []
    for name in blue_names:
        entry = entries_by_short.get(name)
        if entry:
            links.append(f'<a href="theorems/{entry.slug}.html"><code>{esc(name)}</code></a>')
    body = f"""
<section class="page-hero compact"><div class="eyebrow">Strict mathematical boundary</div>
<h1>Roadmap and Current Frontier</h1><p class="lede">The site preserves both the user-supplied Cycle 26 historical snapshot and the later compiled worktree truth. It does not roll the repository back.</p></section>
{diagram_block("current-frontier", "Blue nodes compiled in Cycles 26–28; red nodes remain mathematically distinct.")}
<section><h2>Cycle ledger</h2><div class="table-wrap"><table><thead><tr><th>Cycle</th><th>Registry count</th><th>Closed edge</th><th>Status</th></tr></thead><tbody>{rows}</tbody></table></div></section>
<section class="two-column">
  <div><h2>Blue cutoff-limit leaves</h2><div class="decl-links">{''.join(links)}</div>
  <p>The website task does not alter these declarations or their proofs.</p></div>
  <div><h2>Current first red route</h2><p><strong>Concrete generator-display integrability</strong>, with weighted-score integrability isolated as a genuine missing input during the Cycle 29 statement audit.</p></div>
</section>
<section><div class="section-heading"><span>Do not merge</span><h2>Independent red nodes</h2></div>
<div class="red-node-grid">
  <article><h3>Generator-display integrability</h3><p>Connect the generic field-level packet to the actual weighted Langevin source.</p></article>
  <article><h3>Gibbs tail</h3><p>Supply the tail/normalization estimate actually consumed downstream.</p></article>
  <article><h3>Whole-space weighted IBP</h3><p>Combine finite-box cancellation and both justified limit passages.</p></article>
  <article><h3>Generator / semigroup domains</h3><p>Upgrade formal differential identities to closed-operator statements.</p></article>
  <article><h3>Invariant Gibbs law</h3><p>Connect the domain-level generator statement to the Markov semigroup.</p></article>
</div></section>
<aside class="pitfall"><strong>Deferred branch.</strong> Hessian/Laplacian \\(O(R^{{-2}})\\) is not a prerequisite for the current first-order route. It is implemented only when a concrete second-order consumer appears.</aside>
"""
    return page("Current Frontier", "frontier.html", body, active="Frontier")


def render_learn_lean(entries_by_short: dict[str, RegistryEntry]) -> str:
    examples = {
        "fderiv": "radialSmoothCutoff_fderiv_bound",
        "PiLp": "hasFDerivAt_radialSmoothCutoff_comp_toLp",
        "Integrable": "integrable_expNeg_fderivCoordinateField_of_lintegral_expNeg_ne_top_of_fderiv_norm_le",
        "Tendsto": "tendsto_integral_radialSmoothCutoff_comp_toLp_smul",
    }
    links = {
        label: (
            f'<a href="theorems/{entry.slug}.html"><code>{esc(entry.short_name)}</code></a>'
            if (entry := entries_by_short.get(name)) else "<span>entry unavailable</span>"
        )
        for label, name in examples.items()
    }
    lessons = [
        ("Implicit arguments", "Lean infers dimensions, scalar fields, measures, and instances when curly braces mark parameters as implicit. Hover mentally over every inferred object: it is still part of the theorem contract."),
        ("Namespaces", "A short theorem name is resolved inside nested namespaces. The theorem card always displays the fully qualified declaration to eliminate ambiguity."),
        ("Typeclasses", "Finite-dimensional Euclidean structure, normed spaces, measurability, and measure instances are supplied through typeclasses. These are mathematical structure, not compiler decoration."),
        ("Filters and Tendsto", "A limit theorem states a filter-level relation. In cutoff arguments, the radius tends to infinity through `atTop`; the conclusion may live in a normed vector space."),
        ("Integrable", "Mathlib's Bochner `Integrable` combines strong measurability with finite integral norm. It is stronger than the informal statement that an integral symbol looks finite."),
        ("fderiv", "The Fréchet derivative API is totalized. Use `HasFDerivAt` or `DifferentiableAt` for genuine differentiability; never infer it from a convenient value of `fderiv`."),
        ("PiLp", "`EuclideanSpace ℝ ι` is a `WithLp` wrapper around functions. Bridges between wrapped and unwrapped representations are explicit because norms and continuous linear maps see the wrapper."),
        ("Almost everywhere", "Measure-theoretic equalities are usually `=ᵐ[μ]`. Choosing a pointwise representative requires a separate argument."),
        ("Support", "`Function.support f` is the nonzero set, while topological support is its closure. Compact support is a property of the topological support."),
        ("Dominated convergence", "Pointwise convergence is only one input. The family must be measurable, and one integrable function must dominate every member almost everywhere."),
        ("Generator domains", "A formula for `Lf` on smooth functions is not yet a statement about the infinitesimal generator of a strongly continuous semigroup.")
    ]
    cards = "".join(f"<article><h2>{esc(title)}</h2><p>{esc(text)}</p></article>" for title, text in lessons)
    body = f"""
<section class="page-hero compact"><div class="eyebrow">Sampling-first Lean guide</div>
<h1>Learn Lean Through Sampling</h1><p class="lede">Every concept below is motivated by the real ASTIS cutoff, Gibbs, generator, divergence, or convergence route.</p></section>
<section class="lesson-grid">{cards}</section>
<section><h2>Open real examples</h2><div class="example-links">
<div><strong>Fréchet derivative</strong>{links["fderiv"]}</div>
<div><strong>PiLp bridge</strong>{links["PiLp"]}</div>
<div><strong>Bochner integrability</strong>{links["Integrable"]}</div>
<div><strong>Filter limit</strong>{links["Tendsto"]}</div>
</div></section>
{diagram_block("learning-path", "Start with the proof calculation; descend into Lean only as far as the question requires.")}
"""
    return page("Learn Lean Through Sampling", "learn-lean.html", body, active="Learn Lean")


def render_attribution() -> str:
    body = f"""
<section class="page-hero compact"><div class="eyebrow">Sources and rights</div>
<h1>Attribution and Licensing</h1><p class="lede">ASTIS distinguishes source authorship, ASTIS exposition, and ASTIS-owned Lean formalization on every correspondence page.</p></section>
<section class="attribution-grid">
  <article><h2>Sinho Chewi</h2>
  <p>ASTIS is reconstructing Sinho Chewi's <a href="{CHEWI_URL}"><em>Log-Concave Sampling</em></a>. The book is the organizing mathematical source.</p>
  <p>The public draft and author page expose no explicit license permitting wholesale republication. The site therefore uses original faithful paraphrase, precise chapter/section/page correspondence, supplemental derivations, and only necessary short quotations.</p>
  <p>Chewi does not participate in, endorse, or maintain ASTIS.</p></article>
  <article><h2>Sho Sonoda</h2>
  <p>The Blueprint-style organization and implementation-map idea are inspired by Sho Sonoda's <a href="https://github.com/shosonoda/lean-ridgelet">Lean-Ridgelet repository</a> and <a href="https://shosonoda.github.io/lean-ridgelet/blueprint/html-multi/overview/#Lean-Ridgelet-Blueprint--L2-theory___-arXiv___2106___04770v2-implementation-map">Blueprint site</a>.</p>
  <p>Lean-Ridgelet is Apache-2.0. ASTIS copied no Lean-Ridgelet code, template, or styling; it uses an independently implemented static generator.</p>
  <p>Sho Sonoda does not participate in, endorse, or maintain ASTIS.</p></article>
  <article><h2>Lean and Mathlib</h2>
  <p>Formal proofs use <a href="https://lean-lang.org/">Lean</a> and <a href="https://mathlib.org/">Mathlib</a>. The theorem cards identify Mathlib-facing source declarations when the ASTIS Registry records them.</p>
  <p>Mathlib declarations remain external until an ASTIS-owned declaration compiles locally; external availability alone never earns blue status.</p></article>
  <article><h2>Other papers and repositories</h2>
  <p>External papers, textbooks, and repositories are provenance and porting sources. Their licenses remain controlling for copied material. ASTIS Registry notes and source correspondence record actual use.</p>
  <p>No external candidate is represented as an ASTIS proof until it is owned by this repository and builds under the current toolchain.</p></article>
</section>
<section class="note"><h2>Wording labels</h2>{list_html(["licensed original: text may be reproduced under a verified license", "short quotation: a minimal attributed excerpt", "faithful paraphrase: original ASTIS wording that tracks the source", "ASTIS supplement: proof detail or derivation added by ASTIS", "Lean formalization: the exact compiled declaration"])}
</section>
"""
    return page("Attribution and Licensing", "attribution.html", body)


def render_maintenance(count: int) -> str:
    body = f"""
<section class="page-hero compact"><div class="eyebrow">Contributor guide</div>
<h1>Build and Maintain the Site</h1><p class="lede">The site is a generated view of the repository—not a second proof database.</p></section>
<section class="two-column">
  <div><h2>Build</h2>{code_html("python tools/astis.py site-build\npython tools/astis.py site-check", "shell")}
  <p>On Windows, use <code>py -3</code> instead of <code>python</code> if that is how Python is installed. The generator uses only the Python standard library.</p></div>
  <div><h2>Preview</h2>{code_html("python -m http.server 8000 --directory _site", "shell")}
  <p>This command is for a developer-run foreground preview. The ASTIS harness never launches it detached or in the background.</p></div>
</section>
<section><h2>Add or update content</h2>
<ol><li>Add a compiled theorem through the normal Lean workflow, then add exactly one Registry entry. The theorem card is generated automatically.</li>
<li>Add or edit a source anchor in <code>website/content/source_correspondence.json</code>. Use a precise page/section/theorem/equation reference and an honest wording label.</li>
<li>Edit chapter exposition in <code>website/content/chapters.json</code>.</li>
<li>Edit maintainable diagrams in <code>website/diagrams/*.mmd</code>; do not hand-maintain generated HTML status.</li>
<li>Run the Lean gates, <code>site-build</code>, and <code>site-check</code>.</li></ol></section>
<section><h2>Consistency checks</h2>{list_html([
  f"Registry formalizedLocal count equals the Tests baseline ({count} at this build).",
  "Every blue declaration resolves to a real Lean source declaration.",
  "Every internal link and generated declaration card exists.",
  "Every chapter module link resolves to a real module card.",
  "No absolute Windows path appears in generated output.",
  "The required theme, formula-rendering, code, graph, and attribution hooks are present.",
  "Todo source edges cannot be rendered as compiled mappings."
])}</section>
<section><h2>Deployment</h2><p><code>.github/workflows/blueprint-site.yml</code> builds, validates, and deploys the static artifact to GitHub Pages when Pages is enabled for the repository. The workflow never edits theorem status. A separate Sites deployment may be used for a reviewable production preview; its opaque project ID is stored only in <code>.openai/hosting.json</code>.</p></section>
"""
    return page("Build and Maintenance", "maintenance.html", body)


def copy_assets(output: Path) -> None:
    assets = output / "assets"
    assets.mkdir(parents=True, exist_ok=True)
    for path in STATIC.iterdir():
        if path.is_file():
            shutil.copy2(path, assets / path.name)
    for name in (
        "log_concave_sampling_foundation.svg",
        "log_concave_sampling_foundation.png",
        "log_concave_sampling_status.svg",
        "log_concave_sampling_status.png",
        "astis_lean_arsenal_module_graph.svg",
        "astis_lean_arsenal_module_graph.png",
        "sampling_sde_leaf_network.svg",
        "sampling_sde_leaf_network.png",
    ):
        source = ROOT / "docs" / "assets" / name
        if source.exists():
            shutil.copy2(source, assets / name)
    for path in DIAGRAMS.glob("*.mmd"):
        shutil.copy2(path, assets / path.name)


def build_site(output: Path = DEFAULT_OUTPUT) -> dict[str, object]:
    chapters = load_json(CONTENT / "chapters.json")
    source_entries = load_json(CONTENT / "source_correspondence.json")
    assert isinstance(chapters, list)
    assert isinstance(source_entries, list)
    entries, module_files = enrich_entries(parse_registry())
    entries_by_decl = {entry.local_decl: entry for entry in entries if entry.local_decl}
    entries_by_short = {entry.short_name: entry for entry in entries if entry.local_decl}

    if output.exists():
        shutil.rmtree(output)
    output.mkdir(parents=True)
    copy_assets(output)

    write_page(output, "index.html", render_home(chapters, entries))
    write_page(output, "textbook/index.html", render_textbook_index(chapters))
    for chapter in chapters:
        write_page(
            output,
            f"textbook/{chapter['id']}.html",
            render_chapter(chapter, source_entries, entries_by_decl),
        )
    write_page(output, "calculation-route.html", render_calculation_route(chapters))
    write_page(output, "rigorous-details.html", render_rigorous_details(chapters))
    write_page(output, "lean-foundations.html", render_lean_foundations(entries))
    write_page(
        output,
        "source-correspondence.html",
        render_source_correspondence(source_entries, entries_by_decl),
    )
    write_page(
        output,
        "implementation-map/index.html",
        render_implementation_map(entries),
    )
    write_page(output, "dependency-explorer.html", render_dependency_explorer(entries))
    write_page(output, "progress.html", render_progress(chapters, entries, source_entries))
    write_page(output, "frontier.html", render_frontier(entries_by_short))
    write_page(output, "learn-lean.html", render_learn_lean(entries_by_short))
    write_page(output, "attribution.html", render_attribution())
    write_page(output, "maintenance.html", render_maintenance(sum(entry.is_blue for entry in entries)))

    source_by_decl: dict[str, list[dict[str, object]]] = defaultdict(list)
    for source in source_entries:
        for declaration in source["lean_declarations"]:
            source_by_decl[str(declaration)].append(source)
    for entry in entries:
        write_page(
            output,
            f"theorems/{entry.slug}.html",
            theorem_card(entry, entries_by_decl, source_by_decl.get(entry.local_decl, [])),
        )

    entries_by_module: dict[str, list[RegistryEntry]] = defaultdict(list)
    for entry in entries:
        if entry.source_file:
            module = ".".join(Path(entry.source_file).with_suffix("").parts)
            entries_by_module[module].append(entry)
    requested_modules = {
        str(module)
        for chapter in chapters
        for module in chapter["lean_modules"]
    }
    all_modules = sorted(set(entries_by_module) | requested_modules)
    for module in all_modules:
        rel_file = module_files.get(module, "/".join(module.split(".")) + ".lean")
        write_page(
            output,
            f"modules/{slugify(module)}.html",
            module_card(module, rel_file, sorted(entries_by_module[module], key=lambda item: item.short_name)),
        )

    site_data = {
        "project": "Auto-Sampling-Theory-In-Sleep",
        "short_name": "ASTIS",
        "source_book": {
            "author": "Sinho Chewi",
            "title": "Log-Concave Sampling",
            "url": CHEWI_URL,
            "wording_policy": "faithful paraphrase unless a verified license permits more",
        },
        "registry": {
            "total_entries": len(entries),
            "compiled_local_leaves": sum(entry.is_blue for entry in entries),
            "tests_baseline": test_registry_count(),
        },
        "chapters": chapters,
        "source_correspondence": source_entries,
        "declarations": [
            {
                "key": entry.key,
                "local_decl": entry.local_decl,
                "status": entry.status,
                "display_status": status_class(entry),
                "source_file": entry.source_file,
                "source_line": entry.source_line,
                "dependencies": entry.dependencies,
                "consumers": entry.consumers,
                "tags": entry.tags,
                "explicit_test": entry.explicit_test,
                "card": f"theorems/{entry.slug}.html",
            }
            for entry in entries
        ],
    }
    data_dir = output / "data"
    data_dir.mkdir()
    (data_dir / "site-data.json").write_text(
        json.dumps(site_data, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
        newline="\n",
    )
    (output / ".nojekyll").write_text("", encoding="utf-8")
    return site_data


def iter_local_links(html_path: Path, output: Path) -> Iterable[tuple[str, Path, str]]:
    text = html_path.read_text(encoding="utf-8")
    for attr, value in re.findall(r"\b(href|src)=[\"']([^\"']+)[\"']", text):
        if value.startswith(("mailto:", "javascript:", "data:")):
            continue
        parsed = urlparse(value)
        if parsed.scheme or parsed.netloc:
            continue
        clean = value.split("#", 1)[0].split("?", 1)[0]
        target = (html_path.parent / clean).resolve() if clean else html_path.resolve()
        yield value, target, parsed.fragment


def validate_site(output: Path = DEFAULT_OUTPUT) -> list[str]:
    errors: list[str] = []
    required = [
        "index.html",
        "textbook/index.html",
        "textbook/chapter-01.html",
        "calculation-route.html",
        "rigorous-details.html",
        "lean-foundations.html",
        "source-correspondence.html",
        "implementation-map/index.html",
        "dependency-explorer.html",
        "progress.html",
        "frontier.html",
        "learn-lean.html",
        "attribution.html",
        "maintenance.html",
        "data/site-data.json",
        "assets/styles.css",
        "assets/app.js",
        "assets/astis-blueprint-og.png",
    ]
    for rel in required:
        if not (output / rel).exists():
            errors.append(f"missing required output: {rel}")

    if errors:
        return errors
    site_data = json.loads((output / "data" / "site-data.json").read_text(encoding="utf-8"))
    compiled = int(site_data["registry"]["compiled_local_leaves"])
    baseline = site_data["registry"]["tests_baseline"]
    if baseline is not None and compiled != int(baseline):
        errors.append(f"compiled Registry count {compiled} != Tests baseline {baseline}")
    if len(site_data["chapters"]) != 12:
        errors.append(f"expected 12 chapters, found {len(site_data['chapters'])}")
    for chapter in site_data["chapters"]:
        for field in (
            "prerequisites",
            "concepts",
            "core_definitions",
            "major_results",
            "calculation_route",
            "rigorous_details",
            "blockers",
            "consumers",
        ):
            if not chapter.get(field):
                errors.append(f"{chapter.get('id', 'chapter')} has empty required field: {field}")

    entries, module_files = enrich_entries(parse_registry())
    for entry in entries:
        if entry.status == "formalizedLocal" and not entry.source_file:
            errors.append(f"formalizedLocal declaration does not resolve: {entry.local_decl}")
        if entry.is_blue and not (output / "theorems" / f"{entry.slug}.html").exists():
            errors.append(f"blue declaration has no theorem card: {entry.local_decl}")

    source_ids: set[str] = set()
    for source in site_data["source_correspondence"]:
        if source["id"] in source_ids:
            errors.append(f"duplicate source correspondence id: {source['id']}")
        source_ids.add(source["id"])
        if source["wording_status"] not in {
            "licensed original", "short quotation", "faithful paraphrase"
        }:
            errors.append(f"invalid wording status for {source['id']}: {source['wording_status']}")
        if not re.fullmatch(r"book \d+(?:–\d+)? / PDF \d+(?:–\d+)?", source["page"]):
            errors.append(f"inconsistent book/PDF page format for {source['id']}: {source['page']}")
        if source["status"] == "todo" and not source["lean_declarations"]:
            pass
        for decl in source["lean_declarations"]:
            if decl not in {entry.local_decl for entry in entries}:
                errors.append(f"source mapping references unknown Registry declaration: {decl}")

    requested_modules = {
        str(module)
        for chapter in site_data["chapters"]
        for module in chapter["lean_modules"]
    }
    for module in requested_modules:
        if module not in module_files:
            errors.append(f"chapter references missing Lean module: {module}")

    for html_path in output.rglob("*.html"):
        for value, target, fragment in iter_local_links(html_path, output):
            try:
                target.relative_to(output.resolve())
            except ValueError:
                errors.append(f"link escapes output root: {html_path.relative_to(output)} -> {value}")
                continue
            if not target.exists():
                errors.append(f"broken local link: {html_path.relative_to(output)} -> {value}")
                continue
            if fragment and target.suffix.lower() == ".html":
                target_text = target.read_text(encoding="utf-8", errors="ignore")
                if not re.search(
                    rf"\bid=[\"']{re.escape(fragment)}[\"']",
                    target_text,
                ):
                    errors.append(
                        f"broken local anchor: {html_path.relative_to(output)} -> {value}"
                    )
    generated_text = "\n".join(
        path.read_text(encoding="utf-8", errors="ignore")
        for path in output.rglob("*")
        if path.is_file() and path.suffix.lower() in {".html", ".json", ".css", ".js", ".mmd"}
    )
    if re.search(r"[A-Za-z]:\\", generated_text):
        errors.append("absolute Windows path leaked into generated website")
    for token in ('value="blueprint"', 'value="modern"', 'value="bold"'):
        if token not in generated_text:
            errors.append(f"missing theme option: {token}")
    if "MathJax" not in generated_text:
        errors.append("MathJax configuration missing")
    if "language-lean" not in generated_text:
        errors.append("Lean code blocks missing")
    if generated_text.count('class="mermaid"') < 10:
        errors.append("fewer than ten rendered Mermaid diagram placements")
    if "Sho Sonoda" not in generated_text or "Sinho Chewi" not in generated_text:
        errors.append("required attribution missing")
    return errors


def command_build(args: argparse.Namespace) -> int:
    output = Path(args.output).resolve() if args.output else DEFAULT_OUTPUT
    data = build_site(output)
    print(
        f"built {output}: {len(data['chapters'])} chapters, "
        f"{data['registry']['compiled_local_leaves']} compiled local leaves, "
        f"{len(data['declarations'])} Registry cards"
    )
    return 0


def command_check(args: argparse.Namespace) -> int:
    output = Path(args.output).resolve() if args.output else DEFAULT_OUTPUT
    if not output.exists() or args.rebuild:
        build_site(output)
    errors = validate_site(output)
    if errors:
        print("ASTIS site check failed:", file=sys.stderr)
        for error in errors:
            print(f"- {error}", file=sys.stderr)
        return 1
    data = json.loads((output / "data" / "site-data.json").read_text(encoding="utf-8"))
    print(
        f"ASTIS site check passed: {len(data['chapters'])} chapters, "
        f"{data['registry']['compiled_local_leaves']} compiled local leaves"
    )
    return 0


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser(description=__doc__)
    sub = result.add_subparsers(dest="command", required=True)
    build = sub.add_parser("build", help="generate the static website")
    build.add_argument("--output", help="output directory (default: repository _site)")
    build.set_defaults(func=command_build)
    check = sub.add_parser("check", help="validate generated status, declarations, and links")
    check.add_argument("--output", help="output directory (default: repository _site)")
    check.add_argument("--rebuild", action="store_true", help="rebuild before checking")
    check.set_defaults(func=command_check)
    return result


def main(argv: list[str] | None = None) -> int:
    args = parser().parse_args(argv)
    return int(args.func(args))


if __name__ == "__main__":
    raise SystemExit(main())
