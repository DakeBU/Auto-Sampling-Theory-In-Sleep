import AutoSamplingTheory.TechnicalLemmas.Probability.KernelMixture
import AutoSamplingTheory.TechnicalLemmas.Probability.HeatBath
import AutoSamplingTheory.TechnicalLemmas.Probability.KernelInvariance

namespace AutoSamplingTheory.Tests.KernelMixture

open MeasureTheory ProbabilityTheory
open scoped NNReal ENNReal
open AutoSamplingTheory.TechnicalLemmas.Probability
open AutoSamplingTheory.TechnicalLemmas.Probability.KernelMixture

variable {ι α β : Type*} [Fintype ι] [MeasurableSpace α] [MeasurableSpace β]

-- No finite/SFinite hypothesis on the target measure.
example (w : ι → ℝ≥0) (κ : ι → Kernel α α) [∀ i, IsSFiniteKernel (κ i)]
    (μ : Measure α) (hsum : ∑ i, w i = 1) (hκ : ∀ i, (κ i).Invariant μ) :
    (finiteMixture w κ).Invariant μ := finiteMixture_invariant w κ μ hsum hκ

-- An actual zero-weight component disappears at the measure level.
example (κ : Bool → Kernel α α) [∀ i, IsSFiniteKernel (κ i)] (a : α) :
    finiteMixture (fun b => if b then 1 else 0) κ a = κ true a := by
  simp [finiteMixture_apply]

variable [StandardBorelSpace β] [Nonempty β]

private noncomputable def lazyHeatBathComponents (μ : Measure (α × β))
    [IsFiniteMeasure μ] (b : Bool) : Kernel (α × β) (α × β) :=
  if b then Kernel.id else HeatBath.heatBathSnd μ

private instance (μ : Measure (α × β)) [IsFiniteMeasure μ] (b : Bool) :
    IsMarkovKernel (lazyHeatBathComponents μ b) := by
  cases b <;> dsimp [lazyHeatBathComponents] <;> infer_instance

example (μ : Measure (α × β)) [IsFiniteMeasure μ] (w : Bool → ℝ≥0)
    (hsum : ∑ b, w b = 1) : IsMarkovKernel (finiteMixture w (lazyHeatBathComponents μ)) :=
  finiteMixture_isMarkovKernel w (lazyHeatBathComponents μ) hsum

-- Identity/heat-bath is a concrete lazy-update consumer; zero weights remain
-- possible. Finite iteration reuses invariant_pow, not a new wrapper theorem.
example (μ : Measure (α × β)) [IsFiniteMeasure μ] (w : Bool → ℝ≥0)
    (hsum : ∑ b, w b = 1) (n : ℕ) :
    ((finiteMixture w (lazyHeatBathComponents μ)) ^ n).Invariant μ := by
  apply KernelInvariance.invariant_pow
  apply finiteMixture_invariant w (lazyHeatBathComponents μ) μ hsum
  intro b
  cases b
  · exact HeatBath.heatBathSnd_invariant μ
  · exact Measure.id_comp

end AutoSamplingTheory.Tests.KernelMixture
