import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinFiniteSecondMoment

namespace AutoSamplingTheory.Tests.WassersteinFiniteSecondMoment

open MeasureTheory
open scoped ENNReal
open AutoSamplingTheory.TechnicalLemmas.Measure

#check WassersteinFiniteSecondMoment.isCoupling_prod
#check WassersteinFiniteSecondMoment.integrable_norm_sub_sq_prod
#check WassersteinFiniteSecondMoment.lintegral_quadraticCost_prod_lt_top
#check WassersteinFiniteSecondMoment.wassersteinDistance_lt_top_of_integrable_norm_sq
#check WassersteinFiniteSecondMoment.wassersteinDistance_lt_top_of_p2ac

example {E : Type*} [NormedAddCommGroup E]
    [MeasurableSpace E] [BorelSpace E] [SecondCountableTopology E]
    (μ ν : Measure E)
    (hμ : WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment μ)
    (hν : WassersteinSpace.IsAbsolutelyContinuousFiniteSecondMoment ν) :
    WassersteinSpace.wassersteinDistance μ ν < ∞ :=
  WassersteinFiniteSecondMoment.wassersteinDistance_lt_top_of_p2ac μ ν hμ hν

end AutoSamplingTheory.Tests.WassersteinFiniteSecondMoment