import AutoSamplingTheory.TechnicalLemmas.Gaussian

/-!
# Gaussian distribution technical lemmas

Preferred Mathlib-style import path for ASTIS-owned Gaussian leaves:
coordinate laws, moment integrability, centered means, and variance-one
normalization.

The original `TechnicalLemmas.Gaussian` module remains as a compatibility
surface.
-/

namespace AutoSamplingTheory
namespace TechnicalLemmas
namespace ProbabilityDistributions
namespace Gaussian

export AutoSamplingTheory.TechnicalLemmas.Gaussian (
  stdGaussianPi
  stdGaussianPi_isProbabilityMeasure
  stdGaussianPi_isFiniteMeasure
  map_eval_stdGaussianPi
  integral_id_gaussianReal_zero
  integrable_eval_stdGaussianPi
  integrable_const_mul_sq_gaussianReal_zero
  integrable_sq_eval_stdGaussianPi
  integral_eval_stdGaussianPi
  variance_id_gaussianReal_zero_one
  nnrealVarianceOneOfGaussianRealUnitLaw
  realVarianceOneOfNNRealVarianceOne
)

end Gaussian
end ProbabilityDistributions
end TechnicalLemmas
end AutoSamplingTheory

