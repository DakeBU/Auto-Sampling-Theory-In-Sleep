import AutoSamplingTheory.ExampleCases.ProximalBPS.GaussianReflection

open MeasureTheory ProbabilityTheory
open AutoSamplingTheory.ExampleCases.ProximalBPS.GaussianReflection

-- The projection exercises the exact production declaration at a concrete
-- positive scale and a genuine probability measure, not a supplied invariance.
example :
    Measure.map (fun p : ℝ × ℝ => (p.1, (2 : ℝ) • p.1 - p.2))
      (Measure.map (fun p : ℝ × ℝ => (p.1, p.1 + Real.sqrt 1 • p.2))
        ((stdGaussian ℝ).prod (stdGaussian ℝ))) =
      Measure.map (fun p : ℝ × ℝ => (p.1, p.1 + Real.sqrt 1 • p.2))
        ((stdGaussian ℝ).prod (stdGaussian ℝ)) :=
  (reflection_preserves_augmentation (stdGaussian ℝ) 1 zero_lt_one).2

example {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
    (μ : Measure E) [IsProbabilityMeasure μ] (η : ℝ) (hη : 0 < η) (x y : E) :
    (x, (2 : ℝ) • x - ((2 : ℝ) • x - y)) = (x, y) :=
  (reflection_preserves_augmentation μ η hη).1 (x, y)

#print axioms reflection_preserves_augmentation
#check @reflection_preserves_augmentation
