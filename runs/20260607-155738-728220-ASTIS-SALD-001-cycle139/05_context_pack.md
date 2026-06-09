# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `139`
- Generated: `2026-06-07 15:57:38`

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

- narrows-source-cited-boundary reviewer acceptance after mandatory gate. hweakFpDensityLaplacianAction narrowed to pointwise weak Laplacian IBP; pointwise IBP split into first-Green/second-Green/test-Laplacian pointwise leaves; hsecondGreenPointwise narrowed to residual/divergence, box-divergence, signed-face trace, pointwise trace equality, and pointwise zero trace. Gate python3 tools/astis.py check passed; proof-diagnostics forbidden_hits=0; no SLT import, wrapper churn, non-EM fallback, theorem-status promotio...
- narrows-source-cited-boundary upper handoff queued: dynamic-leaf worker packet selects hfirstGreenPointwise in SALD.generalMovingTargetDiscreteWeakFpStdBasisDefOfPointwiseGreenSecondGreenBoxBoundaryFlux; lower should narrow it to pointwise first-Green residual/divergence/zero-boundary facts over appendix.tex:1379-1427, keeping htestLaplacianPointwise, density/source formulas, second-Green box/trace leaves, and diffusion leaves explicit. Gate python3 tools/astis.py check passed; no SLT import, wrapper churn, non-...
- narrows-source-cited-boundary dynamic-leaf worker packet: hfirstGreenPointwise narrowed to hfirstGreenResidual plus hfirstGreenDivergence plus hfirstGreenZeroBoundary; compiled SALD.generalMovingTargetDiscreteFirstGreenPointwiseOfBoundaryFluxZero and SALD.generalMovingTargetDiscreteWeakFpStdBasisDefOfFirstGreenBoundaryFluxAndSecondGreenBoxBoundaryFlux; conversion window, proof obligations, SLT audit, and dependency list updated; gate python3 tools/astis.py check passed.
- lower_1 narrows-source-cited-boundary dynamic-leaf worker packet: compiled SALD.generalMovingTargetDiscreteTestLaplacianPointwiseOfSourcePullback, narrowing htestLaplacianPointwise to htestLaplacianActionDef plus hweakFpLaplacianDef over appendix.tex:1379-1427; lower_2 next should instantiate those source definitions non-circularly; no SLT import; python3 tools/astis.py check passed.
- lower_2 narrows-source-cited-boundary handoff: compiled SALD.generalMovingTargetDiscreteTestLaplacianPointwiseOfTestStdBasisSourceFormula; htestLaplacianActionDef side narrowed to htestLaplacianStdBasisDef while hweakFpLaplacianDef remains explicit non-circular source boundary; gate python3 tools/astis.py check passed.
- narrows-source-cited-boundary reviewer acceptance after mandatory gate. Cycle 138 narrows hfirstGreenPointwise to residual/divergence/zero-boundary facts; narrows htestLaplacianPointwise to source pullback facts; narrows htestLaplacianActionDef side to htestLaplacianStdBasisDef while keeping hweakFpLaplacianDef non-circular and explicit. Gate passed; proof-diagnostics forbidden_hits=0; no SLT import, wrapper churn, non-EM fallback, broad audit, or theorem-status promotion.

## Local SLT And Paper Reuse

- SLT local project (missing): `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory`.
- SLT paper source (missing): `/home/nitanda_sub/mark/repos/RMFLD/Statistical Learning Theory in Lean 4 Empirical Processes from Scratch`.
- First consult `SLT/EfronStein.lean` for conditional expectation/product-measure proof engineering.
- Consult `SLT/GaussianLSI/TensorizedGLSI.lean`, `SLT/GaussianMeasure.lean`, and `SLT/SmallBallProb.lean` for `Measure.map`, integral, product, and Bochner-style rewrites.
- Consult the SLT article LaTeX for the writing principle: expose measurable/topological hypotheses explicitly; do not promote background analysis until a local ASTIS declaration compiles.
- Do not add SLT as a Lake dependency while the toolchain mismatch remains; port local statements or record cited proof obligations.

## Blueprint Control State

- Stage: LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization
- Latest cycle: 138
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