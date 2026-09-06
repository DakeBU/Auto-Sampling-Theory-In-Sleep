Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 36
Role: upper
Run directory: runs/20260525-162800-267685-ASTIS-SALD-001-cycle36

Mandatory gate:

```bash
python3 tools/astis.py check
```

Task contract:

```text
# Faithfully reproduce the original VA-SALD paper proofs

Task id: `ASTIS-SALD-001`
Kind: `paperReproduction`
Mode: `faithfulPaper`
Status: `active`

## Goal

Reproduce the proof structure of `/home/nitanda_sub/mark/repos/sald/paper` in
Lean-facing contracts and, incrementally, Lean proofs.  The source file
`sald_version_2.tex` is explicitly out of scope.

## First Proof DAG

- `lem:gronwall`
- `lem:dv_variation`
- LSI/KL/FI definitions
- `thm:forward-KL`
- `thm:forward-KL-discrete`
- `prop:guided_path_residual`
- `thm:general-moving-target-SALD`
- `thm:unified-forward-KL`
- `thm:general-moving-target-SALD-discrete`

## Current 6h Priority: Proof Closure Sprint

The first transcript pass is broad enough to stop spending cycles on
rebaseline/source-index work unless a reviewer finds a blocking source anchor
gap.  The next batch should prioritize translating the paper's actual LaTeX
proofs into Lean code and closing theorem dependencies in this order:

1. `lem:gronwall`
2. `lem:dv_variation`
3. `eq:LSI-KL-FI`
4. the forward-KL Fokker--Planck/KL derivative identity
5. the Euler--Maruyama interpolation Fokker--Planck backend

Upper and middle agents must explicitly check this priority before assigning
lower work.  Lower agents should attempt proof-producing Lean lemmas first.
If a source-cited analytic theorem is too large for the current local Mathlib
state, create a precise source-cited theorem interface and use it only as an
explicit dependency; do not mark it formalized.  Systematic migration of
external SDE/Sampling facts, including material analogous to
`YuanheZ/lean-stat-learning-theory`, belongs after these proof-closure
interfaces are in place.

## Acceptance Gate

```bash
python3 tools/astis.py source-index ASTIS-SALD-001
python3 tools/astis.py check
```
```

Cycle focus:

```text
Proof-closure sprint 1: Gronwall: Translate `appendix.tex:47-71` into Lean proof-producing code for `lem:gronwall`; avoid another source-index rebaseline unless reviewer finds a blocking anchor gap.
```

Recent trial memory:

```text
2026-05-25 16:08:48 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 16:17:37 middle/handoff queued gate=not-run :: Cycle 35 middle added compiled endpoint-vector and divergence-regrouping algebra for appendix.tex:260-385 EM interpolation FP backend; synchronized conversion window, proof obligations, SLT audit, DAG/dependencies, and kept analytic endpoint/conditional-FP backends as obligations. source-index ASTIS-SALD-001 and ASTIS check passed.
2026-05-25 16:17:59 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 16:25:04 lower/handoff queued gate=not-run :: Cycle 35 lower compiled SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff for appendix.tex:357-385 and synchronized the cycle35 EM-FP lower obligation/DAG/docs; analytic conditional drift density, conditional-FP theorem, Laplacian chain rule, KL integration by parts, endpoint stitching, LSI, DV, Gronwall, and accumulated-error collection remain obligations. source-index ASTIS-SALD-001 and ASTIS check passed.
2026-05-25 16:25:31 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 16:27:35 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 35: source-index refreshed 103 declarations and ASTIS check passed. Cycle 35 EM interpolation endpoint/vector and conditional-FP regrouping Lean lemmas are local algebra only; analytic FP, density, endpoint-law, integration-by-parts, stitched regularity, LSI, DV, Gronwall, and accumulated-error dependencies remain obligations. No fake proof closure, source drift, SLT promotion, or theorem-constant change found.
2026-05-25 16:27:51 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 16:28:00 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-162800-267685-ASTIS-SALD-001-cycle36/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-162800-267685-ASTIS-SALD-001-cycle36 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-162800-267685-ASTIS-SALD-001-cycle36 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and now prioritize proof closure over new transcript/ledger expansion. Before assigning middle/lower work, explicitly check the current proof-closure order: (1) Gronwall, (2) DV, (3) LSI/KL/FI, (4) forward-KL Fokker--Planck/KL derivative, (5) EM interpolation Fokker--Planck. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized.

## Upper Packet

Priority check before lower assignment: (1) `lem:gronwall` remains open after
cycle 31 local derivative/order/endpoint/exponent helpers, (2)
`lem:dv_variation` remains source-cited with cycle 32 scalar consequences, (3)
`eq:LSI-KL-FI` remains open after cycle 33 density-test scalar lemmas, (4) the
forward-KL Fokker--Planck/KL derivative identity still depends on analytic
backends after cycle 34 scalar handoffs, and (5) the EM interpolation
Fokker--Planck backend has only cycle 35 endpoint/divergence algebra. Cycle 36
therefore returns to item (1), `appendix.tex:47-71`.

Objective: translate the original Gronwall integrating-factor proof into a
proof-producing Lean assembly target while keeping `SALD.gronwallContract` at
obligation status until the global closed-interval calculus backend builds.

Mode discipline:

- `faithfulPaper`; use only original `appendix.tex:47-71`, with
  `sald_version_2.tex` excluded.
- Preserve the source theorem exactly: continuous `a_t,b_t`, differentiable
  `K_t` on `[0,t_1]`, `dK/dt <= -a_t*K_t+b_t`, and the final display with
  `exp(-int_0^t1 a)` and `exp(-int_t^t1 a)`.
- Use cycle 31 compiled helpers only as local dependencies; do not import an
  alternate Gronwall theorem or add sign assumptions on `a` or `b`.

Lower packet:

- target `SALD.saldGronwallCandidateContract`,
  `SALD.saldGronwallEndpointCalculusContract`,
  `SALD.saldGronwallExponentRewriteContract`, and obligations
  `sald.gronwall.integrating_factor`, `sald.gronwall.endpoint_calculus`,
  `sald.gronwall.exponent_rewrite`;
- first attempt one proof-producing assembly lemma under explicit global
  interval hypotheses, reusing
  `SALD.gronwallIntegratingFactorDerivativeLeOfIntegral`,
  `SALD.gronwallOrderIntegrationOfHasDerivAt`,
  `SALD.gronwallEndpointEvaluationScalar`,
  `SALD.gronwallEndpointMultiplyByExpNegScalar`, and
  `SALD.gronwallExpProductRewriteIntegralCongr`;
- if endpoint-safe differentiability or interval FTC blocks the proof, record
  one precise calculus interface and keep it below formalized status.

Reviewer checklist:

- `SALD.gronwallContract` remains `ProofStatus.obligation`.
- `SALD.saldDependenciesForLabel "lem:gronwall"` includes
  `SALD.cycle36GronwallUpperPacket` and
  `sald.gronwall.cycle36_upper_packet`.
- No source-index rebaseline, theorem-constant change, hidden sign assumption,
  alternate Gronwall theorem, or fake proof closure appears.
