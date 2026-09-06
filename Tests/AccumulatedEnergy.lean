import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.AccumulatedEnergy

namespace AutoSamplingTheory.Tests.AccumulatedEnergy

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.AccumulatedEnergy

#check accumulatedEnergy
#check accumulatedEnergy_zero
#check accumulatedEnergy_mono
#check accumulatedEnergy_eq_terminal_of_le
#check accumulatedEnergy_le_terminal
#check accumulatedEnergy_nonneg

example {Omega : Type*} [MeasurableSpace Omega]
    (eta : NNReal → Omega → ℝ) (T : NNReal) (omega : Omega) :
    accumulatedEnergy eta T 0 omega = 0 :=
  accumulatedEnergy_zero eta T omega

end AutoSamplingTheory.Tests.AccumulatedEnergy
