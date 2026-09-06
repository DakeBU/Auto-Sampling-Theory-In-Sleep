import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalStoppedItoOverlap

namespace AutoSamplingTheory.Tests.GlobalStoppedItoOverlap

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianMotion
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalLocalProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GlobalStoppedItoOverlap
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
#check stoppedProcess_coe_eq_min
#check stopped_large_eq_ito_stop_pathwise_ae
#check globalStoppedItoProcess_overlap_pathwise_ae

example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : GlobalLocalProgressiveL2Integrand filtration mu)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {k ell : ℕ} (hkell : k ≤ ell) :
    ∀ᵐ omega ∂mu, ∀ t : ℝ≥0,
      globalStoppedItoProcess hUsual eta hB k t omega =
        stoppedProcess (globalStoppedItoProcess hUsual eta hB ell)
          (fun w =>
            (DyadicGlobalHorizon.dyadicGlobalLocalizingTime hUsual eta k w :
              WithTop ℝ≥0))
          t omega :=
  globalStoppedItoProcess_overlap_pathwise_ae hUsual eta hB hkell

end AutoSamplingTheory.Tests.GlobalStoppedItoOverlap
