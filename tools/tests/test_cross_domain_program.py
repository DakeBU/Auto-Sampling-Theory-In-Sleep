"""Executable source, dependency and truth-boundary contracts (not Lean proofs)."""
from __future__ import annotations
import copy
import json
import sys
import unittest
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'website/scripts'))
sys.path.insert(0,str(ROOT/'tools'))
import cross_domain
import astis_frontier_cells

SPINE_PATH = ROOT/'Libraries/frontloaded-shared-spine.json'

class CrossDomainProgramTests(unittest.TestCase):
    def test_valid_data(self):
        cross_domain.validate_data()

    def test_ot_source_is_byte_pinned(self):
        ot=cross_domain.load(cross_domain.OT_PATH)
        self.assertRegex(ot['sha256'],r'^[0-9a-f]{64}$')
        self.assertEqual(ot['chapter_prerequisites'],[['01','02'],['01','03'],['01','04'],['01','05'],['01','07'],['05','06'],['07','08']])
        self.assertNotIn(['02','03'],ot['chapter_prerequisites'])

    def test_hyperedges_retain_multiple_inputs(self):
        model=cross_domain.load(cross_domain.FUNCTOR_PATH)
        e=next(e for e in model['hyperedges'] if e['id']=='transport:wasserstein-flow')
        self.assertEqual(e['tails'],['concept:optimization','concept:transport'])
        self.assertEqual(e['status'],'not-Lean-certified')

    def test_metric_pl_lsi_and_chi2_mirrors_are_explicit_and_distinct(self):
        model=cross_domain.load(cross_domain.FUNCTOR_PATH)
        edges={e['id']:e for e in model['hyperedges']}
        self.assertTrue({
            'transport:metric-pl','transport:curvature-growth','transport:pl-lsi','transport:pi-chi2'
        } <= set(edges))
        metric=edges['transport:metric-pl']
        self.assertEqual(metric['tails'],['concept:optimization','concept:riemannian','concept:transport'])
        self.assertEqual(metric['heads'],['concept:sampling'])
        self.assertIn('family:metric-gradient-flow',metric['family_ids'])
        lsi=edges['transport:pl-lsi']
        self.assertIn('FI',lsi['formula'])
        self.assertEqual(lsi['relation_kind'],'functional-inequality mirror')
        pi=edges['transport:pi-chi2']
        self.assertIn('chi-square',pi['mechanism'])
        self.assertEqual(pi['family_ids'],['family:l2-coercivity'])
        curvature=edges['transport:curvature-growth']
        self.assertIn('current strong-convex first-order SAU',curvature['conclusion_map'])
        for edge in (metric,lsi,pi,curvature):
            self.assertEqual(edge['status'],'not-Lean-certified')
            self.assertEqual(edge['formal_refs'],[])

    def test_graph_memory_is_stable_family_index_for_three_truth_views(self):
        memory=cross_domain.load(cross_domain.GRAPH_MEMORY_PATH)
        policy=cross_domain.load(cross_domain.MIRROR_POLICY_PATH)
        self.assertEqual(set(memory['views']),{'overview','lean','functor'})
        self.assertEqual(policy['mandatory_sau_audit']['applies_from_advance_schema'],3)
        families={row['id']:row for row in memory['families']}
        self.assertTrue({
            'family:metric-gradient-flow','family:curvature-growth','family:gap-gradient',
            'family:l2-coercivity','family:proximal-energy'
        } <= set(families))
        self.assertIn('transport:pl-lsi',families['family:gap-gradient']['functor_edges'])
        self.assertIn('transport:pi-chi2',families['family:l2-coercivity']['functor_edges'])
        self.assertTrue(families['family:gap-gradient']['do_not_conflate'])
        self.assertTrue(families['family:metric-gradient-flow']['formal_search_nodes'])

    def test_unknown_conceptual_family_is_rejected(self):
        model=cross_domain.load(cross_domain.FUNCTOR_PATH)
        model['hyperedges'][0]['family_ids']=['family:invented']
        with self.assertRaises(ValueError):
            cross_domain.validate_data(model=model)

    def test_false_certification_rejected(self):
        model=cross_domain.load(cross_domain.FUNCTOR_PATH)
        model['hyperedges'][0]['status']='Lean-certified'
        with self.assertRaises(ValueError):
            cross_domain.validate_data(model=model)

    def test_dangling_or_empty_hyperedge_rejected(self):
        for field,value in [('tails',[]),('heads',['concept:nonexistent']),('source_ids',['unknown'])]:
            model=cross_domain.load(cross_domain.FUNCTOR_PATH)
            model['hyperedges'][0][field]=value
            with self.assertRaises(ValueError):
                cross_domain.validate_data(model=model)

    def test_planned_dependency_cycles_rejected(self):
        plan=cross_domain.load(cross_domain.PLAN_PATH)
        plan['stages'][0]['parents']=['compare']
        with self.assertRaises(ValueError):
            cross_domain.validate_data(plan=plan)

    def test_upper_lower_not_serialized(self):
        plan=cross_domain.load(cross_domain.PLAN_PATH)
        lookup={s['id']:s for s in plan['stages']}
        self.assertNotIn('upper',lookup['lower']['parents'])
        self.assertNotIn('lower',lookup['upper']['parents'])
        self.assertEqual(lookup['compare']['parents'],['upper','lower'])

    def test_frontloaded_spine_is_acyclic_and_distinct_from_samplewiki(self):
        spine=json.loads(SPINE_PATH.read_text())
        self.assertEqual([x['id'] for x in spine['textbook_windows']],[
            'log-concave-sampling','optimisation','riemannian-optimization','statistical-optimal-transport'])
        self.assertNotIn('samplewiki-route',[x['id'] for x in spine['textbook_windows']])
        seen=set()
        for node in spine['nodes']:
            self.assertNotIn(node['id'],seen)
            self.assertTrue(set(node['parents']) <= seen)
            seen.add(node['id'])
        for gate in spine['integration_gates']:
            self.assertTrue(set(gate['requires']) <= seen)

    def test_frontloaded_spine_encodes_early_cross_textbook_gates(self):
        spine=json.loads(SPINE_PATH.read_text())
        gates={g['id']:g for g in spine['integration_gates']}
        self.assertIn('sf-coupling-wasserstein',gates['gate-sampling-1-3']['requires'])
        self.assertIn('sf-manifold-first-order',gates['gate-sampling-2']['requires'])
        self.assertIn('sf-empirical-concentration',gates['gate-sampling-2']['requires'])
        self.assertIn('sf-convex-duality',gates['gate-ot-1']['requires'])
        self.assertIn('sf-scalar-energy-dissipation',gates['gate-optimisation-1-2']['requires'])

    def test_pull_forward_has_no_chapter_completion_credit(self):
        spine=json.loads(SPINE_PATH.read_text())
        rules={r['from']:r for r in spine['pull_forward_rules']}
        opt=rules['Optimization Chapter 9 Fenchel duality']
        self.assertIn('No Optimization Chapter 9 completion credit',opt['status_effect'])
        boumal=rules['Boumal Chapter 3 first-order embedded geometry']
        self.assertIn('Sampling §2.5',boumal['unlocks'])

    def test_coarse_plan_includes_frontloaded_shared_stages(self):
        plan=cross_domain.load(cross_domain.PLAN_PATH)
        ids={s['id'] for s in plan['stages']}
        self.assertTrue({'linear-algebra','coupling-wasserstein','duality','semigroup','manifold','concentration'} <= ids)
        self.assertEqual(plan['frontloaded_spine'],'/Libraries/frontloaded-shared-spine.json')

    def cell(self):
        return json.loads((ROOT/'research-wiki/frontier-cells/_example.json').read_text())

    def test_new_routes_and_source_gap_validation(self):
        cell=self.cell();cell['route']='statistical-optimal-transport'
        self.assertEqual(astis_frontier_cells.validate_cells([cell]),[])
        cell['source_detail_audit']['detail_status']='omitted'
        errors=astis_frontier_cells.validate_cells([cell])
        self.assertTrue(any('exact gap' in e for e in errors))
        self.assertTrue(any('consulted background theorem' in e for e in errors))
        cell['source_detail_audit'].update(gap='missing integration by parts',consulted=[dict(source='Source X',anchor='Theorem 1',hypothesis_adapter='Requires finite moment and decay, recorded separately')])
        self.assertEqual(astis_frontier_cells.validate_cells([cell]),[])

    def test_research_route_requires_comparison_contract(self):
        cell=self.cell();cell['route']='higher-order-sampling';cell['mode']='exploratoryProof'
        errors=astis_frontier_cells.validate_cells([cell])
        self.assertTrue(any('oracle_q' in e for e in errors))
        cell['comparison_contract']={k:'explicit test contract' for k in ['potential_class','smoothness_p','oracle_q','dynamics_k','accuracy_r','metric','start','cost']}
        self.assertEqual(astis_frontier_cells.validate_cells([cell]),[])

    def test_formal_upstream_searches_required(self):
        cell=self.cell();cell['shared_floor_audit']['searched']=['some paper']
        errors=astis_frontier_cells.validate_cells([cell])
        self.assertTrue(any('mathlib' in e for e in errors))
        self.assertTrue(any('samplinglib' in e for e in errors))

    def test_renderer_reuses_peer_page_contract(self):
        text=(ROOT/'website/scripts/cross_domain.py').read_text()
        self.assertIn('shelves.index_body(',text)
        self.assertIn('shelves.chapter_body(',text)
        js=(ROOT/'website/static/underlying-lean-graph.js').read_text()
        self.assertIn('functor: new Set(["concept-domain", "concept-bridge"])',js)
        self.assertIn('ALL inputs:',js)
        self.assertIn('Conceptual families:',js)
        self.assertIn('transport:pl-lsi',js)
        self.assertIn('window.location.search',(ROOT/'website/static/graph-alias.js').read_text())

if __name__=='__main__':
    unittest.main()
