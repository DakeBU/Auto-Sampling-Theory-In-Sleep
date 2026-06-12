import AutoSamplingTheory.Probability

/-!
# ASTIS-native measure and conditional-law technical lemmas

This file is the reusable memory surface for measure-theoretic lemmas already
formalized while reproducing SALD.  The proofs live in `Probability.lean`; this
module gives agents a stable technical-lemma namespace to search before they
invent new interfaces.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure

export AutoSamplingTheory (
  lawMapEqOfAEEq
  lawMapIntegral
  lawMapIntegralHasDerivAtOfSample
  lawIntegralHasDerivAtOfMeasureMapEqAndSample
  lawMapIntegralHasDerivAtOfDominated
  lawIntegralHasDerivAtOfMeasureMapEqAndDominated
  lawMapProdEqOfAEEq
  lawMapProdFst
  lawMapProdSnd
  lawMapProdSwap
  condDistribAeEqCondExpKernelMap
  condDistribIntegralSampleAeEqOfCondExpKernelMap
  condDistribIntegralAEStronglyMeasurable
  condDistribIntegralIntegrable
  condDistribIntegralMapAEStronglyMeasurable
  condDistribIntegralMapIntegrable
  condDistribIntegralMapIntegral
  condDistribIntegralNamedLawIntegral
  condDistribIntegralNamedLawAEStronglyMeasurable
  condDistribIntegralNamedLawIntegrable
  condDistribIntegralNamedFieldRegularity
)

end Measure
end TechnicalLemmas
end AutoSamplingTheory

