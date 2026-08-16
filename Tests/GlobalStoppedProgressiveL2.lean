import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalStoppedProgressiveL2

namespace AutoSamplingTheory.Tests.GlobalStoppedProgressiveL2

noncomputable section

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicGlobalHorizon
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalLocalProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalStoppedProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}

#check globalStoppedIntegrand
#check globalStoppedIntegrand_stronglyProgressive
#check dyadicGlobalLocalizingTime_eq_canonicalRaw_of_good
#check globalStoppedTimeLintegral_le
#check globalStoppedProcessFunction_aestronglyMeasurable
#check globalStoppedProcessFunction_sq_integrable
#check globalStoppedProgressiveL2
#check globalStoppedProgressiveL2_process

example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (k : ℕ) :
    ProgressiveL2Integrand filtration mu (dyadicHorizon k) :=
  globalStoppedProgressiveL2 hUsual eta k

end AutoSamplingTheory.Tests.GlobalStoppedProgressiveL2
