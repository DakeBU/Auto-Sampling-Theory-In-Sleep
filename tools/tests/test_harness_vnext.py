from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

from website.scripts import harness_vnext


class HarnessVNextSiteTest(unittest.TestCase):
    def test_overlay_replaces_legacy_harness_surface(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            (output / "workflow").mkdir()
            (output / "related-systems").mkdir()
            (output / "live").mkdir()
            (output / "attribution").mkdir()
            (output / "index.html").write_text(
                '<html><body><main id="content"><section id="powered-by-astis"><h2>A hierarchical proof system maintains the library</h2></section></main></body></html>',
                encoding="utf-8",
            )
            (output / "workflow" / "index.html").write_text(
                '<html><body><main id="content"><h1>Four proving layers</h1><p>upper_source_math middle_formalizer lower_2</p></main></body></html>',
                encoding="utf-8",
            )
            (output / "related-systems" / "index.html").write_text(
                '<html><body><table><tbody><tr><td>Learning Beyond Gradients</td><td>upper planning, middle formalization, lower Lean work, and independent proof review</td></tr></tbody></table></body></html>',
                encoding="utf-8",
            )
            (output / "live" / "index.html").write_text(
                '<html><body><p>export unresolved work into the ASTIS hierarchy</p></body></html>',
                encoding="utf-8",
            )
            (output / "attribution" / "index.html").write_text(
                '<html><body><pre>title = {Auto-Sampling-Theory-In-Sleep: A Hierarchical Automated\n'
                'Theorem Proving System for Sampling Theory}</pre></body></html>',
                encoding="utf-8",
            )

            harness_vnext.enrich_site(output)
            harness_vnext.validate_site(output)

            home = (output / "index.html").read_text(encoding="utf-8")
            workflow = (output / "workflow" / "index.html").read_text(encoding="utf-8")
            related = (output / "related-systems" / "index.html").read_text(encoding="utf-8")
            live = (output / "live" / "index.html").read_text(encoding="utf-8")
            attribution = (output / "attribution" / "index.html").read_text(encoding="utf-8")
            self.assertIn("Substantive Advance Frontier Mesh", home)
            self.assertIn("Universal", workflow)
            self.assertIn("frontier cell", workflow)
            self.assertIn("NoProgressGuard", workflow)
            self.assertIn("single stabilization lane", workflow)
            self.assertIn("FrontierAgent", related)
            self.assertNotIn("upper_source_math", workflow)
            self.assertIn('id="astis-substantive-advance-export"', live)
            self.assertIn("ASTIS Substantive Advance frontier mesh", live)
            self.assertNotIn("ASTIS hierarchy", live)
            self.assertIn("A Substantive-Advance Automated", attribution)
            self.assertNotIn("A Hierarchical Automated", attribution)

    def test_existing_frontieragent_row_is_upgraded(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            (output / "workflow").mkdir()
            (output / "related-systems").mkdir()
            (output / "live").mkdir()
            (output / "attribution").mkdir()
            (output / "index.html").write_text(
                '<html><body><main id="content"></main></body></html>', encoding="utf-8"
            )
            (output / "workflow" / "index.html").write_text(
                '<html><body><main id="content"></main></body></html>', encoding="utf-8"
            )
            (output / "related-systems" / "index.html").write_text(
                '<html><body><table><tbody><tr class="astis-vnext-related"><td>FrontierAgent</td><td>old row</td><td>old boundary</td></tr></tbody></table></body></html>',
                encoding="utf-8",
            )
            (output / "live" / "index.html").write_text(
                '<html><body>Substantive Advance</body></html>', encoding="utf-8"
            )
            (output / "attribution" / "index.html").write_text(
                '<html><body>A Substantive-Advance Automated Theorem Proving System for Sampling Theory</body></html>',
                encoding="utf-8",
            )

            harness_vnext.enrich_site(output)
            harness_vnext.validate_site(output)
            related = (output / "related-systems" / "index.html").read_text(encoding="utf-8")
            self.assertIn("coordinator no-progress detection", related)
            self.assertNotIn("old boundary", related)


if __name__ == "__main__":
    unittest.main()
