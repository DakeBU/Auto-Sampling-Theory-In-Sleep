# ASTIS Lean Leaf Module Graph

This is the textual ledger behind `docs/module-graph.svg`.  It lists the
ASTIS-owned Lean files that form the reusable SDE/Sampling proof-weapon
library and separates Mathlib-ready technical lemma files from paper
consumers.

The graph is intentionally organized like a Lean module map, following the
style of the public QuantumComputing module graph.  SALD is no longer the
center of this artifact; it is a downstream consumer.  The library center is
the reusable `Probability`, `SDE`, and `TechnicalLemmas` surface.

![ASTIS module graph](../../docs/module-graph.svg)

## Public Module Tree

```text
AutoSamplingTheory
|-- Core.lean                         infrastructure contracts
|-- Probability.lean                  reusable law/KL/FI/conditional-law surface
|-- SDE.lean                          SDE/Fokker--Planck/EM contracts
|-- TechnicalLemmas.lean              parent import surface for reusable lemmas
|-- TechnicalLemmas
|   |-- Analysis.lean                 parent for reusable analysis leaves
|   |-- Analysis
|   |   |-- Calculus.lean             parent for calculus leaves
|   |   `-- Calculus
|   |       `-- Taylor.lean           Mathlib-style Taylor/Hessian leaves
|   |-- Gaussian.lean                 compatibility source for Gaussian leaves
|   |-- Probability.lean              parent for probability technical lemmas
|   |-- Probability
|   |   |-- LawMap.lean               pushforward-law and weak-test rewrites
|   |   `-- ConditionalKernel.lean    condDistrib and conditional-integral leaves
|   |-- ProbabilityDistributions.lean parent for distribution-specific leaves
|   |-- ProbabilityDistributions
|   |   `-- Gaussian.lean             Mathlib-style Gaussian coordinate leaves
|   |-- InformationTheory.lean        parent for KL/DV/entropy leaves
|   |-- InformationTheory
|   |   `-- DonskerVaradhan.lean      one-sided DV and energy bounds
|   |-- FunctionalInequalities.lean   parent for LSI/FI/PI-style leaves
|   |-- FunctionalInequalities
|   |   `-- LogSobolev.lean           LSI-to-KL/FI bookkeeping leaves
|   |-- Measure.lean                  compatibility aggregator for probability leaves
|   |-- Taylor.lean                   compatibility source for Taylor leaves
|   |-- Variational.lean              compatibility aggregator for DV/LSI exports
|   |-- Registry.lean                 compiled memory registry
|   `-- SALDExtracted.lean            compiled paper-extracted bridges; generalize first
|-- SALD.lean                         downstream paper consumer
`-- RMFLD.lean                        downstream exploratory consumer
```

## Compiled Module And Leaf Families

