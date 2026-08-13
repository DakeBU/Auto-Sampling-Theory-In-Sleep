import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FellerSemigroup

namespace AutoSamplingTheory.Tests.FellerSemigroup

open MeasureTheory ProbabilityTheory
open scoped NNReal ProbabilityTheory BoundedContinuousFunction

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.MarkovSemigroup
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.OperatorGenerator
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FellerSemigroup

noncomputable section

variable {E : Type*} [TopologicalSpace E] [MeasurableSpace E] [BorelSpace E]

/-- The identity transition kernel is the basic Feller semigroup. -/
def identityFellerContract :
    FellerTransitionKernelContract
      (fun _ : ℝ≥0 => (Kernel.id : Kernel E E)) where
  isMarkov := by
    intro t
    infer_instance
  initial := rfl
  chapmanKolmogorov := by
    intro s t
    simp
  mapsContinuous := by
    intro t f
    have hfun :
        (fun x => ∫ y, f y ∂(Kernel.id : Kernel E E) x) =
          fun x => f x := by
      funext x
      rw [Kernel.id_apply]
      exact integral_dirac' f x f.continuous.stronglyMeasurable
    rw [hfun]
    exact f.continuous

example {K : ℝ≥0 → Kernel E E}
    (hK : FellerTransitionKernelContract K) (t : ℝ≥0)
    (f : E →ᵇ ℝ) (x : E) :
    fellerOperator hK t f x = ∫ y, f y ∂K t x :=
  fellerOperator_apply hK t f x

example {K : ℝ≥0 → Kernel E E}
    (hK : FellerTransitionKernelContract K) (t : ℝ≥0)
    (f : E →ᵇ ℝ) :
    ‖fellerOperator hK t f‖ ≤ ‖f‖ :=
  norm_fellerOperator_apply_le hK t f

example {K : ℝ≥0 → Kernel E E}
    (hK : FellerTransitionKernelContract K) :
    fellerOperator hK 0 = ContinuousLinearMap.id ℝ (E →ᵇ ℝ) :=
  fellerOperator_zero hK

example {K : ℝ≥0 → Kernel E E}
    (hK : FellerTransitionKernelContract K) (s t : ℝ≥0) :
    fellerOperator hK (s + t) =
      (fellerOperator hK s).comp (fellerOperator hK t) :=
  fellerOperator_add hK s t

example {K : ℝ≥0 → Kernel E E}
    (hK : FellerTransitionKernelContract K) :
    ContinuousLinearSemigroup (E →ᵇ ℝ) :=
  continuousLinearSemigroupOfFeller hK

example (t : ℝ≥0) (f : E →ᵇ ℝ) :
    fellerOperator
        (identityFellerContract : FellerTransitionKernelContract
          (fun _ : ℝ≥0 => (Kernel.id : Kernel E E))) t f = f := by
  ext x
  change (∫ y, f y ∂(Kernel.id : Kernel E E) x) = f x
  rw [Kernel.id_apply]
  exact integral_dirac' f x f.continuous.stronglyMeasurable

end

end AutoSamplingTheory.Tests.FellerSemigroup
