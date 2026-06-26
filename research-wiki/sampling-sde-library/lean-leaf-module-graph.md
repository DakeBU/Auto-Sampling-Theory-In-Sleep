# ASTIS Lean Leaf Module Graph

This is the textual ledger behind `docs/module-graph.svg`.  It lists the
ASTIS-owned Lean files that form the reusable SDE/Sampling proof-weapon
library and separates Mathlib-ready technical lemmas from paper consumers.

The graph is intentionally organized like a library map, not like a run log.
SALD is now only a consumer/case study.  The library center is the reusable
`Probability`, `SDE`, and `TechnicalLemmas` surface.

![ASTIS module graph](../../docs/module-graph.svg)

## Public Module Tree

```text
AutoSamplingTheory
|-- Core.lean
|-- Probability.lean
|-- SDE.lean
|-- TechnicalLemmas
|   |-- Gaussian.lean
|   |-- Measure.lean
|   |-- Taylor.lean
|   |-- Variational.lean
|   |-- Registry.lean
|   `-- SALDExtracted.lean
|-- Automation.lean
|-- Literature.lean
|-- OpenProblems.lean
|-- SALD.lean
`-- RMFLD.lean
```

## Compiled Module And Leaf Families

| Module | File | Layer | Purpose | Representative compiled leaves/exports | Mathlib-quality status |
| --- | --- | --- | --- | --- | --- |
| `AutoSamplingTheory.Automation` | `AutoSamplingTheory/Automation.lean` | harness | compiled process contracts, role contracts, acceptance gates | `AutomationStage`, `TaskKind`, `TaskStatus`, `AgentRole`, `AcceptanceGate`, `ArtifactSpec`, `AutomationTask`, `AgentContract`, ... | automation metadata |
| `AutoSamplingTheory.Core` | `AutoSamplingTheory/Core.lean` | foundation | source anchors, proof obligations, theorem contracts, DAG records | `ArtifactLanguage`, `ProofStatus`, `SourceKind`, `SourceAnchor`, `ProofObligation`, `TheoremContract`, `ProofDagBlock`, `forbiddenProofPatterns`, ... | ASTIS infrastructure; not Mathlib material |
| `AutoSamplingTheory.Literature` | `AutoSamplingTheory/Literature.lean` | reference registry | paper/source registry | `ImplementationStatus`, `PaperMode`, `PaperEntry`, `literature`, `literatureCount` | metadata |
| `AutoSamplingTheory.OpenProblems` | `AutoSamplingTheory/OpenProblems.lean` | exploration registry | open problem registry | `OpenProblem`, `openProblems`, `openProblemCount` | metadata |
| `AutoSamplingTheory.Probability` | `AutoSamplingTheory/Probability.lean` | generic technical core | law-map rewrites, dominated law derivatives, conditional-law bridges, KL/DV/LSI bookkeeping | `lawMapEqOfAEEq`, `lawMapIntegral`, `lawMapIntegralHasDerivAtOfSample`, `lawIntegralHasDerivAtOfMeasureMapEqAndSample`, `lawMapIntegralHasDerivAtOfDominated`, `lawIntegralHasDerivAtOfMeasureMapEqAndDominated`, `lawMapProdEqOfAEEq`, `lawMapProdFst`, ... | main Mathlib-ready adapter surface after naming/generalization cleanup |
| `AutoSamplingTheory.RMFLD` | `AutoSamplingTheory/RMFLD.lean` | exploratory consumer | exploratory sampling-theory proof targets | `rmfldPaperRoot`, `rmfldSource`, `exploratorySeedLabels`, `rmfldExploratoryContract`, `rmfldProofDag` | consumer of arsenal |
| `AutoSamplingTheory.SALD` | `AutoSamplingTheory/SALD.lean` | paper consumer | SALD case-study theorem contracts, compiled sublemmas, obligations | `saldPaperRoot`, `saldMainSource`, `saldAppendixSource`, `saldIterationSource`, `saldGronwallSource`, `saldGronwallExponentRewriteSource`, `saldDvVariationSource`, `saldPiSource`, ... | consumer of arsenal; no longer the center of the public library map |
| `AutoSamplingTheory.SDE` | `AutoSamplingTheory/SDE.lean` | contract layer | Ito diffusion, Fokker--Planck, Euler--Maruyama, discretization contracts | `ItoDiffusionContract`, `FokkerPlanckContract`, `EulerMaruyamaContract`, `DiscretizationErrorContract` | ASTIS contract surface; future executable SDE theorem layer |
| `AutoSamplingTheory.TechnicalLemmas.Gaussian` | `AutoSamplingTheory/TechnicalLemmas/Gaussian.lean` | Mathlib-ready technical lemma | product Gaussian coordinate law, integrability, mean zero, variance-one packaging | `stdGaussianPi`, `stdGaussianPi_isProbabilityMeasure`, `stdGaussianPi_isFiniteMeasure`, `map_eval_stdGaussianPi`, `integral_id_gaussianReal_zero`, `integrable_eval_stdGaussianPi`, `integrable_const_mul_sq_gaussianReal_zero`, `integrable_sq_eval_stdGaussianPi`, ... | best current upstream candidates after namespace/name cleanup |
| `AutoSamplingTheory.TechnicalLemmas.Measure` | `AutoSamplingTheory/TechnicalLemmas/Measure.lean` | Mathlib-ready technical lemma | search surface for law-map, dominated derivative, conditional-distribution lemmas | `integrable_of_measure_eq`, `condDistribAeEqCondExpKernelMap`, `condDistribIntegralAEStronglyMeasurable`, `condDistribIntegralIntegrable`, `condDistribIntegralMapAEStronglyMeasurable`, `condDistribIntegralMapIntegrable`, `condDistribIntegralMapIntegral`, `condDistribIntegralNamedFieldRegularity`, ... | re-export surface over compiled generic probability lemmas |
| `AutoSamplingTheory.TechnicalLemmas.Registry` | `AutoSamplingTheory/TechnicalLemmas/Registry.lean` | memory index | compiled lemma-memory metadata and external port queue | `LemmaMemoryStatus`, `LemmaMemoryEntry`, `sltSourceAnchor`, `gaussianMemory`, `taylorMemory`, `measureMemory`, `variationalMemory`, `saldExtractedMemory`, ... | agent retrieval registry, not theorem content |
| `AutoSamplingTheory.TechnicalLemmas.SALDExtracted` | `AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean` | paper-extracted technical lemma | compiled SALD-derived Brownian/Ito/Gronwall bridges exposed for search | `discreteForwardKlAccumulatedErrorCollectionScalar`, `discreteForwardKlAlphaComplexityCollectionScalar`, `discreteForwardKlDeltaAccumulationScalar`, `discreteForwardKlEmEndpointLawPairHandoff`, `discreteForwardKlEmInterpolationLeftEndpointLawHandoff`, `discreteForwardKlEmInterpolationLeftEndpointVector`, `discreteForwardKlEmInterpolationRightEndpointLawHandoff`, `discreteForwardKlEmInterpolationRightEndpointVector`, ... | compiled and useful; must be generalized before Mathlib submission |
| `AutoSamplingTheory.TechnicalLemmas.Taylor` | `AutoSamplingTheory/TechnicalLemmas/Taylor.lean` | Mathlib-ready technical lemma | Hessian/operator norm bridges, orthonormal basis unit, quadratic normalization | `hessianOpNormOfSourceHessianField`, `iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm`, `stdOrthonormalBasisUnit`, `quadraticVariationNormalizationOfCoeffDefAndVarianceOne` | small calculus/algebra leaves; SALD names need generalization before upstream |
| `AutoSamplingTheory.TechnicalLemmas.Variational` | `AutoSamplingTheory/TechnicalLemmas/Variational.lean` | Mathlib-ready technical lemma | Donsker--Varadhan, KL/FI/LSI scalar and integral bookkeeping exports | `dvFiniteLogMgfOfLeAlpha`, `dvVariationalOneSidedConsequenceScalar`, `dvVariationalOneSidedFromSupremumScalar`, `dvVariationalOneSidedOfScaledTest`, `dvVariationalOneSidedOfTiltedRight`, `dvVariationalScaledTestEnergyBound`, `dvVariationalScaledTestEnergyBoundWithCoeff`, `dvVariationalTiltedRightOneSidedConsequence`, ... | small compiled consequences; full DV/LSI remains port queue |

## Current Library Boundary

| Layer | Rule |
|---|---|
| Mathlib-ready technical surface | `Probability.lean`, `TechnicalLemmas/Gaussian.lean`, `TechnicalLemmas/Measure.lean`, `TechnicalLemmas/Taylor.lean`, and `TechnicalLemmas/Variational.lean` are the first upstream-quality targets after names and hypotheses are generalized. |
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
