import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.WeakForwardEquation

namespace AutoSamplingTheory.Tests.WeakForwardEquation

open Filter Set
open scoped NNReal Topology

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGenerator
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGeneratorDomain
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.WeakForwardEquation

noncomputable section

variable {M : Type*} [NormedAddCommGroup M] [NormedSpace ℝ M]

#check dualAction
#check dualAction_zero
#check dualAction_add
#check rightDualPairingDifferenceQuotient_eq
#check kolmogorov_forward_weak_right

example (S : ContinuousLinearSemigroup M) (ell : M →L[ℝ] ℝ)
    (s t : ℝ≥0) :
    dualAction S (s + t) ell = dualAction S t (dualAction S s ell) :=
  dualAction_add S ell s t

example (S : ContinuousLinearSemigroup M) (ell : M →L[ℝ] ℝ)
    (f : generatorDomainSubmodule S) (t : ℝ≥0) :
    Tendsto
      (fun h : ℝ≥0 =>
        rightDualPairingDifferenceQuotient S ell t h (f : M))
      (nhdsWithin 0 (Ioi 0))
      (𝓝 (dualAction S t ell (rightGenerator S f))) :=
  kolmogorov_forward_weak_right S ell f t

end

end AutoSamplingTheory.Tests.WeakForwardEquation
