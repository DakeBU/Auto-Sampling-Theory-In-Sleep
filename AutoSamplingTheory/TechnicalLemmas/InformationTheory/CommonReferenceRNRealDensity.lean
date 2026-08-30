import AutoSamplingTheory.TechnicalLemmas.InformationTheory.RNLogRatio
import AutoSamplingTheory.TechnicalLemmas.Measure.CommonReferenceRadonNikodym

/-!
# Real canonical RN density for two common-reference densities

`CommonReferenceRadonNikodym.rnDeriv_withDensity_div` identifies Mathlib's
canonical ENNReal-valued Radon--Nikodym derivative with `p / q` when both laws
are expressed as densities over the same reference measure.

Samplinglib's calculus layer uses the canonical real representative
`RNLogRatio.density mu nu = (mu.rnDeriv nu).toReal`.  Since Mathlib proves
`ENNReal.toReal_div` without additional hypotheses, the passage from the
measure-theoretic quotient to the real calculus representative is purely an API
adapter and introduces no new analytic assumptions.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace InformationTheory
namespace CommonReferenceRNRealDensity

open MeasureTheory
open scoped ENNReal NNReal

noncomputable section

variable {α : Type*} [MeasurableSpace α]

/-- For two ENNReal densities over a common sigma-finite base measure, the
canonical real RN representative is the quotient of the two real
representatives almost everywhere with respect to the denominator law.

All measure-theoretic hypotheses are exactly those of the parent RN quotient
bridge; no extra hypothesis is needed for `toReal` to commute with division. -/
theorem density_withDensity_eq_toReal_div
    (m : Measure α) [SigmaFinite m]
    (p q : α → ℝ≥0∞)
    (hp : AEMeasurable p m)
    (hq : AEMeasurable q m)
    (hp_ne_top : ∀ᵐ x ∂m, p x ≠ ∞)
    (hq_ne_zero : ∀ᵐ x ∂m, q x ≠ 0)
    (hq_ne_top : ∀ᵐ x ∂m, q x ≠ ∞) :
    RNLogRatio.density (m.withDensity p) (m.withDensity q) =ᵐ[m.withDensity q]
      fun x => (p x).toReal / (q x).toReal := by
  have hRN :=
    Measure.CommonReferenceRadonNikodym.rnDeriv_withDensity_div
      m p q hp hq hp_ne_top hq_ne_zero hq_ne_top
  filter_upwards [hRN] with x hx
  simp [RNLogRatio.density, hx]

end

end CommonReferenceRNRealDensity
end InformationTheory
end TechnicalLemmas
end AutoSamplingTheory
