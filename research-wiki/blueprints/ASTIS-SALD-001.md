# ASTIS Proof Blueprint: ASTIS-SALD-001

Task id: `ASTIS-SALD-001`
Title: Faithfully reproduce the original VA-SALD paper proofs
Updated: `2026-06-10 07:34:25`
Blueprint stage: `LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization`

This is ASTIS's compact system-of-record snapshot for long-horizon Lean proof
automation.  It follows the LeanMarathon/QBE blueprint lesson, but the
correspondence surface is SDE/Sampling-specific: Lean declarations,
source-paper labels, proof obligations, SLT/SDE cited-result reuse, and
Lean-Markdown-LaTeX exports must stay synchronized.

## Current Directive

```text
Mode: `ASTIS-SALD-001` follows `LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization`.
Current dynamic leaf: Remaining boundary: selected-test second-Frechet-derivative operator-norm bound and Brownian coordinate unit direction from testRegular/source regularity. Gate passed: python3 tools/astis.py check.
Current illness area: remaining exact boundary is hHessianOpNorm : forall z : E, norm (fderiv Real (fderiv Real sourceTest) z) <= C1 from selected weak-test C2_b/bounded-Hessian source interface under sald.general_moving_target_discrete.em_interpolation_fp. Brownian unit direction and hHessianOpNorm-to-hSecondFDerivOpNorm bridge already compiled. Source anchors checked: appendix.tex:984-995, appendix.tex:1026-1072, appendix.tex:1379-1387, main_body.tex:273-305. No SLT/external lookup/import/status promotion/wrapper churn/non-EM fallback/sald_version_2. Gate passed: python3 tools/astis.py check.
Upper/middle must retire stale leaves before assigning lower work.
Lower work should be one local Lean declaration/proof boundary at a time.
Reviewer accepts progress only through `python3 tools/astis.py check` plus source correspondence.
```

## Dynamic Leaf Queue

Lower agents should work on one item at a time.  If a leaf is stale, upper or
middle must retire it before spending more proof-search tokens.

| Leaf | Status |
|---|---|
| Remaining boundary: selected-test second-Frechet-derivative operator-norm bound and Brownian coordinate unit direction from testRegular/source regularity. Gate passed: python3 tools/astis.py check. | candidate |
| remaining exact boundary is hHessianOpNorm : forall z : E, norm (fderiv Real (fderiv Real sourceTest) z) <= C1 from selected weak-test C2_b/bounded-Hessian source interface under sald.general_moving_target_discrete.em_interpolation_fp. Brownian unit direction and hHessianOpNorm-to-hSecondFDerivOpNorm bridge already compiled. Source anchors checked: appendix.tex:984-995, appendix.tex:1026-1072, appendix.tex:1379-1387, main_body.tex:273-305. No SLT/external lookup/import/status promotion/wrapper churn/non-EM fallb... | candidate |
| rejected-wrapper-churn middle handoff after gate pass: cycle-172 blueprint-refreshed illness-area refiner preserved hHessianOpNorm source-contract gap, rejected same-field testRegular/SelectedWeakTestC2bBoundedHessian wrappers, synchronized Lean/conversion/proof-obligation/SLT audit notes, and passed python3 tools/astis.py check. | candidate |
| lower_1 recorded as lower because astis.py rejects lower_1. rejected-wrapper-churn lower_1 illness-area proof-scout handoff after gate pass: preserved exact hHessianOpNorm source-contract gap under sald.general_moving_target_discrete.em_interpolation_fp; Brownian unit direction and hHessianOpNorm-to-hSecondFDerivOpNorm bridge already compiled; source anchors and original-source search excluding sald_version_2.tex still lack selected weak-test global bounded-Hessian field; added synchronized Lean ProofObligation/... | candidate |
| lower_2 recorded as lower because astis.py rejects lower_2. rejected-wrapper-churn lower_2 after gate pass: rejected unsourced SourceSelectedWeakTestC2bBoundedHessian/hHessianOpNorm projection and rejected iteration_complexity.tex:309-321 VP score Hessian as wrong object for sourceTest; added cycle172 lower2 ProofObligation/DAG/dependency plus proof-obligation/conversion-window/SLT audit sync. Remaining exact hHessianOpNorm source-contract gap. Gate passed: python3 tools/astis.py check. | candidate |
| rejected-wrapper-churn reviewer acceptance after gate pass: accepted cycle-172 illness-area refiner packet; exact hHessianOpNorm source-contract gap preserved under sald.general_moving_target_discrete.em_interpolation_fp; no theorem-status promotion, no unsourced SelectedWeakTestC2bBoundedHessian projection, no SLT import, no sald_version_2 use; source anchors and iteration_complexity score-Hessian rejection checked; gate passed: python3 tools/astis.py check. | candidate |
| rejected-wrapper-churn upper illness-area refiner after gate pass: no cycle-172 recovery; Phase 1 skeleton stable for single-backend backfill; active lower packet remains source-contract recovery for hHessianOpNorm under sald.general_moving_target_discrete.em_interpolation_fp over appendix.tex:1358-1387. No wrapper churn, non-EM fallback, SLT import, theorem-status promotion, VP score-Hessian substitution, or sald_version_2 use. Gate passed: python3 tools/astis.py check. | candidate |
| rejected-wrapper-churn middle illness-area refiner after gate pass: preserved exact hHessianOpNorm source-contract gap under sald.general_moving_target_discrete.em_interpolation_fp; Brownian unit and Hessian-to-iterated-Frechet bridges already compiled; source recheck found no selected weak-test bounded-Hessian field and rejected testRegular, SourceSelectedWeakTestC2bBoundedHessian, and VP score-Hessian substitutions; synchronized Lean, conversion-window, proof-obligation, blueprint, and SLT audit; gate passed:... | candidate |
| lower_1 recorded as lower because astis.py rejects lower_1. narrows-source-cited-boundary lower_1 illness-area proof-scout packet: hHessianOpNorm narrowed to sourceHessian plus hSourceHasHessian/hSourceHessianBound theorem route; lower_2 implement selectedWeakTestHessianOpNormOfSourceHessianField only if those source fields are source-backed; no wrapper churn, no SLT import; gate passed. | candidate |
| lower_2 recorded as lower because astis.py rejects lower_2. narrows-source-cited-boundary lower_2 compiled SALD.selectedWeakTestHessianOpNormOfSourceHessianField; hHessianOpNorm now follows from sourceHessian plus hSourceHasHessian and hSourceHessianBound via HasFDerivAt.fderiv; remaining source-contract gap is the two source-backed selected weak-test Hessian fields; no SLT import or wrapper churn; gate passed. | candidate |

