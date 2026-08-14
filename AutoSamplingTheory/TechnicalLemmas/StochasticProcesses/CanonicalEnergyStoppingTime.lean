import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalEnergyLocalizer
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingTime

/-!
# Stopping-time status of canonical energy localizers
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace CanonicalEnergyStoppingTime

open MeasureTheory
open scoped NNReal
open ProgressiveL2 LocalProgressiveL2 CanonicalEnergyLocalizer
open StoppingTime

variable {Omega : Type*} {mOmega : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 mOmega} {mu : Measure Omega} {T : ℝ≥0}

/-- Each canonical integer energy localizer is a stopping time. -/
theorem canonicalLocalizingTime_isChewiStoppingTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (n : ℕ) :
    IsChewiStoppingTime filtration
      (fun omega => (canonicalLocalizingTime hUsual eta n omega : WithTop ℝ≥0)) := by
  intro t
  simpa only [WithTop.coe_le_coe] using
    (measurableSet_canonicalEnergyLocalizer_le hUsual eta
      (show 0 ≤ (n + 1 : ℝ) by positivity) t)

/-- The same statement at Mathlib's native stopping-time interface. -/
theorem canonicalLocalizingTime_isStoppingTime
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (n : ℕ) :
    IsStoppingTime filtration
      (fun omega => (canonicalLocalizingTime hUsual eta n omega : WithTop ℝ≥0)) :=
  canonicalLocalizingTime_isChewiStoppingTime hUsual eta n

end CanonicalEnergyStoppingTime
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
