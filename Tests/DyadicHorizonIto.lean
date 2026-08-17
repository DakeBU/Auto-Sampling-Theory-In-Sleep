import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicHorizonIto

namespace AutoSamplingTheory.Tests.DyadicHorizonIto

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianMotion
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicGlobalHorizon
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicHorizonIto
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2Density
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ}

#check fin_sum_eq_sum_prefix_of_tail_zero
#check old_time_le_horizon
#check extend_time_castSucc_eq
#check extend_time_succ_eq
#check extendDyadicHorizon_elementaryItoIntegral_eq
#check extendDyadicHorizon_terminalToLp_eq

example {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a))
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    DyadicElementaryRefinement.terminalToLp
        (DyadicHorizonExtension.extendDyadicHorizon hab q) hB =
      DyadicElementaryRefinement.terminalToLp q hB :=
  extendDyadicHorizon_terminalToLp_eq hab q hB

end AutoSamplingTheory.Tests.DyadicHorizonIto
