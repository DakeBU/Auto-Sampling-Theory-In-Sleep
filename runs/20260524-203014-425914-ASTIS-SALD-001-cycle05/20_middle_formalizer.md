Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 5
Role: middle
Run directory: runs/20260524-203014-425914-ASTIS-SALD-001-cycle05

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
Source-index and first appendix contracts: `lem:gronwall`, `lem:dv_variation`, `def:PI`, and KL/FI/LSI vocabulary.
```

Recent trial memory:

```text
2026-05-24 20:21:18 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 20:26:51 lower/handoff queued gate=not-run :: Refined discrete general VA-SALD derivative side-condition interface; synchronized Lean contract data, conversion window, proof obligations, and source index; python3 tools/astis.py check passed.
2026-05-24 20:27:12 lower/build compiled gate=pass :: Lower gate: source-index refreshed and python3 tools/astis.py check passed after discrete general derivative side-condition refinement.
2026-05-24 20:27:39 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 20:29:18 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 4: source-index refreshed with 24 declarations; source correspondence for prop:guided_path_residual, thm:general-moving-target-SALD, thm:unified-forward-KL, and thm:general-moving-target-SALD-discrete audited against main_body.tex and appendix.tex; analytic steps remain obligations/source-cited; check passed.
2026-05-24 20:29:39 reviewer/build compiled gate=not-run :: Cycle 4 reviewer final gate: source-index refreshed and python3 tools/astis.py check passed after handoff logging.
2026-05-24 20:30:07 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 20:30:14 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260524-203014-425914-ASTIS-SALD-001-cycle05/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-203014-425914-ASTIS-SALD-001-cycle05 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260524-203014-425914-ASTIS-SALD-001-cycle05 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and map each proof step to Lean, cited result, or obligation.
