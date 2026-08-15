import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingTime

namespace AutoSamplingTheory.Tests.StoppingTime

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingTime
open scoped NNReal

#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.StoppingTime.IsChewiStoppingTime
#check IsChewiStoppingTime.min
#check IsChewiStoppingTime.min_const

example {Ω : Type*} {m : MeasurableSpace Ω}
    (filtration : Filtration ℝ≥0 m) (t : ℝ≥0) :
    IsChewiStoppingTime filtration (fun _ : Ω => (t : WithTop ℝ≥0)) :=
  isChewiStoppingTime_const filtration t

example {Ω : Type*} {m : MeasurableSpace Ω}
    {filtration : Filtration ℝ≥0 m} {τ σ : Ω → WithTop ℝ≥0}
    (hτ : IsChewiStoppingTime filtration τ)
    (hσ : IsChewiStoppingTime filtration σ) :
    IsChewiStoppingTime filtration (fun ω => min (τ ω) (σ ω)) :=
  hτ.min hσ

example {Ω : Type*} {m : MeasurableSpace Ω}
    {filtration : Filtration ℝ≥0 m} {τ : Ω → WithTop ℝ≥0}
    (hτ : IsChewiStoppingTime filtration τ) (T : ℝ≥0) :
    IsChewiStoppingTime filtration
      (fun ω => min (τ ω) (T : WithTop ℝ≥0)) :=
  hτ.min_const T

end AutoSamplingTheory.Tests.StoppingTime
