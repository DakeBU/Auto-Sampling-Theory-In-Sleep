Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 28
Role: lower
Run directory: runs/20260525-065724-310530-ASTIS-SALD-001-cycle28

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

## Acceptance Gate

```bash
python3 tools/astis.py source-index ASTIS-SALD-001
python3 tools/astis.py check
```
```

Cycle focus:

```text
Guided and general VA-SALD path: `prop:guided_path_residual`, `thm:general-moving-target-SALD`, `thm:unified-forward-KL`, and `thm:general-moving-target-SALD-discrete`.
```

Recent trial memory:

```text
2026-05-25 06:37:46 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 06:44:16 middle/handoff queued gate=not-run :: Cycle 27 middle added SALD.cycle27DiscreteForwardKlMiddleContract plus sald.discrete_forward_kl.cycle27_accumulated_collection_middle for thm:forward-KL-discrete accumulated-error bridge; synchronized ledgers; source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 06:44:41 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 06:54:12 lower/handoff queued gate=not-run :: Cycle 27 lower compiled additive accumulated-error collection scalar/integral cores for thm:forward-KL-discrete (alpha-complexity and Delta constant-factor extraction plus combined additive collection), synchronized SALD.lean, conversion window, proof obligations, SLT audit, and source dependencies; source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 06:54:45 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 06:56:52 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 27: source-index refreshed 24 declarations and python3 tools/astis.py check passed. Accepted only the compiled additive accumulated-error scalar/integral collection core and synchronized ledgers; theorem-level thm:forward-KL-discrete and analytic backends remain obligations.
2026-05-25 06:57:16 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 06:57:24 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-065724-310530-ASTIS-SALD-001-cycle28/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-065724-310530-ASTIS-SALD-001-cycle28 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260525-065724-310530-ASTIS-SALD-001-cycle28 --notes "..."
```

## Role Instructions

Attempt one narrow Lean/source-index/proof-obligation task. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them.
