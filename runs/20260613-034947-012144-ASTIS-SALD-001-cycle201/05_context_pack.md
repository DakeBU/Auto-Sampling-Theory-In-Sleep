# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `201`
- Generated: `2026-06-13 03:49:47`

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

- rejected-wrapper-churn dynamic-leaf worker packet: hNormalizedRemainderBoundDef replay rejected because cycle 197 already records the exact source-contract gap and cycle 196 already provides SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound plus local Gaussian quadratic-bound integrability. Artifact middle_remainder_bound_def_churn_rejection_packet.md. Gate passed: python3 tools/astis.py check.
- rejected-wrapper-churn dynamic-leaf worker packet: no new original-paper source line for hNormalizedRemainderBoundDef; reuse existing cycle-197 compiled ProofObligation rather than adding same-shape wrapper. Gate passed: python3 tools/astis.py check.
- rejected-wrapper-churn dynamic-leaf worker packet; leaf=hNormalizedRemainderBoundDef; error_class=no_new_local_api_gap_rejected_wrapper_churn; existing_obligation=SALD.cycle197GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoNormalizedRemainderBoundDefLower2Obligation; existing_registry=sald.normalized-remainder-bound-int-quadratic;gaussian.quadratic-bound-integrable; source search excluding sald_version_2.tex found no remainderBound/remainderBoundC definition; no SLT import/call/q...
- rejected-wrapper-churn dynamic-leaf worker packet; hNormalizedRemainderBoundDef source audit found no original SALD source line excluding sald_version_2.tex for remainderBound phi x i z = remainderBoundC phi x i * z ^ 2; existing cycle-197 obligation remains the correct typed boundary; artifact runs/20260613-033458-161044-ASTIS-SALD-001-cycle200/lower_1_remainder_bound_def_source_audit.md; gate passed python3 tools/astis.py check
- typed feedback for lower_1 rejected-wrapper-churn source audit; no original SALD source line excluding sald_version_2.tex states hNormalizedRemainderBoundDef; artifact runs/20260613-033458-161044-ASTIS-SALD-001-cycle200/lower_1_remainder_bound_def_source_audit.md; gate passed python3 tools/astis.py check
- rejected-wrapper-churn reviewer acceptance after gate pass: accepted cycle-200 dynamic-leaf worker packet as a rejection, not new formal theorem progress. Gate passed: python3 tools/astis.py check completed lake build, lake build Tests, and ASTIS fake-proof scan. Exact stale boundary: hNormalizedRemainderBoundDef, remainderBound phi x i z = remainderBoundC phi x i * z ^ 2, already recorded by SALD.cycle197GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoNormalizedRemainderBoundDefL...

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
- Latest cycle: 200
- Dynamic leaf candidate: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-196 dynamic-leaf worker packet. Exact boundary narrowed: hNormalizedRemainderBoundInt under normalizedCoordinateLaw phi x i is reduced by compiled SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound to hNormalizedRemainderBoundDef, namely remainderBound phi x i z = remainderBoundC phi x i * z ^ 2, plus the normalized scalar coordinate law. Mandatory gate passed: python3 tools/astis.py check. Confirmed export through AutoSamplingTheory.TechnicalLemmas.SALDExtracted and registry key sald.normalized-remainder-bound-int-quadratic; supporting local ASTIS lemma AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero with registry key gaussian.quadratic-bound-integrable compiles. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387 checked. Remaining leaves: hNormalizedRemainderBoundDef, hNormalizedRemainderBound/hNormalizedRemainderBoundInt source-definition backfill as applicable, Brownian/Ito weak-FP/KL/IBP ba...
- Illness area candidate: narrows-source-cited-boundary dynamic-leaf worker packet; Global phase judgment: cycle 199 passed, no recovery needed, Phase 1 skeleton stable, next risk-reducing packet is hNormalizedRemainderBoundDef for the frozen Brownian/Ito normalized-remainder backend feeding sald.general_moving_target_discrete.em_interpolation_fp over appendix.tex:1358-1387. Exact missing theorem boundary narrowed: prove or source-cite remainderBound phi x i z = remainderBoundC phi x i * z ^ 2 so compiled SALD.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound can reduce hNormalizedRemainderBoundInt without wrapper churn. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387. Allowed local ingredients: AutoSamplingTheory.TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound and AutoSamplingTheory.TechnicalLemmas.Gaussian.integrable_const_mul_sq_gaussianReal_zero; no external SLT import/call/queue/formalization. Reviewer must require python3 tools/astis.py check, concrete source-line coverage, no fake closures,...
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