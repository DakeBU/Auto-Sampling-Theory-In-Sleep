import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ChewiProposition1_1_16

namespace AutoSamplingTheory.Tests.ChewiProposition1_1_16

open MeasureTheory Set
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
#check chewi_proposition_1_1_16_stopped_integral_representation
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

example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (k : ℕ) {t : ℝ≥0}
    (ht : t ≤ DyadicGlobalHorizon.dyadicHorizon k) :
    stoppedProcess (globalItoProcess hUsual eta hB)
        (fun omega =>
          (DyadicGlobalHorizon.dyadicGlobalLocalizingTime hUsual eta k omega :
            WithTop ℝ≥0)) t =ᵐ[mu]
      ItoIntegralProcess.itoIntegralProcess
        (GlobalStoppedProgressiveL2.globalStoppedProgressiveL2 hUsual eta k)
        (DyadicGlobalHorizon.dyadicHorizon_pos k) hB hUsual t :=
  chewi_proposition_1_1_16_stopped_integral_representation
    hUsual eta hB k ht

end AutoSamplingTheory.Tests.ChewiProposition1_1_16