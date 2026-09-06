Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 38
Role: upper
Run directory: runs/20260525-173305-586747-ASTIS-SALD-001-cycle38

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
Proof-closure sprint 3: LSI/KL/FI: Translate `main_body.tex:202-215` into Lean proof-producing code for the LSI-to-KL/FI bridge, starting from density/test-function and coefficient sublemmas.
```

Recent trial memory:

```text
2026-05-25 17:13:35 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 17:23:21 middle/handoff queued gate=not-run :: Cycle 37 middle compiled one-sided tilted-measure DV backend AutoSamplingTheory.dvVariationalOneSidedOfTiltedRight for appendix.tex:73-79; full DV supremum equality remains source-cited; ledgers synchronized; ASTIS check passed.
2026-05-25 17:24:08 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 17:29:45 lower/handoff queued gate=not-run :: Cycle 37 lower compiled AutoSamplingTheory.dvVariationalTiltedRightOneSidedConsequence, composing the Mathlib tilted one-sided DV backend with the scalar rearrangement to obtain E_nu[Z] <= KL(nu||mu)+log E_mu[exp Z] under explicit selected-test hypotheses; synchronized SALD lower obligation and ledgers; DV supremum equality remains sourceCited; ASTIS check passed.
2026-05-25 17:30:10 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 17:32:30 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 37: python3 tools/astis.py check passed; one-sided DV tilted backend and consequence compile under explicit hypotheses; full Boucheron Cor. 4.15 supremum equality remains sourceCited through SALD.dvContract/probability.dv_variational_formula; no fake closure, source drift, hidden theorem-assumption promotion, SLT import, or status promotion found.
2026-05-25 17:32:56 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 17:33:05 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-173305-586747-ASTIS-SALD-001-cycle38/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-173305-586747-ASTIS-SALD-001-cycle38 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-173305-586747-ASTIS-SALD-001-cycle38 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and now prioritize proof closure over new transcript/ledger expansion. Before assigning middle/lower work, explicitly check the current proof-closure order: (1) Gronwall, (2) DV, (3) LSI/KL/FI, (4) forward-KL Fokker--Planck/KL derivative, (5) EM interpolation Fokker--Planck. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized.
