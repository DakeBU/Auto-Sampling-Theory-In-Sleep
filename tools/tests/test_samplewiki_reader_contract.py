from __future__ import annotations

import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "website" / "scripts"))

import samplewiki_casebook_polish as polish  # noqa: E402
import samplewiki_reader_contract as contract  # noqa: E402


# Exercise the same final public contract used by build_site.py.
polish.patch(contract)


class SampleWikiReaderFormulaTests(unittest.TestCase):
    def test_extracts_clean_formula_from_katex_duplicate_row(self) -> None:
        case = {
            "id": "case",
            "complexity": (
                "O ~ ( beta d ) "
                r"\widetilde O(\beta\sqrt d\,R_0^2/\varepsilon^2) "
                "O ( beta d )"
            ),
        }
        self.assertEqual(
            contract.row_formula(case, "complexity"),
            r"\widetilde O(\beta\sqrt d\,R_0^2/\varepsilon^2)",
        )

    def test_rejects_incomplete_tex(self) -> None:
        with self.assertRaises(contract.FormulaError):
            contract.validate_latex(r"\sqrt")
        with self.assertRaises(contract.FormulaError):
            contract.validate_latex(r"\operatorname{KL}(\mu\Vert\pi")


class SampleWikiReaderTruthBoundaryTests(unittest.TestCase):
    def setUp(self) -> None:
        self.pending = {
            "id": "ASTIS-SW-PENDING",
            "result_class": "upper",
            "algorithm_or_model": "Averaged LMC",
            "setting_slug": "setting-log-concave-smooth",
            "setting_title": "Log-concave and smooth",
            "source_page": "https://example.test/setting",
            "complexity": r"\widetilde O(d/\varepsilon^2)",
            "guarantee": r"\operatorname{KL}(\mu_N\Vert\pi)\le\varepsilon^2",
            "source_refs": [{"label": "Paper, Theorem ?", "url": "https://example.test/paper"}],
            "lean_declarations": ["Internal.Compiled.Leaf"],
        }
        self.open_case = {
            **self.pending,
            "id": "ASTIS-SW-OPEN",
            "result_class": "lower unknown",
            "algorithm_or_model": "Matching lower bound",
            "complexity": "Unknown",
            "source_refs": [],
        }
        self.audit = {
            "theorem_label": "Theorem 1.2",
            "source_title": "Audited paper",
            "source_version": "v1",
            "source_url": "https://example.test/theorem",
            "statement_latex": r"\operatorname{KL}(\mu_N\Vert\pi)\le\varepsilon^2",
            "source_proof_status": "proof given in source",
            "proof_equations": [
                {"latex": r"K_{n+1}\le K_n", "meaning": "one-step contraction"}
            ],
            "prerequisites": ["one-step contraction"],
            "lean_target": "prove the source-facing assembly",
        }

    def test_pending_case_is_normalized_not_falsely_exact(self) -> None:
        html = contract.case_main("example-cases/samplewiki/cases/x.html", self.pending, None, None)
        self.assertIn("Normalized SampleWiki statement", html)
        self.assertIn("Primary theorem audit pending", html)
        self.assertNotIn("Exact source theorem", html)
        self.assertNotIn("Raw pinned row text", html)

    def test_pending_case_has_useful_reader_derivation_map(self) -> None:
        html = contract.case_main("example-cases/samplewiki/cases/x.html", self.pending, None, None)
        self.assertIn("Reader derivation map", html)
        self.assertIn("not a transcription of the paper&#x27;s proof", html)
        self.assertIn("Langevin", html)
        self.assertIn(contract.esc(self.pending["guarantee"]), html)
        self.assertIn(contract.esc(self.pending["complexity"]), html)

    def test_audited_case_uses_exact_statement_and_proof_equation(self) -> None:
        html = contract.case_main("example-cases/samplewiki/cases/x.html", self.pending, self.audit, None)
        self.assertIn("Exact source theorem", html)
        self.assertIn("Theorem 1.2", html)
        self.assertIn(contract.esc(self.audit["statement_latex"]), html)
        self.assertIn(contract.esc(self.audit["proof_equations"][0]["latex"]), html)
        self.assertNotIn("Reader derivation map", html)

    def test_literature_open_case_has_no_synthetic_proof(self) -> None:
        html = contract.case_main("example-cases/samplewiki/cases/x.html", self.open_case, None, None)
        self.assertIn("Open problem", html)
        self.assertIn("no synthetic proof", html)
        self.assertNotIn("Exact source theorem", html)

    def test_lean_fold_is_intentionally_quiet_even_if_internal_leaf_exists(self) -> None:
        html = contract.case_main("example-cases/samplewiki/cases/x.html", self.pending, None, None)
        self.assertIn("Lean formalization", html)
        self.assertIn("intentionally quiet", html)
        self.assertNotIn("Internal.Compiled.Leaf", html)

    def test_case_has_reader_jump_navigation(self) -> None:
        html = contract.case_main("example-cases/samplewiki/cases/x.html", self.pending, None, None)
        self.assertIn('class="sw-casebook-jump"', html)
        self.assertIn('href="#sw-statement"', html)
        self.assertIn('href="#sw-derivation"', html)
        self.assertIn('href="#sw-assumptions"', html)

    def test_five_reader_layers_are_in_required_order(self) -> None:
        html = contract.case_main("example-cases/samplewiki/cases/x.html", self.pending, None, None)
        markers = [
            'data-reader-layer="statement"',
            'data-reader-layer="proof"',
            'data-reader-layer="assumptions"',
            'data-reader-layer="rigorous-latex"',
            'data-reader-layer="lean"',
        ]
        positions = [html.index(marker) for marker in markers]
        self.assertEqual(positions, sorted(positions))


if __name__ == "__main__":
    unittest.main()
