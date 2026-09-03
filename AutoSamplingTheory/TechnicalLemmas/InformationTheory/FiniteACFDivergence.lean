import AutoSamplingTheory.TechnicalLemmas.InformationTheory.RNLogRatio
import Mathlib.Analysis.Convex.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# Finite absolutely-continuous f-divergence realization

Chewi Definition 1.5.5 defines the full `f`-divergence, including a singular
mass correction and potentially infinite values.  The simultaneous-flow proof
of Theorem 8.3.1 uses the absolutely-continuous finite-density branch.

This module isolates that branch without pretending that it is the full source
definition.  In particular, a value is exposed only together with an explicit
contract recording:

* probability-measure inputs;
* `mu ≪ nu`;
* convexity of the scalar generator on the nonnegative half-line;
* normalization `f 1 = 0`;
* integrability of `f(dmu/dnu)` against `nu`.

The canonical real density representative is Samplinglib's existing
`RNLogRatio.density`; no second Radon--Nikodym hierarchy is introduced.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace InformationTheory
namespace FiniteACFDivergence

open MeasureTheory Set

noncomputable section

variable {X : Type*} [MeasurableSpace X]

/-- The finite absolutely-continuous domain of Chewi Definition 1.5.5.

This is intentionally a restricted realization, not the general singular
extension in the source definition. -/
structure Domain
    (mu nu : Measure X) [IsProbabilityMeasure mu] [IsProbabilityMeasure nu]
    (f : ℝ → ℝ) : Prop where
  absolutelyContinuous : mu ≪ nu
  convexOn_nonneg : ConvexOn ℝ (Ici (0 : ℝ)) f
  normalized : f 1 = 0
  integrable : Integrable (fun x => f (RNLogRatio.density mu nu x)) nu

/-- The finite real-valued `f`-divergence on the explicit AC domain.

The domain witness is part of the interface so Mathlib's totalized Bochner
integral is never presented as a faithful value outside the integrable branch. -/
noncomputable def value
    (mu nu : Measure X) [IsProbabilityMeasure mu] [IsProbabilityMeasure nu]
    (f : ℝ → ℝ) (_h : Domain mu nu f) : ℝ :=
  ∫ x, f (RNLogRatio.density mu nu x) ∂nu

@[simp]
theorem value_eq_integral
    (mu nu : Measure X) [IsProbabilityMeasure mu] [IsProbabilityMeasure nu]
    (f : ℝ → ℝ) (h : Domain mu nu f) :
    value mu nu f h = ∫ x, f (RNLogRatio.density mu nu x) ∂nu :=
  rfl

/-- Any `nu`-a.e. representative of the canonical real RN density gives the
same finite `f`-divergence integral.

This is the handoff needed by common-reference density proofs such as Chewi
Theorem 8.3.1: once `rho = dmu/dnu` is identified almost everywhere, the
measure-facing value can be rewritten using `rho`. -/
theorem value_eq_integral_of_density_ae
    (mu nu : Measure X) [IsProbabilityMeasure mu] [IsProbabilityMeasure nu]
    (f : ℝ → ℝ) (h : Domain mu nu f)
    (rho : X → ℝ)
    (hrho : RNLogRatio.density mu nu =ᵐ[nu] rho) :
    value mu nu f h = ∫ x, f (rho x) ∂nu := by
  rw [value_eq_integral]
  apply integral_congr_ae
  filter_upwards [hrho] with x hx
  rw [hx]

end

end FiniteACFDivergence
end InformationTheory
end TechnicalLemmas
end AutoSamplingTheory
