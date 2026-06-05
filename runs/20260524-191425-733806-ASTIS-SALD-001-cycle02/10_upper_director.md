Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 2
Role: upper
Run directory: runs/20260524-191425-733806-ASTIS-SALD-001-cycle02

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
2026-05-24 19:03:48 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 19:06:26 middle/handoff queued gate=not-run :: Middle handoff: source-index refreshed with 24 SALD declarations; first appendix and KL/FI/LSI/PI contracts verified synchronized; python3 tools/astis.py check passed; Gronwall obligation and DV source-cited status preserved.
2026-05-24 19:06:41 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 19:10:20 lower/handoff queued gate=not-run :: Refined gronwall obligation into compiled candidate contract SALD.saldGronwallCandidateContract; synced conversion window and proof obligations; refreshed source index; check passed.
2026-05-24 19:10:49 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 19:13:39 reviewer/handoff queued gate=pass :: Reviewer accepted cycle 1: source index refreshed with 24 declarations excluding sald_version_2.tex; first appendix and KL/FI/LSI/PI contracts match source anchors; Gronwall obligation and DV source-cited status preserved; check passed.
2026-05-24 19:14:18 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 19:14:25 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260524-191425-733806-ASTIS-SALD-001-cycle02/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-191425-733806-ASTIS-SALD-001-cycle02 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260524-191425-733806-ASTIS-SALD-001-cycle02 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving.
