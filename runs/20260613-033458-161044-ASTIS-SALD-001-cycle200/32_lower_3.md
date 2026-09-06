Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 200
Role: lower_3
Base role: lower
Run directory: runs/20260613-033458-161044-ASTIS-SALD-001-cycle200

Mandatory gate:

```bash
python3 tools/astis.py check
```

Task contract:

```text
# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-196 dynamic-leaf worker packet. Exact boundary narrowed: hNormalizedRemainderBoundInt under normalizedCoordinateLaw phi x i is reduced by compiled SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound to hNormalizedRemainderBoundDef, namely remainderBound phi x i z = remainderBoundC phi x i * z ^ 2, plus the normalized scalar coordinate law. Mandatory gate passed: python3 tools/astis.py check. Confirmed export through AutoSamplingTheory.TechnicalLemmas.SALDExtracted and registry key sald.normalized-remainder-bound-int-quadratic; supporting local ASTIS lemma AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero with registry key gaussian.quadratic-bound-integrable compiles. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387 checked. Remaining leaves: hNormalizedRemainderBoundDef, hNormalizedRemainderBound/hNormalizedRemainderBoundInt source-definition backfill as applicable, Brownian/Ito weak-FP/KL/IBP ba...

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.
```

Cycle focus:

```text
Cycle-183+ closure sprint: freeze `hSourceHasHessian` and `hSourceHessianBound` as an explicit source-contract gap unless the original SALD source is found to state the selected weak-test Hessian regularity verbatim. Do not spend the cycle on wrapper projections, `testRegular` repackaging, VP score-Hessian substitution, or source-Hessian re-audits. The active proof work is the connected Brownian/Ito frozen-interpolation backend: first close or strictly narrow `hBrownianCoordinateGeneratorTaylorIntegralDef` and `hRemainderGeneratorLimitDef`; then connect the same local backend to the conditional-drift weak-Fokker--Planck line `appendix.tex:1379-1387`, the KL derivative handoff `appendix.tex:1358-1365`, and the divergence/FI/IBP rewrite `appendix.tex:1422-1434`. Lower_1 should write the natural-language classical proof route for exactly one ticket, and lower_2 should implement one compiled ASTIS-owned theorem or record one strictly smaller source-cited obligation with typed verifier feedback.
```

Recent trial memory:

```text
2026-06-13 03:33:55 reviewer_gate/build compiled gate=not-run :: Cycle 199 mandatory reviewer gate: python3 tools/astis.py check passed. Build completed successfully for lake build and Tests; ASTIS fake-proof scan passed.
2026-06-13 03:34:22 reviewer_gate/handoff queued gate=not-run :: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-199 dynamic-leaf worker packet. Exact boundary narrowed: hsourceLaplacianFieldMeas is reduced by compiled SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable to hSelectedTestLaplacianMeasurable; ancillary compiled SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous reduces...
2026-06-13 03:34:41 reviewer_gate/attempt accepted gate=not-run :: External agent command exit code 0. active_agent_seconds=143.6.
2026-06-13 03:34:52 reviewer/build compiled gate=pass :: Cycle build gate.
```

Compact context pack: `runs/20260613-033458-161044-ASTIS-SALD-001-cycle200/05_context_pack.md`

