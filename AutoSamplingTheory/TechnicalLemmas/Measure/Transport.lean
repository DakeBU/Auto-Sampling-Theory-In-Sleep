import Mathlib.MeasureTheory.Measure.Prod

/-!
# Couplings and transport foundations

Small measure-level interfaces shared by optimal transport and coupling proofs
for sampling algorithms. Algorithmic costs and Wasserstein optimization remain
separate layers.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace Transport

open MeasureTheory

/-- A measure on a product space couples two marginals when its first and
second marginals are the specified measures. Probability normalization remains
visible through the marginal measures' typeclass assumptions at consumers. -/
def IsCoupling {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (γ : Measure (α × β)) (μ : Measure α) (ν : Measure β) : Prop :=
  γ.fst = μ ∧ γ.snd = ν

/-- A prescribed probability marginal forces the joint coupling measure to
have total mass one. This recovers the probability-measure interface required
by expectations and transport costs from the marginal contract. -/
theorem isProbabilityMeasure_of_isCoupling_left
    {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    {γ : Measure (α × β)} {μ : Measure α} {ν : Measure β}
    [IsProbabilityMeasure μ] (hγ : IsCoupling γ μ ν) :
    IsProbabilityMeasure γ := by
  constructor
  rw [← Measure.fst_univ, hγ.1, measure_univ]

/-- The independent product measure is a coupling of two probability measures.
This supplies the canonical nonemptiness witness for the Kantorovich feasible
set in Chewi, Definition 1.3.1. -/
theorem isCoupling_prod {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (μ : Measure α) (ν : Measure β) [IsProbabilityMeasure μ] [IsProbabilityMeasure ν] :
    IsCoupling (μ.prod ν) μ ν := by
  constructor <;> simp

end Transport
end Measure
end TechnicalLemmas
end AutoSamplingTheory
