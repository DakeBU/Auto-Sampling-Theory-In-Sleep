import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingL2Convergence

namespace AutoSamplingTheory.Tests.RandomStoppingL2Convergence

open Filter MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ProgressiveL2Density RandomStoppingL2Convergence
  RandomStoppingProgressiveL2 StoppingTime
open scoped NNReal Topology

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

#check valueBound_nonneg
#check abs_stopRefinedDyadic_sub_stoppedIntegrand_le
#check tendsto_integral_sq_stopRefinedDyadic_sub
#check tendsto_stopRefinedDyadic_toLp

example [IsFiniteMeasure mu]
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T) :
    Tendsto
      (fun n =>
        (RandomStoppingProcessApprox.stopRefinedDyadic eta tau htau n).toLp mu)
      atTop
      (𝓝 (stoppedProgressiveL2 (mu := mu) eta tau htau htauT).toLp) :=
  tendsto_stopRefinedDyadic_toLp eta tau htau htauT

end AutoSamplingTheory.Tests.RandomStoppingL2Convergence
