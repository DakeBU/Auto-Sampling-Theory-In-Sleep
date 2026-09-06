# ASTIS 中文循环总结：ASTIS-SALD-001 cycle 193

生成时间：`2026-06-12 06:01:41`

运行目录：`runs/20260612-053029-174468-ASTIS-SALD-001-cycle193`

## 给非 Lean 读者的结论

当前不是 VA-SALD 的核心想法没写出来，而是论文里的若干“标准分析事实”还没有在当前 Lean 符号下实例化。论文可以说 by Fokker--Planck、by KL/FI/LSI、by Ito/Taylor 或 by integration by parts；Lean 需要具体测度、条件分布代表元、可测/可积、dominated convergence、边界项为零和 Mathlib/local lemma 的精确 statement。

目前需要区分两类东西：

- **SALD 本文贡献**：论文自己提出的 VA-SALD 跟踪、guided path residual、moving-target theorem、离散 Euler--Maruyama theorem 等。ASTIS 必须忠实复现原文定理、常数、假设和 proof route。
- **前置 technical lemma**：测度论、KL/FI/LSI、Fokker--Planck、Ito/Taylor、Gaussian moments、integration by parts 等。它们在论文里通常是“标准事实”，但 Lean 不能把“标准”自动当成证明，必须在本库有可编译 statement，或者明确记录为 port queue / proof obligation。

换句话说，卡住不等于 SALD 思想没翻译出来；多数卡点是把纸面证明省略的正则性、可测性、可积性、边界项和条件分布细节，落到本项目的 Lean 类型和假设里。

## 本轮还没完成的 SALD 本文贡献

| id | 原文位置 | Lean 边界 | 状态 | 下一步 |
| --- | --- | --- | --- | --- |
| discrete-forward-kl-main | main_body.tex:301-326 | SALD.discreteForwardKlProofDag / thm:forward-KL-discrete contract | source-indexed; analytic backend open | Keep theorem contract fixed; discharge the EM weak-FP and Brownian/Ito generator leaves below. |
| unified-forward-kl-main | main_body.tex:372-392 | SALD.unifiedForwardKlContract | source-indexed; depends on general theorem closure | Do not mutate the statement; backfill shared KL/FI/LSI and moving-target interfaces. |
| frozen-em-interpolation | appendix.tex:983-996 | hBrownianCoordinateGeneratorTaylorIntegralDef; hRemainderGeneratorLimitDef | active unfinished leaf | Prove one coordinate generator equality or narrow it to a single Taylor/Ito source obligation. |
| conditional-drift-definition | appendix.tex:1368-1377 | conditional drift representative and law integral fields | source-line mapped; representative/measurability leaves open | Close or strictly narrow conditional expectation representative and integrability hypotheses. |
| weak-fokker-planck-line | appendix.tex:1379-1387 | sald.general_moving_target_discrete.em_interpolation_fp | core unfinished analytic backend | Prove/narrow generator-to-law weak action with the selected test function and Brownian term. |
| kl-derivative-start | appendix.tex:1358-1365 | KL derivative handoff for hat rho_s versus pi_s | source-indexed; depends on weak-FP and admissible log-ratio test | Connect the weak-FP identity to the KL derivative only after the law-level backend is stable. |
| divergence-fi-ibp | appendix.tex:1422-1434 | divergence rewrite, FI term, and no-boundary IBP | source-indexed; Green/trace and integration-by-parts leaves open | Use local measure/variational technical lemmas first; queue missing Green/trace facts explicitly. |
| selected-source-hessian-fields | appendix.tex:982-995 | hSourceHasHessian; hSourceHessianBound | source-contract gap; do not fake via wrapper assumptions | Either locate the exact source regularity assumption or leave a precise ProofObligation. |

## 本轮还没补齐的前置 technical lemma

| id | 来源 | statement | 状态 | 服务于 | 下一步 |
| --- | --- | --- | --- | --- | --- |
| SLT/GaussianMeasure.lean | SLT/GaussianMeasure.lean | `integrable_eval_stdGaussianPi`, `integrable_sq_eval_stdGaussianPi`, `integral_eval_stdGaussianPi` | port-candidate | Brownian/Ito coordinate integrability and polynomial moment leaves | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianPoincare/TaylorBound.lean | SLT/GaussianPoincare/TaylorBound.lean | `taylor_order_one`, `taylor_mean_value_bound`, `taylor_diff_abs_bound`, `deriv2_bounded_of_compactlySupported`, `integrable_deriv_sq` | port-candidate | selected scalar Taylor integral/remainder and bounded-Hessian leaves | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianPoincare/Limit.lean | SLT/GaussianPoincare/Limit.lean | `tendsto_integral_deriv_sq`, `tendsto_entropy_f_sq`, `gaussianPoincare` | future-port | Taylor remainder limits and Gaussian Poincare backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/DualityEntropy.lean | SLT/GaussianLSI/DualityEntropy.lean | `entropy_duality`, `entropy_ge_integral_mul`, `expMeasure_isProbabilityMeasure`, `integral_expMeasure` | future-port | DV/KL variational formula backend | Port to ASTIS-owned TechnicalLemmas before using. |
| SLT/GaussianLSI/TensorizedGLSI.lean | SLT/GaussianLSI/TensorizedGLSI.lean | `gaussian_logSobolev_W12_pi`, `condEntExceptCoord_sq_eq_slice_entropy`, `condEnt_sq_le_partial_deriv_sq` | future-port | product Gaussian LSI backend | Port to ASTIS-owned TechnicalLemmas before using. |

## 最近 reviewer / verifier 反馈

_None._

## 下一轮给人的 high-level 指导入口

1. 先看 SALD 本文贡献表，确认下一轮是否继续当前 source-line leaf，而不是开新战线。
2. 再看 technical lemma 表，只补当前 leaf 真正需要的最小背景事实。
3. 若一个“常识”lemma 已在外部库存在，也必须变成 ASTIS-owned Lean code 后才能被 lower agent 调用。
