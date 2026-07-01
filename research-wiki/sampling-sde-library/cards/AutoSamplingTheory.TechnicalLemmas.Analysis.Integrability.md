# AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability

- File: `AutoSamplingTheory/TechnicalLemmas/Analysis/Integrability.lean`
- Layer: Mathlib-ready technical lemma
- Purpose: ofReal lintegral/Integrable bridge, finite-dimensional Gaussian quadratic-tail integrability, exact quadratic normalizers, and quadratic lower-bound Gibbs normalization leaves
- Mathlib-quality status: preferred Mathlib-style location for Lebesgue tail and coercive-envelope leaves

## Imports

- `AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs`
- `Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform`

## Representative Declarations And Exports

- `lintegral_ofReal_ne_top_of_integrable_nonneg`
- `integrable_exp_neg_mul_norm_sq`
- `integrable_exp_neg_add_mul_norm_sq`
- `lintegral_exp_neg_add_mul_norm_sq_ne_top`
- `lintegral_exp_neg_mul_norm_sq_eq`
- `lintegral_exp_neg_add_mul_norm_sq_eq`
- `isProbabilityMeasure_withDensity_exp_neg_add_mul_norm_sq`
- `lintegral_gibbsDensityENNReal_ne_top_of_ae_quadratic_lower_bound`
- `isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_quadratic_lower_bound`

## Curated Formalized Memory Entries

- `analysis.integrability.of-real-lintegral-finite` -> `lintegral_ofReal_ne_top_of_integrable_nonneg` (Mathlib.MeasureTheory.Function.L1Space.Integrable)
- `analysis.integrability.gaussian-quadratic-tail` -> `integrable_exp_neg_mul_norm_sq` (Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform)
- `analysis.integrability.shifted-gaussian-quadratic-tail` -> `integrable_exp_neg_add_mul_norm_sq` (AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability)
- `analysis.integrability.gaussian-quadratic-tail-normalizer` -> `lintegral_exp_neg_mul_norm_sq_eq` (Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform; Mathlib.MeasureTheory.Integral.Bochner.Basic)
- `analysis.integrability.shifted-gaussian-quadratic-tail-normalizer` -> `lintegral_exp_neg_add_mul_norm_sq_eq` (AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability)
- `measure.gibbs-density.explicit-quadratic-normalized-probability` -> `isProbabilityMeasure_withDensity_exp_neg_add_mul_norm_sq` (AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability; AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs)
- `measure.gibbs-density.integral-finite-quadratic-lower-bound` -> `lintegral_gibbsDensityENNReal_ne_top_of_ae_quadratic_lower_bound` (AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability; AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs)
- `measure.gibbs-density.normalized-probability-quadratic-lower-bound` -> `isProbabilityMeasure_withDensity_normalized_gibbs_of_ae_quadratic_lower_bound` (AutoSamplingTheory.TechnicalLemmas.Analysis.Integrability; AutoSamplingTheory.TechnicalLemmas.Measure.Gibbs)

## Agent Usage

Search this card before inventing a nearby technical lemma.  If the needed fact
is generic and missing, create a Mathlib-ready leaf packet rather than hiding
the requirement inside a paper-specific theorem.
