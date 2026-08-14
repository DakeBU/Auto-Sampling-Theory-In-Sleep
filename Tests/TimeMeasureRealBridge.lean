import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.TimeMeasureRealBridge

open AutoSamplingTheory TechnicalLemmas StochasticProcesses MeasureTheory Set
open scoped NNReal Interval

#check TimeMeasureRealBridge.realZeroExtension
#check TimeMeasureRealBridge.realZeroExtension_measurable
#check TimeMeasureRealBridge.realZeroExtension_stronglyMeasurable
#check TimeMeasureRealBridge.realZeroExtension_coe
#check TimeMeasureRealBridge.realZeroExtension_eq_zero_of_neg
#check TimeMeasureRealBridge.map_restrict_upTo_Ioc
#check TimeMeasureRealBridge.integral_upTo_restrict_Ioc_eq_real
#check TimeMeasureRealBridge.ae_restrict_upTo_Ioc_iff_real
#check TimeMeasureRealBridge.ae_prod_restrict_upTo_of_forall_ae
#check TimeMeasureRealBridge.realClippedSection
#check TimeMeasureRealBridge.realClippedSection_coe
#check TimeMeasureRealBridge.realClippedSection_eq_zero_of_neg
#check TimeMeasureRealBridge.realClippedSection_eq_zero_of_T_lt
#check TimeMeasureRealBridge.realClippedSection_abs_le
#check TimeMeasureRealBridge.realClippedSection_stronglyMeasurable
#check TimeMeasureRealBridge.realClippedSection_locallyIntegrable
#check TimeMeasure.upTo_univ
#check TimeMeasure.upTo_singleton
#check TimeMeasure.ae_mem_Ioc_zero_upTo
#check TimeMeasure.restrict_upTo_Ioc_zero

example :
    ∫ _s, (1 : ℝ) ∂((TimeMeasure.upTo 3).restrict (Ioc 1 2)) = 1 := by
  rw [TimeMeasureRealBridge.integral_upTo_restrict_Ioc_eq_real
    (fun _ : ℝ≥0 ↦ (1 : ℝ)) (by norm_num) (by norm_num)]
  rw [intervalIntegral.integral_congr (g := fun _ : ℝ ↦ (1 : ℝ))]
  · norm_num
  · intro r hr
    have hr0 : 0 ≤ r := by
      rw [uIcc_of_le (by norm_num)] at hr
      exact (show (0 : ℝ) ≤ 1 by norm_num).trans hr.1
    simp [TimeMeasureRealBridge.realZeroExtension, hr0]

example :
    ∫ _s, (0 : ℝ) ∂((TimeMeasure.upTo 3).restrict (Ioc 1 2)) = 0 := by
  simp

example :
    Measure.map ((↑) : ℝ≥0 → ℝ)
        ((TimeMeasure.upTo 3).restrict (Ioc 1 2)) =
      volume.restrict (Ioc (1 : ℝ) 2) := by
  exact TimeMeasureRealBridge.map_restrict_upTo_Ioc (by norm_num) (by norm_num)

example :
    ((TimeMeasure.upTo 3).restrict (Ioc 1 2)) Set.univ = 1 := by
  rw [Measure.restrict_apply MeasurableSet.univ]
  simp only [Set.univ_inter]
  rw [TimeMeasure.upTo_Ioc 3 1 2 (by norm_num)]
  norm_num [min_def]
  norm_cast
