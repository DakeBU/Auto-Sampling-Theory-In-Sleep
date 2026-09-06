# ASTIS Compact Context Pack

- Task: `ASTIS-SALD-001`
- Cycle: `206`
- Generated: `2026-06-13 05:24:44`

## Compact Task Contract

# Faithfully reproduce the original VA-SALD paper proofs

Status: active faithfulPaper reproduction of the original VA-SALD paper.
Source: `/home/nitanda_sub/mark/repos/sald/paper`; exclude `sald_version_2.tex`.
Current phase: Phase 1 faithful transcript and proof backfill; Phase 2 API reorganization is deferred.

Current post-cycle-84 rule: do not add broad wrappers or broad theorem-route audits. Each cycle must either discharge one supplied hypothesis, strictly narrow one source-cited theorem boundary, or explicitly reject wrapper churn.

Active blocker:
narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-205 dynamic-leaf worker packet. Exact boundary narrowed: hSelectedLineTaylorRawSplitDef is recorded by compiled SALD.cycle205GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedLineTaylorRawSplitLower2Obligation/Dag with typed feedback leaf=hSelectedLineTaylorRawSplitDef error_class=source_contract_gap_missing_selected_line_taylor_raw_split_definition; it is not claimed proved. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1176, appendix.tex:1379-1387 checked against the original SALD source excluding sald_version_2.tex. Local ingredients only: existing SALD cycle-188/189/192/193 bridges and Mathlib deriv/taylorCoeffWithin/Set.univ notation; no external SLT import/call/queue, no source-Hessian/VP/endpoint/source-integrand replay, and no theorem-status promotion. Remaining gap: source-backed normalizedRemainder residual definition for the selected scalar Taylor line, or keep this as a source-c...

Allowed packet classifications:
- `discharges-supplied-hypothesis`: compiled local theorem removes an older supplied hypothesis.
- `narrows-source-cited-boundary`: exact missing theorem is smaller and source-cited with imports/hypotheses.
- `rejected-wrapper-churn`: proposed work only restates a supplied hypothesis or broad ledger.

## Cycle Focus

Cycle-183+ closure sprint: freeze `hSourceHasHessian` and `hSourceHessianBound` as an explicit source-contract gap unless the original SALD source is found to state the selected weak-test Hessian regularity verbatim. Do not spend the cycle on wrapper projections, `testRegular` repackaging, VP score-Hessian substitution, or source-Hessian re-audits. The active proof work is the connected Brownian/Ito frozen-interpolation backend: first close or strictly narrow `hBrownianCoordinateGeneratorTaylorIntegralDef` and `hRemainderGeneratorLimitDef`; then connect the same local backend to the conditional-drift weak-Fokker--Planck line `appendix.tex:1379-1387`, the KL derivative handoff `appendix.tex:1358-1365`, and the divergence/FI/IBP rewrite `appendix.tex:1422-1434`. Lower_1 should write the natural-language classical proof route for exactly one ticket, and lower_2 should implement one compiled ASTIS-owned theorem or record one strictly smaller source-cited obligation with typed verifier feedback.

## Recent High-Signal Handoffs

