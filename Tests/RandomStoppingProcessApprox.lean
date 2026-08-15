import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingProcessApprox

namespace AutoSamplingTheory.Tests.RandomStoppingProcessApprox

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ContinuousDoobL2 DyadicElementaryStopping ElementaryStoppingTime ProgressiveL2Density
  RandomStoppingProcessApprox StoppingTime
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {T : ℝ≥0}

#check stopRefinedDyadic
#check stopRefinedDyadic_value_eq_rightApprox
#check stopRefinedDyadic_value_eq_zero_of_stoppingValue_eq_zero

example
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T)
    (n : ℕ) (omega : Omega) (homega : 0 < tau omega)
    (s : ℝ≥0) :
    (stopRefinedDyadic eta tau htau n).process.value s omega =
      (stopAtRightApprox eta (DyadicElementaryProcess.horizon_pos eta)
        homega (htauT omega) n).process.value s omega :=
  stopRefinedDyadic_value_eq_rightApprox
    eta tau htau htauT n omega homega s

example
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (n : ℕ) (omega : Omega) (homega : tau omega = 0)
    (s : ℝ≥0) :
    (stopRefinedDyadic eta tau htau n).process.value s omega = 0 :=
  stopRefinedDyadic_value_eq_zero_of_stoppingValue_eq_zero
    eta tau htau n omega homega s

end AutoSamplingTheory.Tests.RandomStoppingProcessApprox
