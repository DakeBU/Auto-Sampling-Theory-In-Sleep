from __future__ import annotations

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from astis_source import _source_page_bounds


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


if __name__ == "__main__":
    unittest.main()
