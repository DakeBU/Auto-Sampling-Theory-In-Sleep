import AutoSamplingTheory.TechnicalLemmas.Measure.CommonMass
import Mathlib.Algebra.BigOperators.Group.Finset.Defs

/-!
# Permuted equal-mass marginal replacement

This module is the finite-measure re-pairing core used by the direct Brenier
perturbation. Starting from finitely many joint finite measures of one common
positive mass, it keeps every source marginal fixed, permutes the target
marginals, and joins each new pair with `CommonMass.commonMassProduct`.

The output is global: after summing all replacement blocks, both total
marginals agree exactly with those of the original sum. The construction is
independent of how the equal-mass blocks were obtained and independent of the
particular permutation. Later DAG nodes can therefore instantiate it with
common-mass slices and the cyclic successor separately.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace PermutedMarginalReplacement

open MeasureTheory
open CommonMass
open scoped BigOperators NNReal

noncomputable section

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]

/-- A measurable map preserves the total mass of a finite measure. -/
theorem mass_map_of_measurable
    {A B : Type*} [MeasurableSpace A] [MeasurableSpace B]
    (rho : FiniteMeasure A) (f : A → B) (hf : Measurable f) :
    (rho.map f).mass = rho.mass := by
  unfold FiniteMeasure.mass
  rw [FiniteMeasure.map_apply rho hf MeasurableSet.univ]
  simp

/-- First marginal of a finite joint measure. -/
noncomputable def sourceMarginal (rho : FiniteMeasure (X × Y)) : FiniteMeasure X :=
  rho.map Prod.fst

/-- Second marginal of a finite joint measure. -/
noncomputable def targetMarginal (rho : FiniteMeasure (X × Y)) : FiniteMeasure Y :=
  rho.map Prod.snd

@[simp]
theorem sourceMarginal_mass (rho : FiniteMeasure (X × Y)) :
    (sourceMarginal rho).mass = rho.mass := by
  exact mass_map_of_measurable rho Prod.fst measurable_fst

@[simp]
theorem targetMarginal_mass (rho : FiniteMeasure (X × Y)) :
    (targetMarginal rho).mass = rho.mass := by
  exact mass_map_of_measurable rho Prod.snd measurable_snd

/-- Pushforward commutes with a finite sum of finite measures. -/
theorem map_finset_sum
    {A B I : Type*} [MeasurableSpace A] [MeasurableSpace B]
    (s : Finset I) (rho : I → FiniteMeasure A) (f : A → B)
    (hf : Measurable f) :
    (∑ i in s, rho i).map f = ∑ i in s, (rho i).map f := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | @insert a s ha ih =>
      rw [Finset.sum_insert ha, FiniteMeasure.map_add hf, ih, Finset.sum_insert ha]

/-- Fintype form of `map_finset_sum`. -/
theorem map_fintype_sum
    {A B I : Type*} [MeasurableSpace A] [MeasurableSpace B] [Fintype I]
    (rho : I → FiniteMeasure A) (f : A → B) (hf : Measurable f) :
    (∑ i, rho i).map f = ∑ i, (rho i).map f := by
  classical
  exact map_finset_sum Finset.univ rho f hf

/-- Re-pair the source marginal of block `i` with the target marginal of block
`σ i`. Equal positive block masses make the common-mass product legitimate. -/
noncomputable def permutedMarginalJoint {n : ℕ}
    (rho : Fin (n + 1) → FiniteMeasure (X × Y))
    (σ : Equiv.Perm (Fin (n + 1))) (i : Fin (n + 1)) :
    FiniteMeasure (X × Y) :=
  commonMassProduct (sourceMarginal (rho i)) (targetMarginal (rho (σ i)))

/-- Every re-paired block keeps the source marginal of its original index. -/
theorem permutedMarginalJoint_map_fst {n : ℕ}
    (rho : Fin (n + 1) → FiniteMeasure (X × Y))
    (σ : Equiv.Perm (Fin (n + 1))) (m : ℝ≥0)
    (hmass : ∀ i, (rho i).mass = m) (hpos : 0 < m)
    (i : Fin (n + 1)) :
    (permutedMarginalJoint rho σ i).map Prod.fst = sourceMarginal (rho i) := by
  apply commonMassProduct_map_fst
  · simp [hmass]
  · simpa [hmass] using hpos

