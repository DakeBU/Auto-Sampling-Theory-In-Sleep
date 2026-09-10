import AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexGibbsIntegrability
import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOClosure

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexGibbsIntegrability
open AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOClosure

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
  [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]

-- Integrability is not obtained from a zero-measure or undefined-integral fallback.
example {V : E → ℝ} {m : ℝ} (hm : 0 < m) (hV : Differentiable ℝ V)
    (hsc : StrongConvexOn Set.univ m V) :
    0 < ∫ x, Real.exp (-V x) ∂(volume : Measure E) :=
  integral_exp_pos (integrable_exp_neg_of_strongConvexOn hm hV hsc)

-- The normalization consumer requires no user-supplied minimizer or integral bound.
example {V : E → ℝ} {m : ℝ} (hm : 0 < m) (hV : Differentiable ℝ V)
    (hsc : StrongConvexOn Set.univ m V) :
    IsProbabilityMeasure ((volume : Measure E).tilted (fun x => -V x)) :=
  isProbabilityMeasure_tilted (integrable_exp_neg_of_strongConvexOn hm hV hsc)

-- The actual normalized Gibbs law now supplies the base probability required
-- by the already-compiled RGO closure, with r=0 still permitted.
example {V : E → ℝ} {m r s : ℝ} (hm : 0 < m) (hV : Differentiable ℝ V)
    (hsc : StrongConvexOn Set.univ m V) (hr : 0 ≤ r) (hs : 0 < s) (u y : E) :
    (((volume : Measure E).tilted (fun x => -V x)).tilted
      (fun x => -(r / 2) * ‖x - u‖ ^ 2)).tilted
        (fun x => -(s / 2) * ‖x - y‖ ^ 2) =
      ((volume : Measure E).tilted (fun x => -V x)).tilted
        (fun x => -((r + s) / 2) * ‖x - (r + s)⁻¹ • (r • u + s • y)‖ ^ 2) := by
  have : IsProbabilityMeasure ((volume : Measure E).tilted (fun x => -V x)) :=
    isProbabilityMeasure_tilted (integrable_exp_neg_of_strongConvexOn hm hV hsc)
  exact quadratic_tilt_tilt _ hr hs u y

#check @integrable_exp_neg_of_strongConvexOn
#print axioms integrable_exp_neg_of_strongConvexOn
