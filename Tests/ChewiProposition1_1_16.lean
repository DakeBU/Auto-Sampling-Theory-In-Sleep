import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ChewiProposition1_1_16

namespace AutoSamplingTheory.Tests.ChewiProposition1_1_16

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianMotion
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ChewiProposition1_1_16
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalItoProcessGluing
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalLocalProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ}

#check chewi_proposition_1_1_16
#check chewi_proposition_1_1_16_localizers

example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    StronglyAdapted filtration (globalItoProcess hUsual eta hB) ∧
      (∀ omega, Continuous (fun t => globalItoProcess hUsual eta hB t omega)) ∧
      Localization.IsLocalMartingale
        (globalItoProcess hUsual eta hB) filtration mu :=
  chewi_proposition_1_1_16 hUsual eta hB

end AutoSamplingTheory.Tests.ChewiProposition1_1_16
