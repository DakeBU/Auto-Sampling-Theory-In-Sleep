Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 32
Role: lower
Run directory: runs/20260525-143724-852971-ASTIS-SALD-001-cycle32

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
Proof-closure sprint 2: Donsker--Varadhan: Translate `appendix.tex:73-79` and the cited DV result into a precise Lean interface or proof; if source-cited, keep status source-cited and use it as an explicit dependency only.
```

Recent trial memory:

```text
2026-05-25 14:15:19 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 14:26:08 middle/handoff queued gate=not-run :: Cycle 31 middle added proof-producing Gronwall integrating-factor derivative helpers for appendix.tex:58-61, synchronized ledgers/conversion window, kept lem:gronwall obligation status for endpoint/order-integration backend, and passed python3 tools/astis.py check.
2026-05-25 14:27:21 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 14:33:51 lower/handoff queued gate=not-run :: Cycle 31 lower added compiled Gronwall order-integration and endpoint scalar helpers for appendix.tex:62-65, updated SALD ledgers, and passed python3 tools/astis.py check.
2026-05-25 14:34:37 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 14:36:57 reviewer/handoff queued gate=pass :: Reviewer accepted cycle 31 after source-index ASTIS-SALD-001 and python3 tools/astis.py check passed. Gronwall appendix.tex:58-65 helpers compile as partial sublemmas; lem:gronwall remains obligation with endpoint-safe derivative/integrability and final exponent rewrite inputs still open. No fake closures, status drift, hidden assumptions, source-index-only drift, or SLT promotion found.
2026-05-25 14:37:15 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 14:37:24 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-143724-852971-ASTIS-SALD-001-cycle32/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-143724-852971-ASTIS-SALD-001-cycle32 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260525-143724-852971-ASTIS-SALD-001-cycle32 --notes "..."
```

## Role Instructions

Attempt one narrow proof-producing Lean task before creating more ledger-only obligations. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add a precise source-cited interface or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them.
