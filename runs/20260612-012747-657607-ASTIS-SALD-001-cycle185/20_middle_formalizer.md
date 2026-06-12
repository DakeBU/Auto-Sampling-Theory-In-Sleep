Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 185
Role: middle
Base role: middle
Run directory: runs/20260612-012747-657607-ASTIS-SALD-001-cycle185

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
narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-184 dynamic-leaf worker packet. hBrownianCoordinateGeneratorSourceIntegralDef narrowed by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw; hBrownianCoordinateGeneratorNormalizedLawDef narrowed by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward to hScalarMeas, hNormalizedCoordinateLawDef, hSourceTaylorIntegrandMeas, and hGeneratorPullbackDef via MeasureTheory.integral_map. Source anchors appendix.tex:958-996, 1170-1176, 1379-1387 checked; unfinished_source_map frozen-em-interpolation row covers active leaf. Gate passed python3 tools/astis.py check. Remaining backend: hScalarMeas, hNormalizedCoordinateLawDef, hSourceTaylorIntegrandMeas, hGeneratorPullbackDef, hSourceTaylorIntegrandPointwise, hRemainderGeneratorLimitDef, hRemainderMeas/hRemainderBound/hRemainderBoundInt; source-Hessian fields remain source-contract gaps. No SLT import/upstream call, fake closure, wrapper churn, VP substitution, sigma_eta^2/2 ev...

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
2026-06-12 01:24:51 lower/attempt accepted gate=not-run :: External agent command exit code 0. active_agent_seconds=513.9.
2026-06-12 01:27:06 reviewer/handoff queued gate=not-run :: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-184 dynamic-leaf worker packet. hBrownianCoordinateGeneratorSourceIntegralDef narrowed by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw; hBrownianCoordinateGeneratorNormalizedLawDef narrowed by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforwa...
2026-06-12 01:27:30 reviewer/attempt accepted gate=not-run :: External agent command exit code 0. active_agent_seconds=158.9.
2026-06-12 01:27:41 reviewer/build compiled gate=pass :: Cycle build gate.
```

Compact context pack: `runs/20260612-012747-657607-ASTIS-SALD-001-cycle185/05_context_pack.md`

```text
# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `185`
- Generated: `2026-06-12 01:27:47`

## Compact Task Contract

# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-184 dynamic-leaf worker packet. hBrownianCoordinateGeneratorSourceIntegralDef narrowed by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw; hBrownianCoordinateGeneratorNormalizedLawDef narrowed by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward to hScalarMeas, hNormalizedCoordinateLawDef, hSourceTaylorIntegrandMeas, and hGeneratorPullbackDef via MeasureTheory.integral_map. Source anchors appendix.tex:958-996, 1170-1176, 1379-1387 checked; unfinished_source_map frozen-em-interpolation row covers active leaf. Gate passed python3 tools/astis.py check. Remaining backend: hScalarMeas, hNormalizedCoordinateLawDef, hSourceTaylorIntegrandMeas, hGeneratorPullbackDef, hSourceTaylorIntegrandPointwise, hRemainderGeneratorLimitDef, hRemainderMeas/hRemainderBound/hRemainderBoundInt; source-Hessian fields remain source-contract gaps. No SLT import/upstream call, fake closure, wrapper churn, VP substitution, sigma_eta^2/2 ev...

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.

## Cycle Focus

Cycle-183+ closure sprint: freeze `hSourceHasHessian` and `hSourceHessianBound` as an explicit source-contract gap unless the original SALD source is found to state the selected weak-test Hessian regularity verbatim. Do not spend the cycle on wrapper projections, `testRegular` repackaging, VP score-Hessian substitution, or source-Hessian re-audits. The active proof work is the connected Brownian/Ito frozen-interpolation backend: first close or strictly narrow `hBrownianCoordinateGeneratorTaylorIntegralDef` and `hRemainderGeneratorLimitDef`; then connect the same local backend to the conditional-drift weak-Fokker--Planck line `appendix.tex:1379-1387`, the KL derivative handoff `appendix.tex:1358-1365`, and the divergence/FI/IBP rewrite `appendix.tex:1422-1434`. Lower_1 should write the natural-language classical proof route for exactly one ticket, and lower_2 should implement one compiled ASTIS-owned theorem or record one strictly smaller source-cited obligation with typed verifier feedback.

## Recent High-Signal Handoffs

- narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-183 dynamic-leaf worker packet. hBrownianCoordinateGeneratorTaylorIntegralDef narrowed to hBrownianCoordinateGeneratorSourceIntegralDef plus hBrownianCoordinateGeneratorTaylorIntegrandAE by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralAndAE; hBrownianCoordinateGeneratorTaylorIntegrandAE narrowed to hSourceTaylorIntegrandPointwise by compiled SALD.selectedWeakTestBrownianCoordinateGenerat...
- narrows-source-cited-boundary upper dynamic-leaf worker packet after gate pass: cycle 184 assigns hRemainderGeneratorLimitDef as the next Brownian/Ito frozen-backend leaf under sald.general_moving_target_discrete.em_interpolation_fp. hBrownianCoordinateGeneratorTaylorIntegralDef and hBrownianCoordinateGeneratorTaylorIntegrandAE remain narrowed by cycle-183 compiled bridges; remaining explicit siblings are hBrownianCoordinateGeneratorSourceIntegralDef, hSourceTaylorIntegrandPointwise, hRemainderMeas, hRemainderBo...
- narrows-source-cited-boundary middle dynamic-leaf worker packet after gate pass: hBrownianCoordinateGeneratorSourceIntegralDef narrowed by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw to hBrownianCoordinateGeneratorNormalizedLawDef plus hNormalizedVectorLaw, hCoordinateLawDef, hVarianceDef. It reuses compiled SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw and SALD.selectedWeakTestNormalizedVarianceDefOfGaussianRealUnitLaw with Mathlib Gaussi...
- lower_1 recorded as lower because astis.py role choices exclude lower_1. narrows-source-cited-boundary dynamic-leaf proof scout packet for hBrownianCoordinateGeneratorNormalizedLawDef. Wrote route artifact with lower_2 theorem shape selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward: use MeasureTheory.integral_map to derive the law-space source integral from scalar Brownian coordinate measurability, normalizedCoordinateLaw pushforward definition, sourceTaylorIntegrand measurability, a...
- lower_2 recorded as lower because astis.py role choices exclude lower_2. narrows-source-cited-boundary lower_2 dynamic-leaf worker packet after gate pass: compiled SALD.selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward, narrowing hBrownianCoordinateGeneratorNormalizedLawDef to hScalarMeas plus hNormalizedCoordinateLawDef plus hSourceTaylorIntegrandMeas plus hGeneratorPullbackDef by MeasureTheory.integral_map. Source anchors: appendix.tex:984-995, appendix.tex:1170-1176, appendix.tex:...
- narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-184 dynamic-leaf worker packet. hBrownianCoordinateGeneratorSourceIntegralDef narrowed by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw; hBrownianCoordinateGeneratorNormalizedLawDef narrowed by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward to hScalarMeas, hNormalizedCoordinateLawDef, hSourceTaylorIntegrandMeas, and hGeneratorPullbackDe...

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
- Latest cycle: 184
- Dynamic leaf candidate: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-184 dynamic-leaf worker packet. hBrownianCoordinateGeneratorSourceIntegralDef narrowed by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw; hBrownianCoordinateGeneratorNormalizedLawDef narrowed by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward to hScalarMeas, hNormalizedCoordinateLawDef, hSourceTaylorIntegrandMeas, and hGeneratorPullbackDef via MeasureTheory.integral_map. Source anchors appendix.tex:958-996, 1170-1176, 1379-1387 checked; unfinished_source_map frozen-em-interpolation row covers active leaf. Gate passed python3 tools/astis.py check. Remaining backend: hScalarMeas, hNormalizedCoordinateLawDef, hSourceTaylorIntegrandMeas, hGeneratorPullbackDef, hSourceTaylorIntegrandPointwise, hRemainderGeneratorLimitDef, hRemainderMeas/hRemainderBound/hRemainderBoundInt; source-Hessian fields remain source-contract gaps. No SLT import/upstream call, fake closure, wrapper churn, VP substitution, sigma_eta^2/2 ev...
- Illness area candidate: lower_2 recorded as lower because astis.py role choices exclude lower_2. narrows-source-cited-boundary lower_2 dynamic-leaf worker packet after gate pass: compiled SALD.selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward, narrowing hBrownianCoordinateGeneratorNormalizedLawDef to hScalarMeas plus hNormalizedCoordinateLawDef plus hSourceTaylorIntegrandMeas plus hGeneratorPullbackDef by MeasureTheory.integral_map. Source anchors: appendix.tex:984-995, appendix.tex:1170-1176, appendix.tex:1379-1387. Remaining backend: hScalarMeas, hNormalizedCoordinateLawDef, hSourceTaylorIntegrandMeas, hGeneratorPullbackDef, hSourceTaylorIntegrandPointwise, hRemainderGeneratorLimitDef, hRemainderMeas, hRemainderBound, hRemainderBoundInt. Gate passed python3 tools/astis.py check. No SLT import/upstream call or wrapper churn.
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

