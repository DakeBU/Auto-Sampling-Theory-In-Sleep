import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.SemigroupDissipation

namespace AutoSamplingTheory.Tests.SemigroupDissipation

open Filter Set
open scoped NNReal Topology

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGenerator
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGeneratorDomain
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Reversibility
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.SemigroupDissipation

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℝ H]

#check generator_inner_symmetric_of_reversible
#check rightGenerator_inner_symmetric_of_reversible
#check rightNormSqDifferenceQuotient_eq_inner
#check tendsto_rightNormSqDifferenceQuotient
#check tendsto_rightNormSqDifferenceQuotient_eq_neg_two_dirichlet

example (S : ContinuousLinearSemigroup H)
    (hrev : IsReversible S)
    (f g : generatorDomainSubmodule S) :
    inner ℝ (rightGenerator S f) (g : H) =
      inner ℝ (f : H) (rightGenerator S g) :=
  rightGenerator_inner_symmetric_of_reversible S hrev f g

example (S : StronglyContinuousSemigroup H)
    (f : generatorDomainSubmodule S.toContinuousLinearSemigroup)
    (t : ℝ≥0) :
    Tendsto
      (fun h : ℝ≥0 =>
        rightNormSqDifferenceQuotient S.toContinuousLinearSemigroup t h (f : H))
      (nhdsWithin 0 (Ioi 0))
      (𝓝 (-2 * generatorDirichlet S.toContinuousLinearSemigroup
        (orbitDomainPoint S.toContinuousLinearSemigroup t f))) :=
  tendsto_rightNormSqDifferenceQuotient_eq_neg_two_dirichlet S f t

end

end AutoSamplingTheory.Tests.SemigroupDissipation
