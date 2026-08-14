import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.AccumulatedEnergy

namespace AutoSamplingTheory.Tests.AccumulatedEnergy

open MeasureTheory
open scoped NNReal

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ProgressiveL2 AccumulatedEnergy

noncomputable section

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

example (eta : ProgressiveL2Integrand filtration mu T) (t : ℝ≥0) :
    @Measurable Omega ℝ≥0∞ (filtration (min t T)) inferInstance
      (accumulatedEnergy eta t) :=
  accumulatedEnergy_measurable_min eta t

example (eta : ProgressiveL2Integrand filtration mu T)
    {s t : ℝ≥0} (hst : s ≤ t) (omega : Omega) :
    accumulatedEnergy eta s omega ≤ accumulatedEnergy eta t omega :=
  accumulatedEnergy_mono eta hst omega

example (eta : ProgressiveL2Integrand filtration mu T)
    (t : ℝ≥0) (omega : Omega) :
    accumulatedEnergy eta (min t T) omega = accumulatedEnergy eta t omega :=
  accumulatedEnergy_min_horizon eta t omega

end

end AutoSamplingTheory.Tests.AccumulatedEnergy
