import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.EnergyStoppingL2Bridge

namespace AutoSamplingTheory.Tests.EnergyStoppingL2Bridge

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open EnergyStoppingL2Bridge EnergyStoppedProgressiveL2
  LocalProgressiveL2 ProgressiveL2
open scoped NNReal

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

#check ae_time_le_terminal
#check ae_time_ne_terminal
#check processFunction_energyStopped_ae_eq_closedStop_larger
#check stoppedProgressiveL2_toLp_eq_stop_larger

example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    {c d : ℝ} (hc : 0 ≤ c) (hcd : c ≤ d) :
    (stoppedProgressiveL2 hUsual eta hc).toLp =
      (ProgressiveL2Stopping.stop
        (stoppedProgressiveL2 hUsual eta (hc.trans hcd))
        (fun w =>
          (CanonicalEnergyLocalizer.canonicalEnergyLocalizer hUsual eta c w : WithTop ℝ≥0))
        (CanonicalEnergyStoppingTime.canonicalEnergyLocalizer_isChewiStoppingTime
          hUsual eta hc)).toLp :=
  stoppedProgressiveL2_toLp_eq_stop_larger hUsual eta hc hcd

end
