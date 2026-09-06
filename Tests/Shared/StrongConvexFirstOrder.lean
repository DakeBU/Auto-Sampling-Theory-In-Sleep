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

end

end AutoSamplingTheory.Tests.Shared.StrongConvexFirstOrder
