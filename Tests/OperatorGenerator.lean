import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGenerator

namespace AutoSamplingTheory.Tests.OperatorGenerator

open Filter Set
open scoped NNReal Topology

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGenerator

noncomputable section

variable {M : Type*} [NormedAddCommGroup M] [NormedSpace ℝ M]

/-- The constant identity family is the simplest continuous-linear semigroup. -/
def identitySemigroup : ContinuousLinearSemigroup M where
  op := fun _ => ContinuousLinearMap.id ℝ M
  op_zero := rfl
  op_add := by
    intro s t
    ext f
    rfl

example (s t : ℝ≥0) (f : M) :
    (identitySemigroup : ContinuousLinearSemigroup M).op s
        ((identitySemigroup : ContinuousLinearSemigroup M).op t f) =
      (identitySemigroup : ContinuousLinearSemigroup M).op t
        ((identitySemigroup : ContinuousLinearSemigroup M).op s f) :=
  ContinuousLinearSemigroup.op_comm_apply identitySemigroup s t f

example (f : M) :
    HasRightGeneratorAt
      (identitySemigroup : ContinuousLinearSemigroup M) f 0 := by
  simp [HasRightGeneratorAt, rightDifferenceQuotient, identitySemigroup]

example (f : M) :
    f ∈ generatorDomain
      (identitySemigroup : ContinuousLinearSemigroup M) := by
  exact ⟨0, by
    simp [HasRightGeneratorAt, rightDifferenceQuotient, identitySemigroup]⟩

example (f : M) (t : ℝ≥0) :
    Tendsto
      (fun h : ℝ≥0 =>
        rightOrbitDifferenceQuotient
          (identitySemigroup : ContinuousLinearSemigroup M) t h f)
      (nhdsWithin 0 (Ioi 0)) (𝓝 0) := by
  have hgen :
      HasRightGeneratorAt
        (identitySemigroup : ContinuousLinearSemigroup M) f 0 := by
    simp [HasRightGeneratorAt, rightDifferenceQuotient, identitySemigroup]
  simpa [identitySemigroup] using
    (kolmogorov_backward_right
      (identitySemigroup : ContinuousLinearSemigroup M) hgen t).2

end

end AutoSamplingTheory.Tests.OperatorGenerator
