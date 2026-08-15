import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingL2Contraction

namespace AutoSamplingTheory.Tests.RandomStoppingL2Contraction

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ProgressiveL2 ProgressiveL2Density RandomStoppingL2Contraction
open scoped NNReal

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

#check stoppingSet
#check processFunction_stoppedIntegrand_eq_indicator
#check norm_stopped_sub_le
#check norm_stoppedElementary_sub_target_le
#check tendsto_stoppedCanonicalApprox_toLp

example
    (eta xi etaStop xiStop : ProgressiveL2Integrand filtration mu T)
    (tau : Omega → WithTop ℝ≥0)
    (hetaStop :
      processFunction etaStop.process =ᵐ[ElementaryItoIntegral.processTimeMeasure mu T]
        processFunction (Localization.stoppedIntegrand eta.process tau))
    (hxiStop :
      processFunction xiStop.process =ᵐ[ElementaryItoIntegral.processTimeMeasure mu T]
        processFunction (Localization.stoppedIntegrand xi.process tau)) :
    ‖etaStop.toLp - xiStop.toLp‖ ≤ ‖eta.toLp - xi.toLp‖ :=
  norm_stopped_sub_le eta xi etaStop xiStop tau hetaStop hxiStop

end AutoSamplingTheory.Tests.RandomStoppingL2Contraction
