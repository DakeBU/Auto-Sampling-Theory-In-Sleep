import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FiniteTimeGrid
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic

/-!
# Deterministic mesh estimate for quadratic variation

The probabilistic quadratic-variation proof eventually reduces to a finite
sum of squared cell lengths.  This file isolates the deterministic inequality

`sum_i a_i^2 <= mesh * sum_i a_i`

under `0 <= a_i <= mesh`, so the Brownian-independence packet and the mesh
algebra do not share proof obligations.

The second half specializes this algebra to the canonical dyadic grids already
used by the Itô approximation layer.  It therefore supplies the exact bridge

`finite-grid Brownian L2 identity -> mesh bound -> mesh tends to zero`

without reopening any probabilistic argument.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace QuadraticVariationMesh

open scoped BigOperators NNReal

open SampledElementaryApproximation

/-- A finite collection of nonnegative cell lengths bounded by `mesh` has
sum of squares at most `mesh` times its total length. -/
theorem sum_sq_le_mesh_mul_sum
    {ι : Type*} [Fintype ι]
    (a : ι → ℝ) (mesh : ℝ)
    (ha : ∀ i, 0 ≤ a i)
    (hmesh : ∀ i, a i ≤ mesh) :
    (∑ i, (a i) ^ 2) ≤ mesh * ∑ i, a i := by
  calc
    (∑ i, (a i) ^ 2) ≤ ∑ i, mesh * a i := by
      apply Finset.sum_le_sum
      intro i _
      rw [pow_two]
      exact mul_le_mul_of_nonneg_right (hmesh i) (ha i)
    _ = mesh * ∑ i, a i := by
      rw [Finset.mul_sum]

/-- If the total cell length is `T`, the same estimate is the familiar
`sum_i a_i^2 <= mesh * T`. -/
theorem sum_sq_le_mesh_mul_total
    {ι : Type*} [Fintype ι]
    (a : ι → ℝ) (mesh T : ℝ)
    (ha : ∀ i, 0 ≤ a i)
    (hmesh : ∀ i, a i ≤ mesh)
    (htotal : ∑ i, a i = T) :
    (∑ i, (a i) ^ 2) ≤ mesh * T := by
  rw [← htotal]
  exact sum_sq_le_mesh_mul_sum a mesh ha hmesh

/-- Multiplying the mesh estimate by the Brownian one-cell factor `2` gives
exactly the deterministic bound used after cross-term cancellation. -/
theorem two_mul_sum_sq_le_two_mul_mesh_mul_total
    {ι : Type*} [Fintype ι]
    (a : ι → ℝ) (mesh T : ℝ)
    (ha : ∀ i, 0 ≤ a i)
    (hmesh : ∀ i, a i ≤ mesh)
    (htotal : ∑ i, a i = T) :
    2 * ∑ i, (a i) ^ 2 ≤ 2 * mesh * T := by
  have h := sum_sq_le_mesh_mul_total a mesh T ha hmesh htotal
  nlinarith

/-- The number of dyadic cells times the dyadic mesh is exactly the horizon. -/
theorem dyadic_cellCount_mul_mesh (T : ℝ≥0) (level : ℕ) :
    ((2 ^ level : ℕ) : ℝ≥0) * dyadicMesh T level = T := by
  rw [mul_comm, dyadicMesh, div_mul_cancel₀]
  positivity

/-- Every cell of the canonical dyadic grid has exactly the dyadic mesh length. -/
theorem dyadic_cellLength_eq_mesh
    (T : ℝ≥0) (level : ℕ) (i : Fin (2 ^ level)) :
    ((regularGridTimes (dyadicMesh T level) (2 ^ level) i.succ -
          regularGridTimes (dyadicMesh T level) (2 ^ level) i.castSucc : ℝ≥0) : ℝ) =
      ((dyadicMesh T level : ℝ≥0) : ℝ) := by
  rw [FiniteTimeGrid.dyadic_activeCell_right i]
  simp

/-- The real cell lengths of the canonical dyadic grid sum exactly to `T`. -/
theorem dyadic_sum_cellLength_eq_total
    (T : ℝ≥0) (level : ℕ) :
    (∑ i : Fin (2 ^ level),
      ((regularGridTimes (dyadicMesh T level) (2 ^ level) i.succ -
          regularGridTimes (dyadicMesh T level) (2 ^ level) i.castSucc : ℝ≥0) : ℝ)) =
      (T : ℝ) := by
  calc
    (∑ i : Fin (2 ^ level),
      ((regularGridTimes (dyadicMesh T level) (2 ^ level) i.succ -
          regularGridTimes (dyadicMesh T level) (2 ^ level) i.castSucc : ℝ≥0) : ℝ)) =
        ∑ _i : Fin (2 ^ level), ((dyadicMesh T level : ℝ≥0) : ℝ) := by
          apply Finset.sum_congr rfl
          intro i _
          exact dyadic_cellLength_eq_mesh T level i
    _ = (2 ^ level : ℝ) * ((dyadicMesh T level : ℝ≥0) : ℝ) := by
      simp
    _ = (T : ℝ) := by
      exact_mod_cast dyadic_cellCount_mul_mesh T level

/-- The exact deterministic bound consumed after the Brownian cross terms have
been cancelled on a dyadic grid. -/
theorem dyadic_two_mul_sum_cellLength_sq_le
    (T : ℝ≥0) (level : ℕ) :
    2 * ∑ i : Fin (2 ^ level),
        (((regularGridTimes (dyadicMesh T level) (2 ^ level) i.succ -
            regularGridTimes (dyadicMesh T level) (2 ^ level) i.castSucc : ℝ≥0) : ℝ) ^ 2) ≤
      2 * ((dyadicMesh T level : ℝ≥0) : ℝ) * (T : ℝ) := by
  apply two_mul_sum_sq_le_two_mul_mesh_mul_total
    (a := fun i : Fin (2 ^ level) =>
      ((regularGridTimes (dyadicMesh T level) (2 ^ level) i.succ -
          regularGridTimes (dyadicMesh T level) (2 ^ level) i.castSucc : ℝ≥0) : ℝ))
    (mesh := ((dyadicMesh T level : ℝ≥0) : ℝ))
    (T := (T : ℝ))
  · intro i
    positivity
  · intro i
    rw [dyadic_cellLength_eq_mesh]
  · exact dyadic_sum_cellLength_eq_total T level

end QuadraticVariationMesh
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
