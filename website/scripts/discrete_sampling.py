"""Discrete-state peer reader and audited routing metadata, never Lean evidence.

Uses the existing Samplinglib page factory, chapter shell, MathJax, graph model
and progress panel. No vendored textbook PDFs and no second renderer.
"""
from __future__ import annotations
import hashlib
import json
import re
from html import escape
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SOURCE_PATH = ROOT / 'Libraries/DiscreteSampling/source-map.json'
ROUTE_PATH = ROOT / 'Libraries/DiscreteSampling/route-plan.json'
BASE = 'libraries/discrete-sampling/'
SOURCE_SHA256 = '3cc2f911b33bb5538157ef8a70f0c7e0f3c812ecd06dc9c1d5ea0bfdae11a52a'
SOURCE_URL = 'https://arxiv.org/pdf/2307.13826v4'


def load(path: Path) -> dict:
    return json.loads(path.read_text(encoding='utf-8'))


def require(ok: bool, message: str) -> None:
    if not ok:
        raise ValueError('Discrete Sampling: ' + message)


def validate_data(source=None, route=None, spine=None) -> None:
    source = load(SOURCE_PATH) if source is None else source
    route = load(ROUTE_PATH) if route is None else route
    spine = load(ROOT / 'Libraries/frontloaded-shared-spine.json') if spine is None else spine
    require(source['source_url'] == SOURCE_URL and source['arxiv_id'] == '2307.13826v4', 'immutable source version changed')
    require(source['sha256'] == SOURCE_SHA256 and source['pdf_pages'] == 100, 'source fingerprint/page count drift')
    require(source['authors'] == ['Zongchen Chen', 'Daniel Štefankovič', 'Eric Vigoda'], 'primary author identity drift')
    rows = source['chapters']
    require([r['id'] for r in rows] == [f'{i:02}' for i in range(1,13)], 'all twelve source sections must be peers')
    section_ids = set()
    for row in rows:
        require(row['status'] == 'scaffold', 'source scaffolds are not Lean proof closures')
        require(row['path'] == f'chapter-{row["id"]}.html', 'noncanonical chapter path')
        require(row['sections'] and row['formula'] and row['guide'], 'chapter lacks source map or orientation')
        for entry in [row, *row['sections']]:
            require(entry['printed_page'] == entry['pdf_page'] and 1 <= entry['pdf_page'] <= 100, 'wrong source pagination')
        for sec in row['sections']:
            require(sec['id'].startswith(str(int(row['id']))+'.') and sec['id'] not in section_ids, 'section id mismatch/duplicate')
            section_ids.add(sec['id'])
    require(len(section_ids) == 72, 'source TOC entries missing')
    require(rows[-1]['proof_detail_status'] == 'cites_external' and source['proof_gaps'], 'Ising survey proof gap must stay explicit')
    require(next(s for s in rows[-1]['sections'] if s['id']=='12.1')['pdf_page'] == 90, 'Ising anchor drift')
    require(route['scope'] == 'finite-state' and route['progress_is_not_proof'] is True, 'state-space scope/proof boundary drift')
    require(route['source_id'] == source['arxiv_id'], 'route source mismatch')
    known = {n['id'] for n in spine['nodes']}; done = set()
    for step in route['steps']:
        require(step['id'] not in done and set(step['parents']) <= done, 'route is not a DAG')
        require(set(step['shared_nodes']) <= known, 'route references unknown shared core')
        done.add(step['id'])
    for name in route['reuse_audit']['local_modules']:
        require(name.startswith('AutoSamplingTheory.') and (ROOT/(name.replace('.','/')+'.lean')).is_file(), 'missing local reuse candidate '+name)
    # Crucial scheduling property: finite foundations may not wait for continuum
    # calculus, SDE existence, Brenier transport or complete textbook chapters.
    nodes = {n['id']: n for n in spine['nodes']}
    def ancestors(ident, trail=frozenset()):
        require(ident not in trail, 'cyclic shared core')
        return {ident}.union(*(ancestors(p, trail | {ident}) for p in nodes[ident]['parents']))
    forbidden = {'sf-calculus-gradient','sf-markov-semigroup','sf-manifold-first-order'}
    for ident in ('sf-kernel-invariance','sf-finite-gibbs','sf-reversible-dirichlet','sf-pinning-influence'):
        require(not ancestors(ident) & forbidden, 'finite-state core blocked by diffusion/manifold prerequisites')


def verify_pdf(path: Path) -> None:
    require(hashlib.sha256(path.read_bytes()).hexdigest() == SOURCE_SHA256, 'downloaded source PDF bytes differ from pinned edition')


