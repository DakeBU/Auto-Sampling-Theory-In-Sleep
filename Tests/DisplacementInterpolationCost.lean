import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementInterpolationCost

namespace AutoSamplingTheory.Tests.DisplacementInterpolationCost

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure
open DisplacementInterpolationCost

#check pointMap_sub_pointMap
#check measurable_quadraticCost
#check quadraticCost_pairPointMap_eq
#check lintegral_quadraticCost_interpolationCoupling_eq
#check wassersteinDistance_sq_interpolation_le

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
  [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]

example (gamma : Measure (E × E)) (s t : ℝ) :
    WassersteinSpace.wassersteinDistance
        (DisplacementInterpolation.displacementInterpolation gamma s)
        (DisplacementInterpolation.displacementInterpolation gamma t) ^ 2 ≤
      ENNReal.ofReal (|s - t| ^ 2) *
        ∫⁻ z, WassersteinSpace.quadraticCost (E := E) z ∂gamma :=
  wassersteinDistance_sq_interpolation_le gamma s t

end AutoSamplingTheory.Tests.DisplacementInterpolationCost
