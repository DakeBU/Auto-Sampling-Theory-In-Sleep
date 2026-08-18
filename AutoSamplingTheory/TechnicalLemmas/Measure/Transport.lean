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
    change Measure.map id μ = μ
    exact Measure.map_id
  · rw [diagonalCoupling, Measure.snd,
      Measure.map_map measurable_snd hdiag]
    change Measure.map id μ = μ
    exact Measure.map_id

/-- Any measurable nonnegative cost that vanishes on the diagonal has zero
self-transport cost. This isolates the order/measure argument used by the
Wasserstein reflexivity theorem from the special quadratic formula. -/
theorem transportCost_self_eq_zero_of_diagonal
    {α : Type*} [MeasurableSpace α]
    (c : α × α → ℝ≥0∞) (hc : Measurable c)
    (hdiag : ∀ x, c (x, x) = 0) (μ : Measure α) :
    transportCost c μ μ = 0 := by
  have hdiagMeas : Measurable (fun x : α => (x, x)) :=
    measurable_id.prodMk measurable_id
  apply le_antisymm
  · rw [transportCost_eq_sInf]
    refine sInf_le ?_
    refine ⟨diagonalCoupling μ, isCoupling_diagonal μ, ?_⟩
    rw [diagonalCoupling]
    calc
      0 = ∫⁻ x, c (x, x) ∂μ := by simp [hdiag]
      _ = ∫⁻ z, c z ∂Measure.map (fun x : α => (x, x)) μ := by
        exact (lintegral_map hc hdiagMeas).symm
  · exact bot_le

/-- Swapping the two coordinates of a coupling swaps its marginals. -/
theorem isCoupling_map_swap
    {α : Type*} [MeasurableSpace α]
    {γ : Measure (α × α)} {μ ν : Measure α}
    (hγ : IsCoupling γ μ ν) :
    IsCoupling (Measure.map Prod.swap γ) ν μ := by
  constructor
  · rw [Measure.fst_map_swap]
    exact hγ.2
  · rw [Measure.snd_map_swap]
    exact hγ.1

/-- A measurable symmetric cost has the same integral after swapping a joint
measure's coordinates. -/
theorem lintegral_map_swap_eq_of_symmetric
    {α : Type*} [MeasurableSpace α]
    (c : α × α → ℝ≥0∞) (hc : Measurable c)
    (hsymm : ∀ x y, c (x, y) = c (y, x))
    (γ : Measure (α × α)) :
    (∫⁻ z, c z ∂Measure.map Prod.swap γ) = ∫⁻ z, c z ∂γ := by
  rw [lintegral_map hc measurable_swap]
  apply lintegral_congr
  rintro ⟨x, y⟩
  exact (hsymm x y).symm

/-- Symmetric measurable costs have symmetric Kantorovich transport values.
The proof swaps every feasible coupling, so it does not assume existence of an
optimal coupling. -/
theorem transportCost_comm_of_symmetric
    {α : Type*} [MeasurableSpace α]
    (c : α × α → ℝ≥0∞) (hc : Measurable c)
    (hsymm : ∀ x y, c (x, y) = c (y, x))
    (μ ν : Measure α) :
    transportCost c μ ν = transportCost c ν μ := by
  have hvalues :
      {r : ℝ≥0∞ | ∃ γ ∈ couplingSet μ ν, r = ∫⁻ z, c z ∂γ} =
        {r : ℝ≥0∞ | ∃ γ ∈ couplingSet ν μ, r = ∫⁻ z, c z ∂γ} := by
    ext r
    constructor
    · rintro ⟨γ, hγ, hr⟩
      change IsCoupling γ μ ν at hγ
      refine ⟨Measure.map Prod.swap γ, isCoupling_map_swap hγ, ?_⟩
      calc
        r = ∫⁻ z, c z ∂γ := hr
        _ = ∫⁻ z, c z ∂Measure.map Prod.swap γ :=
          (lintegral_map_swap_eq_of_symmetric c hc hsymm γ).symm
    · rintro ⟨γ, hγ, hr⟩
      change IsCoupling γ ν μ at hγ
      refine ⟨Measure.map Prod.swap γ, isCoupling_map_swap hγ, ?_⟩
      calc
        r = ∫⁻ z, c z ∂γ := hr
        _ = ∫⁻ z, c z ∂Measure.map Prod.swap γ :=
          (lintegral_map_swap_eq_of_symmetric c hc hsymm γ).symm
  rw [transportCost_eq_sInf, transportCost_eq_sInf, hvalues]

end Transport
end Measure
end TechnicalLemmas
end AutoSamplingTheory
