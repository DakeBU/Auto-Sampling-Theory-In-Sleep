"""Unit checks for the prototype; no Lean or site build is involved."""
import copy
import json
import unittest
import sys
from pathlib import Path
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'website/scripts'))
sys.path.insert(0, str(ROOT / 'tools'))

from metadata_reader import MetadataReader, Rejected, digest, render_html, tokenize
import metadata_lessons


CORE = '''structure SourceAnchor where
  key : String
  kind : SourceKind
  pathOrUrl : String
  label : String
  note : String
deriving Repr, DecidableEq
structure ProofObligation where
  id : String
  statement : String
  source : SourceAnchor
  status : ProofStatus := ProofStatus.obligation
  dependsOn : List String := []
  note : String := ""
deriving Repr, DecidableEq
'''


def fixture(codes, mutate_audit=None):
    """Synthetic review snapshot, not permission to extend the production one."""
    entries, declarations, lines = [], [], []
    for name, type_text, shape, value in codes:
        signature = f"def {name} : {type_text} {shape}"
        code = signature + "\n" + value
        entries.append({"name": name, "qualified_name": "AutoSamplingTheory.SALD." + name,
                        "result_type": type_text, "normalized_full_signature": signature,
                        "declaration_sha256": digest(code.encode())})
        declarations.append({"full_name": "AutoSamplingTheory.SALD." + name, "kind": "def",
                             "source_file": "AutoSamplingTheory/SALD.lean",
                             "source_line": len(lines) + 1, "source_text": code})
        lines.extend(code.splitlines() + [""])
    core = [{"name": "SourceAnchor", "exact_schema": CORE[:CORE.index("structure ProofObligation")].strip()},
            {"name": "ProofObligation", "exact_schema": CORE[CORE.index("structure ProofObligation"):].strip()},
            {"name": "SourceKind", "exact_schema": "inductive SourceKind where\n  | localTex\n  | mathlib\nderiving Repr, DecidableEq"},
            {"name": "ProofStatus", "exact_schema": "inductive ProofStatus where\n  | obligation\n  | formalized\n  | planned\nderiving Repr, DecidableEq"}]
    audit = {"snapshot": {"source_path": "AutoSamplingTheory/SALD.lean"},
             "matched_definitions": entries, "local_record_schemas": [], "core_exact_definitions": core,
             "core_field_semantics": {
                 "ProofObligation": {"statement": "Desired content as String, not a proposition in Prop.",
                                     "status": "Stored status only, not compilation evidence.",
                                     "dependsOn": "Declared names, not the compiled dependency DAG."},
                 "local_schema_fields": {"String": "Descriptive text, not a proof.",
                                         "SourceAnchor": "Provenance pointer, not certification.",
                                         "List String": "Ordered text data."}}}
    if mutate_audit:
        mutate_audit(audit)
    audit_bytes = json.dumps(audit).encode()
    sources = {"AutoSamplingTheory/SALD.lean": "\n".join(lines).encode(),
               "AutoSamplingTheory/Core.lean": CORE.encode()}
    manifest = {"schema_version": 1, "reader_version": "test-fixture", "digest_mode": "utf8-lf-v1",
                "audit_sha256": digest(audit_bytes), "source_sha256": {p: digest(b) for p, b in sources.items()},
                "expected_definitions": len(entries), "expected_local_schemas": len(audit["local_record_schemas"]),
                "namespace": "AutoSamplingTheory.SALD"}
    return manifest, audit_bytes, sources, declarations


ANCHOR = ("anchor", "SourceAnchor", ":=", 'localTexAnchor "paper" "paper/main.tex" "lemma:1" "Recorded source only"')
OBLIGATION = ("item", "ProofObligation", "where", '  id := "item"\n  statement := "P implies Q"\n  source := anchor')


