from __future__ import annotations

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


if __name__ == "__main__":
    unittest.main()
