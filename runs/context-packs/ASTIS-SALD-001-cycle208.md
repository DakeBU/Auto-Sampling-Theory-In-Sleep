# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `208`
- Generated: `2026-06-13 06:21:38`

## Compact Task Contract

# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-206 dynamic-leaf worker packet. Exact boundary narrowed: hRemainderGeneratorLimitDef -> hRemainderPullbackDef, recorded by compiled SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Obligation/Dag with typed feedback leaf=hRemainderPullbackDef error_class=source_contract_gap_missing_remainder_pullback_definition. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387 checked against original SALD source excluding sald_version_2.tex. Local ASTIS declarations only: existing SALD scalar-pushforward/Gaussian-law remainder bridges, TechnicalLemmas.SALDExtracted/Gaussian/Measure entries, and Mathlib MeasureTheory.integral_map. No external SLT import/call/queue, fake closure, wrapper churn, source-Hessian replay, selected-line Taylor replay, endpoint/naming replay, or theorem-status promotion. Remaining gap is the source-backed pullback definition of re...

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.

## Cycle Focus

Cycle-183+ closure sprint: freeze `hSourceHasHessian` and `hSourceHessianBound` as an explicit source-contract gap unless the original SALD source is found to state the selected weak-test Hessian regularity verbatim. Do not spend the cycle on wrapper projections, `testRegular` repackaging, VP score-Hessian substitution, or source-Hessian re-audits. The active proof work is the connected Brownian/Ito frozen-interpolation backend: first close or strictly narrow `hBrownianCoordinateGeneratorTaylorIntegralDef` and `hRemainderGeneratorLimitDef`; then connect the same local backend to the conditional-drift weak-Fokker--Planck line `appendix.tex:1379-1387`, the KL derivative handoff `appendix.tex:1358-1365`, and the divergence/FI/IBP rewrite `appendix.tex:1422-1434`. Lower_1 should write the natural-language classical proof route for exactly one ticket, and lower_2 should implement one compiled ASTIS-owned theorem or record one strictly smaller source-cited obligation with typed verifier feedback.

## Recent High-Signal Handoffs

- narrows-source-cited-boundary illness-area refiner packet: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp; source artifact middle_source_correspondence_conditional_weak_fp.md; local ASTIS law-map/condDistrib/weak-FP handoffs only; no SLT; gate passed.
- narrows-source-cited-boundary illness-area refiner packet: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Artifact runs/20260613-054827-700501-ASTIS-SALD-001-cycle207/middle_technical_lemma_conditional_weak_fp.md; SLT audit updated with no-slt status; compiled-local Measure/condDistrib/weak-FP handoffs only; no external SLT import/call/queue/port. Gate passed: python3 tools/astis.py check.
- narrows-source-cited-boundary illness-area report/export synchronization packet. Exact boundary for human-readable status: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp over appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387; cycle-206 hRemainderGeneratorLimitDef -> hRemainderPullbackDef remains a recorded source-contract gap, not a proved result. No broad export-latex or project-article rewrite during this inner proof-search cycle; cite only compil...
- narrows-source-cited-boundary illness-area refiner packet. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Artifact: runs/20260613-054827-700501-ASTIS-SALD-001-cycle207/middle_formalizer_conditional_weak_fp_handoff.md. lower_1 classical route; lower_2 one non-wrapper compiled theorem or typed feedback leaf=emInterpolationConditionalWeakFp error_class=source_contract_gap_missing_conditional_fp_generator_definition. Local ASTIS declarations only...
- narrows-source-cited-boundary reviewer_gate acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner; accepted only as obligation-level boundary narrowing, not as a proved Lean theorem and not as a lower_2 worker proof. Gate passed: python3 tools/astis.py check. Source anchors: appendix.tex:983-996;appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387. Canonical unfi...
- narrows-source-cited-boundary reviewer_waste acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner, obligation-level only; no lower_1/lower_2 artifact and no proved Lean theorem in cycle207. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:983-996;appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387 verified. Local compiled ASTIS TechnicalLe...

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
- Latest cycle: 207
- Dynamic leaf candidate: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-206 dynamic-leaf worker packet. Exact boundary narrowed: hRemainderGeneratorLimitDef -> hRemainderPullbackDef, recorded by compiled SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Obligation/Dag with typed feedback leaf=hRemainderPullbackDef error_class=source_contract_gap_missing_remainder_pullback_definition. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387 checked against original SALD source excluding sald_version_2.tex. Local ASTIS declarations only: existing SALD scalar-pushforward/Gaussian-law remainder bridges, TechnicalLemmas.SALDExtracted/Gaussian/Measure entries, and Mathlib MeasureTheory.integral_map. No external SLT import/call/queue, fake closure, wrapper churn, source-Hessian replay, selected-line Taylor replay, endpoint/naming replay, or theorem-status promotion. Remaining gap is the source-backed pullback definition of re...
- Illness area candidate: narrows-source-cited-boundary reviewer_waste acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner, obligation-level only; no lower_1/lower_2 artifact and no proved Lean theorem in cycle207. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:983-996;appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387 verified. Local compiled ASTIS TechnicalLemmas.Measure and SALD weak-FP/condDistrib handoffs only; no external SLT import/call/queue/port. Waste diagnosis: useful progress is retiring repeated hRemainderPullbackDef wrapper churn and selecting emInterpolationConditionalWeakFp; no formal proof progress occurred; next best leaf is lower_2 compiling one non-wrapper theorem for emInterpolationConditionalWeakFp or logging leaf=emInterpolationConditionalWeakFp error_class=source_contract_gap_missing_conditional_fp_generator_definition.
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