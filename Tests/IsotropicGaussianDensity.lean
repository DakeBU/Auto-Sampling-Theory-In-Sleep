import AutoSamplingTheory.TechnicalLemmas.Measure.IsotropicGaussianDensity

open MeasureTheory ProbabilityTheory
open AutoSamplingTheory.TechnicalLemmas.Measure.IsotropicGaussianDensity

namespace Tests.IsotropicGaussianDensity

theorem real_scale_density (η : ℝ) (hη : 0 < η) :
    (stdGaussian ℝ).map (fun z : ℝ => Real.sqrt η • z) =
      (volume : Measure ℝ).withDensity (fun z =>
        ENNReal.ofReal
          ((Real.sqrt (2 * Real.pi * η))⁻¹ *
            Real.exp (-‖z‖ ^ 2 / (2 * η)))) := by
  simpa using (map_sqrt_smul_stdGaussian_eq_withDensity (E := ℝ) η hη)

theorem two_dimensional_density (η : ℝ) (hη : 0 < η) :
    (stdGaussian (EuclideanSpace ℝ (Fin 2))).map (fun z => Real.sqrt η • z) =
      (volume : Measure (EuclideanSpace ℝ (Fin 2))).withDensity (fun z =>
        ENNReal.ofReal
          (((Real.sqrt (2 * Real.pi * η))⁻¹) ^ 2 *
            Real.exp (-‖z‖ ^ 2 / (2 * η)))) := by
  simpa using (map_sqrt_smul_stdGaussian_eq_withDensity
    (E := EuclideanSpace ℝ (Fin 2)) η hη)

theorem zero_dimensional_density (η : ℝ) (hη : 0 < η) :
    (stdGaussian (EuclideanSpace ℝ (Fin 0))).map (fun z => Real.sqrt η • z) =
      (volume : Measure (EuclideanSpace ℝ (Fin 0))) := by
  have hnorm0 (z : EuclideanSpace ℝ (Fin 0)) : ‖z‖ = 0 := by
    rw [show z = 0 from Subsingleton.elim _ _, norm_zero]
  simpa [hnorm0] using (map_sqrt_smul_stdGaussian_eq_withDensity
    (E := EuclideanSpace ℝ (Fin 0)) η hη)

#print axioms map_sqrt_smul_stdGaussian_eq_withDensity

end Tests.IsotropicGaussianDensity
