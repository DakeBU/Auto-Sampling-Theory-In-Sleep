import AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.AffineLineSecondDerivative

namespace AutoSamplingTheory.Tests.AffineLineSecondDerivative

open AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.LineDeriv

#check deriv2_affineLine_eq_iteratedFDeriv_two

example {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {f : E → ℝ} {x v : E}
    (hf : ContDiff ℝ 2 f) :
    (deriv^[2] (fun t : ℝ => f (x + t • v))) 0 =
      iteratedFDeriv ℝ 2 f x ![v, v] :=
  deriv2_affineLine_eq_iteratedFDeriv_two hf

end AutoSamplingTheory.Tests.AffineLineSecondDerivative
