import AutoSamplingTheory.ExampleCases.ProximalBPS.ReflectionL2
import AutoSamplingTheory.ExampleCases.ProximalBPS.GibbsAugmentation

open MeasureTheory ProbabilityTheory
open AutoSamplingTheory.ExampleCases.ProximalBPS

#print axioms ReflectionL2.actual_reflection_block_identities

-- Actual Gibbs consumer: the operators act on the explicit normalized source
-- density. Its normalization is derived from C2 and the genuine Hessian bound.
-- No conditional kernel, projection identity or integrability is assumed.
example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    {V : E → ℝ} {α η : ℝ} (hα : 0 < α) (hV : ContDiff ℝ 2 V)
    (hH : ∀ x v : E, α * ‖v‖^2 ≤ (fderiv ℝ (fderiv ℝ V) x v) v)
    (hη : 0 < η) :
    let ZV := ∫ x, Real.exp (-V x) ∂(volume : Measure E)
    let μ := (volume : Measure E).tilted (fun x => -V x)
    let J := ((volume : Measure E).prod volume).withDensity (fun p =>
      ENNReal.ofReal
        (((((Real.sqrt (2 * Real.pi * η))⁻¹) ^ Module.finrank ℝ E) / ZV) *
          Real.exp (-V p.1 - ‖p.2 - p.1‖ ^ 2 / (2 * η))))
    let F := fun p : E × E => (p.1,(2:ℝ) • p.1-p.2)
    let P : Lp ℝ 2 J →L[ℝ] Lp ℝ 2 J :=
      (lpMeas ℝ ℝ (MeasurableSpace.comap Prod.snd (inferInstance : MeasurableSpace E)) 2 J).subtypeL
        ∘L condExpL2 ℝ ℝ measurable_snd.comap_le
    ∃ R : Kernel E E, IsMarkovKernel R ∧
      (∀ y, R y = μ.tilted (fun x => -‖x-y‖^2/(2*η))) ∧
      ∃ U : Lp ℝ 2 J →ₗᵢ[ℝ] Lp ℝ 2 J,
        (∀ f, U f =ᵐ[J] f ∘ F) ∧ Function.Involutive U ∧
        IsSelfAdjoint U.toContinuousLinearMap ∧
        (∀ f : Lp ℝ 2 J, (P f : E × E → ℝ) =ᵐ[J]
          fun p => ∫ x, f (x,p.2) ∂R p.2) ∧
        let A := P * U.toContinuousLinearMap * P
        let B := (1-P) * U.toContinuousLinearMap * P
        let D := (1-P) * U.toContinuousLinearMap * (1-P)
        star B*B=P-A^2 ∧ star B*D= -(A*star B) ∧
          (∀ f, P f=f → ‖B f‖^2 = ‖f‖^2-‖A f‖^2) := by
  have density := GibbsAugmentation.normalized_augmentation_density hα hV hH hη
  have hi : Integrable (fun x => Real.exp (-V x)) (volume : Measure E) := by
    by_contra hn
    have hz := integral_undef hn
    exact (ne_of_gt density.1) hz
  have : IsProbabilityMeasure ((volume : Measure E).tilted (fun x => -V x)) :=
    isProbabilityMeasure_tilted hi
  dsimp only
  rw [← density.2.2]
  exact ReflectionL2.actual_reflection_block_identities
    ((volume : Measure E).tilted (fun x => -V x)) hη
