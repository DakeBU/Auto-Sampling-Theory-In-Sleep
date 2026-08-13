import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CarreDuChamp

namespace AutoSamplingTheory.Tests.CarreDuChamp

open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CarreDuChamp

variable {X : Type*}

#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CarreDuChamp.carreDuChamp
#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CarreDuChamp.iteratedCarreDuChamp
#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CarreDuChamp.SatisfiesBakryEmery

def zeroGenerator : (X → ℝ) →ₗ[ℝ] (X → ℝ) := 0

example (f g : X → ℝ) :
    carreDuChamp (zeroGenerator (X := X)) f g = 0 := by
  ext x
  simp [carreDuChamp, zeroGenerator]

example (f g : X → ℝ) :
    iteratedCarreDuChamp (zeroGenerator (X := X)) f g = 0 := by
  ext x
  simp [iteratedCarreDuChamp, carreDuChamp, zeroGenerator]

example {alpha : ℝ} (halpha : 0 < alpha) :
    SatisfiesBakryEmery (zeroGenerator (X := X)) alpha := by
  refine ⟨halpha, ?_⟩
  intro f x
  simp [carreDuChamp, iteratedCarreDuChamp, zeroGenerator]

end AutoSamplingTheory.Tests.CarreDuChamp
