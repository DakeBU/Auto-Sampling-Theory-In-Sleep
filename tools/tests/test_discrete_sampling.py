"""Acceptance checks for a peer source library; these tests are not Lean proofs."""
import copy
import json
import sys
import unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path[:0]=[str(ROOT/'website/scripts'),str(ROOT/'tools')]
import discrete_sampling as ds
import cross_domain
import astis_frontier_cells as cells
import library_shelves
import formalization_progress

class DiscreteSamplingTests(unittest.TestCase):
    def test_source_identity_and_pagination(self):
        ds.validate_data();d=ds.load()
        self.assertEqual(d['sha256'],'3cc2f911b33bb5538157ef8a70f0c7e0f3c812ecd06dc9c1d5ea0bfdae11a52a')
        self.assertEqual(d['chapters'][2]['pdf_page'],18)
        self.assertEqual(d['chapters'][-1]['pdf_page'],90)
        self.assertEqual(d['chapters'][-1]['sections'][0]['id'],'12.1')
        self.assertEqual(d['chapters'][-1]['source_detail_status'],'cites_external')

    def test_no_scaffold_completion_or_missing_proof_flag(self):
        for mutate in [lambda d:d['chapters'][0].update(status='merged'),lambda d:d['chapters'][-1].update(source_detail_status='sufficient'),lambda d:d.update(sha256='not-pinned'),lambda d:d['planned_prerequisites'].append(['12','01'])]:
            d=ds.load();mutate(d)
            with self.assertRaises(ValueError):ds.validate_data(d)

    def example(self):
        return json.loads((ROOT/'research-wiki/frontier-cells/_discrete-example.json').read_text())

    def test_route_template_and_shared_consumer_contract(self):
        c=self.example();self.assertEqual(cells.validate_cells([c]),[])
        c['route']='shared';c['consumers']=['discrete-sampling','log-concave-sampling']
        self.assertEqual(cells.validate_cells([c]),[])
        del c['discrete_state_contract']
        self.assertTrue(any('discrete_state_contract' in e for e in cells.validate_cells([c])))

    def test_clock_pinning_and_discrete_time_gate(self):
        for key in ['clock','pinning','regime','source_proof_status','support']:
            c=self.example();del c['discrete_state_contract'][key]
            self.assertTrue(any(key in e for e in cells.validate_cells([c])))
        c=self.example();c['discrete_state_contract']['time_model']='discrete-time'
        self.assertTrue(any('aperiodicity_or_absolute_gap' in e for e in cells.validate_cells([c])))
        c['discrete_state_contract']['aperiodicity_or_absolute_gap']='Static stationarity subclaim only; no mixing conclusion.'
        self.assertEqual(cells.validate_cells([c]),[])

    def test_no_sde_or_geometry_block_on_finite_foundation(self):
        p=cross_domain.load(cross_domain.PLAN_PATH);lookup={s['id']:s for s in p['stages']}
        def ancestors(k):
            return {p for p in lookup[k]['parents']} | {a for p in lookup[k]['parents'] for a in ancestors(p)}
        self.assertFalse(ancestors('finite-dirichlet') & {'calculus','semigroup','transport','manifold','convex'})
        self.assertTrue({'kernel-algebra','scalar-decay','linear-algebra'} <= ancestors('finite-dirichlet'))
        cross_domain.validate_data()

    def test_independent_review_and_certificate_are_different_gates(self):
        m=cross_domain.load(cross_domain.FUNCTOR_PATH)
        e=next(e for e in m['hyperedges'] if e['id']=='transport:discrete-pi')
        e['review'].update(status='independently-reviewed',independent_reviewer=e['review']['proposed_by'],evidence=['review'])
        with self.assertRaisesRegex(ValueError,'self-validation'):ds.validate_data(model=m)
        e['review'].update(independent_reviewer='distinct-verifier',evidence=[])
        with self.assertRaisesRegex(ValueError,'evidence'):ds.validate_data(model=m)
        e['review']['evidence']=['source-audit-reference'];ds.validate_data(model=m)
        e['status']='Lean-certified'
        with self.assertRaises(ValueError):ds.validate_data(model=m)

    def test_all_four_bridges_have_sources_boundaries_and_no_compiled_transport(self):
        m=cross_domain.load(cross_domain.FUNCTOR_PATH);mem=cross_domain.load(cross_domain.GRAPH_MEMORY_PATH)
        present={'module:AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexFirstOrder'}
        for e in m['hyperedges']:
            if e['id'] not in {'transport:'+s for s in ds.BRIDGES}:continue
            self.assertEqual(e['review']['status'],'candidate')
            self.assertTrue(e['source_ids'] and e['failure_boundary'] and e['hypothesis_map'])
            self.assertEqual(e['formal_refs'],[])
            self.assertEqual(cross_domain.candidate_substrate_ids(e,mem,present),[])

    def test_peer_navigation_and_route(self):
        text=library_shelves.libraries_sidebar('libraries/discrete-sampling/index.html')
        self.assertEqual(text.count('class="source-hub"'),6)
        self.assertIn('Discrete Sampling',text)
        self.assertIn('discrete-sampling',formalization_progress.ROUTE_ANCHORS)
        self.assertIn('data-progress-route="discrete-sampling"',formalization_progress.overview_body())
        self.assertIn('Six routes',formalization_progress.overview_body())

    def test_no_lean_sources_added_by_scaffold(self):
        # The source map contains no formalization counters masquerading as proofs.
        for r in ds.load()['chapters']:self.assertEqual(r['status'],'scaffold')
        self.assertIn('no discrete Lean theorem',ds.load()['formalization_status'])

if __name__=='__main__':unittest.main()
