import AutoSamplingTheory.Probability
import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementInterpolation
import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementInterpolationCoupling
import AutoSamplingTheory.TechnicalLemmas.Measure.DisplacementInterpolationCost
import AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs
import AutoSamplingTheory.TechnicalLemmas.Measure.GibbsIntegral
import AutoSamplingTheory.TechnicalLemmas.Measure.GibbsLogConcavity
import AutoSamplingTheory.TechnicalLemmas.Measure.KantorovichDual
import AutoSamplingTheory.TechnicalLemmas.Measure.L2Expectation
import AutoSamplingTheory.TechnicalLemmas.Measure.Product
import AutoSamplingTheory.TechnicalLemmas.Measure.RadonNikodym
import AutoSamplingTheory.TechnicalLemmas.Measure.Transport
import AutoSamplingTheory.TechnicalLemmas.Measure.TransportGluing
import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinSpace
import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinTriangleCore
import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinTriangleMarginals
import AutoSamplingTheory.TechnicalLemmas.Measure.WassersteinTriangle
import AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalKernel
import AutoSamplingTheory.TechnicalLemmas.Probability.LawMap

/-!
# ASTIS-native measure and conditional-law technical lemmas

This file is the reusable memory surface for measure-theoretic lemmas already
formalized while reproducing SALD.  The proofs live in `Probability.lean`; this
module gives agents a stable technical-lemma namespace to search before they
invent new interfaces.

New code should prefer the focused modules under `TechnicalLemmas.Measure` and
`TechnicalLemmas.Probability`. In particular, the transport/Wasserstein spine is
now exposed through displacement interpolation, gluing, Wasserstein-space, and
triangle-core modules rather than hidden behind branch-local imports.
This file remains as a compatibility aggregator.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure

/-- Integrability is invariant under replacing the ambient measure by an equal measure. -/
theorem integrable_of_measure_eq
    {alpha eps : Type*} [MeasurableSpace alpha] [TopologicalSpace eps]
    [ContinuousENorm eps]
    {f : alpha -> eps} {mu nu : MeasureTheory.Measure alpha} (hmunu : mu = nu)
    (hf : MeasureTheory.Integrable f mu) :
    MeasureTheory.Integrable f nu := by
  simpa [hmunu] using hf

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