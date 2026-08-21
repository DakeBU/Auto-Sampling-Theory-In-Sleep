import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementInterpolationCoupling

namespace AutoSamplingTheory.Tests.DisplacementInterpolationCoupling

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure

#check DisplacementInterpolationCoupling.pointMap
#check DisplacementInterpolationCoupling.measurable_pointMap
#check DisplacementInterpolationCoupling.interpolationCoupling
#check DisplacementInterpolationCoupling.measurable_pairPointMap
#check DisplacementInterpolationCoupling.isCoupling_interpolationCoupling

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
  [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]

example (γ : Measure (E × E)) (s t : ℝ) :
    Transport.IsCoupling
      (DisplacementInterpolationCoupling.interpolationCoupling γ s t)
      (DisplacementInterpolation.displacementInterpolation γ s)
      (DisplacementInterpolation.displacementInterpolation γ t) :=
  DisplacementInterpolationCoupling.isCoupling_interpolationCoupling γ s t

end AutoSamplingTheory.Tests.DisplacementInterpolationCoupling
