import AutoSamplingTheory.TechnicalLemmas.Analysis.GradientDescentPL
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Mul

open AutoSamplingTheory.TechnicalLemmas.Analysis.GradientDescentPL
open Set
open scoped RealInnerProductSpace

-- A concrete objective checks the actual gradient and every step in [0,1], including h=0 and q=0.
example (h x : ℝ) (hh : 0 ≤ h) (hs : h ≤ 1) (N : ℕ) :
    (fun t : ℝ => t ^ 2 / 2) ((fun t => t - h * gradient (fun t : ℝ => t ^ 2 / 2) t)^[N] x) ≤
      (1-h)^N * (x^2/2) := by
  have hg (t : ℝ) : gradient (fun t : ℝ => t ^ 2 / 2) t = t := by
    have hd : HasDerivAt (fun t : ℝ => t ^ 2 / 2) t t := by
      simpa using ((hasDerivAt_id t).pow 2).div_const (2 : ℝ)
    exact hd.hasGradientAt.gradient
  have hr := gradient_descent_pl_value_bound (f := fun t : ℝ => t ^ 2 / 2)
    (α := 1) (β := 1) (h := h) (z := 0)
    (by intro t _; change (0 : ℝ) ^ 2 / 2 ≤ t ^ 2 / 2; nlinarith [sq_nonneg t]) hh (by simpa using hs)
    (by intro a b; rw [hg]; simp only [Real.inner_apply, Real.norm_eq_abs, sq_abs]; nlinarith [sq_nonneg (b-a)])
    (by intro t; rw [hg]; simp [Real.norm_eq_abs, sq_abs]; nlinarith) x N
  simpa using hr

-- Constant objectives admit q<0: this endpoint cannot be discarded by assuming alpha<=beta.
example (x : ℝ) (N : ℕ) :
    (fun _ : ℝ => (3 : ℝ)) ((fun t => t - gradient (fun _ : ℝ => (3 : ℝ)) t)^[N] x) - 3 ≤
      (-1 : ℝ)^N * (3 - 3) := by
  have hr := gradient_descent_pl_value_bound (f := fun _ : ℝ => (3 : ℝ))
    (α := 2) (β := 1) (h := 1) (z := 0)
    (by intro t _; change (3 : ℝ) ≤ 3; rfl) (by norm_num) (by norm_num)
    (by intro a b; simp; positivity) (by intro t; simp) x N
  convert hr using 1; norm_num

#print axioms AutoSamplingTheory.TechnicalLemmas.Analysis.GradientDescentBasic.gradient_step_descent_of_quadratic_upper_bound
#print axioms gradient_descent_pl_value_bound
