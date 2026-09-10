import AutoSamplingTheory.TechnicalLemmas.Analysis.QuadraticRegularization
import AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexGibbsIntegrability
import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOClosure

open MeasureTheory
open scoped NNReal
open AutoSamplingTheory.TechnicalLemmas.Analysis.QuadraticRegularization
open AutoSamplingTheory.TechnicalLemmas.Analysis.StrongConvexGibbsIntegrability
open AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOClosure

section SourceConstants

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [CompleteSpace E]
  {U : E → ℝ} {κ A : ℝ≥0}
  (hU : ContDiff ℝ 2 U)
  (hH : ∀ x v : E,
    ((κ⁻¹ : ℝ≥0) : ℝ) * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ U) x v) v ∧
    (fderiv ℝ (fderiv ℝ U) x v) v ≤ ‖v‖ ^ 2)

-- The source constants are κ⁻¹, 1, A⁻¹; the returned smoothness is actual
-- gradient Lipschitz continuity, not an assumed or declared operator norm.
example (u : E) :
    let W := fun x => U x + ((A⁻¹ : ℝ≥0) : ℝ) / 2 * ‖x - u‖ ^ 2
    StrongConvexOn Set.univ ((κ⁻¹ + A⁻¹ : ℝ≥0) : ℝ) W ∧
      LipschitzWith (1 + A⁻¹) (gradient W) := by
  apply strongConvexOn_and_lipschitzWith_gradient_add_quadratic hU
  simpa using hH

-- A=∞ is represented by zero precision, not by treating a zero finite
-- variance as legal. The theorem genuinely retains the base potential.
example (u : E) : StrongConvexOn Set.univ ((κ⁻¹ : ℝ≥0) : ℝ) U ∧
    LipschitzWith 1 (gradient U) := by
  simpa using strongConvexOn_and_lipschitzWith_gradient_add_quadratic
    (m := κ⁻¹) (L := 1) (r := 0) hU (by simpa using hH) u

variable [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]

-- A positive finite source variance supplies an actual normalized RGO/Gibbs
-- law. The conclusion simultaneously retains its exact smoothness constant.
example (hκ : 1 ≤ κ) (hA : 0 < A) (u y z : E) {q : ℝ} (hq : 0 ≤ q) :
    let W := fun x => U x + ((A⁻¹ : ℝ≥0) : ℝ) / 2 * ‖x - u‖ ^ 2
    let μ := (volume : Measure E).tilted (fun x => -W x)
    LipschitzWith (1 + A⁻¹) (gradient W) ∧
      Integrable (fun x => Real.exp (-W x)) (volume : Measure E) ∧
      0 < ∫ x, Real.exp (-W x) ∂(volume : Measure E) ∧
      IsProbabilityMeasure μ ∧
      (μ.tilted (fun x => -(q / 2) * ‖x - y‖ ^ 2)).tilted
          (fun x => -(((A⁻¹ : ℝ≥0) : ℝ) / 2) * ‖x - z‖ ^ 2) =
        μ.tilted (fun x => -((q + ((A⁻¹ : ℝ≥0) : ℝ)) / 2) *
          ‖x - (q + ((A⁻¹ : ℝ≥0) : ℝ))⁻¹ •
            (q • y + ((A⁻¹ : ℝ≥0) : ℝ) • z)‖ ^ 2) := by
  let W := fun x => U x + ((A⁻¹ : ℝ≥0) : ℝ) / 2 * ‖x - u‖ ^ 2
  have hcurv := strongConvexOn_and_lipschitzWith_gradient_add_quadratic
    (m := κ⁻¹) (L := 1) (r := A⁻¹) hU (by simpa using hH) u
  have hkpos : 0 < κ := lt_of_lt_of_le zero_lt_one hκ
  have hm : 0 < ((κ⁻¹ + A⁻¹ : ℝ≥0) : ℝ) := by
    exact_mod_cast add_pos_of_pos_of_nonneg (inv_pos.mpr hkpos)
      (zero_le : (0 : ℝ≥0) ≤ A⁻¹)
  have hn : ContDiff ℝ 2 (fun x : E => ‖x - u‖ ^ 2) :=
    (contDiff_id.sub contDiff_const).norm_sq (𝕜 := ℝ)
  have hW : ContDiff ℝ 2 W := hU.add (contDiff_const.mul hn)
  have hi := integrable_exp_neg_of_strongConvexOn hm
    (hW.differentiable (by norm_num)) hcurv.1
  -- Strict positivity rules out undefined-integral/zero-measure fallback.
  have hZ : 0 < ∫ x, Real.exp (-W x) ∂(volume : Measure E) := integral_exp_pos hi
  have hprecision : 0 < ((A⁻¹ : ℝ≥0) : ℝ) := by exact_mod_cast inv_pos.mpr hA
  have hμ : IsProbabilityMeasure ((volume : Measure E).tilted (fun x => -W x)) :=
    isProbabilityMeasure_tilted hi
  let := hμ
  exact ⟨hcurv.2, hi, hZ, hμ, quadratic_tilt_tilt _ hq hprecision y z⟩

end SourceConstants

-- Zero-dimensional state needs no nontrivial-space spectral workaround.
example (m L r : ℝ≥0) (u : EuclideanSpace ℝ (Fin 0)) :
    let W := fun x : EuclideanSpace ℝ (Fin 0) => (0 : ℝ) + (r : ℝ) / 2 * ‖x - u‖ ^ 2
    StrongConvexOn Set.univ ((m + r : ℝ≥0) : ℝ) W ∧
      LipschitzWith (L + r) (gradient W) := by
  apply strongConvexOn_and_lipschitzWith_gradient_add_quadratic contDiff_const
  intro x v
  have hv : v = 0 := Subsingleton.elim _ _
  simp [hv]

#check @strongConvexOn_and_lipschitzWith_gradient_add_quadratic
#print axioms strongConvexOn_and_lipschitzWith_gradient_add_quadratic
