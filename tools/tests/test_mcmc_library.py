"""Seventh-reader source/route/perspective regressions; no proof certificates."""
import copy
import json
from pathlib import Path
import sys
import unittest
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'website/scripts'))
from tools import astis_frontier_cells
import mcmc_library
import sampling_perspectives
import cross_domain

class MCMCLibraryTests(unittest.TestCase):
    def test_source_inventory_and_required_companion(self):
        d=mcmc_library.validate_data()
        self.assertEqual(len(d['chapters']),6)
        self.assertEqual(sum(len(c['sections']) for c in d['chapters']),85)
        self.assertEqual(len(d['extensions']),10)
        self.assertEqual(d['sources']['mcmc-rr']['version'],'math/0404033v4')
        self.assertEqual(len(d['sources']['mcmc-rr']['sha256']),64)
        self.assertTrue(all(c['status']=='scaffold' for c in d['chapters']))
        self.assertTrue(all(e['status']=='source-backed-outline' for e in d['extensions']))
    def test_no_invented_chapter_or_extension_completion(self):
        d=mcmc_library.load();d['extensions'][0]['parent_chapter']='07'
        with self.assertRaises(ValueError):mcmc_library.validate_data(d)
        d=mcmc_library.load();d['chapters'][0]['status']='compiled'
        with self.assertRaises(ValueError):mcmc_library.validate_data(d)
    def test_no_missing_rr_or_bad_pagination(self):
        d=mcmc_library.load();del d['sources']['mcmc-rr']
        with self.assertRaises(ValueError):mcmc_library.validate_data(d)
        d=mcmc_library.load();d['chapters'][0]['pdf_page']+=1
        with self.assertRaises(ValueError):mcmc_library.validate_data(d)
    def test_candidate_review_is_not_self_review_or_certificate(self):
        model=cross_domain.load(cross_domain.FUNCTOR_PATH)
        e=next(e for e in model['hyperedges'] if e['id']=='transport:mcmc-metropolis')
        self.assertEqual(e['review']['status'],'candidate')
        e['review'].update(status='independently-reviewed',independent_reviewer=e['review']['proposed_by'],evidence=['self assertion'])
        with self.assertRaises(ValueError):cross_domain.validate_data(model=model)
        model=cross_domain.load(cross_domain.FUNCTOR_PATH)
        e=next(e for e in model['hyperedges'] if e['id']=='transport:mcmc-metropolis')
        e['status']='Lean-certified'
        with self.assertRaises(ValueError):cross_domain.validate_data(model=model)
    def cell(self):return json.loads((ROOT/'research-wiki/frontier-cells/_mcmc-example.json').read_text())
    def test_consumer_contract_applies_to_route_and_shared(self):
        for route in ['mcmc','shared']:
            d=self.cell();d['route']=route;d['consumers']=['mcmc','discrete-sampling'] if route=='shared' else []
            # Use a non-discrete consumer to isolate the MCMC contract.
            if route=='shared':d['consumers']=['mcmc','optimisation']
            self.assertEqual(astis_frontier_cells.validate_cells([d]),[])
            del d['mcmc_contract']['clock']
            self.assertTrue(any('clock' in e for e in astis_frontier_cells.validate_cells([d])))
    def test_approximation_and_periodicity_cannot_be_omitted(self):
        d=self.cell();d['mcmc_contract'].update(time_model='discrete-time',invariance_class='approximate-target')
        errors=astis_frontier_cells.validate_cells([d])
        self.assertTrue(any('bias_contract' in e for e in errors))
        self.assertTrue(any('periodicity' in e for e in errors))
    def test_shared_mcmc_cannot_evade_source_audit(self):
        d=self.cell();d.update(route='shared',consumers=['mcmc','optimisation'],schema_version=1)
        self.assertTrue(any('schema_version 2' in e for e in astis_frontier_cells.validate_cells([d])))
    def test_perspectives_are_typed_overlays(self):
        d=sampling_perspectives.validate()
        self.assertEqual(len([p for p in d['palette'].values() if 'node' in p]),7)
        self.assertEqual(d['view'],'overview:methods-targets')
        self.assertTrue(all(e['relation'].endswith('(curated)') for e in d['edges']))
        bad=copy.deepcopy(d);bad['edges'][0]['relation']='depends-on'
        with self.assertRaises(ValueError):sampling_perspectives.validate(bad)
    def test_method_target_intersections_keep_boundaries(self):
        d=sampling_perspectives.load();nodes={n['id']:n for n in d['nodes']}
        self.assertIn('biased',nodes['method:ula']['summary'])
        self.assertIn('Continuous-state',nodes['method:hitrun']['summary'])
        self.assertIn('not generally a smooth',nodes['target:convexbody']['summary'])
        self.assertEqual(set(nodes['method:glauber']['library_scope']),{'mcmc','discrete-sampling'})
        self.assertTrue(all(not(e['source'].startswith('library:') and e['target'].startswith('library:')) for e in d['edges']))
    def test_source_kernel_false_friend_and_mlsi_obstruction_retained(self):
        text=(ROOT/'docs/mcmc-library-protocol.md').read_text()
        self.assertIn('RKHS',text);self.assertIn('zero-density',text)
        self.assertTrue((ROOT/'Libraries/DiscreteSampling/reuse-audit.md').exists())
    def test_colors_do_not_change_formal_edge_whitelist(self):
        js=(ROOT/'website/static/underlying-lean-graph.js').read_text()
        self.assertIn('new Set(["imports", "declares", "depends-on", "closes leaf"])',js)
        self.assertIn('data-graph-color',js);self.assertIn('data-scope',js)
        self.assertIn('Scope evidence boundary',(ROOT/'website/scripts/sampling_perspectives.py').read_text())

if __name__=='__main__':unittest.main()
