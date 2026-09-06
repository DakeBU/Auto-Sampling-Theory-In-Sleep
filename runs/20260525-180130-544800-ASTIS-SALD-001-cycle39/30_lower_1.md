Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 39
Role: lower
Run directory: runs/20260525-180130-544800-ASTIS-SALD-001-cycle39

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
Proof-closure sprint 4: forward-KL derivative: Translate `appendix.tex:168-228` into the forward-KL Fokker--Planck/KL derivative identity; close theorem-specific derivative lemmas before more ledger work.
```

Recent trial memory:

```text
2026-05-25 17:40:13 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 17:49:02 middle/handoff queued gate=not-run :: Cycle 38 middle compiled scalar LSI/KL/FI Fisher-chain progress for main_body.tex:208-215: positive-density sqrt/log derivative coefficient, named derivative wrapper, displayed KL/FI to half-Fisher handoff, and density-test half-Fisher composition. Synchronized ledgers and tests; source-index and ASTIS check passed; full vector/integral LSI-to-KL/FI backend remains obligation.
2026-05-25 17:49:34 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 17:57:57 lower/handoff queued gate=not-run :: Cycle 38 lower compiled finite-coordinate LSI/KL/FI Fisher-chain handoff lemmas for main_body.tex:208-215; synchronized ledgers; source-index and ASTIS check passed; full LSI-to-KL/FI backend remains obligation.
2026-05-25 17:58:24 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 18:00:59 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 38: source-index audit passed, ASTIS check passed, LSI/KL/FI scalar and finite-coordinate Fisher-chain sublemmas compile; full density-test LSI-to-KL/FI remains obligation; no fake closure, source drift, hidden theorem-assumption promotion, SLT import, or status promotion found.
2026-05-25 18:01:21 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 18:01:30 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-180130-544800-ASTIS-SALD-001-cycle39/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-180130-544800-ASTIS-SALD-001-cycle39 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260525-180130-544800-ASTIS-SALD-001-cycle39 --notes "..."
```

## Role Instructions

Attempt one narrow proof-producing Lean task before creating more ledger-only obligations. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add a precise source-cited interface or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them.
