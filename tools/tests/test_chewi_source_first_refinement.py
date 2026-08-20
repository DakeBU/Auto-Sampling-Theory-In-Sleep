from __future__ import annotations

import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "tools"))
sys.path.insert(0, str(ROOT / "website" / "scripts"))

import chewi_source_first_contract as contract
import chewi_source_first_refinement as refinement


class InlineMathRefinementTests(unittest.TestCase):
    def test_known_ascii_assumption_math_is_mathjax(self) -> None:
        self.assertEqual(refinement.mathify("c >= 0"), r"\(c\ge 0\)")
        self.assertEqual(
            refinement.mathify("every path t -> A_t is continuous and nondecreasing"),
            r"every path \(t\mapsto A_t\) is continuous and nondecreasing",
        )
        self.assertEqual(
            refinement.mathify("tau_m <= tau_n"),
            r"\(\tau_m\le\tau_n\)",
        )

    def test_refinement_keeps_audit_packet_out_of_reader_prose(self) -> None:
        refinement.patch(contract)
        source = {
            "source_kind": "Definition 1.1.4",
            "source_summary": "A martingale is adapted and integrable.",
            "source_url": "https://example.com/source.pdf",
            "latex_statement": r"0\le s\le t\Longrightarrow \mathbb E[M_t\mid\mathcal F_s]=M_s",
            "source_assumptions": ["an adapted process"],
            "formal_assumptions": ["Martingale M filtration mu", "s <= t"],
            "rigorous_packet": "INTERNAL AUDIT PROSE t <= T SHOULD NOT APPEAR",
            "lean_declarations": ["AutoSamplingTheory.Example.martingale"],
        }
        card = contract._render_source_card(
            "martingale", source, {}, {}, {}
        )
        self.assertNotIn("INTERNAL AUDIT PROSE", card)
        self.assertIn("Conditions made explicit by ASTIS", card)
        self.assertIn("<code>s &lt;= t</code>", card)

    def test_implicit_assumptions_render_relations_inside_mathjax(self) -> None:
        refinement.patch(contract)
        item = {
            "id": "implicit-1-1-hitting-time-stopping",
            "title": "First hitting time",
            "why_needed": "A stopping-time condition is required.",
            "latex_statement": r"\{\tau_c\le t\}\in\mathcal F_t",
            "assumptions": [
                "every path t -> A_t is continuous and nondecreasing",
                "c >= 0",
            ],
            "lean_declarations": [],
        }
        card = contract._render_implicit_card(item, {})
        self.assertIn(r"\(t\mapsto A_t\)", card)
        self.assertIn(r"\(c\ge 0\)", card)
        visible = contract._non_math_visible_text(card)
        self.assertEqual(contract._raw_math_errors(visible), [])


if __name__ == "__main__":
    unittest.main()
