import AutoSamplingTheory.TechnicalLemmas.Measure.Transport

namespace AutoSamplingTheory.Tests.Transport

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.Measure.Transport
open scoped ENNReal

#check transportCost
#check transportCost_eq_sInf
#check diagonalCoupling
#check isCoupling_diagonal
#check transportCost_self_eq_zero_of_diagonal

variable {α β : Type*} [MeasurableSpace α] [MeasurableSpace β]

example (c : α × β → ℝ≥0∞) (μ : Measure α) (ν : Measure β) :
    transportCost c μ ν =
      sInf {r : ℝ≥0∞ | ∃ γ ∈ couplingSet μ ν, r = ∫⁻ z, c z ∂γ} :=
  transportCost_eq_sInf c μ ν

example (μ : Measure α) (ν : Measure β)
    [IsProbabilityMeasure μ] [IsProbabilityMeasure ν] :
    (couplingSet μ ν).Nonempty :=
  couplingSet_nonempty μ ν

example (μ : Measure α) :
    IsCoupling (diagonalCoupling μ) μ μ :=
  isCoupling_diagonal μ

example (c : α × α → ℝ≥0∞) (hc : Measurable c)
    (hdiag : ∀ x, c (x, x) = 0) (μ : Measure α) :
    transportCost c μ μ = 0 :=
  transportCost_self_eq_zero_of_diagonal c hc hdiag μ

end AutoSamplingTheory.Tests.Transport
