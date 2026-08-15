from __future__ import annotations

import json
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from astis_site import (
    RegistryEntry,
    SourceDeclaration,
    validate_chapter_1_evidence,
)


DECLARATION_NAME = "AutoSamplingTheory.Example.proved"
ROOT = Path(__file__).resolve().parents[2]
RIGOROUS_REFERENCES = ROOT / "website" / "static" / "rigorous-references.json"
RIGOROUS_LESSONS = ROOT / "website" / "static" / "rigorous-lessons.json"


def planned_item(index: int) -> dict[str, object]:
    return {
        "id": f"chapter1-statement-{index}",
        "source_route_id": f"chewi-chapter1-statement-{index}",
        "source_correspondence_id": "",
        "source_kind": f"Statement {index}",
        "book_page": 3,
        "pdf_page": 15,
        "page": "book 3 / PDF 15",
        "source_url": "https://chewisinho.github.io/main.pdf#page=15",
        "coverage_kind": "proved_theorem",
        "coverage_status": "planned",
        "required_declarations": [],
        "focused_tests": [],
        "registry_keys": [],
        "residual_blockers": ["Lean proof not yet implemented."],
    }


def matrix() -> list[dict[str, object]]:
    return [planned_item(index) for index in range(1, 126)]


def declaration() -> SourceDeclaration:
    return SourceDeclaration(
        full_name=DECLARATION_NAME,
        short_name="proved",
        kind="theorem",
        module="AutoSamplingTheory.Example",
        source_file="AutoSamplingTheory/Example.lean",
        source_line=1,
        source_text="theorem proved : True := by simp",
        docstring="",
        anchor="decl-proved",
        has_placeholder=False,
        placeholder_tokens=[],
    )


def registry_entry() -> RegistryEntry:
    return RegistryEntry(
        key="example.proved",
        local_decl=DECLARATION_NAME,
        upstream_decl="",
        upstream_file="",
        status="formalizedLocal",
        tags=[],
        sald_use="",
        note="",
        source_file="AutoSamplingTheory/Example.lean",
        explicit_test=False,
    )


class ChapterOneEvidenceTests(unittest.TestCase):
    def test_duplicate_source_route_is_rejected(self) -> None:
        items = matrix()
        items[1]["source_route_id"] = items[0]["source_route_id"]
        errors = validate_chapter_1_evidence(
            {"chapter_1_completion_matrix": items, "source_correspondence": []},
            [],
            {},
        )
        self.assertTrue(any("source route is reused 2 times" in error for error in errors))

    def test_complete_item_without_focused_test_is_rejected(self) -> None:
        items = matrix()
        items[0].update(
            {
                "source_correspondence_id": "source-row",
                "coverage_status": "complete",
                "required_declarations": [DECLARATION_NAME],
                "registry_keys": ["example.proved"],
                "residual_blockers": [],
            }
        )
        source = {
            "id": "source-row",
            "source_kind": items[0]["source_kind"],
            "book_page": 3,
            "pdf_page": 15,
            "page": "book 3 / PDF 15",
            "source_url": "https://chewisinho.github.io/main.pdf#page=15",
            "status": "compiled",
            "local_status": "compiled",
            "route_status": "compiled",
        }
        errors = validate_chapter_1_evidence(
            {"chapter_1_completion_matrix": items, "source_correspondence": [source]},
            [registry_entry()],
            {DECLARATION_NAME: declaration()},
        )
        self.assertIn(
            "chapter1-statement-1: complete item has no focused test",
            errors,
        )

    def test_strict_gate_rejects_partial_and_planned_items(self) -> None:
        items = matrix()
        items[0]["coverage_status"] = "partial"
        errors = validate_chapter_1_evidence(
            {"chapter_1_completion_matrix": items, "source_correspondence": []},
            [],
            {},
            require_complete=True,
        )
        self.assertTrue(any("coverage status is partial" in error for error in errors))
        self.assertTrue(any("coverage status is planned" in error for error in errors))

    def test_compiled_metadata_alone_cannot_close_an_item(self) -> None:
        items = matrix()
        items[0].update(
            {
                "source_correspondence_id": "source-row",
                "coverage_status": "complete",
                "residual_blockers": [],
            }
        )
        source = {
            "id": "source-row",
            "source_kind": items[0]["source_kind"],
            "book_page": 3,
            "pdf_page": 15,
            "page": "book 3 / PDF 15",
            "source_url": "https://chewisinho.github.io/main.pdf#page=15",
            "status": "compiled",
            "local_status": "compiled",
            "route_status": "compiled",
        }
        errors = validate_chapter_1_evidence(
            {"chapter_1_completion_matrix": items, "source_correspondence": [source]},
            [],
            {},
        )
        self.assertTrue(any("no required declaration" in error for error in errors))
        self.assertTrue(any("no focused test" in error for error in errors))
        self.assertTrue(any("no Registry key" in error for error in errors))


