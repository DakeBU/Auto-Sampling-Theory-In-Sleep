import Mathlib.MeasureTheory.Covering.Differentiation
import Mathlib.MeasureTheory.Covering.OneDim
import Mathlib.Topology.Instances.NNReal.Lemmas

/-!
# Left-sided Lebesgue averages

This file packages the one-dimensional Lebesgue differentiation theorem in
the precise left-sided form used by lagged time discretizations.  The public
interface uses a nonnegative window width, while the proof passes through the
real Vitali family of intervals `[t - h, t]`.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Analysis
namespace LeftLebesgueAverage

open Filter MeasureTheory Set IsUnifLocDoublingMeasure
open scoped NNReal Topology

/-- Mean pointwise error over the left interval `[t-h,t]`. -/
noncomputable def leftAverageError (f : ℝ → ℝ) (t : ℝ) (h : ℝ≥0) : ℝ :=
  ⨍ s in Icc (t - (h : ℝ)) t, |f s - f t| ∂volume

private theorem tendsto_sub_nhdsGT_zero_nhdsLT (t : ℝ) :
    Tendsto (fun h : ℝ ↦ t - h) (𝓝[>] 0) (𝓝[<] t) := by
  apply tendsto_nhdsWithin_iff.mpr
  constructor
  · have hfull : Tendsto (fun h : ℝ ↦ t - h) (𝓝 0) (𝓝 t) := by
      simpa using ((tendsto_const_nhds :
        Tendsto (fun _ : ℝ ↦ t) (𝓝 (0 : ℝ)) (𝓝 t)).sub tendsto_id)
    exact hfull.mono_left
      (show (𝓝[>] (0 : ℝ)) ≤ 𝓝 0 from inf_le_left)
  · filter_upwards [self_mem_nhdsWithin] with h hh
    exact sub_lt_self t hh

private theorem ae_tendsto_leftAverageError_real
    {f : ℝ → ℝ} (hf : LocallyIntegrable f volume) :
    ∀ᵐ t ∂volume,
      Tendsto (fun h : ℝ ↦ ⨍ s in Icc (t - h) t, |f s - f t| ∂volume)
        (𝓝[>] 0) (𝓝 0) := by
  have hdiff := (vitaliFamily volume 1).ae_tendsto_average_norm_sub hf
  filter_upwards [hdiff] with t ht
  have hsets :
      Tendsto (fun h : ℝ ↦ Icc (t - h) t) (𝓝[>] 0)
        ((vitaliFamily volume 1).filterAt t) :=
    t.tendsto_Icc_vitaliFamily_left.comp (tendsto_sub_nhdsGT_zero_nhdsLT t)
  change Tendsto
    ((fun a : Set ℝ ↦ ⨍ s in a, |f s - f t| ∂volume) ∘
      fun h : ℝ ↦ Icc (t - h) t) (𝓝[>] 0) (𝓝 0)
  simpa only [Real.norm_eq_abs] using ht.comp hsets

/-- For almost every time, the left average error converges to zero as a
strictly positive nonnegative window shrinks to zero. -/
theorem ae_tendsto_leftAverageError
    {f : ℝ → ℝ} (hf : LocallyIntegrable f volume) :
    ∀ᵐ t ∂volume,
      Tendsto (fun h : ℝ≥0 ↦ leftAverageError f t h)
        (𝓝[>] 0) (𝓝 0) := by
  filter_upwards [ae_tendsto_leftAverageError_real hf] with t ht
  have hcoe :
      Tendsto ((↑) : ℝ≥0 → ℝ) (𝓝[>] 0) (𝓝[>] 0) := by
    show Filter.map ((↑) : ℝ≥0 → ℝ) (𝓝[>] 0) ≤ 𝓝[>] (0 : ℝ)
    rw [NNReal.map_coe_nhdsGT]
    simp
  change Tendsto
    ((fun h : ℝ ↦ ⨍ s in Icc (t - h) t, |f s - f t| ∂volume) ∘
      ((↑) : ℝ≥0 → ℝ)) (𝓝[>] 0) (𝓝 0)
  exact ht.comp hcoe

/-- Sequential form used by dyadic meshes: any positive real mesh tending to
zero gives vanishing left average error along twice that mesh. -/
theorem ae_tendsto_leftAverageError_two_mul
    {f : ℝ → ℝ} (hf : LocallyIntegrable f volume)
    {mesh : ℕ → ℝ} (hmesh : Tendsto mesh atTop (𝓝 0))
    (hmeshPos : ∀ n, 0 < mesh n) :
    ∀ᵐ t ∂volume,
      Tendsto
        (fun n ↦ leftAverageError f t
          ⟨2 * mesh n, (mul_pos (by norm_num) (hmeshPos n)).le⟩)
        atTop (𝓝 0) := by
  let widths : ℕ → ℝ≥0 :=
    fun n ↦ ⟨2 * mesh n, (mul_pos (by norm_num) (hmeshPos n)).le⟩
  have hwidths_nhds : Tendsto widths atTop (𝓝 (0 : ℝ≥0)) := by
    apply NNReal.tendsto_coe.mp
    change Tendsto (fun n ↦ (2 : ℝ) * mesh n) atTop (𝓝 (0 : ℝ))
    simpa using
      (tendsto_const_nhds.mul hmesh :
        Tendsto (fun n ↦ (2 : ℝ) * mesh n) atTop (𝓝 (2 * 0)))
  have hwidths : Tendsto widths atTop (𝓝[>] (0 : ℝ≥0)) := by
    apply tendsto_nhdsWithin_iff.mpr
    refine ⟨hwidths_nhds, ?_⟩
    filter_upwards [] with n
    exact (mul_pos (by norm_num) (hmeshPos n))
  filter_upwards [ae_tendsto_leftAverageError hf] with t ht
  change Tendsto (fun n ↦ leftAverageError f t (widths n)) atTop (𝓝 0)
  exact ht.comp hwidths

end LeftLebesgueAverage
end Analysis
end TechnicalLemmas
end AutoSamplingTheory
