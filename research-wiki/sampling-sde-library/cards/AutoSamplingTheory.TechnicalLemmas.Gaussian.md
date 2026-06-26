# AutoSamplingTheory.TechnicalLemmas.Gaussian

- File: `AutoSamplingTheory/TechnicalLemmas/Gaussian.lean`
- Layer: compatibility source
- Purpose: source file for ASTIS-owned Gaussian coordinate and moment leaves
- Mathlib-quality status: legacy import surface; prefer TechnicalLemmas.ProbabilityDistributions.Gaussian

## Imports

- `Mathlib.Probability.Distributions.Gaussian.Real`
- `Mathlib.Probability.Distributions.Gaussian.Multivariate`
- `Mathlib.Probability.Independence.Basic`

## Representative Declarations And Exports

- `stdGaussianPi`
- `stdGaussianPi_isProbabilityMeasure`
- `stdGaussianPi_isFiniteMeasure`
- `map_eval_stdGaussianPi`
- `integral_id_gaussianReal_zero`
- `integrable_eval_stdGaussianPi`
- `integrable_const_mul_sq_gaussianReal_zero`
- `integrable_sq_eval_stdGaussianPi`
- `integral_eval_stdGaussianPi`
- `variance_id_gaussianReal_zero_one`
- `nnrealVarianceOneOfGaussianRealUnitLaw`
- `realVarianceOneOfNNRealVarianceOne`

## Curated Formalized Memory Entries

- no curated formalized memory entries for this module

## Agent Usage

Search this card before inventing a nearby technical lemma.  If the needed fact
is generic and missing, create a Mathlib-ready leaf packet rather than hiding
the requirement inside a paper-specific theorem.
