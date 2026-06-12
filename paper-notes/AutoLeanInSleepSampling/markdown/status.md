# ASTIS Project Article Export

- Task: `ASTIS-SALD-001`
- Latest cycle number observed: 194
- Source-indexed original SALD declarations: 90
- Trial-log records: 2141
- Quantum automation reference: https://github.com/DakeBU/Quantum-Computing-Block-Encoding/tree/wip/ghl2025-faithful-20260518-0201
- SLT reference: https://github.com/YuanheZ/lean-stat-learning-theory
- SLT article: https://arxiv.org/abs/2602.02285
- LeanMarathon reference: https://github.com/YuanheZ/LeanMarathon
- LeanMarathon article: https://arxiv.org/abs/2606.05400
- MathCode workflow reference: https://github.com/math-ai-org/mathcode
- ARIS / auto-research-in-sleep reference: https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep
- Learning Beyond Gradients reference: https://github.com/Trinkle23897/learning-beyond-gradients
- EoH reference: https://github.com/FeiLiu36/EoH

The export is batch-based.  Lean and the conversion windows remain the source
of truth; this document is the middle-agent human-audit layer.

## Human-Readable Blocker Report

The current SALD reproduction is not blocked by a missing source index or by
an interrupted run.  It is blocked by the analytic backend that the paper treats
as standard prose: weak Fokker--Planck source actions, Laplacian source fields,
measurability and state-integral identities, Green identities, boundary trace
conditions, box-divergence facts, and diffusion generator leaves.

For a non-specialist: the paper can write one line such as "by the weak
Fokker--Planck equation and integration by parts".  Lean needs every object in
that sentence to be explicit: which law is being integrated against, which
representative of a conditional expectation is used, why the function is
measurable and integrable, why the boundary term is zero, and which exact
Laplacian/divergence theorem applies.

Plain-language separation:

| Layer | Meaning | Why it matters |
|---|---|---|
| SALD contribution | The source paper's KL contraction, moving-target, guided-residual, and EM proof route | Must be reproduced faithfully with the same statements and constants |
| Technical lemma memory | Standard KL/FI/LSI, Fokker--Planck, Ito/Taylor, Gaussian moment, measurability, integrability, and IBP tools | Common in prose, but callable in ASTIS only after a local compiled Lean statement exists |
| Source-contract gap | A regularity or representative choice the source proof seems to use implicitly | Must be found in the source assumptions or kept as an explicit obligation |

Human guidance before the next 6h run should choose a policy: finish the SALD
proof DAG with source-cited background obligations, invest in a reusable
technical lemma library, or use the default local strategy of porting only the
smallest background lemma needed by the next SALD source-line leaf.

Current dynamic leaf:

```text
narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-194 dynamic-leaf worker packet. hRemainderBound under ProbabilityTheory.gaussianReal 0 (variance phi x i) is reduced to hNormalizedRemainderBound under normalizedCoordinateLaw by compiled SALD.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw. Confirmed compiled SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw formalizes hRemainderMeas transport. Source anchors the relevant SALD appendix passage, the relevant SALD appendix passage, the relevant SALD appendix passage, the relevant SALD appendix passage checked. Gate passed python3 tools/astis.py check. Remaining hNormalizedRemainderBound and hRemainderBoundInt; hSourceHasHessian and hSourceHessianBound remain source-contract gaps. No external SLT import/call/queue or wrapper churn accepted.
```

Current illness area:

```text
narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-194 dynamic-leaf worker packet. hRemainderBound under ProbabilityTheory.gaussianReal 0 (variance phi x i) is reduced to hNormalizedRemainderBound under normalizedCoordinateLaw by compiled SALD.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw. Confirmed compiled SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw formalizes hRemainderMeas transport. Source anchors the relevant SALD appendix passage, the relevant SALD appendix passage, the relevant SALD appendix passage, the relevant SALD appendix passage checked. Gate passed python3 tools/astis.py check. Remaining hNormalizedRemainderBound and hRemainderBoundInt; hSourceHasHessian and hSourceHessianBound remain source-contract gaps. No external SLT import/call/queue or wrapper churn accepted.
```

