import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ItoHorizonConsistency

namespace AutoSamplingTheory.Tests.ItoHorizonConsistency

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianMotion
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicGlobalHorizon
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ItoHorizonConsistency
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2HorizonExtension
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ}

#check extendedCanonicalApprox
#check tendsto_extendedCanonicalApprox_toLp
#check tendsto_extendedCanonicalApprox_processToLp
#check extendedCanonicalApprox_terminal_eq
#check itoIntegralTerminal_extendByZero_eq

example [IsProbabilityMeasure mu]
    {a b : ℕ} (hab : a ≤ b)
    (eta : ProgressiveL2Integrand filtration mu (dyadicHorizon a))
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    ItoTerminalCompletion.itoIntegralTerminal
        (extendByZero eta (DyadicHorizonExtension.dyadicHorizon_mono hab))
        (dyadicHorizon_pos b) hB =
      ItoTerminalCompletion.itoIntegralTerminal
        eta (dyadicHorizon_pos a) hB :=
  itoIntegralTerminal_extendByZero_eq hab eta hB

end AutoSamplingTheory.Tests.ItoHorizonConsistency
