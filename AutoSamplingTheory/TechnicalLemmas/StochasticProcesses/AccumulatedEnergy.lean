import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
import Mathlib.MeasureTheory.Measure.Prod

/-!
# Accumulated pathwise energy

This file constructs the increasing adapted energy process used by Chewi's
canonical localization argument.  The process is defined on the fixed finite
horizon measure and a progressive representative is extended by zero after
the inspected time.  This makes filtration measurability and monotonicity
explicit before the hitting-time construction.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace AccumulatedEnergy

open MeasureTheory Set
open scoped ENNReal NNReal

open ElementaryItoIntegral ProgressiveL2

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

/-- Extend a progressive process from `[0,b] × Ω` by zero.  The sample-space
measurable structure is the information available at time `b`. -/
noncomputable def progressiveExtensionAt
    (eta : ProgressiveL2Integrand filtration mu T) (b : ℝ≥0) :
    ℝ≥0 × Omega → ℝ :=
  Function.extend
    (Prod.map ((↑) : Set.Iic b → ℝ≥0) id)
    (fun p : Set.Iic b × Omega => eta.process p.1 p.2)
    0

theorem progressiveExtensionAt_stronglyMeasurable
    (eta : ProgressiveL2Integrand filtration mu T) (b : ℝ≥0) :
    @StronglyMeasurable (ℝ≥0 × Omega) ℝ inferInstance
      (MeasurableSpace.prod inferInstance (filtration b))
      (progressiveExtensionAt eta b) := by
  apply ((MeasurableEmbedding.subtype_coe measurableSet_Iic).prodMap
    MeasurableEmbedding.id).stronglyMeasurable_extend
  · exact eta.progressive b
  · exact stronglyMeasurable_const

@[simp] theorem progressiveExtensionAt_apply_of_le
    (eta : ProgressiveL2Integrand filtration mu T)
    {s b : ℝ≥0} (hsb : s ≤ b) (omega : Omega) :
    progressiveExtensionAt eta b (s, omega) = eta.process s omega := by
  let p : Set.Iic b × Omega := (⟨s, hsb⟩, omega)
  exact ((MeasurableEmbedding.subtype_coe measurableSet_Iic).prodMap
    MeasurableEmbedding.id).injective.extend_apply
      (fun q : Set.Iic b × Omega => eta.process q.1 q.2) 0 p

@[simp] theorem progressiveExtensionAt_eq_zero_of_not_le
    (eta : ProgressiveL2Integrand filtration mu T)
    {s b : ℝ≥0} (hsb : ¬s ≤ b) (omega : Omega) :
    progressiveExtensionAt eta b (s, omega) = 0 := by
  rw [progressiveExtensionAt, Function.extend_apply']
  · rfl
  · rintro ⟨u, hu⟩
    apply hsb
    have htime := congrArg Prod.fst hu
    change (u.1 : ℝ≥0) = s at htime
    have hub : (u.1 : ℝ≥0) ≤ b := u.1.property
    rwa [← htime]

/-- Squared energy accumulated up to `min t T`, represented as an `ENNReal`
lintegral so finiteness is never hidden by totalized real integration. -/
noncomputable def accumulatedEnergy
    (eta : ProgressiveL2Integrand filtration mu T) (t : ℝ≥0)
    (omega : Omega) : ℝ≥0∞ :=
  ∫⁻ s, ENNReal.ofReal
      ((progressiveExtensionAt eta (min t T) (s, omega)) ^ 2)
    ∂(TimeMeasure.upTo T)

/-- At a fixed time, accumulated energy is measurable using only the
information at `min t T`. -/
theorem accumulatedEnergy_measurable_min
    (eta : ProgressiveL2Integrand filtration mu T) (t : ℝ≥0) :
    @Measurable Omega ℝ≥0∞ (filtration (min t T)) inferInstance
      (accumulatedEnergy eta t) := by
  have hreal :=
    (progressiveExtensionAt_stronglyMeasurable eta (min t T)).measurable
  have hsquare :
      @Measurable (ℝ≥0 × Omega) ℝ inferInstance
        (MeasurableSpace.prod inferInstance (filtration (min t T)))
        (fun z => (progressiveExtensionAt eta (min t T) z) ^ 2) :=
    hreal.pow_const 2
  have hnonnegative :
      @Measurable (ℝ≥0 × Omega) ℝ≥0∞ inferInstance
        (MeasurableSpace.prod inferInstance (filtration (min t T)))
        (fun z => ENNReal.ofReal
          ((progressiveExtensionAt eta (min t T) z) ^ 2)) :=
    ENNReal.measurable_ofReal.comp hsquare
  exact hnonnegative.lintegral_prod_left'

private theorem extension_sq_mono
    (eta : ProgressiveL2Integrand filtration mu T)
    {a b : ℝ≥0} (hab : a ≤ b) (s : ℝ≥0) (omega : Omega) :
    ENNReal.ofReal ((progressiveExtensionAt eta a (s, omega)) ^ 2) ≤
      ENNReal.ofReal ((progressiveExtensionAt eta b (s, omega)) ^ 2) := by
  by_cases hsa : s ≤ a
  · rw [progressiveExtensionAt_apply_of_le eta hsa omega,
      progressiveExtensionAt_apply_of_le eta (hsa.trans hab) omega]
  · rw [progressiveExtensionAt_eq_zero_of_not_le eta hsa omega]
    simp

/-- The accumulated energy is increasing in the observation time. -/
theorem accumulatedEnergy_mono
    (eta : ProgressiveL2Integrand filtration mu T)
    {s t : ℝ≥0} (hst : s ≤ t) (omega : Omega) :
    accumulatedEnergy eta s omega ≤ accumulatedEnergy eta t omega := by
  unfold accumulatedEnergy
  apply lintegral_mono
  intro u
  exact extension_sq_mono eta (min_le_min hst le_rfl) u omega

/-- Clipping the time argument at the fixed horizon does not change the
accumulated energy. -/
theorem accumulatedEnergy_min_horizon
    (eta : ProgressiveL2Integrand filtration mu T) (t : ℝ≥0)
    (omega : Omega) :
    accumulatedEnergy eta (min t T) omega = accumulatedEnergy eta t omega := by
  unfold accumulatedEnergy
  rw [min_assoc, min_self]

end AccumulatedEnergy
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
