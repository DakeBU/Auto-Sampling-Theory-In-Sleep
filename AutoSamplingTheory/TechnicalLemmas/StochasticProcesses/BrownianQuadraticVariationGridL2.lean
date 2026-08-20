import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.BrownianQuadraticVariationL2
import Mathlib.Tactic

/-!
# Brownian quadratic variation: finite-grid L2 identity

This packet kills cross terms between distinct compensated squared Brownian
increments and upgrades the one-cell identity to an exact finite-grid formula.
The mesh estimate and convergence theorem are downstream deterministic leaves.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace BrownianQuadraticVariationGridL2

open MeasureTheory ProbabilityTheory
open scoped BigOperators NNReal

open BrownianMotion
open BrownianQuadraticVariation
open BrownianQuadraticVariationL2

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {B : ℝ≥0 → Omega → ℝ}

private theorem grid_cell_le
    {n : ℕ} {times : Fin (n + 1) → ℝ≥0}
    (hmono : Monotone times) (i : Fin n) :
    times i.castSucc ≤ times i.succ :=
  hmono Fin.castSucc_lt_succ.le

private theorem grid_end_le_start_of_lt
    {n : ℕ} {times : Fin (n + 1) → ℝ≥0}
    (hmono : Monotone times) {i j : Fin n} (hij : i < j) :
    times i.succ ≤ times j.castSucc := by
  apply hmono
  apply Fin.le_iff_val_le_val.mpr
  omega

private theorem ordered_cross_integral_eq_zero
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {n : ℕ} {times : Fin (n + 1) → ℝ≥0}
    (hmono : Monotone times) {i j : Fin n} (hij : i < j) :
    ∫ omega,
        centeredSquaredIncrement B times i omega *
          centeredSquaredIncrement B times j omega ∂mu = 0 := by
  let _ : IsProbabilityMeasure mu := hB.isProbabilityMeasure
  have hend : times i.succ ≤ times j.castSucc :=
    grid_end_le_start_of_lt hmono hij
  have hleft : times i.castSucc ≤ times j.castSucc := by
    exact (hmono Fin.castSucc_lt_succ.le).trans hend
  let past : Omega → ℝ := centeredSquaredIncrement B times i
  let futureIncrement : Omega → ℝ := fun omega =>
    B (times j.succ) omega - B (times j.castSucc) omega
  have hpast : StronglyMeasurable[filtration (times j.castSucc)] past := by
    dsimp [past, centeredSquaredIncrement]
    have hright := (hB.stronglyAdapted (times i.succ)).mono (filtration.mono hend)
    have hleftMeas :=
      (hB.stronglyAdapted (times i.castSucc)).mono (filtration.mono hleft)
    exact ((hright.sub hleftMeas).pow 2).sub stronglyMeasurable_const
  have hindep : IndepFun past futureIncrement mu :=
    hB.indepFun_increment_of_stronglyMeasurable (grid_cell_le hmono j) hpast
  have hindepCentered :
      IndepFun past (centeredSquaredIncrement B times j) mu := by
    simpa [futureIncrement, centeredSquaredIncrement, Function.comp_def] using
      hindep.comp measurable_id
        ((measurable_id.pow_const 2).sub measurable_const)
  have hpastMeas : AEStronglyMeasurable past mu :=
    (hpast.mono (filtration.le _)).aestronglyMeasurable
  have hfutureMeas :
      AEStronglyMeasurable (centeredSquaredIncrement B times j) mu :=
    (BrownianQuadraticVariation.centeredSquaredIncrement_integrable hB hmono j).aestronglyMeasurable
  have hfactor :=
    hindepCentered.integral_fun_mul_eq_mul_integral hpastMeas hfutureMeas
  have hpastMean : ∫ omega, past omega ∂mu = 0 := by
    dsimp [past, centeredSquaredIncrement]
    exact integral_centered_increment_sq_eq_zero hB (grid_cell_le hmono i)
  have hfutureMean :
      ∫ omega, centeredSquaredIncrement B times j omega ∂mu = 0 := by
    dsimp [centeredSquaredIncrement]
    exact integral_centered_increment_sq_eq_zero hB (grid_cell_le hmono j)
  calc
    ∫ omega,
        centeredSquaredIncrement B times i omega *
          centeredSquaredIncrement B times j omega ∂mu =
        (∫ omega, past omega ∂mu) *
          ∫ omega, centeredSquaredIncrement B times j omega ∂mu := by
            simpa [past] using hfactor
    _ = 0 := by rw [hpastMean, hfutureMean, zero_mul]

