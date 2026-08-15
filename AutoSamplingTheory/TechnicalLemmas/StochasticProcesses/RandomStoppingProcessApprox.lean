import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.RandomStoppingBoundary
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Localization

/-!
# Process-level dyadic approximation of random stopping

The previous random-stopping modules compare coefficients and terminal finite
Ito sums.  This file packages the stopped refinement again as a dyadic
process and lifts coefficientwise equality to equality of the *entire time
process* at a fixed sample point.

This is deliberately still an elementary-process statement.  It is the exact
algebraic bridge needed before passing to product-space `L2`: no expectation,
dominated convergence, optional stopping, or completed stochastic integral is
used here.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace RandomStoppingProcessApprox

open Filter MeasureTheory Set
open scoped NNReal Topology

open ContinuousDoobL2 DyadicElementaryRefinement DyadicElementaryStopping
  ElementaryItoIntegral ElementaryStoppingTime ProgressiveL2Density
  RandomStoppingBoundary RandomStoppingDyadicApprox StoppingTime

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {T : ℝ≥0}

/-- The refined elementary process stopped by the original random time,
repackaged with its regular dyadic grid. -/
noncomputable def stopRefinedDyadic
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (n : ℕ) : DyadicElementaryProcess filtration T where
  level := stoppingLevel eta n
  process :=
    stopElementary
      (refineDyadic eta (stoppingLevel eta n)
        (level_le_stoppingLevel eta n)).process
      (fun w => (tau w : WithTop ℝ≥0)) htau
  times_eq := rfl

@[simp] theorem stopRefinedDyadic_level
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (n : ℕ) :
    (stopRefinedDyadic eta tau htau n).level = stoppingLevel eta n :=
  rfl

@[simp] theorem stopRefinedDyadic_process
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (n : ℕ) :
    (stopRefinedDyadic eta tau htau n).process =
      stopElementary
        (refineDyadic eta (stoppingLevel eta n)
          (level_le_stoppingLevel eta n)).process
        (fun w => (tau w : WithTop ℝ≥0)) htau :=
  rfl

private theorem value_eq_of_times_eq_coeff_eq
    {n : ℕ}
    (p q : ElementaryAdaptedProcess filtration n)
    (htimes : p.times = q.times)
    (omega : Omega)
    (hcoeff : ∀ j, p.coeff j omega = q.coeff j omega)
    (s : ℝ≥0) :
    p.value s omega = q.value s omega := by
  unfold ElementaryAdaptedProcess.value
  rw [htimes]
  apply Finset.sum_congr rfl
  intro j _hj
  rw [hcoeff j]

/-- At a positive stopping value, not only the coefficients and terminal Ito
sum but the whole stopped refined time process agrees exactly with the
process cut off at the deterministic right endpoint of the fine cell
containing `tau omega`. -/
theorem stopRefinedDyadic_value_eq_rightApprox
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (htauT : ∀ omega, tau omega ≤ T)
    (n : ℕ) (omega : Omega) (homega : 0 < tau omega)
    (s : ℝ≥0) :
    (stopRefinedDyadic eta tau htau n).process.value s omega =
      (stopAtRightApprox eta (DyadicElementaryProcess.horizon_pos eta)
        homega (htauT omega) n).process.value s omega := by
  let fine : ElementaryAdaptedProcess filtration (2 ^ stoppingLevel eta n) :=
    (refineDyadic eta (stoppingLevel eta n)
      (level_le_stoppingLevel eta n)).process
  let stopped : ElementaryAdaptedProcess filtration (2 ^ stoppingLevel eta n) :=
    stopElementary fine (fun w => (tau w : WithTop ℝ≥0)) htau
  let right : ElementaryAdaptedProcess filtration (2 ^ stoppingLevel eta n) :=
    (stopAtRightApprox eta (DyadicElementaryProcess.horizon_pos eta)
      homega (htauT omega) n).process
  change stopped.value s omega = right.value s omega
  apply value_eq_of_times_eq_coeff_eq stopped right rfl omega
  intro j
  change
    (stopElementary
        (refineDyadic eta (stoppingLevel eta n)
          (level_le_stoppingLevel eta n)).process
        (fun w => (tau w : WithTop ℝ≥0)) htau).coeff j omega =
      (stopAtRightApprox eta (DyadicElementaryProcess.horizon_pos eta)
        homega (htauT omega) n).process.coeff j omega
  exact stopRefined_coeff_eq_rightCutoff
    eta tau htau htauT n omega homega j

/-- At a zero stopping value, the whole stopped refined time process vanishes,
not merely its terminal finite Ito sum. -/
theorem stopRefinedDyadic_value_eq_zero_of_stoppingValue_eq_zero
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0)
    (htau : IsChewiStoppingTime filtration
      (fun omega => (tau omega : WithTop ℝ≥0)))
    (n : ℕ) (omega : Omega) (homega : tau omega = 0)
    (s : ℝ≥0) :
    (stopRefinedDyadic eta tau htau n).process.value s omega = 0 := by
  unfold ElementaryAdaptedProcess.value
  apply Finset.sum_eq_zero
  intro j _hj
  by_cases hcell :
      (stopRefinedDyadic eta tau htau n).process.times j.castSucc < s ∧
        s ≤ (stopRefinedDyadic eta tau htau n).process.times j.succ
  · rw [if_pos hcell]
    change
      (stopElementary
          (refineDyadic eta (stoppingLevel eta n)
            (level_le_stoppingLevel eta n)).process
          (fun w => (tau w : WithTop ℝ≥0)) htau).coeff j omega = 0
    exact stopRefined_coeff_eq_zero_of_stoppingValue_eq_zero
      eta tau htau n omega homega j
  · rw [if_neg hcell]

end RandomStoppingProcessApprox
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
