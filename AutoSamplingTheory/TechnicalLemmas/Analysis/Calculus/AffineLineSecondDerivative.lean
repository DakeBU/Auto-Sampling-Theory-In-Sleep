import AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.LineDeriv
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.Calculus.Deriv.Comp
import Mathlib.Analysis.Calculus.Deriv.Mul

/-!
# Second derivatives along affine lines

This module connects the ordinary one-dimensional second derivative of
`t ↦ f (x + t • v)` with the canonical `iteratedFDeriv` Hessian slice already
used by the ASTIS line-derivative calculus.  It deliberately introduces no
separate Hessian matrix abstraction.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Analysis
namespace Calculus
namespace LineDeriv

/-- For a globally `C²` scalar observable, the second derivative of its affine
line restriction at zero is exactly the diagonal two-fold Fréchet derivative.

This is the bridge needed to transport one-dimensional strong-convexity
second-derivative bounds back to the ambient normed space. -/
theorem deriv2_affineLine_eq_iteratedFDeriv_two
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {f : E → ℝ} {x v : E}
    (hf : ContDiff ℝ 2 f) :
    (deriv^[2] (fun t : ℝ => f (x + t • v))) 0 =
      iteratedFDeriv ℝ 2 f x ![v, v] := by
  have hf1 : Differentiable ℝ f := hf.differentiable (by norm_num)
  have hfirst :
      deriv (fun t : ℝ => f (x + t • v)) =
        fun t : ℝ => fderiv ℝ f (x + t • v) v := by
    funext t
    have hpath : HasDerivAt (fun u : ℝ => x + u • v) v t := by
      have hsmul : HasDerivAt (fun u : ℝ => u • v) v t := by
        simpa using (hasDerivAt_id' (x := t)).smul_const v
      simpa using hsmul.const_add x
    have hcomp :=
      (hf1 (x + t • v)).hasFDerivAt.comp_hasDerivAt hpath
    simpa [Function.comp_def] using hcomp.deriv
  change deriv (deriv (fun t : ℝ => f (x + t • v))) 0 = _
  rw [hfirst]
  change lineDeriv ℝ (fun y : E => fderiv ℝ f y v) x v = _
  have hDf : Differentiable ℝ (fun y : E => fderiv ℝ f y) :=
    (hf.fderiv_right (m := 1) (by norm_num)).differentiable one_ne_zero
  exact lineDeriv_fderiv_apply_const_eq_iteratedFDeriv_two (hDf x)

end LineDeriv
end Calculus
end Analysis
end TechnicalLemmas
end AutoSamplingTheory
