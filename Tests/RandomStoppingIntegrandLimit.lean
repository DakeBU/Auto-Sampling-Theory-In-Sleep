import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingIntegrandLimit

namespace AutoSamplingTheory.Tests.RandomStoppingIntegrandLimit

open Filter MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open RandomStoppingIntegrandLimit ProgressiveL2Density StoppingTime
open scoped NNReal Topology

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {T : ℝ≥0}

#check tendsto_stopRefinedDyadic_value_stoppedIntegrand

example
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T)
    (s : ℝ≥0) (omega : Omega) :
    Tendsto
      (fun n =>
        (RandomStoppingProcessApprox.stopRefinedDyadic eta tau htau n).process.value s omega)
      atTop
      (𝓝 (Localization.stoppedIntegrand eta.process.value
        (fun w => (tau w : WithTop ℝ≥0)) s omega)) :=
  tendsto_stopRefinedDyadic_value_stoppedIntegrand
    eta tau htau htauT s omega

end AutoSamplingTheory.Tests.RandomStoppingIntegrandLimit