class MetadataReaderTests(unittest.TestCase):
    def test_public_gate_checks_rows_and_exact_content_not_just_labels(self):
        name = 'AutoSamplingTheory.SALD.testRecord'
        unit = {'declaration': name, 'resolution': 'unresolved', 'reason': 'review needed'}
        data = {'reader_version': 'fixture', 'audited': 1, 'explained': 0, 'unresolved': 1, 'mathematical_proofs_added': 0, 'lessons': [unit]}
        exact = metadata_reader_boundary = __import__('metadata_reader').BOUNDARY
        exact += '<article>Exact construction and source</article>'
        files = {'data/metadata-exposition.json': json.dumps(metadata_lessons.public_ledger(data)), metadata_lessons.lesson_path(name): exact}
        class VirtualPath:
            def __init__(self, value=''):
                self.value = value
            def __truediv__(self, value):
                return VirtualPath((self.value + '/' + str(value)).lstrip('/'))
            def is_file(self):
                return self.value in files
            def read_text(self, **_):
                return files[self.value]
        with patch.object(metadata_lessons, 'report', return_value=data), patch.object(metadata_lessons, 'render_unit', return_value=exact):
            self.assertEqual(metadata_lessons.validate_site(VirtualPath()), [])
            tampered = metadata_lessons.public_ledger(data)
            tampered['declarations'][0].update(resolution='resolved', reason=None, page='wrong.html')
            files['data/metadata-exposition.json'] = json.dumps(tampered)
            self.assertTrue(any('ledger drift' in x for x in metadata_lessons.validate_site(VirtualPath())))
            files['data/metadata-exposition.json'] = json.dumps(metadata_lessons.public_ledger(data))
            files[metadata_lessons.lesson_path(name)] = metadata_reader_boundary + 'Lean statement of this data definition Exact Lean data construction'
            self.assertTrue(any('exact construction/source drift' in x for x in metadata_lessons.validate_site(VirtualPath())))

    def test_line_ended_prefix_is_not_the_complete_declaration(self):
        item = (*OBLIGATION[:3], OBLIGATION[3] + '\n  status := .formalized\n  note := "explicit"')
        args = fixture([ANCHOR, item])
        declarations = copy.deepcopy(args[3])
        declarations[1]['source_text'] = declarations[1]['source_text'].split('\n  status :=')[0]
        with self.assertRaisesRegex(Rejected, 'body drift or truncation'):
            MetadataReader(args[0], args[1], args[2], declarations)

    def test_linux_windows_checkout_newlines_only_are_portable(self):
        args = fixture([ANCHOR, OBLIGATION])
        windows = {p: b.replace(b'\n', b'\r\n') for p, b in args[2].items()}
        reader = MetadataReader(args[0], args[1], windows, args[3])
        self.assertEqual(reader.explain('AutoSamplingTheory.SALD.item')['resolution'], 'resolved')
        windows['AutoSamplingTheory/Core.lean'] += b' '
        with self.assertRaisesRegex(Rejected, 'snapshot drift'):
            MetadataReader(args[0], args[1], windows, args[3])

    def test_record_defaults_are_real_defaults_not_proofs(self):
        reader = MetadataReader(*fixture([ANCHOR, OBLIGATION]))
        lesson = reader.explain("AutoSamplingTheory.SALD.item")
        self.assertEqual(lesson["resolution"], "resolved")
        fields = {f["name"]: f for f in lesson["construction"]["fields"]}
        self.assertEqual(fields["status"]["origin"], "schema-default")
        self.assertEqual(fields["status"]["value"]["label"], "obligation")
        self.assertEqual(fields["dependsOn"]["value"]["items"], [])
        self.assertEqual(fields["note"]["value"]["text"], "")
        self.assertEqual(fields["statement"]["type"], "String")
        self.assertIn("not a proposition", fields["statement"]["meaning"])
        self.assertFalse(lesson["mathematical_proof_evidence"])

    def test_formalized_does_not_set_proof_or_status_evidence(self):
        item = (*OBLIGATION[:3], OBLIGATION[3] + '\n  status := ProofStatus.formalized\n  dependsOn := ["fakeTheorem"]')
        lesson = MetadataReader(*fixture([ANCHOR, item])).explain("AutoSamplingTheory.SALD.item")
        rendered = render_html(lesson)
        self.assertIn("stored label only; no proof certification", rendered)
        self.assertIn("fakeTheorem", rendered)
        self.assertFalse(lesson["compiled_dependency_evidence"])
        self.assertFalse(lesson["proof_status_evidence"])
        self.assertNotIn("class=\"compiled", rendered)

    def test_prop_or_proof_field_is_never_metadata(self):
        for type_text in ("Prop", "Nat", "String → Prop"):
            with self.assertRaises(Rejected):
                MetadataReader(*fixture([("bad", type_text, ":=", '"not a proof"')]))
        def add_prop(audit):
            audit["local_record_schemas"] = [{"name": "Record", "qualified_name": "AutoSamplingTheory.SALD.Record",
                                               "fields": [{"name": "claim", "type": "Prop", "default": ""}]}]
        with self.assertRaises(Rejected):
            MetadataReader(*fixture([("bad", "Record", "where", "  claim := True")], add_prop))

    def test_drift_is_global_fail_closed(self):
        args = fixture([ANCHOR])
        sources = dict(args[2])
        sources["AutoSamplingTheory/Core.lean"] += b"\n"
        with self.assertRaisesRegex(Rejected, "snapshot drift"):
            MetadataReader(args[0], args[1], sources, args[3])
        with self.assertRaisesRegex(Rejected, "audit manifest drift"):
            MetadataReader(args[0], args[1] + b" ", args[2], args[3])
        declarations = copy.deepcopy(args[3])
        declarations[0]["kind"] = "theorem"
        with self.assertRaises(Rejected):
            MetadataReader(args[0], args[1], args[2], declarations)
        declarations = copy.deepcopy(args[3])
        declarations[0]["source_text"] += " changed"
        with self.assertRaises(Rejected):
            MetadataReader(args[0], args[1], args[2], declarations)

    def test_case_sensitive_stable_ids_and_unique_inventory(self):
        args = fixture([("Foo", "String", ":=", '"a"'), ("foo", "String", ":=", '"b"')])
        reader = MetadataReader(*args)
        self.assertNotEqual(reader.explain("AutoSamplingTheory.SALD.Foo")["id"], reader.explain("AutoSamplingTheory.SALD.foo")["id"])
        with self.assertRaises(Rejected):
            MetadataReader(args[0], args[1], args[2], args[3] + args[3][:1])
        with self.assertRaises(Rejected):
            MetadataReader(args[0], args[1], args[2], args[3][:1])

    def test_unknown_expression_is_unresolved_with_own_safe_source(self):
        for expression in ('if true then "a" else "b"', 'by exact "a"', 'xs.map (fun x => x)', '{ anchor with note := "x" }'):
            lesson = MetadataReader(*fixture([ANCHOR, ("unknown", "String", ":=", expression)])).explain("AutoSamplingTheory.SALD.unknown")
            self.assertEqual(lesson["resolution"], "unresolved")
            self.assertIn(expression, lesson["lean_source"])
            self.assertNotIn("construction", lesson)
        for tail in ('\n  source := anchor\n  strange := "x"', '\n  source := anchor\n  id := "duplicate"'):
            item = ("item", "ProofObligation", "where", '  id := "x"\n  statement := "x"' + tail)
            self.assertEqual(MetadataReader(*fixture([ANCHOR, item])).explain("AutoSamplingTheory.SALD.item")["resolution"], "unresolved")

    def test_lexing_nested_comments_escapes_and_html_inertness(self):
        value = r'  /- outer /- := inner -/ ignored -/ "<script>alert(1)</script> \"quoted\"" -- trailing'
        lesson = MetadataReader(*fixture([("safe", "String", ":=", value)])).explain("AutoSamplingTheory.SALD.safe")
        self.assertEqual(lesson["resolution"], "resolved")
        rendered = render_html(lesson)
        self.assertNotIn("<script>", rendered)
        self.assertIn("&lt;script&gt;", rendered)
        self.assertIn("Exact Lean data construction", rendered)
        self.assertLess(rendered.index("Data definition"), rendered.index("<details"))
        with self.assertRaises(Rejected):
            tokenize('/- no closing comment')

    def test_absolute_location_withheld_and_references_not_expanded(self):
        root = ("root", "String", ":=", '"/home/example/private/paper"')
        anchor = ("anchor", "SourceAnchor", ":=", 'localTexAnchor "paper" (root ++ "/appendix.tex") "lemma" "note"')
        reader = MetadataReader(*fixture([root, anchor]))
        hidden, safe = reader.explain("AutoSamplingTheory.SALD.root"), reader.explain("AutoSamplingTheory.SALD.anchor")
        self.assertEqual(hidden["resolution"], "unresolved")
        self.assertIsNone(hidden["lean_source"])
        self.assertNotIn("/home/", render_html(hidden))
        self.assertEqual(safe["resolution"], "resolved")
        self.assertNotIn("/home/", render_html(safe))
        path = next(f for f in safe["construction"]["fields"] if f["name"] == "pathOrUrl")["value"]
        self.assertEqual(path["kind"], "concat")
        self.assertFalse(path["evaluated"])
        for value in ('"Recorded location /data"', '"relative" /- location /volume/private -/', r'"C:\\private\\paper"'):
            unsafe = MetadataReader(*fixture([("unsafe", "String", ":=", value)])).explain("AutoSamplingTheory.SALD.unsafe")
            self.assertIsNone(unsafe["lean_source"])

    def test_local_string_default_and_helper_fixed_kind(self):
        def add_record(audit):
            audit["local_record_schemas"] = [{"name": "Record", "qualified_name": "AutoSamplingTheory.SALD.Record",
                "fields": [{"name": "label", "type": "String", "default": '"literal default"'},
                           {"name": "status", "type": "ProofStatus", "default": "ProofStatus.planned"}]}]
        reader = MetadataReader(*fixture([ANCHOR, ("data", "Record", "where", '  status := .formalized')], add_record))
        lesson = reader.explain("AutoSamplingTheory.SALD.data")
        self.assertEqual(lesson["resolution"], "resolved")
        fields = {f["name"]: f for f in lesson["construction"]["fields"]}
        self.assertEqual(fields["label"]["origin"], "schema-default")
        self.assertEqual(fields["label"]["value"]["text"], "literal default")
        source = reader.explain("AutoSamplingTheory.SALD.anchor")
        kind = next(f for f in source["construction"]["fields"] if f["name"] == "kind")
        self.assertEqual(kind["origin"], "helper-fixed")

    def test_list_records_keep_defaults_in_each_item(self):
        first = '{ id := "a", statement := "A", source := anchor }'
        second = '{ id := "b", statement := "B", source := anchor, status := ProofStatus.formalized }'
        reader = MetadataReader(*fixture([ANCHOR, ("items", "List ProofObligation", ":=", '[' + first + ', ' + second + ']')]))
        lesson = reader.explain("AutoSamplingTheory.SALD.items")
        self.assertEqual(lesson["resolution"], "resolved")
        statuses = [next(f for f in item["fields"] if f["name"] == "status") for item in lesson["construction"]["items"]]
        self.assertEqual([s["origin"] for s in statuses], ["schema-default", "explicit"])
        self.assertFalse(lesson["proof_status_evidence"])

    def test_lists_and_concat_keep_construction_not_computed_result(self):
        items = [("first", "List String", ":=", '["a", "b"]'),
                 ("both", "List String", ":=", 'first ++ ["c"]')]
        lesson = MetadataReader(*fixture(items)).explain("AutoSamplingTheory.SALD.both")
        self.assertEqual(lesson["resolution"], "resolved")
        self.assertEqual(lesson["construction"]["parts"][0]["kind"], "reference")
        self.assertFalse(lesson["construction"]["evaluated"])


if __name__ == "__main__":
    unittest.main()
