import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
import Mathlib.MeasureTheory.Integral.Prod

/-!
# Locally square-integrable progressive processes

Chewi's localization step starts from a progressive process whose pathwise
energy is finite almost surely, without assuming that the expected energy is
finite.  This file packages that exact domain and proves that the global
`ProgressiveL2Integrand` domain embeds into it by Fubini.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace LocalSquareIntegrable

open MeasureTheory
open scoped ENNReal NNReal

open ElementaryItoIntegral ProgressiveL2

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

/-- A progressive process whose squared time integral is finite almost surely
on the fixed finite horizon.  No expectation bound is included. -/
structure LocallySquareIntegrableProgressive
    (filtration : Filtration ℝ≥0 m) (mu : Measure Omega) (T : ℝ≥0) where
  process : ℝ≥0 → Omega → ℝ
  progressive : IsStronglyProgressive filtration process
  locallySquareIntegrable : IsLocallySquareIntegrableOn process mu T

namespace LocallySquareIntegrableProgressive

/-- Global product-space `L2` integrability implies the pathwise local
square-integrability required for localization. -/
theorem progressiveL2_isLocallySquareIntegrableOn
    (eta : ProgressiveL2Integrand filtration mu T) :
    IsLocallySquareIntegrableOn eta.process mu T := by
  have hprod : Integrable
      (fun z : Omega × ℝ≥0 => (processFunction eta.process z) ^ 2)
      (processTimeMeasure mu T) :=
    eta.memLp.integrable_sq
  have hsections : ∀ᵐ omega ∂mu,
      Integrable (fun t : ℝ≥0 => (eta.process t omega) ^ 2)
        (TimeMeasure.upTo T) := by
    simpa [processTimeMeasure, processFunction] using hprod.prod_right_ae
  filter_upwards [hsections] with omega homega
  have hfinite := homega.hasFiniteIntegral
  simpa [hasFiniteIntegral_iff_enorm, enorm_eq_ofReal, sq_nonneg] using hfinite

/-- Canonical inclusion of the global progressive `L2` domain into the local
one. -/
def ofProgressiveL2
    (eta : ProgressiveL2Integrand filtration mu T) :
    LocallySquareIntegrableProgressive filtration mu T where
  process := eta.process
  progressive := eta.progressive
  locallySquareIntegrable := progressiveL2_isLocallySquareIntegrableOn eta

@[simp] theorem ofProgressiveL2_process
    (eta : ProgressiveL2Integrand filtration mu T) :
    (ofProgressiveL2 eta).process = eta.process :=
  rfl

end LocallySquareIntegrableProgressive
end LocalSquareIntegrable
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
