# ASTIS Proof Blueprint: ASTIS-SALD-001

Task id: `ASTIS-SALD-001`
Title: Faithfully reproduce the original VA-SALD paper proofs
Updated: `2026-06-08 23:04:11`
Blueprint stage: `LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization`

This is ASTIS's compact system-of-record snapshot for long-horizon Lean proof
automation.  It follows the LeanMarathon/QBE blueprint lesson, but the
correspondence surface is SDE/Sampling-specific: Lean declarations,
source-paper labels, proof obligations, SLT/SDE cited-result reuse, and
Lean-Markdown-LaTeX exports must stay synchronized.

## Current Directive

```text
Mode: `ASTIS-SALD-001` follows `LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization`.
Current dynamic leaf: Remaining boundary is the internal-paper scalar Brownian/Ito coordinate decomposition and per-coordinate Hessian generator theorem from eq:general_moving_target_SALD_frozen_interp and appendix.tex:1379-1387
Current illness area: Remaining boundary is the internal-paper scalar Brownian/Ito coordinate decomposition and per-coordinate Hessian generator theorem from eq:general_moving_target_SALD_frozen_interp and appendix.tex:1379-1387
Upper/middle must retire stale leaves before assigning lower work.
Lower work should be one local Lean declaration/proof boundary at a time.
Reviewer accepts progress only through `python3 tools/astis.py check` plus source correspondence.
```

## Dynamic Leaf Queue

Lower agents should work on one item at a time.  If a leaf is stale, upper or
middle must retire it before spending more proof-search tokens.

