import AutoSamplingTheory.TechnicalLemmas.Analysis.GradientDescentValue

open Set Finset AutoSamplingTheory.TechnicalLemmas.Analysis.GradientDescentValue
open scoped RealInnerProductSpace

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]

-- The alpha=0 finite sum gives the actual O(1/N) value bound, with positive denominator.
example {f : E → ℝ} {β h : ℝ} (hf : ContDiff ℝ 1 f)
    (hc : ConvexOn ℝ univ f) (hh : 0 < h) (hstep : β * h ≤ 1)
    (hu : ∀ x y, f y ≤ f x + inner ℝ (gradient f x) (y - x) + β / 2 * ‖y - x‖ ^ 2)
    (x₀ z : E) {N : ℕ} (hN : 0 < N) :
    f ((fun x => x - h • gradient f x)^[N] x₀) - f z ≤ ‖x₀ - z‖ ^ 2 / (2 * h * N) := by
  have he := gradient_descent_weighted_value_bound hf
    (strongConvexOn_zero.mpr hc) hh.le hstep (by norm_num : (0 : ℝ) * h ≤ 1) hu x₀ z N
  simp only [zero_mul, sub_zero, one_pow, sum_const, card_range, nsmul_eq_mul,
    mul_one, one_mul] at he
  apply (le_div_iff₀ (by positivity : 0 < 2 * h * (N : ℝ))).mpr
  nlinarith [he]

-- Strong convexity: divide only by the strictly positive 1-q^N; q=0 is retained.
example {f : E → ℝ} {α β h : ℝ} (hf : ContDiff ℝ 1 f)
    (hsc : StrongConvexOn univ α f) (hh : 0 ≤ h) (hstep : β * h ≤ 1)
    (hq : 0 ≤ 1 - α * h) (hqlt : 1 - α * h < 1)
    (hu : ∀ x y, f y ≤ f x + inner ℝ (gradient f x) (y - x) + β / 2 * ‖y - x‖ ^ 2)
    (x₀ z : E) {N : ℕ} (hN : 0 < N) :
    f ((fun x => x - h • gradient f x)^[N] x₀) - f z ≤
      α * (1 - α * h) ^ N * ‖x₀ - z‖ ^ 2 / (2 * (1 - (1 - α * h) ^ N)) := by
  have ha : 0 < α := by nlinarith
  have he := gradient_descent_weighted_value_bound hf hsc hh hstep (by linarith) hu x₀ z N
  have hs := geom_sum_mul_neg (1 - α * h) N
  have hp : (1 - α * h) ^ N < 1 := pow_lt_one₀ hq hqlt (Nat.ne_of_gt hN)
  apply (le_div_iff₀ (by positivity : 0 < 2 * (1 - (1 - α * h) ^ N))).mpr
  have hem := mul_le_mul_of_nonneg_left he ha.le
  have hid : α * (2 * h * ∑ k ∈ range N, (1 - α * h) ^ k) =
      2 * (1 - (1 - α * h) ^ N) := by nlinarith [hs]
  rw [← mul_assoc, hid] at hem
  nlinarith [hem]

-- Zero coefficient and genuine minimum imply exact function optimality after one step.
example {f : E → ℝ} {α β h : ℝ} (hf : ContDiff ℝ 1 f)
    (hsc : StrongConvexOn univ α f) (hh : 0 < h) (hstep : β * h ≤ 1)
    (hcoeff : α * h = 1)
    (hu : ∀ x y, f y ≤ f x + inner ℝ (gradient f x) (y - x) + β / 2 * ‖y - x‖ ^ 2)
    {z : E} (hz : IsMinOn f univ z) (x : E) :
    f (x - h • gradient f x) = f z := by
  have he := gradient_step_energy_bound hf hsc hh.le hstep hu x z
  rw [hcoeff] at he
  have hm : f z ≤ f (x - h • gradient f x) := hz (mem_univ _)
  have hn := sq_nonneg ‖x - h • gradient f x - z‖
  nlinarith