```text
# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `200`
- Generated: `2026-06-13 03:34:58`

## Compact Task Contract

# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-196 dynamic-leaf worker packet. Exact boundary narrowed: hNormalizedRemainderBoundInt under normalizedCoordinateLaw phi x i is reduced by compiled SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound to hNormalizedRemainderBoundDef, namely remainderBound phi x i z = remainderBoundC phi x i * z ^ 2, plus the normalized scalar coordinate law. Mandatory gate passed: python3 tools/astis.py check. Confirmed export through AutoSamplingTheory.TechnicalLemmas.SALDExtracted and registry key sald.normalized-remainder-bound-int-quadratic; supporting local ASTIS lemma AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero with registry key gaussian.quadratic-bound-integrable compiles. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387 checked. Remaining leaves: hNormalizedRemainderBoundDef, hNormalizedRemainderBound/hNormalizedRemainderBoundInt source-definition backfill as applicable, Brownian/Ito weak-FP/KL/IBP ba...

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.

## Cycle Focus

Cycle-183+ closure sprint: freeze `hSourceHasHessian` and `hSourceHessianBound` as an explicit source-contract gap unless the original SALD source is found to state the selected weak-test Hessian regularity verbatim. Do not spend the cycle on wrapper projections, `testRegular` repackaging, VP score-Hessian substitution, or source-Hessian re-audits. The active proof work is the connected Brownian/Ito frozen-interpolation backend: first close or strictly narrow `hBrownianCoordinateGeneratorTaylorIntegralDef` and `hRemainderGeneratorLimitDef`; then connect the same local backend to the conditional-drift weak-Fokker--Planck line `appendix.tex:1379-1387`, the KL derivative handoff `appendix.tex:1358-1365`, and the divergence/FI/IBP rewrite `appendix.tex:1422-1434`. Lower_1 should write the natural-language classical proof route for exactly one ticket, and lower_2 should implement one compiled ASTIS-owned theorem or record one strictly smaller source-cited obligation with typed verifier feedback.

## Recent High-Signal Handoffs

- narrows-source-cited-boundary dynamic-leaf worker packet; hsourceLaplacianFieldMeas narrowed by compiled SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable to hSelectedTestLaplacianMeasurable; source anchors appendix.tex:983-996 and appendix.tex:1379-1387; local Mathlib Measurable.aestronglyMeasurable only; no external SLT import/queue/formalization; gate passed python3 tools/astis.py check; artifacts middle_source_laplacian_meas_packet.md lower_1_source_laplacian_meas_rout...
- narrows-source-cited-boundary dynamic-leaf worker packet; compiled SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable reduces hsourceLaplacianFieldMeas to hSelectedTestLaplacianMeasurable over appendix.tex:983-996 and appendix.tex:1379-1387; gate passed with python3 tools/astis.py check; used Mathlib Measurable.aestronglyMeasurable only; no external SLT theorem imported, queued, or marked formalized.
- narrows-source-cited-boundary lower_3 retrieval packet for hsourceLaplacianFieldMeas -> hSelectedTestLaplacianMeasurable; artifact lower_3_source_laplacian_meas_retrieval.md; used SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable and Mathlib Measurable.aestronglyMeasurable; no SLT import/queue; mandatory gate passed.
- narrows-source-cited-boundary dynamic-leaf worker packet for hSelectedTestLaplacianMeasurable. Refined lower_1 route artifact names source anchors appendix.tex:983-996, appendix.tex:1379-1387, and theorem inheritance lines appendix.tex:1313-1316; no source line found in the audited packet that states selected-test Laplacian measurability. Lower_2 should prove hSelectedTestLaplacianMeasurable from a paper-backed hSelectedTestLaplacianContinuous via Continuous.measurable, or log source_contract_gap_missing_selecte...
- narrows-source-cited-boundary lower_3 compiled API bridge SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous, reducing hSelectedTestLaplacianMeasurable to hSelectedTestLaplacianContinuous via Mathlib Continuous.measurable; complements hsourceLaplacianFieldMeas -> hSelectedTestLaplacianMeasurable bridge; no SLT import/queue; lake env lean AutoSamplingTheory/SALD.lean and mandatory gate passed.
- narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-199 dynamic-leaf worker packet. Exact boundary narrowed: hsourceLaplacianFieldMeas is reduced by compiled SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable to hSelectedTestLaplacianMeasurable; ancillary compiled SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous reduces that to hSelectedTestLaplacianContinuous if source continuity exists. Mandatory gate passed: python...

## External SLT Provenance And Port Discipline

- External SLT clone for audited porting only (exists): `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/lean-stat-learning-theory`.
- External SLT paper source for exposition/provenance only (exists): `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Statistical Learning Theory in Lean 4 Empirical Processes from Scratch`.
- Do not use the SLT clone as a runtime dependency and do not tell agents to call upstream declarations directly.
- Any useful SLT theorem must become an ASTIS-owned compiled declaration under `AutoSamplingTheory/TechnicalLemmas` before it is callable.
- Port status/provenance remains recorded in `research-wiki/cited-results/SLT_reuse_audit.md`.

## ASTIS Technical Lemma Memory For This Task

- Technical lemma entry point: `research-wiki/technical-lemmas/README.md` (legacy mirror: `research-wiki/technical-lemma-memory/README.md`).
- Compiled local Lean modules: `AutoSamplingTheory/TechnicalLemmas/Gaussian.lean`, `AutoSamplingTheory/TechnicalLemmas/Taylor.lean`, `AutoSamplingTheory/TechnicalLemmas/Measure.lean`, `AutoSamplingTheory/TechnicalLemmas/Variational.lean`, `AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean`, and `AutoSamplingTheory/TechnicalLemmas/Registry.lean`.
- Local registry: `research-wiki/technical-lemmas/technical_lemma_registry.jsonl` (mirrored from legacy when needed).
- SALD map: `research-wiki/technical-lemmas/SALD_remaining_map.md`.
- Human TODO dashboard: `research-wiki/todo/SALD_REPRODUCTION_TODO.md`.
- Task-local SALD paper memory: `research-wiki/paper-contributions/SALD/unfinished_source_map.md` (legacy mirror: `research-wiki/paper-memory/ASTIS-SALD-001/unfinished_source_map.md`).
- Retrieval index: `research-wiki/retrieval-index/ASTIS-SALD-001.json`.
- Port queue: `research-wiki/technical-lemmas/SLT_port_queue.jsonl`; queue entries are not callable until ported locally.
- Separation rule: common prior knowledge lives here; SALD-specific theorem leaves and source line coverage live in paper memory.
- Current SALD priority: use ASTIS technical lemmas for the EM Brownian/Ito scalar generator backend before broad LSI/DV backfill.
- First local candidates: `TechnicalLemmas.Gaussian.map_eval_stdGaussianPi`, `TechnicalLemmas.Gaussian.nnrealVarianceOneOfGaussianRealUnitLaw`, and `TechnicalLemmas.Gaussian.realVarianceOneOfNNRealVarianceOne`.
- Second local candidates: `TechnicalLemmas.Taylor.hessianOpNormOfSourceHessianField`, `TechnicalLemmas.Taylor.iteratedFDerivTwoOpNormOfFDerivFDerivOpNorm`, and `TechnicalLemmas.Taylor.quadraticVariationNormalizationOfCoeffDefAndVarianceOne`.
- Current active leaves after cycle 181: `hBrownianCoordinateGeneratorTaylorIntegralDef`, `hRemainderGeneratorLimitDef`, concrete remainder measurability/domination, and coordinate-law/variance side leaves.
- Known source-contract gap: `hSourceHasHessian` and `hSourceHessianBound`; do not fake it via technical lemmas unless the original source supplies the fields.
- Deferred backends: `entropy_duality` for DV and `gaussian_logSobolev_W12_pi` for LSI are high-value port candidates, but only after they are implemented as local ASTIS declarations.

## Task-Local Paper Contribution Memory

- Canonical task-local paper contribution memory: `research-wiki/paper-contributions/SALD/`.
- Legacy mirror: `research-wiki/paper-memory/ASTIS-SALD-001/`.
- Unfinished source-line map: `research-wiki/paper-contributions/SALD/unfinished_source_map.md`.
- Paper memory stores VA-SALD-specific theorem/proof leaves, source line correspondence, and source-cited obligations.
- It must not store generic prior facts; those belong in `research-wiki/technical-lemmas/` and `AutoSamplingTheory/TechnicalLemmas/`.
- Upper reads compact context, blueprint, TODO, and unfinished map only; it must not replay long historical logs.
- Middle checks task-local paper memory plus TechnicalLemmas before assigning lower agents.
- Lower proves one compiled theorem or narrows one source-cited boundary.
- Reviewer checks Lean gate, concrete source-line coverage, and whether any called technical lemma is ASTIS-owned and compiled.

## Human TODO Dashboard

- Current human-readable SALD reproduction TODO: `research-wiki/todo/SALD_REPRODUCTION_TODO.md`.
- Current unfinished source-line map: `research-wiki/paper-contributions/SALD/unfinished_source_map.md`.
- Compact retrieval index for upper/middle: `research-wiki/retrieval-index/ASTIS-SALD-001.json`.

## Blueprint Control State

- Stage: LeanMarathon Stage-2 analogue: DAG-guided proof discharge after faithful source transcript stabilization
- Latest cycle: 199
- Dynamic leaf candidate: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-196 dynamic-leaf worker packet. Exact boundary narrowed: hNormalizedRemainderBoundInt under normalizedCoordinateLaw phi x i is reduced by compiled SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound to hNormalizedRemainderBoundDef, namely remainderBound phi x i z = remainderBoundC phi x i * z ^ 2, plus the normalized scalar coordinate law. Mandatory gate passed: python3 tools/astis.py check. Confirmed export through AutoSamplingTheory.TechnicalLemmas.SALDExtracted and registry key sald.normalized-remainder-bound-int-quadratic; supporting local ASTIS lemma AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero with registry key gaussian.quadratic-bound-integrable compiles. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387 checked. Remaining leaves: hNormalizedRemainderBoundDef, hNormalizedRemainderBound/hNormalizedRemainderBoundInt source-definition backfill as applicable, Brownian/Ito weak-FP/KL/IBP ba...
- Illness area candidate: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-199 dynamic-leaf worker packet. Exact boundary narrowed: hsourceLaplacianFieldMeas is reduced by compiled SALD.generalMovingTargetDiscreteSourceLaplacianFieldMeasOfSelectedTestLaplacianMeasurable to hSelectedTestLaplacianMeasurable; ancillary compiled SALD.generalMovingTargetDiscreteSelectedTestLaplacianMeasurableOfContinuous reduces that to hSelectedTestLaplacianContinuous if source continuity exists. Mandatory gate passed: python3 tools/astis.py check. Source anchors appendix.tex:983-996 and appendix.tex:1379-1387 checked; remaining source-facing leaf recorded in canonical and legacy paper memory. Used Mathlib Measurable.aestronglyMeasurable and Continuous.measurable only; no external SLT import/call/queue/formalization; no fake closures or theorem-status promotion.
- Task blueprint: `proof-blueprints/ASTIS-SALD-001.md` (legacy mirror: `research-wiki/blueprints/ASTIS-SALD-001.md`).
- Borrowed LeanMarathon controls: blueprint system-of-record, target review, dynamic leaves, illness-area refiner, deterministic gate.
- Preserved ASTIS controls: EoH candidate populations for exploratoryProof, LBG-style trial memory, ARIS/QBE upper-middle-lower-reviewer loops, auto-research-in-sleep long run, SDE/Sampling source anchors.

## Self-Reflection Guard

- Start the handoff with one packet classification from the allowed list.
- Name the exact supplied hypothesis discharged or the exact missing theorem boundary narrowed.
- State whether the packet is a dynamic-leaf worker packet or an illness-area refiner packet.
- State which local ASTIS technical lemmas/Mathlib files were used, or which external theorem was only queued for local porting.
- Reject broad source-index, route-audit, wrapper, or project-article work unless it directly closes the active blocker.
- Keep `python3 tools/astis.py check` as the mandatory gate.
```

