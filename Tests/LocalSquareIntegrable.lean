import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.LocalSquareIntegrable

namespace AutoSamplingTheory.Tests.LocalSquareIntegrable

open MeasureTheory
open scoped ENNReal NNReal

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ProgressiveL2 LocalSquareIntegrable

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

example (eta : ProgressiveL2Integrand filtration mu T) :
    IsLocallySquareIntegrableOn eta.process mu T :=
  LocallySquareIntegrableProgressive.progressiveL2_isLocallySquareIntegrableOn eta

example (eta : ProgressiveL2Integrand filtration mu T) :
    LocallySquareIntegrableProgressive filtration mu T :=
  LocallySquareIntegrableProgressive.ofProgressiveL2 eta

end

end AutoSamplingTheory.Tests.LocalSquareIntegrable
