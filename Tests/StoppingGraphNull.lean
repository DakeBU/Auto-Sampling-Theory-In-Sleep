import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingGraphNull

namespace AutoSamplingTheory.Tests.StoppingGraphNull

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open StoppingGraphNull
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingTime
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

#check stoppingGraph
#check measurableSet_stoppingGraph
#check timeSection_stoppingGraph_zero
#check processTimeMeasure_stoppingGraph_zero
#check ae_notMem_stoppingGraph
#check ae_time_ne_stoppingTime

example (tau : Omega → WithTop ℝ≥0)
    (htau : IsChewiStoppingTime filtration tau) :
    ElementaryItoIntegral.processTimeMeasure mu T (stoppingGraph tau) = 0 :=
  processTimeMeasure_stoppingGraph_zero tau htau T

end
