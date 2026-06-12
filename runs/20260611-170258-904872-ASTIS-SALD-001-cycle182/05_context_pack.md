# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `182`
- Generated: `2026-06-11 17:02:58`

## Compact Task Contract

# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-180 dynamic-leaf worker packet. hRemainderInt discharged by compiled SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder from hRemainderMeas/hRemainderBound/hRemainderBoundInt; hLinearInt and hQuadraticInt also discharged by Gaussian polynomial integrability. Remaining exact Taylor-integral source boundary hBrownianCoordinateGeneratorTaylorIntegralDef plus hRemainderGeneratorLimitDef with hRemainderMeas/hRemainderBound/hRemainderBoundInt explicit; hSourceHasHessian/hSourceHessianBound remain source-contract gaps. No SLT import/use, wrapper churn, VP score-Hessian substitution, sigma_eta^2/2 event-field move, fake closure, non-EM fallback, or sald_version_2 use. Gate passed: python3 tools/astis.py check.

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.

## Cycle Focus

Post-cycle-173 source-Hessian leaf: stay on `sald.general_moving_target_discrete.em_interpolation_fp` and discharge or strictly narrow the two source-facing selected weak-test Hessian fields left by `SALD.selectedWeakTestHessianOpNormOfSourceHessianField`: `hSourceHasHessian : forall z, HasFDerivAt (fderiv Real sourceTest) (sourceHessian z) z` and `hSourceHessianBound : forall z, norm (sourceHessian z) <= C1`. Upper/middle must first decide whether these fields are genuine source assumptions or derivable from the selected-test regularity used by the EM Brownian/Ito weak action. If derivable, lower_1 writes the natural-language Mathlib route and lower_2 implements exactly one compiled theorem. If not derivable from the paper source, record the gap honestly and move to the next real leaf in the same Brownian/Ito chain: selected-line Taylor domination, Gaussian DCT integrability, quadratic-variation normalization, or per-coordinate Hessian generator identity. Do not return to older `htraceFieldEqLaplacian`/consumer-wrapper targets unless this Hessian leaf is closed or reviewer records a strict dependency.

## Recent High-Signal Handoffs

- narrows-source-cited-boundary upper handoff after gate pass: hSourceHasHessian/hSourceHessianBound remain source-contract gaps; next dynamic-leaf packet targets hFrozenScalarBrownianItoTaylorMomentDecomposition via scalar Gaussian Taylor moment split, with hScalarLineTaylorCoeffDef, variance law fields, normalized-remainder, coordinate-sum, and Hessian gaps explicit; no SLT import, VP score-Hessian substitution, sigma_eta^2/2 event-field move, htraceFieldEqLaplacian/consumer-wrapper churn, theorem-status promoti...
- narrows-source-cited-boundary middle dynamic-leaf packet after gate pass: compiled SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefs, narrowing hFrozenScalarBrownianItoTaylorMomentDecomposition to hBrownianCoordinateGeneratorTaylorIntegralDef plus hLinearInt/hQuadraticInt/hRemainderInt and hRemainderGeneratorLimitDef; Hessian fields remain source-contract gaps; no SLT import/use, wrapper churn, VP score-Hessian substitution, sigma_eta^2/2 event-field move, or sald_version_2 use;...
- lower_1 recorded as lower because astis.py rejects lower_1. discharges-supplied-hypothesis lower_1 packet: compiled Gaussian polynomial-integrability bridge discharging hLinearInt and hQuadraticInt; remaining boundary hBrownianCoordinateGeneratorTaylorIntegralDef + hRemainderInt + hRemainderGeneratorLimitDef; gate passed python3 tools/astis.py check.
- lower_2 recorded as lower because astis.py rejects lower_2. discharges-supplied-hypothesis lower_2 packet: compiled SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder discharging hRemainderInt via MeasureTheory.Integrable.mono' from hRemainderMeas/hRemainderBound/hRemainderBoundInt; remaining boundary hBrownianCoordinateGeneratorTaylorIntegralDef + hRemainderGeneratorLimitDef plus concrete remainder meas/domination package; gate passed python3 tools/astis.py...
- discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-180 dynamic-leaf worker packet. hRemainderInt discharged by compiled SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder from hRemainderMeas/hRemainderBound/hRemainderBoundInt; hLinearInt and hQuadraticInt also discharged by Gaussian polynomial integrability. Remaining exact Taylor-integral source boundary hBrownianCoordinateGeneratorTaylorIntegralDef plus hRemainderGeneratorLim...
- narrows-source-cited-boundary upper handoff after gate pass: source-Hessian fields remain source-contract gaps after original-source recheck; next dynamic-leaf worker packet narrows hBrownianCoordinateGeneratorTaylorIntegralDef to a source-integral definition plus a.e. scalar Taylor integrand equality using MeasureTheory.integral_congr_ae. hRemainderGeneratorLimitDef and normalized-remainder measurability/domination remain explicit. No SLT import/use, wrapper churn, VP score-Hessian substitution, sigma_eta^2/2 e...

