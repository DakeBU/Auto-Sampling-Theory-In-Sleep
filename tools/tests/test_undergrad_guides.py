from __future__ import annotations

import json
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "website" / "scripts"))

import undergrad_guides  # noqa: E402


class UndergradGuideTests(unittest.TestCase):
    def test_render_contains_story_vocab_and_scope_boundary(self) -> None:
        guide = {
            "audience": "beginner",
            "question": "Why?",
            "promise": "Understand the route.",
            "before_you_start": ["basic calculus"],
            "story": [{"title": "Step", "intuition": "Idea", "tiny_example": "Example", "remember": "Key"}],
            "vocabulary": [["term", "plain meaning"]],
        }
        html = undergrad_guides.render_guide("1.1", guide)
        self.assertIn("story-ladder", html)
        self.assertIn("Tiny example", html)
        self.assertIn("Only remember this for now", html)
        self.assertIn("vocabulary-grid", html)
        self.assertIn("Three-layer rule", html)

    def test_unwrapped_math_detection(self) -> None:
        self.assertTrue(undergrad_guides.find_unwrapped_math("At time B_t"))
        self.assertTrue(undergrad_guides.find_unwrapped_math("Use the L2 norm"))
        self.assertEqual(undergrad_guides.find_unwrapped_math(r"At time \(B_t\)"), [])
        self.assertEqual(undergrad_guides.find_unwrapped_math(r"Use the \(L^2\) norm"), [])

    def test_real_guides_pass_math_notation_contract(self) -> None:
        guides = undergrad_guides.load_guides()
        self.assertIn("1.1", guides)
        self.assertIn("1.5", guides)

    def test_section_one_summary_and_source_cards_use_mathjax(self) -> None:
        section_guides = json.loads(
            (ROOT / "website" / "content" / "section_guides.json").read_text(encoding="utf-8")
        )
        intro = str(section_guides["1.1"])
        for legacy in (
            "E[(sum H_i Delta B_i)^2] = E[integral H^2 dt]",
            "A_t = integral_0^{t wedge T} eta_s^2 ds",
            "tau_n = inf{t : A_t >= n}",
        ):
            self.assertNotIn(legacy, intro)
        for rendered in (
            r"\(\mathbb E[(\sum_i H_i\,\Delta B_i)^2]=\mathbb E[\int H_t^2\,dt]\)",
            r"\(A_t=\int_0^{t\wedge T}\eta_s^2\,ds\)",
            r"\(\tau_n=\inf\{t:A_t\ge n\}\)",
        ):
            self.assertIn(rendered, intro)

        rows = json.loads(
            (ROOT / "website" / "content" / "source_correspondence.json").read_text(encoding="utf-8")
        )
        by_id = {str(row.get("id", "")): row for row in rows}
        for source_id in (
            "chewi-1-1-theorem-1-1-8",
            "chewi-1-1-display-1-1-5",
            "chewi-1-1-display-1-1-6",
            "chewi-proposition-1-1-16",
        ):
            formula = str(by_id[source_id].get("latex_statement", ""))
            self.assertTrue(formula, source_id)
            self.assertIn("\\", formula, source_id)

    def test_site_injection_is_idempotent(self) -> None:
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        output = Path(temp.name)
        (output / "assets").mkdir(parents=True)
        (output / "assets" / "undergrad-guide.css").write_text(".undergrad-guide{}\n", encoding="utf-8")
        section = output / "textbook" / "chapter-01" / "section-1-1.html"
        section.parent.mkdir(parents=True)
        section.write_text(
            '<html><head></head><body><article class="textbook-reader"><header></header>'
            '<div class="reader-prose"><p>source route</p></div></article></body></html>',
            encoding="utf-8",
        )
        fake = {
            "1.1": {
                "audience": "beginner",
                "question": "Why?",
                "promise": "Understand.",
                "before_you_start": ["calculus"],
                "story": [["Step", "Idea"]],
                "vocabulary": [["term", "meaning"]],
            }
        }
        with mock.patch.object(undergrad_guides, "load_guides", return_value=fake):
            self.assertEqual(undergrad_guides.enrich_site(output), 1)
            self.assertEqual(undergrad_guides.enrich_site(output), 1)
            self.assertEqual(undergrad_guides.validate_site(output), [])
        text = section.read_text(encoding="utf-8")
        self.assertEqual(text.count(undergrad_guides.START), 1)
        self.assertEqual(text.count("undergrad-guide.css"), 1)


if __name__ == "__main__":
    unittest.main()
