import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.MarkovSemigroup

namespace AutoSamplingTheory.Tests.MarkovSemigroup

open ProbabilityTheory
open scoped ProbabilityTheory ENNReal

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.MarkovSemigroup

noncomputable section

example {E : Type*} [MeasurableSpace E] :
    TransitionKernelContract
      (fun _ : ℝ≥0 => (Kernel.id : Kernel E E)) := by
  refine
    { isMarkov := ?_
      initial := rfl
      chapmanKolmogorov := ?_ }
  · intro t
    infer_instance
  · intro s t
    simp

example {E : Type*} [MeasurableSpace E]
    {K : ℝ≥0 → Kernel E E} (hK : TransitionKernelContract K) :
    markovOperator hK 0 = id :=
  markovOperator_zero hK

example {E : Type*} [MeasurableSpace E]
    {K : ℝ≥0 → Kernel E E} (hK : TransitionKernelContract K)
    (s t : ℝ≥0) :
    markovOperator hK s ∘ markovOperator hK t =
      markovOperator hK (s + t) :=
  markovOperator_comp hK s t

example {E : Type*} [MeasurableSpace E]
    {K : ℝ≥0 → Kernel E E} (hK : TransitionKernelContract K)
    (s t : ℝ≥0) :
    markovOperator hK s ∘ markovOperator hK t =
      markovOperator hK t ∘ markovOperator hK s :=
  markovOperator_comm hK s t

example {E : Type*} [MeasurableSpace E]
    {K : ℝ≥0 → Kernel E E} (hK : TransitionKernelContract K) :
    markovOperator hK 0 = id ∧
      ∀ s t : ℝ≥0,
        markovOperator hK s ∘ markovOperator hK t =
            markovOperator hK (s + t) ∧
          markovOperator hK t ∘ markovOperator hK s =
            markovOperator hK (s + t) :=
  chewi_lemma_1_2_2 hK

end

end AutoSamplingTheory.Tests.MarkovSemigroup
