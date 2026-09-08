import AutoSamplingTheory.TechnicalLemmas.Probability.RandomScanHeatBathReversibility
import AutoSamplingTheory.TechnicalLemmas.Probability.KernelInvariance

namespace AutoSamplingTheory.Tests.RandomScanHeatBathReversibility

open MeasureTheory ProbabilityTheory
open scoped ENNReal NNReal
open AutoSamplingTheory.TechnicalLemmas.Probability
open AutoSamplingTheory.TechnicalLemmas.Probability.RandomScanHeatBath

-- Infinite countable state space and infinite target/kernel mass are allowed
-- by the bridge: counting-measure constant kernel is not a Markov kernel.
example : Kernel.IsReversible (Kernel.const ℕ (Measure.count : Measure ℕ)) Measure.count := by
  apply KernelReversibility.isReversible_of_singleton_balance
  intro x y
  simp

example : (Kernel.const ℕ (Measure.count : Measure ℕ)) 0 Set.univ = ∞ := by
  exact Measure.count_apply_infinite Set.infinite_univ

example (κ : Kernel ℕ ℕ) : Kernel.IsReversible κ (0 : Measure ℕ) := by
  apply KernelReversibility.isReversible_of_singleton_balance
  intro x y
  simp

-- A generic target with null atoms still yields genuine set-flux equality.
example {n : ℕ} (μ : Measure (Fin (n + 1) → Bool)) [IsProbabilityMeasure μ]
    (A B : Set (Fin (n + 1) → Bool)) :
    ∫⁻ x in A, randomScan μ x B ∂μ = ∫⁻ y in B, randomScan μ y A ∂μ :=
  randomScan_isReversible μ (Set.to_countable A).measurableSet
    (Set.to_countable B).measurableSet

-- The standard existing consequence is consumed, not redefined in public.
example {n : ℕ} (μ : Measure (Fin (n + 1) → Bool)) [IsProbabilityMeasure μ]
    (k : ℕ) : ((randomScan μ) ^ k).Invariant μ :=
  KernelInvariance.invariant_pow (randomScan_isReversible μ).invariant k

private abbrev State := Fin 2 → Bool
private def a : State := ![false, false]
private def b : State := ![true, false]
private def d : State := ![true, true]

private noncomputable def nonuniform : Measure State :=
  (1 / 4 : ℝ≥0) • Measure.dirac a + (3 / 4 : ℝ≥0) • Measure.dirac b

local instance : IsProbabilityMeasure (α := Fin (1 + 1) → Bool) nonuniform := by
  constructor
  norm_num [nonuniform, Measure.add_apply, Measure.smul_apply, measure_univ]
  simpa [div_eq_mul_inv] using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
    (show (4 : ℝ≥0)⁻¹ + 3 * 4⁻¹ = 1 by norm_num)

private theorem nonuniform_a_pos : nonuniform {a} ≠ 0 := by
  norm_num [nonuniform, Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
    Set.indicator_apply, a, b, funext_iff, Fin.forall_fin_two]

private theorem nonuniform_b_pos : nonuniform {b} ≠ 0 := by
  norm_num [nonuniform, Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
    Set.indicator_apply, a, b, funext_iff, Fin.forall_fin_two]

private theorem forward_move : randomScan nonuniform a {b} = 3 / 8 := by
  rw [randomScan_apply_singleton nonuniform a b nonuniform_a_pos, Fin.sum_univ_two]
  norm_num [Fin.forall_fin_succ, nonuniform, Measure.smul_apply, Measure.add_apply,
    Measure.dirac_apply, Set.indicator_apply, a, b, funext_iff]
  have hsum : (4 : ℝ≥0∞)⁻¹ + 3 / 4 = 1 := by
    simpa [div_eq_mul_inv] using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
      (show (4 : ℝ≥0)⁻¹ + 3 / 4 = 1 by norm_num)
  rw [hsum, inv_one, one_mul]
  simpa [div_eq_mul_inv] using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
    (show (2 : ℝ≥0)⁻¹ * (3 / 4) = 3 / 8 by norm_num)

private theorem reverse_move : randomScan nonuniform b {a} = 1 / 8 := by
  rw [randomScan_apply_singleton nonuniform b a nonuniform_b_pos, Fin.sum_univ_two]
  norm_num [Fin.forall_fin_succ, nonuniform, Measure.smul_apply, Measure.add_apply,
    Measure.dirac_apply, Set.indicator_apply, a, b, funext_iff]
  have hsum : (4 : ℝ≥0∞)⁻¹ + 3 / 4 = 1 := by
    simpa [div_eq_mul_inv] using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
      (show (4 : ℝ≥0)⁻¹ + 3 / 4 = 1 by norm_num)
  rw [hsum, inv_one, one_mul]
  simpa using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
    (show (2 : ℝ≥0)⁻¹ * 4⁻¹ = 8⁻¹ by norm_num)

