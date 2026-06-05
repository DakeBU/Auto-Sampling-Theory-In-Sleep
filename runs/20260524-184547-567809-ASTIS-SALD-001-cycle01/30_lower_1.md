Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 1
Role: lower
Run directory: runs/20260524-184547-567809-ASTIS-SALD-001-cycle01

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

Recent trial memory:

```text
no trial records yet
```

Shared dialogue board: `runs/20260524-184547-567809-ASTIS-SALD-001-cycle01/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-184547-567809-ASTIS-SALD-001-cycle01 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260524-184547-567809-ASTIS-SALD-001-cycle01 --notes "..."
```

## Role Instructions

Attempt one narrow Lean/source-index/proof-obligation task. Do not change the theorem target.
