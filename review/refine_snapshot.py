#!/usr/bin/env python3
"""Presentation-only refinements for the frozen export; no mathematical upgrades."""
import argparse, json
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('root',type=Path);ap.add_argument('source',type=Path);a=ap.parse_args()
root=a.root;source=a.source
formula=r'\begin{gathered}f(y)\ge f(x)+\langle\operatorname{grad}f(x),\log_x y\rangle\\{}+\frac{\alpha}{2}d(x,y)^2\\\alpha\text{-geodesic convexity}\\\Rightarrow\text{metric PL in its valid setting}\\CD(\alpha,\infty)\Rightarrow C_{\mathrm{LSI}}\le\alpha^{-1}\end{gathered}'
for rel in ('data/functor_hypergraph.json','data/underlying-lean-graph.json'):
 path=root/rel;data=json.loads(path.read_text())
 for edge in data['hyperedges']:
  if edge['id']=='transport:curvature-growth':edge['formula']=formula
 for node in data.get('nodes',[]):
  if node['id']=='transport:curvature-growth':
   node['formula']=formula;node['hyperedge']['formula']=formula
 path.write_text(json.dumps(data,ensure_ascii=False,indent=2)+'\n')
sampling=json.loads((source/'website/content/source_edition.json').read_text())
ot=json.loads((source/'Libraries/StatisticalOptimalTransport/source-map.json').read_text())
metadata={'note':'Bibliographic source fingerprints inherited from the frozen source audit; PDFs are not redistributed.','sampling':{k:sampling[k] for k in ('title','author','edition','canonical_url','pdf_sha256','pdf_pages')},'optimal_transport':{k:ot[k] for k in ('title','authors','source_url','source_audit_date','sha256','pdf_pages')},'optimization':{'title':'Lectures on Optimization','author':'Sinho Chewi','version':'arXiv:2605.07006v1'},'riemannian_optimization':{'title':'An Introduction to Optimization on Smooth Manifolds','author':'Nicolas Boumal','year':2023,'doi':'10.1017/9781009166164'}}
(root/'data/source-editions.json').write_text(json.dumps(metadata,ensure_ascii=False,indent=2)+'\n')