-- The actual transitions differ, while their stationary fluxes agree.
example : nonuniform {a} * randomScan nonuniform a {b} =
    nonuniform {b} * randomScan nonuniform b {a} := by
  simpa only [lintegral_singleton, mul_comm (nonuniform {a}), mul_comm (nonuniform {b})] using
    (randomScan_isReversible nonuniform (measurableSet_singleton a)
      (measurableSet_singleton b))

example : randomScan nonuniform a {b} ≠ randomScan nonuniform b {a} := by
  rw [forward_move, reverse_move]
  have hn : ((3 / 8 : ℝ≥0) : ℝ≥0∞) ≠ ((1 / 8 : ℝ≥0) : ℝ≥0∞) :=
    ENNReal.coe_injective.ne (by norm_num)
  simpa [div_eq_mul_inv] using hn

-- A forbidden ambient state does not need a positive-start hypothesis for
-- reversibility; its target flux is zero even when its kernel is still Markov.
private theorem forbidden_mass : nonuniform {d} = 0 := by
  norm_num [nonuniform, Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
    Set.indicator_apply, a, b, d, funext_iff, Fin.forall_fin_two]

example : nonuniform {d} * randomScan nonuniform d {a} = 0 := by
  simp only [forbidden_mass, zero_mul]

example : randomScan nonuniform a {d} = 0 := by
  rw [randomScan_apply_singleton nonuniform a d nonuniform_a_pos]
  simp [forbidden_mass]

-- Nonzero target with an invalid start whose every retained fiber is null.
private theorem null_fibers (i : Fin 2) :
    Measure.dirac a {z : State | (fun j => z (i.succAbove j)) =
      (fun j => d (i.succAbove j))} = 0 := by
  fin_cases i <;> norm_num [Measure.dirac_apply, Set.indicator_apply,
    a, d, funext_iff, Fin.forall_fin_one]

example : Kernel.IsReversible (randomScan (Measure.dirac a)) (Measure.dirac a) :=
  randomScan_isReversible _

example : randomScan (Measure.dirac a) d ≠
    (2 : ℝ≥0∞)⁻¹ • ∑ i : Fin 2,
      cond (Measure.dirac a) {z : State | (fun j => z (i.succAbove j)) =
        (fun j => d (i.succAbove j))} := by
  simp only [cond_eq_zero_of_meas_eq_zero (null_fibers _), Finset.sum_const_zero, smul_zero]
  intro h
  have hmass := congrArg (fun ν : Measure State => ν Set.univ) h
  simp only [measure_univ, Measure.coe_zero, Pi.zero_apply] at hmass
  exact one_ne_zero hmass

private noncomputable def diagonal : Measure State :=
  (1 / 2 : ℝ≥0) • (Measure.dirac a + Measure.dirac d)

local instance : IsProbabilityMeasure (α := Fin (1 + 1) → Bool) diagonal := by
  constructor
  norm_num [diagonal, Measure.add_apply, Measure.smul_apply, measure_univ]
  simpa using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
    (show (2 : ℝ≥0)⁻¹ + 2⁻¹ = 1 by norm_num)

private theorem diagonal_a_pos : diagonal {a} ≠ 0 := by
  norm_num [diagonal, Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
    Set.indicator_apply, a, d, funext_iff, Fin.forall_fin_two]

-- Reversible can be disconnected: a supported point is absorbing although
-- the target assigns positive mass to another supported point.
example : Kernel.IsReversible (randomScan diagonal) diagonal ∧
    randomScan diagonal a {a} = 1 ∧ diagonal {a} ≠ 1 := by
  refine ⟨randomScan_isReversible _, ?_, ?_⟩
  · rw [randomScan_apply_singleton diagonal a a diagonal_a_pos, Fin.sum_univ_two]
    norm_num [Fin.forall_fin_two, Fin.forall_fin_one, diagonal,
      Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
      Set.indicator_apply, a, d, funext_iff]
    rw [ENNReal.mul_inv_cancel (by norm_num) (by simp)]
    norm_num
    exact ENNReal.inv_mul_cancel (by norm_num) (by simp)
  · norm_num [diagonal, Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
      Set.indicator_apply, a, d, funext_iff, Fin.forall_fin_two]

-- Single-site (empty retained tuple) boundary.
example (μ : Measure (Fin 1 → Bool)) [IsProbabilityMeasure μ] :
    Kernel.IsReversible (randomScan μ) μ := randomScan_isReversible μ

#print axioms KernelReversibility.isReversible_of_singleton_balance
#print axioms randomScan_isReversible

end AutoSamplingTheory.Tests.RandomScanHeatBathReversibility
