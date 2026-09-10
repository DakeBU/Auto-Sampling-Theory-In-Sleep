import AutoSamplingTheory.ExampleCases.ProximalBPS.GaussianAugmentation

open MeasureTheory ProbabilityTheory
open AutoSamplingTheory.ExampleCases.ProximalBPS.GaussianAugmentation

namespace Tests.ProximalBPSGaussianAugmentation

theorem dirac_real_input (a η : ℝ) (hη : 0 < η) :
    Measure.map (fun p : ℝ × ℝ => (p.1, p.1 + Real.sqrt η • p.2))
        ((Measure.dirac a).prod (stdGaussian ℝ)) =
      ((Measure.dirac a).prod (volume : Measure ℝ)).withDensity (fun p =>
        ENNReal.ofReal
          ((Real.sqrt (2 * Real.pi * η))⁻¹ *
            Real.exp (-‖p.2 - p.1‖ ^ 2 / (2 * η)))) := by
  simpa using augmentation_eq_withDensity (Measure.dirac a) η hη

theorem gaussian_two_dimensional_input (η : ℝ) (hη : 0 < η) :
    Measure.map (fun p : EuclideanSpace ℝ (Fin 2) × EuclideanSpace ℝ (Fin 2) =>
        (p.1, p.1 + Real.sqrt η • p.2))
        ((stdGaussian (EuclideanSpace ℝ (Fin 2))).prod
          (stdGaussian (EuclideanSpace ℝ (Fin 2)))) =
      ((stdGaussian (EuclideanSpace ℝ (Fin 2))).prod volume).withDensity (fun p =>
        ENNReal.ofReal
          (((Real.sqrt (2 * Real.pi * η))⁻¹) ^ 2 *
            Real.exp (-‖p.2 - p.1‖ ^ 2 / (2 * η)))) := by
  simpa using augmentation_eq_withDensity
    (stdGaussian (EuclideanSpace ℝ (Fin 2))) η hη

#print axioms augmentation_eq_withDensity

end Tests.ProximalBPSGaussianAugmentation
