# ChatGPT Pro Prompt: ASTIS ASTIS-SALD-001 cycle 207

Copy everything below this line into ChatGPT Pro.

---

You are helping with ASTIS, an Auto-Sampling-Theory-in-Sleep Lean 4 project for
faithful paper reproduction and sampling/SDE proof exploration.  You cannot
access my local files.  Use only public links and the self-contained status in
this prompt.  Local Lean names and local paths are labels for me to patch later.

## Public sources you may use

- SALD/VA-SALD target paper, "Learning Distributional Diffusion Models with Training-Free Guided Generation": https://arxiv.org/abs/2605.07950
- PDF: https://arxiv.org/pdf/2605.07950

## Current ASTIS task

Task: `ASTIS-SALD-001`

Title: Faithfully reproduce the original VA-SALD paper proofs

Cycle: `207`

Run label: `20260613-054827-700501-ASTIS-SALD-001-cycle207`

Task contract excerpt:

```text
# Faithfully reproduce the original VA-SALD paper proofs Task id: `ASTIS-SALD-001` Kind: `paperReproduction` Mode: `faithfulPaper` Status: `active` ## Goal Reproduce the proof structure of `[local source path]` in Lean-facing contracts and, incrementally, Lean proofs. The source file `unrelated draft routes` is explicitly out of scope. ## First Proof DAG - `lem:gronwall` - `lem:dv_variation` - LSI/KL/FI definitions - `thm:forward-KL` - `thm:forward-KL-discrete` - `prop:guided_path_residual` - `thm:general-moving-target-SALD` - `thm:unified-forward-KL` - `thm:general-moving-target-SALD-discrete` ## Current 6h Priority: Single-Backend Backfill The theorem-skeleton route is now stable enough to stop rotating broadly through all theorem statements. The next batch should backfill exactly one shared analytic backend: the Euler--Maruyama interpolation conditional-law / weak Fokker--Planck interface, especially `sald.general_moving_target_discrete.em_interpolation_fp` over `the relevant SALD appendix passage`. This backend has the highest leverage because it supports both `thm:forward-KL-discrete` and `thm:general-moving-target-SALD-discrete`. Upper and middle agents should avoid assigning lower work on unrelated theorem-route audits, display algebra, or broad reusable APIs while this backend remains open. The required source-cited analytic interfaces are: 1. `lem:gronwall`, with endpoint-safe differentiability/FTC assumptions. 2. `lem:dv_variation`, with common-space, absolute-continuity, finite-KL, and finite-log-mgf assumptions. 3. `eq:LSI-KL-FI`, with density, zero-set convention, admissible test, entropy identity, and Fisher chain-rule assumptions. 4. The continuous forward-KL Fokker--Planck/KL derivative identity. 5. The Euler--Maruyama interpolation Fokker--Planck...
```

If this is faithful-paper mode, do not change the theorem statement,
assumptions, constants, or proof target.  If a paper proof says "standard" or
"by Fokker--Planck/KL/FI/LSI/Ito/Taylor/integration by parts", classify that as
an external technical lemma or classical fact unless it is fully proved in the
target paper.

## Current status

Plain-language status: The current SALD state is not missing the VA-SALD idea.  The remaining work is mainly background analysis that papers cite as standard but Lean must instantiate for the exact law, conditional representative, measurability/integrability assumptions, domination argument, boundary condition, and KL/FI/LSI or Fokker--Planck statement in use.

### Active proof-DAG leaves

