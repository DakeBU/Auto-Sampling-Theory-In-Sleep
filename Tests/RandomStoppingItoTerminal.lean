import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingItoTerminal

namespace AutoSamplingTheory.Tests.RandomStoppingItoTerminal

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open BrownianMotion ProgressiveL2Density RandomStoppingItoTerminal StoppingTime
open scoped NNReal

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}
  {B : ℝ≥0 → Omega → ℝ}

#check tendsto_stopRefinedDyadic_terminalToLp
#check itoIntegralTerminal_stopped_elementary_ae

example [IsFiniteMeasure mu]
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T)
    (hT : 0 < T)
    (hB : IsBrownianMotionWithFiltration B filtration mu) :
    (fun omega =>
      ItoTerminalCompletion.itoIntegralTerminal
        (RandomStoppingProgressiveL2.stoppedProgressiveL2
          (mu := mu) eta tau htau htauT) hT hB omega) =ᵐ[mu]
      (fun omega =>
        ElementaryItoIntegral.elementaryItoIntegral eta.process B (tau omega) omega) :=
  itoIntegralTerminal_stopped_elementary_ae
    eta tau htau htauT hT hB

end AutoSamplingTheory.Tests.RandomStoppingItoTerminal
