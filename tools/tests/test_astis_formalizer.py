from __future__ import annotations

import unittest

from tools.astis_formalizer import FormalizationRequest, formalize


class FormalizerTests(unittest.TestCase):
    def test_poincare_template_returns_typed_candidate(self) -> None:
        result = formalize(
            FormalizationRequest(
                latex=r"\operatorname{Var}_\pi(f) \le C_P \int \|\nabla f\|^2 d\pi"
            )
        )
        self.assertEqual(result.status, "candidate")
        self.assertEqual(result.semantic_review_status, "not_reviewed")
        self.assertEqual(result.proof_status, "unproved")
        self.assertIn("Poincare.Satisfies", result.lean_statement)
        self.assertTrue(result.local_candidates)

    def test_unknown_formula_remains_unresolved(self) -> None:
        result = formalize(FormalizationRequest(latex=r"x \star y = z"))
        self.assertEqual(result.status, "unsupported")
        self.assertEqual(result.translation_status, "unresolved")
        self.assertEqual(result.lean_source, "")
        self.assertTrue(result.remaining_proof_obligations)

    def test_empty_input_is_rejected(self) -> None:
        with self.assertRaises(ValueError):
            formalize(FormalizationRequest(latex="  "))


if __name__ == "__main__":
    unittest.main()