Shared dialogue board: `runs/20260613-033458-161044-ASTIS-SALD-001-cycle200/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260613-033458-161044-ASTIS-SALD-001-cycle200 --role lower_3 --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower_3 --kind handoff --status queued --artifact runs/20260613-033458-161044-ASTIS-SALD-001-cycle200 --notes "..."
```

## Role Instructions

Attempt one narrow proof-producing Lean task for the assigned active backend before creating more ledger-only obligations. Do not change the theorem target. Work on exactly one compiled theorem/proof block or one strictly smaller source-cited boundary, and name the paper-memory source line or technical-lemma registry entry used. Begin by naming the packet classification and the exact supplied hypothesis or missing theorem boundary. If this is a worker-style packet, stay inside the assigned local target/refinement region before asking for upstream changes; if it is a refiner-style packet, edit only the connected illness area named by middle. Do not work on unrelated display algebra, route audits, or general API cleanup unless the upper/middle packet explicitly assigns it. After cycle 84, a new supplied-hypothesis wrapper is acceptable only if it removes an older supplied hypothesis, exposes a strictly smaller missing theorem boundary, or produces a compiled local theorem using Mathlib/ASTIS technical-lemma ingredients. Do not add fake proof closures; if the analysis fact is not formalized, add a precise source-cited interface or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them. For SALD cycle 130 and later, treat the cycle-129 illness-area boundary as the live target unless the reviewer records a newer one: `hdiffusionSource` has been narrowed to the EM/Brownian diffusion generator weak action plus weak Laplacian integration-by-parts action. Do not reassign already-discharged leaves `hsampleInt`, `hsampleDerivMeas`, `hsampleDerivBound`, `hboundInt`, `hpathDeriv`, `hderivValue`, `hdriftBarBAction`, raw `hpairMeas`, or `hcanonicalBarBMeas`. For SALD cycle 151 and later, the reviewer-accepted cycle-150 boundary overrides older broad guards. The active EM conditional-law / weak-FP backend remains `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`, with source anchors `appendix.tex:984-995`, `appendix.tex:1368-1387`, and `appendix.tex:1379-1387`. Prioritize one direct definition/equality leaf at a time: `htraceFieldEqLaplacian`, `hemGeneratorLaplacianEventFieldEqTraceField`, `hemGeneratorLaplacianStateIntegral`, or `hsourceLaplacianFieldMeas`. Upper should choose the smallest leaf that reduces this boundary; middle should coordinate the proof route and split lower-agent roles; lower_1 should produce the natural-language/math route and lower_2 should implement exactly one compiled Lean theorem or a strictly smaller source-cited obligation. Reject new total-event/source-functional consumer wrappers unless they discharge one of these direct leaves. Reviewer must check that the remaining boundary is strictly smaller, not merely renamed, and that `python3 tools/astis.py check` passes. For SALD cycle 174 and later, the reviewer-accepted cycle-173 boundary overrides the older cycle-150 direct-leaf list. The active target is still the EM conditional-law / weak-FP Brownian/Ito backend, but the immediate live leaf is now the source-Hessian contract behind `SALD.selectedWeakTestHessianOpNormOfSourceHessianField`: `hSourceHasHessian : forall z, HasFDerivAt (fderiv Real sourceTest) (sourceHessian z) z` and `hSourceHessianBound : forall z, norm (sourceHessian z) <= C1`. Upper must decide whether these fields are paper assumptions or can be derived from selected-test regularity; middle must translate that decision into a single Lean theorem/proof-obligation with source anchors; lower_1 should give the natural-language Mathlib route, using ASTIS `TechnicalLemmas` first and external SLT Taylor/DCT/measure files only as port references; lower_2 should implement exactly one compiled theorem or strictly smaller source-cited boundary. Reject routes that define `sourceHessian` from the desired conclusion, reintroduce `SelectedWeakTestC2bBoundedHessian` without source support, use VP score-Hessian regularity for the selected weak test, import SLT as a dependency, call upstream SLT declarations directly, or return to consumer-wrapper churn. If the source-Hessian fields are confirmed absent from the paper source, keep the gap honest and move only to the next connected Brownian/Ito leaf: selected-line Taylor domination, Gaussian dominated-convergence integrability, quadratic-variation normalization, or per-coordinate Hessian generator identity. For SALD cycle 183 and later, the source-Hessian fields `hSourceHasHessian` and `hSourceHessianBound` are no longer an active proof target unless the original SALD source explicitly supplies the selected weak-test Hessian regularity. Treat them as a documented source-contract gap and move proof effort to the Brownian/Ito frozen backend tickets: `hBrownianCoordinateGeneratorTaylorIntegralDef`, `hRemainderGeneratorLimitDef`, conditional-drift weak-FP, KL derivative, and divergence/FI/IBP handoff. Reject source-Hessian wrapper churn, `testRegular` repackaging, VP score-Hessian substitution, direct SLT dependency use, or broad theorem-route replay.

Parallel lower specialization: you are the technical-lemma/API scout. Work only when middle_technical_lemma or middle_formalizer identifies a missing background fact. Search local ASTIS declarations and Mathlib/SLT provenance, then either port one tiny ASTIS-owned lemma that compiles or record a precise ProofObligation with the exact source and use site. In parallel-lower runs, prefer a run-local retrieval packet or isolated TechnicalLemmas edit; avoid editing the same SALD theorem block that lower_2 is likely to touch. Do not attack the root SALD theorem directly.
