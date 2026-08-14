import AutoSamplingTheory.TechnicalLemmas.Analysis.LeftLebesgueAverage

open AutoSamplingTheory TechnicalLemmas Analysis MeasureTheory Filter
open scoped NNReal Topology

#check LeftLebesgueAverage.leftAverageError
#check LeftLebesgueAverage.ae_tendsto_leftAverageError
#check LeftLebesgueAverage.ae_tendsto_leftAverageError_two_mul

example :
    ∀ᵐ t ∂volume,
      Tendsto
        (fun h : ℝ≥0 ↦ LeftLebesgueAverage.leftAverageError (fun _ ↦ (3 : ℝ)) t h)
        (𝓝[>] 0) (𝓝 0) := by
  apply LeftLebesgueAverage.ae_tendsto_leftAverageError
  exact MeasureTheory.locallyIntegrable_const (μ := (volume : Measure ℝ)) (3 : ℝ)

example :
    ∀ᵐ t ∂volume,
      Tendsto
        (fun n ↦ LeftLebesgueAverage.leftAverageError (fun _ ↦ (3 : ℝ)) t
          ⟨2 * ((1 / 2 : ℝ) ^ n), by positivity⟩)
        atTop (𝓝 0) := by
  apply LeftLebesgueAverage.ae_tendsto_leftAverageError_two_mul
    (f := fun _ : ℝ ↦ (3 : ℝ))
    (mesh := fun n ↦ (1 / 2 : ℝ) ^ n)
    (MeasureTheory.locallyIntegrable_const (μ := (volume : Measure ℝ)) (3 : ℝ))
  · exact tendsto_pow_atTop_nhds_zero_of_lt_one (by norm_num) (by norm_num)
  · intro n
    positivity
