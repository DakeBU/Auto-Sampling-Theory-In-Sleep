import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingDyadicApprox

namespace AutoSamplingTheory.Tests.RandomStoppingDyadicApprox

open Filter MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open RandomStoppingDyadicApprox ContinuousDoobL2 DyadicElementaryRefinement
  DyadicElementaryStopping ElementaryItoIntegral ElementaryStoppingTime ProgressiveL2Density
  StoppingTime
open scoped NNReal Topology

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {T : ℝ≥0}

#check IsBoundedNNRealStoppingTime
#check stopRefined_coeff_eq_rightCutoff
#check stopRefined_elementaryItoIntegral_eq_rightApprox
#check tendsto_rightApproxTime_stoppingValue
#check tendsto_rightApproxTime_stoppingValue_nhdsWithin
#check tendsto_continuousOn_rightApproxTime_stoppingValue

example
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T)
    (n : ℕ) (omega : Omega) (homega : 0 < tau omega)
    (j : Fin (2 ^ stoppingLevel eta n)) :
    (stopElementary
        (refineDyadic eta (stoppingLevel eta n)
          (level_le_stoppingLevel eta n)).process
        (fun w => (tau w : WithTop ℝ≥0)) htau).coeff j omega =
      (stopAtRightApprox eta (DyadicElementaryProcess.horizon_pos eta)
        homega (htauT omega) n).process.coeff j omega :=
  stopRefined_coeff_eq_rightCutoff eta tau htau htauT n omega homega j

example
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T)
    (n : ℕ) (B : ℝ≥0 → Omega → ℝ)
    (omega : Omega) (homega : 0 < tau omega) :
    elementaryItoIntegral
        (stopElementary
          (refineDyadic eta (stoppingLevel eta n)
            (level_le_stoppingLevel eta n)).process
          (fun w => (tau w : WithTop ℝ≥0)) htau)
        B T omega =
      elementaryItoIntegral eta.process B
        (rightApproxTime (DyadicElementaryProcess.horizon_pos eta)
          homega (htauT omega) (stoppingLevel eta n)) omega :=
  stopRefined_elementaryItoIntegral_eq_rightApprox
    eta tau htau htauT n B omega homega

example
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htauT : ∀ omega, tau omega ≤ T)
    (M : ℝ≥0 → Omega → ℝ)
    (omega : Omega) (homega : 0 < tau omega)
    (hcont : ContinuousOn (fun t => M t omega) (Set.Icc (0 : ℝ≥0) T)) :
    Tendsto
      (fun n => M
        (rightApproxTime (DyadicElementaryProcess.horizon_pos eta)
          homega (htauT omega) (stoppingLevel eta n)) omega)
      atTop (𝓝 (M (tau omega) omega)) :=
  tendsto_continuousOn_rightApproxTime_stoppingValue
    eta tau htauT M omega homega hcont

end AutoSamplingTheory.Tests.RandomStoppingDyadicApprox
