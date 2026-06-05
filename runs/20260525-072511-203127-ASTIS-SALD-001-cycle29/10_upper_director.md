Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 29
Role: upper
Run directory: runs/20260525-072511-203127-ASTIS-SALD-001-cycle29

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
2026-05-25 07:13:07 middle/handoff queued gate=not-run :: Cycle 28 middle added SALD.cycle28GeneralVaSaldMiddleContract plus sald.general_moving_target_discrete.cycle28_derivative_side_middle for appendix.tex:1469-1511 frozen/residual algebra and two sigma_eta^2/8 Young splits; compiled local scalar Young bookkeeping helpers; synchronized ledgers; source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 07:13:56 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 07:21:24 lower/handoff queued gate=not-run :: Cycle 28 lower compiled frozen/residual module algebra for appendix.tex:1469-1478 via SALD.generalMovingTargetDiscreteFrozenResidualAlgebraVector and synchronized lower obligation/DAG/ledgers; source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 07:22:15 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 07:24:17 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 28: source-index refreshed 24 declarations and mandatory check passed. Scope accepted is the compiled theorem-independent frozen/residual module algebra plus synchronized ledgers; all analytic side conditions and thm:general-moving-target-SALD-discrete remain obligations.
2026-05-25 07:24:42 reviewer/build compiled gate=pass :: Cycle 28 reviewer build gate: python3 tools/astis.py check passed after source-index refresh.
2026-05-25 07:25:02 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 07:25:11 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-072511-203127-ASTIS-SALD-001-cycle29/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-072511-203127-ASTIS-SALD-001-cycle29 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-072511-203127-ASTIS-SALD-001-cycle29 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end.
