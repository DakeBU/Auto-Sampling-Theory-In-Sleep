import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.L2GeneratorIdentities

namespace AutoSamplingTheory.Tests.L2GeneratorIdentities

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open OperatorGenerator OperatorGeneratorDomain L2GeneratorIdentities

#check integral_rightGenerator_eq_zero_of_expectation_invariant
#check integral_rightGenerator_mul_eq_integral_mul_rightGenerator

variable {α : Type*} [MeasurableSpace α]

example (pi : Measure α) [IsFiniteMeasure pi]
    (S : ContinuousLinearSemigroup (Lp ℝ 2 pi))
    (hrev : Reversibility.IsReversible S)
    (f g : generatorDomainSubmodule S) :
    (∫ x, rightGenerator S f x * (g : Lp ℝ 2 pi) x ∂pi) =
      ∫ x, (f : Lp ℝ 2 pi) x * rightGenerator S g x ∂pi :=
  integral_rightGenerator_mul_eq_integral_mul_rightGenerator pi S hrev f g

end AutoSamplingTheory.Tests.L2GeneratorIdentities
