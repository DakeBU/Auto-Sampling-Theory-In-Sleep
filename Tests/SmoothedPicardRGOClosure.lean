import AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOClosure

open MeasureTheory
open AutoSamplingTheory.ExampleCases.SmoothedPicardHMC.RGOClosure

example (μ : Measure ℝ) [IsProbabilityMeasure μ] (u y : ℝ) :
    (μ.tilted (fun x => -(0 / 2) * ‖x - u‖ ^ 2)).tilted
        (fun x => -(1 / 2) * ‖x - y‖ ^ 2) =
      μ.tilted (fun x => -((0 + 1) / 2) *
        ‖x - (0 + 1 : ℝ)⁻¹ • ((0 : ℝ) • u + (1 : ℝ) • y)‖ ^ 2) :=
  quadratic_tilt_tilt μ (r := 0) (s := 1) le_rfl zero_lt_one u y

example (μ : Measure ℝ) [IsProbabilityMeasure μ] (u y : ℝ) :
    (μ.tilted (fun x => -(1 / 2) * ‖x - u‖ ^ 2)).tilted
        (fun x => -(1 / 2) * ‖x - y‖ ^ 2) =
      μ.tilted (fun x => -‖x - ((1 / 2 : ℝ) • (u + y))‖ ^ 2) := by
  convert quadratic_tilt_tilt μ (r := 1) (s := 1) zero_le_one zero_lt_one u y using 1
  norm_num

#check @quadratic_tilt_tilt
#print axioms quadratic_tilt_tilt
