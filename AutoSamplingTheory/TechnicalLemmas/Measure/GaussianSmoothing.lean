import AutoSamplingTheory.TechnicalLemmas.Measure.CommonNoiseContraction
import Mathlib.Probability.Distributions.Gaussian.Multivariate

/-!
# Gaussian smoothing as common additive noise

The transport part of heat-flow contraction does not depend on the PDE.  This
module packages a centered Gaussian noise of arbitrary scale `sigma` and then
specializes the general common-noise contraction theorem.

The scale remains an explicit parameter.  Identifying Chewi's heat time `t`
with a particular choice such as `sigma = sqrt t` is a separate source-facing
normalization theorem.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace Measure
namespace GaussianSmoothing

open MeasureTheory ProbabilityTheory
open scoped ENNReal

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
  [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E]
  [SecondCountableTopology E]

/-- Centered isotropic Gaussian noise obtained by scaling the standard Gaussian
by `sigma`.  The definition is valid for every real scale; later heat-flow
interfaces may restrict to nonnegative scales. -/
noncomputable def scaledStdGaussian (sigma : ℝ) : Measure E :=
  Measure.map (fun z : E => sigma • z) (stdGaussian E)

instance scaledStdGaussian_isProbabilityMeasure (sigma : ℝ) :
    IsProbabilityMeasure (scaledStdGaussian (E := E) sigma) := by
  unfold scaledStdGaussian
  exact Measure.isProbabilityMeasure_map (by fun_prop : AEMeasurable (fun z : E => sigma • z) (stdGaussian E))

/-- Gaussian smoothing of a law by independent centered Gaussian noise of
scale `sigma`. -/
noncomputable def gaussianSmoothing (mu : Measure E) (sigma : ℝ) : Measure E :=
  CommonNoiseContraction.addNoise mu (scaledStdGaussian (E := E) sigma)

/-- Gaussian smoothing is `W₂`-contractive because it adds the same independent
noise law to both endpoint measures. -/
theorem wassersteinDistance_gaussianSmoothing_le
    (mu nu : Measure E) [IsProbabilityMeasure mu] [IsProbabilityMeasure nu]
    (sigma : ℝ) :
    WassersteinSpace.wassersteinDistance
        (gaussianSmoothing mu sigma) (gaussianSmoothing nu sigma) ≤
      WassersteinSpace.wassersteinDistance mu nu := by
  exact CommonNoiseContraction.wassersteinDistance_addNoise_le
    mu nu (scaledStdGaussian (E := E) sigma)

end

end GaussianSmoothing
end Measure
end TechnicalLemmas
end AutoSamplingTheory