| Leaf | Status |
|---|---|
| Remaining boundary is the internal-paper scalar Brownian/Ito coordinate decomposition and per-coordinate Hessian generator theorem from eq:general_moving_target_SALD_frozen_interp and appendix.tex:1379-1387 | candidate |
| narrows-source-cited-boundary middle packet: compiled SALD.emFrozenScalarBrownianItoOneDimTaylorGenerator and SALD.generalMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoCoordinateGeneratorDefOfOneDimTaylor; hFrozenScalarBrownianItoCoordinateGeneratorDef narrowed to hFrozenScalarBrownianItoCoordinateGeneratorOneDimTaylor; hFrozenScalarBrownianItoEventFieldCoordinateSum remains explicit; conversion/proof-obligation/SLT audit/dependency notes updated; no SLT import; mandatory gate passed p... | candidate |
| lower_1 recorded as lower because astis.py rejects lower_1. narrows-source-cited-boundary lower_1 proof-scout packet. Compiled SALD.gaussianRealZeroSecondMoment from Mathlib Gaussian.Real, narrowing hFrozenScalarBrownianItoCoordinateGeneratorOneDimTaylor by discharging the centered scalar Gaussian second moment. Remaining lower_2-ready theorem is hFrozenScalarBrownianItoOneDimTaylorExpansion: selected-test C^2 plus zero first moment, compiled second moment, and dominated Taylor/Ito generator limit imply brownian... | candidate |
| lower_2 recorded as lower because astis.py rejects lower_2. narrows-source-cited-boundary dynamic-leaf worker packet. Compiled SALD.gaussianRealZeroOneDimTaylorMomentContribution, narrowing hFrozenScalarBrownianItoOneDimTaylorExpansion by removing centered scalar Gaussian Taylor moment algebra via ProbabilityTheory.integral_id_gaussianReal and SALD.gaussianRealZeroSecondMoment. Remaining smaller source-cited theorem: hFrozenScalarBrownianItoTaylorRemainderGeneratorLimit; hFrozenScalarBrownianItoEventFieldCoordin... | candidate |
| narrows-source-cited-boundary reviewer acceptance after mandatory gate. Accepted cycle-161 lower_2: SALD.gaussianRealZeroOneDimTaylorMomentContribution narrows hFrozenScalarBrownianItoOneDimTaylorExpansion to remaining hFrozenScalarBrownianItoTaylorRemainderGeneratorLimit; dynamic-leaf scalar Brownian/Ito packet; appendix.tex:984-995 and 1379-1387 checked; no SLT import or fake closure; gate passed python3 tools/astis.py check. | candidate |
| narrows-source-cited-boundary upper handoff after mandatory gate pass. Selected dynamic-leaf worker target hFrozenScalarBrownianItoTaylorRemainderGeneratorLimit below hFrozenScalarBrownianItoOneDimTaylorExpansion inside sald.general_moving_target_discrete.em_interpolation_fp over appendix.tex:1358-1387, anchors appendix.tex:984-995 and 1379-1387. Reject wrapper churn, non-EM fallback, broad audits, Lake/SLT import, theorem-status promotion, fake closures, and sald_version_2.tex. Gate passed: python3 tools/astis.... | candidate |
| narrows-source-cited-boundary dynamic-leaf worker packet: compiled SALD.generalMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoOneDimTaylorOfGaussianMomentRemainder; narrowed hFrozenScalarBrownianItoTaylorRemainderGeneratorLimit to hFrozenScalarBrownianItoTaylorMomentDecomposition plus hFrozenScalarBrownianItoQuadraticVariationNormalization plus hFrozenScalarBrownianItoNormalizedTaylorRemainderVanishes; conversion window, proof obligations, SLT audit, and Lean dependency index updated; n... | candidate |
| lower_1 recorded as lower because astis.py rejects lower_1. narrows-source-cited-boundary dynamic-leaf proof-scout packet. Narrowed hFrozenScalarBrownianItoNormalizedTaylorRemainderVanishes to lower_2-ready theorem SALD.gaussianRealNormalizedTaylorRemainderIntegralTendstoZeroOfDCT using MeasureTheory.tendsto_integral_filter_of_dominated_convergence; follow-up pointwise source Taylor limit uses Real.taylor_tendsto or taylor_isLittleO for r /-> selectedTest phi (x + r • e_i). hFrozenScalarBrownianItoTaylorMomentDe... | candidate |
| lower_2 recorded as lower because astis.py rejects lower_2. narrows-source-cited-boundary dynamic-leaf worker packet: compiled SALD.gaussianRealNormalizedTaylorRemainderIntegralTendstoZeroOfDCT, narrowing hFrozenScalarBrownianItoNormalizedTaylorRemainderVanishes by formalizing the Mathlib dominated-convergence Gaussian integral-limit step. Remaining smaller source-cited work: concrete selected-test scalar Taylor hPoint, hFrozenScalarBrownianItoTaylorMomentDecomposition, and hFrozenScalarBrownianItoQuadraticVaria... | candidate |

## Open Obligation Signals

