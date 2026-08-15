import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalRawLocalizationL2

namespace AutoSamplingTheory.Tests.CanonicalRawLocalizationL2

open MeasureTheory
open AutoSamplingTheory.TechnicalLemmas.StochasticProcesses
open CanonicalRawLocalization CanonicalRawLocalizationL2 LocalProgressiveL2

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : Filtration ℝ≥0 m} {mu : Measure Omega} {T : ℝ≥0}

#check rawStoppedTimeLintegral_le
#check rawStoppedProductEnergy_lt_top
#check canonicalRaw_isLocalizingSequence

/-- Focused source-contract smoke test for Chewi Proposition 1.1.13.  This is
an actual theorem application, not merely a name lookup: the result must
elaborate to the literal `Localization.IsLocalizingSequence` predicate for the
raw integrand. -/
example [IsProbabilityMeasure mu]
    (hUsual : SatisfiesUsualConditions filtration mu)
    (eta : LocalProgressiveL2Integrand filtration mu T) :
    Localization.IsLocalizingSequence eta.process filtration mu T
      (fun n omega =>
        (canonicalRawLocalizingTime hUsual eta n omega : WithTop ℝ≥0)) :=
  canonicalRaw_isLocalizingSequence hUsual eta

end AutoSamplingTheory.Tests.CanonicalRawLocalizationL2
