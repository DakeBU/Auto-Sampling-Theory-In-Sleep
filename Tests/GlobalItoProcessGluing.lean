import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalItoProcessGluing

namespace AutoSamplingTheory.Tests.GlobalItoProcessGluing

open MeasureTheory Set
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianMotion
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalItoProcessGluing
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalLocalProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ}

#check globalItoGluingGoodSet
#check globalItoGluingGoodSet_ae
#check rawGlobalItoProcess
#check globalItoProcess
#check globalItoProcess_stronglyAdapted
#check globalItoProcess_continuous
#check globalItoProcess_zero
#check stopped_globalItoProcess_martingale
#check globalItoProcess_isLocalMartingale

example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    (∀ omega, Continuous (fun t => globalItoProcess hUsual eta hB t omega)) ∧
      Localization.IsLocalMartingale
        (globalItoProcess hUsual eta hB) filtration mu :=
  ⟨globalItoProcess_continuous hUsual eta hB,
    globalItoProcess_isLocalMartingale hUsual eta hB⟩

end AutoSamplingTheory.Tests.GlobalItoProcessGluing
