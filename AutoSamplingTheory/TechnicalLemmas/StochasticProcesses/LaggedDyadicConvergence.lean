import AutoSamplingTheory.TechnicalLemmas.Analysis.LeftLebesgueAverage
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.FiniteTimeGrid
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.TimeMeasureRealBridge
import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ElementaryItoEmbedding
import Mathlib.MeasureTheory.Constructions.Polish.StronglyMeasurable

/-!
# Convergence of lagged dyadic approximations

This file connects finite dyadic grid geometry to one-dimensional Lebesgue
differentiation.  It first proves the pointwise estimate for a fixed clipping
level, then upgrades it to product-almost-everywhere convergence.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace StochasticProcesses
namespace LaggedDyadicConvergence

open Filter MeasureTheory Set
open scoped NNReal Topology Interval

open Analysis.LeftLebesgueAverage ElementaryItoIntegral FiniteTimeGrid
  ElementaryItoEmbedding LaggedDyadicApproximation ProgressiveL2 ProgressiveL2Truncation
  SampledElementaryApproximation TimeMeasureRealBridge

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

/-- Away from the initial cell, the lagged dyadic error is controlled by twice
the mean pointwise error on a left neighborhood of radius two mesh widths. -/
theorem abs_laggedDyadicApprox_sub_le
    (eta : ProgressiveL2Integrand filtration mu T) (hT : 0 < T)
    (M level : ℕ) (omega : Omega) {t : ℝ≥0}
    (ht : 0 < t) (htT : t ≤ T)
    (hmesh : 2 * ((dyadicMesh T level : ℝ≥0) : ℝ) < (t : ℝ)) :
    |(laggedDyadicApprox eta hT level M).value t omega -
        (clipped eta M).process t omega| ≤
      2 * leftAverageError (realClippedSection eta M omega) (t : ℝ)
        ⟨2 * ((dyadicMesh T level : ℝ≥0) : ℝ), by positivity⟩ := by
  obtain ⟨i, hi, _hiUnique⟩ := dyadic_activeCell hT level ht htT
  have hi0 : i ≠ 0 := by
    intro hiZero
    subst i
    have ht_delta : t ≤ dyadicMesh T level := by
      simpa only [regularGridTimes, Fin.val_succ, Fin.val_zero,
        Nat.zero_add, Nat.cast_one, one_mul] using hi.2
    have hdelta_nonneg : 0 ≤ ((dyadicMesh T level : ℝ≥0) : ℝ) := by positivity
    have ht_delta_real : (t : ℝ) ≤ (dyadicMesh T level : ℝ) := by exact_mod_cast ht_delta
    linarith
  have hvalue :
      (laggedDyadicApprox eta hT level M).value t omega =
        laggedDyadicCoeff eta level M i omega := by
    rw [FiniteTimeGrid.ElementaryAdaptedProcess.value_eq_coeff_of_mem_cell]
    · rfl
    · simpa only [laggedDyadicApprox_times] using hi
  let delta : ℝ≥0 := dyadicMesh T level
  let b : ℝ≥0 := dyadicLeftTime T level i.val
  let a : ℝ≥0 := b - delta
  have hiVal : i.val ≠ 0 := by
    intro h
    apply hi0
    exact Fin.ext h
  have hdelta : 0 < delta := dyadicMesh_pos hT level
  have hdelta_b : delta ≤ b :=
    dyadicMesh_le_leftTime_of_ne_zero level hiVal
  have hab : a ≤ b := tsub_le_self
  have hbT : b ≤ T := by
    have hb_eq : b = regularGridTimes (dyadicMesh T level) (2 ^ level) i.castSucc := by
      rfl
    rw [hb_eq]
    exact hi.1.le.trans htT
  have hcell : b - a = delta := by
    exact tsub_tsub_cancel_of_le hdelta_b
  have hcellReal : (b : ℝ) - (a : ℝ) = (delta : ℝ) := by
    exact_mod_cast hcell
  have hsubsetReal :
      Ioc (a : ℝ) (b : ℝ) ⊆
        Icc ((t : ℝ) - 2 * (delta : ℝ)) (t : ℝ) := by
    intro r hr
    have ht_bdelta : (t : ℝ) ≤ (b : ℝ) + (delta : ℝ) := by
      have ht_nn : t ≤ b + delta := by
        have hb_eq :
            b = regularGridTimes (dyadicMesh T level) (2 ^ level) i.castSucc := rfl
        rw [hb_eq]
        simpa only [delta, dyadic_activeCell_right i] using hi.2
      exact_mod_cast ht_nn
    have haReal : (a : ℝ) = (b : ℝ) - (delta : ℝ) := by
      exact NNReal.coe_sub hdelta_b
    constructor
    · calc
        (t : ℝ) - 2 * (delta : ℝ) ≤ (b : ℝ) - (delta : ℝ) := by
          linarith
        _ = (a : ℝ) := haReal.symm
        _ ≤ r := hr.1.le
    · have hbt : (b : ℝ) < (t : ℝ) := by exact_mod_cast hi.1
      exact hr.2.trans hbt.le
  rw [hvalue]
  simp only [laggedDyadicCoeff, hiVal, ↓reduceDIte]
  change
    |laggedCellAverage eta M delta a b omega - (clipped eta M).process t omega| ≤ _
  rw [laggedCellAverage]
  rw [integral_upTo_restrict_Ioc_eq_real
    (fun s ↦ clippedExtensionAt eta M b (s, omega)) hab hbT]
  rw [intervalIntegral.integral_of_le (by exact_mod_cast hab)]
  have hsection :
      ∫ r in Ioc (a : ℝ) (b : ℝ),
          realZeroExtension (fun s ↦ clippedExtensionAt eta M b (s, omega)) r ∂volume =
        ∫ r in Ioc (a : ℝ) (b : ℝ), realClippedSection eta M omega r ∂volume := by
    apply setIntegral_congr_fun measurableSet_Ioc
    intro r hr
    have hr0 : 0 ≤ r := by
      exact (show (0 : ℝ) ≤ (a : ℝ) by positivity).trans hr.1.le
    let s : ℝ≥0 := ⟨r, hr0⟩
    have hs_b : s ≤ b := by exact_mod_cast hr.2
    simp only [realClippedSection, realZeroExtension, hr0, ↓reduceIte,
      Real.toNNReal_of_nonneg]
    exact (clippedExtensionAt_apply_of_le eta M hs_b omega).trans
      (clippedExtensionAt_apply_of_le eta M (hs_b.trans hbT) omega).symm
  rw [hsection, ← realClippedSection_coe eta M omega htT]
  change
    |(delta : ℝ)⁻¹ *
          ∫ r in Ioc (a : ℝ) (b : ℝ), realClippedSection eta M omega r ∂volume -
        realClippedSection eta M omega (t : ℝ)| ≤
      2 * leftAverageError (realClippedSection eta M omega) (t : ℝ)
        ⟨2 * (delta : ℝ), by positivity⟩
  exact Analysis.LeftLebesgueAverage.abs_normalized_setIntegral_sub_le_two_mul_leftAverageError
    (realClippedSection_locallyIntegrable eta M omega)
    (by exact_mod_cast hdelta) hcellReal hsubsetReal

