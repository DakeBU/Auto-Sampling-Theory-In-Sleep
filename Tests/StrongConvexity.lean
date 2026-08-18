import AutoSamplingTheory.TechnicalLemmas.Geometry.StrongConvexity

namespace AutoSamplingTheory.Tests.StrongConvexity

open Set
open AutoSamplingTheory.TechnicalLemmas.Geometry.StrongConvexity

#check deriv2_nonneg_of_convexOn_univ

example {f : ℝ → ℝ}
    (hf : ConvexOn ℝ (Set.univ : Set ℝ) f)
    (hfd : Differentiable ℝ f) (x : ℝ) :
    0 ≤ (deriv^[2] f) x :=
  deriv2_nonneg_of_convexOn_univ hf hfd x

end AutoSamplingTheory.Tests.StrongConvexity
