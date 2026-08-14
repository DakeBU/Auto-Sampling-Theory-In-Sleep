import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicEnergyStopping

namespace AutoSamplingTheory.Tests.DyadicEnergyStopping

open MeasureTheory Set
open scoped ENNReal NNReal

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ProgressiveL2 LocalSquareIntegrable DyadicEnergyStopping

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

example (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (hT : 0 < T) (level : ℕ) :
    Adapted (dyadicFiltration filtration T level)
      (dyadicEnergyProcess hUsual eta level) :=
  dyadicEnergyProcess_adapted hUsual eta hT level

example (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocallySquareIntegrableProgressive filtration mu T)
    (hT : 0 < T) (level threshold : ℕ) :
    IsStoppingTime filtration
      (dyadicEnergyHitTime hUsual eta level threshold) :=
  dyadicEnergyHitTime_isStoppingTime hUsual eta hT level threshold

end

end AutoSamplingTheory.Tests.DyadicEnergyStopping
