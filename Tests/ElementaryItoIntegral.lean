import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ElementaryItoIntegral

namespace AutoSamplingTheory.Tests.ElementaryItoIntegral

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ElementaryItoIntegral
open scoped BigOperators NNReal

#check ElementaryAdaptedProcess
#check ElementaryAdaptedProcess.value
#check chewi_display_1_1_2
#check elementaryItoIntegral
#check chewi_display_1_1_3

example {Omega : Type*} {m : MeasurableSpace Omega}
    {filtration : Filtration ℝ≥0 m} {n : ℕ}
    (eta : ElementaryAdaptedProcess filtration n)
    (B : ℝ≥0 → Omega → ℝ) (T : ℝ≥0) (omega : Omega) :
    elementaryItoIntegral eta B T omega =
      ∑ i, eta.coeff i omega *
        (B (min (eta.times i.succ) T) omega -
          B (min (eta.times i.castSucc) T) omega) :=
  chewi_display_1_1_3 eta B T omega

end AutoSamplingTheory.Tests.ElementaryItoIntegral
