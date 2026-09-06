Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 21
Role: upper
Run directory: runs/20260525-040849-643035-ASTIS-SALD-001-cycle21

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
2026-05-25 03:59:18 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:05:22 lower/handoff queued gate=not-run :: Cycle 20 lower formalized the constant-schedule coefficient rewrite scalar core for sald.general_moving_target_discrete.gronwall_side_conditions: inverse-schedule square, doubled residual, Gamma, and Delta coefficient algebra. Ledgers synchronized; source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 04:05:42 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:07:58 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 20: source-index refreshed 24 declarations and python3 tools/astis.py check passed. Accepted only the compiled scalar coefficient algebra helpers for sald.general_moving_target_discrete.gronwall_side_conditions; theorem-level discrete general VA-SALD proof, Gronwall/display matching, endpoint stitching, coefficient regularity, DV, LSI-to-KL/FI, and KL derivative remain obligations/source-cited.
2026-05-25 04:08:13 reviewer/source-index indexed gate=not-run :: Reviewer refreshed source index for ASTIS-SALD-001; indexed 24 declarations before gate.
2026-05-25 04:08:19 reviewer/build compiled gate=pass :: Reviewer mandatory gate: python3 tools/astis.py check passed after source-index refresh.
2026-05-25 04:08:41 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:08:49 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-040849-643035-ASTIS-SALD-001-cycle21/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-040849-643035-ASTIS-SALD-001-cycle21 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-040849-643035-ASTIS-SALD-001-cycle21 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end.