- narrows-source-cited-boundary reviewer_waste acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner, obligation-level only; no lower_1/lower_2 artifact and no proved Lean theorem in cycle207. Gate passed: python3 tools/astis.py check. Source anchors the relevant SALD appendix passage;the relevant SALD appendix passage;the relevant SALD appendix passage;the relevant SALD appendix passage verified. Local compiled ASTIS TechnicalLemmas.Measure and SALD weak-FP/condDistrib handoffs only; no external SLT import/call/queue/port. Waste diagnosis: useful progress is retiring repeated hRemainderPullbackDef wrapper churn and selecting emInterpolationConditionalWeakFp; no formal proof progress occurred; next best leaf is lower_2 compiling one non-wrapper theorem for emInterpolationConditionalWeakFp or logging leaf=emInterpolationConditionalWeakFp error_class=source_contract_gap_missing_conditional_fp_generator_definition.
- narrows-source-cited-boundary reviewer_waste acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner, obligation-level only; no lower_1/lower_2 artifact and no proved Lean theorem in cycle207. Gate passed: python3 tools/astis.py check. Source anchors the relevant SALD appendix passage;the relevant SALD appendix passage;the relevant SALD appendix passage;the relevant SALD appendix passage verified. Local compiled ASTIS TechnicalLemmas.Measure and SALD weak-FP/condDistrib handoffs only; no external SLT import/call/queue/port. Waste diagnosis: useful progress is retiring repeated hRemainderPullbackDef wrapper churn and selecting emInterpolationConditionalWeakFp; no formal proof progress occurred; next best leaf is lower_2 compiling one non-wrapper theorem for emInterpolationConditionalWeakFp or logging leaf=emInterpolationConditionalWeakFp error_class=source_contract_gap_missing_conditional_fp_generator_definition.

### Open obligation signals

- narrows-source-cited-boundary reviewer_waste acceptance after mandatory gate pass. Exact boundary narrowed: sald.general_moving_target_discrete.em_interpolation_fp -> emInterpolationConditionalWeakFp. Packet type: illness-area refiner, obligation-level only; no lower_1/lower_2 artifact and no proved Lean theorem in cycle207. Gate passed: python3 tools/astis.py check. Source anchors the relevant SALD appendix passage;the relevant SALD appendix passage;the relevant SALD appendix passage;the relevant SALD appendix passage verified. Local compiled ASTIS TechnicalLemmas.Measure and SALD weak-FP/condDistrib handoffs only; no external SLT import/call/queue/port. Waste diagnosis: useful progress is retiring repeated hRemainderPullbackDef wrapper churn and selecting emInterpolationConditionalWeakFp; no formal proof progress occurred; next best leaf is lower_2 compiling one non-wrapper theorem for emInterpolationConditionalWeakFp or logging leaf=emInterpolationConditionalWeakFp error_class=source_contract_gap_missing_conditional_fp_generator_definition.

### Open paper-contribution obligations

| id | source | paper object | Lean/status | next action |
| --- | --- | --- | --- | --- |
| discrete-forward-kl-main | the corresponding SALD main-text passage | Discrete VA-SALD Euler--Maruyama forward-KL theorem statement and proof route. | source-indexed; analytic backend open | Keep theorem contract fixed; discharge the EM weak-FP and Brownian/Ito generator leaves below. |
| unified-forward-kl-main | the corresponding SALD main-text passage | Unified guided VA-SALD theorem that depends on the general moving-target theorem. | source-indexed; depends on general theorem closure | Do not mutate the statement; backfill shared KL/FI/LSI and moving-target interfaces. |
| frozen-em-interpolation | the relevant SALD appendix passage | Frozen EM interpolation used to identify the Brownian/Ito scalar generator and Taylor remainder. | active unfinished leaf | Prove one coordinate generator equality or narrow it to a single Taylor/Ito source obligation. |
| conditional-drift-definition | the relevant SALD appendix passage | The conditional drift \bar b_{k,s} and conditional-law representative used by the weak FP equation. | source-line mapped; representative/measurability leaves open | Close or strictly narrow conditional expectation representative and integrability hypotheses. |
| weak-fokker-planck-line | the relevant SALD appendix passage | Weak Fokker--Planck equation for the EM interpolation law. | core unfinished analytic backend | Prove/narrow generator-to-law weak action with the selected test function and Brownian term. |
| kl-derivative-start | the relevant SALD appendix passage | First derivative of the KL along the discrete moving-target law. | source-indexed; depends on weak-FP and admissible log-ratio test | Connect the weak-FP identity to the KL derivative only after the law-level backend is stable. |
| divergence-fi-ibp | the relevant SALD appendix passage | Divergence/Laplacian rewrite producing the Fisher-information term and residual pairing. | source-indexed; Green/trace and integration-by-parts leaves open | Use local measure/variational technical lemmas first; queue missing Green/trace facts explicitly. |
| selected-source-hessian-fields | the relevant SALD appendix passage | Selected weak-test Hessian regularity required by the Brownian/Ito Taylor expansion. | source-contract gap; do not fake via wrapper assumptions | Either locate the exact source regularity assumption or leave a precise ProofObligation. |

