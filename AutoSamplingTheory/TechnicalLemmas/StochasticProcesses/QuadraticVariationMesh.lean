import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic

/-!
# Deterministic mesh estimate for quadratic variation

The probabilistic quadratic-variation proof eventually reduces to a finite
sum of squared cell lengths.  This file isolates the deterministic inequality

`sum_i a_i^2 <= mesh * sum_i a_i`

under `0 <= a_i <= mesh`, so the Brownian-independence packet and the mesh
algebra do not share proof obligations.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace QuadraticVariationMesh

open scoped BigOperators

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

end QuadraticVariationMesh
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
