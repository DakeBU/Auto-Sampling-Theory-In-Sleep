# ASTIS 6h 中文复盘：ASTIS-SALD-001

- 导出时间: 2026-06-11 20:04:22
- 本轮 cycle: unknown
- 本轮日志: `runs/logs/astis-sald-001-6h-20260611-170258-852101.log`
- active-agent 用量: unknown
- source-indexed SALD declarations: 90
- trial-log records: 1985
- Lean theorem 数: 459
- Lean def 数: 1037
- forbidden proof hits: 0
- Lean gate 状态: cycle 181, pass at 2026-06-10 15:40:22

## 总结结论

这轮还没有完整复现完 SALD 论文的剩余基础分析部分。它完成的是更细的
source-cited boundary narrowing：本轮 cycle `unknown` 一直由
blueprint/reviewer 的动态 leaf 驱动，主要推进 EM conditional-law /
weak Fokker--Planck 后端，没有把时间花在无关的 KL/LSI/DV/Gronwall
重排或项目文章润色上。

最新 reviewer 认可的状态是：

```text
discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-180 dynamic-leaf worker packet. hRemainderInt discharged by compiled SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder from hRemainderMeas/hRemainderBound/hRemainderBoundInt; hLinearInt and hQuadraticInt also discharged by Gaussian polynomial integrability. Remaining exact Taylor-integral source boundary hBrownianCoordinateGeneratorTaylorIntegralDef plus hRemainderGeneratorLimitDef with hRemainderMeas/hRemainderBound/hRemainderBoundInt explicit; hSourceHasHessian/hSourceHessianBound remain source-contract gaps. No SLT import/use, wrapper churn, VP score-Hessian substitution, sigma_eta^2/2 event-field move, fake closure, non-EM fallback, or sald_version_2 use. Gate passed: python3 tools/astis.py check.
```

这说明系统仍在把论文中一句
“by the Fokker--Planck equation / integration by parts / Laplacian/Ito
calculus”拆成 Lean 必须检查的具体对象。当前剩余困难已经从宽泛的
trace/source-functional wrapper 进一步推进到内部 Brownian/Ito coordinate
decomposition、per-coordinate Hessian generator、Taylor remainder、Gaussian
moment/limit、measurability/integrability 这类底层分析边界。

## 给不懂 Lean 的 30 秒版本

当前不是“VA-SALD 的核心数学想法还没写出来”。核心 theorem 的路线、原文
位置、Lean contract 和很多局部代数/高斯/Taylor 子步骤已经在系统里了。现在
卡住的是：论文把若干前置知识写成“标准结论”，但 Lean 不能接受“这是常识”
这句话，必须知道它在当前符号、当前测度、当前条件分布、当前边界条件下到底
是哪一个定理实例。

可以把剩余工作分成两类：

| 类别 | 人类怎么理解 | 现在是否 SALD 新贡献 | 为什么还要做 |
|---|---|---|---|
| SALD 本文贡献 | VA-SALD 的离散/连续 KL 收缩、moving target、guided residual、EM 插值路线 | 是 | 必须忠实对应原论文定理和 proof DAG |
| 前置 technical lemma | KL/FI/LSI、Fokker--Planck、Ito/Taylor 展开、Gaussian moment、可测/可积、IBP/边界项 | 不是 | 论文作者可以引用“常识”，Lean 需要本地可调用的精确定理 |
| source-contract gap | 原文可能默认了某个正则性假设，但没有写成 Lean 可用字段 | 介于两者之间 | 不能偷偷加假设；必须回原文定位或诚实记录为 obligation |

所以，很多“非 SALD 本身贡献”的东西拖得久，并不是因为数学上没人知道，而是
因为 ASTIS 的目标不是写自然语言证明，而是让 Lean 检查。一个常识性步骤要能
通过 Lean，通常还要补全：

1. 对象是哪一个测度或 law，不只是“分布”；
2. 函数是不是可测、可积，log-ratio 或梯度在哪些地方定义；
3. 条件期望/条件分布选了哪个代表元；
4. 积分换序、求导进积分、极限进积分的 domination 条件；
5. integration by parts 的边界项为什么为零；
6. Mathlib 或本地 lemma 的 statement 是否和论文符号完全对齐。

## 你下一轮可以怎么给 high-level 指导

你不需要读 Lean code，也可以按下面三种方向给指示：

