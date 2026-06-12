# ASTIS Proof Blueprint: ASTIS-SALD-001

Task id: `ASTIS-SALD-001`
Title: Faithfully reproduce the original VA-SALD paper proofs
Updated: `2026-06-12 07:18:59`
Blueprint stage: `LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization`

This is ASTIS's compact system-of-record snapshot for long-horizon Lean proof
automation.  It follows the LeanMarathon/QBE blueprint lesson, but the
correspondence surface is SDE/Sampling-specific: Lean declarations,
source-paper labels, proof obligations, ASTIS technical lemma memory,
SLT/SDE cited-result port audits, and
Lean-Markdown-LaTeX exports must stay synchronized.

## Current Directive

```text
Mode: `ASTIS-SALD-001` follows `LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization`.
Current dynamic leaf: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-194 dynamic-leaf worker packet. hRemainderBound under ProbabilityTheory.gaussianReal 0 (variance phi x i) is reduced to hNormalizedRemainderBound under normalizedCoordinateLaw by compiled SALD.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw. Confirmed compiled SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw formalizes hRemainderMeas transport. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387 checked. Gate passed python3 tools/astis.py check. Remaining hNormalizedRemainderBound and hRemainderBoundInt; hSourceHasHessian and hSourceHessianBound remain source-contract gaps. No external SLT import/call/queue or wrapper churn accepted.
Current illness area: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-194 dynamic-leaf worker packet. hRemainderBound under ProbabilityTheory.gaussianReal 0 (variance phi x i) is reduced to hNormalizedRemainderBound under normalizedCoordinateLaw by compiled SALD.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw. Confirmed compiled SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw formalizes hRemainderMeas transport. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387 checked. Gate passed python3 tools/astis.py check. Remaining hNormalizedRemainderBound and hRemainderBoundInt; hSourceHasHessian and hSourceHessianBound remain source-contract gaps. No external SLT import/call/queue or wrapper churn accepted.
Upper/middle must retire stale leaves before assigning lower work.
Lower work should be one local Lean declaration/proof boundary at a time.
Reviewer accepts progress only through `python3 tools/astis.py check` plus source correspondence.
```

## Dynamic Leaf Queue

Lower agents should work on one item at a time.  If a leaf is stale, upper or
middle must retire it before spending more proof-search tokens.

| Leaf | Status |
|---|---|
| narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-194 dynamic-leaf worker packet. hRemainderBound under ProbabilityTheory.gaussianReal 0 (variance phi x i) is reduced to hNormalizedRemainderBound under normalizedCoordinateLaw by compiled SALD.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw. Confirmed compiled SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw formalizes hRemainderMeas transport. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:116... | candidate |
| lower_2 recorded as lower because astis.py role choices exclude lower_2. discharges-supplied-hypothesis dynamic-leaf worker packet after gate pass: compiled SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsDominatedRemainderAndRemainderLimitScalarPushforward, discharging hRemainderGeneratorLimitDef inside the dominated Taylor moment consumer while keeping hBrownianCoordinateGeneratorTaylorIntegralDef explicit. Reuses local SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarP... | candidate |
| discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-193 dynamic-leaf worker packet. hRemainderGeneratorLimitDef is discharged by SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsDominatedRemainderAndRemainderLimitScalarPushforward, and hBrownianCoordinateGeneratorTaylorIntegralDef plus hRemainderGeneratorLimitDef are discharged inside the Taylor moment consumer by SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfScalarPushforw... | candidate |
| discharges-supplied-hypothesis dynamic-leaf worker packet queued after gate pass. Exact supplied hypothesis: hRemainderMeas in SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfScalarPushforwardRawTaylorAndDominatedRemainder, with optional same-hypothesis follow-through in SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsDominatedRemainderAndRemainderLimitScalarPushforward. Lower_2 target: SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw from hNormal... | candidate |
| lower_2 recorded as lower because astis.py role choices exclude lower_2. discharges-supplied-hypothesis dynamic-leaf worker packet: compiled SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw discharges hRemainderMeas from hNormalizedRemainderMeas plus standard-Gaussian vector coordinate-law and variance-def fields. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387. Checks: lake env lean AutoSamplingTheory/SALD.lean passed; python3 tools/astis.py chec... | candidate |
| discharges-supplied-hypothesis dynamic-leaf worker packet after gate pass: hRemainderMeas discharged by compiled SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw. Uses local SALD selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw and selectedWeakTestNormalizedVarianceDefOfGaussianRealUnitLaw plus equality/simpa transport for AEStronglyMeasurable; exposed via TechnicalLemmas.SALDExtracted and registry key sald.remainder-meas-gaussian-law. Source anchors appendix.tex:958-970, appendix.tex:983-99... | candidate |
| lower_1 recorded as lower because astis.py role choices exclude lower_1. discharges-supplied-hypothesis dynamic-leaf proof-scout packet after gate pass for hRemainderMeas Gaussian-law transport. Route artifact: runs/20260612-060143-086541-ASTIS-SALD-001-cycle194/lower_1_remainder_meas_route.md. Exact supplied hypothesis: hRemainderMeas in the cycle-193 Taylor moment consumers. The route uses local SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw and SALD.selectedWeakTestNormalizedVarianceDefOfG... | candidate |
| lower_2 recorded as lower because astis.py role choices exclude lower_2. narrows-source-cited-boundary dynamic-leaf worker packet after gate pass: compiled SALD.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw narrows hRemainderBound from Gaussian-law domination to hNormalizedRemainderBound under normalizedCoordinateLaw, using local SALD Gaussian coordinate-law and variance bridges. Exposed through TechnicalLemmas.SALDExtracted and registry key sald.remainder-bound-gaussian-law. Source anchors appendix.tex:9... | candidate |

