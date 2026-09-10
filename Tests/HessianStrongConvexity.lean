import AutoSamplingTheory.TechnicalLemmas.Analysis.HessianStrongConvexity
import AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexGibbsIntegrability
import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOClosure

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Analysis.HessianStrongConvexity
open AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexGibbsIntegrability
open AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOClosure

section SourcePositiveHessian

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
  [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
  {V : E → ℝ} {α : ℝ} (hα : 0 < α) (hV : ContDiff ℝ 2 V)
  (hH : ∀ x v : E, α * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ V) x v) v)

-- The paper's genuine C²/Hessian premises, not a supplied StrongConvexOn
-- hypothesis or an assumed finite normalizer, reach positive finite Gibbs mass.
example : Integrable (fun x => Real.exp (-V x)) (volume : Measure E) ∧
    0 < ∫ x, Real.exp (-V x) ∂(volume : Measure E) := by
  have hi := integrable_exp_neg_of_strongConvexOn hα
    (hV.differentiable (by norm_num)) (strongConvexOn_univ_of_fderiv2_lower hV hH)
  exact ⟨hi, integral_exp_pos hi⟩

example : IsProbabilityMeasure ((volume : Measure E).tilted (fun x => -V x)) := by
  exact isProbabilityMeasure_tilted (integrable_exp_neg_of_strongConvexOn hα
    (hV.differentiable (by norm_num)) (strongConvexOn_univ_of_fderiv2_lower hV hH))

-- An actual normalized Gibbs probability from source-positive curvature feeds
-- the existing RGO closure. This tests the analytic join, not a production wrapper.
example {r s : ℝ} (hr : 0 ≤ r) (hs : 0 < s) (u y : E) :
    (((volume : Measure E).tilted (fun x => -V x)).tilted
      (fun x => -(r / 2) * ‖x - u‖ ^ 2)).tilted
        (fun x => -(s / 2) * ‖x - y‖ ^ 2) =
      ((volume : Measure E).tilted (fun x => -V x)).tilted
        (fun x => -((r + s) / 2) * ‖x - (r + s)⁻¹ • (r • u + s • y)‖ ^ 2) := by
  have : IsProbabilityMeasure ((volume : Measure E).tilted (fun x => -V x)) :=
    isProbabilityMeasure_tilted (integrable_exp_neg_of_strongConvexOn hα
      (hV.differentiable (by norm_num)) (strongConvexOn_univ_of_fderiv2_lower hV hH))
  exact quadratic_tilt_tilt _ hr hs u y

end SourcePositiveHessian

-- The analytic adapter itself does not need positive modulus or dimension.
example : StrongConvexOn (Set.univ : Set ℝ) 0 (fun _ : ℝ => (0 : ℝ)) := by
  apply strongConvexOn_univ_of_fderiv2_lower contDiff_const
  intro x v
  simp

example (α : ℝ) : StrongConvexOn (Set.univ : Set (EuclideanSpace ℝ (Fin 0)))
    α (fun _ => (0 : ℝ)) := by
  apply strongConvexOn_univ_of_fderiv2_lower contDiff_const
  intro x v
  have hv : v = 0 := Subsingleton.elim _ _
  simp [hv]

#check @strongConvexOn_univ_of_fderiv2_lower
#print axioms strongConvexOn_univ_of_fderiv2_lower