## Open Obligation Signals

```text
source-facing obligations are now exactly:
- `hSourceHasHessian`: the selected weak test has the named Hessian
representative `sourceHessian`.
- `hSourceHessianBound`: that representative has uniform operator norm at most
The route is admissible only if those two fields are source-backed from the
selected weak-test interface. Defining `sourceHessian` or either field from
`hHessianOpNorm`, unexpanded `testRegular`, or an unsourced
`SourceSelectedWeakTestC2bBoundedHessian` predicate is wrapper churn.
| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
| Cycle 173 lower_1 source-Hessian proof route | Reduce `hHessianOpNorm` to a source-backed Hessian representative plus a uniform bound. | `HasFDerivAt.fderiv`; Brownian unit theorem; Hessian-to-iterated-Frechet bridge; cycle-173 middle rejection of wrappers | `SALD.cycle173GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoHe...
Dependency classification remains `source-contract-gap`, with a Mathlib
derivative-uniqueness proof route once the source-backed fields exist. No SLT
## Cycle 173 Lower_2 Compiled Source-Hessian Bridge
Classification: `narrows-source-cited-boundary`.
SALD.selectedWeakTestHessianOpNormOfSourceHessianField
smaller source-facing pair
hSourceHasHessian :
HasFDerivAt (fderiv Real sourceTest) (sourceHessian z) z
hSourceHessianBound :
forall z : E, norm (sourceHessian z) <= C1
forall z : E, norm (fderiv Real (fderiv Real sourceTest) z) <= C1
by rewriting with `(hSourceHasHessian z).fderiv` and applying
`hSourceHessianBound z`.
| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
| Cycle 173 lower_2 source-Hessian bridge | Compile the bridge from source-backed Hessian fields to the downstream selected-test Hessian operator-norm bound. | `HasFDerivAt.fderiv`; lower_1 source-Hessian route; cycle-173 middle wrapper rejection | `SALD.selectedWeakTestHessianOpNormOfSourceHessianField`; `SALD.cycle173GeneralMovingTargetDiscreteEmGenerat...
Remaining dependency classification: `source-contract-gap` for
`hSourceHasHessian` and `hSourceHessianBound`. The compiled theorem does not
unsourced `SourceSelectedWeakTestC2bBoundedHessian`, and does not use the VP
```

## Recent Packet Classifications

- `discharges-supplied-hypothesis`: 1
- `narrows-source-cited-boundary`: 14
- `rejected-wrapper-churn`: 14

## Proof Status Counts

- `blocked`: 0
- `contractOnly`: 34
- `formalized`: 225
- `obligation`: 1101
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