- narrows-source-cited-boundary dynamic-leaf worker packet after gate pass. Exact boundary hSelectedLineTaylorRawSplitDef with source anchors appendix.tex:958-970;appendix.tex:983-996;appendix.tex:1161-1176;appendix.tex:1379-1387. Run artifact middle_selected_line_taylor_raw_split_packet.md; conversion window and proof obligations updated. Local ingredients are existing SALD raw Taylor bridges and Mathlib deriv/taylorCoeffWithin/Set.univ notation; no external SLT import/call/queue. lower_2 fallback feedback leaf=h...
- rejected-wrapper-churn dynamic-leaf API-scout packet for hSelectedLineTaylorRawSplitDef; no lower_2 concrete missing technical lemma request and no local/SLT Taylor API can replace the missing source definition of normalizedRemainder as selected scalar-line residual; artifact lower_3_selected_line_taylor_api_churn_rejection.md; gate python3 tools/astis.py check passed.
- narrows-source-cited-boundary dynamic-leaf worker packet: lower_1 route for hSelectedLineTaylorRawSplitDef added at runs/20260613-050236-675526-ASTIS-SALD-001-cycle205/lower_1_selected_line_taylor_raw_split_route.md; source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1176, appendix.tex:1379-1387; lower_2 handoff is residual-definition rewrite if reducible, otherwise typed ProofObligation leaf=hSelectedLineTaylorRawSplitDef error_class=source_contract_gap_missing_selected_line_taylor_raw...
- narrows-source-cited-boundary dynamic-leaf worker packet: compiled cycle205 selected-line raw Taylor split source obligation; gate passed.
- narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-205 dynamic-leaf worker packet. Exact boundary narrowed: hSelectedLineTaylorRawSplitDef is recorded by compiled SALD.cycle205GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedLineTaylorRawSplitLower2Obligation/Dag with typed feedback leaf=hSelectedLineTaylorRawSplitDef error_class=source_contract_gap_missing_selected_line_taylor_raw_split_definition; it is not claimed proved. Gate passed: pytho...
- narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-205 dynamic-leaf worker packet. Exact boundary narrowed: hSelectedLineTaylorRawSplitDef is recorded by compiled SALD.cycle205GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedLineTaylorRawSplitLower2Obligation/Dag with typed feedback leaf=hSelectedLineTaylorRawSplitDef error_class=source_contract_gap_missing_selected_line_taylor_raw_split_definition; it is not claimed proved. Gate passed: pytho...

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
- Latest cycle: 205
- Dynamic leaf candidate: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-205 dynamic-leaf worker packet. Exact boundary narrowed: hSelectedLineTaylorRawSplitDef is recorded by compiled SALD.cycle205GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedLineTaylorRawSplitLower2Obligation/Dag with typed feedback leaf=hSelectedLineTaylorRawSplitDef error_class=source_contract_gap_missing_selected_line_taylor_raw_split_definition; it is not claimed proved. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1176, appendix.tex:1379-1387 checked against the original SALD source excluding sald_version_2.tex. Local ingredients only: existing SALD cycle-188/189/192/193 bridges and Mathlib deriv/taylorCoeffWithin/Set.univ notation; no external SLT import/call/queue, no source-Hessian/VP/endpoint/source-integrand replay, and no theorem-status promotion. Remaining gap: source-backed normalizedRemainder residual definition for the selected scalar Taylor line, or keep this as a source-c...
- Illness area candidate: narrows-source-cited-boundary reviewer acceptance after gate pass: accepted cycle-205 dynamic-leaf worker packet. Exact boundary narrowed: hSelectedLineTaylorRawSplitDef is recorded by compiled SALD.cycle205GeneralMovingTargetDiscreteEmGeneratorLaplacianEventFieldFrozenScalarBrownianItoSelectedLineTaylorRawSplitLower2Obligation/Dag with typed feedback leaf=hSelectedLineTaylorRawSplitDef error_class=source_contract_gap_missing_selected_line_taylor_raw_split_definition; it is not claimed proved. Gate passed: python3 tools/astis.py check. Source anchors appendix.tex:958-970, appendix.tex:983-996, appendix.tex:1161-1176, appendix.tex:1379-1387 checked against the original SALD source excluding sald_version_2.tex. Local ingredients only: existing SALD cycle-188/189/192/193 bridges and Mathlib deriv/taylorCoeffWithin/Set.univ notation; no external SLT import/call/queue, no source-Hessian/VP/endpoint/source-integrand replay, and no theorem-status promotion. Remaining gap: source-backed normalizedRemainder residual definition for the selected scalar Taylor line, or keep this as a source-c...
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