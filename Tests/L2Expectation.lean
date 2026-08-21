import AutoSamplingTheory.TechnicalLemmas.Measure.L2Expectation

namespace AutoSamplingTheory.Tests.L2Expectation

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure.L2Expectation

#check one
#check expectation
#check expectation_apply_eq_inner
#check expectation_apply_eq_integral
#check inner_one_eq_integral

variable {α : Type*} [MeasurableSpace α]

example (pi : Measure α) [IsFiniteMeasure pi] (f : Lp ℝ 2 pi) :
    expectation pi f = ∫ x, f x ∂pi :=
  expectation_apply_eq_integral pi f

end AutoSamplingTheory.Tests.L2Expectation
