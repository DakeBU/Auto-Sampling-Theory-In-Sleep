import AutoSamplingTheory.TechnicalLemmas.Analysis.PairingCyclicMonotonicity
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Order.ConditionallyCompleteLattice.Basic
import Mathlib.Topology.Order.WithTop

/-!
# Finite-chain core of the Rockafellar construction

This module starts the ASTIS-native construction of a convex potential from a
pairing-cyclically-monotone relation. Unlike list-recursive presentations, the
chain is represented directly by a tuple `Fin (n+1) → E × E`, matching the
finite-cycle language used by `PairingCycleMonotone`.

For a chain `(x_0,y_0),...,(x_n,y_n)`, its value at `z` is

`sum_{i<n} <y_i, x_{i+1}-x_i> + <y_n, z-x_n>`.

At `z=x_0` this is exactly the closed-cycle increment sum. Consequently a
pairing-cyclically-monotone relation bounds every rooted chain value at its
root by zero. This is the normalization estimate later used to prove that the
proper `WithTop ℝ` Rockafellar supremum is finite somewhere.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Analysis
namespace RockafellarFiniteChain

open PairingCyclicMonotonicity
open scoped BigOperators

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

/-- Affine value of a finite nonempty chain at a query point. -/
def finiteChainValue {n : ℕ} (p : Fin (n + 1) → E × E) (z : E) : ℝ :=
  (∑ i : Fin n,
      inner ℝ (p i.castSucc).2 ((p i.succ).1 - (p i.castSucc).1)) +
    inner ℝ (p (Fin.last n)).2 (z - (p (Fin.last n)).1)

/-- The same chain closed back to its first source point. -/
def closedCycleValue {n : ℕ} (p : Fin (n + 1) → E × E) : ℝ :=
  (∑ i : Fin n,
      inner ℝ (p i.castSucc).2 ((p i.succ).1 - (p i.castSucc).1)) +
    inner ℝ (p (Fin.last n)).2 ((p 0).1 - (p (Fin.last n)).1)

/-- Evaluating a chain at its first source point closes the chain into a
cycle. -/
theorem finiteChainValue_at_first
    {n : ℕ} (p : Fin (n + 1) → E × E) :
    finiteChainValue p (p 0).1 = closedCycleValue p := by
  rfl

/-- The split first-`n`-edges plus closing-edge expression is exactly the
cyclic `Fin (n+1)` increment sum used by `PairingCycleMonotone`. -/
theorem closedCycleValue_eq_cycle_sum
    {n : ℕ} (p : Fin (n + 1) → E × E) :
    closedCycleValue p =
      ∑ i : Fin (n + 1),
        inner ℝ (p i).2 ((p (i + 1)).1 - (p i).1) := by
  rw [Fin.sum_univ_castSucc]
  unfold closedCycleValue
  congr 1
  · apply Finset.sum_congr rfl
    intro i _hi
    have hsucc : (i.castSucc + 1 : Fin (n + 1)) = i.succ := by
      fin_omega
    rw [hsucc]
  · have hlast : (Fin.last n + 1 : Fin (n + 1)) = 0 := by
      fin_omega
    rw [hlast]

/-- A rooted finite chain consists of finitely many points of `Gamma` with a
chosen first point. -/
structure RootedFiniteChain (base : E × E) (Gamma : Set (E × E)) where
  steps : ℕ
  point : Fin (steps + 1) → E × E
  root_eq : point 0 = base
  mem_relation : ∀ i, point i ∈ Gamma

namespace RootedFiniteChain

variable {base : E × E} {Gamma : Set (E × E)}

/-- Value of a rooted finite chain. -/
def value (c : RootedFiniteChain base Gamma) (z : E) : ℝ :=
  finiteChainValue c.point z

/-- The one-point rooted chain. -/
def singleton (base : E × E) {Gamma : Set (E × E)}
    (hbase : base ∈ Gamma) : RootedFiniteChain base Gamma where
  steps := 0
  point := fun _ => base
  root_eq := rfl
  mem_relation := fun _ => hbase

@[simp]
theorem singleton_value
    (base : E × E) {Gamma : Set (E × E)} (hbase : base ∈ Gamma) (z : E) :
    (singleton base hbase).value z = inner ℝ base.2 (z - base.1) := by
  simp [value, finiteChainValue, singleton]

/-- At the root, the chain value is its closed-cycle value. -/
theorem value_at_root_eq_closedCycleValue
    (c : RootedFiniteChain base Gamma) :
    c.value base.1 = closedCycleValue c.point := by
  rw [← c.root_eq]
  exact finiteChainValue_at_first c.point

/-- Cyclic monotonicity forces every rooted chain to have nonpositive value at
the root. This is the key finiteness normalization for the later proper
Rockafellar supremum. -/
theorem value_at_root_nonpos
    (hmono : PairingCycleMonotone Gamma)
    (c : RootedFiniteChain base Gamma) :
    c.value base.1 ≤ 0 := by
  rw [c.value_at_root_eq_closedCycleValue,
    closedCycleValue_eq_cycle_sum]
  exact hmono c.steps c.point c.mem_relation

end RootedFiniteChain

/-- Real values attained at `z` by finite chains rooted at `base`. -/
def rockafellarValueSet
    (base : E × E) (Gamma : Set (E × E)) (z : E) : Set ℝ :=
  {r | ∃ c : RootedFiniteChain base Gamma, r = c.value z}

/-- Coercion of rooted finite-chain values to `WithTop ℝ`. -/
def properRockafellarValueSet
    (base : E × E) (Gamma : Set (E × E)) (z : E) : Set (WithTop ℝ) :=
  ((↑) : ℝ → WithTop ℝ) '' rockafellarValueSet base Gamma z

/-- Proper Rockafellar candidate: the pointwise supremum of all rooted
finite-chain affine values. No properness or convexity claim is bundled into
the definition. -/
noncomputable def properRockafellarPotential
    (base : E × E) (Gamma : Set (E × E)) (z : E) : WithTop ℝ :=
  sSup (properRockafellarValueSet base Gamma z)

/-- If the root belongs to the relation, the real chain-value set is nonempty
at every query point. -/
theorem rockafellarValueSet_nonempty
    {base : E × E} {Gamma : Set (E × E)}
    (hbase : base ∈ Gamma) (z : E) :
    (rockafellarValueSet base Gamma z).Nonempty := by
  refine ⟨(RootedFiniteChain.singleton base hbase).value z, ?_⟩
  exact ⟨RootedFiniteChain.singleton base hbase, rfl⟩

/-- The extended-real value set is likewise nonempty. -/
theorem properRockafellarValueSet_nonempty
    {base : E × E} {Gamma : Set (E × E)}
    (hbase : base ∈ Gamma) (z : E) :
    (properRockafellarValueSet base Gamma z).Nonempty := by
  rcases rockafellarValueSet_nonempty hbase z with ⟨r, hr⟩
  exact ⟨(r : WithTop ℝ), ⟨r, hr, rfl⟩⟩

end

end RockafellarFiniteChain
end Analysis
end TechnicalLemmas
end AutoSamplingTheory
