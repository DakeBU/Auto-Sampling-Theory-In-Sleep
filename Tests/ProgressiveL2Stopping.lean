import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2Stopping

namespace AutoSamplingTheory.Tests.ProgressiveL2Stopping

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ProgressiveL2 ProgressiveL2Stopping StoppingTime
open scoped NNReal

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

#check measurableSet_stoppingSet
#check stoppedIntegrand_stronglyProgressive
#check stoppedIntegrand_memLp
#check stop
#check norm_stop_sub_stop_le
#check tendsto_stop_toLp_of_tendsto

example
    (eta : ProgressiveL2Integrand filtration mu T)
    (tau : Omega → WithTop ℝ≥0)
    (htau : IsChewiStoppingTime filtration tau) :
    ProgressiveL2Integrand filtration mu T :=
  stop eta tau htau

example
    (eta xi : ProgressiveL2Integrand filtration mu T)
    (tau : Omega → WithTop ℝ≥0)
    (htau : IsChewiStoppingTime filtration tau) :
    ‖(stop eta tau htau).toLp - (stop xi tau htau).toLp‖ ≤
      ‖eta.toLp - xi.toLp‖ :=
  norm_stop_sub_stop_le eta xi tau htau

end AutoSamplingTheory.Tests.ProgressiveL2Stopping
