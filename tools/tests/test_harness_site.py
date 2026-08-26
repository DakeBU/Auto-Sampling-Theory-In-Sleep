from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

from website.scripts import harness


ROOT = Path(__file__).resolve().parents[2]


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

    def test_harness_page_is_visual_first(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            self._make_site(output)

            harness.enrich_site(output)
            harness.validate_site(output)

            home = (output / "index.html").read_text(encoding="utf-8")
            workflow = (output / "workflow" / "index.html").read_text(encoding="utf-8")
            related = (output / "related-systems" / "index.html").read_text(encoding="utf-8")

            self.assertIn("astis-formal-graph-value.svg", home)
            self.assertIn("astis-harness-evolution.svg", workflow)
            self.assertIn("astis-formal-graph-value.svg", workflow)
            self.assertIn("Harness architecture", workflow)
            self.assertIn("Why the formal graph matters", workflow)
            self.assertGreaterEqual(workflow.count("<img "), 2)
            self.assertNotIn("<pre", workflow)
            self.assertLessEqual(workflow.count("<p>"), 3)
            self.assertIn("FrontierAgent", related)

    def test_samplinglib_architecture_uses_current_harness(self) -> None:
        architecture = (ROOT / "website" / "static" / "samplinglib-architecture.svg").read_text(
            encoding="utf-8"
        )
        for required in (
            "Substantive Advance Board",
            "Frontier Cells",
            "Universal Workers",
            "Thin Master",
            "Independent verification",
            "Single stabilization lane",
            "Underlying Lean Graph",
        ):
            self.assertIn(required, architecture)
        self.assertNotIn(">UPPER<", architecture)
        self.assertNotIn(">MIDDLE<", architecture)
        self.assertNotIn(">LOWER<", architecture)
        self.assertNotIn("HIERARCHICAL PROVING SYSTEM", architecture)

    def test_existing_frontieragent_row_is_replaced(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            self._make_site(
                output,
                related_row=(
                    '<tr class="astis-related-old"><td>FrontierAgent</td>'
                    '<td>old row</td><td>old boundary</td></tr>'
                ),
            )

            harness.enrich_site(output)
            harness.validate_site(output)
            related = (output / "related-systems" / "index.html").read_text(encoding="utf-8")
            self.assertIn("coordinator no-progress detection", related)
            self.assertNotIn("old boundary", related)


if __name__ == "__main__":
    unittest.main()
