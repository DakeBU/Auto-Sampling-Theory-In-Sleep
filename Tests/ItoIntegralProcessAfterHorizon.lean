import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ItoIntegralProcessAfterHorizon

namespace AutoSamplingTheory.Tests.ItoIntegralProcessAfterHorizon

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ItoIntegralProcessAfterHorizon
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}
  {B : ℝ≥0 → Omega → ℝ}

#check canonicalItoProcess_eq_terminal_of_le
#check canonicalPathLimit_eq_terminal_of_le
#check itoIntegralProcess_eq_terminal_of_le
#check stoppedProcess_eq_terminal_of_le

example [IsFiniteMeasure mu]
    (eta : ProgressiveL2Integrand filtration mu T) (hT : 0 < T)
    (hB : BrownianMotion.IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu)
    {t : ℝ≥0} (hTt : T ≤ t) :
    ItoIntegralProcess.itoIntegralProcess eta hT hB hUsual t =
      ItoIntegralProcess.itoIntegralProcess eta hT hB hUsual T :=
  itoIntegralProcess_eq_terminal_of_le eta hT hB hUsual hTt

end AutoSamplingTheory.Tests.ItoIntegralProcessAfterHorizon
