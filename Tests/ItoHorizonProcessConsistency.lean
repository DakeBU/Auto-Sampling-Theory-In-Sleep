import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ItoHorizonProcessConsistency

namespace AutoSamplingTheory.Tests.ItoHorizonProcessConsistency

open MeasureTheory Set
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianMotion
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicGlobalHorizon
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ItoHorizonProcessConsistency
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ}

#check extendByZero_restrictAt_toLp_eq
#check itoIntegralTerminal_restrict_cross_horizon_eq
#check itoIntegralProcess_extendByZero_ae
#check itoIntegralProcess_extendByZero_pathwise_ae

example [IsProbabilityMeasure mu]
    {a b : ℕ} (hab : a ≤ b)
    (eta : ProgressiveL2Integrand filtration mu (dyadicHorizon a))
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu) :
    ∀ᵐ omega ∂mu, ∀ t ∈ Icc (0 : ℝ≥0) (dyadicHorizon a),
      ItoIntegralProcess.itoIntegralProcess
          (ProgressiveL2HorizonExtension.extendByZero eta
            (DyadicHorizonExtension.dyadicHorizon_mono hab))
          (dyadicHorizon_pos b) hB hUsual t omega =
        ItoIntegralProcess.itoIntegralProcess
          eta (dyadicHorizon_pos a) hB hUsual t omega :=
  itoIntegralProcess_extendByZero_pathwise_ae hab eta hB hUsual

end AutoSamplingTheory.Tests.ItoHorizonProcessConsistency