### Open external technical-lemma obligations

| id | source | statement | status | used by | next action |
| --- | --- | --- | --- | --- | --- |
| SLT/GaussianPoincare/TaylorBound.lean | SLT/GaussianPoincare/TaylorBound.lean | `taylor_order_one`, `taylor_mean_value_bound`, `taylor_diff_abs_bound`, `deriv2_bounded_of_compactlySupported`, `integrable_deriv_sq` | port-candidate | selected scalar Taylor integral/remainder and bounded-Hessian leaves | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianPoincare/Limit.lean | SLT/GaussianPoincare/Limit.lean | `tendsto_integral_deriv_sq`, `tendsto_entropy_f_sq`, `gaussianPoincare` | future-port | Taylor remainder limits and Gaussian Poincare backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/DualityEntropy.lean | SLT/GaussianLSI/DualityEntropy.lean | `entropy_duality`, `entropy_ge_integral_mul`, `expMeasure_isProbabilityMeasure`, `integral_expMeasure` | future-port | DV/KL variational formula backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/TensorizedGLSI.lean | SLT/GaussianLSI/TensorizedGLSI.lean | `gaussian_logSobolev_W12_pi`, `condEntExceptCoord_sq_eq_slice_entropy`, `condEnt_sq_le_partial_deriv_sq` | future-port | product Gaussian LSI backend | Port to ASTIS-owned TechnicalLemmas before using. |

### Recent typed verifier feedback

| leaf | error class | Lean build | measure theory | technical lemma | next route |
| --- | --- | --- | --- | --- | --- |
| hRemainderPullbackDef | source_contract_gap_missing_remainder_pullback_definition |  |  |  |  |
| hRemainderPullbackDef | source_contract_gap_missing_remainder_pullback_definition |  |  |  |  |
| hRemainderPullbackDef | source_contract_gap_missing_remainder_pullback_definition |  |  |  |  |
| hRemainderPullbackDef | source_contract_gap_missing_remainder_pullback_definition |  |  |  |  |
| hSelectedLineTaylorRawSplitDef | source_contract_gap_missing_selected_line_taylor_raw_split_definition |  |  |  |  |
| hSelectedLineTaylorRawSplitDef | source_contract_gap_missing_selected_line_taylor_raw_split_definition |  |  |  |  |
| hSelectedLineTaylorRawSplitDef | source_contract_gap_missing_selected_line_taylor_raw_split_definition |  |  |  |  |
| hSourceTaylorIntegrandSelectedIncrementDef | source_contract_gap_missing_source_taylor_integrand_selected_increment_definition |  |  |  |  |
| hSelectedIncrementEndpointDef | source_contract_gap_missing_selected_increment_endpoint_definition |  |  |  |  |
| hSelectedEndpointCoordinateLineDef | source_contract_gap_missing_selected_endpoint_coordinate_line_definition |  |  |  |  |

## What I need from you

Please return a proof-engineering answer that can guide the next ASTIS 6h run.

1. Identify which remaining items are target-paper contributions and which are
   external technical lemmas/classical facts.
2. For the smallest next leaf, write a source-faithful natural-language proof
   route and a dependency DAG.
3. Propose Lean-facing lemma statements in pseudo-Lean if necessary.  Be
   precise about measures, kernels, laws, densities, conditioning, integrability,
   differentiability, domination, and boundary conditions.
4. Identify any pre-Lean sanity checks that are necessary conditions and cannot
   reject a theorem that Lean could prove.  Examples may include finite
   Gaussian-moment checks, dimensional consistency, sign conventions, or toy
   scalar cases; do not present them as formal proof.
5. If an external theorem is needed, name the exact public theorem/source I
   should cite or formalize next.
6. Do not claim completion unless the remaining proof obligations are closed by
   Lean-level theorem routes.
