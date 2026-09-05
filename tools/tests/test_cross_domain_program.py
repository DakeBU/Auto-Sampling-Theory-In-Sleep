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
        self.assertIn('window.location.search',(ROOT/'website/static/graph-alias.js').read_text())

if __name__=='__main__':
    unittest.main()