| Module | File | Layer | Purpose | Representative compiled leaves/exports | Curated memory entries | Mathlib-quality status |
| --- | --- | --- | --- | --- | --- | --- |
| `AutoSamplingTheory.Core` | `AutoSamplingTheory/Core.lean` | foundation | source anchors, proof obligations, theorem contracts, DAG records | `ArtifactLanguage`, `ProofStatus`, `SourceKind`, `SourceAnchor`, `ProofObligation`, `TheoremContract`, `ProofDagBlock`, `forbiddenProofPatterns`, ... | 0 | ASTIS infrastructure; not Mathlib material |
| `AutoSamplingTheory.Probability` | `AutoSamplingTheory/Probability.lean` | generic technical core | law-map rewrites, dominated law derivatives, conditional-law bridges, KL/DV/LSI bookkeeping | `lawMapEqOfAEEq`, `lawMapIntegral`, `lawMapIntegralHasDerivAtOfSample`, `lawIntegralHasDerivAtOfMeasureMapEqAndSample`, `lawMapIntegralHasDerivAtOfDominated`, `lawIntegralHasDerivAtOfMeasureMapEqAndDominated`, `lawMapProdEqOfAEEq`, `lawMapProdFst`, ... | 0 | main Mathlib-ready adapter surface after naming/generalization cleanup |
| `AutoSamplingTheory.RMFLD` | `AutoSamplingTheory/RMFLD.lean` | exploratory consumer | exploratory sampling-theory proof targets | `rmfldPaperRoot`, `rmfldSource`, `exploratorySeedLabels`, `rmfldExploratoryContract`, `rmfldProofDag` | 0 | consumer of arsenal |
| `AutoSamplingTheory.SALD` | `AutoSamplingTheory/SALD.lean` | paper consumer | SALD case-study theorem contracts, compiled sublemmas, obligations | `saldPaperRoot`, `saldMainSource`, `saldAppendixSource`, `saldIterationSource`, `saldGronwallSource`, `saldGronwallExponentRewriteSource`, `saldDvVariationSource`, `saldPiSource`, ... | 0 | consumer of arsenal; no longer the center of the public library map |
| `AutoSamplingTheory.SDE` | `AutoSamplingTheory/SDE.lean` | contract layer | Ito diffusion, Fokker--Planck, Euler--Maruyama, discretization contracts | `ItoDiffusionContract`, `FokkerPlanckContract`, `EulerMaruyamaContract`, `DiscretizationErrorContract` | 0 | ASTIS contract surface; future executable SDE theorem layer |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor` | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus/Taylor.lean` | Mathlib-ready technical lemma | Hessian/operator norm bridges, orthonormal-basis units, quadratic normalization | `hessianOpNormOfSourceHessianField`, `iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm`, `quadraticVariationNormalizationOfCoeffDefAndVarianceOne`, `stdOrthonormalBasisUnit` | 3 | preferred Mathlib-style location for Ito/Taylor local-error leaves |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus` | `AutoSamplingTheory/TechnicalLemmas/Analysis/Calculus.lean` | Mathlib-ready technical lemma | parent import surface for calculus leaves used by SDE/Sampling proofs | exports/metadata only | 0 | preferred parent module for Taylor and Hessian leaves |
| `AutoSamplingTheory.TechnicalLemmas.Analysis` | `AutoSamplingTheory/TechnicalLemmas/Analysis.lean` | Mathlib-ready technical lemma | parent import surface for reusable analysis leaves | exports/metadata only | 0 | preferred parent module for calculus, regularity, and future IBP leaves |
| `AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.LogSobolev` | `AutoSamplingTheory/TechnicalLemmas/FunctionalInequalities/LogSobolev.lean` | Mathlib-ready technical lemma | log-Sobolev to KL/FI bookkeeping leaves | `lsiKlFiRnDerivDensityMassOne`, `lsiKlFiRnDerivEntropyIntegral`, `lsiKlFiRnDerivLIntegralMassOne`, `lsiKlFiSqrtDensityEntropyIntegrandScalar`, `lsiKlFiSqrtDensityFisherChainFiniteSumHandoffScalar`, `lsiKlFiSqrtDensityFisherChainFiniteSumScalar`, `lsiKlFiSqrtDensityFisherChainIntegralFiniteSum`, `lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar`, ... | 1 | preferred Mathlib-style location for LSI/FI bookkeeping leaves |
| `AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities` | `AutoSamplingTheory/TechnicalLemmas/FunctionalInequalities.lean` | Mathlib-ready technical lemma | parent import surface for LSI/FI/PI-style technical lemmas | exports/metadata only | 0 | preferred parent module for functional-inequality leaves |
| `AutoSamplingTheory.TechnicalLemmas.Gaussian` | `AutoSamplingTheory/TechnicalLemmas/Gaussian.lean` | compatibility source | source file for ASTIS-owned Gaussian coordinate and moment leaves | `stdGaussianPi`, `stdGaussianPi_isProbabilityMeasure`, `stdGaussianPi_isFiniteMeasure`, `map_eval_stdGaussianPi`, `integral_id_gaussianReal_zero`, `integrable_eval_stdGaussianPi`, `integrable_const_mul_sq_gaussianReal_zero`, `integrable_sq_eval_stdGaussianPi`, ... | 0 | legacy import surface; prefer TechnicalLemmas.ProbabilityDistributions.Gaussian |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.DonskerVaradhan` | `AutoSamplingTheory/TechnicalLemmas/InformationTheory/DonskerVaradhan.lean` | Mathlib-ready technical lemma | Donsker--Varadhan one-sided and scaled-test energy leaves | `dvFiniteLogMgfOfLeAlpha`, `dvVariationalOneSidedConsequenceScalar`, `dvVariationalOneSidedFromSupremumScalar`, `dvVariationalOneSidedOfScaledTest`, `dvVariationalOneSidedOfTiltedRight`, `dvVariationalScaledTestEnergyBound`, `dvVariationalScaledTestEnergyBoundWithCoeff`, `dvVariationalTiltedRightOneSidedConsequence` | 1 | preferred Mathlib-style location for DV/KL energy leaves |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory` | `AutoSamplingTheory/TechnicalLemmas/InformationTheory.lean` | Mathlib-ready technical lemma | parent import surface for KL/DV/entropy technical lemmas | exports/metadata only | 0 | preferred parent module for information-theoretic leaves |
| `AutoSamplingTheory.TechnicalLemmas.Measure` | `AutoSamplingTheory/TechnicalLemmas/Measure.lean` | Mathlib-ready technical lemma | compatibility aggregator for law-map and conditional-kernel lemmas | `integrable_of_measure_eq`, `condDistribAeEqCondExpKernelMap`, `condDistribIntegralAEStronglyMeasurable`, `condDistribIntegralIntegrable`, `condDistribIntegralMapAEStronglyMeasurable`, `condDistribIntegralMapIntegrable`, `condDistribIntegralMapIntegral`, `condDistribIntegralNamedFieldRegularity`, ... | 0 | legacy search surface; prefer TechnicalLemmas.Probability.* for new work |
| `AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalKernel` | `AutoSamplingTheory/TechnicalLemmas/Probability/ConditionalKernel.lean` | Mathlib-ready technical lemma | condDistrib/condExpKernel bridges and conditional-integral regularity leaves | `condDistribAeEqCondExpKernelMap`, `condDistribIntegralAEStronglyMeasurable`, `condDistribIntegralIntegrable`, `condDistribIntegralMapAEStronglyMeasurable`, `condDistribIntegralMapIntegrable`, `condDistribIntegralMapIntegral`, `condDistribIntegralNamedFieldRegularity`, `condDistribIntegralNamedLawAEStronglyMeasurable`, ... | 1 | preferred Mathlib-style location for conditional-kernel leaves |
| `AutoSamplingTheory.TechnicalLemmas.Probability.LawMap` | `AutoSamplingTheory/TechnicalLemmas/Probability/LawMap.lean` | Mathlib-ready technical lemma | pushforward law, weak-test integral, and dominated derivative transport leaves | `lawIntegralHasDerivAtOfMeasureMapEqAndDominated`, `lawIntegralHasDerivAtOfMeasureMapEqAndSample`, `lawMapEqOfAEEq`, `lawMapIntegral`, `lawMapIntegralHasDerivAtOfDominated`, `lawMapIntegralHasDerivAtOfSample`, `lawMapProdEqOfAEEq`, `lawMapProdFst`, ... | 2 | preferred Mathlib-style location for law-map leaves |
| `AutoSamplingTheory.TechnicalLemmas.Probability` | `AutoSamplingTheory/TechnicalLemmas/Probability.lean` | Mathlib-ready technical lemma | parent import surface for probability technical lemmas | exports/metadata only | 0 | preferred parent module for law-map and conditional-kernel leaves |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions/Gaussian.lean` | Mathlib-ready technical lemma | Gaussian coordinate laws, integrability, mean-zero, and variance-one packaging | `integrable_const_mul_sq_gaussianReal_zero`, `integrable_eval_stdGaussianPi`, `integrable_sq_eval_stdGaussianPi`, `integral_eval_stdGaussianPi`, `integral_id_gaussianReal_zero`, `map_eval_stdGaussianPi`, `nnrealVarianceOneOfGaussianRealUnitLaw`, `realVarianceOneOfNNRealVarianceOne`, ... | 6 | preferred Mathlib-style location for Gaussian/Brownian increment leaves |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions` | `AutoSamplingTheory/TechnicalLemmas/ProbabilityDistributions.lean` | Mathlib-ready technical lemma | parent import surface for distribution-specific reusable leaves | exports/metadata only | 0 | preferred parent module for Gaussian and future Gamma/Ornstein--Uhlenbeck distribution leaves |
| `AutoSamplingTheory.TechnicalLemmas.Registry` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean` | memory index | compiled lemma-memory metadata and external port queue | `LemmaMemoryStatus`, `LemmaMemoryEntry`, `sltSourceAnchor`, `gaussianMemory`, `taylorMemory`, `measureMemory`, `variationalMemory`, `saldExtractedMemory`, ... | 0 | agent retrieval registry, not theorem content |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean` | paper-extracted technical lemma | compiled SALD-derived Brownian/Ito/Gronwall bridges exposed for search | `discreteForwardKlAccumulatedErrorCollectionScalar`, `discreteForwardKlAlphaComplexityCollectionScalar`, `discreteForwardKlDeltaAccumulationScalar`, `discreteForwardKlEmEndpointLawPairHandoff`, `discreteForwardKlEmInterpolationLeftEndpointLawHandoff`, `discreteForwardKlEmInterpolationLeftEndpointVector`, `discreteForwardKlEmInterpolationRightEndpointLawHandoff`, `discreteForwardKlEmInterpolationRightEndpointVector`, ... | 7 | compiled and useful; must be generalized before Mathlib submission |
| `AutoSamplingTheory.TechnicalLemmas.Taylor` | `AutoSamplingTheory/TechnicalLemmas/Taylor.lean` | compatibility source | source file for ASTIS-owned Taylor/Hessian and quadratic-normalization leaves | `hessianOpNormOfSourceHessianField`, `iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm`, `stdOrthonormalBasisUnit`, `quadraticVariationNormalizationOfCoeffDefAndVarianceOne` | 0 | legacy import surface; prefer TechnicalLemmas.Analysis.Calculus.Taylor |
| `AutoSamplingTheory.TechnicalLemmas.Variational` | `AutoSamplingTheory/TechnicalLemmas/Variational.lean` | Mathlib-ready technical lemma | compatibility aggregator for DV and LSI/FI leaves | `dvFiniteLogMgfOfLeAlpha`, `dvVariationalOneSidedConsequenceScalar`, `dvVariationalOneSidedFromSupremumScalar`, `dvVariationalOneSidedOfScaledTest`, `dvVariationalOneSidedOfTiltedRight`, `dvVariationalScaledTestEnergyBound`, `dvVariationalScaledTestEnergyBoundWithCoeff`, `dvVariationalTiltedRightOneSidedConsequence`, ... | 0 | legacy search surface; prefer InformationTheory and FunctionalInequalities modules |
| `AutoSamplingTheory.TechnicalLemmas` | `AutoSamplingTheory/TechnicalLemmas.lean` | Mathlib-ready technical lemma | parent import surface for reusable ASTIS-owned technical lemmas | exports/metadata only | 0 | public import surface for the Mathlib-ready arsenal; excludes SALDExtracted quarantine |

## Mathlib-Ready Callable Arsenal

The table below is generated from
`AutoSamplingTheory/TechnicalLemmas/Registry.lean`.  These are the currently
compiled local entries that agents may retrieve as proven technical lemma
memory for future Mathlib-style cleanup.  External Lean projects may motivate
a row, but the callable proof is the ASTIS-owned declaration listed here.

| Module | Memory key | Local declaration | Upstream or source orientation |
| --- | --- | --- | --- |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor` | `taylor.hessian.source-field-to-opnorm` | `hessianOpNormOfSourceHessianField` | SLT/GaussianPoincare/TaylorBound.lean |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor` | `taylor.fderiv-hessian-to-iterated` | `iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm` | SLT/GaussianPoincare/TaylorBound.lean |
| `AutoSamplingTheory.TechnicalLemmas.Analysis.Calculus.Taylor` | `brownian.quadratic-variation-normalization` | `quadraticVariationNormalizationOfCoeffDefAndVarianceOne` | ASTIS/SALD cycles 174-176 |
| `AutoSamplingTheory.TechnicalLemmas.FunctionalInequalities.LogSobolev` | `lsi.sqrt-density.fisher-chain` | `lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar` | Mathlib/SLT-inspired entropy and LSI proof shape |
| `AutoSamplingTheory.TechnicalLemmas.InformationTheory.DonskerVaradhan` | `dv.scaled-test.energy-bound` | `dvVariationalScaledTestEnergyBound` | Boucheron-style cited result / future SLT entropy-duality port |
| `AutoSamplingTheory.TechnicalLemmas.Probability.ConditionalKernel` | `measure.conditional-distribution.integral` | `condDistribIntegralNamedLawIntegral` | Mathlib.Probability.Kernel.CondDistrib and Condexp |
| `AutoSamplingTheory.TechnicalLemmas.Probability.LawMap` | `measure.law-map.integral` | `lawMapIntegral` | Mathlib measure/integration APIs |
| `AutoSamplingTheory.TechnicalLemmas.Probability.LawMap` | `measure.law-map.dominated-derivative` | `lawMapIntegralHasDerivAtOfDominated` | Mathlib.Analysis.Calculus.ParametricIntegral |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.coordinate-law` | `map_eval_stdGaussianPi` | SLT/GaussianMeasure.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.coordinate-integrable` | `integrable_eval_stdGaussianPi` | SLT/GaussianMeasure.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.coordinate-square-integrable` | `integrable_sq_eval_stdGaussianPi` | SLT/GaussianMeasure.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.product.coordinate-mean-zero` | `integral_eval_stdGaussianPi` | SLT/GaussianMeasure.lean |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.unit-variance.nnreal` | `nnrealVarianceOneOfGaussianRealUnitLaw` | Mathlib.Probability.Distributions.Gaussian.Real |
| `AutoSamplingTheory.TechnicalLemmas.ProbabilityDistributions.Gaussian` | `gaussian.quadratic-bound-integrable` | `integrable_const_mul_sq_gaussianReal_zero` | Mathlib.Probability.Distributions.Gaussian.Real |

