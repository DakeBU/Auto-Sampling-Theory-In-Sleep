import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalRawLocalizationL2

namespace AutoSamplingTheory.Tests.CanonicalRawLocalizationL2

open MeasureTheory

namespace SP := AutoSamplingTheory.TechnicalLemmas.StochasticProcesses

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : MeasureTheory.Filtration NNReal m}
  {mu : Measure Omega} {T : NNReal}

#check SP.CanonicalRawLocalizationL2.rawStoppedTimeLintegral_le
#check SP.CanonicalRawLocalizationL2.rawStoppedProductEnergy_lt_top
#check SP.CanonicalRawLocalizationL2.canonicalRaw_isLocalizingSequence

/-- Focused source-contract smoke test for Chewi Proposition 1.1.13.

Unlike a bare `#check`, this applies the production theorem to the literal
localizing-sequence predicate.  All ambient stochastic-process types are kept
fully qualified here so this test also documents the exact interface used by
the formalization. -/
example [IsProbabilityMeasure mu]
    (hUsual : SP.ProgressiveL2.SatisfiesUsualConditions filtration mu)
    (eta : SP.LocalProgressiveL2.LocalProgressiveL2Integrand filtration mu T) :
    SP.Localization.IsLocalizingSequence eta.process filtration mu T
      (fun n omega =>
        (SP.CanonicalRawLocalization.canonicalRawLocalizingTime hUsual eta n omega : WithTop NNReal)) :=
  SP.CanonicalRawLocalizationL2.canonicalRaw_isLocalizingSequence hUsual eta

end AutoSamplingTheory.Tests.CanonicalRawLocalizationL2
