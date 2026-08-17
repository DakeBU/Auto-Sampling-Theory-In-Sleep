import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ElementaryStoppingTime

namespace AutoSamplingTheory.Tests.ElementaryStoppingTime

open MeasureTheory Set
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open ElementaryItoIntegral StoppingTime ElementaryStoppingTime
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m}

#check activeBefore
#check measurableSet_activeBefore
#check stopElementary
#check stopElementary_coeff

example {tau : Omega → WithTop ℝ≥0}
    (htau : IsChewiStoppingTime filtration tau) (t : ℝ≥0) :
    MeasurableSet[filtration t] (activeBefore tau t) :=
  measurableSet_activeBefore htau t

example {n : ℕ} (eta : ElementaryAdaptedProcess filtration n)
    (tau : Omega → WithTop ℝ≥0)
    (htau : IsChewiStoppingTime filtration tau)
    (i : Fin n) (omega : Omega) :
    (stopElementary eta tau htau).coeff i omega =
      if (eta.times i.castSucc : WithTop ℝ≥0) < tau omega
      then eta.coeff i omega else 0 :=
  stopElementary_coeff eta tau htau i omega

end AutoSamplingTheory.Tests.ElementaryStoppingTime