```text
| Trace-law source/event to total event | Feed the trace-action narrowing through the cycle-149 trace-field source/event total-event bridge. | trace-action helper; `SALD.generalMovingTargetDiscreteEmGeneratorLaplacianTotalEventIntegralOfTraceFieldSourceAndEventFormula`; `hemGeneratorLaplacianEventFieldEqTraceField`; `htraceFieldEqLaplacian` | `SALD.genera...
| Trace-state source/event to total event | Transport the sample-space trace integral along `hatXAtS` to the law-space trace integral, then feed the trace-law total-event bridge. | `SALD.generalMovingTargetDiscreteEmGeneratorTraceLawIntegralOfStateIntegral`; `hhatRhoS`; `hhatX`; `htraceFieldMeas`; `hemGeneratorTraceStateIntegral`; trace-law total-event he...
| Trace-Laplacian state source/event to total event | Feed the source-Laplacian measurability and selected-test Laplacian state integral through the local trace-field/Laplacian helpers, then reuse the trace-state total-event theorem. | `SALD.generalMovingTargetDiscreteEmGeneratorTraceFieldMeasOfSourceLaplacianFieldMeas`; `SALD.generalMovingTargetDiscreteE...
| Remaining EM source definitions | Prove the paper's selected-test Laplacian state integral, source-Laplacian measurability when not supplied by the source-Laplacian route, event-field/trace-field equality, and trace-field/Laplacian identity for the named frozen EM Laplacian contribution. | Source definition of the frozen EM generator from `eq:general_mo...
`hemGeneratorLaplacianStateIntegral`, `hsourceLaplacianFieldMeas` when not
supplied by the source-Laplacian route,
keep `hsourceLaplacianFunctional` and state-event equality explicit when not
Classification: `narrows-source-cited-boundary`.
- `SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfEmGeneratorTraceLaplacianStdBasisEventLawIntegralFormula`.
`SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfEmGeneratorTraceLaplacianStdBasisEventStdBasisActionFormula`.
It follows from the smaller source-facing law-space action integral
`SALD.generalMovingTargetDiscreteSourceTestLaplacianEqStdIteratedFDeriv`.
The source event-field definition
| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
| Law integral to standard-basis action | Rewrite the law-space Mathlib Laplacian integral as the `Set.univ` standard-basis second-derivative action. | `SALD.generalMovingTargetDiscreteSourceTestLaplacianEqStdIteratedFDeriv`; `Mathlib.Analysis.InnerProductSpace.Laplacian` | `SALD.generalMovingTargetDiscreteEmGeneratorLaplacianStdBasisActionDefOfLawIntegra...
| Downstream law-integral consumer | Feed the law-integral split through the cycle-144 standard-basis action consumer while keeping `hemGeneratorLaplacianEventFieldStdBasisDef` explicit. | `SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfEmGeneratorTraceLaplacianStdBasisEventStdBasisActionFormula`; law-integral helper | `SALD.generalMovingTargetDis...
| Remaining EM source definitions | Prove the paper's law-space EM generator selected-test Laplacian action integral and the standard-basis event-field definition for the named frozen EM Laplacian event field. | Source definition of the frozen EM generator from `eq:general_moving_target_SALD_frozen_interp`; Fokker--Planck line for `hatRhoS`; existing EM c...
`htraceFieldStdBasis`, source-field/source-functional leaves,
Classification: `narrows-source-cited-boundary`.
- `SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfEmGeneratorTraceLaplacianTraceEventLawIntegralFormula`.
`SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfEmGeneratorTraceLaplacianStdBasisEventLawIntegralFormula`.
It follows from the smaller source-facing equality
together with the already explicit trace-field source formula
| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
| Trace field to Laplacian event-field standard basis | Identify the named frozen-generator Laplacian event field with the already tracked trace field, then reuse `htraceFieldStdBasis`. | source equality `hemGeneratorLaplacianEventFieldEqTraceField`; `htraceFieldStdBasis` | `SALD.generalMovingTargetDiscreteEmGeneratorLaplacianEventFieldStdBasisDefOfTraceF...
| Downstream trace-event law-integral consumer | Feed the trace-event split through the cycle-145 law-integral route while keeping `hemGeneratorLaplacianLawIntegral` explicit. | `SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfEmGeneratorTraceLaplacianStdBasisEventLawIntegralFormula`; trace-event helper | `SALD.generalMovingTargetDiscreteWeakFpSour...
| Remaining EM source definitions | Prove the paper's law-space EM generator selected-test Laplacian action integral and the source equality between the named Laplacian event field and the trace field. | Source definition of the frozen EM generator from `eq:general_moving_target_SALD_frozen_interp`; Fokker--Planck line for `hatRhoS`; trace-field naming at...
source-field/source-functional leaves, density-Laplacian facts,
```

## Recent Packet Classifications

- `discharges-supplied-hypothesis`: 0
- `narrows-source-cited-boundary`: 28
- `rejected-wrapper-churn`: 1

## Proof Status Counts

- `blocked`: 0
- `contractOnly`: 34
- `formalized`: 183
- `obligation`: 1070
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
| `research-wiki/cited-results/SLT_reuse_audit.md` | correspondence/system-of-record |
| `runs/trials.jsonl` | correspondence/system-of-record |
| `research-wiki/blueprints/ASTIS-SALD-001-blueprint-status.md` | correspondence/system-of-record |
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
