"""Publication admission regressions; no fake theorem or semantic certification."""
from __future__ import annotations

import ast
import copy
import tempfile
import unittest
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch

from tools import astis_publication as p
from tools import astis_advance as advance


class PublicationTest(unittest.TestCase):
    def setUp(self):
        self.items = copy.deepcopy(p.load())
        self.data = copy.deepcopy(p.inputs())
        # Identify the source item and its two historical bindings separately:
        # new, reviewed proof components may be added to the same source item.
        self.item = next(i for i in self.items if i['id'] == 'chewi-opt-v1-prop-1-6')
        self.legacy_bindings = [b for b in self.item['bindings']
                                if b['declaration'] in p.LEGACY_NAMES]
        self.binding = self.legacy_bindings[0]
        self.name = self.binding['declaration']

    def test_current_migration_is_explicit_not_certified(self):
        self.assertEqual(p.validate(self.items, self.data), [])
        # The migration fixture remains partial as other source items are added.
        with patch.object(p, 'load', return_value=[self.item]):
            state = p.chapter_progress('optimisation', '01')
        self.assertEqual(state['status'], 'partial')
        self.assertEqual(set(state['proof_declarations']),
                         {b['declaration'] for b in self.item['bindings']})
        self.assertEqual(len(self.legacy_bindings), 2)
        self.assertFalse(state['source_complete'])
        self.assertEqual(p.chapter_progress('optimisation', '02')['status'], 'scaffold')

    def test_companion_pages_exist_before_publication_projection(self):
        tree = ast.parse((p.ROOT / 'website/scripts/build_site.py').read_text(encoding='utf-8'))
        main = next(n for n in tree.body if isinstance(n, ast.FunctionDef) and n.name == 'main')
        order = [n.value.func.value.id for n in main.body
                 if isinstance(n, ast.Expr) and isinstance(n.value, ast.Call)
                 and isinstance(n.value.func, ast.Attribute)
                 and n.value.func.attr == 'enrich_site'
                 and isinstance(n.value.func.value, ast.Name)]
        self.assertLess(order.index('samplewiki_companions'), order.index('publication_reader'))

    def test_absent_declaration_rejected(self):
        del self.data['declarations'][self.name]
        self.assertTrue(any('missing/placeholder' in e for e in p.validate(self.items, self.data)))

    def test_missing_lesson_rejected(self):
        del self.data['lessons'][self.name]
        self.assertTrue(any('authored statement' in e for e in p.validate(self.items, self.data)))

    def test_lesson_dependency_is_an_exact_declaration_not_prose(self):
        self.data['lessons'][self.name]['astis_dependencies'] = [self.name + ': description']
        self.assertTrue(any('unknown lesson dependency' in e for e in p.validate(self.items, self.data)))

    def test_source_catalog_order_does_not_select_migration_fixture(self):
        with patch.object(p, 'load', return_value=list(reversed(self.items))):
            self.setUp()
        self.assertEqual(self.item['id'], 'chewi-opt-v1-prop-1-6')
        self.assertEqual(len(self.legacy_bindings), 2)
        self.assertEqual({b['declaration'] for b in self.legacy_bindings}, p.LEGACY_NAMES)

    def test_changed_legacy_requires_real_review(self):
        errors = p.validate(self.items, self.data, strict_names={self.name})
        self.assertTrue(any('historical audit debt' in e for e in errors))

    def test_no_new_legacy_optout(self):
        self.binding['declaration'] = 'not.a.legacy.theorem'
        self.assertFalse(p.legacy_debt_valid(self.binding, self.data))

    def test_legacy_hash_is_fixed_not_user_selected(self):
        self.binding['legacy_audit_debt']['file_sha256'] = 'a' * 64
        with patch.object(p, 'file_digest', return_value='a' * 64):
            self.assertFalse(p.legacy_debt_valid(self.binding, self.data))

    def test_assumption_ledger_mandatory(self):
        self.binding['assumption_deltas'] = []
        self.assertTrue(any('assumption ledger' in e for e in p.validate(self.items, self.data)))

    def test_cannot_attach_an_unrelated_verified_cell(self):
        self.binding['cell'] = self.item['bindings'][1]['cell']
        self.assertTrue(any('canonical declaration' in e for e in p.validate(self.items, self.data)))

    def test_missing_changed_mapping_rejected(self):
        self.assertTrue(any('no publication edge' in e for e in p.validate(self.items, self.data, strict_names={'new.theorem'})))

    def test_changed_source_or_prose_invalidates_binding(self):
        before = p.binding_digest(self.item, self.binding, self.data)
        self.item['assumptions'].append('A new assumption')
        self.assertNotEqual(before, p.binding_digest(self.item, self.binding, self.data))
        self.item['assumptions'].pop()
        self.data['lessons'][self.name]['steps'][0]['text'] += ' changed explanation'
        self.assertNotEqual(before, p.binding_digest(self.item, self.binding, self.data))

    def test_stale_audit_rejected(self):
        self.binding['audit_id'] = 'fixture'
        self.data['audits']['fixture'] = {'lean': {'declaration': self.name},
                                        'publication_binding_sha256': '0' * 64, 'state': 'accepted'}
        self.assertTrue(any('stale code/source' in e for e in p.validate(self.items, self.data)))

    def test_draft_is_not_verification(self):
        self.binding['audit_id'] = 'fixture'
        self.data['audits']['fixture'] = {'lean': {'declaration': self.name},
            'publication_binding_sha256': p.binding_digest(self.item, self.binding, self.data), 'state': 'draft'}
        self.assertTrue(any('independent source review' in e for e in p.validate(self.items, self.data, strict_names={self.name})))

    def test_prerequisite_does_not_credit_a_proof(self):
        for b in self.item['bindings']:
            b['role'] = 'prerequisite'
        with patch.object(p, 'load', return_value=[self.item]), patch.object(p, 'inputs', return_value=self.data):
            state = p.chapter_progress('optimisation', '01')
            self.assertEqual(state['status'], 'prerequisite-ready')
            self.assertFalse(state['proof_declarations'])

    def test_packet_is_bounded_and_not_decoder_input(self):
        packet = p.packet(self.binding['cell'])
        self.assertEqual(len(packet['targets']), 1)
        self.assertIn('NOT decoder input', packet['boundary'])
        self.assertLess(len(str(packet)), 5000)

    def test_review_packet_changes_but_blind_decoder_stays_blind(self):
        audit = copy.deepcopy(next(iter(self.data['audits'].values())))
        blind_before = p.roundtrip.decoder_packet(audit)
        review_before = p.roundtrip.semantic_reviewer_packet(audit)['packet_sha256']
        audit['publication_binding_sha256'] = p.binding_digest(self.item, self.binding, self.data)
        audit['publication_context'] = p.review_context(self.item, self.binding, self.data)
        review_after = p.roundtrip.semantic_reviewer_packet(audit)['packet_sha256']
        self.assertNotEqual(review_before, review_after)
        self.assertEqual(blind_before, p.roundtrip.decoder_packet(audit))
        audit['publication_context']['statement'] += ' changed'
        self.assertNotEqual(review_after, p.roundtrip.semantic_reviewer_packet(audit)['packet_sha256'])

    def test_metadata_only_release_still_requires_review(self):
        with patch.object(p, 'changed_declarations', return_value=set()), patch.object(p, 'legacy_debt_valid', return_value=False):
            self.assertIn(self.name, p.release_targets('HEAD'))

    def test_definition_cannot_earn_proof_credit(self):
        self.data['declarations'][self.name].kind = 'def'
        self.assertFalse(p.verified_binding(self.binding, self.data))
        self.assertTrue(any('not a proof-edge' in e for e in p.validate(self.items, self.data)))

    def test_claimed_cell_does_not_get_proof_component_label(self):
        import publication_reader
        for b in self.item['bindings']:
            self.data['cells'][b['cell']]['status'] = 'claimed'
        with patch.object(publication_reader.publication, 'inputs', return_value=self.data):
            html = publication_reader.source_card(self.item, self.item['chapter_path'])
        self.assertNotIn('Local proof component;', html)

    def test_diff_gate_fails_closed_on_unindexed_unicode(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            path = root / 'AutoSamplingTheory' / 'Unicode.lean'
            path.parent.mkdir()
            path.write_text('theorem α : True := True.intro\n', encoding='utf-8')
            def fake_git(*args):
                return 'AutoSamplingTheory/Unicode.lean\0' if args[0] == 'diff' else ''
            with patch.object(p, 'ROOT', root), patch.object(p, 'git', side_effect=fake_git), patch.object(p, 'inputs', return_value={'declarations': {}}):
                with self.assertRaisesRegex(ValueError, 'unindexed declaration'):
                    p.changed_declarations('HEAD')

    def test_registry_metadata_exemption_does_not_hide_mathematics(self):
        file = 'AutoSamplingTheory/TechnicalLemmas/Registry.lean'
        source = ('inductive LemmaMemoryStatus where\n  | formalizedLocal\n'
                  'structure LemmaMemoryEntry where\n  key : String\n'
                  'def analysisMemory : Nat := 0\n'
                  'theorem newRegistryTheorem : 0 = 0 := rfl\n'
                  'structure NewMathematicalObject where\n  n : Nat\n'
                  'structure OtherMathematics.LemmaMemoryEntry where\n  n : Nat\n')
        specs = [(1, 'inductive', 'LemmaMemoryStatus'), (3, 'structure', 'LemmaMemoryEntry'),
                 (5, 'def', 'analysisMemory'), (6, 'theorem', 'newRegistryTheorem'),
                 (7, 'structure', 'NewMathematicalObject'),
                 (9, 'structure', 'OtherMathematics.LemmaMemoryEntry')]
        declarations = {name: SimpleNamespace(source_file=file, source_line=line,
                         kind=kind, short_name=name.rsplit('.', 1)[-1],
                         full_name=('AutoSamplingTheory.TechnicalLemmas.' + name
                                    if name in {'LemmaMemoryStatus', 'LemmaMemoryEntry'} else name))
                        for line, kind, name in specs}
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            path = root / file
            path.parent.mkdir(parents=True)
            path.write_text(source, encoding='utf-8')
            def fake_git(*args):
                return file + '\0' if args[0] == 'diff' else ''
            with patch.object(p, 'ROOT', root), patch.object(p, 'git', side_effect=fake_git), \
                 patch.object(p, 'inputs', return_value={'declarations': declarations}):
                self.assertEqual(p.changed_declarations('HEAD'),
                                 {'newRegistryTheorem', 'NewMathematicalObject',
                                  'OtherMathematics.LemmaMemoryEntry'})

    def test_multiline_attribute_and_truncated_name_do_not_bypass(self):
        for source in ('@[simp\n] theorem foo (n : Nat) : n = n := rfl\n',
                       'theorem fooα (n : Nat) : n = n := rfl\n'):
            with self.subTest(source=source), tempfile.TemporaryDirectory() as temp:
                root = Path(temp)
                file = 'AutoSamplingTheory/Edge.lean'
                path = root / file
                path.parent.mkdir()
                path.write_text(source, encoding='utf-8')
                truncated = SimpleNamespace(source_file=file, source_line=1, kind='theorem',
                                            short_name='foo', full_name='foo')
                def fake_git(*args):
                    return file + '\0' if args[0] == 'diff' else ''
                with patch.object(p, 'ROOT', root), patch.object(p, 'git', side_effect=fake_git), patch.object(p, 'inputs', return_value={'declarations': {'foo': truncated}}):
                    with self.assertRaisesRegex(ValueError, 'unindexed declaration'):
                        p.changed_declarations('HEAD')

    def test_reader_embeds_statement_proof_and_separate_lean(self):
        import publication_reader
        text = publication_reader.source_card(self.item, self.item['chapter_path'])
        self.assertEqual(text.count('data-authored-declaration='), len(self.item['bindings']))
        self.assertNotIn('<h1>', text)
        self.assertIn('pending historical audit', text)
        self.assertIn('TODO — not closed', text)
        self.assertNotIn('<details open', text)
        self.assertIn('Source assumptions versus formal assumptions', text)
        self.assertGreater(text.count('\\['), 8)

    def test_new_default_harness_schema_requires_publication(self):
        self.assertEqual(advance.ADVANCE_SCHEMA_VERSION, 4)
        evidence = {'result_kind': 'theorem-edge', 'theorem_delta': 'bounded edge',
                    'lean_files': ['X.lean'], 'lean_declarations': ['X.theorem'],
                    'focused_checks': ['passed'], 'truth_boundary': 'no downstream closure',
                    'conceptual_mirror_audit': {'status': 'none-found', 'discovery_ids': []}}
        with self.assertRaisesRegex(advance.HarnessError, 'publication_declarations'):
            advance._validate_transition_evidence('PROVED_LOCAL', evidence, schema_version=4)
        evidence['publication_declarations'] = ['another.theorem']
        with self.assertRaisesRegex(advance.HarnessError, 'exactly'):
            advance._validate_transition_evidence('PROVED_LOCAL', evidence, schema_version=4)

    def test_real_harness_gate_rejects_invented_audit(self):
        with self.assertRaises(ValueError):
            p.check_advance(['NoSuch.declaration'], reviewed=True)

    def graph_fixture(self, container_kind='library-chapter'):
        import publication_reader as reader
        from underlying_lean_graph_model import GraphBuilder
        from underlying_lean_graph_textbook import add_textbook
        names = [b['declaration'] for b in self.item['bindings']]
        module = self.data['declarations'][names[0]].module
        site = {'modules': [{'name': module, 'imports': []}],
                'declarations': [{'full_name': n, 'module': module,
                    'source_file': self.data['declarations'][n].source_file,
                    'source_line': self.data['declarations'][n].source_line} for n in names],
                'registry_declarations': [{'local_decl': n, 'status': 'formalizedLocal',
                    'card': 'theorems/example.html',
                    'dependencies': [names[0]] if n == names[1] else []} for n in names]}
        builder = GraphBuilder()
        add_textbook(builder, site)
        builder.add('chapter:fixture', container_kind, 'Fixture', status='planned',
                    url=self.item['chapter_path'])
        reader.project_graph(builder)
        graph = builder.export()
        graph['publication_inputs_sha256'] = reader.graph_input_digest()
        return reader, graph, site

    def test_contribution_graph_has_owned_nodes_and_typed_connections(self):
        reader, graph, site = self.graph_fixture()
        self.assertEqual(reader.validate_graph(graph, site, [self.item]), [])
        self.assertIn(reader.REFERENCE_EDGE, {e['relation'] for e in graph['edges']})
        self.assertNotIn('depends-on', {e['relation'] for e in graph['edges']})

    def test_contribution_missing_or_mistyped_edges_rejected(self):
        reader, graph, site = self.graph_fixture()
        for relation in ('declares', reader.REFERENCE_EDGE, reader.SOURCE_EDGE):
            with self.subTest(relation=relation):
                broken = copy.deepcopy(graph)
                broken['edges'] = [e for e in broken['edges'] if e['relation'] != relation]
                self.assertTrue(any(relation in e for e in reader.validate_graph(broken, site)))
        broken = copy.deepcopy(graph)
        for e in broken['edges']:
            if e['relation'] == reader.REFERENCE_EDGE:
                e['relation'] = 'depends-on'
        self.assertTrue(any('promotes a name scan' in e for e in reader.validate_graph(broken, site)))

    def test_paper_frontier_container_uses_the_same_publication_contract(self):
        reader, graph, site = self.graph_fixture('frontier-case')
        self.assertEqual(reader.validate_graph(graph, site, [self.item]), [])
        self.assertTrue(any(e['relation'] == reader.SOURCE_EDGE and
                            e['target'] == 'chapter:fixture' for e in graph['edges']))

    def test_contribution_missing_duplicate_stale_or_false_blue_rejected(self):
        reader, graph, site = self.graph_fixture()
        broken = copy.deepcopy(graph)
        broken['nodes'] = [n for n in broken['nodes'] if n['id'] != 'decl:' + self.name]
        self.assertTrue(any('missing declaration' in e for e in reader.validate_graph(broken, site)))
        broken = copy.deepcopy(graph)
        broken['nodes'].append(copy.deepcopy(broken['nodes'][0]))
        self.assertTrue(any('duplicate node' in e for e in reader.validate_graph(broken, site)))
        broken['publication_inputs_sha256'] = 'stale'
        self.assertTrue(any('stale' in e for e in reader.validate_graph(broken, site)))
        site['registry_declarations'][0]['status'] = 'todo'
        self.assertTrue(any('unsupported compiled' in e for e in reader.validate_graph(graph, site)))

    def test_contribution_chapter_progress_drift_rejected(self):
        reader, graph, site = self.graph_fixture()
        next(n for n in graph['nodes'] if n['id'] == 'chapter:fixture')['status'] = 'compiled'
        self.assertTrue(any('progress drift' in e for e in reader.validate_graph(graph, site)))

    def test_actual_owner_module_not_namespace(self):
        from underlying_lean_graph_model import GraphBuilder
        from underlying_lean_graph_textbook import add_textbook
        site = {'modules': [{'name': 'Actual.File'}],
                'declarations': [{'full_name': 'Other.Namespace.result', 'module': 'Actual.File'}],
                'registry_declarations': [{'local_decl': 'Other.Namespace.result'}]}
        builder = GraphBuilder()
        add_textbook(builder, site)
        self.assertIn(('module:Actual.File', 'decl:Other.Namespace.result', 'declares'), builder.edges)

    def test_bounded_graph_report_and_no_absent_output_fallback(self):
        import json
        reader, graph, site = self.graph_fixture()
        with tempfile.TemporaryDirectory() as tmp:
            out = Path(tmp)
            with self.assertRaisesRegex(ValueError, 'Build the site once'):
                p.graph_report(self.binding['cell'], out)
            (out / 'data').mkdir()
            (out / 'data/site-data.json').write_text(json.dumps(site), encoding='utf-8')
            (out / 'data/underlying-lean-graph.json').write_text(json.dumps(graph), encoding='utf-8')
            report = p.graph_report(self.binding['cell'], out)
        self.assertEqual(report['status'], 'graph coverage checked')
        self.assertEqual(len(report['contributions']), 1)
        self.assertIn('view=lean&focus=decl%3A', report['contributions'][0]['focus'])
        self.assertLess(len(json.dumps(report)), 5000)


if __name__ == '__main__':
    unittest.main()
