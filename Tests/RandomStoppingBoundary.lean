import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingBoundary

namespace AutoSamplingTheory.Tests.RandomStoppingBoundary

open Filter MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ContinuousDoobL2 DyadicElementaryRefinement ElementaryItoIntegral
  ElementaryStoppingTime ProgressiveL2Density RandomStoppingBoundary
  RandomStoppingDyadicApprox StoppingTime
open scoped NNReal Topology

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {T : ℝ≥0}

#check stopRefined_coeff_eq_zero_of_stoppingValue_eq_zero
#check stopRefined_elementaryItoIntegral_eq_zero_of_stoppingValue_eq_zero
#check tendsto_stopRefined_elementaryItoIntegral

example
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (n : ℕ) (omega : Omega) (homega : tau omega = 0)
    (j : Fin (2 ^ DyadicElementaryStopping.stoppingLevel eta n)) :
    (stopElementary
        (refineDyadic eta (DyadicElementaryStopping.stoppingLevel eta n)
          (DyadicElementaryStopping.level_le_stoppingLevel eta n)).process
        (fun w => (tau w : WithTop ℝ≥0)) htau).coeff j omega = 0 :=
  stopRefined_coeff_eq_zero_of_stoppingValue_eq_zero
    eta tau htau n omega homega j

example
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T)
    (B : ℝ≥0 → Omega → ℝ) (omega : Omega)
    (hcont : ContinuousOn
      (fun t => elementaryItoIntegral eta.process B t omega)
      (Set.Icc (0 : ℝ≥0) T)) :
    Tendsto
      (fun n =>
        elementaryItoIntegral
          (stopElementary
            (refineDyadic eta (DyadicElementaryStopping.stoppingLevel eta n)
              (DyadicElementaryStopping.level_le_stoppingLevel eta n)).process
            (fun w => (tau w : WithTop ℝ≥0)) htau)
          B T omega)
      atTop (𝓝 (elementaryItoIntegral eta.process B (tau omega) omega)) :=
  tendsto_stopRefined_elementaryItoIntegral
    eta tau htau htauT B omega hcont

end AutoSamplingTheory.Tests.RandomStoppingBoundary
