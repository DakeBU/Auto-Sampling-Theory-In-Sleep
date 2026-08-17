import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicHorizonExtension

namespace AutoSamplingTheory.Tests.DyadicHorizonExtension

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicGlobalHorizon
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicHorizonExtension
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2Density
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega}

#check extensionLevel
#check dyadicHorizon_mono
#check dyadicMesh_dyadicHorizon_align
#check oldCellCount_le_extension
#check prefixIndex
#check prefix_time_eq
#check extendDyadicHorizon
#check extendDyadicHorizon_coeff_prefix
#check extendDyadicHorizon_coeff_tail
#check extendDyadicHorizon_value_eq_of_le
#check extendDyadicHorizon_value_eq_zero_of_old_lt
#check extendDyadicHorizon_value_eq_restrictProcess_of_ne_terminal
#check processFunction_extendDyadicHorizon_ae_eq_restrictProcess
#check extendDyadicHorizon_toLp_eq_extendByZero

example [IsFiniteMeasure mu]
    {a b : ℕ} (hab : a ≤ b)
    (q : DyadicElementaryProcess filtration (dyadicHorizon a)) :
    (extendDyadicHorizon hab q).toLp mu =
      (ProgressiveL2HorizonExtension.extendByZero
        (ElementaryItoEmbedding.toProgressiveL2 q.process mu (dyadicHorizon a))
        (dyadicHorizon_mono hab)).toLp :=
  extendDyadicHorizon_toLp_eq_extendByZero hab q

end AutoSamplingTheory.Tests.DyadicHorizonExtension
