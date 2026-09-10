import AutoSamplingTheory.TechnicalLemmas.Probability.KernelTotalVariation

open MeasureTheory ProbabilityTheory
open scoped ProbabilityTheory
open AutoSamplingTheory.TechnicalLemmas.Probability.KernelTotalVariation

#check abs_real_comp_sub_le
#print axioms abs_real_comp_sub_le

section
variable {A B : Type*} [MeasurableSpace A] [MeasurableSpace B]
variable (μ ν : Measure A) [IsProbabilityMeasure μ] [IsProbabilityMeasure ν]
variable (K : Kernel A B) [IsMarkovKernel K]

-- Empty events force the advertised radius to be nonnegative.
example {δ : ℝ} (hδ : ∀ s, MeasurableSet s → |μ.real s - ν.real s| ≤ δ) :
    0 ≤ δ := by
  simpa using hδ ∅ MeasurableSet.empty

-- Zero discrepancy is preserved without an additional positive-radius premise.
example : ∀ t, MeasurableSet t →
    |(K ∘ₘ μ).real t - (K ∘ₘ μ).real t| ≤ (0 : ℝ) := by
  exact abs_real_comp_sub_le μ μ K (fun s _ => by simp)

-- Actual/proxy composition: the target mixing estimate is a SEPARATE input.
-- Neither warmness, the source algorithm kernel, nor its cost is proved here.
example (π : Measure B) [IsProbabilityMeasure π] {δ ε : ℝ}
    (hinput : ∀ s, MeasurableSet s → |μ.real s - ν.real s| ≤ δ)
    (hproxy : ∀ t, MeasurableSet t → |(K ∘ₘ ν).real t - π.real t| ≤ ε) :
    ∀ t, MeasurableSet t → |(K ∘ₘ μ).real t - π.real t| ≤ δ + ε := by
  intro t ht
  exact (abs_sub_le ((K ∘ₘ μ).real t) ((K ∘ₘ ν).real t) (π.real t)).trans
    (add_le_add (abs_real_comp_sub_le μ ν K hinput t ht) (hproxy t ht))

end
