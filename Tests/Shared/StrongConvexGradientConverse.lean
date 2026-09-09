import AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexGradientConverse

open AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexGradientConverse
open scoped RealInnerProductSpace

/-- A quadratic attains the modulus exactly, including negative and zero moduli.
This checks the normalization and the signed-modulus boundary of the converse. -/
example (m : ℝ) : StrongConvexOn Set.univ m (fun x : ℝ => m / 2 * x ^ 2) := by
  apply strongConvexOn_of_gradient_inner_lower_bound (grad := fun x => m * x) convex_univ
  · intro x _
    have hd : HasDerivAt (fun x : ℝ => m / 2 * x ^ 2) (m * x) x := by
      convert! ((hasDerivAt_id x).pow 2).const_mul (m / 2) using 1
      simp only [id_eq]
      ring
    simpa using hd.hasGradientAt
  · intro x _ y _
    simp only [RCLike.inner_apply, conj_trivial, Real.norm_eq_abs, sq_abs]
    nlinarith

/-- The domain-local result supplies the midpoint bound on a closed interval. -/
example {f grad : ℝ → ℝ} {m : ℝ}
    (hg : ∀ x ∈ Set.Icc (0 : ℝ) 1, HasGradientAt f (grad x) x)
    (hm : ∀ x ∈ Set.Icc (0 : ℝ) 1, ∀ y ∈ Set.Icc (0 : ℝ) 1,
      m * ‖y - x‖ ^ 2 ≤ inner ℝ (grad y - grad x) (y - x)) :
    f (1 / 2) ≤ (f 0 + f 1) / 2 - m / 8 := by
  have h := strongConvexOn_of_gradient_inner_lower_bound (convex_Icc 0 1) hg hm
  have hb := h.2 (show (0 : ℝ) ∈ Set.Icc 0 1 by norm_num)
    (show (1 : ℝ) ∈ Set.Icc 0 1 by norm_num)
    (show (0 : ℝ) ≤ 1 / 2 by norm_num) (show (0 : ℝ) ≤ 1 / 2 by norm_num)
    (show (1 : ℝ) / 2 + 1 / 2 = 1 by norm_num)
  norm_num [smul_eq_mul] at hb
  linarith
