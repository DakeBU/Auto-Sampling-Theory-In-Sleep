import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.TimeMeasure
import Mathlib.MeasureTheory.Integral.DominatedConvergence

/-!
# Continuity of finite-horizon prefix integrals

A locally integrable function has a continuous primitive when it is integrated
over the moving interval `[0, min t T)`.  The proof is phrased directly on the
finite nonnegative-time measure used by the stochastic-process library, so it
can be reused by the canonical localization energy process.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Analysis
namespace PrefixIntegral

open Filter MeasureTheory Set
open scoped NNReal Topology

open StochasticProcesses

/-- Prefix integral on the finite nonnegative-time horizon. -/
noncomputable def prefixIntegral
    (f : ℝ≥0 → ℝ) (T t : ℝ≥0) : ℝ :=
  ∫ s, if s < min t T then f s else 0 ∂(TimeMeasure.upTo T)

@[simp] theorem prefixIntegral_zero (f : ℝ≥0 → ℝ) (T : ℝ≥0) :
    prefixIntegral f T 0 = 0 := by
  simp [prefixIntegral]

/-- The prefix integral is continuous in its upper time argument. -/
theorem continuous_prefixIntegral
    {f : ℝ≥0 → ℝ} {T : ℝ≥0}
    (hf : Integrable f (TimeMeasure.upTo T)) :
    Continuous (prefixIntegral f T) := by
  rw [continuous_iff_continuousAt]
  intro t0
  let g : ℝ≥0 → ℝ≥0 → ℝ := fun t s =>
    if s < min t T then f s else 0
  have hmeas : ∀ t, AEStronglyMeasurable (g t) (TimeMeasure.upTo T) := by
    intro t
    exact AEStronglyMeasurable.ite measurableSet_Iio hf.1 aestronglyMeasurable_const
  have hbound : ∀ t, ∀ᵐ s ∂(TimeMeasure.upTo T), ‖g t s‖ ≤ ‖f s‖ := by
    intro t
    filter_upwards [] with s
    by_cases hs : s < min t T <;> simp [g, hs]
  have hneq : ∀ᵐ s ∂(TimeMeasure.upTo T), s ≠ min t0 T := by
    rw [ae_iff]
    simpa using TimeMeasure.upTo_singleton T (min t0 T)
  have hb : Tendsto (fun t : ℝ≥0 => min t T) (𝓝 t0) (𝓝 (min t0 T)) :=
    continuousAt_id.min continuousAt_const
  have hpoint : ∀ᵐ s ∂(TimeMeasure.upTo T),
      Tendsto (fun t => g t s) (𝓝 t0) (𝓝 (g t0 s)) := by
    filter_upwards [hneq] with s hs
    by_cases hslt : s < min t0 T
    · have hev : ∀ᶠ t in 𝓝 t0, s < min t T :=
        (tendsto_order.1 hb).1 s hslt
      apply tendsto_congr' (hev.mono fun t ht => by simp [g, ht, hslt]) |>.2
      exact tendsto_const_nhds
    · have hle : min t0 T ≤ s := le_of_not_gt hslt
      have hlt : min t0 T < s := lt_of_le_of_ne hle hs.symm
      have hev : ∀ᶠ t in 𝓝 t0, min t T < s :=
        (tendsto_order.1 hb).2 s hlt
      apply tendsto_congr' (hev.mono fun t ht => by
        have hnot : ¬s < min t T := not_lt_of_ge ht.le
        simp [g, hnot, hslt]) |>.2
      exact tendsto_const_nhds
  change Tendsto (fun t => ∫ s, g t s ∂(TimeMeasure.upTo T))
    (𝓝 t0) (𝓝 (∫ s, g t0 s ∂(TimeMeasure.upTo T)))
  exact tendsto_integral_of_dominated_convergence
    (fun s => ‖f s‖) hmeas hf.norm hbound hpoint

/-- Prefix integration is monotone in time for pointwise nonnegative
integrands. -/
theorem prefixIntegral_mono
    {f : ℝ≥0 → ℝ} {T s t : ℝ≥0}
    (hf : Integrable f (TimeMeasure.upTo T))
    (hnonneg : ∀ u, 0 ≤ f u) (hst : s ≤ t) :
    prefixIntegral f T s ≤ prefixIntegral f T t := by
  unfold prefixIntegral
  have hs : Integrable (fun u => if u < min s T then f u else 0)
      (TimeMeasure.upTo T) := by
    simpa [Set.indicator] using hf.indicator (measurableSet_Iio : MeasurableSet (Iio (min s T)))
  have ht : Integrable (fun u => if u < min t T then f u else 0)
      (TimeMeasure.upTo T) := by
    simpa [Set.indicator] using hf.indicator (measurableSet_Iio : MeasurableSet (Iio (min t T)))
  apply integral_mono hs ht
  intro u
  by_cases hu : u < min s T
  · have hus : u < s := (lt_min_iff.mp hu).1
    have huT : u < T := (lt_min_iff.mp hu).2
    have hut : u < min t T := lt_min (hus.trans_le hst) huT
    simp [hu, hut]
  · by_cases hut : u < min t T
    · simp [hu, hut, hnonneg u]
    · simp [hu, hut]

/-- Prefix integration stabilizes once the observation time passes the
terminal horizon. -/
theorem prefixIntegral_eq_terminal_of_le
    (f : ℝ≥0 → ℝ) (T t : ℝ≥0) (hTt : T ≤ t) :
    prefixIntegral f T t = prefixIntegral f T T := by
  simp [prefixIntegral, min_eq_right hTt]

end PrefixIntegral
end Analysis
end TechnicalLemmas
end AutoSamplingTheory
