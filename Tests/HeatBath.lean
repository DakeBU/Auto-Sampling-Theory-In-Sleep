import AutoSamplingTheory.TechnicalLemmas.Probability.HeatBath
import AutoSamplingTheory.TechnicalLemmas.Probability.KernelInvariance

namespace AutoSamplingTheory.Tests.HeatBath

open MeasureTheory ProbabilityTheory
open AutoSamplingTheory.TechnicalLemmas.Probability
open AutoSamplingTheory.TechnicalLemmas.Probability.HeatBath

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]
  [StandardBorelSpace β] [Nonempty β]

example (μ : Measure (α × β)) [IsFiniteMeasure μ] :
    IsMarkovKernel (heatBathSnd μ) := inferInstance

example (μ : Measure (α × β)) [IsFiniteMeasure μ] (x : α × β) :
    heatBathSnd μ x = (Measure.dirac x.1).prod (condDistrib Prod.snd Prod.fst μ x.1) :=
  heatBathSnd_apply μ x

example (μ : Measure (α × β)) [IsFiniteMeasure μ] :
    (heatBathSnd μ).Invariant μ := heatBathSnd_invariant μ

-- A real shared consumer: the new concrete update instantiates the existing
-- kernel-power interface. No duplicate iteration theorem is declared.
example (μ : Measure (α × β)) [IsFiniteMeasure μ] (n : ℕ) :
    ((heatBathSnd μ) ^ n).Invariant μ :=
  KernelInvariance.invariant_pow (heatBathSnd_invariant μ) n

-- Zero target mass still permits a Markov conditional version and invariance.
example : IsMarkovKernel (heatBathSnd (0 : Measure (α × β))) := inferInstance

example : (heatBathSnd (0 : Measure (α × β))).Invariant 0 :=
  heatBathSnd_invariant 0

end AutoSamplingTheory.Tests.HeatBath