| 你可以选择的方向 | 对系统的影响 | 适合什么时候用 |
|---|---|---|
| “先完成 SALD 本文贡献骨架，前置常识先保留为 source-cited obligation” | 文章复现速度快，但 Lean fully formalized 程度较低 | 想先看完整 proof DAG 和教学结构 |
| “优先补 technical lemma memory，把 KL/测度论/Ito/Taylor 常识都本地 Lean 化” | 后续论文复用强，但当前 SALD 完成会慢 | 想建设长期 Sampling/SDE Lean 库 |
| “只补当前最小 leaf 需要的前置 lemma，不做大库建设” | 当前最稳妥，避免无限扩张 | 适合下一轮 6h 默认策略 |

我建议默认用第三种：每轮只问“为了关掉当前 source-line leaf，最少需要哪个
常识 lemma？”如果这个 lemma 在 Mathlib 或 lean-stat-learning-theory 有类似
版本，就把它 port 成 ASTIS-owned local lemma；如果没有，就先写成精确
ProofObligation，不让 lower agent 泛泛地补测度论大库。

## 对应原文位置

这里的“原文位置”对应 ASTIS 当前 SALD 复现任务的源论文位置；类比 QBE/GHL
任务中的 `main.tex` 对照表，但本任务不是 GHL。

| 原文位置 | 内容 | 当前 Lean 复现状态 |
|---|---|---|
| `main_body.tex:301-326` | `thm:forward-KL-discrete` 离散 SALD 主定理显示式 | theorem contract 已建；分析后端仍在补 |
| `main_body.tex:372-392` | `thm:unified-forward-KL` general / guided VA-SALD 连续主定理 | theorem contract 已建；与离散后端共享部分义务 |
| `appendix.tex:982-995` | frozen EM interpolation `eq:general_moving_target_SALD_frozen_interp` | 本轮反复使用的 EM generator 来源 |
| `appendix.tex:1354-1366` | `hat rho_s` endpoint law 与 KL derivative 起点 | 已进入 proof DAG；mass/KL derivative 后端仍需精化 |
| `appendix.tex:1368-1377` | conditional drift `bar b_{k,s}` 定义 | conditional-law 代表元与 measurability 仍是关键基础边界 |
| `appendix.tex:1379-1387` | 论文直接写的 weak Fokker--Planck equation | 当前 6h 的核心未完成分析后端 |
| `appendix.tex:1402-1427` | divergence rewrite、Fisher information 项、IBP 入口 | Green/trace/box-divergence 与 Laplacian source leaves 仍未完全 formalized |

## 未完成 source-line map

文件位置：`research-wiki/paper-contributions/SALD/unfinished_source_map.md`

| Boundary id | Type | Source lines | Lean boundary | Status | Next action |
|---|---|---|---|---|---|
| `discrete-forward-kl-main` | paper-contribution | `main_body.tex:301-326` | `SALD.discreteForwardKlProofDag / thm:forward-KL-discrete contract` | source-indexed; analytic backend open | Keep theorem contract fixed; discharge the EM weak-FP and Brownian/Ito generator leaves below. |
| `unified-forward-kl-main` | paper-contribution | `main_body.tex:372-392` | `SALD.unifiedForwardKlContract` | source-indexed; depends on general theorem closure | Do not mutate the statement; backfill shared KL/FI/LSI and moving-target interfaces. |
| `frozen-em-interpolation` | paper-contribution | `appendix.tex:983-996` | `hBrownianCoordinateGeneratorTaylorIntegralDef; hRemainderGeneratorLimitDef` | active unfinished leaf | Prove one coordinate generator equality or narrow it to a single Taylor/Ito source obligation. |
| `conditional-drift-definition` | paper-contribution | `appendix.tex:1368-1377` | `conditional drift representative and law integral fields` | source-line mapped; representative/measurability leaves open | Close or strictly narrow conditional expectation representative and integrability hypotheses. |
| `weak-fokker-planck-line` | paper-contribution | `appendix.tex:1379-1387` | `sald.general_moving_target_discrete.em_interpolation_fp` | core unfinished analytic backend | Prove/narrow generator-to-law weak action with the selected test function and Brownian term. |
| `kl-derivative-start` | paper-contribution | `appendix.tex:1358-1365` | `KL derivative handoff for hat rho_s versus pi_s` | source-indexed; depends on weak-FP and admissible log-ratio test | Connect the weak-FP identity to the KL derivative only after the law-level backend is stable. |
| `divergence-fi-ibp` | paper-contribution | `appendix.tex:1422-1434` | `divergence rewrite, FI term, and no-boundary IBP` | source-indexed; Green/trace and integration-by-parts leaves open | Use local measure/variational technical lemmas first; queue missing Green/trace facts explicitly. |
| `selected-source-hessian-fields` | paper-contribution | `appendix.tex:982-995` | `hSourceHasHessian; hSourceHessianBound` | source-contract gap; do not fake via wrapper assumptions | Either locate the exact source regularity assumption or leave a precise ProofObligation. |
| `taylor-dct-technical-backend` | technical-lemma | `appendix.tex:982-995` | `hRemainderMeas; hRemainderBound; hRemainderBoundInt` | technical lemma port/proof queue | Port or prove ASTIS-owned local lemmas before calling them from SALD proof code. |

