import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.EnergyStoppedItoOverlap

namespace AutoSamplingTheory.Tests.EnergyStoppedItoOverlap

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianMotion
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalStoppedItoIntegral
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.EnergyStoppedItoOverlap
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.LocalProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}
  {B : ℝ≥0 → Omega → ℝ}

#check energyStoppedItoProcess_overlap_ae
#check canonicalStoppedItoProcess_overlap_ae

example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    (hT : 0 < T)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {n k : ℕ} (hnk : n ≤ k)
    {t : ℝ≥0} (htT : t ≤ T) :
    canonicalStoppedItoProcess hUsual eta hT hB n t =ᵐ[mu]
      stoppedProcess
        (canonicalStoppedItoProcess hUsual eta hT hB k)
        (fun omega =>
          (CanonicalEnergyLocalizer.canonicalLocalizingTime hUsual eta n omega :
            WithTop ℝ≥0)) t :=
  canonicalStoppedItoProcess_overlap_ae hUsual eta hT hB hnk htT

end AutoSamplingTheory.Tests.EnergyStoppedItoOverlap