/-- Measurable sample-first extension of the clipped process, equal to it on
the stopped horizon and zero beyond the horizon. -/
noncomputable def clippedHorizonFunction
    (eta : ProgressiveL2Integrand filtration mu T) (M : ℕ) :
    Omega × ℝ≥0 → ℝ :=
  fun z ↦ clippedExtensionAt eta M T (z.2, z.1)

theorem clippedHorizonFunction_stronglyMeasurable
    (eta : ProgressiveL2Integrand filtration mu T) (M : ℕ) :
    StronglyMeasurable (clippedHorizonFunction eta M) := by
  have homega :
      @Measurable (Omega × ℝ≥0) Omega
        (MeasurableSpace.prod m inferInstance) (filtration T) Prod.fst :=
    (measurable_fst :
      @Measurable (Omega × ℝ≥0) Omega
        (MeasurableSpace.prod m inferInstance) m Prod.fst).mono
      le_rfl (filtration.le T)
  exact (clippedExtensionAt_stronglyMeasurable eta M T).comp_measurable
    (measurable_snd.prodMk homega)

theorem clippedHorizonFunction_eq
    (eta : ProgressiveL2Integrand filtration mu T) (M : ℕ)
    {z : Omega × ℝ≥0} (hz : z.2 ≤ T) :
    clippedHorizonFunction eta M z = (clipped eta M).process z.2 z.1 :=
  clippedExtensionAt_apply_of_le eta M hz z.1

