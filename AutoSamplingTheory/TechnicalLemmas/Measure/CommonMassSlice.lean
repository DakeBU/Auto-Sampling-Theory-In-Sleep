import AutoSamplingTheory.TechnicalLemmas.Measure.CommonRemovableMass
import Mathlib.MeasureTheory.Measure.Sub

/-!
# Equal-mass slices of finite measures

Given a finite measure `mu` with positive total mass and a target mass `t` no
larger than `mu.mass`, the scalar multiple

`t / mu.mass • mu`

is a canonical submeasure of `mu` with total mass exactly `t`.

Applied to the minimum mass of a finite family, this produces one dominated
slice from every local piece, all with exactly the same positive mass.  These
are the pieces that the direct Brenier perturbation will remove and then
re-pair cyclically.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace CommonMassSlice

open MeasureTheory
open CommonMass CommonRemovableMass
open scoped NNReal ENNReal

noncomputable section

variable {X : Type*} [MeasurableSpace X]

/-- Canonical slice of a finite measure with prescribed target mass. -/
noncomputable def commonMassSlice (t : ℝ≥0) (mu : FiniteMeasure X) :
    FiniteMeasure X :=
  (t / mu.mass) • mu

/-- If the ambient finite measure has positive mass, its canonical slice has
exactly the prescribed total mass. -/
theorem commonMassSlice_mass (t : ℝ≥0) (mu : FiniteMeasure X)
    (hpos : 0 < mu.mass) :
    (commonMassSlice t mu).mass = t := by
  have hne : mu.mass ≠ 0 := ne_of_gt hpos
  rw [commonMassSlice, mass_smul_nnreal]
  simp [div_eq_mul_inv, hne, mul_assoc]

/-- If the target mass is no larger than the ambient mass, the canonical slice
is dominated by the original measure.  The domination statement is made on
underlying `Measure`s because this is exactly the order needed for later
measure subtraction. -/
theorem commonMassSlice_toMeasure_le (t : ℝ≥0) (mu : FiniteMeasure X)
    (hpos : 0 < mu.mass) (ht : t ≤ mu.mass) :
    ((commonMassSlice t mu : FiniteMeasure X) : Measure X) ≤ (mu : Measure X) := by
  have hscale : t / mu.mass ≤ 1 := (div_le_one hpos.le).2 ht
  rw [Measure.le_iff]
  intro s hs
  change ((t / mu.mass : ℝ≥0) : ℝ≥0∞) * (mu : Measure X) s ≤ (mu : Measure X) s
  calc
    ((t / mu.mass : ℝ≥0) : ℝ≥0∞) * (mu : Measure X) s
        ≤ 1 * (mu : Measure X) s :=
      mul_le_mul_right' (ENNReal.coe_le_coe.mpr hscale) _
    _ = (mu : Measure X) s := one_mul _

/-- The equal-mass slice family obtained by using the minimum local mass as
the target for every member of a nonempty finite family. -/
noncomputable def commonMassSliceFamily {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) (i : Fin (n + 1)) :
    FiniteMeasure X :=
  commonMassSlice (commonRemovableMass mu) (mu i)

/-- Every member of the canonical slice family has exactly the same total
mass. -/
theorem commonMassSliceFamily_mass {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X)
    (hpos : ∀ i, 0 < (mu i).mass) (i : Fin (n + 1)) :
    (commonMassSliceFamily mu i).mass = commonRemovableMass mu := by
  exact commonMassSlice_mass _ _ (hpos i)

/-- Every canonical equal-mass slice is dominated by its corresponding local
measure. -/
theorem commonMassSliceFamily_toMeasure_le {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X)
    (hpos : ∀ i, 0 < (mu i).mass) (i : Fin (n + 1)) :
    ((commonMassSliceFamily mu i : FiniteMeasure X) : Measure X) ≤
      (mu i : Measure X) := by
  exact commonMassSlice_toMeasure_le _ _ (hpos i) (commonRemovableMass_le mu i)

/-- Under positive local masses, the common mass carried by every canonical
slice is itself strictly positive. -/
theorem commonMassSliceFamily_mass_pos {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X)
    (hpos : ∀ i, 0 < (mu i).mass) (i : Fin (n + 1)) :
    0 < (commonMassSliceFamily mu i).mass := by
  rw [commonMassSliceFamily_mass mu hpos i]
  exact commonRemovableMass_pos mu hpos

end

end CommonMassSlice
end Measure
end TechnicalLemmas
end AutoSamplingTheory
