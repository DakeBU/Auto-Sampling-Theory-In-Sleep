import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.EnergyStoppingBoundaryBridge

namespace AutoSamplingTheory.Tests.EnergyStoppingBoundaryBridge

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open EnergyStoppingBoundaryBridge EnergyStoppedIntegrand LocalProgressiveL2 ProgressiveL2
open scoped NNReal

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

#check energyStoppedIntegrand_eq_closedStop_larger_of_ne_boundary
#check energyStoppedIntegrand_ae_eq_closedStop_larger

example
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T)
    {c d : ℝ} (hc : 0 ≤ c) (hcd : c ≤ d) (omega : Omega) :
    (fun s => energyStoppedIntegrand hUsual eta c s omega) =ᵐ[TimeMeasure.upTo T]
      (fun s =>
        Localization.stoppedIntegrand
          (energyStoppedIntegrand hUsual eta d)
          (fun w =>
            (CanonicalEnergyLocalizer.canonicalEnergyLocalizer hUsual eta c w : WithTop ℝ≥0))
          s omega) :=
  energyStoppedIntegrand_ae_eq_closedStop_larger hUsual eta hc hcd omega

end
