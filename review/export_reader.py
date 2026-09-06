#!/usr/bin/env python3
"""Export a selected, anonymized reader without changing the development tree.
This is author-side tooling, NOT part of the anonymous reviewer distribution.
"""
from __future__ import annotations
import argparse, hashlib, html, json, re
from pathlib import Path
from urllib.parse import urlsplit, unquote
from bs4 import BeautifulSoup, Comment

DENY = re.compile(r'Dake\s*Bu|dakebu|Ji Cheng|Huanjian Zhou|Andi Han|Zonghao Chen|Hau.San Wong|Qingfu Zhang|Auto.Sampling.Theory.In.Sleep|ASTIS|Samplinglib|AutoSamplingTheory|/home/|github\.com/[^/]+/[^/]+/(?:commit|pull|actions)/', re.I)
RENAME = {'AutoSamplingTheory':'ReviewLibrary','Samplinglib':'Review Library','samplinglib':'review-library','ASTIS':'Review','astis':'review','quantumcomputinglib':'reference-library'}
CASE = 'ReviewLibrary.TechnicalLemmas.Analysis.StrongConvexFirstOrder'
CURVE = 'ReviewLibrary.TechnicalLemmas.Geometry.GeodesicConvexity'


def neutral(text):
    for a,b in RENAME.items(): text=text.replace(a,b)
    text=re.sub(r'https?://(?:github\.com|raw\.githubusercontent\.com)/DakeBU/[^\s"<>]+', '', text, flags=re.I)
    text=re.sub(r'https?://dakebu\.github\.io/[^\s"<>]+', '', text, flags=re.I)
    return text


