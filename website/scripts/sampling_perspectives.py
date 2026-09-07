"""Source/method/target overlays. Scope colours never certify Lean reuse."""
import json
import re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
PATH=ROOT/'website/content/sampling_perspectives.json'

def load():return json.loads(PATH.read_text())

def validate(data=None):
    d=load() if data is None else data
    ids={n['id'] for n in d['nodes']}; libraries={v['node'] for v in d['palette'].values() if 'node' in v}
    if len(ids)!=len(d['nodes']):raise ValueError('Duplicate perspective id')
    if d['view']!='overview:methods-targets':raise ValueError('Perspective is an Overview subview, not a fourth proof contract')
    for p in d['palette'].values():
        if not re.fullmatch(r'#[0-9a-fA-F]{6}',p['color']):raise ValueError('Bad scope colour')
    for row in d['nodes']:
        if not set(row['library_scope'])<=set(d['palette']):raise ValueError('Unknown perspective membership')
    for row in d['edges']:
        if not {row['source'],row['target']}<=ids|libraries:raise ValueError('Dangling perspective relation')
        if not row['relation'].endswith('(curated)'):raise ValueError('Perspective cannot create a formal implication')
    for row in d['module_scope']:
        if not row['boundary'] or not set(row['libraries'])<=set(d['palette']):raise ValueError('Missing module scope boundary')
    return d

def apply_to_graph(b):
    d=validate()
    from mcmc_library import load as mcmc_load
    sources=mcmc_load()['sources']
    for row in d['nodes']:
        b.add(row['id'],row['kind'],row['label'],status='planned',summary=row['summary'],subtitle='Curated method / target perspective',formula=row['formula'],perspective_position=row['position'],library_scope=row['library_scope'],scope_basis='curated taxonomy / analytical scope; not proof reuse',sources=[sources[k] for k in row['source_ids']],source_url=sources[row['source_ids'][0]]['url'],url='libraries/mcmc/index.html#method-perspective',details=[{'label':'Scope boundary','value':row['summary']}])
    for row in d['edges']:b.edge(row['source'],row['target'],row['relation'])
    for nid,xy in d['library_positions'].items():
        if nid not in b.nodes:raise ValueError('Missing peer Library '+nid)
        b.nodes[nid]['perspective_position']=xy
    direct={v['node']:k for k,v in d['palette'].items() if 'node' in v}
    chapter_prefixes={'library-chapter:riemannian:':'riemannian-optimization','library-chapter:optimisation:':'optimisation','library-chapter:optimal-transport:':'statistical-optimal-transport','library-chapter:discrete-sampling:':'discrete-sampling','library-chapter:mcmc:':'mcmc','library-extension:mcmc:':'mcmc','chapter:':'log-concave-sampling','source:chewi-':'log-concave-sampling','proof:chewi-':'log-concave-sampling'}
    domains={'concept:mcmc':'mcmc','concept:sampling':'log-concave-sampling','concept:discrete-sampling':'discrete-sampling','concept:optimization':'optimisation','concept:riemannian':'riemannian-optimization','concept:transport':'statistical-optimal-transport','concept:lower':'samplewiki'}
    for nid,n in b.nodes.items():
        scope=[direct[nid]] if nid in direct else ([domains[nid]] if nid in domains else [])
        for prefix,lib in chapter_prefixes.items():
            if nid.startswith(prefix):scope=[lib]
        if n.get('kind') in {'setting','frontier-case'}:scope=['samplewiki']
        if scope:n['library_scope']=scope;n['scope_basis']='reader / source affiliation, not exclusive ownership'
    # Only named, source-present modules receive a curated reuse scope. No guessed
    # dependency closure, no all-textbook default, no fabricated formal edges.
    for row in d['module_scope']:
        nid='module:'+row['module']
        if nid not in b.nodes:raise ValueError('Unresolved module scope '+nid)
        b.nodes[nid]['library_scope']=row['libraries'];b.nodes[nid]['scope_basis']=row['boundary']
    # A direct source-map edge is sufficient for reader affiliation, not a
    # proof of multi-source use. Do not propagate scopes through imports.
    for edge in b.edges.values():
        if edge['relation']=='formalizes' and edge['source'].startswith('decl:'):
            src=b.nodes[edge['source']];target=b.nodes[edge['target']]
            if target.get('library_scope'):
                src['library_scope']=sorted(set(src.get('library_scope',[])+target['library_scope']))
                src['scope_basis']='existing direct source-map affiliation; not exclusive ownership or new proof evidence'
    for edge in b.edges.values():
        if edge['relation']=='declares' and edge['source'].startswith('module:'):
            parent=b.nodes[edge['source']];child=b.nodes[edge['target']]
            if parent.get('library_scope') and not child.get('library_scope'):
                child['library_scope']=parent['library_scope']
                child['scope_basis']='inherits curated module scope, not verified downstream theorem use; '+parent['scope_basis']
    for n in b.nodes.values():
        if n.get('hyperedge'):
            n['library_scope']=sorted({domains[x] for x in n['hyperedge']['tails']+n['hyperedge']['heads'] if x in domains})
            n['scope_basis']='conceptual incidence scope, not compiled cross-domain use'
    for n in b.nodes.values():
        libs=n.get('library_scope',[])
        n['scope_key']='shared' if len(libs)>1 else (libs[0] if libs else 'unassigned')
        if libs:
            n['search'] += ' '+ ' '.join(libs)+' '+n.get('scope_basis','').lower()
            n.setdefault('details',[]).extend([{'label':'Library scope (curated)','value':' · '.join(d['palette'][k]['label'] for k in libs)},{'label':'Scope evidence boundary','value':n['scope_basis']}])
    return {'palette':d['palette'],'truth_contract':d['truth_contract'],'source':'website/content/sampling_perspectives.json'}
