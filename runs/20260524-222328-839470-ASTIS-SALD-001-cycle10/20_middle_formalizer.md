Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 10
Role: middle
Run directory: runs/20260524-222328-839470-ASTIS-SALD-001-cycle10

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
2026-05-24 22:08:22 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 22:15:08 middle/handoff queued gate=pass :: Middle handoff: added first-layer DV finite-log-mgf/common-space contract and PI velocity-norm Sobolev/Riesz backend contract; synchronized conversion window, proof obligations, SLT reuse audit, and first-DAG dependencies; source-index refreshed; check passed.
2026-05-24 22:15:43 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 22:20:35 lower/handoff queued gate=not-run :: Lower handoff: added Gronwall endpoint-calculus side-condition contract/obligation for appendix.tex lines 55-69; synchronized conversion window, proof obligations, SLT audit, and first-DAG dependencies; source-index refreshed; python3 tools/astis.py check passed.
2026-05-24 22:21:06 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 22:22:56 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 9: source-index refreshed with 24 declarations; audited first appendix/vocabulary source anchors, proof-DAG statuses, fake-proof scan, and SLT reuse; sald_version_2.tex excluded; python3 tools/astis.py check passed.
2026-05-24 22:23:21 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 22:23:28 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260524-222328-839470-ASTIS-SALD-001-cycle10/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-222328-839470-ASTIS-SALD-001-cycle10 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260524-222328-839470-ASTIS-SALD-001-cycle10 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and map each proof step to Lean, cited result, or obligation.
