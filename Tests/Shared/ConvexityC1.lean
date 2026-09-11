import AutoSamplingTheory.TechnicalLemmas.Analysis.ConvexityC1

open AutoSamplingTheory.TechnicalLemmas.Analysis.ConvexityC1
open scoped RealInnerProductSpace

-- A reversed segment checks the FTC orientation on a nonconstant function.
example : (∫ s : ℝ in 0..1, inner ℝ (gradient (fun u : ℝ => u ^ 2)
    (2 + s • (-3 : ℝ))) (-3 : ℝ)) = -3 := by
  convert (sub_eq_integral_gradient (f := fun u : ℝ => u ^ 2)
    (by fun_prop) 2 (-3)).symm using 1 <;> norm_num

-- Exact quadratic correction for every real modulus, including negative values.
example (m : ℝ) : StrongConvexOn Set.univ m (fun u : ℝ => m / 2 * u ^ 2) := by
  apply strongConvexOn_univ_of_gradient_mono_integral (by fun_prop)
  have hg (x : ℝ) : gradient (fun u : ℝ => m / 2 * u ^ 2) x = m * x := by
    have hd : HasDerivAt (fun u : ℝ => m / 2 * u ^ 2) (m * x) x := by
      convert! ((hasDerivAt_id x).pow 2).const_mul (m / 2) using 1
      simp only [id_eq]
      ring
    exact hd.hasGradientAt.gradient
  intro x y
  rw [hg x, hg y]
  simp only [RCLike.inner_apply, conj_trivial, Real.norm_eq_abs, sq_abs]
  nlinarith

-- The source equivalence turns monotonicity and stationarity into quadratic growth.
example {d : ℕ} {f : EuclideanSpace ℝ (Fin d) → ℝ} {m : ℝ}
    (hm : 0 ≤ m) (hf : ContDiff ℝ 1 f)
    (hg : ∀ x y, m * ‖y - x‖ ^ 2 ≤ inner ℝ (gradient f y - gradient f x) (y - x))
    (xstar : EuclideanSpace ℝ (Fin d)) (hz : gradient f xstar = 0) (y) :
    f xstar + m / 2 * ‖y - xstar‖ ^ 2 ≤ f y := by
  have eqs := convexity_equivalences hm hf
  have h := eqs.1.mp (eqs.2.mpr hg) xstar y
  simpa [hz] using h

-- The source adapter does not accidentally impose positive dimension or modulus.
example : StrongConvexOn Set.univ (0 : ℝ)
    (fun _ : EuclideanSpace ℝ (Fin 0) => (7 : ℝ)) := by
  apply (convexity_equivalences (by norm_num) contDiff_const).2.mpr
  intro x y
  simp
