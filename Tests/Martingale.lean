import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Martingale

namespace AutoSamplingTheory.Tests.Martingale

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Martingale
open scoped NNReal

#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Martingale.IsChewiMartingale

example {Ω : Type*} {m : MeasurableSpace Ω}
    (filtration : Filtration ℝ≥0 m) (μ : Measure Ω) [IsFiniteMeasure μ]
    (value : ℝ) :
    IsChewiMartingale (fun _ : ℝ≥0 => fun _ : Ω => value) filtration μ :=
  isChewiMartingale_const filtration μ value

end AutoSamplingTheory.Tests.Martingale
