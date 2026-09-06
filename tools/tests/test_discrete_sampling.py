"""Mutation checks for discrete-state source, shared DAG and review boundaries.

These are infrastructure/metadata tests. They do not prove a mixing theorem.
"""
from __future__ import annotations
import copy
import hashlib
import json
import sys
import unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'website/scripts'))
sys.path.insert(0,str(ROOT/'tools'))
import discrete_sampling as discrete
import cross_domain
import library_shelves
import formalization_progress
import astis_frontier_cells

class DiscreteSamplingTests(unittest.TestCase):
    def cell(self):
        return json.loads((ROOT/'research-wiki/frontier-cells/_discrete_example.json').read_text())
    def model(self):
        return cross_domain.load(cross_domain.FUNCTOR_PATH)
    def test_source_and_shared_plan_validate(self):
        discrete.validate_data();cross_domain.validate_data()
    def test_old_arxiv_version_and_wrong_authors_rejected(self):
        for key,value in [('arxiv_id','2307.13826v1'),('sha256','0'*64),('authors',['Zonghao Chen','Eric Vigoda'])]:
            source=discrete.load(discrete.SOURCE_PATH);source[key]=value
            with self.assertRaises(ValueError):discrete.validate_data(source=source)
    def test_isings_survey_cannot_be_promoted_or_gap_hidden(self):
        for key,value in [('status','merged'),('proof_detail_status','sufficient')]:
            source=discrete.load(discrete.SOURCE_PATH);source['chapters'][-1][key]=value
            with self.assertRaises(ValueError):discrete.validate_data(source=source)
    def test_source_section_map_is_complete_and_pinned(self):
        source=discrete.load(discrete.SOURCE_PATH)
        self.assertEqual(len(source['chapters']),12)
        self.assertEqual(sum(len(c['sections']) for c in source['chapters']),72)
        self.assertEqual(source['chapters'][-1]['sections'][0]['id'],'12.1')
        self.assertEqual(source['chapters'][-1]['sections'][0]['pdf_page'],90)
    def test_no_cyclic_routes_or_missing_shared_nodes(self):
        for key,value in [('parents',['DS5']),('shared_nodes',['sf-invented'])]:
            route=discrete.load(discrete.ROUTE_PATH);route['steps'][0][key]=value
            with self.assertRaises(ValueError):discrete.validate_data(route=route)
    def test_finite_foundations_must_not_wait_for_diffusion_calculus(self):
        spine=discrete.load(ROOT/'Libraries/frontloaded-shared-spine.json')
        next(n for n in spine['nodes'] if n['id']=='sf-kernel-invariance')['parents'].append('sf-calculus-gradient')
        with self.assertRaisesRegex(ValueError,'blocked by diffusion'):discrete.validate_data(spine=spine)
    def test_frontier_contract_requires_state_clock_and_cost(self):
        cell=self.cell();self.assertEqual(astis_frontier_cells.validate_cells([cell]),[])
        for key in discrete.load(discrete.ROUTE_PATH)['required_contract_fields']:
            mutation=copy.deepcopy(cell);del mutation['discrete_sampling_contract'][key]
            self.assertTrue(any(key in e for e in astis_frontier_cells.validate_cells([mutation])),key)
        cell['discrete_sampling_contract']['state_space']='continuous-state Euler'
        self.assertTrue(any('finite-state' in e for e in astis_frontier_cells.validate_cells([cell])))
    def test_new_route_cannot_downgrade_source_protocol(self):
        cell=self.cell();cell['schema_version']=1
        self.assertTrue(any('schema_version 2' in e for e in astis_frontier_cells.validate_cells([cell])))
    def test_source_gap_requires_reference_and_adapter(self):
        cell=self.cell();cell['source_detail_audit']['detail_status']='cites_external'
        self.assertTrue(any('consulted background' in e for e in astis_frontier_cells.validate_cells([cell])))
    def test_six_peers_and_six_progress_routes(self):
        side=library_shelves.libraries_sidebar('index.html')
        self.assertEqual(side.count('class="source-hub"'),6)
        self.assertEqual(len(formalization_progress.ROUTE_ANCHORS),6)
        self.assertIn('Discrete Sampling',side)
        self.assertEqual(library_shelves.six_portals().count('class="source-portal source-portal-'),6)
    def test_discrete_mirrors_cannot_self_validate_or_claim_certificates(self):
        for field,value in [('review',{'state':'validated','creator':'worker','reviewer':'worker','evidence':['self']}),('status','Lean-certified'),('formal_refs',['a claimed certificate']),('review',{})]:
            model=self.model();edge=next(e for e in model['hyperedges'] if e['id']=='transport:discrete-entropy');edge[field]=value
            with self.assertRaises(ValueError):cross_domain.validate_data(model=model)
    def test_independent_mirror_review_needs_evidence(self):
        model=self.model();edge=next(e for e in model['hyperedges'] if e['id']=='transport:discrete-transport')
        edge['review'].update(state='validated',reviewer='different-reviewer',evidence=[])
        with self.assertRaisesRegex(ValueError,'review evidence'):cross_domain.validate_data(model=model)
    def test_legacy_compiled_binding_does_not_prove_discrete_bridge(self):
        model=self.model();memory=cross_domain.load(cross_domain.GRAPH_MEMORY_PATH)
        mid='module:AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexFirstOrder'
        edge=next(e for e in model['hyperedges'] if e['id']=='transport:discrete-transport')
        self.assertNotIn(mid,cross_domain.candidate_substrate_ids(edge,memory,{mid}))
    def test_new_mirrors_remain_pending_and_no_compiled_evidence(self):
        model=self.model();edges=[e for e in model['hyperedges'] if 'concept:discrete' in e['heads']+e['tails']]
        self.assertEqual(len(edges),5)
        for e in edges:
            self.assertEqual(e['review']['state'],'candidate')
            self.assertIsNone(e['review']['reviewer'])
            self.assertEqual(e['formal_refs'],[])
        js=(ROOT/'website/static/underlying-lean-graph.js').read_text()
        self.assertIn('showProposals: false',js)
        self.assertIn('selected.delete(id)',js)
        self.assertIn('data-graph-proposals',js)
    def test_reuse_locations_and_shared_generator_declaration_exist(self):
        route=discrete.load(discrete.ROUTE_PATH)
        for name in route['reuse_audit']['local_modules']:
            self.assertTrue((ROOT/(name.replace('.','/')+'.lean')).exists())
        content=(ROOT/'AutoSamplingTheory/TechnicalLemmas/FunctionalInequalities/Generator.lean').read_text()
        for name in ['dirichletForm','SatisfiesPoincare','SatisfiesLogSobolev']:self.assertIn('def '+name,content)
    def test_peer_renderer_is_not_another_theme(self):
        text=(ROOT/'website/scripts/discrete_sampling.py').read_text()
        for api in ['shelves.index_body(','shelves.chapter_body(','astis_site.page(']:self.assertIn(api,text)
        self.assertNotIn('cdn.jsdelivr',text)
    def test_example_is_not_an_active_claim(self):
        self.assertNotIn('_discrete_example.json',[p.name for p in astis_frontier_cells.cell_paths()])

if __name__=='__main__':unittest.main()
