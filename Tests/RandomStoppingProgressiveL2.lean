import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingProgressiveL2

namespace AutoSamplingTheory.Tests.RandomStoppingProgressiveL2

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ProgressiveL2Density RandomStoppingProgressiveL2 StoppingTime
open scoped NNReal

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

#check stoppedIntegrand_stronglyProgressive
#check stoppedProcessFunction_stronglyMeasurable
#check abs_stoppedIntegrand_le_valueBound
#check abs_stopRefinedDyadic_value_le_valueBound
#check stoppedIntegrand_memLp_two
#check stoppedProgressiveL2
#check stoppedProgressiveL2_process

example [IsFiniteMeasure mu]
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T) :
    ProgressiveL2.ProgressiveL2Integrand filtration mu T :=
  stoppedProgressiveL2 eta tau htau htauT

example [IsFiniteMeasure mu]
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T) :
    (stoppedProgressiveL2 (mu := mu) eta tau htau htauT).process =
      Localization.stoppedIntegrand eta.process.value
        (fun w => (tau w : WithTop ℝ≥0)) :=
  stoppedProgressiveL2_process eta tau htau htauT

end
