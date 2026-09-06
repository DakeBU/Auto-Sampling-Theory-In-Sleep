Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 35
Role: upper
Run directory: runs/20260525-160022-322532-ASTIS-SALD-001-cycle35

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
Proof-closure sprint 5: EM interpolation Fokker--Planck: Translate `appendix.tex:260-385` into the Euler--Maruyama interpolation endpoint and conditional-drift Fokker--Planck backend.
```

Recent trial memory:

```text
2026-05-25 15:49:38 middle/handoff queued gate=not-run :: Cycle 34 middle compiled SALD.forwardKlTimeChangedDerivativeBoundScalar for forward-KL appendix.tex:218-228 and synchronized SALD.cycle34ForwardKlDerivativeMiddleContract plus ledgers; source-index ASTIS-SALD-001 and ASTIS check passed.
2026-05-25 15:50:07 middle/attempt accepted gate=not-run :: External agent command exit code 0.

## Upper Packet

Priority check before assigning lower work: (1) `lem:gronwall` remains open
after cycle 31 local real-analysis sublemmas, (2) `lem:dv_variation` remains
source-cited with cycle 32 scalar consequences, (3) `eq:LSI-KL-FI` remains
open after cycle 33 density-test scalar lemmas, and (4) the continuous
forward-KL derivative has cycle 34 scalar handoffs but still depends on
analytic Fokker--Planck inputs.  Cycle 35 therefore targets item (5), the
Euler--Maruyama interpolation endpoint and conditional-drift Fokker--Planck
backend in `appendix.tex:260-385`.

Objective: keep `thm:forward-KL-discrete` fixed and reselect the existing EM
endpoint/conditional-FP interfaces for proof closure, without reopening
discrete coefficient-chain or accumulated-error work.

Mode discipline:

- `faithfulPaper`; use only original `main_body.tex` and `appendix.tex`, with
  `sald_version_2.tex` excluded.
- Preserve `t(s)=s/r`, `Gamma`, `Delta`, `barGamma`, `barDelta`, `alpha`,
  `alpha'`, `eta`, `r`, and the theorem step-size condition.
- Keep endpoint laws, conditional expectation/disintegration, density,
  Fokker--Planck, Laplacian split, boundary integration by parts, stitched
  regularity, LSI, DV, and Gronwall as obligations unless a compiled local
  proof replaces exactly one named interface.

Lower packet:

- target exactly `SALD.discreteForwardKlEmInterpolationSideConditionContract`
  and `SALD.discreteForwardKlEmConditionalFpObligation`;
- first attempt one proof-producing Lean interface: endpoint-law algebra for
  the frozen interpolation, or the conditional-law/density/measurability
  interface for `bar b_{k,s}`;
- if the conditional-drift Fokker--Planck theorem is too large, create a
  precise source-cited theorem interface depending on
  `sald.discrete_forward_kl.conditional_drift_density`, and keep it below
  formalized status;
- leave endpoint stitching, frozen Gamma/Delta, LSI, DV, Gronwall, and
  accumulated-error collection as sibling obligations.

Reviewer checklist:

- `SALD.discreteForwardKlProofDag` includes
  `ASTIS.SALD.forward_KL_discrete.cycle35_em_fp_upper`.
- `SALD.discreteSaldContract` lists
  `SALD.cycle35DiscreteForwardKlEmFpUpperObligation`.
- `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` includes the
  cycle 35 packet and obligation while retaining cycle 15 EM obligations.
- No source theorem, constant, file selection, or analytic dependency status
  changes; mandatory gate passes.
2026-05-25 15:57:26 lower/handoff queued gate=not-run :: Cycle 34 lower proof-producing slice: added SALD.forwardKlTargetTransportYoungBoundScalar and SALD.forwardKlPostYoungDerivativeBoundOfCauchyScalar for appendix.tex:199-208 target-side Cauchy-Young bookkeeping; registered sald.forward_kl.cycle34_target_young_lower and kept analytic transport/Cauchy, KL derivative, LSI, time-change, DV, and Gronwall as obligations. source-index ASTIS-SALD-001 and python3 tools/astis.py check passed.
2026-05-25 15:57:51 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 15:59:40 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 34: source-index ASTIS-SALD-001 and python3 tools/astis.py check passed. Cycle 34 forward-KL scalar lemmas compile and are faithful to appendix.tex:168-228 without promoting analytic KL derivative, Fokker-Planck, integration by parts, target Cauchy, LSI, schedule time-change, DV, or Gronwall obligations; no fake closures or SLT drift found.
2026-05-25 15:59:59 reviewer/build compiled gate=pass :: Cycle 34 reviewer gate: source-index ASTIS-SALD-001 refreshed 103 declarations; python3 tools/astis.py check passed after Lake build and Tests build.
2026-05-25 16:00:13 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 16:00:22 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-160022-322532-ASTIS-SALD-001-cycle35/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-160022-322532-ASTIS-SALD-001-cycle35 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-160022-322532-ASTIS-SALD-001-cycle35 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and now prioritize proof closure over new transcript/ledger expansion. Before assigning middle/lower work, explicitly check the current proof-closure order: (1) Gronwall, (2) DV, (3) LSI/KL/FI, (4) forward-KL Fokker--Planck/KL derivative, (5) EM interpolation Fokker--Planck. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized.
