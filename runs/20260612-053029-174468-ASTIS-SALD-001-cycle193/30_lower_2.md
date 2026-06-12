Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 193
Role: lower_2
Base role: lower
Run directory: runs/20260612-053029-174468-ASTIS-SALD-001-cycle193

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
discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-192 dynamic-leaf worker packet. hBrownianCoordinateGeneratorSourceIntegralDef is discharged inside hBrownianCoordinateGeneratorTaylorIntegralDef by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs, using only local SALD declarations and Mathlib law-map/Gaussian infrastructure encapsulated by local bridges. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387 checked. Gate passed python3 tools/astis.py check. Remaining backend keeps scalar pushforward/law fields, raw Taylor fields, hRemainderGeneratorLimitDef, hRemainderMeas, hRemainderBound, and hRemainderBoundInt.

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
2026-06-12 05:29:18 reviewer/build compiled gate=not-run :: Cycle 192 reviewer gate: python3 tools/astis.py check passed. Lake build and Tests completed; ASTIS fake-closure scan accepted the cycle state.
2026-06-12 05:29:37 reviewer/handoff queued gate=not-run :: discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-192 dynamic-leaf worker packet. hBrownianCoordinateGeneratorSourceIntegralDef is discharged inside hBrownianCoordinateGeneratorTaylorIntegralDef by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs, using only local SALD declarations and Mathlib law-map/Gaussian infrast...
2026-06-12 05:30:11 reviewer/attempt accepted gate=not-run :: External agent command exit code 0. active_agent_seconds=146.6.
2026-06-12 05:30:21 reviewer/build compiled gate=pass :: Cycle build gate.
```

Compact context pack: `runs/20260612-053029-174468-ASTIS-SALD-001-cycle193/05_context_pack.md`

```text
# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `193`
- Generated: `2026-06-12 05:30:29`

## Compact Task Contract

# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-192 dynamic-leaf worker packet. hBrownianCoordinateGeneratorSourceIntegralDef is discharged inside hBrownianCoordinateGeneratorTaylorIntegralDef by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs, using only local SALD declarations and Mathlib law-map/Gaussian infrastructure encapsulated by local bridges. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387 checked. Gate passed python3 tools/astis.py check. Remaining backend keeps scalar pushforward/law fields, raw Taylor fields, hRemainderGeneratorLimitDef, hRemainderMeas, hRemainderBound, and hRemainderBoundInt.

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.

## Cycle Focus

Cycle-183+ closure sprint: freeze `hSourceHasHessian` and `hSourceHessianBound` as an explicit source-contract gap unless the original SALD source is found to state the selected weak-test Hessian regularity verbatim. Do not spend the cycle on wrapper projections, `testRegular` repackaging, VP score-Hessian substitution, or source-Hessian re-audits. The active proof work is the connected Brownian/Ito frozen-interpolation backend: first close or strictly narrow `hBrownianCoordinateGeneratorTaylorIntegralDef` and `hRemainderGeneratorLimitDef`; then connect the same local backend to the conditional-drift weak-Fokker--Planck line `appendix.tex:1379-1387`, the KL derivative handoff `appendix.tex:1358-1365`, and the divergence/FI/IBP rewrite `appendix.tex:1422-1434`. Lower_1 should write the natural-language classical proof route for exactly one ticket, and lower_2 should implement one compiled ASTIS-owned theorem or record one strictly smaller source-cited obligation with typed verifier feedback.

## Recent High-Signal Handoffs

- discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-191 dynamic-leaf worker packet. hBrownianCoordinateGeneratorNormalizedLawDef is discharged inside hBrownianCoordinateGeneratorSourceIntegralDef by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfScalarPushforwardAndStdGaussianVectorLaw, using only local SALD declarations and existing Mathlib MeasureTheory.integral_map/Gaussian/map/stdOrthonormalBasis infrastructure. Source anchors and unfinished_source_...
- narrows-source-cited-boundary dynamic-leaf worker packet after gate pass: assign lower_1/lower_2 to narrow hBrownianCoordinateGeneratorTaylorIntegralDef inside sald.general_moving_target_discrete.em_interpolation_fp over appendix.tex:1358-1387 to the source-cited scalar selected-line Taylor/DCT interface selectedWeakTestScalarTaylorIntegralDCT anchored at appendix.tex:983-996. Lower_2 should compile one ASTIS-owned bridge using local Gaussian moment and quadratic-variation declarations, or record typed verifier...
- discharges-supplied-hypothesis dynamic-leaf worker packet: lower_2 should compile SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs to discharge hBrownianCoordinateGeneratorSourceIntegralDef inside hBrownianCoordinateGeneratorTaylorIntegralDef by composing the cycle-191 source-integral scalar-pushforward bridge with the cycle-189 raw Taylor bridge. lower_1 should write the matching classical route. Gate passed python3 tools/astis.py check.
- lower_1 recorded as lower because astis.py role choices exclude lower_1. discharges-supplied-hypothesis dynamic-leaf proof-scout packet after gate pass: recorded lower_1 route for discharging hBrownianCoordinateGeneratorSourceIntegralDef inside hBrownianCoordinateGeneratorTaylorIntegralDef. Artifact runs/20260612-050646-484742-ASTIS-SALD-001-cycle192/lower_1_taylor_integral_source_integral_discharge_route.md. Lower_2-ready theorem target: SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarP...
- lower_2 recorded as lower because astis.py role choices exclude lower_2. discharges-supplied-hypothesis dynamic-leaf worker packet after gate pass: compiled SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs discharges hBrownianCoordinateGeneratorSourceIntegralDef inside hBrownianCoordinateGeneratorTaylorIntegralDef by composing SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfScalarPushforwardAndStdGaussianVectorLaw with SALD.selectedWeakTe...
- discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-192 dynamic-leaf worker packet. hBrownianCoordinateGeneratorSourceIntegralDef is discharged inside hBrownianCoordinateGeneratorTaylorIntegralDef by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs, using only local SALD declarations and Mathlib law-map/Gaussian infrastructure encapsulated by local bridges. Source anchors appendix.tex:958-970, appendix.tex:983-996, ap...

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
- Latest cycle: 192
- Dynamic leaf candidate: discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-192 dynamic-leaf worker packet. hBrownianCoordinateGeneratorSourceIntegralDef is discharged inside hBrownianCoordinateGeneratorTaylorIntegralDef by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs, using only local SALD declarations and Mathlib law-map/Gaussian infrastructure encapsulated by local bridges. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387 checked. Gate passed python3 tools/astis.py check. Remaining backend keeps scalar pushforward/law fields, raw Taylor fields, hRemainderGeneratorLimitDef, hRemainderMeas, hRemainderBound, and hRemainderBoundInt.
- Illness area candidate: discharges-supplied-hypothesis reviewer acceptance after gate pass: accepted cycle-192 dynamic-leaf worker packet. hBrownianCoordinateGeneratorSourceIntegralDef is discharged inside hBrownianCoordinateGeneratorTaylorIntegralDef by compiled SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs, using only local SALD declarations and Mathlib law-map/Gaussian infrastructure encapsulated by local bridges. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1170, appendix.tex:1379-1387 checked. Gate passed python3 tools/astis.py check. Remaining backend keeps scalar pushforward/law fields, raw Taylor fields, hRemainderGeneratorLimitDef, hRemainderMeas, hRemainderBound, and hRemainderBoundInt.
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

Shared dialogue board: `runs/20260612-053029-174468-ASTIS-SALD-001-cycle193/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260612-053029-174468-ASTIS-SALD-001-cycle193 --role lower_2 --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower_2 --kind handoff --status queued --artifact runs/20260612-053029-174468-ASTIS-SALD-001-cycle193 --notes "..."
```

## Role Instructions