## Technical lemma 未完成项

这些是前人/常识性技术 lemma 的 port 或本地证明队列。它们不能作为可调用事实，
除非已经变成 `AutoSamplingTheory/TechnicalLemmas/` 下面能通过 Lake build 的
ASTIS-owned declaration。

- `SLT/GaussianMeasure.lean` -> `integrable_eval_stdGaussianPi`, `integrable_sq_eval_stdGaussianPi`, `integral_eval_stdGaussianPi`; target: Brownian/Ito coordinate integrability and polynomial moment leaves; status: port-candidate
- `SLT/GaussianPoincare/TaylorBound.lean` -> `taylor_order_one`, `taylor_mean_value_bound`, `taylor_diff_abs_bound`, `deriv2_bounded_of_compactlySupported`, `integrable_deriv_sq`; target: selected scalar Taylor integral/remainder and bounded-Hessian leaves; status: port-candidate
- `SLT/GaussianPoincare/Limit.lean` -> `tendsto_integral_deriv_sq`, `tendsto_entropy_f_sq`, `gaussianPoincare`; target: Taylor remainder limits and Gaussian Poincare backend; status: future-port
- `SLT/GaussianLSI/DualityEntropy.lean` -> `entropy_duality`, `entropy_ge_integral_mul`, `expMeasure_isProbabilityMeasure`, `integral_expMeasure`; target: DV/KL variational formula backend; status: future-port
- `SLT/GaussianLSI/TensorizedGLSI.lean` -> `gaussian_logSobolev_W12_pi`, `condEntExceptCoord_sq_eq_slice_entropy`, `condEnt_sq_le_partial_deriv_sq`; target: product Gaussian LSI backend; status: future-port

## 下一轮最小 leaf

- Boundary: `frozen-em-interpolation`
- 原文行号: `appendix.tex:983-996`
- Lean boundary: `hBrownianCoordinateGeneratorTaylorIntegralDef; hRemainderGeneratorLimitDef`
- 下一步: Prove one coordinate generator equality or narrow it to a single Taylor/Ito source obligation.

## 当前未复现的关键边界

```text
discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-180 dynamic-leaf worker packet. hRemainderInt discharged by compiled SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder from hRemainderMeas/hRemainderBound/hRemainderBoundInt; hLinearInt and hQuadraticInt also discharged by Gaussian polynomial integrability. Remaining exact Taylor-integral source boundary hBrownianCoordinateGeneratorTaylorIntegralDef plus hRemainderGeneratorLimitDef with hRemainderMeas/hRemainderBound/hRemainderBoundInt explicit; hSourceHasHessian/hSourceHessianBound remain source-contract gaps. No SLT import/use, wrapper churn, VP score-Hessian substitution, sigma_eta^2/2 event-field move, fake closure, non-EM fallback, or sald_version_2 use. Gate passed: python3 tools/astis.py check.
```

下一轮应优先处理 latest blocker 里点名的最小 leaf，而不是回到旧的
total-event/source-functional consumer wrapper。若最新 blocker 是
Brownian/Ito/Taylor 方向，则优先处理：

- selected-test scalar Taylor pointwise limit；
- Taylor moment decomposition；
- quadratic-variation normalization；
- per-coordinate Hessian generator identity；
- 必要的 Gaussian moment、dominated-convergence、measurability/integrability leaf。

若 reviewer 指回 trace/Laplacian 命名方向，则再处理：

- `hemGeneratorLaplacianStateIntegral`；
- `hsourceLaplacianFieldMeas`；
- `hemGeneratorLaplacianEventFieldEqTraceField`；
- `htraceFieldEqLaplacian`。

## 为什么还没有完成

