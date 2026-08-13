import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Reversibility

namespace AutoSamplingTheory.Tests.Reversibility

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGenerator
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Reversibility

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℝ H]

#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Reversibility.IsReversible

def identitySemigroup : ContinuousLinearSemigroup H where
  op := fun _ => ContinuousLinearMap.id ℝ H
  op_zero := rfl
  op_add := by
    intro s t
    ext f
    rfl

example : IsReversible (identitySemigroup : ContinuousLinearSemigroup H) := by
  apply isReversible_identity
  intro t
  rfl

end

end AutoSamplingTheory.Tests.Reversibility
