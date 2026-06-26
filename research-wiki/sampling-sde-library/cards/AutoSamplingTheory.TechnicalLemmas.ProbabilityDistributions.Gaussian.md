# AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian

- File: `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions/Gaussian.lean`
- Layer: Mathlib-ready technical lemma
- Purpose: Gaussian coordinate laws, integrability, mean-zero, and variance-one packaging
- Mathlib-quality status: preferred Mathlib-style location for Gaussian/Brownian increment leaves

## Imports

- `AutoSamplingTheory.TechnicalLemmas.Gaussian`

## Representative Declarations And Exports

- `integrable_const_mul_sq_gaussianReal_zero`
- `integrable_eval_stdGaussianPi`
- `integrable_sq_eval_stdGaussianPi`
- `integral_eval_stdGaussianPi`
- `integral_id_gaussianReal_zero`
- `map_eval_stdGaussianPi`
- `nnrealVarianceOneOfGaussianRealUnitLaw`
- `realVarianceOneOfNNRealVarianceOne`
- `stdGaussianPi`
- `stdGaussianPi_isFiniteMeasure`
- `stdGaussianPi_isProbabilityMeasure`
- `variance_id_gaussianReal_zero_one`

## Curated Formalized Memory Entries

- `gaussian.product.coordinate-law` -> `map_eval_stdGaussianPi` (SLT/GaussianMeasure.lean)
- `gaussian.product.coordinate-integrable` -> `integrable_eval_stdGaussianPi` (SLT/GaussianMeasure.lean)
- `gaussian.product.coordinate-square-integrable` -> `integrable_sq_eval_stdGaussianPi` (SLT/GaussianMeasure.lean)
- `gaussian.product.coordinate-mean-zero` -> `integral_eval_stdGaussianPi` (SLT/GaussianMeasure.lean)
- `gaussian.unit-variance.nnreal` -> `nnrealVarianceOneOfGaussianRealUnitLaw` (Mathlib.Probability.Distributions.Gaussian.Real)
- `gaussian.quadratic-bound-integrable` -> `integrable_const_mul_sq_gaussianReal_zero` (Mathlib.Probability.Distributions.Gaussian.Real)

## Agent Usage

Search this card before inventing a nearby technical lemma.  If the needed fact
is generic and missing, create a Mathlib-ready leaf packet rather than hiding
the requirement inside a paper-specific theorem.
