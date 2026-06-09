# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `132`
- Generated: `2026-06-07 11:44:50`

## Compact Task Contract

# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
discharges-supplied-hypothesis reviewer acceptance: accepted SALD.generalMovingTargetDiscreteCanonicalBarBWeakConditionalFpNamedLawDerivativeOfEmIntervalMeasIntDominated; discharged hsampleInt from SALD.generalMovingTargetDiscreteCanonicalBarBWeakConditionalFpNamedLawDerivativeOfEmIntervalMeasDominated using named-law Measure.map integrability transport plus Mathlib Integrable.comp_aemeasurable/integrable_map_measure. Remaining hsampleDerivMeas hsampleDerivBound hboundInt hpathDeriv hderivValue and canonical source-action identities. Gate python3 tools/astis.py check passed; proof-diagnostics forbidden_hits=0; no wrapper churn, broad audit, non-EM fallback, SLT import, Lake/toolchain change, theorem-status promotion, fake closure, or sald_version_2.

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.

## Cycle Focus

Blueprint-guided dynamic leaf: use `python3 tools/astis.py blueprint-refresh ASTIS-SALD-001` and target the refreshed dynamic leaf / illness area rather than the old rotating focus. Current blocker: discharges-supplied-hypothesis reviewer acceptance: accepted SALD.generalMovingTargetDiscreteCanonicalBarBWeakConditionalFpNamedLawDerivativeOfEmIntervalMeasIntDominated; discharged hsampleInt from SALD.generalMovingTargetDiscreteCanonicalBarBWeakConditionalFpNamedLawDerivativeOfEmIntervalMeasDominated using named-law Measure.map integrability transport plus Mathlib Integrable.comp_aemeasurable/integrable_map_measure. Remaining hsampleDerivMeas hsampleDerivBound hboundInt hpathDeriv hderivValue and canonical source-action identities. Gate python3 tools/astis.py check passed; proof-diagnostics forbidden_hits=0; no wrapper churn, broad audit, non-EM fallback, SLT import, Lake/toolchain change, theorem-status promotion, fake closure, or sald_version_2.. For the current SALD state this means stay on the EM conditional-drift/state-event set-integral boundary unless reviewer records a named Mathlib/theory gap; do not take a non-EM fallback merely because the old cycle schedule rotates there.

## Recent High-Signal Handoffs

- narrows-source-cited-boundary reviewer acceptance: accepted cycle130 illness-area refiner packet. Exact boundary narrowed: direct hfirstGreen replaced by first-Green residual/divergence/zero-boundary facts, with upstream hlaplacianAction and hweakLaplacianIbP boundaries split into source-facing Laplacian and Green leaves. Gate python3 tools/astis.py check passed; proof-diagnostics forbidden_hits=0; no wrapper churn, broad audit, non-EM fallback, SLT import, Lake/toolchain change, theorem-status promotion, fake c...
- narrows-source-cited-boundary upper handoff queued: illness-area refiner packet selected for cycle131. Exact boundary: narrow direct `hsecondGreen` in `SALD.generalMovingTargetDiscreteWeakConditionalFpDiffusionSourceOfFirstGreenNoBoundaryFlux` to source-facing second-Green residual/divergence/zero-boundary facts over appendix.tex:1379-1427, keeping `hdiffusionAction`, `hdiffusionLaplacianTerm`, first-Green subfacts, and `htestLaplacian` explicit. No SLT import; local SALD box divergence theorem plus Mathlib inte...
- narrows-source-cited-boundary handoff queued: illness-area refiner packet compiled SALD.generalMovingTargetDiscreteWeakConditionalFpDiffusionSourceOfSecondGreenNoBoundaryFlux; exact boundary narrowed direct hsecondGreen to hsecondGreenResidual, hsecondGreenDivergence, and hsecondGreenZeroBoundary over appendix.tex:1379-1427; gate python3 tools/astis.py check passed; no SLT import, wrapper churn, broad audit, non-EM fallback, Lake/toolchain change, theorem-status promotion, fake closure, or sald_version_2.
- lower_1 narrows-source-cited-boundary handoff: compiled SALD.generalMovingTargetDiscreteWeakConditionalFpDiffusionSourceOfSecondGreenTraceBoundary, narrowing hsecondGreenZeroBoundary to hsecondGreenBoundaryFluxIntegral plus hsecondGreenTraceProductZero; lower_2 next should instantiate the boundary-flux integral via SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfDivergenceTheoremBox or the source box-divergence route and prove trace-product zero from admissible-test trace or decay; gate python3 tools/astis...
- lower_2 narrows-source-cited-boundary: compiled SALD.generalMovingTargetDiscreteWeakConditionalFpDiffusionSourceOfSecondGreenBoxBoundaryFlux; removed direct hsecondGreenBoundaryFluxIntegral by deriving it from SALD.generalMovingTargetDiscreteBoundaryFluxIntegralOfDivergenceTheoremBox / MeasureTheory.integral_divergence_of_hasFDerivAt_off_countable package; hsecondGreenTraceProductZero and other Green/source facts remain explicit; gate python3 tools/astis.py check passed.
- narrows-source-cited-boundary reviewer acceptance: accepted cycle131 illness-area second-Green boundary chain; direct hsecondGreen narrowed to residual/divergence/zero-boundary, then zero-boundary to trace flux, then boundary-flux integral to SALD box divergence theorem package. Gate python3 tools/astis.py check passed; proof-diagnostics forbidden_hits=0; no SLT import, wrapper churn, non-EM fallback, Lake/toolchain change, theorem-status promotion, fake closure, or sald_version_2.

