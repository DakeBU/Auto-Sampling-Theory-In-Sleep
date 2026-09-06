from __future__ import annotations

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from astis_source import _semantic_source_label_present, _source_page_bounds


class SourcePageBoundsTests(unittest.TestCase):
    def test_adjacent_sections_share_a_printed_boundary_page(self) -> None:
        edition = {
            "chapters": [
                {
                    "book_page_end": 20,
                    "sections": [
                        {"id": "1.1", "book_page": 3},
                        {"id": "1.2", "book_page": 10},
                    ],
                }
            ]
        }

        self.assertEqual(_source_page_bounds(edition), {"1.1": (3, 10), "1.2": (10, 20)})


class SemanticSourceLabelTests(unittest.TestCase):
    def test_number_split_from_kind_by_formula_text_is_accepted(self) -> None:
        page = "proposition integral t 0 eta s d b s 1.1.16. if eta is progressive"
        self.assertTrue(
            _semantic_source_label_present(page, "Proposition 1.1.16", "1.1")
        )

    def test_wrong_statement_number_is_rejected(self) -> None:
        page = "proposition integral t 0 eta s d b s 1.1.15."
        self.assertFalse(
            _semantic_source_label_present(page, "Proposition 1.1.16", "1.1")
        )


if __name__ == "__main__":
    unittest.main()
