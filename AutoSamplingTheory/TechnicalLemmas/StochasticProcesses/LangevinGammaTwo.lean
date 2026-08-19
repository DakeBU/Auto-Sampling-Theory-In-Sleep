import AutoSamplingTheory.TechnicalLemmas.Geometry.StrongConvexity
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.LangevinCarreDuChamp

/-!
# Langevin Gamma-two calculus

The target diagonal identity is

`Gamma2(f,f) = HessianSquare(f) + D2V[gradient f, gradient f]`.

This module first isolates the two curvature terms using the canonical
`iteratedFDeriv` Hessian slices already used by ASTIS.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace LangevinGammaTwo

open scoped BigOperators RealInnerProductSpace
open AutoSamplingTheory.TechnicalLemmas.Geometry.StrongConvexity

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
  [FiniteDimensional ℝ E]

/-- Sum of squared second-derivative coordinates in the standard orthonormal basis. -/
noncomputable def hessianHilbertSchmidtSq (f : E → ℝ) (x : E) : ℝ :=
  ∑ i, ∑ j,
    (iteratedFDeriv ℝ 2 f x
      ![(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) j]) ^ 2

/-- The Hessian square term is nonnegative. -/
theorem hessianHilbertSchmidtSq_nonneg (f : E → ℝ) (x : E) :
    0 ≤ hessianHilbertSchmidtSq f x := by
  unfold hessianHilbertSchmidtSq
  exact Finset.sum_nonneg fun _ _ =>
    Finset.sum_nonneg fun _ _ => sq_nonneg _

/-- Strong convexity controls the potential-Hessian term in Gamma-two. -/
theorem potentialHessian_gradient_ge_of_strongConvexOn_univ
    {V f : E → ℝ} {k : ℝ}
    (hV : StrongConvexOn (Set.univ : Set E) k V)
    (hreg : ContDiff ℝ 2 V) (x : E) :
    k * ‖gradient f x‖ ^ 2 ≤
      iteratedFDeriv ℝ 2 V x ![gradient f x, gradient f x] :=
  iteratedFDeriv_two_ge_of_strongConvexOn_univ hV hreg x (gradient f x)

end LangevinGammaTwo
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