## Local SLT And Paper Reuse

- SLT local project (exists): `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/lean-stat-learning-theory`.
- SLT paper source (exists): `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Statistical Learning Theory in Lean 4 Empirical Processes from Scratch`.
- Agent memory: `research-wiki/agent-memory/SLT_memory_index.md`.
- SALD map: `research-wiki/agent-memory/SLT_to_SALD_remaining_map.md`.
- Port queue: `research-wiki/agent-memory/SLT_port_queue.jsonl`.
- First consult `SLT/EfronStein.lean` for conditional expectation/product-measure proof engineering.
- Consult `SLT/GaussianLSI/TensorizedGLSI.lean`, `SLT/GaussianMeasure.lean`, and `SLT/SmallBallProb.lean` for `Measure.map`, integral, product, and Bochner-style rewrites.
- Consult the SLT article LaTeX for the writing principle: expose measurable/topological hypotheses explicitly; do not promote background analysis until a local ASTIS declaration compiles.
- Do not add SLT as a Lake dependency while the toolchain mismatch remains; port local statements or record cited proof obligations.

## SLT Agent Memory For This Task

- Current SALD priority: use SLT memory for the EM Brownian/Ito scalar generator backend before broad LSI/DV backfill.
- First-port candidate: `SLT/GaussianMeasure.lean` for coordinate laws, variance, and Gaussian polynomial integrability.
- Second-port candidate: `SLT/GaussianPoincare/TaylorBound.lean` for scalar Taylor identities, bounded second derivative, and remainder bounds.
- Current active leaves after cycle 181: `hBrownianCoordinateGeneratorTaylorIntegralDef`, `hRemainderGeneratorLimitDef`, concrete remainder measurability/domination, and coordinate-law/variance side leaves.
- Known source-contract gap: `hSourceHasHessian` and `hSourceHessianBound`; do not fake it via SLT unless a local ASTIS theorem proves stronger selected-test regularity.
- Deferred backends: `entropy_duality` for DV and `gaussian_logSobolev_W12_pi` for LSI are high-value ports, but only after the active Brownian/Ito backend stops being the dynamic leaf.

## Blueprint Control State

- Stage: LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization
- Latest cycle: 181
- Dynamic leaf candidate: discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-180 dynamic-leaf worker packet. hRemainderInt discharged by compiled SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder from hRemainderMeas/hRemainderBound/hRemainderBoundInt; hLinearInt and hQuadraticInt also discharged by Gaussian polynomial integrability. Remaining exact Taylor-integral source boundary hBrownianCoordinateGeneratorTaylorIntegralDef plus hRemainderGeneratorLimitDef with hRemainderMeas/hRemainderBound/hRemainderBoundInt explicit; hSourceHasHessian/hSourceHessianBound remain source-contract gaps. No SLT import/use, wrapper churn, VP score-Hessian substitution, sigma_eta^2/2 event-field move, fake closure, non-EM fallback, or sald_version_2 use. Gate passed: python3 tools/astis.py check.
- Illness area candidate: narrows-source-cited-boundary upper dynamic-leaf worker packet after gate pass: hSourceHasHessian/hSourceHessianBound remain source-contract gaps after rechecking appendix.tex:984-995, appendix.tex:1026-1072, appendix.tex:1170-1176, appendix.tex:1379-1387, main_body.tex:273-305, and iteration_complexity.tex:309-321 excluding sald_version_2.tex; next lower packet targets hScalarLineSecondCoeffDef as the connected per-coordinate Hessian generator identity, with variance-side hNormalizedVectorLaw/hCoordinateLawDef/hVarianceDef, hSecondCoeff, DCT data, coordinate-sum, and Hessian gaps explicit; no SLT import, wrapper churn, VP score-Hessian substitution, theorem-status promotion, or direct variance composition wrapper; gate passed: python3 tools/astis.py check.
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