## Paper-Extracted Quarantine

These declarations also compile, but they are not counted as the Mathlib-ready
arsenal until the SALD-specific names and assumptions are generalized.  The
main graph places `SALDExtracted.lean` outside the reusable technical-lemma
folder for this reason.

| Module | Memory key | Local declaration | Source orientation |
| --- | --- | --- | --- |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.gronwall.scalar-rewrites` | `gronwallExpProductRewriteScalar` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.em-endpoint-law-handoff` | `discreteForwardKlEmEndpointLawPairHandoff` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.brownian-normalization-bridges` | `selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.remainder-meas-gaussian-law` | `selectedWeakTestRemainderMeasOfStdGaussianVectorLaw` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.remainder-bound-gaussian-law` | `selectedWeakTestRemainderBoundOfStdGaussianVectorLaw` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.remainder-bound-integrable-gaussian-law` | `selectedWeakTestRemainderBoundIntegrableOfStdGaussianVectorLaw` | AutoSamplingTheory/SALD.lean |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `sald.normalized-remainder-bound-int-quadratic` | `selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound` | AutoSamplingTheory/SALD.lean |

## Current Library Boundary

| Layer | Rule |
|---|---|
| Mathlib-ready technical surface | `Probability.lean`, `TechnicalLemmas/Probability/*`, `TechnicalLemmas/ProbabilityDistributions/Gaussian.lean`, `TechnicalLemmas/Analysis/Calculus/Taylor.lean`, `TechnicalLemmas/InformationTheory/*`, and `TechnicalLemmas/FunctionalInequalities/*` are the first upstream-quality targets after final naming/API cleanup. |
| Compatibility surfaces | `TechnicalLemmas/Gaussian.lean`, `TechnicalLemmas/Taylor.lean`, `TechnicalLemmas/Measure.lean`, and `TechnicalLemmas/Variational.lean` remain stable imports but new tasks should prefer the family-specific modules. |
| ASTIS contract surface | `SDE.lean` states the domain contracts that future executable SDE lemmas should discharge. |
| Paper-extracted compiled leaves | `TechnicalLemmas/SALDExtracted.lean` exposes useful local theorems, but they remain SALD-derived until generalized. |
| Consumers | `SALD.lean` and `RMFLD.lean` consume the arsenal; they are not the public foundation. |

## External Reference Memory

External Lean code and textbooks are preserved as reference cards under
`research-wiki/external-lean-libraries/`.  They are port sources and proof-style
memory, not local proof certificates.

| Reference | Card |
|---|---|
| Mathlib | `research-wiki/external-lean-libraries/mathlib.md` |
| `YuanheZ/lean-stat-learning-theory` | `research-wiki/external-lean-libraries/lean-stat-learning-theory.md` |
| `auto-res/lean-rademacher` | `research-wiki/external-lean-libraries/lean-rademacher.md` |
| Chewisinho stochastic-process notes | `research-wiki/external-lean-libraries/chewisinho-stochastic-processes.md` |

## Agent Rule

Upper agents use this graph to choose the likely proof family.  Middle agents
turn the selected family into one or two Mathlib-ready leaves and must search
Mathlib plus this arsenal before assigning generic infrastructure.  Lower Lean
workers prove one stable leaf at a time.  Persistent failure means the
statement probably needs a hidden regularity contract, a missing assumption, or
a counterexample audit.