/-- Every re-paired block receives the target marginal indexed by `σ i`. -/
theorem permutedMarginalJoint_map_snd {n : ℕ}
    (rho : Fin (n + 1) → FiniteMeasure (X × Y))
    (σ : Equiv.Perm (Fin (n + 1))) (m : ℝ≥0)
    (hmass : ∀ i, (rho i).mass = m) (hpos : 0 < m)
    (i : Fin (n + 1)) :
    (permutedMarginalJoint rho σ i).map Prod.snd = targetMarginal (rho (σ i)) := by
  apply commonMassProduct_map_snd
  · simp [hmass]
  · simpa [hmass] using hpos

/-- Every re-paired block still has the common block mass. -/
theorem permutedMarginalJoint_mass {n : ℕ}
    (rho : Fin (n + 1) → FiniteMeasure (X × Y))
    (σ : Equiv.Perm (Fin (n + 1))) (m : ℝ≥0)
    (hmass : ∀ i, (rho i).mass = m) (hpos : 0 < m)
    (i : Fin (n + 1)) :
    (permutedMarginalJoint rho σ i).mass = m := by
  calc
    (permutedMarginalJoint rho σ i).mass
        = (sourceMarginal (rho i)).mass := by
          apply commonMassProduct_mass
          · simp [hmass]
          · simpa [hmass] using hpos
    _ = (rho i).mass := sourceMarginal_mass (rho i)
    _ = m := hmass i

/-- Sum of all re-paired equal-mass blocks. -/
noncomputable def permutedMarginalReplacement {n : ℕ}
    (rho : Fin (n + 1) → FiniteMeasure (X × Y))
    (σ : Equiv.Perm (Fin (n + 1))) : FiniteMeasure (X × Y) :=
  ∑ i, permutedMarginalJoint rho σ i

/-- The replacement sum has the same first marginal as the sum of the original
blocks. -/
theorem permutedMarginalReplacement_map_fst {n : ℕ}
    (rho : Fin (n + 1) → FiniteMeasure (X × Y))
    (σ : Equiv.Perm (Fin (n + 1))) (m : ℝ≥0)
    (hmass : ∀ i, (rho i).mass = m) (hpos : 0 < m) :
    (permutedMarginalReplacement rho σ).map Prod.fst =
      (∑ i, rho i).map Prod.fst := by
  classical
  rw [permutedMarginalReplacement, map_fintype_sum]
  calc
    ∑ i, (permutedMarginalJoint rho σ i).map Prod.fst
        = ∑ i, sourceMarginal (rho i) := by
          apply Finset.sum_congr rfl
          intro i _hi
          exact permutedMarginalJoint_map_fst rho σ m hmass hpos i
    _ = ∑ i, (rho i).map Prod.fst := by rfl
    _ = (∑ i, rho i).map Prod.fst := by
          symm
          exact map_fintype_sum rho Prod.fst measurable_fst

/-- The replacement sum has the same second marginal as the sum of the original
blocks. The only extra ingredient is invariance of a finite sum under `σ`. -/
theorem permutedMarginalReplacement_map_snd {n : ℕ}
    (rho : Fin (n + 1) → FiniteMeasure (X × Y))
    (σ : Equiv.Perm (Fin (n + 1))) (m : ℝ≥0)
    (hmass : ∀ i, (rho i).mass = m) (hpos : 0 < m) :
    (permutedMarginalReplacement rho σ).map Prod.snd =
      (∑ i, rho i).map Prod.snd := by
  classical
  rw [permutedMarginalReplacement, map_fintype_sum]
  calc
    ∑ i, (permutedMarginalJoint rho σ i).map Prod.snd
        = ∑ i, targetMarginal (rho (σ i)) := by
          apply Finset.sum_congr rfl
          intro i _hi
          exact permutedMarginalJoint_map_snd rho σ m hmass hpos i
    _ = ∑ i, targetMarginal (rho i) :=
          Equiv.sum_comp σ (fun i => targetMarginal (rho i))
    _ = ∑ i, (rho i).map Prod.snd := by rfl
    _ = (∑ i, rho i).map Prod.snd := by
          symm
          exact map_fintype_sum rho Prod.snd measurable_snd

end

end PermutedMarginalReplacement
end Measure
end TechnicalLemmas
end AutoSamplingTheory
