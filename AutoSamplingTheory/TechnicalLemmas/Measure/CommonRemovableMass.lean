import AutoSamplingTheory.TechnicalLemmas.Measure.CommonMass
import Mathlib.Data.Finset.Max

/-!
# A common removable mass for a finite family

The direct Brenier perturbation starts from finitely many positive local finite
measures.  Before changing their pairings, one must remove exactly the same
amount of mass from every local piece.

This module isolates that finite-order argument.  For a nonempty cycle indexed
by `Fin (n+1)`, the common removable mass is the minimum of the local total
masses.  It is no larger than any local mass, is attained by one local piece,
and is strictly positive whenever every local mass is strictly positive.

No topology, transport cost, coupling, support, or optimality appears here.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace CommonRemovableMass

open MeasureTheory

noncomputable section

variable {X : Type*} [MeasurableSpace X]

/-- The finite set of total masses of a nonempty finite family of measures. -/
noncomputable def localMassSet {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) : Finset ℝ≥0 :=
  Finset.univ.image fun i => (mu i).mass

/-- The local-mass set is nonempty because `Fin (n+1)` contains `0`. -/
theorem localMassSet_nonempty {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) :
    (localMassSet mu).Nonempty := by
  refine ⟨(mu 0).mass, ?_⟩
  simp [localMassSet]

/-- Minimum total mass among a nonempty finite family of local measures. -/
noncomputable def commonRemovableMass {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) : ℝ≥0 :=
  (localMassSet mu).min' (localMassSet_nonempty mu)

/-- The common removable mass is bounded above by every local total mass. -/
theorem commonRemovableMass_le {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) (i : Fin (n + 1)) :
    commonRemovableMass mu ≤ (mu i).mass := by
  have hi : (mu i).mass ∈ localMassSet mu := by
    simp [localMassSet]
  simpa [commonRemovableMass] using
    (Finset.min'_le (localMassSet mu) (mu i).mass hi)

/-- One local piece attains the common removable mass. -/
theorem exists_mass_eq_commonRemovableMass {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X) :
    ∃ i : Fin (n + 1), (mu i).mass = commonRemovableMass mu := by
  have hmem := Finset.min'_mem (localMassSet mu) (localMassSet_nonempty mu)
  rcases Finset.mem_image.mp hmem with ⟨i, _hi, hmass⟩
  exact ⟨i, by simpa [commonRemovableMass] using hmass⟩

/-- If every local finite measure has positive total mass, then their common
removable mass is positive. -/
theorem commonRemovableMass_pos {n : ℕ}
    (mu : Fin (n + 1) → FiniteMeasure X)
    (hpos : ∀ i, 0 < (mu i).mass) :
    0 < commonRemovableMass mu := by
  obtain ⟨i, hi⟩ := exists_mass_eq_commonRemovableMass mu
  rw [← hi]
  exact hpos i

end

end CommonRemovableMass
end Measure
end TechnicalLemmas
end AutoSamplingTheory
