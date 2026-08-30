import AutoSamplingTheory.TechnicalLemmas.InformationTheory.FiniteACFDivergence
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap

/-!
# Common-reference presentation of finite AC f-divergence

The finite absolutely-continuous realization of Chewi Definition 1.5.5 is
measure-facing:

`D_f(mu || nu) = ∫ f(dmu/dnu) dnu`.

The proof of Chewi Theorem 8.3.1 instead chooses a common reference measure
`m`, writes `nu = m.withDensity q`, and works with the weighted integral

`∫ q * f(rho) dm`.

This file proves exactly that representation change.  It reuses Mathlib's
Bochner `withDensity` formula rather than reproving integration against a
density.  The identification of `rho` with the canonical RN density is kept as
an explicit a.e. parent contract; the common-reference RN cells can discharge
that contract later.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace InformationTheory
namespace FiniteACFDivergenceCommonReference

open MeasureTheory

noncomputable section

variable {X : Type*} [MeasurableSpace X]

/-- Rewrite a finite AC `f`-divergence against `nu = m.withDensity q` as the
common-reference weighted integral used in Chewi Theorem 8.3.1.

The hypotheses on `q` are exactly those needed by Mathlib's
`integral_withDensity_eq_integral_toReal_smul₀`.  `hrho` is deliberately a
separate parent edge: for two common-reference laws it can be supplied by the
canonical RN quotient / real-density bridge rather than reproved here. -/
theorem value_withDensity_eq_integral_mul_of_density_ae
    (m : Measure X)
    (mu : Measure X) [IsProbabilityMeasure mu]
    (q : X → ℝ≥0∞) [IsProbabilityMeasure (m.withDensity q)]
    (f : ℝ → ℝ)
    (h : FiniteACFDivergence.Domain mu (m.withDensity q) f)
    (hq : AEMeasurable q m)
    (hq_lt_top : ∀ᵐ x ∂m, q x < ∞)
    (rho : X → ℝ)
    (hrho : RNLogRatio.density mu (m.withDensity q) =ᵐ[m.withDensity q] rho) :
    FiniteACFDivergence.value mu (m.withDensity q) f h =
      ∫ x, ENNReal.toReal (q x) * f (rho x) ∂m := by
  rw [FiniteACFDivergence.value_eq_integral_of_density_ae
    mu (m.withDensity q) f h rho hrho]
  rw [integral_withDensity_eq_integral_toReal_smul₀ hq hq_lt_top]
  simp only [smul_eq_mul]

end

end FiniteACFDivergenceCommonReference
end InformationTheory
end TechnicalLemmas
end AutoSamplingTheory
