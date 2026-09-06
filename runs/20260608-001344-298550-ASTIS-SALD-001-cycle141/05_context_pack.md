# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `141`
- Generated: `2026-06-08 00:13:44`

## Compact Task Contract

# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
Remaining exact boundary: prove hlaplacianEqEmGenerator, hemGeneratorSourceActionDef, hweakFpSourceFieldEqLaplacian, hsourceLaplacianFieldMeas, hsourceLaplacianFunctional, htestLaplacianStdBasisDef, density-Laplacian source facts, Green/trace/box-divergence leaves, and diffusion leaves.

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.

## Cycle Focus

Blueprint-guided dynamic leaf: use `python3 tools/astis.py blueprint-refresh ASTIS-SALD-001` and target the refreshed dynamic leaf / illness area rather than the old rotating focus. Current blocker: Remaining exact boundary: prove hlaplacianEqEmGenerator, hemGeneratorSourceActionDef, hweakFpSourceFieldEqLaplacian, hsourceLaplacianFieldMeas, hsourceLaplacianFunctional, htestLaplacianStdBasisDef, density-Laplacian source facts, Green/trace/box-divergence leaves, and diffusion leaves.. For the current SALD state this means stay on the EM conditional-drift/state-event set-integral boundary unless reviewer records a named Mathlib/theory gap; do not take a non-EM fallback merely because the old cycle schedule rotates there.

## Recent High-Signal Handoffs

- narrows-source-cited-boundary reviewer acceptance after mandatory gate. Cycle 139 dynamic-leaf packet narrows hweakFpLaplacianDef to hweakFpSourceActionDef plus hweakFpSourceFieldEqLaplacian, and further narrows hweakFpSourceActionDef to EM map-law/source-functional/measurability/state-integral leaves via the compiled state-integral bridges. Gate python3 tools/astis.py check passed; proof-diagnostics forbidden_hits=0; no SLT import, htestLaplacianOperator reintroduction, circular hweakFpStdBasisDef/hweakFpDensit...
- narrows-source-cited-boundary upper handoff queued: illness-area refiner selects hlaplacianSourceStateIntegral under SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfSourceLaplacianStateIntegral; lower should narrow it to an EM frozen-interpolation weak-generator/state-integral source fact over appendix.tex:984-995 and appendix.tex:1379-1387 while keeping hweakFpSourceFieldEqLaplacian, hsourceLaplacianFieldMeas, htestLaplacianStdBasisDef, density-Laplacian, Green/trace/box-divergence, and diffusion leaves...
- narrows-source-cited-boundary; illness-area refiner narrowed hlaplacianSourceStateIntegral to hlaplacianEqEmGenerator plus hemGeneratorStateIntegral via compiled SALD.generalMovingTargetDiscreteLaplacianSourceStateIntegralOfEmGeneratorStateIntegral and SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfEmGeneratorStateIntegral; gate python3 tools/astis.py check passed; no SLT import, non-EM fallback, wrapper churn, theorem-status promotion, fake closure, broad audit, or sald_version_2 use.
- lower_1 narrows-source-cited-boundary packet: compiled SALD.generalMovingTargetDiscreteEmGeneratorLaplacianStateIntegralOfLawIntegral and SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfEmGeneratorLawIntegral, narrowing hemGeneratorStateIntegral to law-space hemGeneratorLawIntegral plus map-law integral_map transport. Lower_2 next target: prove hemGeneratorLawIntegral for the frozen EM generator Laplacian action over appendix.tex:984-995 and appendix.tex:1379-1387. Gate python3 tools/astis.py check passed.
- lower_2: narrows-source-cited-boundary illness-area packet. Compiled SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfEmGeneratorSourceFunctional, narrowing hemGeneratorLawIntegral to hemGeneratorSourceActionDef plus hsourceLaplacianFunctional. Gate python3 tools/astis.py check passed; proof-diagnostics forbidden_hits=0; no SLT import, wrapper churn, non-EM fallback, or theorem-status promotion.
- narrows-source-cited-boundary reviewer acceptance after mandatory gate. Cycle 140 illness-area packet narrows hlaplacianSourceStateIntegral to hlaplacianEqEmGenerator plus hemGeneratorSourceActionDef through the compiled EM generator law/source-functional bridges. Gate python3 tools/astis.py check passed; proof-diagnostics forbidden_hits=0; no SLT import, non-EM fallback, wrapper churn, broad route audit, theorem-status promotion, Lake/toolchain change, sald_version_2 use, or fake closure. Remaining exact bounda...

## Local SLT And Paper Reuse

- SLT local project (missing): `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory`.
- SLT paper source (missing): `/home/nitanda_sub/mark/repos/RMFLD/Statistical Learning Theory in Lean 4 Empirical Processes from Scratch`.
- First consult `SLT/EfronStein.lean` for conditional expectation/product-measure proof engineering.
- Consult `SLT/GaussianLSI/TensorizedGLSI.lean`, `SLT/GaussianMeasure.lean`, and `SLT/SmallBallProb.lean` for `Measure.map`, integral, product, and Bochner-style rewrites.
- Consult the SLT article LaTeX for the writing principle: expose measurable/topological hypotheses explicitly; do not promote background analysis until a local ASTIS declaration compiles.
- Do not add SLT as a Lake dependency while the toolchain mismatch remains; port local statements or record cited proof obligations.

## Blueprint Control State

- Stage: LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization
- Latest cycle: 140
- Dynamic leaf candidate: Remaining exact boundary: prove hlaplacianEqEmGenerator, hemGeneratorSourceActionDef, hweakFpSourceFieldEqLaplacian, hsourceLaplacianFieldMeas, hsourceLaplacianFunctional, htestLaplacianStdBasisDef, density-Laplacian source facts, Green/trace/box-divergence leaves, and diffusion leaves.
- Illness area candidate: lower_1 narrows-source-cited-boundary packet: compiled SALD.generalMovingTargetDiscreteEmGeneratorLaplacianStateIntegralOfLawIntegral and SALD.generalMovingTargetDiscreteWeakFpSourceActionDefOfEmGeneratorLawIntegral, narrowing hemGeneratorStateIntegral to law-space hemGeneratorLawIntegral plus map-law integral_map transport. Lower_2 next target: prove hemGeneratorLawIntegral for the frozen EM generator Laplacian action over appendix.tex:984-995 and appendix.tex:1379-1387. Gate python3 tools/astis.py check passed.
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