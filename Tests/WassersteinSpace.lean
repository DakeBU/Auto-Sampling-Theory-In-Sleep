import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace

namespace AutoSamplingTheory.Tests.WassersteinSpace

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace

#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment
#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.quadraticCost_measurable
#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.quadraticCost_diag
#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.quadraticCost_comm
#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.wassersteinDistance
#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.wassersteinDistance_sq
#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.wassersteinDistance_self
#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.wassersteinDistance_comm

example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    (μ : Measure E) :
    IsAbsolutelyContinuousFiniteSecondMoment μ ↔
      IsProbabilityMeasure μ ∧
        μ ≪ (volume : Measure E) ∧
        Integrable (fun x : E => ‖x‖ ^ 2) μ :=
  isAbsolutelyContinuousFiniteSecondMoment_iff μ

example {E : Type*} [NormedAddCommGroup E] [MeasurableSpace E]
    (μ ν : Measure E) :
    wassersteinDistance μ ν ^ 2 =
      AutoSamplingTheory.TechnicalLemmas.Measure.Transport.transportCost
        (quadraticCost (E := E)) μ ν :=
  wassersteinDistance_sq μ ν

example {E : Type*} [NormedAddCommGroup E] [MeasurableSpace E] [BorelSpace E]
    [SecondCountableTopology E] (μ : Measure E) :
    wassersteinDistance μ μ = 0 :=
  wassersteinDistance_self μ

example {E : Type*} [NormedAddCommGroup E] [MeasurableSpace E] [BorelSpace E]
    [SecondCountableTopology E] (μ ν : Measure E) :
    wassersteinDistance μ ν = wassersteinDistance ν μ :=
  wassersteinDistance_comm μ ν

end AutoSamplingTheory.Tests.WassersteinSpace