def write_pages(output: Path, shelves) -> None:
    import astis_site
    validate_data()
    source, route = load(SOURCE_PATH), load(ROUTE_PATH)
    body = shelves.index_body(eyebrow='Discrete Sampling Library · arXiv:2307.13826v4', title='Discrete Sampling',
        lede='Ising, hard-core, matroid bases and finite-state Gibbs samplers. Chen · Štefankovič · Vigoda supply the primary spectral-independence monograph.',
        source=source['source_url'], chapters=(),
        contract='Use the shared Samplinglib graph, not a parallel discrete probability library. Search Mathlib and local kernels, forms and entropy APIs; pin the source and clock; publish conceptual mirrors through independent review.')
    cards = ''.join(f'''<article class="library-chapter-card"><div class="library-chapter-number">{r['id']}</div><div><div class="card-meta">{shelves.badge('scaffold')}</div><h2><a href="{r['path']}">{escape(r['title'])}</a></h2><p>Source §{int(r['id'])} · printed / PDF p. {r['pdf_page']}. Source map, not a Lean closure.</p></div></article>''' for r in source['chapters'])
    body = body.replace('<div class="library-chapter-list"></div>', '<div class="library-chapter-list">'+cards+'</div>')
    companions = ''.join(f'<li><a href="{escape(c["url"])}">{escape(c["title"])}</a> — {escape(c["boundary"])}</li>' for c in source['companions'])
    body += f'''<section class="library-integration-note"><h2>Primary source and beginner companion</h2><p><a href="{source['abstract_url']}">{escape(source['title'])}</a> · {escape(', '.join(source['authors']))}.</p><p>{escape(source['edition_note'])} All 12 source sections use the same chapter environment as the peer books.</p><ul>{companions}</ul><h2>Discrete states, not Euler time steps</h2><p>Both discrete-time P and continuous-time jump generators are in scope on finite configurations. This is not the Euler discretization of a continuous-state Langevin diffusion.</p><p><strong>Ising proof boundary:</strong> §12.1 (p.90) includes model setup but surveys mixing results without proofs. Each such theorem must fetch its cited original proof and record every graph, sign, temperature, field and boundary hypothesis.</p><p><a class="button" href="route.html">Dependency-first contributor route</a> <a class="button" href="chapter-12.html#section-12-1">Ising source entry</a></p><p><a href="../../progress/index.html#discrete-sampling">Current Progress</a> · <a href="../../lean-foundations.html?view=functor&amp;focus=concept:discrete">Functor Hypergraph</a></p></section>'''
    astis_site.write_page(output,BASE+'index.html',astis_site.page('Discrete Sampling',BASE+'index.html',body,active='Libraries'))
    for r in source['chapters']:
        rel=BASE+r['path'];label=f'Source section {int(r["id"])}'
        body=shelves.chapter_body('Discrete Sampling',label,r['title'],source['source_url']+f'#page={r["pdf_page"]}',
            'Audit exact PMF/kernel, conditioning, weighted L2 and entropy signatures in Samplinglib/Mathlib; introduce a domain adapter, not a duplicate foundation.',source_label=f'Pinned arXiv v4 · printed / PDF p. {r["pdf_page"]}')
        links=''.join(f'<li id="section-{s["id"].replace(".","-")}"><a href="{source["source_url"]}#page={s["pdf_page"]}">§{s["id"]} · {escape(s["title"])}</a> <small>PDF / printed p. {s["pdf_page"]}</small></li>' for s in r['sections'])
        body+=rf'''<section class="library-integration-note"><h2>Mathematical orientation</h2><div class="math-display">\[{escape(r['formula'])}\]</div><p>{escape(r['guide'])}</p><p>ASTIS orientation, not a verbatim source theorem or a completed Lean proof. Exact statements and source omissions receive separate audits.</p><h2>Section source map</h2><ol>{links}</ol><p><a href="index.html">← Discrete Sampling contents</a> · <a href="route.html">Shared prerequisite route</a> · <a href="../../lean-foundations.html?view=functor&amp;focus=concept:discrete">Conceptual mirrors</a></p></section>'''
        astis_site.write_page(output,rel,astis_site.page(f'Discrete Sampling {label}: '+r['title'],rel,body,active='Libraries'))
    body=shelves.chapter_body('Discrete Sampling','Contributor route','Finite states, shared mathematics',source['source_url'],route['reuse_audit']['rule'])
    steps=''.join(f'<article class="library-integration-note" id="{s["id"]}"><h2>{s["id"]} · {escape(s["label"])}</h2><p>{escape(s["target"])}</p><p><strong>Parents:</strong> {escape(", ".join(s["parents"]) or "none")} · <strong>Source:</strong> {escape(", ".join(s["anchors"]))}</p><p><strong>Shared nodes:</strong> {escape(", ".join(s["shared_nodes"]))}</p></article>' for s in route['steps'])
    distinctions=''.join(f'<li>{escape(s)}</li>' for s in route['separations'])
    modules=''.join(f'<li><code>{escape(m)}</code></li>' for m in route['reuse_audit']['local_modules'])
    bridges=''.join(f'<li><a href="../../lean-foundations.html?view=functor&amp;focus={bid}">{escape(bid)}</a> — proposal; independent conceptual review pending, not Lean-certified.</li>' for bid in route['mirror_bridges'])
    body+=steps+f'''<section class="library-integration-note"><h2>Source-present reuse candidates</h2><p>{escape(route['reuse_audit']['status'])}</p><ul>{modules}</ul><h2>Do not conflate</h2><ul>{distinctions}</ul><h2>Automatic conceptual-mirror audit</h2><p>Every schema-v3 SAU must report none-found or publish typed discoveries before PROVED_LOCAL. A creator cannot validate their own mirror. Stabilization records source/assumption maps and failure boundaries once in family memory; graph links remain dashed until actual transport certificates exist.</p><ul>{bridges}</ul><p>Overview locates the source and plan; Functor explains conditional mathematical correspondences; Lean Branches alone displays actual compiled dependencies.</p><p><a href="../../progress/index.html#discrete-sampling">Progress board</a> · <a href="index.html">Library contents</a></p></section>'''
    rel=BASE+'route.html';astis_site.write_page(output,rel,astis_site.page('Discrete Sampling contributor route',rel,body,active='Libraries'))
    # Compact source/route metadata is downloadable by both Codex and readers.
    (output/'data').mkdir(exist_ok=True)
    for name, data in [('discrete-sampling-source',source),('discrete-sampling-route',route)]:
        (output/'data'/f'{name}.json').write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')


