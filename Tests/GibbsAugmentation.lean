import AutoSamplingTheory.ExampleCases.ProximalBPS.GibbsAugmentation
import AutoSamplingTheory.ExampleCases.ProximalBPS.GaussianReflection

open MeasureTheory ProbabilityTheory
open AutoSamplingTheory.ExampleCases.ProximalBPS.GibbsAugmentation
open AutoSamplingTheory.ExampleCases.ProximalBPS.GaussianReflection

-- The entire certificate is used: positive mass supplies a nonzero totalized
-- integral, probability transports to the source density, and the exact measure
-- equality turns the existing reflection theorem into a source-density result.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    {V : E → ℝ} {α η : ℝ} (hα : 0 < α) (hV : ContDiff ℝ 2 V)
    (hH : ∀ x v : E, α * ‖v‖ ^ 2 ≤ (fderiv ℝ (fderiv ℝ V) x v) v)
    (hη : 0 < η) :
    let ZV := ∫ x, Real.exp (-V x) ∂(volume : Measure E)
    let πη := ((volume : Measure E).prod volume).withDensity (fun p =>
      ENNReal.ofReal
        (((((Real.sqrt (2 * Real.pi * η))⁻¹) ^ Module.finrank ℝ E) / ZV) *
          Real.exp (-V p.1 - ‖p.2 - p.1‖ ^ 2 / (2 * η))))
    IsProbabilityMeasure πη ∧
      Measure.map (fun p : E × E => (p.1, (2 : ℝ) • p.1 - p.2)) πη = πη := by
  rcases normalized_augmentation_density hα hV hH hη with ⟨hZ, hprob, hdensity⟩
  have hi : Integrable (fun x => Real.exp (-V x)) (volume : Measure E) := by
    by_contra h
    exact hZ.ne' (integral_undef h)
  have : IsProbabilityMeasure ((volume : Measure E).tilted (fun x => -V x)) :=
    isProbabilityMeasure_tilted hi
  refine ⟨hdensity ▸ hprob, ?_⟩
  simpa only [hdensity] using
    (reflection_preserves_augmentation
      ((volume : Measure E).tilted (fun x => -V x)) η hη).2

-- Positive curvature is compatible with the zero-dimensional constant
-- potential: every direction is zero. The full normalized certificate still
-- applies, including its dimension-dependent Gaussian prefactor.
example (η : ℝ) (hη : 0 < η) :
    let E0 := EuclideanSpace ℝ (Fin 0)
    let V : E0 → ℝ := fun _ => 0
    let ZV := ∫ x, Real.exp (-V x) ∂(volume : Measure E0)
    let μ := (volume : Measure E0).tilted (fun x => -V x)
    let joint := Measure.map (fun p : E0 × E0 => (p.1, p.1 + Real.sqrt η • p.2))
      (μ.prod (stdGaussian E0))
    0 < ZV ∧ IsProbabilityMeasure joint ∧
      joint = ((volume : Measure E0).prod volume).withDensity (fun p =>
        ENNReal.ofReal
          (((((Real.sqrt (2 * Real.pi * η))⁻¹) ^ Module.finrank ℝ E0) / ZV) *
            Real.exp (-V p.1 - ‖p.2 - p.1‖ ^ 2 / (2 * η)))) := by
  apply normalized_augmentation_density (α := 1) (by norm_num) contDiff_const _ hη
  intro x v
  have hv : v = 0 := Subsingleton.elim _ _
  simp [hv]

#check @normalized_augmentation_density
#print axioms normalized_augmentation_density
