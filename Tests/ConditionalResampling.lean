import AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalResampling

namespace AutoSamplingTheory.Tests.ConditionalResampling

open MeasureTheory
open scoped ProbabilityTheory
open AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalResampling

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  [StandardBorelSpace β] [Nonempty β]

example {μ : Measure (α × β)} [IsFiniteMeasure μ] :
    (μ.map Prod.fst) ⊗ₘ
        ProbabilityTheory.condDistrib Prod.snd Prod.fst μ = μ := by
  exact fst_compProd_condDistrib_snd_eq_self

end AutoSamplingTheory.Tests.ConditionalResampling
