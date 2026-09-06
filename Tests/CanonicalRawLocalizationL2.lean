import AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalRawLocalizationL2

namespace AutoSamplingTheory.Tests.CanonicalRawLocalizationL2

open MeasureTheory

variable {Omega : Type*} {m : MeasurableSpace Omega}
  {filtration : MeasureTheory.Filtration NNReal m}
  {mu : Measure Omega} {T : NNReal}

#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalRawLocalizationL2.rawStoppedTimeLintegral_le
#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalRawLocalizationL2.rawStoppedProductEnergy_lt_top
#check AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalRawLocalizationL2.canonicalRaw_isLocalizingSequence

/-- Focused source-contract smoke test for Chewi Proposition 1.1.13.

Unlike a bare `#check`, this applies the production theorem to the literal
localizing-sequence predicate. All ambient stochastic-process types are kept
fully qualified here so this test also documents the exact interface used by
the formalization. -/
example [IsProbabilityMeasure mu]
    (hUsual :
      AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.ProgressiveL2.SatisfiesUsualConditions
        filtration mu)
    (eta :
      AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.LocalProgressiveL2.LocalProgressiveL2Integrand
        filtration mu T) :
    AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.Localization.IsLocalizingSequence
      eta.process filtration mu T
      (fun n omega =>
        (AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalRawLocalization.canonicalRawLocalizingTime
          hUsual eta n omega : WithTop NNReal)) :=
  AutoSamplingTheory.TechnicalLemmas.StochasticProcesses.CanonicalRawLocalizationL2.canonicalRaw_isLocalizingSequence
    hUsual eta

end AutoSamplingTheory.Tests.CanonicalRawLocalizationL2
