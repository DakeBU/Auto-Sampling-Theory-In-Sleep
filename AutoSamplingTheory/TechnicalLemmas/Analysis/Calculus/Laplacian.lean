import Mathlib.Analysis.InnerProductSpace.Laplacian

/-!
# Laplacian coordinate bridges

Small wrappers around Mathlib's finite-dimensional real inner-product-space
Laplacian API.  These leaves expose the standard orthonormal-basis second
derivative formula in ASTIS-owned names for the Langevin generator tree.

They do not prove integration by parts, boundary decay, stationarity,
reversibility, or any divergence theorem.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Analysis
namespace Calculus
namespace Laplacian

open scoped BigOperators InnerProductSpace

/-- Mathlib's finite-dimensional standard-orthonormal-basis formula for the
Laplacian, exposed as an ASTIS calculus leaf.

For Ch.1 Langevin this is the coordinate bridge behind a supplied Laplacian
identifier `lapF = ∑ᵢ ∂ᵢᵢ f`.  It is not an integration-by-parts or invariant
measure theorem. -/
theorem laplacian_eq_sum_stdOrthonormalBasis
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] (f : E → ℝ) :
    Laplacian.laplacian f =
      fun x => ∑ i, iteratedFDeriv ℝ 2 f x
        ![(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i] :=
  InnerProductSpace.laplacian_eq_iteratedFDeriv_stdOrthonormalBasis f

/-- Handoff form of `laplacian_eq_sum_stdOrthonormalBasis` for source-defined
Laplacian functionals.

This is useful when a paper defines a weak-generator or test-function action by
the coordinate second-derivative sum and the local Lean proof needs to rewrite
that action as Mathlib's `Laplacian.laplacian`. -/
theorem laplacianFunctional_eq_of_stdOrthonormalBasis_sum
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E]
    (sourceLaplacianFunctional : (E → ℝ) → ℝ)
    (sourceTest : E → ℝ) :
    sourceLaplacianFunctional (Laplacian.laplacian sourceTest) =
      sourceLaplacianFunctional
        (fun x => ∑ i, iteratedFDeriv ℝ 2 sourceTest x
          ![(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i]) := by
  rw [laplacian_eq_sum_stdOrthonormalBasis]

/-- A globally `C²` real-valued function has a continuous Mathlib Laplacian.

This packages the standard finite-dimensional route: expand the Laplacian in a
standard orthonormal basis, use continuity of the second iterated Frechet
derivative from `ContDiff`, and apply the resulting continuous multilinear map
to fixed basis directions.

It does not prove closed-box `ContDiffOn` regularity, divergence theorem,
weighted integration by parts, boundary cancellation, generator domains,
invariant laws, reversibility, or KL/FI dissipation. -/
theorem continuous_laplacian_of_contDiff_two
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E]
    {f : E → ℝ} (hf : ContDiff ℝ 2 f) :
    Continuous (fun x : E => Laplacian.laplacian f x) := by
  rw [InnerProductSpace.laplacian_eq_iteratedFDeriv_stdOrthonormalBasis f]
  refine continuous_finset_sum _ ?_
  intro i _
  let v : Fin 2 → E := ![(stdOrthonormalBasis ℝ E) i, (stdOrthonormalBasis ℝ E) i]
  have h2 : Continuous (fun x : E => iteratedFDeriv ℝ 2 f x) := by
    exact (hf.iteratedFDeriv_right (m := 0) (i := 2) (by norm_num)).continuous
  exact (ContinuousMultilinearMap.apply ℝ (fun _ : Fin 2 => E) ℝ v).continuous.comp h2

end Laplacian
end Calculus
end Analysis
end TechnicalLemmas
end AutoSamplingTheory
