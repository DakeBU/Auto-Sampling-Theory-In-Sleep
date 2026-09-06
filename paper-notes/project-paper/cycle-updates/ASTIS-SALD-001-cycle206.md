# Project Article Cycle Update: ASTIS-SALD-001 cycle 206

Generated: `2026-06-13 05:48:27`

## Reader-Facing Status

The current SALD state is not missing the VA-SALD idea.  The remaining work is mainly background analysis that papers cite as standard but Lean must instantiate for the exact law, conditional representative, measurability/integrability assumptions, domination argument, boundary condition, and KL/FI/LSI or Fokker--Planck statement in use.

ASTIS separates paper-specific contributions from reusable background formalization.  The former records what the target paper actually proves and where it appears in the source; the latter records common probability, measure-theory, and SDE lemmas that must compile locally before an agent may use them.

## Open Paper-Contribution Leaves

| id | source | Lean boundary | status | next action |
| --- | --- | --- | --- | --- |
| discrete-forward-kl-main | main_body.tex:301-326 | SALD.discreteForwardKlProofDag / thm:forward-KL-discrete contract | source-indexed; analytic backend open | Keep theorem contract fixed; discharge the EM weak-FP and Brownian/Ito generator leaves below. |
| unified-forward-kl-main | main_body.tex:372-392 | SALD.unifiedForwardKlContract | source-indexed; depends on general theorem closure | Do not mutate the statement; backfill shared KL/FI/LSI and moving-target interfaces. |
| frozen-em-interpolation | appendix.tex:983-996 | hBrownianCoordinateGeneratorTaylorIntegralDef; hRemainderGeneratorLimitDef | active unfinished leaf | Prove one coordinate generator equality or narrow it to a single Taylor/Ito source obligation. |
| conditional-drift-definition | appendix.tex:1368-1377 | conditional drift representative and law integral fields | source-line mapped; representative/measurability leaves open | Close or strictly narrow conditional expectation representative and integrability hypotheses. |
| weak-fokker-planck-line | appendix.tex:1379-1387 | sald.general_moving_target_discrete.em_interpolation_fp | core unfinished analytic backend | Prove/narrow generator-to-law weak action with the selected test function and Brownian term. |
| kl-derivative-start | appendix.tex:1358-1365 | KL derivative handoff for hat rho_s versus pi_s | source-indexed; depends on weak-FP and admissible log-ratio test | Connect the weak-FP identity to the KL derivative only after the law-level backend is stable. |
| divergence-fi-ibp | appendix.tex:1422-1434 | divergence rewrite, FI term, and no-boundary IBP | source-indexed; Green/trace and integration-by-parts leaves open | Use local measure/variational technical lemmas first; queue missing Green/trace facts explicitly. |
| selected-source-hessian-fields | appendix.tex:982-995 | hSourceHasHessian; hSourceHessianBound | source-contract gap; do not fake via wrapper assumptions | Either locate the exact source regularity assumption or leave a precise ProofObligation. |

## Open Technical-Lemma Leaves

| id | source | status | used by | next action |
| --- | --- | --- | --- | --- |
| SLT/GaussianPoincare/TaylorBound.lean | SLT/GaussianPoincare/TaylorBound.lean | port-candidate | selected scalar Taylor integral/remainder and bounded-Hessian leaves | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianPoincare/Limit.lean | SLT/GaussianPoincare/Limit.lean | future-port | Taylor remainder limits and Gaussian Poincare backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/DualityEntropy.lean | SLT/GaussianLSI/DualityEntropy.lean | future-port | DV/KL variational formula backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/TensorizedGLSI.lean | SLT/GaussianLSI/TensorizedGLSI.lean | future-port | product Gaussian LSI backend | Port to ASTIS-owned TechnicalLemmas before using. |

## Harness Lesson

The useful control signal for the next cycle is not the raw number of remaining leaves.  It is whether the next lower packet closes one exact source-line leaf or ports one exact background lemma needed by that leaf.  This is why the ABEIS-style retrieval index is compact, typed, and split into paper-contribution memory and technical-lemma memory.
