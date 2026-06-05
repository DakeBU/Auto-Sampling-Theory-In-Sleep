Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 14
Role: middle
Run directory: runs/20260525-001418-949141-ASTIS-SALD-001-cycle14

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
Continuous forward-KL theorem: `thm:forward-KL`, moving-target assumptions, and the Gronwall/DV/LSI dependency chain.
```

Recent trial memory:

```text
2026-05-24 23:56:58 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 00:03:42 middle/handoff queued gate=not-run :: Middle handoff: added cycle13 first-appendix middle source-to-Lean map and obligation; synchronized Lean, conversion window, proof obligations, SLT audit, and source index; source-index 24 declarations and check passed.
2026-05-25 00:04:09 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 00:10:06 lower/handoff queued gate=not-run :: Lower handoff: isolated appendix.tex:63-69 Gronwall exponent rewrite as a named Lean-facing contract/obligation; synchronized conversion window, proof-obligation ledger, SLT audit, and first-DAG dependencies; source-index refreshed 24 declarations and check passed.
2026-05-25 00:10:34 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 00:13:40 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 13: source-index refreshed with 24 declarations; first appendix source correspondence and contract statuses audited; no contract drift or fake proof closure found; check passed.
2026-05-25 00:14:11 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 00:14:18 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-001418-949141-ASTIS-SALD-001-cycle14/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-001418-949141-ASTIS-SALD-001-cycle14 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260525-001418-949141-ASTIS-SALD-001-cycle14 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and map each proof step to Lean, cited result, or obligation.
