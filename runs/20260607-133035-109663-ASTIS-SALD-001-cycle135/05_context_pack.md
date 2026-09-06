# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `135`
- Generated: `2026-06-07 13:30:35`

## Compact Task Contract

# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
Remaining boundary: prove htestLaplacianOperator and the still-explicit second-Green/box-divergence/test-trace/diffusion leaves.

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.

## Cycle Focus

Blueprint-guided dynamic leaf: use `python3 tools/astis.py blueprint-refresh ASTIS-SALD-001` and target the refreshed dynamic leaf / illness area rather than the old rotating focus. Current blocker: Remaining boundary: prove htestLaplacianOperator and the still-explicit second-Green/box-divergence/test-trace/diffusion leaves.. For the current SALD state this means stay on the EM conditional-drift/state-event set-integral boundary unless reviewer records a named Mathlib/theory gap; do not take a non-EM fallback merely because the old cycle schedule rotates there.

## Recent High-Signal Handoffs

- narrows-source-cited-boundary reviewer acceptance: accepted cycle133 illness-area chain; htestTraceZero -> htestTracePointwiseZero, broad htestLaplacian -> htestLaplacianLocal, and htestLaplacianLocal -> htestLaplacianOperator via SALD.generalMovingTargetDiscreteTestLaplacianLocalOfOperatorNormalization. Gate python3 tools/astis.py check passed; proof-diagnostics forbidden_hits=0; no wrapper churn, broad audit, non-EM fallback, SLT import, Lake/toolchain change, theorem-status promotion, fake closure, source-ind...
- narrows-source-cited-boundary upper handoff queued: dynamic-leaf worker packet selected for cycle 134. Exact boundary: remove or strictly narrow `htestLaplacianOperator : testRegular -> testLaplacianAction = laplacian` left by `SALD.generalMovingTargetDiscreteTestLaplacianLocalOfOperatorNormalization`, targeting the EM conditional-law/Fokker--Planck backend `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387` and the test-calculus source window `appendix.tex:1379-1427`. Lower m...
- narrows-source-cited-boundary dynamic-leaf worker packet: compiled source-pullback normalization helper and downstream second-Green consumer; htestLaplacianOperator narrowed to htestLaplacianActionDef plus hweakFpLaplacianDef over appendix.tex:1379-1427. Gate python3 tools/astis.py check passed; no SLT import, non-EM fallback, wrapper churn, broad audit, Lake/toolchain change, theorem-status promotion, fake closure, or sald_version_2 use.
- lower_1 narrows-source-cited-boundary dynamic-leaf proof scout compiled SALD.generalMovingTargetDiscreteSourceTestLaplacianEqStdIteratedFDeriv; htestLaplacianActionDef/hweakFpLaplacianDef narrowed to Mathlib Laplacian standard-basis second-derivative source normalization over appendix.tex:1379-1427; gate python3 tools/astis.py check passed; lower_2 next prove hweakFpLaplacianDef or htestLaplacianActionDef by instantiating sourceLaplacianAction as Mathlib Laplacian on selected weak-test representation; no SLT imp...
- lower_2 narrows-source-cited-boundary dynamic-leaf worker packet compiled SALD.generalMovingTargetDiscreteWeakFpLaplacianDefOfStdBasisSourceFormula, narrowing hweakFpLaplacianDef to hweakFpStdBasisDef over appendix.tex:1379-1427; gate python3 tools/astis.py check passed; no SLT import, wrapper churn, broad audit, non-EM fallback, fake closure, theorem-status promotion, Lake/toolchain change, or sald_version_2 use.
- narrows-source-cited-boundary reviewer acceptance: cycle134 dynamic leaf accepted; hweakFpLaplacianDef narrowed to hweakFpStdBasisDef through SALD.generalMovingTargetDiscreteWeakFpLaplacianDefOfStdBasisSourceFormula. Gate python3 tools/astis.py check passed; proof-diagnostics forbidden_hits=0; source-index refreshed with no sald_version_2 hit; no wrapper churn, non-EM fallback, broad audit, SLT import, Lake/toolchain change, theorem-status promotion, or fake closure.

## Local SLT And Paper Reuse

- SLT local project (missing): `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory`.
- SLT paper source (missing): `/home/nitanda_sub/mark/repos/RMFLD/Statistical Learning Theory in Lean 4 Empirical Processes from Scratch`.
- First consult `SLT/EfronStein.lean` for conditional expectation/product-measure proof engineering.
- Consult `SLT/GaussianLSI/TensorizedGLSI.lean`, `SLT/GaussianMeasure.lean`, and `SLT/SmallBallProb.lean` for `Measure.map`, integral, product, and Bochner-style rewrites.
- Consult the SLT article LaTeX for the writing principle: expose measurable/topological hypotheses explicitly; do not promote background analysis until a local ASTIS declaration compiles.
- Do not add SLT as a Lake dependency while the toolchain mismatch remains; port local statements or record cited proof obligations.

## Blueprint Control State

- Stage: LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization
- Latest cycle: 134
- Dynamic leaf candidate: Remaining boundary: prove htestLaplacianOperator and the still-explicit second-Green/box-divergence/test-trace/diffusion leaves.
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