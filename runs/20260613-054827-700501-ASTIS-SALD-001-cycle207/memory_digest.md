# Memory Digest: ASTIS-SALD-001 cycle 207

Generated: `2026-06-27 01:58:34`

Run directory: `runs/20260613-054827-700501-ASTIS-SALD-001-cycle207`

This is the ABEIS-style compact retrieval packet for ASTIS.  Upper and middle
should read this before replaying long logs.

## Plain-Language Status

The current SALD state is not missing the VA-SALD idea.  The remaining work is mainly background analysis that papers cite as standard but Lean must instantiate for the exact law, conditional representative, measurability/integrability assumptions, domination argument, boundary condition, and KL/FI/LSI or Fokker--Planck statement in use.

## Active Proof-DAG Leaves

- narrows-source-cited-boundary reviewer_waste acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner, obligation-level only; no lower_1/lower_2 artifact and no proved Lean theorem in cycle207. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:983-996;appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387 verified. Local compiled ASTIS TechnicalLemmas.Measure and SALD weak-FP/condDistrib handoffs only; no external SLT import/call/queue/port. Waste diagnosis: useful progress is retiring repeated hRemainderPullbackDef wrapper churn and selecting emInterpolationConditionalWeakFp; no formal proof progress occurred; next best leaf is lower_2 compiling one non-wrapper theorem for emInterpolationConditionalWeakFp or logging leaf=emInterpolationConditionalWeakFp error_class=source_contract_gap_missing_conditional_fp_generator_definition.
- narrows-source-cited-boundary reviewer_waste acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner, obligation-level only; no lower_1/lower_2 artifact and no proved Lean theorem in cycle207. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:983-996;appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387 verified. Local compiled ASTIS TechnicalLemmas.Measure and SALD weak-FP/condDistrib handoffs only; no external SLT import/call/queue/port. Waste diagnosis: useful progress is retiring repeated hRemainderPullbackDef wrapper churn and selecting emInterpolationConditionalWeakFp; no formal proof progress occurred; next best leaf is lower_2 compiling one non-wrapper theorem for emInterpolationConditionalWeakFp or logging leaf=emInterpolationConditionalWeakFp error_class=source_contract_gap_missing_conditional_fp_generator_definition.

## Open Obligation Signals

- narrows-source-cited-boundary reviewer_waste acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner, obligation-level only; no lower_1/lower_2 artifact and no proved Lean theorem in cycle207. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:983-996;appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387 verified. Local compiled ASTIS TechnicalLemmas.Measure and SALD weak-FP/condDistrib handoffs only; no external SLT import/call/queue/port. Waste diagnosis: useful progress is retiring repeated hRemainderPullbackDef wrapper churn and selecting emInterpolationConditionalWeakFp; no formal proof progress occurred; next best leaf is lower_2 compiling one non-wrapper theorem for emInterpolationConditionalWeakFp or logging leaf=emInterpolationConditionalWeakFp error_class=source_contract_gap_missing_conditional_fp_generator_definition.

## Mathlib-Ready Leaf Discipline

- Decompose aggressively: one lower packet should target one small lemma.
- Specify the theorem together with local APIs, imports, hidden regularity
  contracts, and an intended proof route.
- Search Mathlib and `AutoSamplingTheory/TechnicalLemmas` before inventing a
  local bridge.
- Treat repeated failure as a mathematical signal: missing assumption, false
  statement, representative mismatch, API mismatch, or over-large target.
- Do not churn the theorem shape or proof route without reviewer diagnosis.
- Protocol: `docs/mathlib_ready_leaf_protocol.md`.
- Skill tree: `research-wiki/lemma-dags/SDE_Sampling_skill_tree.md`.
- Compressed Pro leaf targets:
  `research-wiki/lemma-dags/Pro_assimilated_leaf_targets.md`.

## Open SALD Contribution Obligations

