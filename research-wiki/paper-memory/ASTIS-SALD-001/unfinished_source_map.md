# ASTIS-SALD-001 Paper Memory: Unfinished Source Map

Generated: `2026-06-27 02:49:22`

Cycle considered: `207`.

This file is task-local paper contribution memory.  It records the VA-SALD
paper-specific source lines and Lean proof boundaries that remain unfinished.
Reusable background facts belong in canonical `research-wiki/technical-lemmas/`
and ASTIS-owned Lean modules under `AutoSamplingTheory/TechnicalLemmas/`.
The legacy mirror is `research-wiki/paper-memory/ASTIS-SALD-001/`.

## Unfinished Source-Line Map

| Boundary id | Type | Source lines | Lean boundary | Status | Next action |
|---|---|---|---|---|---|
| `discrete-forward-kl-main` | paper-contribution | `main_body.tex:301-326` | `SALD.discreteForwardKlProofDag / thm:forward-KL-discrete contract` | source-indexed; analytic backend open | Keep theorem contract fixed; discharge the EM weak-FP and Brownian/Ito generator leaves below. |
| `unified-forward-kl-main` | paper-contribution | `main_body.tex:372-392` | `SALD.unifiedForwardKlContract` | source-indexed; depends on general theorem closure | Do not mutate the statement; backfill shared KL/FI/LSI and moving-target interfaces. |
| `frozen-em-interpolation` | paper-contribution | `appendix.tex:983-996` | `hBrownianCoordinateGeneratorTaylorIntegralDef; hRemainderGeneratorLimitDef` | active unfinished leaf | Prove one coordinate generator equality or narrow it to a single Taylor/Ito source obligation. |
| `conditional-drift-definition` | paper-contribution | `appendix.tex:1368-1377` | `conditional drift representative and law integral fields` | source-line mapped; representative/measurability leaves open | Close or strictly narrow conditional expectation representative and integrability hypotheses. |
| `weak-fokker-planck-line` | paper-contribution | `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp` | core unfinished analytic backend | Prove/narrow generator-to-law weak action with the selected test function and Brownian term. |
| `kl-derivative-start` | paper-contribution | `appendix.tex:1358-1365` | `KL derivative handoff for hat rho_s versus pi_s` | source-indexed; depends on weak-FP and admissible log-ratio test | Connect the weak-FP identity to the KL derivative only after the law-level backend is stable. |
| `divergence-fi-ibp` | paper-contribution | `appendix.tex:1422-1434` | `divergence rewrite, FI term, and no-boundary IBP` | source-indexed; Green/trace and integration-by-parts leaves open | Use local measure/variational technical lemmas first; queue missing Green/trace facts explicitly. |
| `selected-source-hessian-fields` | paper-contribution | `appendix.tex:982-995` | `hSourceHasHessian; hSourceHessianBound` | source-contract gap; do not fake via wrapper assumptions | Either locate the exact source regularity assumption or leave a precise ProofObligation. |
| `taylor-dct-technical-backend` | technical-lemma | `appendix.tex:982-995` | `hRemainderMeas; hRemainderBound; hRemainderBoundInt` | technical lemma port/proof queue | Port or prove ASTIS-owned local lemmas before calling them from SALD proof code. |

## Line Range Audit

Reviewer must reject a cycle's "complete" claim if any active paper
contribution leaf is missing concrete source lines.

- none

## Next Smallest Leaf

- Boundary: `frozen-em-interpolation`
- Source: `appendix.tex:983-996`
- Lean boundary: `hBrownianCoordinateGeneratorTaylorIntegralDef; hRemainderGeneratorLimitDef`
- Next action: Prove one coordinate generator equality or narrow it to a single Taylor/Ito source obligation.

## Technical Lemma Status Snapshot

## Formalized Local Technical Lemmas