def progress_panel(grouped, panel) -> str:
    route=load(ROUTE_PATH)
    return panel(route_id='discrete-sampling',anchor='discrete-sampling',title='Discrete Sampling Route',eyebrow='Finite states · Gibbs / Glauber · arXiv:2307.13826v4',status='scaffold',source_label='Open library',source_url='../'+BASE+'index.html',lede='Ising and combinatorial sampling share canonical kernels, reversible forms and scalar decay with the other books. Discrete state space is not time discretization.',items=[('planned',s['label'],s['target']) for s in route['steps']],cells=grouped['discrete-sampling'],actions='<p><a class="button" href="../'+BASE+'route.html">Contributor route and truth boundaries</a></p>')


def add_to_graph(builder) -> None:
    source, route=load(SOURCE_PATH),load(ROUTE_PATH)
    builder.add('library:discrete','library','Discrete Sampling',status='planned',subtitle='peer arXiv monograph · scaffold',url=BASE+'index.html')
    builder.edge('library:samplinglib','library:discrete','formalization route')
    for r in source['chapters']:
        nid=builder.add('library-chapter:discrete:'+r['id'],'library-chapter',r['id']+'. '+r['title'],status='planned',subtitle='source section scaffold; not Lean evidence',url=BASE+r['path'])
        builder.edge('library:discrete',nid,'chapter scaffold')
    # Project topology, not a compiler dependency and not source chapter order.
    for s in route['steps']:
        nid=builder.add('discrete-plan:'+s['id'],'library-chapter',s['id']+' · '+s['label'],status='planned',subtitle='shared-dependency plan; no Lean closure',url=BASE+'route.html#'+s['id'],details=[{'label':'Shared core','value':', '.join(s['shared_nodes'])},{'label':'Target','value':s['target']}])
        builder.edge('library:discrete',nid,'route plan')
        for parent in s['parents']:builder.edge('discrete-plan:'+parent,nid,'planned prerequisite; not proof dependency')


def validate_site(output: Path) -> None:
    import library_shelves
    validate_data();source=load(SOURCE_PATH)
    canonical=set(library_shelves.canonical_theme_styles(output))
    for rel in [BASE+'index.html',BASE+'route.html',*[BASE+r['path'] for r in source['chapters']]]:
        require((output/rel).is_file(),'missing peer page '+rel)
        text=(output/rel).read_text(encoding='utf-8')
        require(canonical <= set(library_shelves.stylesheet_names(text)), 'theme mismatch '+rel)
        require(len(re.findall(r'<h1\b',text))==1,'one H1 required '+rel)
        require('discrete-sampling' in text and SOURCE_URL in text,'missing source/navigation '+rel)
    for r in source['chapters']:
        text=(output/BASE/r['path']).read_text(encoding='utf-8')
        for s in r['sections']:require('id="section-'+s['id'].replace('.','-')+'"' in text,'missing section anchor '+s['id'])
    graph=load(output/'data/underlying-lean-graph.json');nodes={n['id']:n for n in graph['nodes']}
    require('library:discrete' in nodes and 'concept:discrete' in nodes,'source/concept absent from unified graph')
    for s in load(ROUTE_PATH)['steps']:require(nodes['discrete-plan:'+s['id']]['status']=='planned','plan promoted to theorem')
    require('Discrete Sampling Route' in (output/'progress/index.html').read_text(),'missing current progress route')


if __name__=='__main__':
    import argparse
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--pdf',type=Path);args=parser.parse_args()
    validate_data()
    if args.pdf: verify_pdf(args.pdf)
    print('Discrete Sampling source and shared-route contracts: OK (not Lean proof evidence)')
