# SALD Remaining Leaves To Technical Lemma Memory

This map tells ASTIS agents which compiled local technical lemmas to try before
inventing a new proof interface.  External SLT files are only port references.

## Active Brownian/Ito Backend

| SALD leaf | First local ASTIS lemmas to search | If missing |
|---|---|---|
| `hNormalizedVectorLaw`, `hCoordinateLawDef`, `hNormalizedCoordinateLaw` | `TechnicalLemmas.Gaussian.map_eval_stdGaussianPi`; SALD local `selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw` | port only the missing coordinate-law lemma into `TechnicalLemmas/Gaussian.lean` |
| `hVarianceDef`, `hNormalizedVarianceDef`, `hVarianceOne` | `TechnicalLemmas.Gaussian.nnrealVarianceOneOfGaussianRealUnitLaw`; `TechnicalLemmas.Gaussian.realVarianceOneOfNNRealVarianceOne` | add a local packaging lemma; do not cite SLT as proved |
| `hSourceHasHessian`, `hSourceHessianBound`, `hHessianOpNorm` | `TechnicalLemmas.Taylor.hessianOpNormOfSourceHessianField`; `TechnicalLemmas.Taylor.iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm` | if the source fields are absent, record a source-contract gap |
| `hQuadraticCoeffDef`, `hFrozenScalarBrownianItoQuadraticVariationNormalization` | `TechnicalLemmas.Taylor.quadraticVariationNormalizationOfCoeffDefAndVarianceOne`; SALD local coefficient bridges | add a small local algebra bridge only if it removes an existing supplied hypothesis |
| `hBrownianCoordinateGeneratorTaylorIntegralDef`, `hRemainderGeneratorLimitDef` | current local SALD DCT/Taylor bridges plus future ports in `SLT_port_queue.jsonl` | port narrow Taylor/remainder lemmas into `TechnicalLemmas/Taylor.lean` |
| EM weak-test law derivative / `hatRhoS` law integrals | `TechnicalLemmas.Measure.lawMapIntegral`; `TechnicalLemmas.Measure.lawMapIntegralHasDerivAtOfDominated` | add only a missing named-law or domination adapter |
| conditional frozen drift / named conditional law | `TechnicalLemmas.Measure.condDistribIntegralNamedLawIntegral`; `TechnicalLemmas.Measure.condDistribIntegralNamedFieldRegularity` | keep kernel/measurability assumptions explicit |
| DV energy conversion | `TechnicalLemmas.Variational.dvVariationalScaledTestEnergyBound` | full DV remains a cited-result obligation until locally ported |
| LSI/FI density bookkeeping | `TechnicalLemmas.Variational.lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar` | full LSI remains a cited-result obligation until locally ported |

## Reviewer Rule

Reject any packet that directly relies on the external SLT clone.  Accept only:

- a compiled ASTIS declaration under `AutoSamplingTheory/TechnicalLemmas` or
  another ASTIS module;
- a precise proof obligation naming the source theorem and the missing local
  port; or
- a source-contract gap when the original SALD paper does not provide the
  needed analytic assumption.
