import AutoSamplingTheory.TechnicalLemmas.Probability.CoordinateHeatBathConditional
import AutoSamplingTheory.TechnicalLemmas.Probability.KernelMixture
import AutoSamplingTheory.TechnicalLemmas.Probability.KernelInvariance

namespace AutoSamplingTheory.Tests.CoordinateHeatBathConditional

open MeasureTheory ProbabilityTheory
open scoped ENNReal NNReal
open AutoSamplingTheory.TechnicalLemmas.Probability

-- A positive-mass starting configuration lies in its retained fiber.
-- This consumer adapter adds no public duplicate of measure monotonicity.
private theorem fiber_ne_zero_of_atom {n : ℕ} (X : Fin (n + 1) → Type*)
    [∀ j, MeasurableSpace (X j)] (μ : Measure (∀ j, X j))
    (i : Fin (n + 1)) (x : ∀ j, X j) (hx : μ {x} ≠ 0) :
    μ {y | (fun j => y (i.succAbove j)) = (fun j => x (i.succAbove j))} ≠ 0 := by
  have hle : μ {x} ≤
      μ {y | (fun j => y (i.succAbove j)) = (fun j => x (i.succAbove j))} :=
    measure_mono (Set.singleton_subset_iff.mpr rfl)
  intro hzero
  exact hx (le_antisymm (hzero ▸ hle) bot_le)

-- The upper endpoint needed for normalization follows from finite mass.
example {n : ℕ} (X : Fin (n + 1) → Type*) [∀ j, MeasurableSpace (X j)]
    (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ] (i : Fin (n + 1)) (x : ∀ j, X j) :
    μ {y | (fun j => y (i.succAbove j)) = (fun j => x (i.succAbove j))} ≠ ∞ :=
  measure_ne_top _ _

