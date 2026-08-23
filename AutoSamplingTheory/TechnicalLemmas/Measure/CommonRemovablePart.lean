import AutoSamplingTheory.TechnicalLemmas.Measure.CommonRemovableMass

/-!
# Equal-mass removable parts of a finite family

The direct Brenier perturbation needs more than a positive common scalar: from
each positive local finite measure it must actually remove a submeasure of
exactly that common mass.

For a nonempty family `mu : Fin (n+1) → FiniteMeasure X`, this module scales
`mu i` by `commonRemovableMass mu / (mu i).mass`.  The scale is at most one,
the resulting removable part has exactly the common mass when all local masses
are positive, and the original local measure splits as removable part plus a
nonnegative remainder.  The latter gives an explicit domination certificate at
the underlying `Measure` level.

This is still pure finite-measure algebra: there is no topology, support,
transport cost, cyclic shift, or optimality argument here.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace CommonRemovablePart

open MeasureTheory
open CommonRemovableMass

noncomputable section

variable {X : Type*} [MeasurableSpace X]

/-- Fraction of the `i`-th local measure removed by the common-mass
construction. -/
noncomputable def removableScale {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) (i : Fin (n + 1)) : ℝ≥0 :=
  commonRemovableMass mu / (mu i).mass

/-- Every common-removal scale lies in `[0,1]`. -/
theorem removableScale_le_one {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) (i : Fin (n + 1)) :
    removableScale mu i ≤ 1 := by
  unfold removableScale
  apply NNReal.div_le_of_le_mul'
  simpa using commonRemovableMass_le mu i

/-- The piece removed from the `i`-th local finite measure. -/
noncomputable def commonRemovablePart {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) (i : Fin (n + 1)) : FiniteMeasure X :=
  removableScale mu i • mu i

/-- The complementary piece left after removing the common-mass part. -/
noncomputable def commonRemainderPart {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) (i : Fin (n + 1)) : FiniteMeasure X :=
  (1 - removableScale mu i) • mu i

/-- Each local measure splits exactly into its common removable part and its
remainder.  This is the algebraic certificate that the perturbation never
removes more local mass than is available. -/
theorem commonRemovablePart_add_remainder {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) (i : Fin (n + 1)) :
    commonRemovablePart mu i + commonRemainderPart mu i = mu i := by
  rw [commonRemovablePart, commonRemainderPart, ← add_smul]
  rw [add_tsub_cancel_of_le (removableScale_le_one mu i)]
  simp

/-- The removable part is dominated by the original local measure, stated on
the underlying ordered `Measure` type. -/
theorem commonRemovablePart_toMeasure_le {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) (i : Fin (n + 1)) :
    (↑(commonRemovablePart mu i) : Measure X) ≤ ↑(mu i) := by
  have hdecomp :=
    congrArg (fun eta : FiniteMeasure X => (eta : Measure X))
      (commonRemovablePart_add_remainder mu i)
  simp only [FiniteMeasure.toMeasure_add] at hdecomp
  rw [← hdecomp]
  exact Measure.le_add_right le_rfl

/-- If every local piece has positive mass, every removable part has exactly
the chosen common removable mass. -/
theorem commonRemovablePart_mass {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X)
    (hpos : ∀ i, 0 < (mu i).mass) (i : Fin (n + 1)) :
    (commonRemovablePart mu i).mass = commonRemovableMass mu := by
  rw [commonRemovablePart, CommonMass.mass_smul_nnreal]
  unfold removableScale
  exact div_mul_cancel₀ _ (ne_of_gt (hpos i))

/-- Under the positive-local-mass hypothesis, every removable part has positive
mass. -/
theorem commonRemovablePart_mass_pos {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X)
    (hpos : ∀ i, 0 < (mu i).mass) (i : Fin (n + 1)) :
    0 < (commonRemovablePart mu i).mass := by
  rw [commonRemovablePart_mass mu hpos i]
  exact commonRemovableMass_pos mu hpos

/-- Any two removable parts have exactly the same total mass. -/
theorem commonRemovablePart_mass_eq {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X)
    (hpos : ∀ i, 0 < (mu i).mass) (i j : Fin (n + 1)) :
    (commonRemovablePart mu i).mass = (commonRemovablePart mu j).mass := by
  rw [commonRemovablePart_mass mu hpos i, commonRemovablePart_mass mu hpos j]

end

end CommonRemovablePart
end Measure
end TechnicalLemmas
end AutoSamplingTheory
