# ASTIS Proof Blueprint: ASTIS-SALD-001

Task id: `ASTIS-SALD-001`
Title: Faithfully reproduce the original VA-SALD paper proofs
Updated: `2026-06-06 02:27:41`
Blueprint stage: `LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization`

This is ASTIS's compact system-of-record snapshot for long-horizon Lean proof
automation.  It follows the LeanMarathon/QBE blueprint lesson, but the
correspondence surface is SDE/Sampling-specific: Lean declarations,
source-paper labels, proof obligations, SLT/SDE cited-result reuse, and
Lean-Markdown-LaTeX exports must stay synchronized.

## Current Directive

```text
Mode: `ASTIS-SALD-001` follows `LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization`.
Current dynamic leaf: Remaining exact blocker: ASTIS.SALD.cycle113.remaining_named_barB_state_event_set_integral / hbarBStateSetIntegral for appendix.tex:1368-1377, plus Integrable barB hatRhoS if not source-supplied
Current illness area: Remaining exact blocker: ASTIS.SALD.cycle113.remaining_named_barB_state_event_set_integral / hbarBStateSetIntegral for appendix.tex:1368-1377, plus Integrable barB hatRhoS if not source-supplied
Upper/middle must retire stale leaves before assigning lower work.
Lower work should be one local Lean declaration/proof boundary at a time.
Reviewer accepts progress only through `python3 tools/astis.py check` plus source correspondence.
```

## Dynamic Leaf Queue

Lower agents should work on one item at a time.  If a leaf is stale, upper or
middle must retire it before spending more proof-search tokens.

| Leaf | Status |
|---|---|
| Remaining exact blocker: ASTIS.SALD.cycle113.remaining_named_barB_state_event_set_integral / hbarBStateSetIntegral for appendix.tex:1368-1377, plus Integrable barB hatRhoS if not source-supplied | candidate |
| narrows-source-cited-boundary: upper selected hbarBCondExp in SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSourceDef as the one supplied EM conditional-integral hypothesis to replace or strictly narrow; active target remains sald.general_moving_target_discrete.em_interpolation_fp over appendix.tex:1358-1387; astis check passed. | candidate |
| narrows-source-cited-boundary. Compiled SALD.generalMovingTargetDiscreteNamedBarBCondExpOfSetIntegralEq and SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSetIntegralDef for appendix.tex:1368-1377, replacing primitive hbarBCondExp with the conditional-expectation uniqueness/set-integral characterization boundary. Remaining exact boundary is source set-integral characterization plus candidate regularity for barB(hatXAtS omega). Gate passed. | candidate |
| narrows-source-cited-boundary: compiled state-event set-integral bridge for appendix.tex:1368-1377 hbarBCondExp boundary; gate passed. | candidate |
| narrows-source-cited-boundary. Reviewer accepted cycle 112 after mandatory gate passed; proof-diagnostics forbidden_hits=0. hbarBCondExp in SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpSourceDef is replaced by compiled conditional-expectation uniqueness and state-event set-integral handoffs. Remaining exact boundary is candidate regularity plus the source state-event set-integral characterization for selected barB(hatXAtS omega). | candidate |
| narrows-source-cited-boundary. Pressure test of thm:forward-KL-discrete reaches the compiled EM/target-time/scalar LSI-DV-Gronwall route; next non-wrapper blocker is ASTIS.SALD.cycle112.remaining_named_barB_set_integral_characterization for appendix.tex:1368-1377, consumed by SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef. Lower packet is candidate regularity plus source state-event Bochner set-integral characterization for barB(hatXAtS omega). Mandatory astis check passed. | candidate |
| narrows-source-cited-boundary: cycle113 pressure test routes thm:forward-KL-discrete through compiled EM wrappers plus LSI/DV/Gronwall; first non-wrapper blocker is ASTIS.SALD.cycle112.remaining_named_barB_set_integral_characterization consumed by SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef at appendix.tex:1368-1377. Updated conversion/proof-obligation/SLT audit docs; gate passed. | candidate |
| discharges-supplied-hypothesis: cycle 113 lower compiled named barB state-field regularity pullback and downstream state-field set-integral bridge; hbarBMeas/hbarBInt discharged, remaining blocker is source state-event Bochner set-integral characterization; mandatory ASTIS check passed. | candidate |
| discharges-supplied-hypothesis. Reviewer accepted cycle 113 after python3 tools/astis.py check passed and proof-diagnostics forbidden_hits=0. hbarBMeas/hbarBInt in SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef are discharged by compiled SALD.generalMovingTargetDiscreteNamedBarBComapRegularityOfStateField and SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateFieldSetIntegralDef. Remaining exact blocker: ASTIS.SALD.cycle113.remaining_named_barB_state_event... | candidate |

## Open Obligation Signals

