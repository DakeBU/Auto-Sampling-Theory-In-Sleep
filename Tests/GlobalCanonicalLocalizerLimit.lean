import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalCanonicalLocalizerLimit

namespace AutoSamplingTheory.Tests.GlobalCanonicalLocalizerLimit

open Filter MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open GlobalCanonicalLocalizer GlobalCanonicalLocalizerLimit
  GlobalLocalProgressiveL2 ProgressiveL2
open scoped NNReal Topology

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}

#check eventually_lt_globalLocalizingTime_of_good
#check tendsto_globalLocalizingTime_top_of_good
#check globalLocalizingTime_tendsto_top_ae

example
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu) :
    ∀ᵐ omega ∂mu,
      Tendsto
        (fun n => (globalLocalizingTime hUsual eta n omega : WithTop ℝ≥0))
        atTop (𝓝 (⊤ : WithTop ℝ≥0)) :=
  globalLocalizingTime_tendsto_top_ae hUsual eta

end AutoSamplingTheory.Tests.GlobalCanonicalLocalizerLimit
