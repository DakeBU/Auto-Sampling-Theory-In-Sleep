#!/usr/bin/env python3
"""Generate the interactive textbook/SampleWiki/Lean dependency graph."""

from __future__ import annotations

import json
import re
import shutil
from html import escape
from pathlib import Path
from typing import Any

from underlying_lean_graph_frontier import add_frontier
from underlying_lean_graph_model import AUDITS, CASES, CSS, DATA, DEFAULT_OUTPUT, JS, LABEL, PAGE, ROOTS, GraphBuilder, load
from underlying_lean_graph_textbook import add_textbook


def build_graph(output: Path) -> dict[str, Any]:
    site = load(output / "data/site-data.json")
    manifest = load(CASES)
    audit_registry = load(AUDITS)
    builder = GraphBuilder()
    textbook = add_textbook(builder, site)
    setting_ids = add_frontier(builder, manifest, audit_registry, textbook["chapter_ids"])
    graph = builder.export()
    graph["counts"] = {
        "chapters": len(textbook["chapter_ids"]),
        "samplewiki_settings": len(setting_ids),
        "samplewiki_cases": len(manifest.get("cases", [])),
        "source_claims": len(textbook["source_ids"]),
        "lean_modules": len(textbook["module_ids"]),
        "registry_declarations": len(textbook["registry"]),
        "proof_roots": len(ROOTS),
        "nodes": len(builder.nodes),
        "edges": len(builder.edges),
    }
    return graph


def main_html(counts: dict[str, Any]) -> str:
    return f'''
<section class="ulg-hero" data-underlying-lean-graph data-graph-source="{DATA}">
  <div class="eyebrow">Samplinglib · formal topology</div>
  <div class="ulg-hero-grid">
    <div><h1>{LABEL}</h1><p>Chewi's twelve-chapter theorem order, the compiled Samplinglib branches beneath it, and the SampleWiki frontier are one navigable proof graph.</p></div>
    <dl><div><dt>{counts.get('chapters', 0)}</dt><dd>book chapters</dd></div><div><dt>{counts.get('source_claims', 0)}</dt><dd>source claims</dd></div><div><dt>{counts.get('lean_modules', 0)}</dt><dd>Lean modules</dd></div><div><dt>{counts.get('samplewiki_cases', 0)}</dt><dd>frontier results</dd></div></dl>
  </div>
  <p class="ulg-contract"><strong>Edge direction:</strong> prerequisite → consumer. A new paper may reuse a branch, close a missing leaf, or establish a genuinely new cross-branch composition edge.</p>
</section>
<section class="ulg-shell">
  <div class="ulg-toolbar">
    <div class="ulg-presets" role="group" aria-label="Graph view"><button class="active" data-view="overview">Library overview</button><button data-view="textbook">Textbook · 12 chapters</button><button data-view="frontier">SampleWiki frontier</button><button data-view="lean">Lean branches</button></div>
    <label class="ulg-search"><span>Search theorem, paper, module, declaration, or technique</span><input type="search" data-graph-search placeholder="e.g. Theorem 8.4.1, Fisher, Girsanov"></label>
    <div class="ulg-actions"><button data-graph-fit>Fit</button><button data-graph-reset>Reset</button><span data-graph-count></span></div>
  </div>
  <div class="ulg-stage"><div class="ulg-canvas" data-graph-canvas tabindex="0"><svg data-graph-svg role="img" aria-label="Interactive Lean dependency graph"></svg><p data-graph-empty hidden>No matching branch.</p><small>Drag to pan · wheel to zoom · click a node to reveal its immediate prerequisites and consumers.</small></div><aside class="ulg-detail" data-graph-detail aria-live="polite"><div class="ulg-placeholder"><span>Branch inspector</span><h2>Select a node.</h2><p>Source statement, proof equations, exact Lean leaves, prerequisites, consumers, and reader links appear here.</p></div></aside></div>
  <div class="ulg-legend"><span><i data-status="compiled"></i>compiled</span><span><i data-status="partial"></i>partial</span><span><i data-status="audited"></i>source audited</span><span><i data-status="planned"></i>planned / blocked</span><span><i data-status="literature-open"></i>literature-open</span><span><i data-status="shared"></i>shared root</span></div>
</section>
<section class="ulg-semantics"><div class="section-heading"><span>Topology semantics</span><h2>What a contribution changes in the graph.</h2></div><div><article><b>01</b><h3>Reuse a branch</h3><p>A thin assembly adds a consumer edge, not a duplicate proof.</p></article><article><b>02</b><h3>Close a leaf</h3><p>A new analytic lemma discharges an open interface.</p></article><article><b>03</b><h3>Add topology</h3><p>A proof connects branches that were previously formalized only in isolation.</p></article><article><b>04</b><h3>Expose a gap</h3><p>An unknown matching theorem stays visible; ASTIS never invents a source statement.</p></article></div></section>
<noscript><p>The interactive graph requires JavaScript. Exact declarations remain in the <a href="declarations/index.html">declaration index</a>.</p></noscript>
'''


