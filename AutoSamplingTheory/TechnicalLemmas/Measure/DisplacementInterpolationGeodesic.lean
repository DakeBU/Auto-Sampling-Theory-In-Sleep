import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementInterpolationConstantSpeed
import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSymmetry
import Mathlib.Tactic

/-!
# Constant-speed Wasserstein geodesics from displacement interpolation

`DisplacementInterpolation.IsWassersteinGeodesic` records Chewi's source-side
McCann interpolation data.  The metric conclusion of Theorem 1.3.23 is stronger:
for any two times in the unit interval, the Wasserstein distance along the curve
is exactly the time separation times the endpoint distance.

This file adds that metric predicate without changing the older source-data
predicate, and proves it for every quadratic-optimal displacement interpolation.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace DisplacementInterpolationGeodesic

open MeasureTheory Set
open scoped ENNReal

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
  [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
  [SecondCountableTopology E] [StandardBorelSpace E] [Nonempty E]

open DisplacementInterpolation

/-- A source displacement interpolation together with its exact constant-speed
metric identity on `[0,1]`.  This strengthens, but does not redefine, the
existing `IsWassersteinGeodesic` source-data predicate. -/
def IsConstantSpeedWassersteinGeodesic
    (μ₀ μ₁ : Measure E) (curve : ℝ → Measure E) : Prop :=
  IsWassersteinGeodesic μ₀ μ₁ curve ∧
    ∀ s ∈ Icc (0 : ℝ) 1, ∀ t ∈ Icc (0 : ℝ) 1,
      WassersteinSpace.wassersteinDistance (curve s) (curve t) =
        ENNReal.ofReal |s - t| * WassersteinSpace.wassersteinDistance μ₀ μ₁

/-- Exact metric identity for arbitrary interpolation times in the unit
interval.  Ordered times are handled by the previous constant-speed theorem;
the reverse order is reduced to it by Wasserstein symmetry. -/
theorem wassersteinDistance_displacementInterpolation_eq
    {γ : Measure (E × E)} {μ₀ μ₁ : Measure E}
    (hμ₀ : WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment μ₀)
    (hμ₁ : WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment μ₁)
    (hγ : IsQuadraticOptimalCoupling γ μ₀ μ₁)
    {s t : ℝ} (hs : s ∈ Icc (0 : ℝ) 1) (ht : t ∈ Icc (0 : ℝ) 1) :
    WassersteinSpace.wassersteinDistance
        (displacementInterpolation γ s)
        (displacementInterpolation γ t) =
      ENNReal.ofReal |s - t| * WassersteinSpace.wassersteinDistance μ₀ μ₁ := by
  rcases hs with ⟨hs0, hs1⟩
  rcases ht with ⟨ht0, ht1⟩
  rcases le_total s t with hst | hts
  · have h :=
      DisplacementInterpolationConstantSpeed.wassersteinDistance_interpolation_eq_of_le
        (E := E) hμ₀ hμ₁ hγ hs0 hst ht1
    have habs : |s - t| = t - s := by
      rw [abs_sub_comm, abs_of_nonneg (sub_nonneg.mpr hst)]
    simpa [habs] using h
  · calc
      WassersteinSpace.wassersteinDistance
          (displacementInterpolation γ s)
          (displacementInterpolation γ t) =
          WassersteinSpace.wassersteinDistance
            (displacementInterpolation γ t)
            (displacementInterpolation γ s) :=
        WassersteinSymmetry.wassersteinDistance_comm _ _
      _ = ENNReal.ofReal (s - t) * WassersteinSpace.wassersteinDistance μ₀ μ₁ :=
        DisplacementInterpolationConstantSpeed.wassersteinDistance_interpolation_eq_of_le
          (E := E) hμ₀ hμ₁ hγ ht0 hts hs1
      _ = ENNReal.ofReal |s - t| * WassersteinSpace.wassersteinDistance μ₀ μ₁ := by
        rw [abs_of_nonneg (sub_nonneg.mpr hts)]

/-- Chewi Theorem 1.3.23, metric part: a quadratic-optimal displacement
interpolation between two `P₂,ac` endpoints is a constant-speed Wasserstein
geodesic on the unit interval. -/
theorem isConstantSpeedWassersteinGeodesic_displacementInterpolation
    {γ : Measure (E × E)} {μ₀ μ₁ : Measure E}
    (hμ₀ : WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment μ₀)
    (hμ₁ : WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment μ₁)
    (hγ : IsQuadraticOptimalCoupling γ μ₀ μ₁) :
    IsConstantSpeedWassersteinGeodesic μ₀ μ₁ (displacementInterpolation γ) := by
  refine ⟨isWassersteinGeodesic_displacementInterpolation hμ₀ hμ₁ hγ, ?_⟩
  intro s hs t ht
  exact wassersteinDistance_displacementInterpolation_eq hμ₀ hμ₁ hγ hs ht

/-- The stronger metric predicate forgets to the original source-data
predicate. -/
theorem isWassersteinGeodesic_of_isConstantSpeed
    {μ₀ μ₁ : Measure E} {curve : ℝ → Measure E}
    (hcurve : IsConstantSpeedWassersteinGeodesic μ₀ μ₁ curve) :
    IsWassersteinGeodesic μ₀ μ₁ curve :=
  hcurve.1

end

end DisplacementInterpolationGeodesic
end Measure
end TechnicalLemmas
end AutoSamplingTheory