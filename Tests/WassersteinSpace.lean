import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace

namespace AutoSamplingTheory.Tests.WassersteinSpace

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace

#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment

example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    (μ : Measure E) :
    IsAbsolutelyContinuousFiniteSecondMoment μ ↔
      IsProbabilityMeasure μ ∧
        μ ≪ (volume : Measure E) ∧
        Integrable (fun x : E => ‖x‖ ^ 2) μ :=
  isAbsolutelyContinuousFiniteSecondMoment_iff μ

end AutoSamplingTheory.Tests.WassersteinSpace
