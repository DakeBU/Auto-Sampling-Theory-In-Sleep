import AutoSamplingTheory.TechnicalLemmas.Geometry.StrongConvexity

namespace AutoSamplingTheory.Tests.StrongConvexity

open Set
open AutoSamplingTheory.TechnicalLemmas.Geometry.StrongConvexity

#check deriv2_nonneg_of_convexOn_univ
#check strongConvexOn_affineLine
#check deriv2_ge_of_strongConvexOn_univ

example {f : ℝ → ℝ}
    (hf : ConvexOn ℝ (Set.univ : Set ℝ) f)
    (hfd : Differentiable ℝ f) (x : ℝ) :
    0 ≤ (deriv^[2] f) x :=
  deriv2_nonneg_of_convexOn_univ hf hfd x

example {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {V : E → ℝ} {k : ℝ}
    (hV : StrongConvexOn (Set.univ : Set E) k V)
    (x v : E) :
    StrongConvexOn (Set.univ : Set ℝ) (k * ‖v‖ ^ 2)
      (fun t : ℝ => V (x + t • v)) :=
  strongConvexOn_affineLine hV x v

example {f : ℝ → ℝ} {k : ℝ}
    (hf : StrongConvexOn (Set.univ : Set ℝ) k f)
    (hreg : ContDiff ℝ 2 f) (x : ℝ) :
    k ≤ (deriv^[2] f) x :=
  deriv2_ge_of_strongConvexOn_univ hf hreg x

end AutoSamplingTheory.Tests.StrongConvexity
