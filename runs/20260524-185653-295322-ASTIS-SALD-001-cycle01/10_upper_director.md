Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 1
Role: upper
Run directory: runs/20260524-185653-295322-ASTIS-SALD-001-cycle01

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
2026-05-24 18:45:47 upper/plan queued gate=not-run :: sleep-run dry-run prompt deck
2026-05-24 18:45:47 upper/plan queued gate=not-run :: sleep-run dry-run prompt deck
```

Shared dialogue board: `runs/20260524-185653-295322-ASTIS-SALD-001-cycle01/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-185653-295322-ASTIS-SALD-001-cycle01 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260524-185653-295322-ASTIS-SALD-001-cycle01 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving.
