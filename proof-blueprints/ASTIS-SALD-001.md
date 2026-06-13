# ASTIS Proof Blueprint: ASTIS-SALD-001

Task id: `ASTIS-SALD-001`
Title: Faithfully reproduce the original VA-SALD paper proofs
Updated: `2026-06-13 06:21:42`
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
Current dynamic leaf: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-206 dynamic-leaf worker packet. Exact boundary narrowed: hRemainderGeneratorLimitDef -> hRemainderPullbackDef, recorded by compiled SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Obligation/Dag with typed feedback leaf=hRemainderPullbackDef error_class=source_contract_gap_missing_remainder_pullback_definition. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387 checked against original SALD source excluding sald_version_2.tex. Local ASTIS declarations only: existing SALD scalar-pushforward/Gaussian-law remainder bridges, TechnicalLemmas.SALDExtracted/Gaussian/Measure entries, and Mathlib MeasureTheory.integral_map. No external SLT import/call/queue, fake closure, wrapper churn, source-Hessian replay, selected-line Taylor replay, endpoint/naming replay, or theorem-status promotion. Remaining gap is the source-backed pullback definition of re...
Current illness area: narrows-source-cited-boundary reviewer_waste acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner, obligation-level only; no lower_1/lower_2 artifact and no proved Lean theorem in cycle207. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:983-996;appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387 verified. Local compiled ASTIS TechnicalLemmas.Measure and SALD weak-FP/condDistrib handoffs only; no external SLT import/call/queue/port. Waste diagnosis: useful progress is retiring repeated hRemainderPullbackDef wrapper churn and selecting emInterpolationConditionalWeakFp; no formal proof progress occurred; next best leaf is lower_2 compiling one non-wrapper theorem for emInterpolationConditionalWeakFp or logging leaf=emInterpolationConditionalWeakFp error_class=source_contract_gap_missing_conditional_fp_generator_definition.
Upper/middle must retire stale leaves before assigning lower work.
Lower work should be one local Lean declaration/proof boundary at a time.
Reviewer accepts progress only through `python3 tools/astis.py check` plus source correspondence.
```

## Dynamic Leaf Queue

Lower agents should work on one item at a time.  If a leaf is stale, upper or
middle must retire it before spending more proof-search tokens.

| Leaf | Status |
|---|---|
| narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-206 dynamic-leaf worker packet. Exact boundary narrowed: hRemainderGeneratorLimitDef -> hRemainderPullbackDef, recorded by compiled SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Obligation/Dag with typed feedback leaf=hRemainderPullbackDef error_class=source_contract_gap_missing_remainder_pullback_definition. Gate passed: python3 tools/astis.py check. Source anch... | candidate |
| narrows-source-cited-boundary reviewer_waste acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner, obligation-level only; no lower_1/lower_2 artifact and no proved Lean theorem in cycle207. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:983-996;appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387 verified. Local compiled ASTIS TechnicalLe... | candidate |
| narrows-source-cited-boundary illness-area refiner packet. Global phase judgment: cycle 206 passed and needs no recovery; Phase 1 transcript is stable enough for cited-theory backfill; next lower packet narrows sald.general_moving_target_discrete.em_interpolation_fp over appendix.tex:1358-1387 to emInterpolationConditionalWeakFp over appendix.tex:1368-1387 and appendix.tex:1379-1387. Process audit: accepted hRemainderPullbackDef below hRemainderGeneratorLimitDef is honest source-contract memory, but further same... | candidate |
| narrows-source-cited-boundary illness-area refiner packet queued after gate pass. Global phase judgment: cycle 206 needs no recovery; Phase 1 theorem skeleton is stable; retire repeated hRemainderPullbackDef loop as accepted source-contract gap below hRemainderGeneratorLimitDef unless reducible-definition evidence appears. Exact boundary narrowed for cycle 207: sald.general_moving_target_discrete.em_interpolation_fp over appendix.tex:1358-1387 -> emInterpolationConditionalWeakFp over appendix.tex:1368-1387 and a... | candidate |
| narrows-source-cited-boundary illness-area refiner packet: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp; source artifact middle_source_correspondence_conditional_weak_fp.md; local ASTIS law-map/condDistrib/weak-FP handoffs only; no SLT; gate passed. | candidate |
| narrows-source-cited-boundary illness-area refiner packet: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Artifact runs/20260613-054827-700501-ASTIS-SALD-001-cycle207/middle_technical_lemma_conditional_weak_fp.md; SLT audit updated with no-slt status; compiled-local Measure/condDistrib/weak-FP handoffs only; no external SLT import/call/queue/port. Gate passed: python3 tools/astis.py check. | candidate |
| narrows-source-cited-boundary illness-area report/export synchronization packet. Exact boundary for human-readable status: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp over appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387; cycle-206 hRemainderGeneratorLimitDef -> hRemainderPullbackDef remains a recorded source-contract gap, not a proved result. No broad export-latex or project-article rewrite during this inner proof-search cycle; cite only compil... | candidate |
| narrows-source-cited-boundary illness-area refiner packet. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Artifact: runs/20260613-054827-700501-ASTIS-SALD-001-cycle207/middle_formalizer_conditional_weak_fp_handoff.md. lower_1 classical route; lower_2 one non-wrapper compiled theorem or typed feedback leaf=emInterpolationConditionalWeakFp error_class=source_contract_gap_missing_conditional_fp_generator_definition. Local ASTIS declarations only... | candidate |
| narrows-source-cited-boundary reviewer_gate acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner; accepted only as obligation-level boundary narrowing, not as a proved Lean theorem and not as a lower_2 worker proof. Gate passed: python3 tools/astis.py check. Source anchors: appendix.tex:983-996;appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387. Canonical unfi... | candidate |

## Open Obligation Signals

```text
hSourceQuadraticTermDef
hSourceTaylorIntegrandMeas
`hSourceHasHessian` and `hSourceHessianBound` remain source-contract gaps. No
## Cycle 206 Middle Remainder Pullback Source Boundary
Classification: `narrows-source-cited-boundary`.
Source anchors: `appendix.tex:958-970`, `appendix.tex:983-996`,
Typed feedback if the local source definitions do not reduce:
error_class=source_contract_gap_missing_remainder_pullback_definition
source_lines=appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387
blocked_by=remainderGeneratorLimit and normalizedRemainder are source-facing abstract fields in the compiled scalar-pushforward remainder bridge unless lower_2 finds a reducible local definition
| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
| Cycle 206 middle source boundary | Record `hRemainderPullbackDef` as the exact sample-space normalized-remainder expectation required below `hRemainderGeneratorLimitDef`. | `SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward`; `MeasureTheory.integral_map`; local Gaussian coordinate-law/variance facts | `SALD.cycle206GeneralMoving...
| Cycle 206 lower_2 remainder-pullback source gap | Lean inspection found `remainderGeneratorLimit`, `normalizedRemainder`, and `scalarBrownianCoordinate` only as abstract bridge parameters, so the pullback identity is recorded as the exact source-contract gap rather than closed by a wrapper. | existing scalar-pushforward remainder bridge; local Gaussian...
## Cycle 207 Middle Conditional-Law Weak-FP Boundary
Classification: `narrows-source-cited-boundary`.
-> emInterpolationConditionalWeakFp
interpolation law. The source lines are `appendix.tex:1368-1377` for the
conditional drift `bar b_{k,s}`, `appendix.tex:1379-1387` for the weak-FP
emInterpolationConditionalWeakFp :
and `SALD.generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfDominatedSplitGeneratorHandoff`.
`hderivValue`, `hdriftBarBAction`, raw `hpairMeas`, or `hcanonicalBarBMeas`.
Do not reopen `hSourceHasHessian` or `hSourceHessianBound`.
leaf=emInterpolationConditionalWeakFp
error_class=source_contract_gap_missing_conditional_fp_generator_definition
source_lines=appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387;appendix.tex:983-996
blocked_by=need source-selected generator/weak-FP definition connecting the frozen interpolation law to the conditional drift and Brownian Laplacian after already compiled law-map, condDistrib, and retired path/domination leaves
| Obligation | Boundary | Dependencies | Lean-facing contract | Source | Reuse | Status |
| Cycle 207 middle conditional-law weak-FP source correspondence | Narrow the broad EM interpolation weak-FP backend to the conditional-law source-sign law-derivative theorem, keeping KL differentiation downstream and avoiding wrapper churn. | frozen interpolation law; conditional drift definition; local law-map derivative and condDistrib handoffs | `runs...
```

## Recent Packet Classifications

- `discharges-supplied-hypothesis`: 0
- `narrows-source-cited-boundary`: 39
- `rejected-wrapper-churn`: 4

## Proof Status Counts

- `blocked`: 0
- `contractOnly`: 34
- `formalized`: 286
- `obligation`: 1175
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
