Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 207
Role: upper_source_math
Base role: upper
Run directory: runs/20260613-054827-700501-ASTIS-SALD-001-cycle207

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
narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-206 dynamic-leaf worker packet. Exact boundary narrowed: hRemainderGeneratorLimitDef -> hRemainderPullbackDef, recorded by compiled SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Obligation/Dag with typed feedback leaf=hRemainderPullbackDef error_class=source_contract_gap_missing_remainder_pullback_definition. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387 checked against original SALD source excluding sald_version_2.tex. Local ASTIS declarations only: existing SALD scalar-pushforward/Gaussian-law remainder bridges, TechnicalLemmas.SALDExtracted/Gaussian/Measure entries, and Mathlib MeasureTheory.integral_map. No external SLT import/call/queue, fake closure, wrapper churn, source-Hessian replay, selected-line Taylor replay, endpoint/naming replay, or theorem-status promotion. Remaining gap is the source-backed pullback definition of re...

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
2026-06-13 05:46:51 reviewer_gate/handoff queued gate=pass :: 
2026-06-13 05:47:06 reviewer_gate/handoff queued gate=pass :: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-206 dynamic-leaf worker packet. Exact boundary narrowed: hRemainderGeneratorLimitDef -> hRemainderPullbackDef, recorded by compiled SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Obligation/Dag; not claimed proved. Gate passed: python3 tools/astis.py check. Source a...
2026-06-13 05:48:10 reviewer_gate/attempt accepted gate=not-run :: External agent command exit code 0. active_agent_seconds=290.1.
2026-06-13 05:48:21 reviewer/build compiled gate=pass :: Cycle build gate.
```

Compact context pack: `runs/20260613-054827-700501-ASTIS-SALD-001-cycle207/05_context_pack.md`

```text
# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `207`
- Generated: `2026-06-13 05:48:27`

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

- narrows-source-cited-boundary dynamic-leaf worker packet. Exact boundary hRemainderPullbackDef below hRemainderGeneratorLimitDef. lower_1 route artifact: runs/20260613-052444-683667-ASTIS-SALD-001-cycle206/lower_1_remainder_pullback_route.md. Source anchors appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387. Local facts only: existing SALD scalar-pushforward/Gaussian remainder bridges plus TechnicalLemmas.SALDExtracted.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVecto...
- rejected-wrapper-churn dynamic-leaf API-scout packet for hRemainderPullbackDef; local MeasureTheory.integral_map / AutoSamplingTheory.TechnicalLemmas.Measure.lawMapIntegral and SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward already cover the reusable pushforward integral transport; no new technical lemma or SLT port queued; source search excluding sald_version_2.tex found no named normalizedRemainder, remainderGeneratorLimit, or pullback definition at appendix.tex:958-970;appendix.tex...
- narrows-source-cited-boundary dynamic-leaf worker packet: lower_2 recorded hRemainderPullbackDef as the exact source-contract gap below hRemainderGeneratorLimitDef after Lean/source inspection; no reducer proof exists, no wrapper churn or external SLT dependency; python3 tools/astis.py check passed.
- narrows-source-cited-boundary dynamic-leaf worker packet final: lower_2 recorded hRemainderPullbackDef as the exact source-contract gap below hRemainderGeneratorLimitDef after Lean/source inspection and reconciled the matching lower_1 route; no reducer proof exists, no wrapper churn or external SLT dependency; python3 tools/astis.py check passed.
- narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-206 dynamic-leaf worker packet. Exact boundary narrowed: hRemainderGeneratorLimitDef -> hRemainderPullbackDef, recorded by compiled SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Obligation/Dag with typed feedback leaf=hRemainderPullbackDef error_class=source_contract_gap_missing_remainder_pullback_definition. Gate passed: python3 tools/astis.py check. Source anch...
- narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-206 dynamic-leaf worker packet. Exact boundary narrowed: hRemainderGeneratorLimitDef -> hRemainderPullbackDef, recorded by compiled SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Obligation/Dag; not claimed proved. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387 check...

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
- Latest cycle: 206
- Dynamic leaf candidate: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-206 dynamic-leaf worker packet. Exact boundary narrowed: hRemainderGeneratorLimitDef -> hRemainderPullbackDef, recorded by compiled SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Obligation/Dag with typed feedback leaf=hRemainderPullbackDef error_class=source_contract_gap_missing_remainder_pullback_definition. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387 checked against original SALD source excluding sald_version_2.tex. Local ASTIS declarations only: existing SALD scalar-pushforward/Gaussian-law remainder bridges, TechnicalLemmas.SALDExtracted/Gaussian/Measure entries, and Mathlib MeasureTheory.integral_map. No external SLT import/call/queue, fake closure, wrapper churn, source-Hessian replay, selected-line Taylor replay, endpoint/naming replay, or theorem-status promotion. Remaining gap is the source-backed pullback definition of re...
- Illness area candidate: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-206 dynamic-leaf worker packet. Exact boundary narrowed: hRemainderGeneratorLimitDef -> hRemainderPullbackDef, recorded by compiled SALD.cycle206GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoRemainderPullbackLower2Obligation/Dag; not claimed proved. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1170;appendix.tex:1379-1387 checked against original SALD source excluding sald_version_2.tex. Local ASTIS declarations only; no external SLT import/call/queue, fake closure, wrapper churn, source-Hessian replay, selected-line Taylor replay, endpoint/naming replay, or theorem-status promotion.
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

