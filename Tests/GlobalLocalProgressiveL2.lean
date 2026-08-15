import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalLocalProgressiveL2

namespace AutoSamplingTheory.Tests.GlobalLocalProgressiveL2

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ElementaryItoIntegral GlobalLocalProgressiveL2 LocalProgressiveL2
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}

#check GlobalLocalProgressiveL2Integrand
#check GlobalLocalProgressiveL2Integrand.onHorizon
#check GlobalLocalProgressiveL2Integrand.onHorizon_process
#check GlobalLocalProgressiveL2Integrand.chewi_global_condition_1_1_10

example (eta : GlobalLocalProgressiveL2Integrand filtration mu) (T : ℝ≥0) :
    LocalProgressiveL2Integrand filtration mu T :=
  eta.onHorizon T

example (eta : GlobalLocalProgressiveL2Integrand filtration mu) :
    ∀ T : ℝ≥0, IsLocallySquareIntegrableOn eta.process mu T :=
  eta.chewi_global_condition_1_1_10

end AutoSamplingTheory.Tests.GlobalLocalProgressiveL2
