import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2HorizonExtension

namespace AutoSamplingTheory.Tests.ProgressiveL2HorizonExtension

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2HorizonExtension
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}
  {T₁ T₂ : ℝ≥0}

#check horizonPrefix
#check measurableSet_horizonPrefix
#check restrict_processTimeMeasure_horizonPrefix
#check processFunction_restrictProcess_eq_indicator
#check extendByZero
#check norm_extendByZero_eq
#check extendByZero_sub_toLp
#check norm_extendByZero_sub_extendByZero_eq

example (eta xi : ProgressiveL2Integrand filtration mu T₁)
    (hT : T₁ ≤ T₂) :
    ‖(extendByZero eta hT).toLp - (extendByZero xi hT).toLp‖ =
      ‖eta.toLp - xi.toLp‖ :=
  norm_extendByZero_sub_extendByZero_eq eta xi hT

end AutoSamplingTheory.Tests.ProgressiveL2HorizonExtension