| Local declaration | Tags | SALD use | File |
|---|---|---|---|
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.map_eval_stdGaussianPi` | gaussian, coordinate-law, brownian-increment | normalized scalar coordinate law in the Brownian/Ito EM backend | `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions/Gaussian.lean` |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integrable_eval_stdGaussianPi` | gaussian, integrability, coordinate, brownian-increment | Brownian/Ito coordinate integrability for scalar Taylor moment and generator leaves | `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions/Gaussian.lean` |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integrable_sq_eval_stdGaussianPi` | gaussian, integrability, quadratic-moment, brownian-increment | Brownian/Ito coordinate square integrability for polynomial moment leaves | `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions/Gaussian.lean` |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integral_eval_stdGaussianPi` | gaussian, mean, coordinate, brownian-increment | coordinate mean-zero rewrite for Brownian/Ito scalar Taylor moment leaves | `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions/Gaussian.lean` |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integral_id_gaussianReal_zero` | gaussian, mean, brownian-increment | centered scalar Gaussian increment bookkeeping | `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions/Gaussian.lean` |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.nnrealVarianceOneOfGaussianRealUnitLaw` | gaussian, variance, NNReal | turn scalar Gaussian law and variance-field definition into normalized variance one | `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions/Gaussian.lean` |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian.integrable_const_mul_sq_gaussianReal_zero` | gaussian, integrability, quadratic-bound, brownian-increment | supply normalized-remainder bound integrability once the source identifies remainderBound as C * z^2 | `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions/Gaussian.lean` |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor.hessianOpNormOfSourceHessianField` | taylor, hessian, source-contract | convert source-supplied selected-test Hessian representative into downstream Hessian operator-norm bound | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Taylor.lean` |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor.iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm` | taylor, iteratedFDeriv, hessian | feed selected-line Taylor bounds from a Hessian operator-norm field | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Taylor.lean` |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor.quadraticVariationNormalizationOfCoeffDefAndVarianceOne` | brownian, ito, quadratic-variation, normalization | assemble quadratic coefficient and variance-one fields without re-assuming the downstream normalization | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Taylor.lean` |
| `AutoSamplingTheory.TechnicalLemmas.Measure.lawMapIntegral` | measure-map, law, integral | rewrite weak-test integrals under endpoint laws and EM interpolation laws | `AutoSamplingTheory/TechnicalLemmas/Measure.lean` |
| `AutoSamplingTheory.TechnicalLemmas.Measure.lawMapIntegralHasDerivAtOfDominated` | parametric-integral, dominated-convergence, weak-test | transport dominated sample-space derivatives to law-level weak-test derivatives | `AutoSamplingTheory/TechnicalLemmas/Measure.lean` |
| `AutoSamplingTheory.TechnicalLemmas.Measure.condDistribIntegralNamedLawIntegral` | conditional-law, kernel, Bochner-integral | conditional frozen drift and named-law conditional integral interface | `AutoSamplingTheory/TechnicalLemmas/Measure.lean` |
| `AutoSamplingTheory.TechnicalLemmas.Variational.dvVariationalScaledTestEnergyBound` | DV, KL, energy | convert finite log-mgf and KL hypotheses into residual energy bounds | `AutoSamplingTheory/TechnicalLemmas/Variational.lean` |
| `AutoSamplingTheory.TechnicalLemmas.Variational.lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar` | LSI, FI, density | bookkeeping for LSI-to-KL/FI handoff after density assumptions are supplied | `AutoSamplingTheory/TechnicalLemmas/Variational.lean` |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.gronwallExpProductRewriteScalar` | Gronwall, scalar-algebra, SALD-extracted | forward-KL and discrete forward-KL Gronwall display algebra | `AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean` |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.discreteForwardKlEmEndpointLawPairHandoff` | Euler-Maruyama, endpoint-law, SALD-extracted | endpoint-law pair handoff for discrete SALD/VA-SALD proofs | `AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean` |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw` | Brownian, Ito, Gaussian, SALD-extracted | active Brownian/Ito scalar generator backend and coordinate variance leaves | `AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean` |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw` | Brownian, Ito, Gaussian, measurability, SALD-extracted | discharge hRemainderMeas in the active Brownian/Ito Taylor moment backend | `AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean` |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound` | Brownian, Ito, Gaussian, integrability, quadratic-bound, SALD-extracted | narrow hNormalizedRemainderBoundInt to hNormalizedRemainderBoundDef plus normalized-coordinate-law integrability | `AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean` |

## Technical Lemma Port Queue

| Source / upstream | Declarations | ASTIS target | Status |
|---|---|---|---|
| `SLT/GaussianMeasure.lean` | `integrable_eval_stdGaussianPi`, `integrable_sq_eval_stdGaussianPi`, `integral_eval_stdGaussianPi` | Brownian/Ito coordinate integrability and polynomial moment leaves | formalized-local |
| `SLT/GaussianPoincare/TaylorBound.lean` | `taylor_order_one`, `taylor_mean_value_bound`, `taylor_diff_abs_bound`, `deriv2_bounded_of_compactlySupported`, `integrable_deriv_sq` | selected scalar Taylor integral/remainder and bounded-Hessian leaves | port-candidate |
| `SLT/GaussianPoincare/Limit.lean` | `tendsto_integral_deriv_sq`, `tendsto_entropy_f_sq`, `gaussianPoincare` | Taylor remainder limits and Gaussian Poincare backend | future-port |
| `SLT/GaussianLSI/DualityEntropy.lean` | `entropy_duality`, `entropy_ge_integral_mul`, `expMeasure_isProbabilityMeasure`, `integral_expMeasure` | DV/KL variational formula backend | future-port |
| `SLT/GaussianLSI/TensorizedGLSI.lean` | `gaussian_logSobolev_W12_pi`, `condEntExceptCoord_sq_eq_slice_entropy`, `condEnt_sq_le_partial_deriv_sq` | product Gaussian LSI backend | future-port |

