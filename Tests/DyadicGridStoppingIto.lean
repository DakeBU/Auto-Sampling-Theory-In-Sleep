import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.DyadicGridStoppingIto

namespace AutoSamplingTheory.Tests.DyadicGridStoppingIto

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open DyadicGridStoppingIto ElementaryItoIntegral ProgressiveL2Density StoppingTime
open scoped NNReal

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {T : ℝ≥0}

#check IsGridValuedFor
#check stopElementary_coeff_eq_gridCutoff
#check elementaryItoIntegral_stop_gridValued

example
    (eta : DyadicElementaryProcess filtration T)
    (tau : Omega → WithTop ℝ≥0)
    (htau : IsChewiStoppingTime filtration tau)
    (cutoff : Omega → Fin (2 ^ eta.level + 1))
    (hgrid : IsGridValuedFor eta tau cutoff)
    (B : ℝ≥0 → Omega → ℝ) (omega : Omega) :
    elementaryItoIntegral
        (ElementaryStoppingTime.stopElementary eta.process tau htau) B T omega =
      elementaryItoIntegral eta.process B
        (eta.process.times (cutoff omega)) omega :=
  elementaryItoIntegral_stop_gridValued eta tau htau cutoff hgrid B omega

end AutoSamplingTheory.Tests.DyadicGridStoppingIto
