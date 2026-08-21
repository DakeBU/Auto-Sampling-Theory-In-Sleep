import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementInterpolationGeodesic

namespace AutoSamplingTheory.Tests.DisplacementInterpolationGeodesic

open MeasureTheory Set
open scoped ENNReal
open AutoSamplingTheory.TechnicalLemmas.Measure

#check DisplacementInterpolationGeodesic.IsConstantSpeedWassersteinGeodesic
#check DisplacementInterpolationGeodesic.wassersteinDistance_displacementInterpolation_eq
#check DisplacementInterpolationGeodesic.isConstantSpeedWassersteinGeodesic_displacementInterpolation

example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    [SecondCountableTopology E] [StandardBorelSpace E] [Nonempty E]
    {γ : Measure (E × E)} {μ₀ μ₁ : Measure E}
    (hμ₀ : WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment μ₀)
    (hμ₁ : WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment μ₁)
    (hγ : DisplacementInterpolation.IsQuadraticOptimalCoupling γ μ₀ μ₁) :
    DisplacementInterpolationGeodesic.IsConstantSpeedWassersteinGeodesic
      μ₀ μ₁ (DisplacementInterpolation.displacementInterpolation γ) :=
  DisplacementInterpolationGeodesic.isConstantSpeedWassersteinGeodesic_displacementInterpolation
    hμ₀ hμ₁ hγ

end AutoSamplingTheory.Tests.DisplacementInterpolationGeodesic