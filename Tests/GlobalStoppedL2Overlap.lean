import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalStoppedL2Overlap

namespace AutoSamplingTheory.Tests.GlobalStoppedL2Overlap

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicGlobalHorizon
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalLocalProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalStoppedL2Overlap
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalStoppedProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}

#check dyadicGlobalLocalizingTime_coe_le
#check stopped_globalStoppedIntegrand_eq
#check stop_globalStoppedProgressiveL2_process
#check stop_globalStopped_toLp_eq_extendByZero

example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    {k ell : ℕ} (hkell : k ≤ ell) :
    (ProgressiveL2Stopping.stop (globalStoppedProgressiveL2 hUsual eta ell)
      (fun omega =>
        (dyadicGlobalLocalizingTime hUsual eta k omega : WithTop ℝ≥0))
      (dyadicGlobalLocalizingTime_isChewiStoppingTime hUsual eta k)).toLp =
      (ProgressiveL2HorizonExtension.extendByZero
        (globalStoppedProgressiveL2 hUsual eta k)
        (DyadicHorizonExtension.dyadicHorizon_mono hkell)).toLp :=
  stop_globalStopped_toLp_eq_extendByZero hUsual eta hkell

end AutoSamplingTheory.Tests.GlobalStoppedL2Overlap