Shared dialogue board: `runs/20260612-012747-657607-ASTIS-SALD-001-cycle185/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260612-012747-657607-ASTIS-SALD-001-cycle185 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260612-012747-657607-ASTIS-SALD-001-cycle185 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, technical lemma memory, SLT reuse audit, and lower packets. Use the compact context pack instead of rereading broad historical task text. Before assigning lower agents, query the task-local paper memory for the exact source-line leaf, then query ASTIS TechnicalLemmas for callable background facts and the port queue for non-callable candidates. Treat the LeanMarathon-style blueprint state as the system-of-record summary: translate only the chosen dynamic leaf or illness area into lower-ready declarations, and keep unrelated DAG regions out of scope. For SALD after cycle 69, read the TeX around the active EM conditional-law/Fokker--Planck focus and translate only that backend into lower-ready Lean declarations; avoid fresh theorem-route audits unless needed for source correctness. For SALD after cycle 84, classify every lower packet as either `discharges-supplied-hypothesis`, `narrows-source-cited-boundary`, or `rejected-wrapper-churn`; lower-ready declarations should name the exact Mathlib/local theorem boundary and source line. Before inventing an abstraction, inspect `AutoSamplingTheory/TechnicalLemmas` and the technical lemma registry; inspect local `lean-stat-learning-theory` only when a missing lemma must be ported locally under this project's toolchain. Also follow the MathCode-inspired theorem-reuse discipline: search existing ASTIS declarations, conversion windows, proof obligations, and cited-result ledgers before creating a duplicate interface. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. At the end of a multi-hour batch, perform the ARIS-style writing pass: update the generated technical-report snippets with the latest run evidence, middle-agent rule changes, source anchors, and remaining proof boundary, while keeping Lean/proof obligations authoritative. External lookup discipline: upper and middle may use network search when local context is insufficient for Mathlib names, Lean API examples, or standard SDE/measure-theory statements such as weak Fokker-Planck, Green identities, trace theorems, or divergence theorems. Prefer primary sources: Mathlib docs/source, Lean project repositories, arXiv papers, or official project documentation. Any external result must be converted into a local ASTIS compiled declaration or a precise source-cited ProofObligation; do not mark it formalized just because it was found online. During this sprint, avoid broad rebaseline work, broad SLT/SDE library import, direct upstream calls, and lower packets outside the active EM backend unless reviewer found a blocker. Export the Overleaf-ready project article and the external ASTIS technical-report snippets only at the end of a multi-hour batch. For SALD cycle 130 and later, treat the cycle-129 illness-area boundary as the live target unless the reviewer records a newer one: `hdiffusionSource` has been narrowed to the EM/Brownian diffusion generator weak action plus weak Laplacian integration-by-parts action. Do not reassign already-discharged leaves `hsampleInt`, `hsampleDerivMeas`, `hsampleDerivBound`, `hboundInt`, `hpathDeriv`, `hderivValue`, `hdriftBarBAction`, raw `hpairMeas`, or `hcanonicalBarBMeas`. For SALD cycle 151 and later, the reviewer-accepted cycle-150 boundary overrides older broad guards. The active EM conditional-law / weak-FP backend remains `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`, with source anchors `appendix.tex:984-995`, `appendix.tex:1368-1387`, and `appendix.tex:1379-1387`. Prioritize one direct definition/equality leaf at a time: `htraceFieldEqLaplacian`, `hemGeneratorLaplacianEventFieldEqTraceField`, `hemGeneratorLaplacianStateIntegral`, or `hsourceLaplacianFieldMeas`. Upper should choose the smallest leaf that reduces this boundary; middle should coordinate the proof route and split lower-agent roles; lower_1 should produce the natural-language/math route and lower_2 should implement exactly one compiled Lean theorem or a strictly smaller source-cited obligation. Reject new total-event/source-functional consumer wrappers unless they discharge one of these direct leaves. Reviewer must check that the remaining boundary is strictly smaller, not merely renamed, and that `python3 tools/astis.py check` passes. For SALD cycle 174 and later, the reviewer-accepted cycle-173 boundary overrides the older cycle-150 direct-leaf list. The active target is still the EM conditional-law / weak-FP Brownian/Ito backend, but the immediate live leaf is now the source-Hessian contract behind `SALD.selectedWeakTestHessianOpNormOfSourceHessianField`: `hSourceHasHessian : forall z, HasFDerivAt (fderiv Real sourceTest) (sourceHessian z) z` and `hSourceHessianBound : forall z, norm (sourceHessian z) <= C1`. Upper must decide whether these fields are paper assumptions or can be derived from selected-test regularity; middle must translate that decision into a single Lean theorem/proof-obligation with source anchors; lower_1 should give the natural-language Mathlib route, using ASTIS `TechnicalLemmas` first and external SLT Taylor/DCT/measure files only as port references; lower_2 should implement exactly one compiled theorem or strictly smaller source-cited boundary. Reject routes that define `sourceHessian` from the desired conclusion, reintroduce `SelectedWeakTestC2bBoundedHessian` without source support, use VP score-Hessian regularity for the selected weak test, import SLT as a dependency, call upstream SLT declarations directly, or return to consumer-wrapper churn. If the source-Hessian fields are confirmed absent from the paper source, keep the gap honest and move only to the next connected Brownian/Ito leaf: selected-line Taylor domination, Gaussian dominated-convergence integrability, quadratic-variation normalization, or per-coordinate Hessian generator identity. For SALD cycle 183 and later, the source-Hessian fields `hSourceHasHessian` and `hSourceHessianBound` are no longer an active proof target unless the original SALD source explicitly supplies the selected weak-test Hessian regularity. Treat them as a documented source-contract gap and move proof effort to the Brownian/Ito frozen backend tickets: `hBrownianCoordinateGeneratorTaylorIntegralDef`, `hRemainderGeneratorLimitDef`, conditional-drift weak-FP, KL derivative, and divergence/FI/IBP handoff. Reject source-Hessian wrapper churn, `testRegular` repackaging, VP score-Hessian substitution, direct SLT dependency use, or broad theorem-route replay.
