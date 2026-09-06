import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementInterpolationConstantSpeed

namespace AutoSamplingTheory.Tests.DisplacementInterpolationConstantSpeed

open MeasureTheory Set
open scoped ENNReal
open AutoSamplingTheory.TechnicalLemmas.Measure

#check DisplacementInterpolationConstantSpeed.isProbabilityMeasure_displacementInterpolation
#check DisplacementInterpolationConstantSpeed.wassersteinDistance_interpolation_le
#check DisplacementInterpolationConstantSpeed.interpolation_coefficients_sum_one
#check DisplacementInterpolationConstantSpeed.wassersteinDistance_interpolation_eq_of_le

example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    [SecondCountableTopology E] [StandardBorelSpace E] [Nonempty E]
    {γ : Measure (E × E)} {μ₀ μ₁ : Measure E}
    (hμ₀ : WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment μ₀)
    (hμ₁ : WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment μ₁)
    (hγ : DisplacementInterpolation.IsQuadraticOptimalCoupling γ μ₀ μ₁)
    {s t : ℝ} (hs0 : 0 ≤ s) (hst : s ≤ t) (ht1 : t ≤ 1) :
    WassersteinSpace.wassersteinDistance
        (DisplacementInterpolation.displacementInterpolation γ s)
        (DisplacementInterpolation.displacementInterpolation γ t) =
      ENNReal.ofReal (t - s) * WassersteinSpace.wassersteinDistance μ₀ μ₁ :=
  DisplacementInterpolationConstantSpeed.wassersteinDistance_interpolation_eq_of_le
    hμ₀ hμ₁ hγ hs0 hst ht1

end AutoSamplingTheory.Tests.DisplacementInterpolationConstantSpeed