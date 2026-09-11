import AutoSamplingTheory.TechnicalLemmas.Analysis.SmoothnessEquivalences

open AutoSamplingTheory.TechnicalLemmas.Analysis
open SmoothnessEquivalences
open scoped RealInnerProductSpace

-- Signed sharp modulus: the upper model is exactly the Hessian bound for a quadratic.
example (β : ℝ) : ∀ x v : ℝ,
    (fderiv ℝ (fderiv ℝ (fun u : ℝ => β / 2 * u ^ 2)) x v) v ≤ β * ‖v‖ ^ 2 := by
  apply (upper_model_iff_fderiv2_upper (by fun_prop)).mp
  have hg (x : ℝ) : gradient (fun u : ℝ => β / 2 * u ^ 2) x = β * x := by
    have hd : HasDerivAt (fun u : ℝ => β / 2 * u ^ 2) (β * x) x := by
      convert! ((hasDerivAt_id x).pow 2).const_mul (β / 2) using 1
      simp only [id_eq]
      ring
    exact hd.hasGradientAt.gradient
  intro x y
  rw [hg]
  simp only [RCLike.inner_apply, conj_trivial, Real.norm_eq_abs, sq_abs]
  nlinarith

-- The source one-sided beta=0 condition does NOT imply a 0-Lipschitz gradient.
example :
    (∀ x y : ℝ, (-y ^ 2) ≤ -x ^ 2 + inner ℝ (gradient (fun u : ℝ => -u ^ 2) x) (y-x)) ∧
    ¬ LipschitzWith 0 (gradient (fun u : ℝ => -u ^ 2)) := by
  have hg (x : ℝ) : gradient (fun u : ℝ => -u ^ 2) x = -(2*x) := by
    have hd : HasDerivAt (fun u : ℝ => -(u ^ 2)) (-(2*x)) x := by
      convert! ((hasDerivAt_id x).pow 2).neg using 1
      simp
    exact hd.hasGradientAt.gradient
  constructor
  · have h := (upper_model_iff_gradient_upper (f := fun u : ℝ => -u ^ 2)
        (β := 0) (by fun_prop)).mpr (by
      intro x y
      rw [hg, hg]
      simp only [RCLike.inner_apply, conj_trivial]
      nlinarith [sq_nonneg (y-x)])
    simpa using h
  · intro h
    have hz := h.dist_le_mul 0 1
    rw [hg, hg] at hz
    norm_num [Real.dist_eq] at hz

-- A genuine consumer: upper Hessian control gives the descent estimate at a gradient step.
example {d : ℕ} {f : EuclideanSpace ℝ (Fin d) → ℝ} {β : ℝ}
    (hβ : 0 < β) (hf : ContDiff ℝ 2 f)
    (hH : ∀ x v, (fderiv ℝ (fderiv ℝ f) x v) v ≤ β * ‖v‖ ^ 2) (x) :
    f (x - β⁻¹ • gradient f x) ≤ f x - (1 / (2*β)) * ‖gradient f x‖ ^ 2 := by
  have h := (upper_model_iff_fderiv2_upper hf).mpr hH x (x - β⁻¹ • gradient f x)
  rw [sub_sub_cancel_left, inner_neg_right, inner_smul_right,
    real_inner_self_eq_norm_sq, norm_neg, norm_smul, Real.norm_eq_abs,
    mul_pow, sq_abs] at h
  field_simp at h ⊢
  nlinarith

-- Zero-dimensional Euclidean source instance and beta=0 are admitted.
example : ∀ x v : EuclideanSpace ℝ (Fin 0),
    (fderiv ℝ (fderiv ℝ (fun _ : EuclideanSpace ℝ (Fin 0) => (7 : ℝ))) x v) v ≤
      (0 : ℝ) * ‖v‖ ^ 2 := by
  apply (upper_model_iff_fderiv2_upper contDiff_const).mp
  simp

#print axioms upper_model_iff_gradient_upper
#print axioms upper_model_iff_fderiv2_upper
