from __future__ import annotations

import unittest
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from astis_site import RegistryEntry, SourceDeclaration, validate_chapter_1_closure


class ChapterOneClosureTests(unittest.TestCase):
    def test_reused_source_row_and_missing_explicit_test_are_rejected(self) -> None:
        declaration_name = "AutoSamplingTheory.Example.proved"
        item = {
            "id": "chapter1-statement-1-2-1",
            "source_mapping_id": "shared-row",
            "source_kind": "Definition 1.2.1",
            "book_page": 10,
            "pdf_page": 22,
            "page": "book 10 / PDF 22",
            "source_url": "https://chewisinho.github.io/main.pdf#page=22",
            "local_status": "Compiled",
            "route_status": "Compiled",
        }
        source = {
            "id": "shared-row",
            "source_kind": "Definition 1.2.1",
            "book_page": 10,
            "pdf_page": 22,
            "page": "book 10 / PDF 22",
            "source_url": "https://chewisinho.github.io/main.pdf#page=22",
            "status": "compiled",
            "local_status": "compiled",
            "route_status": "compiled",
            "lean_declarations": [declaration_name],
        }
        entry = RegistryEntry(
            key="example.proved",
            local_decl=declaration_name,
            upstream_decl="",
            upstream_file="",
            status="formalizedLocal",
            tags=[],
            sald_use="",
            note="",
            source_file="AutoSamplingTheory/Example.lean",
            explicit_test=False,
        )
        declaration = SourceDeclaration(
            full_name=declaration_name,
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
        errors = validate_chapter_1_closure(
            {
                "chapter_1_completion_matrix": [item, {**item, "id": "second-item"}],
                "source_correspondence": [source],
            },
            [entry],
            {declaration_name: declaration},
        )
        self.assertTrue(any("reused 2 times" in error for error in errors))
        self.assertTrue(any("lacks an explicit test reference" in error for error in errors))


if __name__ == "__main__":
    unittest.main()
