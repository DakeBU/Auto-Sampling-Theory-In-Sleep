import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DiscreteDoobL2
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ElementaryItoProcess
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.SampledElementaryApproximation

/-!
# Doob L2 control for elementary Ito processes

The discrete maximal inequality is applied to deterministic dyadic samples of
the continuous elementary Ito martingale.  Path continuity is recorded in
`ElementaryItoProcess` and is the bridge used by the subsequent process-limit
module to pass from these finite maxima to uniform control on `[0,T]`.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace ElementaryItoDoobL2

open MeasureTheory
open scoped ENNReal NNReal

open BrownianMotion DiscreteDoobL2 ElementaryItoIntegral ElementaryItoProcess
  SampledElementaryApproximation

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ} {n : ℕ}

/-- The `k`-th point of the level-`level` dyadic observation grid. -/
noncomputable def dyadicObservationTime (T : ℝ≥0) (level k : ℕ) : ℝ≥0 :=
  k * dyadicMesh T level

theorem dyadicObservationTime_monotone (T : ℝ≥0) (level : ℕ) :
    Monotone (dyadicObservationTime T level) := by
  intro i j hij
  unfold dyadicObservationTime
  gcongr

@[simp] theorem dyadicObservationTime_terminal (T : ℝ≥0) (level : ℕ) :
    dyadicObservationTime T level (2 ^ level) = T := by
  simp only [dyadicObservationTime, dyadicMesh, Nat.cast_pow, Nat.cast_ofNat]
  rw [mul_comm, div_mul_cancel₀]
  positivity

/-- Finite-grid Doob control for an elementary Ito martingale. -/
theorem doobL2_elementaryItoProcess
    (eta : ElementaryAdaptedProcess filtration n)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (T : ℝ≥0) (level : ℕ) :
    eLpNorm
        (runningAbsMax
          (fun k => elementaryItoProcess eta B T (dyadicObservationTime T level k))
          (2 ^ level)) 2 mu ≤
      2 * eLpNorm (elementaryItoIntegral eta B T) 2 mu := by
  let _ : IsProbabilityMeasure mu := hB.isProbabilityMeasure
  have h := doobL2_sampled (elementaryItoProcess_martingale eta hB T)
    (dyadicObservationTime T level) (dyadicObservationTime_monotone T level) (2 ^ level)
  simpa only [dyadicObservationTime_terminal, elementaryItoProcess_terminal] using h

end ElementaryItoDoobL2
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
