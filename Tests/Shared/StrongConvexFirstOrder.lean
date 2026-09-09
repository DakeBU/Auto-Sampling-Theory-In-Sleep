import AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexFirstOrder

namespace AutoSamplingTheory.Tests.Shared.StrongConvexFirstOrder

open Set
open scoped RealInnerProductSpace

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]

/-- Focused import/use check for the canonical shared strong-convexity edge. -/
example
    {s : Set E} {f : E → ℝ} {m : ℝ} {grad : E → E}
    (hsc : StrongConvexOn s m f)
    (hgrad : ∀ z ∈ s, HasGradientAt f (grad z) z)
    {x y : E} (hx : x ∈ s) (hy : y ∈ s) :
    f y ≥ f x + inner ℝ (grad x) (y - x) + m / 2 * ‖y - x‖ ^ 2 := by
  exact
    TechnicalLemmas.Analysis.StrongConvexFirstOrder.firstOrder_lower_bound_of_strongConvexOn
      hsc hgrad hx hy

/-- Positive modulus makes the supplied gradient injective on the domain.
This consumer checks that the bound controls point separation, not just signs. -/
example
    {s : Set E} {f : E → ℝ} {m : ℝ} {grad : E → E}
    (hm : 0 < m) (hsc : StrongConvexOn s m f)
    (hgrad : ∀ z ∈ s, HasGradientAt f (grad z) z) :
    Set.InjOn grad s := by
  intro x hx y hy heq
  have h :=
    TechnicalLemmas.Analysis.StrongConvexFirstOrder.gradient_inner_lower_bound_of_strongConvexOn
      hsc hgrad hx hy
  rw [heq, sub_self, inner_zero_left] at h
  have hnorm : ‖y - x‖ = 0 := by
    apply le_antisymm ?_ (norm_nonneg (y - x))
    by_contra hn
    have hn' : 0 < ‖y - x‖ := lt_of_not_ge hn
    exact (not_lt_of_ge h) (mul_pos hm (pow_pos hn' 2))
  exact (sub_eq_zero.mp (norm_eq_zero.mp hnorm)).symm

end

end AutoSamplingTheory.Tests.Shared.StrongConvexFirstOrder
