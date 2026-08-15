import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingGeneralIto

namespace AutoSamplingTheory.Tests.RandomStoppingGeneralIto

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open BrownianMotion ProgressiveL2 ProgressiveL2Stopping RandomStoppingGeneralIto StoppingTime
open scoped NNReal

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}
  {B : ℝ≥0 → Omega → ℝ}

#check tendsto_stoppedCanonical_toLp
#check tendsto_stoppedCanonical_terminal
#check itoIntegralTerminal_stop_ae

example [IsFiniteMeasure mu]
    (eta : ProgressiveL2Integrand filtration mu T) (hT : 0 < T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T)
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    (hUsual : SatisfiesUsualConditions filtration mu) :
    (fun omega =>
      ItoTerminalCompletion.itoIntegralTerminal
        (stop eta (fun w => (tau w : WithTop ℝ≥0)) htau) hT hB omega) =ᵐ[mu]
      (fun omega =>
        ItoIntegralProcess.itoIntegralProcess eta hT hB hUsual (tau omega) omega) :=
  itoIntegralTerminal_stop_ae eta hT tau htau htauT hB hUsual

end AutoSamplingTheory.Tests.RandomStoppingGeneralIto
