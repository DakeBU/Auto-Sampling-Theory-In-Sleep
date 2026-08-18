import Mathlib.MeasureTheory.Integral.Lebesgue.Map
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
open scoped ENNReal

/-- A measure on a product space couples two marginals when its first and
second marginals are the specified measures. Probability normalization remains
visible through the marginal measures' typeclass assumptions at consumers. -/
def IsCoupling {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (γ : Measure (α × β)) (μ : Measure α) (ν : Measure β) : Prop :=
  γ.fst = μ ∧ γ.snd = ν

/-- The feasible set of couplings with prescribed marginals. -/
def couplingSet {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (μ : Measure α) (ν : Measure β) : Set (Measure (α × β)) :=
  {γ | IsCoupling γ μ ν}

/-- Chewi Definition 1.3.1 and display (1.3.2): the Kantorovich
transport cost for an extended nonnegative cost function.

Measurability and lower semicontinuity of `c` are not needed to state the
extended-real infimum. They enter the later existence theorem. -/
noncomputable def transportCost {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (c : α × β → ℝ≥0∞) (μ : Measure α) (ν : Measure β) : ℝ≥0∞ :=
  sInf {r : ℝ≥0∞ | ∃ γ ∈ couplingSet μ ν, r = ∫⁻ z, c z ∂γ}

/-- Source-facing expansion of the Kantorovich value in display (1.3.2). -/
theorem transportCost_eq_sInf
    {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (c : α × β → ℝ≥0∞) (μ : Measure α) (ν : Measure β) :
    transportCost c μ ν =
      sInf {r : ℝ≥0∞ | ∃ γ ∈ couplingSet μ ν, r = ∫⁻ z, c z ∂γ} :=
  rfl

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

/-- The feasible set in the Kantorovich problem is nonempty for probability
marginals. -/
theorem couplingSet_nonempty
    {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
    (μ : Measure α) (ν : Measure β) [IsProbabilityMeasure μ] [IsProbabilityMeasure ν] :
    (couplingSet μ ν).Nonempty :=
  ⟨μ.prod ν, isCoupling_prod μ ν⟩

/-- The diagonal pushforward of a measure. Unlike the independent product,
this construction is available without probability assumptions and is the
canonical zero-cost self-coupling for metric transport costs. -/
noncomputable def diagonalCoupling
    {α : Type*} [MeasurableSpace α] (μ : Measure α) : Measure (α × α) :=
  Measure.map (fun x => (x, x)) μ

/-- The diagonal pushforward has both marginals equal to the original measure. -/
theorem isCoupling_diagonal
    {α : Type*} [MeasurableSpace α] (μ : Measure α) :
    IsCoupling (diagonalCoupling μ) μ μ := by
  have hdiag : Measurable (fun x : α => (x, x)) :=
    measurable_id.prodMk measurable_id
  constructor
  · rw [diagonalCoupling, Measure.fst,
      Measure.map_map measurable_fst hdiag]
    simp
  · rw [diagonalCoupling, Measure.snd,
      Measure.map_map measurable_snd hdiag]
    simp

/-- Any measurable nonnegative cost that vanishes on the diagonal has zero
self-transport cost. This isolates the order/measure argument used by the
Wasserstein reflexivity theorem from the special quadratic formula. -/
theorem transportCost_self_eq_zero_of_diagonal
    {α : Type*} [MeasurableSpace α]
    (c : α × α → ℝ≥0∞) (hc : Measurable c)
    (hdiag : ∀ x, c (x, x) = 0) (μ : Measure α) :
    transportCost c μ μ = 0 := by
  apply le_antisymm
  · rw [transportCost_eq_sInf]
    refine sInf_le ?_
    refine ⟨diagonalCoupling μ, isCoupling_diagonal μ, ?_⟩
    rw [diagonalCoupling, lintegral_map hc (measurable_id.prodMk measurable_id)]
    simp [hdiag]
  · exact bot_le

end Transport
end Measure
end TechnicalLemmas
end AutoSamplingTheory
