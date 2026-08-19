import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianQuadraticVariation
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GaussianFourthMoment
import Mathlib.Tactic

/-!
# Brownian quadratic variation: L2 cell identities

This is the next B19.2 layer after the finite-grid expectation identities.
It converts the Gaussian fourth moment into the one-cell second-moment identity
for the compensated square `(ΔB)^2 - Δt`.

Finite-grid cross terms and the mesh limit are intentionally separate packets.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace BrownianQuadraticVariationL2

open MeasureTheory ProbabilityTheory
open scoped NNReal

open BrownianMotion
open BrownianQuadraticVariation
open GaussianFourthMoment

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ}

/-- Fourth moment of one Brownian increment, in the metric form supplied
naturally by Mathlib's `IsPreBrownianReal.hasLaw_sub`. -/
theorem integral_increment_pow_four_nndist
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (s t : ℝ≥0) :
    ∫ omega, (B t omega - B s omega) ^ 4 ∂mu =
      3 * ((nndist (t : ℝ) (s : ℝ) : ℝ) ^ 2) := by
  have hpre := hB.isBrownian.toIsPreBrownianReal
  have hlaw := hpre.hasLaw_sub t s
  rw [hlaw.integral_eq]
  exact integral_pow_four_gaussianReal_zero (nndist (t : ℝ) (s : ℝ))

/-- Under `s ≤ t`, the fourth moment has the familiar Brownian form
`E[(B_t-B_s)^4] = 3 (t-s)^2`. -/
theorem integral_increment_pow_four
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {s t : ℝ≥0} (hst : s ≤ t) :
    ∫ omega, (B t omega - B s omega) ^ 4 ∂mu =
      3 * (((t - s : ℝ≥0) : ℝ) ^ 2) := by
  rw [integral_increment_pow_four_nndist hB s t]
  congr 1
  rw [show nndist (t : ℝ) (s : ℝ) = (t - s : ℝ≥0) by
    apply NNReal.eq
    simp [Real.nndist_eq, abs_of_nonneg (sub_nonneg.mpr (show (s : ℝ) ≤ t by exact_mod_cast hst))]]

/-- The compensated square of one Brownian increment is in `L2`. -/
theorem centered_increment_sq_memLp_two
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {s t : ℝ≥0} (hst : s ≤ t) :
    MemLp
      (fun omega =>
        (B t omega - B s omega) ^ 2 - ((t - s : ℝ≥0) : ℝ))
      2 mu := by
  have hpre := hB.isBrownian.toIsPreBrownianReal
  have h4 : MemLp (fun omega => (B t omega - B s omega) ^ 2) 2 mu := by
    have hsub : MemLp (fun omega => B t omega - B s omega) 4 mu :=
      (hpre.isGaussianProcess.hasGaussianLaw_eval t).memLp 4 |>.sub
        ((hpre.isGaussianProcess.hasGaussianLaw_eval s).memLp 4)
    simpa [← pow_mul] using hsub.pow 2
  let _ : IsProbabilityMeasure mu := hB.isProbabilityMeasure
  exact h4.sub (memLp_const ((t - s : ℝ≥0) : ℝ))

/-- One-cell variance identity behind quadratic variation:

`E[((ΔB)^2 - Δt)^2] = 2 (Δt)^2`. -/
theorem integral_centered_increment_sq_sq
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {s t : ℝ≥0} (hst : s ≤ t) :
    ∫ omega,
        ((B t omega - B s omega) ^ 2 - ((t - s : ℝ≥0) : ℝ)) ^ 2 ∂mu =
      2 * (((t - s : ℝ≥0) : ℝ) ^ 2) := by
  let _ : IsProbabilityMeasure mu := hB.isProbabilityMeasure
  have h4 := integral_increment_pow_four hB hst
  have h2 := hB.integral_increment_sq hst
  have hInt4 : Integrable (fun omega => (B t omega - B s omega) ^ 4) mu := by
    have hpre := hB.isBrownian.toIsPreBrownianReal
    exact (hpre.isGaussianProcess.hasGaussianLaw_eval t).integrable_pow 4 |>.sub
      ((hpre.isGaussianProcess.hasGaussianLaw_eval s).integrable_pow 4)
  have hInt2 := increment_sq_integrable hB s t
  calc
    ∫ omega,
        ((B t omega - B s omega) ^ 2 - ((t - s : ℝ≥0) : ℝ)) ^ 2 ∂mu =
        (∫ omega, (B t omega - B s omega) ^ 4 ∂mu) -
          2 * ((t - s : ℝ≥0) : ℝ) *
            (∫ omega, (B t omega - B s omega) ^ 2 ∂mu) +
          (((t - s : ℝ≥0) : ℝ) ^ 2) := by
      rw [show (fun omega =>
          ((B t omega - B s omega) ^ 2 - ((t - s : ℝ≥0) : ℝ)) ^ 2) =
        (fun omega =>
          (B t omega - B s omega) ^ 4 -
            2 * ((t - s : ℝ≥0) : ℝ) * (B t omega - B s omega) ^ 2 +
            (((t - s : ℝ≥0) : ℝ) ^ 2)) by
        funext omega
        ring]
      rw [integral_add, integral_sub]
      · rw [integral_const_mul]
        simp
      · exact hInt4
      · exact hInt2.const_mul _
      · exact hInt4.sub (hInt2.const_mul _)
      · fun_prop
    _ = 2 * (((t - s : ℝ≥0) : ℝ) ^ 2) := by
      rw [h4, h2]
      ring

end BrownianQuadraticVariationL2
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