## Open Obligation Signals

```text
hSourceLinearTermDef :
sourceLinearTerm phi x i z = linearCoeff phi x i * z
The next smaller source-cited obligation package is:
hSourceLinearTermTaylorDef :
sourceLinearTerm phi x i z =
Source anchors: `appendix.tex:958-970`, `appendix.tex:984-995`,
does not reopen the selected weak-test Hessian source-contract gap.
selectedWeakTestSourceLinearTermDefOfScalarLineFirstCoeffDef
This bridge should prove `hSourceLinearTermDef` from
`hSourceLinearTermTaylorDef` and `hScalarLineFirstCoeffDef` by two rewrites.
analytic content remains in the two smaller source-cited fields.
| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
| Cycle 186 lower_1 source-linear route | Reduce `hSourceLinearTermDef` to the source first-order Taylor term and the local first-derivative coefficient convention. | scalar selected line; `deriv`; `stdOrthonormalBasis`; source Brownian coordinate normalization | `runs/20260612-015813-121084-ASTIS-SALD-001-cycle186/lower_1_source_linear_term_route.md`; pr...
| Cycle 186 lower_2 source-linear bridge | Derive `hSourceLinearTermDef` from `hSourceLinearTermTaylorDef` and `hScalarLineFirstCoeffDef`. | local two-rewrite bridge; no measure theory or SLT dependency | `SALD.selectedWeakTestSourceLinearTermDefOfScalarLineFirstCoeffDef`; `SALD.cycle186GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalar...
## Cycle 186 Lower_2 Source Linear Term Bridge
Classification: `narrows-source-cited-boundary`.
hSourceLinearTermDef :
sourceLinearTerm phi x i z = linearCoeff phi x i * z
SALD.selectedWeakTestSourceLinearTermDefOfScalarLineFirstCoeffDef
The compiled bridge reduces the source-linear field to the smaller
source-cited pair `hSourceLinearTermTaylorDef` and
`hScalarLineFirstCoeffDef`. It rewrites the source linear term to the
Source anchors: `appendix.tex:958-970`, `appendix.tex:984-995`,
hSourceTaylorIntegrandDef
hSourceLinearTermTaylorDef
hSourceQuadraticTermDef
hSourceTaylorIntegrandMeas
`hSourceHasHessian` and `hSourceHessianBound` remain source-contract gaps. No
```

## Recent Packet Classifications

- `discharges-supplied-hypothesis`: 22
- `narrows-source-cited-boundary`: 10
- `rejected-wrapper-churn`: 0

## Proof Status Counts

- `blocked`: 0
- `contractOnly`: 34
- `formalized`: 286
- `obligation`: 1157
- `planned`: 9
- `sourceCited`: 16

## Lean Declaration Index

| Kind | Lean name | File |
|---|---|---|
| theorem | `lawIntegralHasDerivAtOfMeasureMapEqAndDominated` | `AutoSamplingTheory/Probability.lean:161` |
| theorem | `lawMapProdEqOfAEEq` | `AutoSamplingTheory/Probability.lean:210` |
| lemma | `does` | `AutoSamplingTheory/Probability.lean:225` |
| theorem | `lawMapProdFst` | `AutoSamplingTheory/Probability.lean:227` |
| theorem | `lawMapProdSnd` | `AutoSamplingTheory/Probability.lean:241` |
| theorem | `lawMapProdSwap` | `AutoSamplingTheory/Probability.lean:257` |
| theorem | `condDistribAeEqCondExpKernelMap` | `AutoSamplingTheory/Probability.lean:274` |
| theorem | `condDistribIntegralSampleAeEqOfCondExpKernelMap` | `AutoSamplingTheory/Probability.lean:298` |
| theorem | `condDistribIntegralAEStronglyMeasurable` | `AutoSamplingTheory/Probability.lean:328` |
| theorem | `condDistribIntegralIntegrable` | `AutoSamplingTheory/Probability.lean:348` |
| theorem | `condDistribIntegralMapAEStronglyMeasurable` | `AutoSamplingTheory/Probability.lean:370` |
| theorem | `condDistribIntegralMapIntegrable` | `AutoSamplingTheory/Probability.lean:390` |
| theorem | `condDistribIntegralMapIntegral` | `AutoSamplingTheory/Probability.lean:412` |
| theorem | `condDistribIntegralNamedLawIntegral` | `AutoSamplingTheory/Probability.lean:445` |
| theorem | `condDistribIntegralNamedLawAEStronglyMeasurable` | `AutoSamplingTheory/Probability.lean:466` |
| theorem | `condDistribIntegralNamedLawIntegrable` | `AutoSamplingTheory/Probability.lean:482` |
| theorem | `condDistribIntegralNamedFieldRegularity` | `AutoSamplingTheory/Probability.lean:505` |
| structure | `MeasureContract` | `AutoSamplingTheory/Probability.lean:532` |
| structure | `KLContract` | `AutoSamplingTheory/Probability.lean:541` |
| structure | `FIContract` | `AutoSamplingTheory/Probability.lean:550` |
| structure | `LSIContract` | `AutoSamplingTheory/Probability.lean:559` |
| structure | `PIContract` | `AutoSamplingTheory/Probability.lean:568` |
| structure | `TransportVelocityContract` | `AutoSamplingTheory/Probability.lean:577` |
| structure | `GuidedTiltContract` | `AutoSamplingTheory/Probability.lean:586` |
| structure | `DvVariationalFormulaInterface` | `AutoSamplingTheory/Probability.lean:600` |
| def | `dvVariationalObligation` | `AutoSamplingTheory/Probability.lean:616` |
| def | `dvVariationalFormulaInterface` | `AutoSamplingTheory/Probability.lean:628` |
| theorem | `lsiKlFiSqrtDensitySquareScalar` | `AutoSamplingTheory/Probability.lean:650` |
| theorem | `lsiKlFiSqrtDensityEntropyIntegrandScalar` | `AutoSamplingTheory/Probability.lean:661` |
| theorem | `lsiKlFiSqrtDensityNormalizationScalar` | `AutoSamplingTheory/Probability.lean:671` |
| theorem | `lsiKlFiRnDerivLIntegralMassOne` | `AutoSamplingTheory/Probability.lean:683` |
| theorem | `lsiKlFiRnDerivDensityMassOne` | `AutoSamplingTheory/Probability.lean:695` |
| theorem | `lsiKlFiSqrtRnDerivTestMassOne` | `AutoSamplingTheory/Probability.lean:708` |
| theorem | `lsiKlFiRnDerivEntropyIntegral` | `AutoSamplingTheory/Probability.lean:724` |
| theorem | `lsiKlFiSqrtRnDerivEntropyIntegral` | `AutoSamplingTheory/Probability.lean:738` |
| theorem | `lsiKlFiSqrtDensityFisherChainScalar` | `AutoSamplingTheory/Probability.lean:758` |
| theorem | `lsiKlFiSqrtDensityFisherChainOfDerivativesScalar` | `AutoSamplingTheory/Probability.lean:774` |
| theorem | `lsiKlFiSqrtDensityFisherChainFiniteSumScalar` | `AutoSamplingTheory/Probability.lean:790` |
| theorem | `lsiKlFiSqrtDensityFisherChainFiniteSumHandoffScalar` | `AutoSamplingTheory/Probability.lean:820` |
| theorem | `lsiKlFiSqrtDensityFisherChainIntegralFiniteSum` | `AutoSamplingTheory/Probability.lean:841` |
| theorem | `lsiKlFiSqrtDensityFisherChainIntegralHandoffScalar` | `AutoSamplingTheory/Probability.lean:861` |
| theorem | `dvVariationalOneSidedConsequenceScalar` | `AutoSamplingTheory/Probability.lean:881` |
| theorem | `dvVariationalOneSidedFromSupremumScalar` | `AutoSamplingTheory/Probability.lean:892` |
| theorem | `dvFiniteLogMgfOfLeAlpha` | `AutoSamplingTheory/Probability.lean:913` |
| theorem | `dvVariationalOneSidedOfTiltedRight` | `AutoSamplingTheory/Probability.lean:929` |
| theorem | `dvVariationalOneSidedOfScaledTest` | `AutoSamplingTheory/Probability.lean:973` |
| theorem | `dvVariationalScaledTestEnergyBound` | `AutoSamplingTheory/Probability.lean:999` |
| theorem | `dvVariationalScaledTestEnergyBoundWithCoeff` | `AutoSamplingTheory/Probability.lean:1047` |
| theorem | `dvVariationalTiltedRightOneSidedConsequence` | `AutoSamplingTheory/Probability.lean:1079` |
| def | `lsiToKlFiObligation` | `AutoSamplingTheory/Probability.lean:1094` |
| inductive | `ArtifactLanguage` | `AutoSamplingTheory/Core.lean:14` |
| inductive | `ProofStatus` | `AutoSamplingTheory/Core.lean:22` |
| inductive | `SourceKind` | `AutoSamplingTheory/Core.lean:31` |
| structure | `SourceAnchor` | `AutoSamplingTheory/Core.lean:41` |
| structure | `ProofObligation` | `AutoSamplingTheory/Core.lean:50` |
| structure | `TheoremContract` | `AutoSamplingTheory/Core.lean:60` |
| structure | `ProofDagBlock` | `AutoSamplingTheory/Core.lean:72` |
| def | `forbiddenProofPatterns` | `AutoSamplingTheory/Core.lean:83` |
| def | `sourceAnchor` | `AutoSamplingTheory/Core.lean:86` |
| def | `localTexAnchor` | `AutoSamplingTheory/Core.lean:100` |

## Correspondence Artifacts

| Artifact | Role |
|---|---|
| `AutoSamplingTheory/SALD.lean` | correspondence/system-of-record |
| `conversion-windows/ASTIS-SALD-001.md` | correspondence/system-of-record |
| `proof-obligations/ASTIS-SALD-001.md` | correspondence/system-of-record |
| `research-wiki/source-index/SALD_original.jsonl` | correspondence/system-of-record |
| `proof-blueprints/ASTIS-SALD-001.md` | correspondence/system-of-record |
| `research-wiki/paper-contributions/SALD/unfinished_source_map.md` | correspondence/system-of-record |
| `research-wiki/technical-lemmas/technical_lemma_registry.jsonl` | correspondence/system-of-record |
| `research-wiki/retrieval-index/ASTIS-SALD-001.json` | correspondence/system-of-record |
| `research-wiki/cited-results/SLT_reuse_audit.md` | correspondence/system-of-record |
| `runs/trials.jsonl` | correspondence/system-of-record |
| `proof-blueprints/ASTIS-SALD-001-blueprint-status.md` | correspondence/system-of-record |
| `paper-notes/AutoLeanInSleepSampling/markdown/status.md` | correspondence/system-of-record |
| `paper-notes/AutoLeanInSleepSampling/latex/sections/00_overview.tex` | correspondence/system-of-record |
| `docs/leanmarathon_reference_notes.md` | correspondence/system-of-record |
| `docs/self_reflection_and_efficiency.md` | correspondence/system-of-record |

## Source Contract Excerpt

```text
# Faithfully reproduce the original VA-SALD paper proofs Task id: `ASTIS-SALD-001` Kind: `paperReproduction` Mode: `faithfulPaper` Status: `active` ## Goal Reproduce the proof structure of `/home/nitanda_sub/mark/repos/sald/paper` in Lean-facing contracts and, incrementally, Lean proofs. The source file `sald_version_2.tex` is explicitly out of scope. ## First Proof DAG - `lem:gronwall` - `lem:dv_variation` - LSI/KL/FI definitions - `thm:forward-KL` - `thm:forward-KL-discrete` - `prop:guided_path_residual` - `thm:general-moving-target-SALD` - `thm:unified-forward-KL` - `thm:general-moving-target-SALD-discrete` ## Current 6h Priority: Single-Backend Backfill The theorem-skeleton route is now stable enough to stop rotating broadly through all theorem statements. The next batch should backfill exactly one shared analytic backend: the Euler--Maruyama interpolation conditional-law / weak Fokker--Planck interface, especially `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`. This backend has the highest leverage because it supports both `thm:forward-KL-discrete` and `thm:general-moving-target-SALD-discrete`. Upper and middle agents should avoid as...
```

## Gate Policy

- Faithful paper mode may not weaken the SALD statement to close a Lean goal.
- Stage 1 target/source review remains active when notation or hypotheses move.
- Stage 2 proof discharge assigns lower workers to dynamic leaves only.
- Refiner work should repair one connected illness area instead of stacking
  unrelated wrapper lemmas.
- Lean plus explicit source correspondence is the gate; agent self-assessment is
  not proof progress.

## External References

- LeanMarathon: https://github.com/YuanheZ/LeanMarathon
- LeanMarathon article: https://arxiv.org/abs/2606.05400
- Shared local LeanMarathon repo: `/home/nitanda_sub/mark/repos/outer_repos/automation_systems/LeanMarathon`
- Shared local LeanMarathon PDF: `/home/nitanda_sub/mark/repos/outer_papers/automation_systems/LeanMarathon-2606.05400.pdf`
