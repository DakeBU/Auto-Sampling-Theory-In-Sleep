import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingTime

namespace AutoSamplingTheory.Tests.StoppingTime

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingTime
open scoped NNReal

#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingTime.IsChewiStoppingTime

example {Ω : Type*} {m : MeasurableSpace Ω}
    (filtration : Filtration ℝ≥0 m) (t : ℝ≥0) :
    IsChewiStoppingTime filtration (fun _ : Ω => (t : WithTop ℝ≥0)) :=
  isChewiStoppingTime_const filtration t

end AutoSamplingTheory.Tests.StoppingTime
