import Mathlib.Probability.Distributions.Gaussian.Real
import Mathlib.Tactic

/-!
# Gaussian fourth moment

The one scalar moment needed for the Brownian quadratic-variation `L2` estimate:

`E[X^4] = 3 v^2` for `X ~ N(0,v)`.

This is proved from Mathlib's Gaussian moment-generating function and
`iteratedDeriv_mgf_zero`, following the same route used by Mathlib to prove the
Gaussian variance formula.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace GaussianFourthMoment

open MeasureTheory ProbabilityTheory Real
open scoped NNReal ProbabilityTheory

/-- Fourth moment of a centered real Gaussian with variance `v`. -/
theorem integral_pow_four_gaussianReal_zero (v : ℝ≥0) :
    ∫ x : ℝ, x ^ 4 ∂(gaussianReal 0 v) = 3 * (v : ℝ) ^ 2 := by
  calc
    ∫ x : ℝ, x ^ 4 ∂(gaussianReal 0 v) =
        iteratedDeriv 4 (mgf (fun x : ℝ => x) (gaussianReal 0 v)) 0 := by
      rw [iteratedDeriv_mgf_zero] <;> simp
    _ = 3 * (v : ℝ) ^ 2 := by
      rw [mgf_fun_id_gaussianReal, iteratedDeriv_succ, iteratedDeriv_succ,
        iteratedDeriv_succ, iteratedDeriv_one]
      simp only [zero_mul, zero_add]
      have h1 :
          deriv (fun t : ℝ => rexp (v * t ^ 2 / 2)) =
            fun t => v * t * rexp (v * t ^ 2 / 2) := by
        ext t
        rw [_root_.deriv_exp (by fun_prop)]
        simp only [deriv_div_const, differentiableAt_const, differentiableAt_fun_id,
          Nat.cast_ofNat, DifferentiableAt.fun_pow, deriv_fun_mul, deriv_const', zero_mul,
          deriv_fun_pow, Nat.add_one_sub_one, pow_one, deriv_id'', mul_one, zero_add]
        ring
      have h2 :
          deriv (fun t : ℝ => v * t * rexp (v * t ^ 2 / 2)) =
            fun t => (v + v ^ 2 * t ^ 2) * rexp (v * t ^ 2 / 2) := by
        ext t
        rw [deriv_fun_mul (by fun_prop) (by fun_prop),
          deriv_fun_mul (by fun_prop) (by fun_prop),
          _root_.deriv_exp (by fun_prop)]
        simp only [deriv_div_const, differentiableAt_const, differentiableAt_fun_id,
          Nat.cast_ofNat, DifferentiableAt.fun_pow, deriv_fun_mul, deriv_const', zero_mul,
          deriv_fun_pow, Nat.add_one_sub_one, pow_one, deriv_id'', mul_one, zero_add]
        ring
      have h3 :
          deriv (fun t : ℝ => (v + v ^ 2 * t ^ 2) * rexp (v * t ^ 2 / 2)) =
            fun t => (3 * v ^ 2 * t + v ^ 3 * t ^ 3) * rexp (v * t ^ 2 / 2) := by
        ext t
        rw [deriv_fun_mul (by fun_prop) (by fun_prop),
          deriv_fun_add (by fun_prop) (by fun_prop),
          deriv_fun_mul (by fun_prop) (by fun_prop),
          _root_.deriv_exp (by fun_prop)]
        simp only [deriv_div_const, differentiableAt_const, differentiableAt_fun_id,
          Nat.cast_ofNat, DifferentiableAt.fun_pow, deriv_fun_mul, deriv_const', zero_mul,
          deriv_fun_pow, Nat.add_one_sub_one, pow_one, deriv_id'', mul_one, zero_add]
        ring
      rw [h1, h2, h3]
      rw [deriv_fun_mul (by fun_prop) (by fun_prop),
        deriv_fun_add (by fun_prop) (by fun_prop),
        deriv_fun_mul (by fun_prop) (by fun_prop),
        deriv_fun_mul (by fun_prop) (by fun_prop),
        _root_.deriv_exp (by fun_prop)]
      simp only [deriv_div_const, differentiableAt_const, differentiableAt_fun_id,
        Nat.cast_ofNat, DifferentiableAt.fun_pow, deriv_fun_mul, deriv_const', zero_mul,
        deriv_fun_pow, Nat.add_one_sub_one, pow_one, deriv_id'', mul_one, zero_add,
        deriv_fun_add, mul_zero, add_zero, zero_pow, OfNat.ofNat_ne_zero,
        not_false_eq_true, Real.exp_zero]
      ring

end GaussianFourthMoment
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
