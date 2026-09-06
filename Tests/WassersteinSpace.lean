import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace

namespace AutoSamplingTheory.Tests.WassersteinSpace

open MeasureTheory
open scoped ENNReal
open AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace

#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment
#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.wassersteinDistance
#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.wassersteinDistance_sq
#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.wassersteinDistance_sq_le_lintegral_of_isCoupling
#check AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace.exists_isCoupling_sqrt_lintegral_lt_of_wassersteinDistance_lt

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

example {E : Type*} [NormedAddCommGroup E] [MeasurableSpace E]
    (μ ν : Measure E) (γ : Measure (E × E))
    (hγ : AutoSamplingTheory.TechnicalLemmas.Measure.Transport.IsCoupling γ μ ν) :
    wassersteinDistance μ ν ^ 2 ≤
      ∫⁻ z, quadraticCost (E := E) z ∂γ :=
  wassersteinDistance_sq_le_lintegral_of_isCoupling μ ν γ hγ

example {E : Type*} [NormedAddCommGroup E] [MeasurableSpace E]
    (μ ν : Measure E) {r : ℝ≥0∞} (h : wassersteinDistance μ ν < r) :
    ∃ γ : Measure (E × E),
      AutoSamplingTheory.TechnicalLemmas.Measure.Transport.IsCoupling γ μ ν ∧
        (∫⁻ z, quadraticCost (E := E) z ∂γ) ^ (1 / (2 : ℝ)) < r :=
  exists_isCoupling_sqrt_lintegral_lt_of_wassersteinDistance_lt μ ν h

end AutoSamplingTheory.Tests.WassersteinSpace