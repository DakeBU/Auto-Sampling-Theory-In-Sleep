import AutoSamplingTheory.TechnicalLemmas.Analysis.ConvexSmoothGradient
import AutoSamplingTheory.TechnicalLemmas.Analysis.SmoothnessEquivalences

open AutoSamplingTheory.TechnicalLemmas.Analysis
open ConvexSmoothGradient
open scoped RealInnerProductSpace

-- Source reciprocal formula, explicitly on its positive denominator domain.
example {f : ℝ → ℝ} {β : ℝ} (hf : ContDiff ℝ 1 f)
    (hc : ConvexOn ℝ Set.univ f) (hβ : 0 < β)
    (hu : ∀ x y, f y ≤ f x + inner ℝ (gradient f x) (y-x) + β/2*‖y-x‖^2)
    (x y : ℝ) :
    f x + inner ℝ (gradient f x) (y-x) +
      (1/(2*β))*‖gradient f y-gradient f x‖^2 ≤ f y := by
  have h := gradient_gap_sq_le_bregman hf hc hβ hu x y
  have hb : 0 < 2*β := by positivity
  have hd := (div_le_iff₀ hb).mpr (by simpa only [mul_comm] using h)
  rw [div_eq_mul_inv] at hd
  rw [one_div]
  nlinarith

-- Integration with the already compiled C1 single-sided interface: convexity
-- supplies precisely the missing condition needed for a Lipschitz gradient.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {f : E → ℝ} {β : NNReal} (hf : ContDiff ℝ 1 f) (hc : ConvexOn ℝ Set.univ f)
    (hg : ∀ x y, inner ℝ (gradient f y-gradient f x) (y-x) ≤ (β : ℝ)*‖y-x‖^2) :
    LipschitzWith β (gradient f) :=
  gradient_lipschitz hf hc ((SmoothnessEquivalences.upper_model_iff_gradient_upper hf).mpr hg)

-- Zero modulus is exercised without taking a reciprocal: the gradient is constant.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {f : E → ℝ} (hf : ContDiff ℝ 1 f) (hc : ConvexOn ℝ Set.univ f)
    (hu : ∀ x y, f y ≤ f x + inner ℝ (gradient f x) (y-x)) (x y : E) :
    gradient f x = gradient f y := by
  have hl := gradient_lipschitz (β := 0) hf hc (by simpa using hu)
  have h := hl.dist_le_mul x y
  simpa [dist_le_zero] using h

-- A genuine downstream consumer: the 1/beta gradient step is nonexpansive.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {f : E → ℝ} {β : ℝ} (hf : ContDiff ℝ 1 f) (hc : ConvexOn ℝ Set.univ f)
    (hβ : 0 < β)
    (hu : ∀ x y, f y ≤ f x + inner ℝ (gradient f x) (y-x) + β/2*‖y-x‖^2)
    (x y : E) :
    ‖(y - β⁻¹ • gradient f y) - (x - β⁻¹ • gradient f x)‖ ≤ ‖y-x‖ := by
  have h := gradient_cocoercive hf hc hβ.le hu x y
  have hv : (y - β⁻¹ • gradient f y) - (x - β⁻¹ • gradient f x) =
      (y-x) - β⁻¹ • (gradient f y-gradient f x) := by rw [smul_sub]; abel
  rw [hv]
  apply (sq_le_sq₀ (norm_nonneg _) (norm_nonneg _)).mp
  rw [norm_sub_sq_real, inner_smul_right, real_inner_comm (gradient f y-gradient f x), norm_smul,
    Real.norm_eq_abs, mul_pow, sq_abs]
  have hb : β ≠ 0 := ne_of_gt hβ
  field_simp [hb]
  nlinarith [sq_nonneg ‖gradient f y-gradient f x‖]

#print axioms gradient_gap_sq_le_bregman
#print axioms gradient_cocoercive
#print axioms gradient_lipschitz