/-- Distinct compensated squared Brownian grid increments are orthogonal in
`L2`. -/
theorem integral_centeredSquaredIncrement_mul_eq_zero
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {n : ℕ} {times : Fin (n + 1) → ℝ≥0}
    (hmono : Monotone times) {i j : Fin n} (hij : i ≠ j) :
    ∫ omega,
        centeredSquaredIncrement B times i omega *
          centeredSquaredIncrement B times j omega ∂mu = 0 := by
  rcases lt_or_gt_of_ne hij with hij | hji
  · exact ordered_cross_integral_eq_zero hB hmono hij
  · simpa [mul_comm] using ordered_cross_integral_eq_zero hB hmono hji

/-- Exact finite-grid `L2` expansion: only diagonal compensated-square terms
remain. -/
theorem integral_quadraticVariationError_sq_eq_sum
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {n : ℕ} {times : Fin (n + 1) → ℝ≥0}
    (hmono : Monotone times) :
    ∫ omega, quadraticVariationError B times omega ^ 2 ∂mu =
      ∑ i : Fin n,
        ∫ omega, centeredSquaredIncrement B times i omega ^ 2 ∂mu := by
  let W : Fin n → Omega → ℝ := fun i => centeredSquaredIncrement B times i
  have hW : ∀ i, MemLp (W i) 2 mu := fun i => by
    dsimp [W, centeredSquaredIncrement]
    exact centered_increment_sq_memLp_two hB (grid_cell_le hmono i)
  have hpair : ∀ i j, Integrable (fun omega => W i omega * W j omega) mu := by
    intro i j
    change Integrable (W i * W j) mu
    exact (hW i).integrable_mul (hW j)
  calc
    ∫ omega, quadraticVariationError B times omega ^ 2 ∂mu =
        ∫ omega, ∑ i : Fin n, ∑ j : Fin n, W i omega * W j omega ∂mu := by
          apply integral_congr_ae
          filter_upwards [] with omega
          simp only [quadraticVariationError, W, Finset.sum_mul_sum, pow_two]
    _ = ∑ i : Fin n, ∑ j : Fin n,
        ∫ omega, W i omega * W j omega ∂mu := by
      rw [integral_finsetSum]
      · apply Finset.sum_congr rfl
        intro i _
        rw [integral_finsetSum]
        intro j _
        exact hpair i j
      · intro i _
        exact integrable_finsetSum _ fun j _ => hpair i j
    _ = ∑ i : Fin n, ∫ omega, W i omega ^ 2 ∂mu := by
      apply Finset.sum_congr rfl
      intro i _
      rw [Finset.sum_eq_single i]
      · simp [pow_two]
      · intro j _ hji
        exact integral_centeredSquaredIncrement_mul_eq_zero hB hmono hji
      · intro hi
        exact False.elim (hi (Finset.mem_univ i))

/-- Exact deterministic formula for the finite-grid compensated quadratic
variation error. -/
theorem integral_quadraticVariationError_sq_eq_two_mul_sum_cellLength_sq
    (hB : IsBrownianMotionWithFiltration B filtration mu)
    {n : ℕ} {times : Fin (n + 1) → ℝ≥0}
    (hmono : Monotone times) :
    ∫ omega, quadraticVariationError B times omega ^ 2 ∂mu =
      ∑ i : Fin n, 2 * (((times i.succ - times i.castSucc : ℝ≥0) : ℝ) ^ 2) := by
  rw [integral_quadraticVariationError_sq_eq_sum hB hmono]
  apply Finset.sum_congr rfl
  intro i _
  exact integral_centered_increment_sq_sq hB (grid_cell_le hmono i)

end BrownianQuadraticVariationGridL2
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