Attempt one narrow proof-producing Lean task for the assigned active backend before creating more ledger-only obligations. Do not change the theorem target. Work on exactly one compiled theorem/proof block or one strictly smaller source-cited boundary, and name the paper-memory source line or technical-lemma registry entry used. Begin by naming the packet classification and the exact supplied hypothesis or missing theorem boundary. If this is a worker-style packet, stay inside the assigned local target/refinement region before asking for upstream changes; if it is a refiner-style packet, edit only the connected illness area named by middle. Do not work on unrelated display algebra, route audits, or general API cleanup unless the upper/middle packet explicitly assigns it. After cycle 84, a new supplied-hypothesis wrapper is acceptable only if it removes an older supplied hypothesis, exposes a strictly smaller missing theorem boundary, or produces a compiled local theorem using Mathlib/ASTIS technical-lemma ingredients. Do not add fake proof closures; if the analysis fact is not formalized, add a precise source-cited interface or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them. For SALD cycle 130 and later, treat the cycle-129 illness-area boundary as the live target unless the reviewer records a newer one: `hdiffusionSource` has been narrowed to the EM/Brownian diffusion generator weak action plus weak Laplacian integration-by-parts action. Do not reassign already-discharged leaves `hsampleInt`, `hsampleDerivMeas`, `hsampleDerivBound`, `hboundInt`, `hpathDeriv`, `hderivValue`, `hdriftBarBAction`, raw `hpairMeas`, or `hcanonicalBarBMeas`. For SALD cycle 151 and later, the reviewer-accepted cycle-150 boundary overrides older broad guards. The active EM conditional-law / weak-FP backend remains `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`, with source anchors `appendix.tex:984-995`, `appendix.tex:1368-1387`, and `appendix.tex:1379-1387`. Prioritize one direct definition/equality leaf at a time: `htraceFieldEqLaplacian`, `hemGeneratorLaplacianEventFieldEqTraceField`, `hemGeneratorLaplacianStateIntegral`, or `hsourceLaplacianFieldMeas`. Upper should choose the smallest leaf that reduces this boundary; middle should coordinate the proof route and split lower-agent roles; lower_1 should produce the natural-language/math route and lower_2 should implement exactly one compiled Lean theorem or a strictly smaller source-cited obligation. Reject new total-event/source-functional consumer wrappers unless they discharge one of these direct leaves. Reviewer must check that the remaining boundary is strictly smaller, not merely renamed, and that `python3 tools/astis.py check` passes. For SALD cycle 174 and later, the reviewer-accepted cycle-173 boundary overrides the older cycle-150 direct-leaf list. The active target is still the EM conditional-law / weak-FP Brownian/Ito backend, but the immediate live leaf is now the source-Hessian contract behind `SALD.selectedWeakTestHessianOpNormOfSourceHessianField`: `hSourceHasHessian : forall z, HasFDerivAt (fderiv Real sourceTest) (sourceHessian z) z` and `hSourceHessianBound : forall z, norm (sourceHessian z) <= C1`. Upper must decide whether these fields are paper assumptions or can be derived from selected-test regularity; middle must translate that decision into a single Lean theorem/proof-obligation with source anchors; lower_1 should give the natural-language Mathlib route, using ASTIS `TechnicalLemmas` first and external SLT Taylor/DCT/measure files only as port references; lower_2 should implement exactly one compiled theorem or strictly smaller source-cited boundary. Reject routes that define `sourceHessian` from the desired conclusion, reintroduce `SelectedWeakTestC2bBoundedHessian` without source support, use VP score-Hessian regularity for the selected weak test, import SLT as a dependency, call upstream SLT declarations directly, or return to consumer-wrapper churn. If the source-Hessian fields are confirmed absent from the paper source, keep the gap honest and move only to the next connected Brownian/Ito leaf: selected-line Taylor domination, Gaussian dominated-convergence integrability, quadratic-variation normalization, or per-coordinate Hessian generator identity. For SALD cycle 183 and later, the source-Hessian fields `hSourceHasHessian` and `hSourceHessianBound` are no longer an active proof target unless the original SALD source explicitly supplies the selected weak-test Hessian regularity. Treat them as a documented source-contract gap and move proof effort to the Brownian/Ito frozen backend tickets: `hBrownianCoordinateGeneratorTaylorIntegralDef`, `hRemainderGeneratorLimitDef`, conditional-drift weak-FP, KL derivative, and divergence/FI/IBP handoff. Reject source-Hessian wrapper churn, `testRegular` repackaging, VP score-Hessian substitution, direct SLT dependency use, or broad theorem-route replay.

Parallel lower specialization: you are the Lean proof implementer. First read the shared dialogue for the lower_1 natural-language proof scout handoff, then implement exactly one compiled Lean theorem or a strictly smaller source-cited boundary from that route. If lower_1's route is invalid, record the precise failure and implement the next smallest correct boundary instead. Keep the build green and do not broaden the target.
