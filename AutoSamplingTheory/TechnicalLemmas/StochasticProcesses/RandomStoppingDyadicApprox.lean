import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicGridStoppingIto

/-!
# Dyadic right approximations of a bounded stopping time

The stochastic integral is still stopped by the *original* stopping time.
For a fixed sample point `omega`, however, the active coefficients on a fine
dyadic refinement are exactly the coefficients retained by the deterministic
right endpoint of the cell containing `tau omega`.  This observation avoids
introducing a second approximating stopping-time theory merely for
measurability: `stopElementary` already inherits measurability from the
original stopping time.

This file proves only the coefficient comparison and convergence of the
selected right endpoints.  The finite Itô-sum identity and its L² extension
are downstream.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace RandomStoppingDyadicApprox

open Filter MeasureTheory
open scoped NNReal Topology

open ContinuousDoobL2 DyadicElementaryRefinement DyadicElementaryStopping
  ElementaryStoppingTime FiniteTimeGrid ProgressiveL2Density
  SampledElementaryApproximation StoppingTime

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {T : ℝ≥0}

/-- A finite nonnegative stopping time bounded by the construction horizon. -/
def IsBoundedNNRealStoppingTime
    (tau : Omega → ℝ≥0) : Prop :=
  IsChewiStoppingTime filtration (fun omega => (tau omega : WithTop ℝ≥0)) ∧
    ∀ omega, tau omega ≤ T

/-- At a sample point where `tau` is positive, stopping the refined elementary
integrand by the original stopping time retains exactly the same coefficients
as the deterministic right-grid cutoff of the cell containing `tau omega`. -/
theorem stopRefined_coeff_eq_rightCutoff
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
        homega (htauT omega) n).process.coeff j omega := by
  let level := stoppingLevel eta n
  let grid := regularGridTimes (dyadicMesh T level) (2 ^ level)
  let i := activeCellIndex (DyadicElementaryProcess.horizon_pos eta)
    homega (htauT omega) level
  have hi : grid i.castSucc < tau omega ∧ tau omega ≤ grid i.succ := by
    simpa only [grid, i] using
      activeCellIndex_spec (DyadicElementaryProcess.horizon_pos eta)
        homega (htauT omega) level
  have hmono : StrictMono grid :=
    regularGridTimes_strictMono
      (dyadicMesh_pos (DyadicElementaryProcess.horizon_pos eta) level) _
  rw [stopElementary_coeff]
  simp only [refineDyadic_times, WithTop.coe_lt_coe]
  rw [show (stopAtRightApprox eta (DyadicElementaryProcess.horizon_pos eta)
      homega (htauT omega) n).process.coeff j omega =
      if j.castSucc < rightCutoffIndex eta
          (DyadicElementaryProcess.horizon_pos eta) homega (htauT omega) n
        then (refineDyadic eta (stoppingLevel eta n)
          (level_le_stoppingLevel eta n)).process.coeff j omega
        else 0 by rfl]
  have hcutoff : rightCutoffIndex eta
      (DyadicElementaryProcess.horizon_pos eta) homega (htauT omega) n = i.succ :=
    rfl
  rw [hcutoff]
  by_cases hj : j.castSucc < i.succ
  · have hji : j ≤ i := by
      exact (Fin.castSucc_lt_succ_iff).mp hj
    have hidx : j.castSucc ≤ i.castSucc := by
      exact_mod_cast hji
    have htime : grid j.castSucc < tau omega :=
      (hmono.monotone hidx).trans_lt hi.1
    simpa only [level, grid, if_pos hj, if_pos htime]
  · have hij : i.succ ≤ j.castSucc := le_of_not_gt hj
    have htimeLe : tau omega ≤ grid j.castSucc :=
      hi.2.trans (hmono.monotone hij)
    have htime : ¬ grid j.castSucc < tau omega :=
      not_lt_of_ge htimeLe
    simpa only [level, grid, if_neg hj, if_neg htime]

/-- For every positive sample value of the bounded stopping time, the right
endpoints chosen on successively finer dyadic refinements converge to that
sample value. -/
theorem tendsto_rightApproxTime_stoppingValue
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → ℝ≥0) (htauT : ∀ omega, tau omega ≤ T)
    (omega : Omega) (homega : 0 < tau omega) :
    Tendsto
      (fun n => rightApproxTime (DyadicElementaryProcess.horizon_pos eta)
        homega (htauT omega) (stoppingLevel eta n))
      atTop (𝓝 (tau omega)) :=
  tendsto_rightApproxTime_stoppingLevel eta
    (DyadicElementaryProcess.horizon_pos eta) homega (htauT omega)

end RandomStoppingDyadicApprox
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
