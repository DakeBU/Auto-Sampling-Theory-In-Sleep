import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ReversibleGenerator

namespace AutoSamplingTheory.Tests.ReversibleGenerator

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open OperatorGenerator OperatorGeneratorDomain Reversibility ReversibleGenerator

#check ReversibleGenerator.inner_rightDifferenceQuotient_eq
#check ReversibleGenerator.inner_rightGenerator_eq

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℝ H]

example (S : ContinuousLinearSemigroup H) (hrev : IsReversible S)
    (f g : generatorDomainSubmodule S) :
    inner ℝ (rightGenerator S f) (g : H) =
      inner ℝ (f : H) (rightGenerator S g) :=
  inner_rightGenerator_eq S hrev f g

end AutoSamplingTheory.Tests.ReversibleGenerator