## Local SLT And Paper Reuse

- SLT local project (missing): `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory`.
- SLT paper source (missing): `/home/nitanda_sub/mark/repos/RMFLD/Statistical Learning Theory in Lean 4 Empirical Processes from Scratch`.
- First consult `SLT/EfronStein.lean` for conditional expectation/product-measure proof engineering.
- Consult `SLT/GaussianLSI/TensorizedGLSI.lean`, `SLT/GaussianMeasure.lean`, and `SLT/SmallBallProb.lean` for `Measure.map`, integral, product, and Bochner-style rewrites.
- Consult the SLT article LaTeX for the writing principle: expose measurable/topological hypotheses explicitly; do not promote background analysis until a local ASTIS declaration compiles.
- Do not add SLT as a Lake dependency while the toolchain mismatch remains; port local statements or record cited proof obligations.

## Blueprint Control State

- Stage: LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization
- Latest cycle: 131
- Dynamic leaf candidate: discharges-supplied-hypothesis reviewer acceptance: accepted SALD.generalMovingTargetDiscreteCanonicalBarBWeakConditionalFpNamedLawDerivativeOfEmIntervalMeasIntDominated; discharged hsampleInt from SALD.generalMovingTargetDiscreteCanonicalBarBWeakConditionalFpNamedLawDerivativeOfEmIntervalMeasDominated using named-law Measure.map integrability transport plus Mathlib Integrable.comp_aemeasurable/integrable_map_measure. Remaining hsampleDerivMeas hsampleDerivBound hboundInt hpathDeriv hderivValue and canonical source-action identities. Gate python3 tools/astis.py check passed; proof-diagnostics forbidden_hits=0; no wrapper churn, broad audit, non-EM fallback, SLT import, Lake/toolchain change, theorem-status promotion, fake closure, or sald_version_2.
- Illness area candidate: narrows-source-cited-boundary upper handoff queued: illness-area refiner packet selected for cycle130. Exact boundary: narrow `hlaplacianAction` in `SALD.generalMovingTargetDiscreteWeakConditionalFpDiffusionSourceOfLaplacianAction` to a source-cited weak Laplacian integration-by-parts interface for `appendix.tex:1379-1387`, keeping `hdiffusionAction` separate. Rejected repeating cycle129 direct `hdiffusionSource` continuation and all discharged sample/path/canonical leaves as wrapper churn. Gate `python3 tools/astis.py check` passed.
- Task blueprint: `research-wiki/blueprints/ASTIS-SALD-001.md`.
- Borrowed LeanMarathon controls: blueprint system-of-record, target review, dynamic leaves, illness-area refiner, deterministic gate.
- Preserved ASTIS controls: EoH candidate populations for exploratoryProof, LBG-style trial memory, ARIS/QBE upper-middle-lower-reviewer loops, auto-research-in-sleep long run, SDE/Sampling source anchors.

## Self-Reflection Guard

- Start the handoff with one packet classification from the allowed list.
- Name the exact supplied hypothesis discharged or the exact missing theorem boundary narrowed.
- State whether the packet is a dynamic-leaf worker packet or an illness-area refiner packet.
- State which local SLT/Mathlib files were consulted or why no consultation was needed.
- Reject broad source-index, route-audit, wrapper, or project-article work unless it directly closes the active blocker.
- Keep `python3 tools/astis.py check` as the mandatory gate.