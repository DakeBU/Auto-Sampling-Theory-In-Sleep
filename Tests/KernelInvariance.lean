import AutoSamplingTheory.TechnicalLemmas.Probability.KernelInvariance

namespace AutoSamplingTheory.Tests.KernelInvariance

open MeasureTheory
open ProbabilityTheory
open AutoSamplingTheory.TechnicalLemmas.Probability.KernelInvariance

variable {α : Type*} [MeasurableSpace α]

example {κ : Kernel α α} {μ : Measure α}
    (hκ : κ.Invariant μ) :
    (κ ^ 7).Invariant μ := by
  exact invariant_pow hκ 7

example {κ : Kernel α α} [IsMarkovKernel κ] {μ : Measure α}
    (hrev : κ.IsReversible μ) :
    μ.bind (κ ^ (5 : ℕ) : Kernel α α) = μ := by
  exact bind_pow_eq hrev.invariant 5

end AutoSamplingTheory.Tests.KernelInvariance
