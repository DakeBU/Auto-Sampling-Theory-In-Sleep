import AutoSamplingTheory.TechnicalLemmas.Measure.Transport
import Mathlib.Probability.Kernel.Disintegration.StandardBorel

/-!
# Gluing of transport plans

For finite measures on a standard Borel space, disintegrate the second plan
and compose it with the first:

`γ₁₂₃ := γ₁₂ ⊗ₘ (γ₂₃.condKernel ∘ π₂)`.

This file builds Chewi's gluing construction one marginal identity at a time.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace TransportGluing

open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory

/-- The three-coordinate measure used in the gluing argument:

`γ₁₂₃(dx,dy,dz) = γ₁₂(dx,dy) γ₂₃(dz | y)`.

The product is encoded as `((x,y),z)`. -/
noncomputable def gluingMeasure
    {α : Type*} [MeasurableSpace α] [StandardBorelSpace α] [Nonempty α]
    (γ₁₂ γ₂₃ : Measure (α × α)) [IsFiniteMeasure γ₂₃] :
    Measure ((α × α) × α) :=
  γ₁₂ ⊗ₘ Kernel.prodMkLeft α γ₂₃.condKernel

/-- The `(x,y)` marginal of `γ₁₂₃` is the prescribed first plan:

`(π₁₂)♯ γ₁₂₃ = γ₁₂`. -/
@[simp]
theorem fst_gluingMeasure
    {α : Type*} [MeasurableSpace α] [StandardBorelSpace α] [Nonempty α]
    (γ₁₂ γ₂₃ : Measure (α × α)) [SFinite γ₁₂] [IsFiniteMeasure γ₂₃] :
    (gluingMeasure γ₁₂ γ₂₃).fst = γ₁₂ := by
  unfold gluingMeasure
  exact Measure.fst_compProd _ _

end TransportGluing
end Measure
end TechnicalLemmas
end AutoSamplingTheory