Shared dialogue board: `runs/20260613-054827-700501-ASTIS-SALD-001-cycle207/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260613-054827-700501-ASTIS-SALD-001-cycle207 --role upper_source_math --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper_source_math --kind handoff --status queued --artifact runs/20260613-054827-700501-ASTIS-SALD-001-cycle207 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. Read only the compact context pack, blueprint state, human TODO, task-local paper memory, and technical lemma memory before assigning work; do not replay long historical logs. First read the compact context pack and run the self-reflection guard: if the planned packet is wrapper churn, reject it and choose a narrower target. Use the LeanMarathon-inspired proof blueprint: choose either the current dynamic leaf candidate for worker-style proof discharge, or a named illness-area refiner packet when the blocker affects a connected sub-DAG. Begin with a concise `Global phase judgment:` paragraph that answers: did the previous cycle fail and need recovery; is Phase 1 theorem-skeleton translation stable enough for cited-theory backfill; and which single lower packet now reduces the largest proof risk. For SALD after cycle 69, treat the theorem-skeleton route as stable enough for single-backend backfill. Keep the source theorem fixed and now prioritize the active EM conditional-law/Fokker--Planck backend over new transcript/ledger expansion, broad theorem-route audits, or isolated scalar sublemmas. For SALD after cycle 84, do not let the run accumulate more supplied-hypothesis wrappers unless they discharge or strictly narrow an existing supplied hypothesis. The priority is a smallest real backend theorem boundary: conditional kernel/conditional expectation, generator-to-law weak FP, KL/log-ratio admissibility, or one named LSI/DV/Gronwall blocker. If recent trial memory shows a failed cycle after an upper or middle handoff, recover that cycle first instead of advancing to a new source target. Before assigning middle/lower work, explicitly check that the active lower packet still targets `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`, unless reviewer identified a theorem-route blocker. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article and technical-report export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized. External lookup discipline: upper and middle may use network search when local context is insufficient for Mathlib names, Lean API examples, or standard SDE/measure-theory statements such as weak Fokker-Planck, Green identities, trace theorems, or divergence theorems. Prefer primary sources: Mathlib docs/source, Lean project repositories, arXiv papers, or official project documentation. Any external result must be converted into a local ASTIS compiled declaration or a precise source-cited ProofObligation; do not mark it formalized just because it was found online. Search `AutoSamplingTheory/TechnicalLemmas`, `research-wiki/technical-lemmas`, and the compact retrieval index before assigning new probability/Taylor work. Use `/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/lean-stat-learning-theory` only as provenance/source material for porting; do not import it as a Lake dependency or claim an SLT theorem is formalized unless an ASTIS-owned local declaration compiles. For SALD cycle 130 and later, treat the cycle-129 illness-area boundary as the live target unless the reviewer records a newer one: `hdiffusionSource` has been narrowed to the EM/Brownian diffusion generator weak action plus weak Laplacian integration-by-parts action. Do not reassign already-discharged leaves `hsampleInt`, `hsampleDerivMeas`, `hsampleDerivBound`, `hboundInt`, `hpathDeriv`, `hderivValue`, `hdriftBarBAction`, raw `hpairMeas`, or `hcanonicalBarBMeas`. For SALD cycle 151 and later, the reviewer-accepted cycle-150 boundary overrides older broad guards. The active EM conditional-law / weak-FP backend remains `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`, with source anchors `appendix.tex:984-995`, `appendix.tex:1368-1387`, and `appendix.tex:1379-1387`. Prioritize one direct definition/equality leaf at a time: `htraceFieldEqLaplacian`, `hemGeneratorLaplacianEventFieldEqTraceField`, `hemGeneratorLaplacianStateIntegral`, or `hsourceLaplacianFieldMeas`. Upper should choose the smallest leaf that reduces this boundary; middle should coordinate the proof route and split lower-agent roles; lower_1 should produce the natural-language/math route and lower_2 should implement exactly one compiled Lean theorem or a strictly smaller source-cited obligation. Reject new total-event/source-functional consumer wrappers unless they discharge one of these direct leaves. Reviewer must check that the remaining boundary is strictly smaller, not merely renamed, and that `python3 tools/astis.py check` passes. For SALD cycle 174 and later, the reviewer-accepted cycle-173 boundary overrides the older cycle-150 direct-leaf list. The active target is still the EM conditional-law / weak-FP Brownian/Ito backend, but the immediate live leaf is now the source-Hessian contract behind `SALD.selectedWeakTestHessianOpNormOfSourceHessianField`: `hSourceHasHessian : forall z, HasFDerivAt (fderiv Real sourceTest) (sourceHessian z) z` and `hSourceHessianBound : forall z, norm (sourceHessian z) <= C1`. Upper must decide whether these fields are paper assumptions or can be derived from selected-test regularity; middle must translate that decision into a single Lean theorem/proof-obligation with source anchors; lower_1 should give the natural-language Mathlib route, using ASTIS `TechnicalLemmas` first and external SLT Taylor/DCT/measure files only as port references; lower_2 should implement exactly one compiled theorem or strictly smaller source-cited boundary. Reject routes that define `sourceHessian` from the desired conclusion, reintroduce `SelectedWeakTestC2bBoundedHessian` without source support, use VP score-Hessian regularity for the selected weak test, import SLT as a dependency, call upstream SLT declarations directly, or return to consumer-wrapper churn. If the source-Hessian fields are confirmed absent from the paper source, keep the gap honest and move only to the next connected Brownian/Ito leaf: selected-line Taylor domination, Gaussian dominated-convergence integrability, quadratic-variation normalization, or per-coordinate Hessian generator identity. For SALD cycle 183 and later, the source-Hessian fields `hSourceHasHessian` and `hSourceHessianBound` are no longer an active proof target unless the original SALD source explicitly supplies the selected weak-test Hessian regularity. Treat them as a documented source-contract gap and move proof effort to the Brownian/Ito frozen backend tickets: `hBrownianCoordinateGeneratorTaylorIntegralDef`, `hRemainderGeneratorLimitDef`, conditional-drift weak-FP, KL derivative, and divergence/FI/IBP handoff. Reject source-Hessian wrapper churn, `testRegular` repackaging, VP score-Hessian substitution, direct SLT dependency use, or broad theorem-route replay.

Upper-panel profile: source-math and regularity auditor. This pass answers source-faithfulness questions for Sampling/SDE analysis. Inspect the original source anchors, assumptions, hidden regularity needs, boundary conditions, conditional-law choices, and whether the current Lean object still matches the paper object. Classify each issue as source-confirmed, standard-background-lemma-needed, source-contract-gap, or contract-drift. Do not assign broad Lean proof search. End with a recommendation to upper_director: continue the current leaf, switch to a smaller source-connected leaf, or stop a wasteful route.
