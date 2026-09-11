import AutoSamplingTheory.TechnicalLemmas.Analysis.ConvexityC2
import AutoSamplingTheory.TechnicalLemmas.Analysis.HessianStrongConvexity

open AutoSamplingTheory.TechnicalLemmas.Analysis
open ConvexityC2
open scoped RealInnerProductSpace

-- Nonconstant reversed segment: the directional quadratic form retains its sign.
example : (∫ t : ℝ in 0..1,
    (fderiv ℝ (fderiv ℝ (fun u : ℝ => u ^ 2)) (2 + t • (-3 : ℝ)) (-3)) (-3)) = 18 := by
  have hg (x : ℝ) : gradient (fun u : ℝ => u ^ 2) x = 2 * x := by
    have hd : HasDerivAt (fun u : ℝ => u ^ 2) (2 * x) x := by
      convert! (hasDerivAt_id x).pow 2 using 1
      simp
    exact hd.hasGradientAt.gradient
  rw [← gradient_sub_inner_eq_integral_fderiv2 (by fun_prop), hg, hg]
  norm_num

-- Positive and negative quadratic curvature both satisfy the exact necessary bound.
example (m : ℝ) : ∀ x v : ℝ,
    m * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ (fun u : ℝ => m / 2 * u ^ 2)) x v) v := by
  apply (gradient_mono_iff_fderiv2_lower (by fun_prop)).mp
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

-- Independent old route and new necessary condition agree on the exact modulus.
example {d : ℕ} {f : EuclideanSpace ℝ (Fin d) → ℝ} {m : ℝ}
    (hm : 0 ≤ m) (hf : ContDiff ℝ 2 f)
    (hH : ∀ x v, m * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ f) x v) v) :
    ∀ x v, m * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ f) x v) v := by
  exact (strongConvexOn_iff_fderiv2_lower hm hf).mp
    (HessianStrongConvexity.strongConvexOn_univ_of_fderiv2_lower hf hH)

-- A Hessian lower bound gives the actual quadratic growth consumer at a stationary point.
example {d : ℕ} {f : EuclideanSpace ℝ (Fin d) → ℝ} {m : ℝ}
    (hm : 0 ≤ m) (hf : ContDiff ℝ 2 f)
    (hH : ∀ x v, m * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ f) x v) v)
    (xstar y : EuclideanSpace ℝ (Fin d)) (hz : gradient f xstar = 0) :
    f xstar + m / 2 * ‖y - xstar‖ ^ 2 ≤ f y := by
  have h := (ConvexityC1.convexity_equivalences hm (hf.of_le (by norm_num))).1.mp
    ((strongConvexOn_iff_fderiv2_lower hm hf).mpr hH) xstar y
  simpa [hz] using h

-- No accidentally added positive dimension/modulus or nonzero-direction condition.
example : StrongConvexOn Set.univ (0 : ℝ)
    (fun _ : EuclideanSpace ℝ (Fin 0) => (7 : ℝ)) := by
  apply (strongConvexOn_iff_fderiv2_lower (by norm_num) contDiff_const).mpr
  intro x v
  simp

#print axioms gradient_sub_inner_eq_integral_fderiv2
#print axioms gradient_mono_iff_fderiv2_lower
#print axioms strongConvexOn_iff_fderiv2_lower