class RigorousReferenceTests(unittest.TestCase):
    def test_rigorous_reference_asset_has_auditable_structure(self) -> None:
        data = json.loads(RIGOROUS_REFERENCES.read_text(encoding="utf-8"))
        self.assertEqual(data.get("schema_version"), 1)
        entries = data.get("entries")
        self.assertIsInstance(entries, list)
        self.assertGreater(len(entries), 0)

        ids: set[str] = set()
        for entry in entries:
            self.assertIsInstance(entry, dict)
            entry_id = str(entry.get("id", ""))
            self.assertTrue(entry_id)
            self.assertNotIn(entry_id, ids)
            ids.add(entry_id)

            source_items = entry.get("source_items")
            declarations = entry.get("declarations")
            additions = entry.get("astis_additions")
            references = entry.get("references")
            self.assertIsInstance(source_items, list)
            self.assertGreater(len(source_items), 0)
            self.assertIsInstance(declarations, list)
            self.assertGreater(len(declarations), 0)
            self.assertIsInstance(additions, list)
            self.assertGreater(len(additions), 0)
            self.assertIsInstance(references, list)
            self.assertGreater(len(references), 0)

            urls: set[str] = set()
            for reference in references:
                self.assertIsInstance(reference, dict)
                for field in ("kind", "label", "url", "note"):
                    self.assertTrue(str(reference.get(field, "")).strip())
                url = str(reference["url"])
                self.assertTrue(url.startswith("https://"))
                self.assertNotIn(url, urls)
                urls.add(url)

    def test_stochastic_localization_points_to_original_and_formal_sources(self) -> None:
        data = json.loads(RIGOROUS_REFERENCES.read_text(encoding="utf-8"))
        entries = {entry["id"]: entry for entry in data["entries"]}
        ito = entries["chapter-1-ito-integral-localization"]
        kinds = {reference["kind"] for reference in ito["references"]}
        labels = " ".join(reference["label"] for reference in ito["references"])
        self.assertIn("original paper", kinds)
        self.assertIn("classic textbook", kinds)
        self.assertIn("formal library", kinds)
        self.assertIn("Kiyosi Itô", labels)
        self.assertIn("Mathlib", labels)


class RigorousLessonTests(unittest.TestCase):
    def test_rigorous_lessons_contain_formulas_proof_steps_and_lean_nodes(self) -> None:
        data = json.loads(RIGOROUS_LESSONS.read_text(encoding="utf-8"))
        self.assertEqual(data.get("schema_version"), 1)
        entries = data.get("entries")
        self.assertIsInstance(entries, list)
        self.assertGreaterEqual(len(entries), 2)

        ids: set[str] = set()
        for entry in entries:
            self.assertIsInstance(entry, dict)
            entry_id = str(entry.get("id", ""))
            self.assertTrue(entry_id)
            self.assertNotIn(entry_id, ids)
            ids.add(entry_id)
            self.assertTrue(str(entry.get("source_item", "")))
            self.assertTrue(str(entry.get("scope_note", "")))
            declarations = entry.get("declarations")
            formulas = entry.get("formula_latex")
            steps = entry.get("proof_steps")
            self.assertIsInstance(declarations, list)
            self.assertGreater(len(declarations), 0)
            self.assertIsInstance(formulas, list)
            self.assertGreater(len(formulas), 0)
            self.assertTrue(all("\\[" in formula and "\\]" in formula for formula in formulas))
            self.assertIsInstance(steps, list)
            self.assertGreater(len(steps), 0)
            for step in steps:
                self.assertTrue(str(step.get("title", "")).strip())
                self.assertTrue(str(step.get("body", "")).strip())
                nodes = step.get("lean_nodes")
                self.assertIsInstance(nodes, list)
                self.assertGreater(len(nodes), 0)
                self.assertTrue(all(str(node).startswith("AutoSamplingTheory.") for node in nodes))

    def test_localization_lesson_preserves_open_1_1_16_boundary(self) -> None:
        data = json.loads(RIGOROUS_LESSONS.read_text(encoding="utf-8"))
        text = json.dumps(data, ensure_ascii=False)
        self.assertIn("does not by itself close Proposition 1.1.16", text)
        self.assertIn("does not yet prove that stochastic integration commutes", text)
        self.assertIn("grid-valued stopping", text)


if __name__ == "__main__":
    unittest.main()
