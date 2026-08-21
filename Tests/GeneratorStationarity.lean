import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GeneratorStationarity

namespace AutoSamplingTheory.Tests.GeneratorStationarity

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open OperatorGenerator OperatorGeneratorDomain GeneratorStationarity

#check GeneratorStationarity.hasRightGeneratorAt_zero_of_fixed
#check GeneratorStationarity.mem_generatorDomainSubmodule_of_fixed
#check GeneratorStationarity.invariantFunctional_generator_eq_zero
#check GeneratorStationarity.invariantFunctional_rightGenerator_eq_zero

variable {M : Type*} [NormedAddCommGroup M] [NormedSpace ℝ M]

example (S : ContinuousLinearSemigroup M)
    (ell : M →L[ℝ] ℝ)
    (hinv : ∀ (t : ℝ≥0) (f : M), ell (S.op t f) = ell f)
    (f : generatorDomainSubmodule S) :
    ell (rightGenerator S f) = 0 :=
  invariantFunctional_rightGenerator_eq_zero S ell hinv f

end AutoSamplingTheory.Tests.GeneratorStationarity