Latest blocker:

```text
narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-194 dynamic-leaf worker packet. hRemainderBound under ProbabilityTheory.gaussianReal 0 (variance phi x i) is reduced to hNormalizedRemainderBound under normalizedCoordinateLaw by compiled SALD.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw. Confirmed compiled SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw formalizes hRemainderMeas transport. Source anchors the relevant SALD appendix passage, the relevant SALD appendix passage, the relevant SALD appendix passage, the relevant SALD appendix passage checked. Gate passed python3 tools/astis.py check. Remaining hNormalizedRemainderBound and hRemainderBoundInt; hSourceHasHessian and hSourceHessianBound remain source-contract gaps. No external SLT import/call/queue or wrapper churn accepted.
```

Recent packet classifications:

- `discharges-supplied-hypothesis`: 22
- `narrows-source-cited-boundary`: 10
- `rejected-wrapper-churn`: 0

Proof-status counts:

- `blocked`: 0
- `contractOnly`: 34
- `formalized`: 286
- `obligation`: 1157
- `planned`: 9
- `sourceCited`: 16

Unfinished source-line map:

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

Technical lemma memory status:

- Formalized local registry entries: 15
- Port queue entries: 5
- Port candidates are not callable until they become ASTIS-owned compiled declarations.

Recent reviewer/lower handoffs:

- lower_2 recorded as lower because astis.py role choices exclude lower_2. discharges-supplied-hypothesis dynamic-leaf worker packet: compiled SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw discharges hRemainderMeas from hNormalizedRemainderMeas plus standard-Gaussian vector coordinate-law and variance-def fields. Source anchors the relevant SALD appendix passage, the relevant SALD appendix passage, the relevant SALD appendix passage, the relevant SALD appendix passage. Checks: lake env lean AutoSamplingTheory/SALD.lean passed; python3 tools/astis.py chec...
- discharges-supplied-hypothesis dynamic-leaf worker packet after gate pass: hRemainderMeas discharged by compiled SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw. Uses local SALD selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw and selectedWeakTestNormalizedVarianceDefOfGaussianRealUnitLaw plus equality/simpa transport for AEStronglyMeasurable; exposed via TechnicalLemmas.SALDExtracted and registry key sald.remainder-meas-gaussian-law. Source anchors the relevant SALD appendix passage, the relevant SALD appendix passage...
- lower_1 recorded as lower because astis.py role choices exclude lower_1. discharges-supplied-hypothesis dynamic-leaf proof-scout packet after gate pass for hRemainderMeas Gaussian-law transport. Route artifact: runs/20260612-060143-086541-ASTIS-SALD-001-cycle194/lower_1_remainder_meas_route.md. Exact supplied hypothesis: hRemainderMeas in the cycle-193 Taylor moment consumers. The route uses local SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw and SALD.selectedWeakTestNormalizedVarianceDefOfG...
- lower_2 recorded as lower because astis.py role choices exclude lower_2. narrows-source-cited-boundary dynamic-leaf worker packet after gate pass: compiled SALD.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw narrows hRemainderBound from Gaussian-law domination to hNormalizedRemainderBound under normalizedCoordinateLaw, using local SALD Gaussian coordinate-law and variance bridges. Exposed through TechnicalLemmas.SALDExtracted and registry key sald.remainder-bound-gaussian-law. Source anchors the relevant SALD appendix passage...
- narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-194 dynamic-leaf worker packet. hRemainderBound under ProbabilityTheory.gaussianReal 0 (variance phi x i) is reduced to hNormalizedRemainderBound under normalizedCoordinateLaw by compiled SALD.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw. Confirmed compiled SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw formalizes hRemainderMeas transport. Source anchors the relevant SALD appendix passage, the relevant SALD appendix passage, the relevant SALD appendix passage...