-- Exact singleton transition formula, retaining the mismatch branch explicitly.
open Classical in
private theorem singleton_transition {n : ℕ} (X : Fin (n + 1) → Type*)
    [∀ j, MeasurableSpace (X j)] [∀ j, MeasurableSingletonClass (X j)]
    (μ : Measure (∀ j, X j)) [IsFiniteMeasure μ]
    (i : Fin (n + 1)) [StandardBorelSpace (X i)] [Nonempty (X i)]
    (x y : ∀ j, X j)
    (hx : μ {z | (fun j => z (i.succAbove j)) = (fun j => x (i.succAbove j))} ≠ 0) :
    CoordinateHeatBath.heatBath X μ i x {y} =
      if (fun j => y (i.succAbove j)) = (fun j => x (i.succAbove j)) then
        (μ {z | (fun j => z (i.succAbove j)) = (fun j => x (i.succAbove j))})⁻¹ * μ {y}
      else 0 := by
  classical
  rw [CoordinateHeatBath.heatBath_eq_cond X μ i x hx,
    cond_apply' (measurableSet_singleton _)]
  split_ifs with hy
  · rw [Set.inter_singleton_of_mem (show y ∈
      {z | (fun j => z (i.succAbove j)) = (fun j => x (i.succAbove j))} from hy)]
  · rw [Set.inter_singleton_of_notMem (show y ∉
      {z | (fun j => z (i.succAbove j)) = (fun j => x (i.succAbove j))} from hy),
      measure_empty, mul_zero]

private abbrev State := Fin 3 → Bool
private def a : State := ![false, false, false]
private def b : State := ![false, true, false]
private def c : State := ![true, false, false]
private def off : State := ![false, false, true]

-- A nontrivial supported joint probability: weights 1/6, 1/2, 1/3.
private noncomputable def joint : Measure State :=
  (1 / 6 : ℝ≥0) • Measure.dirac a +
    (1 / 2 : ℝ≥0) • Measure.dirac b + (1 / 3 : ℝ≥0) • Measure.dirac c

local instance : IsFiniteMeasure (α := Fin (2 + 1) → Bool) joint := by
  unfold joint
  infer_instance

local instance : IsProbabilityMeasure (α := Fin (2 + 1) → Bool) joint := by
  constructor
  norm_num [joint, Measure.add_apply, Measure.smul_apply, measure_univ]
  simpa using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
    (show (1 / 6 : ℝ≥0) + 1 / 2 + 1 / 3 = 1 by norm_num)

private theorem fiber_a :
    {y : State | (fun j => y ((1 : Fin 3).succAbove j)) =
      (fun j => a ((1 : Fin 3).succAbove j))} = {y : State | y 0 = false ∧ y 2 = false} := by
  ext y
  simp [a, funext_iff, Fin.forall_fin_two]

private theorem fiber_a_mass :
    joint {y : State | (fun j => y ((1 : Fin 3).succAbove j)) =
      (fun j => a ((1 : Fin 3).succAbove j))} = 2 / 3 := by
  rw [fiber_a]
  norm_num [joint, Measure.add_apply, Measure.smul_apply, Measure.dirac_apply,
    a, b, c, Set.indicator_apply, Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]
  simpa using congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
    (show (1 / 6 : ℝ≥0) + 1 / 2 = 2 / 3 by norm_num)

-- The real kernel conditionally gives a probability different from target mass.
example : CoordinateHeatBath.heatBath (fun _ : Fin 3 => Bool) joint 1 a {b} = 3 / 4 := by
  rw [singleton_transition _ joint 1 a b (by rw [fiber_a_mass]; norm_num)]
  rw [if_pos (by decide), fiber_a_mass]
  norm_num [joint, Measure.add_apply, Measure.smul_apply,
    Measure.dirac_apply, Set.indicator_apply, a, b, c, funext_iff, Fin.forall_fin_two,
    Fin.forall_fin_succ, Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]
  rw [ENNReal.inv_div (by simp) (by simp)]
  simpa using
    congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
      (show (2 / 3 : ℝ≥0)⁻¹ * (1 / 2) = 3 / 4 by norm_num)

example : CoordinateHeatBath.heatBath (fun _ : Fin 3 => Bool) joint 1 a {a} = 1 / 4 := by
  rw [singleton_transition _ joint 1 a a (by rw [fiber_a_mass]; norm_num)]
  rw [if_pos rfl, fiber_a_mass]
  norm_num [joint, Measure.add_apply, Measure.smul_apply,
    Measure.dirac_apply, Set.indicator_apply, a, b, c, funext_iff, Fin.forall_fin_succ,
    Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]
  rw [ENNReal.inv_div (by simp) (by simp)]
  simpa using
    congrArg (fun r : ℝ≥0 => (r : ℝ≥0∞))
      (show (2 / 3 : ℝ≥0)⁻¹ * (1 / 6) = 1 / 4 by norm_num)

-- Changing a retained coordinate has transition probability zero.
example : CoordinateHeatBath.heatBath (fun _ : Fin 3 => Bool) joint 1 a {c} = 0 := by
  rw [singleton_transition _ joint 1 a c (by rw [fiber_a_mass]; norm_num)]
  norm_num [a, c, funext_iff, Fin.forall_fin_two]

-- Supported start supplies its denominator by inclusion, not feasibility fiat.
example : CoordinateHeatBath.heatBath (fun _ : Fin 3 => Bool) joint 1 b =
    cond joint {y : State | (fun j => y ((1 : Fin 3).succAbove j)) =
      (fun j => b ((1 : Fin 3).succAbove j))} := by
  apply CoordinateHeatBath.heatBath_eq_cond
  apply fiber_ne_zero_of_atom
  norm_num [joint, Measure.add_apply, Measure.smul_apply, Measure.dirac_apply,
    Set.indicator_apply, a, b, c, funext_iff, Fin.forall_fin_succ,
    Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]

private theorem null_fiber :
    joint {y : State | (fun j => y ((1 : Fin 3).succAbove j)) =
      (fun j => off ((1 : Fin 3).succAbove j))} = 0 := by
  norm_num [joint, Measure.add_apply, Measure.smul_apply, Measure.dirac_apply,
    Set.indicator_apply, a, b, c, off, funext_iff, Fin.forall_fin_two,
    Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons]

-- A nonzero target can have a null retained fiber. Its normalized restriction
-- is zero, whereas the actual selected conditional version is always Markov.
example : CoordinateHeatBath.heatBath (fun _ : Fin 3 => Bool) joint 1 off ≠
    cond joint {y : State | (fun j => y ((1 : Fin 3).succAbove j)) =
      (fun j => off ((1 : Fin 3).succAbove j))} := by
  rw [cond_eq_zero_of_meas_eq_zero null_fiber]
  intro h
  have hmass := congrArg (fun ν : Measure State => ν Set.univ) h
  simp only [measure_univ, Measure.coe_zero, Pi.zero_apply] at hmass
  exact one_ne_zero hmass

-- Existing mixture/power laws continue to consume this very kernel.
example (w : Fin 3 → ℝ≥0) (hw : ∑ i, w i = 1) (k : ℕ) :
    ((KernelMixture.finiteMixture w
      (fun i => CoordinateHeatBath.heatBath (fun _ : Fin 3 => Bool) joint i)) ^ k).Invariant
      joint := by
  apply KernelInvariance.invariant_pow
  exact KernelMixture.finiteMixture_invariant w _ joint hw
    (fun i => CoordinateHeatBath.heatBath_invariant _ joint i)

#check @CoordinateHeatBath.heatBath_eq_cond
#print axioms CoordinateHeatBath.heatBath_eq_cond

end AutoSamplingTheory.Tests.CoordinateHeatBathConditional
