import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGeneratorDomain

namespace AutoSamplingTheory.Tests.OperatorGeneratorDomain

open Filter Set
open scoped NNReal Topology

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGenerator
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGeneratorDomain

noncomputable section

variable {M : Type*} [NormedAddCommGroup M] [NormedSpace ℝ M]

/-- The identity family is a strongly continuous semigroup. -/
def identityStronglyContinuousSemigroup : StronglyContinuousSemigroup M where
  op := fun _ => ContinuousLinearMap.id ℝ M
  op_zero := rfl
  op_add := by
    intro s t
    ext f
    rfl
  stronglyContinuousAtZero := by
    intro f
    simpa using (tendsto_const_nhds : Tendsto (fun _ : ℝ≥0 => f) (𝓝 0) (𝓝 f))

example (t : ℝ≥0) (f : M) :
    Tendsto
      (fun h : ℝ≥0 =>
        (identityStronglyContinuousSemigroup : StronglyContinuousSemigroup M).op
          (t + h) f)
      (𝓝 0)
      (𝓝 ((identityStronglyContinuousSemigroup : StronglyContinuousSemigroup M).op t f)) :=
  StronglyContinuousSemigroup.tendsto_op_add identityStronglyContinuousSemigroup t f

example (f g₁ g₂ : M)
    {S : ContinuousLinearSemigroup M}
    (h₁ : HasRightGeneratorAt S f g₁)
    (h₂ : HasRightGeneratorAt S f g₂) :
    g₁ = g₂ :=
  hasRightGeneratorAt_unique h₁ h₂

example (S : ContinuousLinearSemigroup M) :
    Submodule ℝ M :=
  generatorDomainSubmodule S

example (S : ContinuousLinearSemigroup M) :
    generatorDomainSubmodule S →ₗ[ℝ] M :=
  rightGenerator S

example (f : M) :
    f ∈ generatorDomainSubmodule
      (identityStronglyContinuousSemigroup.toContinuousLinearSemigroup) := by
  exact ⟨0, by
    simp [HasRightGeneratorAt, rightDifferenceQuotient,
      identityStronglyContinuousSemigroup]⟩

example (f : M) :
    let S := identityStronglyContinuousSemigroup.toContinuousLinearSemigroup
    let fd : generatorDomainSubmodule S :=
      ⟨f, ⟨0, by
        simp [HasRightGeneratorAt, rightDifferenceQuotient,
          identityStronglyContinuousSemigroup]⟩⟩
    rightGenerator S fd = 0 := by
  dsimp
  apply hasRightGeneratorAt_unique
  · exact rightGeneratorValue_spec _ _
  · simp [HasRightGeneratorAt, rightDifferenceQuotient,
      identityStronglyContinuousSemigroup]

example (S : ContinuousLinearSemigroup M)
    (f : generatorDomainSubmodule S) (t : ℝ≥0) :
    Tendsto
      (fun h : ℝ≥0 => rightOrbitDifferenceQuotient S t h (f : M))
      (nhdsWithin 0 (Ioi 0))
      (𝓝 (S.op t (rightGenerator S f))) :=
  kolmogorov_backward_right_generator S f t

end

end AutoSamplingTheory.Tests.OperatorGeneratorDomain