论文里可以把 `appendix.tex:1379-1387` 写成一个 Fokker--Planck 方程，把
`appendix.tex:1402-1427` 写成一次 divergence rewrite 和 integration by
parts。Lean 里这些不是一句话：它需要知道具体是哪一个 law、哪个版本的
conditional expectation、哪个 measurable representative、哪个 Laplacian
定义、哪个边界 trace 为零、哪个积分换元定理可用。

因此，本轮是在把“大而模糊的标准分析步骤”切成小接口：law integral、
state integral、source functional、trace field、Laplacian field、event
field、standard-basis formula、Brownian/Ito scalar coordinate expansion、
Gaussian dominated convergence。这个方向是对的，但还没有完成所有底层
Taylor/Ito/可测性/积分/边界定理。

## 本轮 packet 统计

- `discharges-supplied-hypothesis`: 3
- `narrows-source-cited-boundary`: 19
- `rejected-wrapper-churn`: 0

## Proof status counts

- `blocked`: 0
- `contractOnly`: 34
- `formalized`: 249
- `obligation`: 1131
- `planned`: 9
- `sourceCited`: 16

## 最近 handoff 摘要

- lower_1 recorded as lower because astis.py rejects lower_1. discharges-supplied-hypothesis lower_1 packet: compiled Gaussian polynomial-integrability bridge discharging hLinearInt and hQuadraticInt; remaining boundary hBrownianCoordinateGeneratorTaylorIntegralDef + hRemainderInt + hRemainderGeneratorLimitDef; gate passed python3 tools/astis.py check.
- lower_2 recorded as lower because astis.py rejects lower_2. discharges-supplied-hypothesis lower_2 packet: compiled SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder discharging hRemainderInt via MeasureTheory.Integrable.mono' from hRemainderMeas/hRemainderBound/hRemainderBoundInt; remaining boundary hBrownianCoordinateGeneratorTaylorIntegralDef + hRemainderGeneratorLimitDef plus concrete remainder meas/domination package; gate passed python3 tools/astis.py...
- discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-180 dynamic-leaf worker packet. hRemainderInt discharged by compiled SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder from hRemainderMeas/hRemainderBound/hRemainderBoundInt; hLinearInt and hQuadraticInt also discharged by Gaussian polynomial integrability. Remaining exact Taylor-integral source boundary hBrownianCoordinateGeneratorTaylorIntegralDef plus hRemainderGeneratorLim...
- narrows-source-cited-boundary upper handoff after gate pass: source-Hessian fields remain source-contract gaps after original-source recheck; next dynamic-leaf worker packet narrows hBrownianCoordinateGeneratorTaylorIntegralDef to a source-integral definition plus a.e. scalar Taylor integrand equality using MeasureTheory.integral_congr_ae. hRemainderGeneratorLimitDef and normalized-remainder measurability/domination remain explicit. No SLT import/use, wrapper churn, VP score-Hessian substitution, sigma_eta^2/2 e...
- narrows-source-cited-boundary upper dynamic-leaf worker packet after gate pass: hSourceHasHessian/hSourceHessianBound remain source-contract gaps after original-source recheck; next lower packet narrows hBrownianCoordinateGeneratorTaylorIntegralDef to a source integral definition plus an a.e. scalar Taylor integrand equality using MeasureTheory.integral_congr_ae. hRemainderGeneratorLimitDef and normalized-remainder measurability/domination remain explicit. No SLT import/use, wrapper churn, VP score-Hessian subst...

## 下一轮科学计划

1. upper 必须从 latest blocker 里选一个最小 direct leaf；不要回到已经缩小过的
   total-event/source-functional wrapper。
2. middle 负责把该 leaf 的源文位置、Lean declaration、依赖 DAG、可用 Mathlib
   theorem 和仍需 source-cited 的假设写清楚，再分派 lower agents。
3. lower_1 先做自然语言证明路线，明确哪些步骤是 Taylor/Ito 展开、Gaussian
   moment、dominated convergence、measurability/integrability 或定义展开。
4. lower_2 只实现一个 compiled Lean theorem，或者把该 leaf 严格缩小成更小的
   source-cited obligation。
5. reviewer 必须拒绝只把同一个大前提换名字的 wrapper churn；接受标准是
   `python3 tools/astis.py check` 通过且剩余边界严格变小。
6. 如本地 Mathlib/SLT 参考不够，upper/middle 可以网络检索 Mathlib source、
   Lean API 或标准 SDE/Fokker--Planck/Ito/Taylor/Green identity 文献，但所有结果必须回写成
   本地 compiled declaration 或明确 `ProofObligation`。
