Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 31
Role: middle
Run directory: runs/20260525-141054-155782-ASTIS-SALD-001-cycle31

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
2026-05-25 08:03:02 middle/handoff queued gate=not-run :: Cycle 30 middle added SALD.cycle30ForwardKlMiddleContract and sald.forward_kl.cycle30_derivative_side_middle for appendix.tex:168-208, selecting appendix.tex:168-185 density/boundary/FI identification as the first lower slice; synchronized ledgers/source dependencies/SLT audit/source-index and passed python3 tools/astis.py check.
2026-05-25 08:03:25 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 08:11:18 lower/handoff queued gate=not-run :: Cycle 30 lower compiled SALD.forwardKlFirstTermFisherSubstitutionScalar and recorded SALD.cycle30ForwardKlDensityBoundaryLowerObligation for appendix.tex:168-185 first-term -FI scalar substitution; synchronized ledgers/source dependencies/SLT audit/source-index; python3 tools/astis.py check passed.
2026-05-25 08:11:44 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 08:16:17 reviewer/handoff queued gate=pass :: Reviewer accepted cycle 30 after source-index repair for labelled equation/align anchors; refreshed SALD_original.jsonl now includes eq:SALD and eq:FP-eq, excludes sald_version_2.tex, and python3 tools/astis.py check passed. Cycle 30 lower scalar substitution accepted only as theorem-independent Real equality; analytic derivative, density/boundary/FI, target transport, LSI, DV, time-change, and Gronwall remain obligations.
2026-05-25 08:17:00 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 08:17:09 reviewer/build compiled gate=pass :: Cycle build gate.
2026-05-25 08:17:09 upper/compression accepted gate=not-run :: Graceful sleep window completed 15 cycle(s); final cycle was not interrupted.
```

Shared dialogue board: `runs/20260525-141054-155782-ASTIS-SALD-001-cycle31/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-141054-155782-ASTIS-SALD-001-cycle31 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260525-141054-155782-ASTIS-SALD-001-cycle31 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and translate the paper proof into proof-producing Lean targets first; only add obligations when proof-producing code is genuinely blocked. Check the proof-closure order before planning: Gronwall, DV, LSI/KL/FI, forward-KL derivative, then EM interpolation Fokker--Planck. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During this sprint, avoid broad rebaseline work and avoid systematic SLT/SDE library import until the source-cited theorem interfaces needed by the five closure targets are precise. Export the Overleaf-ready project article only at the end of a multi-hour batch.
