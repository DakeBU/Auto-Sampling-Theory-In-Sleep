from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

from website.scripts import harness


class HarnessSiteTest(unittest.TestCase):
    def _make_site(self, root: Path, *, related_row: str = "") -> None:
        (root / "workflow").mkdir()
        (root / "related-systems").mkdir()
        (root / "live").mkdir()
        (root / "attribution").mkdir()
        (root / "index.html").write_text(
            '<html><body><main id="content"><section id="powered-by-astis"><h2>Old home copy</h2></section></main></body></html>',
            encoding="utf-8",
        )
        (root / "workflow" / "index.html").write_text(
            '<html><body><main id="content"><h1>Four proving layers</h1><p>upper_source_math middle_formalizer lower_2</p></main></body></html>',
            encoding="utf-8",
        )
        (root / "related-systems" / "index.html").write_text(
            '<html><body><table><tbody>' + related_row + '</tbody></table></body></html>',
            encoding="utf-8",
        )
        (root / "live" / "index.html").write_text(
            '<html><body>export into the ASTIS hierarchy</body></html>', encoding="utf-8"
        )
        (root / "attribution" / "index.html").write_text(
            '<html><body>A Hierarchical Automated Theorem Proving System for Sampling Theory</body></html>',
            encoding="utf-8",
        )

    def test_harness_page_shows_history_current_architecture_and_math_purpose(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            self._make_site(output)

            harness.enrich_site(output)
            harness.validate_site(output)

            home = (output / "index.html").read_text(encoding="utf-8")
            workflow = (output / "workflow" / "index.html").read_text(encoding="utf-8")
            related = (output / "related-systems" / "index.html").read_text(encoding="utf-8")

            self.assertIn("From proofs to verified mathematical structure", home)
            self.assertIn("Current ASTIS Harness", workflow)
            self.assertIn("Earlier role-ladder architecture", workflow)
            self.assertIn("Upper", workflow)
            self.assertIn("Middle", workflow)
            self.assertIn("Lower workers", workflow)
            self.assertIn("Reviewer", workflow)
            self.assertIn("Universal Worker", workflow)
            self.assertIn("Frontier Cells", workflow)
            self.assertIn("Thin Master", workflow)
            self.assertIn("Why not simply ask AI to write proofs?", workflow)
            self.assertIn("Lean verification", workflow)
            self.assertIn("Using the formal graph to understand the field", workflow)
            self.assertIn("terminal leaf", workflow)
            self.assertIn("create a bridge", workflow)
            self.assertIn("single stabilization lane", workflow)
            self.assertIn("FrontierAgent", related)

    def test_existing_frontieragent_row_is_replaced_without_release_branding(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            self._make_site(
                output,
                related_row=(
                    '<tr class="astis-related-old"><td>FrontierAgent</td>'
                    '<td>old release-branded row</td><td>old boundary</td></tr>'
                ),
            )

            harness.enrich_site(output)
            harness.validate_site(output)
            related = (output / "related-systems" / "index.html").read_text(encoding="utf-8")
            self.assertIn("coordinator no-progress detection", related)
            self.assertNotIn("old boundary", related)


if __name__ == "__main__":
    unittest.main()
