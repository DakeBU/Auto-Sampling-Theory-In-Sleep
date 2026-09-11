import AutoSamplingTheory.TechnicalLemmas.Analysis.GradientDescentContraction

open AutoSamplingTheory.TechnicalLemmas.Analysis.GradientDescentContraction
open scoped RealInnerProductSpace

-- Source step h=1/beta: recover the exponential distance estimate from
-- a genuine minimum, without assuming stationarity or a recurrence bound.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {f : E → ℝ} {α β : ℝ} (hf : ContDiff ℝ 1 f)
    (hsc : StrongConvexOn Set.univ α f) (hα : 0 ≤ α) (hβ : 0 < β)
    (hu : ∀ x y, f y ≤ f x + inner ℝ (gradient f x) (y-x) + β/2*‖y-x‖^2)
    {xstar : E} (hmin : IsMinOn f Set.univ xstar) (x₀ : E) (N : ℕ) :
    ‖(fun x => x - β⁻¹ • gradient f x)^[N] x₀ - xstar‖ ≤
      Real.exp (-(α / β * N) / 2) * ‖x₀ - xstar‖ := by
  have hi := gradient_descent_distance_bound hf hsc hα hβ.le (inv_nonneg.mpr hβ.le)
    (by simp [ne_of_gt hβ] : β * β⁻¹ ≤ 1) hu hmin x₀ N
  simpa only [div_eq_mul_inv] using hi.1.trans hi.2

-- Equal unit moduli: one step reaches any supplied global minimizer exactly.
example {f : ℝ → ℝ} (hf : ContDiff ℝ 1 f) (hsc : StrongConvexOn Set.univ 1 f)
    (hu : ∀ x y, f y ≤ f x + inner ℝ (gradient f x) (y-x) + 1/2*‖y-x‖^2)
    {xstar : ℝ} (hmin : IsMinOn f Set.univ xstar) (x : ℝ) :
    x - gradient f x = xstar := by
  have hi := (gradient_descent_distance_bound (α := 1) (β := 1) (h := 1)
    hf hsc (by norm_num) (by norm_num) (by norm_num) (by norm_num) hu hmin x 1).1
  simpa [sub_eq_zero] using hi

-- Actual constant objective exercises zero curvature, zero smoothness,
-- arbitrary nonnegative step and N=0 as well as positive iteration counts.
example (h : ℝ) (hh : 0 ≤ h) (x xstar : ℝ) (N : ℕ) :
    ‖(fun y : ℝ => y - h • gradient (fun _ : ℝ => (7 : ℝ)) y)^[N] x - xstar‖ ≤
      ‖x - xstar‖ := by
  have hi := gradient_descent_distance_bound (f := fun _ : ℝ => (7 : ℝ))
    (xstar := xstar) (α := 0) (β := 0)
    contDiff_const (strongConvexOn_zero.mpr (convexOn_const _ convex_univ))
    (by norm_num) (by norm_num) hh (by simp)
    (by intro a b; simp) isMinOn_const x N
  simpa using hi.1

#print axioms gradient_step_contraction
#print axioms gradient_descent_distance_bound
