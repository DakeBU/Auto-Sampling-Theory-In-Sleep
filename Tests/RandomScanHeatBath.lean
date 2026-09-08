import AutoSamplingTheory.TechnicalLemmas.Probability.RandomScanHeatBath
import AutoSamplingTheory.TechnicalLemmas.Probability.KernelInvariance

namespace AutoSamplingTheory.Tests.RandomScanHeatBath

open MeasureTheory ProbabilityTheory
open scoped ENNReal NNReal
open AutoSamplingTheory.TechnicalLemmas.Probability
open AutoSamplingTheory.TechnicalLemmas.Probability.RandomScanHeatBath

private abbrev State := Fin 2 → Bool
private def a : State := ![false, false]
private def b : State := ![true, false]
private def c : State := ![false, true]
private def d : State := ![true, true]

private noncomputable def uniform : Measure State :=
  (1 / 4 : ℝ≥0) • (Measure.dirac a + Measure.dirac b + Measure.dirac c + Measure.dirac d)

local instance : IsProbabilityMeasure (α := Fin (1 + 1) → Bool) uniform := by
  constructor
  norm_num [uniform, Measure.add_apply, Measure.smul_apply, measure_univ]
  simpa using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
    (show (4 : ℝ≥0)⁻¹ + 4⁻¹ + 4⁻¹ + 4⁻¹ = 1 by norm_num)

private theorem uniform_a_pos : uniform {a} ≠ 0 := by
  norm_num [uniform, Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
    Set.indicator_apply, a, b, c, d, funext_iff, Fin.forall_fin_two]

-- The actual random-scan kernel stays with probability 1/2 after ONE move.
example : randomScan uniform a {a} = 1 / 2 := by
  rw [randomScan_apply_singleton uniform a a uniform_a_pos]
  rw [Fin.sum_univ_two]
  norm_num [Fin.forall_fin_succ,
    uniform, Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
    Set.indicator_apply, a, b, c, d, funext_iff]
  have hhalf : (4 : ℝ≥0∞)⁻¹ + 4⁻¹ = 2⁻¹ := by
    simpa using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
      (show (4 : ℝ≥0)⁻¹ + 4⁻¹ = 2⁻¹ by norm_num)
  rw [hhalf, inv_inv, ← mul_add, ← mul_assoc,
    ENNReal.inv_mul_cancel (by norm_num) (by simp), one_mul, hhalf]

-- Either one-bit change has probability 1/4, including the site-selection factor.
example : randomScan uniform a {b} = 1 / 4 := by
  rw [randomScan_apply_singleton uniform a b uniform_a_pos, Fin.sum_univ_two]
  norm_num [Fin.forall_fin_succ,
    uniform, Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
    Set.indicator_apply, a, b, c, d, funext_iff]
  have hhalf : (4 : ℝ≥0∞)⁻¹ + 4⁻¹ = 2⁻¹ := by
    simpa using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
      (show (4 : ℝ≥0)⁻¹ + 4⁻¹ = 2⁻¹ by norm_num)
  rw [hhalf, inv_inv, ← mul_assoc,
    ENNReal.inv_mul_cancel (by norm_num) (by simp), one_mul]

example : randomScan uniform a {c} = 1 / 4 := by
  rw [randomScan_apply_singleton uniform a c uniform_a_pos, Fin.sum_univ_two]
  norm_num [Fin.forall_fin_succ,
    uniform, Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
    Set.indicator_apply, a, b, c, d, funext_iff]
  have hhalf : (4 : ℝ≥0∞)⁻¹ + 4⁻¹ = 2⁻¹ := by
    simpa using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
      (show (4 : ℝ≥0)⁻¹ + 4⁻¹ = 2⁻¹ by norm_num)
  rw [hhalf, inv_inv, ← mul_assoc,
    ENNReal.inv_mul_cancel (by norm_num) (by simp), one_mul]

-- A sweep could change both bits; this one-move kernel cannot.
example : randomScan uniform a {d} = 0 := by
  rw [randomScan_apply_singleton uniform a d uniform_a_pos, Fin.sum_univ_two]
  norm_num [a, d, Fin.forall_fin_succ]

-- Two supported configurations, with forbidden ambient configurations between them.
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

example : diagonal {b} = 0 := by
  norm_num [diagonal, Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
    Set.indicator_apply, a, b, d, funext_iff, Fin.forall_fin_two]

