"""Reader integrity, not an independent mathematical/source certification."""
import copy
import sys
import unittest
from pathlib import Path
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[2]
sys.path[:0] = [str(ROOT / "website/scripts"), str(ROOT / "tools")]
import proof_readers as reader


class ProofReaderTests(unittest.TestCase):
    def setUp(self):
        self.items = reader.load_items()
        names = {n for i in self.items for n in i['declarations'] + i['astis_dependencies']}
        self.data = {'gate': {'passed': True}, 'declarations': [
            {'full_name': n, 'local_status': 'Compiled', 'has_placeholder': False,
             'registry_status': ''} for n in names]}

    def test_all_steps_have_equations_and_lean_correspondence(self):
        self.assertEqual(len(self.items), 3)
        self.assertEqual(sum(len(i['steps']) for i in self.items), 13)
        for item in self.items:
            self.assertTrue((ROOT / item['test']).is_file())
            for step in item['steps']:
                self.assertTrue(all(step[k] for k in ('text', 'formula', 'lean')))

    def test_fisher_source_mismatch_cannot_be_hidden_by_compilation(self):
        ev = reader.evidence(self.items[0], self.data)
        self.assertTrue(ev['compiled'])
        self.assertEqual(ev['source_verdict'], 'domain-mismatch')
        self.assertEqual(ev['source_review'], 'needs-revision')
        self.assertEqual(ev['registry_entries'], 0)

    def test_stale_gate_cannot_be_blue(self):
        self.data['gate']['passed'] = False
        self.assertFalse(reader.evidence(self.items[0], self.data)['compiled'])

    def test_placeholder_cannot_be_blue(self):
        name = self.items[0]['declarations'][0]
        next(d for d in self.data['declarations'] if d['full_name'] == name)['has_placeholder'] = True
        self.assertFalse(reader.evidence(self.items[0], self.data)['compiled'])

    def test_noncompiled_declaration_cannot_be_blue(self):
        name = self.items[0]['declarations'][0]
        next(d for d in self.data['declarations'] if d['full_name'] == name)['local_status'] = 'Partial'
        self.assertFalse(reader.evidence(self.items[0], self.data)['compiled'])

    def test_unknown_decl_is_an_error_not_a_search_fallback(self):
        item = copy.deepcopy(self.items[0])
        item['declarations'].append('Invented.theorem')
        with self.assertRaisesRegex(ValueError, 'unknown declaration'):
            reader.evidence(item, self.data)

    def test_invalid_metadata_is_rejected(self):
        items = copy.deepcopy(self.items)
        items[0]['steps'][0]['formula'] = ''
        with patch.object(reader, 'read_json', return_value=items):
            with self.assertRaisesRegex(ValueError, 'incomplete proof step'):
                reader.load_items()

    def test_mathlib_urls_pin_real_source_files_and_lines(self):
        prefix = 'https://github.com/leanprover-community/mathlib4/blob/'
        for item in self.items:
            for dep in item['mathlib_dependencies']:
                self.assertTrue(dep['url'].startswith(prefix))
                sha, path = dep['url'][len(prefix):].split('/', 1)
                self.assertEqual(sha, 'db584cd6d46c92f209a44c0f1c829460d327499d')
                file, line = path.split('#L')
                local = ROOT / '.lake/packages/mathlib' / file
                if local.exists():
                    source_line = local.read_text(encoding='utf-8').splitlines()[int(line)-1]
                    self.assertIn(dep['name'].rsplit('.', 1)[-1], source_line)

    def test_local_and_external_sources_use_distinct_commit_pins(self):
        check = reader.base.source_commit_link_error
        root = 'https://github.com/DakeBU/Auto-Sampling-Theory-In-Sleep'
        commit = 'a' * 40
        self.assertIsNone(check(root + '/blob/' + commit + '/A.lean', commit, root))
        self.assertIsNotNone(check(root + '/blob/main/A.lean', commit, root))
        self.assertIsNotNone(check(root + '/blob/' + 'b'*40 + '/A.lean', commit, root))
        external = 'https://github.com/leanprover-community/mathlib4/blob/'
        self.assertIsNone(check(external + 'b'*40 + '/A.lean', commit, root))
        self.assertIsNotNone(check(external + 'master/A.lean', commit, root))


if __name__ == '__main__':
    unittest.main()
