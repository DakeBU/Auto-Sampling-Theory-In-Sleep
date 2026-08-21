import AutoSamplingTheory.TechnicalLemmas.Measure.Transport

namespace AutoSamplingTheory.Tests.Transport

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure.Transport
open scoped ENNReal

#check AutoSamplingTheory.TechnicalLemmas.Measure.Transport.transportCost
#check AutoSamplingTheory.TechnicalLemmas.Measure.Transport.transportCost_eq_sInf
#check AutoSamplingTheory.TechnicalLemmas.Measure.Transport.transportCost_le_lintegral_of_isCoupling

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]

example (c : α × β → ℝ≥0∞) (μ : Measure α) (ν : Measure β) :
    transportCost c μ ν =
      sInf {r : ℝ≥0∞ | ∃ γ ∈ couplingSet μ ν, r = ∫⁻ z, c z ∂γ} :=
  transportCost_eq_sInf c μ ν

example (c : α × β → ℝ≥0∞) (μ : Measure α) (ν : Measure β)
    (γ : Measure (α × β)) (hγ : IsCoupling γ μ ν) :
    transportCost c μ ν ≤ ∫⁻ z, c z ∂γ :=
  transportCost_le_lintegral_of_isCoupling c μ ν γ hγ

example (μ : Measure α) (ν : Measure β)
    [IsProbabilityMeasure μ] [IsProbabilityMeasure ν] :
    (couplingSet μ ν).Nonempty :=
  couplingSet_nonempty μ ν

end AutoSamplingTheory.Tests.Transport