-- Valid denominators do not require full ambient support, nor imply irreducibility.
example : randomScan diagonal a {a} = 1 := by
  rw [randomScan_apply_singleton diagonal a a diagonal_a_pos, Fin.sum_univ_two]
  norm_num [Fin.forall_fin_two, Fin.forall_fin_one, diagonal,
    Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
    Set.indicator_apply, a, d, funext_iff]
  rw [ENNReal.mul_inv_cancel (by norm_num) (by simp)]
  norm_num
  exact ENNReal.inv_mul_cancel (by norm_num) (by simp)

example : randomScan diagonal a {b} = 0 := by
  rw [randomScan_apply_singleton diagonal a b diagonal_a_pos, Fin.sum_univ_two]
  norm_num [Fin.forall_fin_two, Fin.forall_fin_one, diagonal,
    Measure.smul_apply, Measure.add_apply, Measure.dirac_apply,
    Set.indicator_apply, a, b, d, funext_iff]

example : randomScan diagonal a {d} = 0 := by
  rw [randomScan_apply_singleton diagonal a d diagonal_a_pos, Fin.sum_univ_two]
  norm_num [a, d, Fin.forall_fin_succ]

-- Source support supplies BOTH normalization endpoints through native inequalities.
example {n : ℕ} (μ : Measure (Fin (n + 1) → Bool)) [IsProbabilityMeasure μ]
    (x : Fin (n + 1) → Bool) (hx : μ {x} ≠ 0) (i : Fin (n + 1)) :
    μ {z | (fun j => z (i.succAbove j)) = (fun j => x (i.succAbove j))} ≠ 0 ∧
      μ {z | (fun j => z (i.succAbove j)) = (fun j => x (i.succAbove j))} ≠ ∞ := by
  refine ⟨?_, measure_ne_top _ _⟩
  have hle : μ {x} ≤ μ {z | (fun j => z (i.succAbove j)) =
      (fun j => x (i.succAbove j))} :=
    measure_mono (Set.singleton_subset_iff.mpr rfl)
  intro hz
  exact hx (le_antisymm (hz ▸ hle) bot_le)

-- A nonzero probability target can have null fibers at an ambient but invalid start.
private theorem null_fibers (i : Fin 2) :
    Measure.dirac a {z : State | (fun j => z (i.succAbove j)) =
      (fun j => d (i.succAbove j))} = 0 := by
  fin_cases i <;> norm_num [Measure.dirac_apply, Set.indicator_apply,
    a, d, funext_iff, Fin.forall_fin_one]

example : Measure.dirac a {d} = 0 := by
  norm_num [Measure.dirac_apply, Set.indicator_apply, a, d, funext_iff, Fin.forall_fin_two]

-- Extending the normalized-fiber measure formula to this ambient input is false:
-- its normalized restrictions vanish, while the actual randomScan remains Markov.
example : randomScan (Measure.dirac a) d ≠
    (2 : ℝ≥0∞)⁻¹ • ∑ i : Fin 2,
      cond (Measure.dirac a) {z : State | (fun j => z (i.succAbove j)) =
        (fun j => d (i.succAbove j))} := by
  simp only [cond_eq_zero_of_meas_eq_zero (null_fibers _), Finset.sum_const_zero, smul_zero]
  intro h
  have hmass := congrArg (fun ν : Measure State => ν Set.univ) h
  simp only [measure_univ, Measure.coe_zero, Pi.zero_apply] at hmass
  exact one_ne_zero hmass

-- With a single site the retained tuple is empty and one move draws the whole target.
example (μ : Measure (Fin 1 → Bool)) [IsProbabilityMeasure μ]
    (x y : Fin 1 → Bool) (hx : μ {x} ≠ 0) : randomScan μ x {y} = μ {y} := by
  rw [randomScan_apply_singleton μ x y hx, Fin.sum_univ_one]
  simp [Fin.forall_fin_one, funext_iff]

-- Existing invariance and finite powers consume this actual random-scan kernel.
-- These are test-consumer inputs, not extra proof parents of the singleton law.
example {n : ℕ} (μ : Measure (Fin (n + 1) → Bool)) [IsProbabilityMeasure μ]
    (k : ℕ) : ((randomScan μ) ^ k).Invariant μ := by
  apply KernelInvariance.invariant_pow
  apply KernelMixture.finiteMixture_invariant
  · simp [Finset.sum_const, nsmul_eq_mul, Nat.cast_add, Nat.cast_one]
  · exact fun i => CoordinateHeatBath.heatBath_invariant _ μ i

#check @randomScan
#check @randomScan_isMarkovKernel
#check @randomScan_apply_singleton
#print axioms randomScan
#print axioms randomScan_isMarkovKernel
#print axioms randomScan_apply_singleton

end AutoSamplingTheory.Tests.RandomScanHeatBath
