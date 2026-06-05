Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 4
Role: lower
Run directory: runs/20260524-200351-331721-ASTIS-SALD-001-cycle04

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
2026-05-24 19:52:22 middle/handoff queued gate=pass :: Middle handoff: split discrete forward-KL Gronwall accumulation from linear-slowdown specialization; Lean contract data, conversion window, proof obligations, SLT audit, and source index synchronized; python3 tools/astis.py check passed.
2026-05-24 19:52:41 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 19:59:56 lower/handoff queued gate=not-run :: Split discrete EM interpolation setup into endpoint-law, conditional-drift/Fokker--Planck, and stitched-interval regularity obligations; synchronized Lean, conversion window, proof obligations, source index; check passed.
2026-05-24 20:00:22 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 20:02:35 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 3: source-index refreshed with 24 declarations excluding sald_version_2.tex; discrete forward-KL source correspondence and proof-status audit passed; analytic discrete pieces remain obligations/source-cited; check passed.
2026-05-24 20:03:35 reviewer/build compiled gate=pass :: Cycle 3 reviewer gate: source-index refreshed and python3 tools/astis.py check passed after handoff logging.
2026-05-24 20:03:44 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 20:03:51 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260524-200351-331721-ASTIS-SALD-001-cycle04/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-200351-331721-ASTIS-SALD-001-cycle04 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260524-200351-331721-ASTIS-SALD-001-cycle04 --notes "..."
```

## Role Instructions

Attempt one narrow Lean/source-index/proof-obligation task. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add or refine a ProofObligation and keep the build green.