```text
| Obligation | Status | Source | Lean-facing contract |
| Pressure-test route through discrete theorem dependencies | checked; no theorem status promotion | `main_body.tex:301-323`; `appendix.tex:334-592`; active backend `appendix.tex:1358-1387` | `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes `SALD.cycle112EmNamedBarBCondExpRepresentativeDependencyNames`, `SALD.cycle113EmNamedBarBStateFiel...
| First non-wrapper blocker | source-cited/obligation boundary; narrows-source-cited-boundary | `appendix.tex:1368-1377` | `ASTIS.SALD.cycle112.remaining_named_barB_set_integral_characterization`; the exact consuming declaration is `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef` |
| Candidate regularity pullback | formalized local theorem; discharges-supplied-hypothesis | `appendix.tex:1368-1377`; named marginal `hatRhoS = Law(hatXAtS)` | `SALD.generalMovingTargetDiscreteNamedBarBComapRegularityOfStateField`; discharges `hbarBMeas` and `hbarBInt` from `StronglyMeasurable barB`, `Integrable barB hatRhoS`, `Measurable hatXAtS`, and `...
| State-field set-integral bridge | formalized downstream handoff; discharges-supplied-hypothesis | `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateFieldSetIntegralDef`; feeds the derived regularity into `SALD.generalMovingTargetDiscreteCondDistribNamedBarBAeEqOfCondExpStateSetIntegralDef` |
| Remaining lower-ready declaration boundary | source-cited/obligation boundary | `appendix.tex:1368-1377` | Prove or strictly narrow `hbarBStateSetIntegral`: equality of Bochner set integrals over every source-facing state event `{omega | hatXAtS omega in t}`; also prove `Integrable barB hatRhoS` from the selected state representative if that is not alre...
state-event set-integral characterization for `barB (hatXAtS omega)` or name
one smaller Mathlib/conditional-expectation theorem with imports and exact
and Bochner-integral style; no SLT theorem was found that directly supplies
| Obligation | Status | Source | Lean-facing contract |
| Source-signed named-law weak derivative | formalized local theorem; discharges `hsampleGenerator` in the named-law split-generator route | `appendix.tex:1379-1387` | `SALD.generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfDominatedSplitGeneratorHandoff`; dependency list `SALD.cycle110EmWeakFpDominatedGeneratorDependencyNames` |
| Remaining theorem | obligation; exact lower boundary after dominated transport | EM interpolation proof at `appendix.tex:1379-1387`; drift source at `appendix.tex:1368-1377` | `ASTIS.SALD.cycle110.remaining_parametric_generator_boundary_after_dominated_transport`; prove the pointwise EM derivative/dominated-bound package and identify the derivative inte...
`barB` representative, no-boundary theorem, box trace, KL/log-ratio, LSI, DV,
Classification: `narrows-source-cited-boundary`.
`appendix.tex:1379-1387`, with `barB` supplied by `appendix.tex:1368-1377`.
| Obligation | Status | Source | Lean-facing contract |
| Product flux continuity on the Mathlib box | formalized local theorem; `narrows-source-cited-boundary` | `appendix.tex:1379-1387`; Mathlib topology/box divergence setup | `SALD.generalMovingTargetDiscreteHatRhoBarBWeightedFieldContinuousOnBox`; proves continuity of `x |-> hatRhoDensity x • barB x` on `Set.Icc a b` from separate continuity of the density...
| Product-flux box handoff | formalized local theorem plus remaining obligations | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfHatRhoBarBBox`; instantiates the cycle-107 theorem with the concrete product flux and discharges the generic continuity premise |
| Remaining box/trace instantiation | obligation; exact next non-wrapper blocker | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | prove the Frechet derivative of `x |-> hatRhoDensity x • barB x` off a countable interior set, divergence integrability, `boundaryFlux` equals the interior divergence integral, and signed Mathlib faces equal the `testTrac...
`htestTraceZero` remain explicit. No non-EM fallback, source-index rebaseline,
Classification: `narrows-source-cited-boundary`.
`appendix.tex:1379-1387`, with `barB` supplied by `appendix.tex:1368-1377`.
Frechet derivative of `x |-> hatRhoDensity x • barB x` from separate density
| Obligation | Status | Source | Lean-facing contract |
| Product flux pointwise Frechet derivative | formalized local theorem; `narrows-source-cited-boundary` | `appendix.tex:1379-1387`; Mathlib `HasFDerivAt.smul` product rule | `SALD.generalMovingTargetDiscreteHatRhoBarBWeightedFieldHasFDerivAt`; proves the derivative formula `(hatRhoDensity x) • barBDeriv x + (hatRhoDeriv x).smulRight (barB x)` for `x |-> h...
| Product flux derivative off countable union | formalized local theorem | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | `SALD.generalMovingTargetDiscreteHatRhoBarBWeightedFieldHasFDerivAtOffUnion`; reduces product-flux differentiability off one exception set to separate density and `barB` differentiability off their union |
| Product-flux box handoff with derivative instantiated | formalized local theorem plus remaining obligations | `appendix.tex:1379-1387`; Mathlib box divergence setup | `SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfHatRhoBarBBoxProductDeriv`; instantiates `SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfHatRhoBarBBox` with the product deriv...
| Remaining box/trace instantiation after derivative | obligation; exact next non-wrapper blocker | `appendix.tex:1379-1387`; `appendix.tex:1368-1377` | prove divergence integrability for the product derivative, `boundaryFlux` equals the interior divergence integral, and signed Mathlib faces equal the `testTrace`/`normalFluxTrace` boundary integral |
```

## Recent Packet Classifications

- `discharges-supplied-hypothesis`: 5
- `narrows-source-cited-boundary`: 15
- `rejected-wrapper-churn`: 0

## Proof Status Counts

- `blocked`: 0
- `contractOnly`: 34
- `formalized`: 52
- `obligation`: 837
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
- Shared local LeanMarathon repo: `/home/nitanda_sub/mark/repos/outer_repos/LeanMarathon`
- Shared local LeanMarathon PDF: `/home/nitanda_sub/mark/repos/outer_papers/LeanMarathon-2606.05400.pdf`
