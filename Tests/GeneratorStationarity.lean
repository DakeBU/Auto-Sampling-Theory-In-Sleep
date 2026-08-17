import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GeneratorStationarity

namespace AutoSamplingTheory.Tests.GeneratorStationarity

open Filter Set
open scoped NNReal Topology

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGenerator
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGeneratorDomain
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.GeneratorStationarity

noncomputable section

variable {M : Type*} [NormedAddCommGroup M] [NormedSpace ℝ M]

#check hasRightGeneratorAt_zero_of_fixed
#check mem_generatorDomainSubmodule_of_fixed
#check invariantFunctional_generator_eq_zero
#check invariantFunctional_rightGenerator_eq_zero

example (S : ContinuousLinearSemigroup M)
    {f : M} (hfix : ∀ t : ℝ≥0, S.op t f = f) :
    HasRightGeneratorAt S f 0 :=
  hasRightGeneratorAt_zero_of_fixed S hfix

example (S : ContinuousLinearSemigroup M)
    (ell : M →L[ℝ] ℝ)
    (hinv : ∀ (t : ℝ≥0) (f : M), ell (S.op t f) = ell f)
    {f Af : M} (hf : HasRightGeneratorAt S f Af) :
    ell Af = 0 :=
  invariantFunctional_generator_eq_zero S ell hinv hf

example (S : ContinuousLinearSemigroup M)
    (ell : M →L[ℝ] ℝ)
    (hinv : ∀ (t : ℝ≥0) (f : M), ell (S.op t f) = ell f)
    (f : generatorDomainSubmodule S) :
    ell (rightGenerator S f) = 0 :=
  invariantFunctional_rightGenerator_eq_zero S ell hinv f

end

end AutoSamplingTheory.Tests.GeneratorStationarity
