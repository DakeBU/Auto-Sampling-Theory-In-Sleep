# AutoSamplingTheory.TechnicalLemmas.Gaussian

- File: `AutoSamplingTheory/TechnicalLemmas/Gaussian.lean`
- Layer: Mathlib-ready technical lemma
- Purpose: product Gaussian coordinate law, integrability, mean zero, variance-one packaging
- Mathlib-quality status: best current upstream candidates after namespace/name cleanup

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

## Agent Usage

Search this card before inventing a nearby technical lemma.  If the needed fact
is generic and missing, create a Mathlib-ready leaf packet rather than hiding
the requirement inside a paper-specific theorem.
