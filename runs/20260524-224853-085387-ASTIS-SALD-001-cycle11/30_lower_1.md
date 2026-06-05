Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 11
Role: lower
Run directory: runs/20260524-224853-085387-ASTIS-SALD-001-cycle11

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
Discrete forward-KL theorem: `thm:forward-KL-discrete`, Euler--Maruyama interpolation, one-step defects, and accumulated error.
```

Recent trial memory:

```text
2026-05-24 22:31:33 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 22:38:20 middle/handoff queued gate=not-run :: Middle handoff: added theorem-specific forward-KL DV finite-log-mgf witness contract/obligation for appendix.tex lines 230-241; synchronized conversion window, proof obligations, SLT reuse audit, and proof DAG; source-index refreshed; check passed.
2026-05-24 22:38:53 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 22:45:00 lower/handoff queued gate=not-run :: Lower handoff: added forward-KL DV alpha0-to-alpha finite-log-mgf monotonicity contract/obligation; synchronized Lean contract, DAG, conversion window, proof obligations, SLT audit, and source index; check passed.
2026-05-24 22:45:23 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 22:48:16 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 10: source-index refreshed with 24 declarations; audited forward-KL source correspondence, moving-target/DV/Gronwall obligations, fake-proof scan, and SLT reuse audit; check passed.
2026-05-24 22:48:45 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 22:48:53 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260524-224853-085387-ASTIS-SALD-001-cycle11/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-224853-085387-ASTIS-SALD-001-cycle11 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260524-224853-085387-ASTIS-SALD-001-cycle11 --notes "..."
```

## Role Instructions

Attempt one narrow Lean/source-index/proof-obligation task. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add or refine a ProofObligation and keep the build green.