def replace_main(text: str, body: str) -> str:
    start = text.find('<main id="content">')
    end = text.find("</main>", start)
    if start < 0 or end < 0:
        raise RuntimeError("lean-foundations main element not found")
    marker = '<main id="content">'
    return text[:start] + marker + body + "</main>" + text[end + 7 :]


def graph_href(rel: str, node_id: str) -> str:
    return "../" * len(Path(rel).parent.parts) + PAGE + "?focus=" + node_id


def context_link(text: str, rel: str, node_id: str, label: str) -> str:
    href = graph_href(rel, node_id)
    if href in text:
        return text
    block = f'<a class="ulg-context" href="{escape(href)}"><span>Formal topology</span><strong>{escape(label)}</strong><b>↗</b></a>'
    start = text.find('<main id="content">')
    closing = "</header>"
    end = text.find(closing, start)
    if end < 0:
        closing = "</section>"
        end = text.find(closing, start)
    cut = end + len(closing)
    return text if end < 0 else text[:cut] + block + text[cut:]


def transform_site(output: Path, graph: dict[str, Any]) -> None:
    asset_dir = output / "assets"
    asset_dir.mkdir(exist_ok=True)
    shutil.copyfile(CSS, asset_dir / CSS.name)
    shutil.copyfile(JS, asset_dir / JS.name)
    page = output / PAGE
    text = replace_main(page.read_text(encoding="utf-8"), main_html(graph["counts"]))
    title = LABEL + " · Samplinglib"
    text = re.sub(r"<title>.*?</title>", f"<title>{title}</title>", text, count=1, flags=re.S)
    text = text.replace("</head>", f'<link rel="stylesheet" href="assets/{CSS.name}">\n</head>', 1)
    text = text.replace("</body>", f'<script defer src="assets/{JS.name}"></script>\n</body>', 1)
    page.write_text(text, encoding="utf-8", newline="\n")

    link_pattern = re.compile(r'(<a\s+href="(?:\.\./)*lean-foundations\.html"(?:\s+aria-current="page")?>)Proof Atlas(</a>)')
    for path in sorted(output.rglob("*.html")):
        rel = path.relative_to(output).as_posix()
        text = path.read_text(encoding="utf-8")
        text = link_pattern.sub(rf"\1{LABEL}\2", text)
        text = re.sub(r'(?<!id="source-)(data-source-id)="([^"]+)"', r'id="source-\2" \1="\2"', text)
        chapter = re.fullmatch(r"textbook/chapter-(\d{2})\.html", rel)
        section = re.fullmatch(r"textbook/chapter-(\d{2})/section-.*\.html", rel)
        if chapter:
            text = context_link(text, rel, f"chapter:{chapter.group(1)}", "Open this chapter's Lean branches")
        elif section:
            text = context_link(text, rel, f"chapter:{section.group(1)}", "Open this section in the underlying Lean graph")
        path.write_text(text, encoding="utf-8", newline="\n")
    for node in graph["nodes"]:
        if node.get("kind") != "frontier-case" or not node.get("url"):
            continue
        path = output / str(node["url"])
        if path.exists():
            rel = path.relative_to(output).as_posix()
            path.write_text(context_link(path.read_text(encoding="utf-8"), rel, str(node["id"]), "Open this result's proof branch"), encoding="utf-8", newline="\n")


def validate(output: Path, graph: dict[str, Any]) -> None:
    counts = graph["counts"]
    expected = {"chapters": 12, "samplewiki_settings": 7, "samplewiki_cases": 34}
    errors = [f"{key}: expected {value}, found {counts.get(key)}" for key, value in expected.items() if counts.get(key) != value]
    for key in ("source_claims", "lean_modules", "registry_declarations", "nodes", "edges"):
        if not counts.get(key):
            errors.append(f"{key} is empty")
    page = (output / PAGE).read_text(encoding="utf-8")
    for marker in (LABEL, "data-underlying-lean-graph", DATA, CSS.name, JS.name, "data-graph-detail"):
        if marker not in page:
            errors.append(f"graph page missing {marker}")
    failures = 0
    for path in output.rglob("*.html"):
        text = path.read_text(encoding="utf-8")
        start = text.find('<div class="sidebar-contents"')
        end = text.find('<div class="sidebar-utility">', start)
        if start >= 0 and end >= 0 and LABEL not in text[start:end]:
            failures += 1
    if failures:
        errors.append(f"sidebar label missing on {failures} pages")
    if errors:
        raise RuntimeError("underlying Lean graph validation failed:\n- " + "\n- ".join(errors))


def enrich_site(output: Path = DEFAULT_OUTPUT) -> None:
    graph = build_graph(output)
    data = output / DATA
    data.parent.mkdir(exist_ok=True)
    data.write_text(json.dumps(graph, ensure_ascii=False, indent=2) + "\n", encoding="utf-8", newline="\n")
    transform_site(output, graph)
    validate(output, graph)


if __name__ == "__main__":
    enrich_site()
