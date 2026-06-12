# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `187`
- Generated: `2026-06-12 02:31:48`

## Compact Task Contract

# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-186 dynamic-leaf worker packet. hSourceTaylorIntegrandPointwise narrowed by compiled SALD.selectedWeakTestSourceTaylorIntegrandPointwiseOfLineTermDefs to hSourceTaylorIntegrandDef, hSourceLinearTermDef, and hSourceQuadraticTermDef; hSourceLinearTermDef further narrowed by compiled SALD.selectedWeakTestSourceLinearTermDefOfScalarLineFirstCoeffDef to hSourceLinearTermTaylorDef and hScalarLineFirstCoeffDef. Source anchors appendix.tex:958-970, appendix.tex:984-995, appendix.tex:1170-1176, appendix.tex:1379-1387 checked; unfinished_source_map records the smaller backend. Gate passed python3 tools/astis.py check. No SLT import/upstream call, fake closure, wrapper churn, VP substitution, source-Hessian re-audit, or sigma_eta^2/2 event-field move. Remaining backend: hSourceTaylorIntegrandDef, hSourceLinearTermTaylorDef, hScalarLineFirstCoeffDef, hSourceQuadraticTermDef, scalar law/measurability fields, normalized-remainder fields, and hRemainderMeas/hRemainderBound/hRemainderBoundInt; hSourceHasHessian/hSou...

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.

## Cycle Focus

Cycle-183+ closure sprint: freeze `hSourceHasHessian` and `hSourceHessianBound` as an explicit source-contract gap unless the original SALD source is found to state the selected weak-test Hessian regularity verbatim. Do not spend the cycle on wrapper projections, `testRegular` repackaging, VP score-Hessian substitution, or source-Hessian re-audits. The active proof work is the connected Brownian/Ito frozen-interpolation backend: first close or strictly narrow `hBrownianCoordinateGeneratorTaylorIntegralDef` and `hRemainderGeneratorLimitDef`; then connect the same local backend to the conditional-drift weak-Fokker--Planck line `appendix.tex:1379-1387`, the KL derivative handoff `appendix.tex:1358-1365`, and the divergence/FI/IBP rewrite `appendix.tex:1422-1434`. Lower_1 should write the natural-language classical proof route for exactly one ticket, and lower_2 should implement one compiled ASTIS-owned theorem or record one strictly smaller source-cited obligation with typed verifier feedback.

## Recent High-Signal Handoffs

- narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-185 dynamic-leaf worker packet. hRemainderGeneratorLimitDef is narrowed by compiled SALD.selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw to hRemainderGeneratorNormalizedLawDef plus hNormalizedVectorLaw, hCoordinateLawDef, and hVarianceDef; hRemainderGeneratorNormalizedLawDef is further narrowed by compiled SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward to hScalarMeas, hNormalizedCoordina...
- narrows-source-cited-boundary upper dynamic-leaf worker packet after gate pass: assign hSourceTaylorIntegrandPointwise as the next Brownian/Ito frozen-interpolation boundary for hBrownianCoordinateGeneratorTaylorIntegralDef under sald.general_moving_target_discrete.em_interpolation_fp over appendix.tex:1358-1387, anchored at appendix.tex:984-995 and consumed by appendix.tex:1379-1387. Lower_1 route: scalar Taylor pointwise identity only. Lower_2: compile one ASTIS-owned theorem reducing hSourceTaylorIntegrandPoi...
- narrows-source-cited-boundary middle dynamic-leaf worker packet after gate pass: compiled SALD.selectedWeakTestSourceTaylorIntegrandPointwiseOfLineTermDefs narrows hSourceTaylorIntegrandPointwise to hSourceTaylorIntegrandDef, hSourceLinearTermDef, and hSourceQuadraticTermDef; source anchors appendix.tex:984-995, appendix.tex:1170-1176, appendix.tex:1379-1387; gate passed python3 tools/astis.py check; no SLT import/upstream call, wrapper churn, VP substitution, source-Hessian re-audit, fake closure, or sigma_eta^...
- lower_1 recorded as lower because astis.py role choices exclude lower_1. narrows-source-cited-boundary lower_1 dynamic-leaf proof-scout packet after gate pass: hSourceLinearTermDef narrowed to hSourceLinearTermTaylorDef plus hScalarLineFirstCoeffDef. Route artifact: runs/20260612-015813-121084-ASTIS-SALD-001-cycle186/lower_1_source_linear_term_route.md. Synchronized conversion-windows/ASTIS-SALD-001.md and proof-obligations/ASTIS-SALD-001.md. Lower_2-ready bridge: SALD.selectedWeakTestSourceLinearTermDefOfScalar...
- lower_2 recorded as lower because astis.py role choices exclude lower_2. narrows-source-cited-boundary lower_2 dynamic-leaf worker packet after gate pass: compiled SALD.selectedWeakTestSourceLinearTermDefOfScalarLineFirstCoeffDef, narrowing hSourceLinearTermDef to hSourceLinearTermTaylorDef and hScalarLineFirstCoeffDef. Source anchors appendix.tex:958-970, appendix.tex:984-995, appendix.tex:1170-1176, appendix.tex:1379-1387. Gate passed python3 tools/astis.py check. No SLT import/upstream call, fake closure, wra...
- narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-186 dynamic-leaf worker packet. hSourceTaylorIntegrandPointwise narrowed by compiled SALD.selectedWeakTestSourceTaylorIntegrandPointwiseOfLineTermDefs to hSourceTaylorIntegrandDef, hSourceLinearTermDef, and hSourceQuadraticTermDef; hSourceLinearTermDef further narrowed by compiled SALD.selectedWeakTestSourceLinearTermDefOfScalarLineFirstCoeffDef to hSourceLinearTermTaylorDef and hScalarLineFirstCoeffDef. Source anchors appendix.tex...

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
- Latest cycle: 186
- Dynamic leaf candidate: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-186 dynamic-leaf worker packet. hSourceTaylorIntegrandPointwise narrowed by compiled SALD.selectedWeakTestSourceTaylorIntegrandPointwiseOfLineTermDefs to hSourceTaylorIntegrandDef, hSourceLinearTermDef, and hSourceQuadraticTermDef; hSourceLinearTermDef further narrowed by compiled SALD.selectedWeakTestSourceLinearTermDefOfScalarLineFirstCoeffDef to hSourceLinearTermTaylorDef and hScalarLineFirstCoeffDef. Source anchors appendix.tex:958-970, appendix.tex:984-995, appendix.tex:1170-1176, appendix.tex:1379-1387 checked; unfinished_source_map records the smaller backend. Gate passed python3 tools/astis.py check. No SLT import/upstream call, fake closure, wrapper churn, VP substitution, source-Hessian re-audit, or sigma_eta^2/2 event-field move. Remaining backend: hSourceTaylorIntegrandDef, hSourceLinearTermTaylorDef, hScalarLineFirstCoeffDef, hSourceQuadraticTermDef, scalar law/measurability fields, normalized-remainder fields, and hRemainderMeas/hRemainderBound/hRemainderBoundInt; hSourceHasHessian/hSou...
- Illness area candidate: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-186 dynamic-leaf worker packet. hSourceTaylorIntegrandPointwise narrowed by compiled SALD.selectedWeakTestSourceTaylorIntegrandPointwiseOfLineTermDefs to hSourceTaylorIntegrandDef, hSourceLinearTermDef, and hSourceQuadraticTermDef; hSourceLinearTermDef further narrowed by compiled SALD.selectedWeakTestSourceLinearTermDefOfScalarLineFirstCoeffDef to hSourceLinearTermTaylorDef and hScalarLineFirstCoeffDef. Source anchors appendix.tex:958-970, appendix.tex:984-995, appendix.tex:1170-1176, appendix.tex:1379-1387 checked; unfinished_source_map records the smaller backend. Gate passed python3 tools/astis.py check. No SLT import/upstream call, fake closure, wrapper churn, VP substitution, source-Hessian re-audit, or sigma_eta^2/2 event-field move. Remaining backend: hSourceTaylorIntegrandDef, hSourceLinearTermTaylorDef, hScalarLineFirstCoeffDef, hSourceQuadraticTermDef, scalar law/measurability fields, normalized-remainder fields, and hRemainderMeas/hRemainderBound/hRemainderBoundInt; hSourceHasHessian/hSou...
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