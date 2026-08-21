import AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Gradient
import Mathlib.Analysis.Calculus.FDeriv.Comp
import Mathlib.Analysis.Calculus.FDeriv.Mul
import Mathlib.Tactic

/-!
# Algebra and scalar chain rules for gradients

Mathlib's gradient API is intentionally minimal.  Sampling proofs repeatedly
need two derived rules for real-valued functions on a real Hilbert space:

* product rule: `grad(fg) = f grad g + g grad f`;
* scalar outer chain rule: `grad(phi ∘ f) = phi'(f) grad f`.

This file packages these rules at the `HasGradientAt` level so downstream
proofs can keep differentiability hypotheses explicit.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Analysis
namespace Calculus
namespace GradientAlgebra

open InnerProductSpace
open scoped RealInnerProductSpace

noncomputable section

/-- Product rule for gradients of real-valued functions on a real Hilbert
space. -/
theorem HasGradientAt.mul
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {f g : E → ℝ} {x gradF gradG : E}
    (hf : HasGradientAt f gradF x) (hg : HasGradientAt g gradG x) :
    HasGradientAt (fun y => f y * g y)
      (f x • gradG + g x • gradF) x := by
  rw [hasGradientAt_iff_hasFDerivAt]
  change HasFDerivAt (f * g)
    ((toDual ℝ E) (f x • gradG + g x • gradF)) x
  simpa only [map_add, map_smul] using hf.hasFDerivAt.mul hg.hasFDerivAt

/-- Scalar outer-function chain rule for gradients. -/
theorem HasGradientAt.comp_real
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {f : E → ℝ} {phi : ℝ → ℝ} {x gradF : E} {phi' : ℝ}
    (hf : HasGradientAt f gradF x)
    (hphi : HasDerivAt phi phi' (f x)) :
    HasGradientAt (fun y => phi (f y)) (phi' • gradF) x := by
  rw [hasGradientAt_iff_hasFDerivAt]
  change HasFDerivAt (phi ∘ f) ((toDual ℝ E) (phi' • gradF)) x
  have hmap :
      (toDual ℝ E) (phi' • gradF) =
        (ContinuousLinearMap.toSpanSingleton ℝ phi').comp ((toDual ℝ E) gradF) := by
    ext v
    simp [InnerProductSpace.toDual_apply_apply, mul_comm]
  rw [hmap]
  exact hphi.hasFDerivAt.comp x hf.hasFDerivAt

/-- Total-gradient form of the product rule under pointwise differentiability. -/
theorem gradient_mul_eq_of_differentiableAt
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {f g : E → ℝ} {x : E}
    (hf : DifferentiableAt ℝ f x) (hg : DifferentiableAt ℝ g x) :
    gradient (fun y => f y * g y) x =
      f x • gradient g x + g x • gradient f x := by
  exact (HasGradientAt.mul hf.hasGradientAt hg.hasGradientAt).gradient

/-- Total-gradient form of the scalar chain rule. -/
theorem gradient_comp_real_eq_of_differentiableAt
    {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
    {f : E → ℝ} {phi : ℝ → ℝ} {x : E}
    (hf : DifferentiableAt ℝ f x)
    (hphi : DifferentiableAt ℝ phi (f x)) :
    gradient (fun y => phi (f y)) x =
      deriv phi (f x) • gradient f x := by
  exact (HasGradientAt.comp_real hf.hasGradientAt hphi.hasDerivAt).gradient

end

end GradientAlgebra
end Calculus
end Analysis
end TechnicalLemmas
end AutoSamplingTheory