def dump(path, obj):
    path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(obj,ensure_ascii=False,indent=2)+'\n')


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--root',type=Path,required=True);ap.add_argument('--output',type=Path,required=True)
    a=ap.parse_args();root=a.root.resolve();out=a.output.resolve();site=root/'_site'
    if out==root or root in out.parents: raise ValueError('Export outside the development source tree')
    if out.exists(): raise ValueError('Use a fresh output directory')
    out.mkdir(parents=True);(out/'assets').mkdir();(out/'data').mkdir()
    graph=json.loads((site/'data/underlying-lean-graph.json').read_text())
    memory=json.loads(neutral((root/'website/content/graph_memory_index.json').read_text()))
    model=json.loads(neutral((root/'website/content/functor_hypergraph.json').read_text()))
    searches={x for f in memory['families'] for x in f['formal_search_nodes']}
    searches |= {b['node'] for f in memory['families'] for b in f.get('compiled_substrate_bindings',[])}
    selected=[]
    for n in graph['nodes']:
        n=json.loads(neutral(json.dumps(n,ensure_ascii=False)))
        if n['kind'] not in {'library','chapter','library-chapter','proof-root','concept-domain','concept-bridge','module'}:continue
        if n['kind']=='module' and n['id'].removeprefix('module:') not in searches:continue
        n.pop('source_url',None);n.pop('url',None);n.pop('search',None)
        if n['kind']=='module':
            mid=n['id'].removeprefix('module:');checked=mid in {CASE,CURVE}
            n.update(status='compiled' if checked else 'planned',subtitle='Explicit focused build passed' if checked else 'Source inventory; not individually rechecked',summary='Selected module in the frozen review snapshot.',details=[{'label':'Evidence scope','value':'Named module compiled in the pinned environment.' if checked else 'A retrieval location, not a per-declaration proof certificate.'}])
            if checked:n['url']='case-study.html'
        elif n['kind'] in {'chapter','library-chapter','library'}:
            n['status']='planned';n['subtitle']='Source organization; not chapter completion';n['summary']='Reading/source organization in the selected review graph.'
        n['search']=' '.join([n['id'],n['label'],n.get('subtitle',''),n.get('summary','')]).lower()
        selected.append(n)
    ids={n['id'] for n in selected};edges=[]
    for e in graph['edges']:
        e=json.loads(neutral(json.dumps(e)))
        if e['source'] not in ids or e['target'] not in ids:continue
        if e['relation']=='imports':
            e['relation']='checked import' if e['source']=='module:'+CURVE and e['target']=='module:'+CASE else 'source import; not individually checked'
        edges.append(e)
    g={'schema_version':graph['schema_version'],'generated_from':'Frozen selected source export; see verification-report.json','nodes':selected,'edges':edges,'hyperedges':model['hyperedges'],'conceptual_transport_contract':neutral(graph['conceptual_transport_contract']),'graph_memory_index':{'path':'data/graph_memory_index.json','family_ids':[f['id'] for f in memory['families']],'view_contracts':memory['views']},'counts':{'nodes':len(selected),'edges':len(edges),'lean_modules':sum(n['kind']=='module' for n in selected),'conceptual_domains':5,'conceptual_families':5,'conceptual_hyperedges':13}}
    dump(out/'data/underlying-lean-graph.json',g);dump(out/'data/graph_memory_index.json',memory);dump(out/'data/functor_hypergraph.json',model)
    # Reuse native styles; do not redistribute font files or fetch web fonts.
    for p in (site/'assets').glob('*.css'):
        text=neutral(p.read_text());text=re.sub(r'/\*.*?\*/','',text,flags=re.S)
        text=re.sub(r'@import\s+url\(["\']https?[^;]+;', '',text)
        text=re.sub(r'url\(["\']?(?!data:|[.a-zA-Z0-9_-]+\.css)[^)]*\)', 'none', text)
        (out/'assets'/neutral(p.name)).write_text(text)
    js=neutral((site/'assets/underlying-lean-graph.js').read_text())
    js=js.replace('new Set(["imports", "declares", "depends-on", "closes leaf"])','new Set(["checked import"])')
    (out/'assets/underlying-lean-graph.js').write_text(js)
    raw=BeautifulSoup((site/'lean-foundations.html').read_text(),'html.parser')
    css=[neutral(Path(t['href']).name) for t in raw.select('link[rel="stylesheet"]')]
    math=next(str(t) for t in raw.select('script') if not t.get('src') and 'MathJax' in t.text)
    head='<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><meta name="referrer" content="no-referrer"><meta name="robots" content="noindex,nofollow">'+''.join(f'<link rel="stylesheet" href="assets/{p}">' for p in css)+math+'<script defer src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>'
    head+='<style>.review-main{max-width:1440px;margin:auto;padding:28px}.review-nav{display:flex;flex-wrap:wrap;gap:18px;margin:0 0 24px}.review-note{padding:16px;border:1px solid var(--line);border-radius:10px;margin-bottom:24px}pre{white-space:pre-wrap;overflow-wrap:anywhere}body{min-width:0}</style>'
    nav='<nav class="review-nav" aria-label="Review navigation"><a href="index.html">Review home</a><a href="lean-foundations.html">Three graph views</a><a href="sources.html">Source shelves</a><a href="case-study.html">Lean case</a><a href="protocol.html">Protocol</a></nav>'
    def page(name,title,body,graphscript=False):
        s=BeautifulSoup(neutral(body),'html.parser')
        for c in s.find_all(string=lambda v:isinstance(v,Comment)):c.extract()
        for a in s.select('a[href]'):
            url=a['href'];u=urlsplit(url)
            if u.scheme and u.scheme not in {'http','https'}:a.attrs.pop('href',None)
            elif not u.scheme and url and not url.startswith('#') and urlsplit(url).path not in {'index.html','lean-foundations.html','sources.html','case-study.html','protocol.html','verification-report.json'}:
                a.attrs.pop('href',None);a['title']='Not included in this frozen excerpt'
            a['rel']='noreferrer noopener'
        text='<!doctype html><html lang="en" data-color-scheme="light"><head><title>'+html.escape(title)+'</title>'+head+'</head><body><main class="review-main" id="content">'+nav+str(s)+'</main>'
        if graphscript:text+='<script defer src="assets/underlying-lean-graph.js"></script>'
        (out/name).write_text(text+'</body></html>')
    main=raw.main
    for b in main.select('button[data-view]'):
        if b['data-view'] not in {'overview','lean','functor'}:b.decompose()
    main.select_one('.ulg-hero dl').clear()
    for num,label in [(5,'source shelves'),(len(searches),'selected module locations'),(5,'concept families'),(13,'typed bridges'),(2,'focused case modules'),(0,'completed round-trip audits')]:
        main.select_one('.ulg-hero dl').append(BeautifulSoup(f'<div><dt>{num}</dt><dd>{label}</dd></div>','html.parser'))
    main.select_one('.ulg-contract').clear();main.select_one('.ulg-contract').append('This frozen excerpt distinguishes source inventory from focused compilation. Only the case-study import is shown as a checked structural edge; all other edges are source or conceptual overlays. Conceptual bridges are not certified functors. Source matching remains a separate obligation.')
    main.select_one('.ulg-legend').clear();main.select_one('.ulg-legend').append('Green: explicitly checked case module. Gray: source organization or unverified retrieval location. Dashed edges: source/conceptual overlays. Solid edge: checked case import, not a general proof-term graph.')
    page('lean-foundations.html','Frozen review | Three graph views',main.decode_contents(),True)
    page('index.html','Anonymous review snapshot','<section class="ulg-hero"><div class="eyebrow">Frozen supplementary reader</div><h1>Source-Faithful Graph Memory</h1><p>Anonymous companion to the workshop submission. Explore source organization, formal evidence, and recurring mathematical mechanisms without conflating their truth status.</p></section><section class="ulg-semantics"><h2>Start with the mechanism; inspect its evidence.</h2><p><a href="lean-foundations.html?view=functor&amp;focus=transport:pl-lsi">PL / LSI mirror</a> · <a href="lean-foundations.html?view=functor&amp;focus=transport:pi-chi2">Poincaré / chi-square</a> · <a href="case-study.html">Compiled convexity case</a></p><p>This is a selected, frozen export, not the full development repository. Five shelves describe a corpus, not completed textbook formalizations. Thirteen conceptual bridges remain not-Lean-certified. A minimal Lean fixture is included in LeanCase/; the source/repair and agent protocols are summarized separately.</p><p>No accounts, Git history, private paths, or development links are needed to use this snapshot. Standard third-party source citations are retained.</p></section>')
    cards=''
    for title,source,description in [
        ('Log-Concave Sampling','https://chewisinho.github.io/main.pdf','Chewi. Convexity, couplings, Langevin dynamics and functional inequalities; twelve-chapter reading spine.'),
        ('Optimisation','https://arxiv.org/abs/2605.07006','Chewi. Euclidean convex analysis and first-order methods; shared producer of convex-energy interfaces.'),
        ('Riemannian Optimisation','https://www.nicolasboumal.net/book/','Boumal. Manifold, metric and gradient contracts; geometry-specific adapters remain explicit.'),
        ('Statistical Optimal Transport','https://chewisinho.github.io/st_flour.pdf','Chewi, Niles-Weed and Rigollet. Couplings, duality, flows and statistical estimation; source scaffolds, not completed Lean proofs.'),
        ('SampleWiki frontier','https://samplewiki.morning-recipe-422a.workers.dev/','Frontier literature, including lower bounds. Hardness and constructive upper-bound routes have distinct oracle and cost contracts.')]:
        cards+=f'<article><h2>{title}</h2><p>{description}</p><a href="{source}">Primary source</a></article>'
    page('sources.html','Frozen review | Source shelves','<section class="ulg-hero"><h1>Five source shelves, one shared foundation</h1><p>Textbook order is not proof dependency order. Reuse exact matches; adapt near matches; share one missing foundation; preserve genuinely different statements.</p></section><section class="ulg-semantics">'+cards+'</section><section class="ulg-semantics"><h2>Source detail and attribution</h2><p>Background mathematical references include Bubeck (2015), Beck (2017), Nesterov (2018), Ambrosio–Gigli–Savaré (2008) and Bakry–Gentil–Ledoux (2014). Upstream formal sources include mathlib, Optlib and CvxLean. Missing hypotheses are recorded, never silently added to a source theorem. No textbook PDF or external theorem corpus is redistributed.</p></section>')
    # Rename only project namespaces and prose, and separately recompile in CI.
    lean=out/'LeanCase';lean.mkdir()
    for src,dst in [('AutoSamplingTheory/TechnicalLemmas/Geometry/GeodesicConvexity.lean','ReviewLibrary/TechnicalLemmas/Geometry/GeodesicConvexity.lean'),('AutoSamplingTheory/TechnicalLemmas/Analysis/StrongConvexFirstOrder.lean','ReviewLibrary/TechnicalLemmas/Analysis/StrongConvexFirstOrder.lean'),('Tests/Shared/StrongConvexFirstOrder.lean','ReviewTest.lean')]:
        text=neutral((root/src).read_text());p=lean/dst;p.parent.mkdir(parents=True,exist_ok=True);p.write_text(text)
    (lean/'lean-toolchain').write_text((root/'lean-toolchain').read_text())
    manifest=json.loads((root/'lake-manifest.json').read_text());rev=next(p['rev'] for p in manifest['packages'] if p['name']=='mathlib')
    (lean/'lakefile.lean').write_text('import Lake\nopen Lake DSL\npackage reviewCase\nrequire mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "'+rev+'"\n@[default_target]\nlean_lib ReviewLibrary\n@[default_target]\nlean_lib ReviewTest\n')
    (lean/'ReviewLibrary.lean').write_text('import '+CASE+'\n')
    (lean/'AxiomCheck.lean').write_text('import '+CASE+'\n#print axioms '+CASE+'.firstOrder_lower_bound_of_strongConvexOn\n')
    source=(lean/'ReviewLibrary/TechnicalLemmas/Analysis/StrongConvexFirstOrder.lean').read_text()
    page('case-study.html','Frozen review | Strong convexity','<section class="ulg-hero"><h1>One shared quadratic lower model</h1><p>Strong convexity + the ambient gradient give a curve-wise first-order lower bound. The affine segment supplies the adapter; a previously available scalar limiting lemma supplies the proof core.</p></section><section class="ulg-semantics"><div class="math-display">\\[f(y)\\ge f(x)+\\langle G(x),y-x\\rangle+\\frac m2\\|y-x\\|^2.\\]</div><p>The original named module and focused test were explicitly compiled under Lean/mathlib 4.33.0. Axiom output lists propext, Classical.choice and Quot.sound. Check verification-report.json for the separately recompiled anonymized fixture. Neither result certifies PL, LSI, a manifold application or source-text equivalence.</p><p>The minimal fixture retains mathematical source attribution to Optlib and Chewi. Only project-specific namespace/description strings are renamed.</p><pre>'+html.escape(source)+'</pre></section>')
    page('protocol.html','Frozen review | Protocol','<section class="ulg-hero"><h1>Evidence and memory obligations</h1><p>One generalist worker owns a bounded theorem target. Reading, retrieval, proof design and debugging are modes, not permanent intellectual roles.</p></section><section class="ulg-semantics"><h2>Three independent checks</h2><p>Local Lean validity, source fidelity and conceptual correspondence are different claims. The admission sequence is claim → local proof → separate review → integration. A no-progress guard retains typed obstructions. A different actor label is not a guarantee of independent mathematical judgment.</p><h2>Keep discovered mechanisms</h2><p>A new local-proof packet must record either no mirror found or published mirror candidates. Each candidate names family, bridge, domains, mechanism, formula, hypothesis/conclusion maps, source anchors and failure boundaries. The creator cannot validate its own candidate.</p><h2>Source round trip and repairs</h2><p>Original text → Lean statement → reconstruction with source text hidden from the decoder. Compare semantic slots, not wording. Record repairs separately; do not overwrite the source. The frozen registry has zero completed audits and zero accepted repairs. This is implemented infrastructure, not evidence of semantic-repair accuracy.</p><h2>Contribution, not ranking</h2><p>Leaf, bridge, shortcut, hub and reorganization describe graph changes relative to a baseline. They are not scientific-quality scores. Compression must retain expandable assumptions, dependencies and provenance.</p></section>')
    report={'schema_version':1,'scope':'Selected frozen review export; source inventories are not proof counts.','protocol_tests':{'passed':48,'suites':['substantive advance and conceptual mirror','semantic roundtrip and repair','cross-domain consistency']},'original_focused_lean':{'status':'passed','toolchain':'Lean 4.33.0 / mathlib 4.33.0','scope':'strong-convex first-order module, curve-wise dependency and focused use test','axioms':['propext','Classical.choice','Quot.sound']},'anonymous_fixture':{'status':'not-yet-rechecked','commands':['lake update','lake exe cache get','lake build','lake env lean AxiomCheck.lean']},'browser':{'status':'not-yet-rechecked'},'semantic_audits':0,'accepted_repairs':0,'conceptual_bridges':13,'certified_functors':0}
    dump(out/'verification-report.json',report)
    (out/'README.md').write_text('# Anonymous frozen review reader\n\nRun `python3 validate_snapshot.py`, then `python3 -m http.server 8000` and open the local index. The graph requires HTTP, not file://. MathJax is loaded from jsDelivr; no analytics or development-account links are included. The selected reader uses the original theme and graph renderer with neutral branding and explicit evidence boundaries.\n\n## Lean fixture\nIn LeanCase, with elan installed: `lake update`, `lake exe cache get`, `lake build`, then `lake env lean AxiomCheck.lean`. Toolchain and mathlib are pinned. This reproduces the convexity case, not full textbook formalization. See verification-report.json for executed checks.\n\nSources and their authors are retained as third-party attribution, not identified as submission authors. No repository history or external theorem corpus is included. Deliberate reverse identification from public mathematics cannot be ruled out.\n')
    validator='''#!/usr/bin/env python3
"""Check integrity and local HTML links of this frozen snapshot."""
import hashlib, json
from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urlsplit, unquote
ROOT=Path(__file__).resolve().parent
class Links(HTMLParser):
 def __init__(self): super().__init__(); self.links=[]
 def handle_starttag(self,tag,attrs):
  for k,v in attrs:
   if k in ('href','src') and v: self.links.append(v)
manifest=json.loads((ROOT/'integrity.json').read_text())
for rel,digest in manifest.items():
 p=ROOT/rel
 assert p.is_file() and hashlib.sha256(p.read_bytes()).hexdigest()==digest, rel
for p in ROOT.glob('*.html'):
 parser=Links();parser.feed(p.read_text())
 for link in parser.links:
  u=urlsplit(link)
  if not u.scheme and u.path:
   assert (p.parent/unquote(u.path)).is_file(), (p.name,link)
print('Snapshot file integrity and local HTML links: PASS')
'''
    (out/'validate_snapshot.py').write_text(validator)
    # No scanner patterns or author-only pipeline sources enter the review ZIP.
    for p in out.rglob('*'):
        if p.is_file():
            for text in [str(p.relative_to(out)),html.unescape(unquote(p.read_text()))]:
                m=DENY.search(text)
                if m:raise ValueError(f'Identity leak in {p.relative_to(out)}: {m.group()}')
    dump(out/'integrity.json',{str(p.relative_to(out)):hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(out.rglob('*')) if p.is_file()})
    print(json.dumps({'pages':5,'nodes':len(selected),'edges':len(edges),'identity_scan':'passed','output':str(out)},indent=2))

if __name__=='__main__':main()
