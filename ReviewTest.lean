import ReviewLibrary.TechnicalLemmas.Analysis.StrongConvexFirstOrder

open Set

namespace ReviewTest

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

example {s : Set E} {f : E → ℝ} {m : ℝ} {grad : E → E}
    (hsc : StrongConvexOn s m f)
    (hgrad : ∀ z ∈ s, HasGradientAt f (grad z) z)
    {x y : E} (hx : x ∈ s) (hy : y ∈ s) :
    f y ≥ f x + inner ℝ (grad x) (y - x) + m / 2 * ‖y - x‖ ^ 2 := by
  exact ReviewLibrary.TechnicalLemmas.Analysis.StrongConvexFirstOrder.firstOrder_lower_bound_of_strongConvexOn
    hsc hgrad hx hy

end ReviewTest
