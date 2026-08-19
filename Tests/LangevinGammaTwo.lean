import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.LangevinGammaTwo

namespace AutoSamplingTheory.Tests.LangevinGammaTwo

open scoped RealInnerProductSpace
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.LangevinGammaTwo

#check hessianHilbertSchmidtSq
#check hessianHilbertSchmidtSq_nonneg
#check potentialHessian_gradient_ge_of_strongConvexOn_univ

example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] (f : E → ℝ) (x : E) :
    0 ≤ hessianHilbertSchmidtSq f x :=
  hessianHilbertSchmidtSq_nonneg f x

example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] {V f : E → ℝ} {k : ℝ}
    (hV : StrongConvexOn (Set.univ : Set E) k V)
    (hreg : ContDiff ℝ 2 V) (x : E) :
    k * ‖gradient f x‖ ^ 2 ≤
      iteratedFDeriv ℝ 2 V x ![gradient f x, gradient f x] :=
  potentialHessian_gradient_ge_of_strongConvexOn_univ hV hreg x

end AutoSamplingTheory.Tests.LangevinGammaTwo