| id | source | paper object | Lean/status | next action |
| --- | --- | --- | --- | --- |
| discrete-forward-kl-main | main_body.tex:301-326 | Discrete VA-SALD Euler--Maruyama forward-KL theorem statement and proof route. | source-indexed; analytic backend open | Keep theorem contract fixed; discharge the EM weak-FP and Brownian/Ito generator leaves below. |
| unified-forward-kl-main | main_body.tex:372-392 | Unified guided VA-SALD theorem that depends on the general moving-target theorem. | source-indexed; depends on general theorem closure | Do not mutate the statement; backfill shared KL/FI/LSI and moving-target interfaces. |
| frozen-em-interpolation | appendix.tex:983-996 | Frozen EM interpolation used to identify the Brownian/Ito scalar generator and Taylor remainder. | active unfinished leaf | Prove one coordinate generator equality or narrow it to a single Taylor/Ito source obligation. |
| conditional-drift-definition | appendix.tex:1368-1377 | The conditional drift \bar b_{k,s} and conditional-law representative used by the weak FP equation. | source-line mapped; representative/measurability leaves open | Close or strictly narrow conditional expectation representative and integrability hypotheses. |
| weak-fokker-planck-line | appendix.tex:1379-1387 | Weak Fokker--Planck equation for the EM interpolation law. | core unfinished analytic backend | Prove/narrow generator-to-law weak action with the selected test function and Brownian term. |
| kl-derivative-start | appendix.tex:1358-1365 | First derivative of the KL along the discrete moving-target law. | source-indexed; depends on weak-FP and admissible log-ratio test | Connect the weak-FP identity to the KL derivative only after the law-level backend is stable. |
| divergence-fi-ibp | appendix.tex:1422-1434 | Divergence/Laplacian rewrite producing the Fisher-information term and residual pairing. | source-indexed; Green/trace and integration-by-parts leaves open | Use local measure/variational technical lemmas first; queue missing Green/trace facts explicitly. |
| selected-source-hessian-fields | appendix.tex:982-995 | Selected weak-test Hessian regularity required by the Brownian/Ito Taylor expansion. | source-contract gap; do not fake via wrapper assumptions | Either locate the exact source regularity assumption or leave a precise ProofObligation. |

## Open External Technical Lemma Obligations

| id | source | status | used by | next action |
| --- | --- | --- | --- | --- |
| SLT/GaussianPoincare/TaylorBound.lean | SLT/GaussianPoincare/TaylorBound.lean | port-candidate | selected scalar Taylor integral/remainder and bounded-Hessian leaves | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianPoincare/Limit.lean | SLT/GaussianPoincare/Limit.lean | future-port | Taylor remainder limits and Gaussian Poincare backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/DualityEntropy.lean | SLT/GaussianLSI/DualityEntropy.lean | future-port | DV/KL variational formula backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/TensorizedGLSI.lean | SLT/GaussianLSI/TensorizedGLSI.lean | future-port | product Gaussian LSI backend | Port to ASTIS-owned TechnicalLemmas before using. |

## Recent Typed Verifier Feedback

| leaf | class | build | measure | technical lemma | next |
| --- | --- | --- | --- | --- | --- |
| hRemainderPullbackDef | source_contract_gap_missing_remainder_pullback_definition |  |  |  |  |
| hRemainderPullbackDef | source_contract_gap_missing_remainder_pullback_definition |  |  |  |  |
| hRemainderPullbackDef | source_contract_gap_missing_remainder_pullback_definition |  |  |  |  |
| hRemainderPullbackDef | source_contract_gap_missing_remainder_pullback_definition |  |  |  |  |
| hSelectedLineTaylorRawSplitDef | source_contract_gap_missing_selected_line_taylor_raw_split_definition |  |  |  |  |
| hSelectedLineTaylorRawSplitDef | source_contract_gap_missing_selected_line_taylor_raw_split_definition |  |  |  |  |
| hSelectedLineTaylorRawSplitDef | source_contract_gap_missing_selected_line_taylor_raw_split_definition |  |  |  |  |
| hSourceTaylorIntegrandSelectedIncrementDef | source_contract_gap_missing_source_taylor_integrand_selected_increment_definition |  |  |  |  |

## Next Lower-Agent Split

| role | goal | artifact |
| --- | --- | --- |
| lower-1-natural-language-proof-scout | Translate the active SALD source-line leaf into a dependency DAG with exact technical lemma needs. | proof-attempts/<task>/...-natural-language-dag.md or a dialogue handoff. |
| lower-2-lean-implementation-worker | Close one compiled Lean theorem or strictly narrow one source-cited Sampling/SDE boundary. | Lean declaration plus typed verifier feedback fields. |
