import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalStoppedItoMartingale

namespace AutoSamplingTheory.Tests.GlobalStoppedItoMartingale

open MeasureTheory Set
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianMotion
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicGlobalHorizon
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalLocalProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalStoppedItoMartingale
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ}

#check globalStoppedItoProcess
#check globalStoppedItoProcess_stronglyAdapted
#check globalStoppedItoProcess_martingale
#check globalStoppedItoProcess_continuous
#check globalStoppedItoProcess_zero
#check globalStoppedItoProcess_overlap_pathwise_ae
#check globalStoppedItoProcess_eq_of_le_localizer_ae
#check stopped_globalStoppedItoProcess_martingale

example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {k ell : ℕ} (hkell : k ≤ ell) :
    ∀ᵐ omega ∂mu, ∀ t ∈ Icc (0 : ℝ≥0) (dyadicHorizon k),
      globalStoppedItoProcess hUsual eta hB k t omega =
        stoppedProcess (globalStoppedItoProcess hUsual eta hB ell)
          (fun w =>
            (dyadicGlobalLocalizingTime hUsual eta k w : WithTop ℝ≥0))
          t omega :=
  globalStoppedItoProcess_overlap_pathwise_ae hUsual eta hB hkell

example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (k : ℕ) :
    Martingale
      (stoppedProcess (globalStoppedItoProcess hUsual eta hB k)
        (fun w =>
          (dyadicGlobalLocalizingTime hUsual eta k w : WithTop ℝ≥0)))
      filtration mu :=
  stopped_globalStoppedItoProcess_martingale hUsual eta hB k

end AutoSamplingTheory.Tests.GlobalStoppedItoMartingale