private theorem laggedDyadicApprox_tendsto_ae_time
    (eta : ProgressiveL2Integrand filtration mu T) (hT : 0 < T)
    (M : ℕ) (omega : Omega) :
    ∀ᵐ t ∂TimeMeasure.upTo T,
      Tendsto
        (fun level ↦ (laggedDyadicApprox eta hT level M).value t omega)
        atTop (𝓝 ((clipped eta M).process t omega)) := by
  rw [← TimeMeasure.restrict_upTo_Ioc_zero T]
  rw [ae_restrict_upTo_Ioc_iff_real (T := T)
    (fun t ↦ Tendsto
      (fun level ↦ (laggedDyadicApprox eta hT level M).value t omega)
      atTop (𝓝 ((clipped eta M).process t omega))) (by simp) le_rfl]
  have havg := ae_tendsto_leftAverageError_two_mul
    (realClippedSection_locallyIntegrable eta M omega)
    (dyadicMesh_tendsto_zero T)
    (fun level ↦ by
      exact_mod_cast dyadicMesh_pos hT level)
  filter_upwards [ae_restrict_of_ae havg,
    ae_restrict_mem (measurableSet_Ioc : MeasurableSet (Ioc (0 : ℝ) (T : ℝ)))]
      with r hravg hr
  have hr0 : 0 ≤ r := hr.1.le
  let t : ℝ≥0 := ⟨r, hr0⟩
  have ht : 0 < t := by exact_mod_cast hr.1
  have htT : t ≤ T := by exact_mod_cast hr.2
  have hbound :
      ∀ᶠ level in atTop,
        |(laggedDyadicApprox eta hT level M).value t omega -
            (clipped eta M).process t omega| ≤
          2 * leftAverageError (realClippedSection eta M omega) (t : ℝ)
            ⟨2 * ((dyadicMesh T level : ℝ≥0) : ℝ), by positivity⟩ := by
    filter_upwards [eventually_two_mul_dyadicMesh_lt T hr.1] with level hlevel
    exact abs_laggedDyadicApprox_sub_le eta hT M level omega ht htT hlevel
  have hright :
      Tendsto
        (fun level ↦
          2 * leftAverageError (realClippedSection eta M omega) (t : ℝ)
            ⟨2 * ((dyadicMesh T level : ℝ≥0) : ℝ), by positivity⟩)
        atTop (𝓝 0) := by
    simpa only [show (t : ℝ) = r from rfl, mul_zero] using hravg.const_mul 2
  have herror :
      Tendsto
        (fun level ↦
          |(laggedDyadicApprox eta hT level M).value t omega -
            (clipped eta M).process t omega|)
        atTop (𝓝 0) :=
    squeeze_zero' (Filter.Eventually.of_forall fun _ ↦ abs_nonneg _)
      hbound hright
  have hsub :
      Tendsto
        (fun level ↦ (laggedDyadicApprox eta hT level M).value t omega -
          (clipped eta M).process t omega)
        atTop (𝓝 0) :=
    (tendsto_zero_iff_abs_tendsto_zero _).mpr herror
  have ht_toNNReal : r.toNNReal = t := by
    apply NNReal.eq
    exact Real.coe_toNNReal r hr0
  rw [ht_toNNReal]
  exact tendsto_sub_nhds_zero_iff.mp hsub

/-- At every fixed clipping level, lagged dyadic approximations converge
pointwise almost everywhere on the repository's sample-first product space. -/
theorem laggedDyadicApprox_tendsto_ae
    [IsFiniteMeasure mu]
    (eta : ProgressiveL2Integrand filtration mu T)
    (hT : 0 < T) (M : ℕ) :
    ∀ᵐ z ∂processTimeMeasure mu T,
      Tendsto
        (fun level ↦
          (laggedDyadicApprox eta hT level M).value z.2 z.1)
        atTop (𝓝 ((clipped eta M).process z.2 z.1)) := by
  let approx : ℕ → Omega × ℝ≥0 → ℝ := fun level z ↦
    (laggedDyadicApprox eta hT level M).value z.2 z.1
  have happrox : ∀ level, Measurable (approx level) := fun level ↦
    (processFunction_stronglyMeasurable
      (laggedDyadicApprox eta hT level M)).measurable
  have htarget : Measurable (clippedHorizonFunction eta M) :=
    (clippedHorizonFunction_stronglyMeasurable eta M).measurable
  have hevent : MeasurableSet {z : Omega × ℝ≥0 |
      Tendsto (fun level ↦ approx level z) atTop
        (𝓝 (clippedHorizonFunction eta M z))} :=
    MeasureTheory.measurableSet_tendsto_fun happrox htarget
  have hconvHorizon :
      ∀ᵐ z ∂processTimeMeasure mu T,
        Tendsto (fun level ↦ approx level z) atTop
          (𝓝 (clippedHorizonFunction eta M z)) := by
    apply (Measure.ae_prod_iff_ae_ae hevent).2
    filter_upwards [] with omega
    filter_upwards [laggedDyadicApprox_tendsto_ae_time eta hT M omega,
      TimeMeasure.ae_mem_Ioc_zero_upTo T] with t ht htmem
    rw [clippedHorizonFunction_eq eta M htmem.2]
    exact ht
  have hsupport :
      ∀ᵐ z ∂processTimeMeasure mu T, z.2 ∈ Ioc 0 T := by
    apply (Measure.ae_prod_iff_ae_ae
      ((measurableSet_Ioc : MeasurableSet (Ioc 0 T)).preimage measurable_snd)).2
    filter_upwards [] with _omega
    exact TimeMeasure.ae_mem_Ioc_zero_upTo T
  filter_upwards [hconvHorizon, hsupport] with z hz hzt
  change Tendsto (fun level ↦ approx level z) atTop _
  rw [← clippedHorizonFunction_eq eta M hzt.2]
  exact hz

end LaggedDyadicConvergence
end StochasticProcesses
end TechnicalLemmas
end AutoSamplingTheory
