import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CompletedLocalIntegrand

namespace AutoSamplingTheory.Tests.CompletedLocalIntegrand

open MeasureTheory Set
open scoped ENNReal NNReal

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ProgressiveL2 LocalSquareIntegrable CompletedLocalIntegrand

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

example (eta : LocallySquareIntegrableProgressive filtration mu T) :
    mu (goodEnergySet eta)ᶜ = 0 :=
  badEnergySet_null eta

example (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T) :
    IsStronglyProgressive filtration (completedProcess eta) :=
  completedProcess_progressive hUsual eta

example (eta : LocallySquareIntegrableProgressive filtration mu T)
    (omega : Omega) :
    (∫⁻ t, ENNReal.ofReal ((completedProcess eta t omega) ^ 2)
      ∂(TimeMeasure.upTo T)) < ∞ :=
  completedProcess_energy_lt_top eta omega

end

end AutoSamplingTheory.Tests.CompletedLocalIntegrand
