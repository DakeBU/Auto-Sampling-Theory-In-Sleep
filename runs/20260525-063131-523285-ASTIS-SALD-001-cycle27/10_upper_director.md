Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 27
Role: upper
Run directory: runs/20260525-063131-523285-ASTIS-SALD-001-cycle27

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
2026-05-25 06:14:49 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 06:21:34 middle/handoff queued gate=not-run :: Cycle 26 middle added SALD.cycle26ForwardKlMiddleContract plus sald.forward_kl.cycle26_dv_witness_middle for thm:forward-KL DV witness; synchronized conversion-window/proof-obligation/SLT ledgers and source dependencies. Source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 06:22:10 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 06:28:50 lower/handoff queued gate=not-run :: Cycle 26 lower compiled positive-alpha scalar DV division/coefficient lemmas for forward-KL and synchronized ledgers; source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 06:29:17 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 06:31:07 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 26: source-index refreshed 24 declarations and python3 tools/astis.py check passed. Scope accepted is only the compiled positive-alpha scalar Real core and synchronized DV witness/SLT/proof-obligation ledgers; DV, finite-log-mgf, common-space/measurability, KL derivative, LSI-to-KL/FI, Gronwall, and forward-KL theorem remain obligations.
2026-05-25 06:31:23 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 06:31:31 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-063131-523285-ASTIS-SALD-001-cycle27/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-063131-523285-ASTIS-SALD-001-cycle27 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-063131-523285-ASTIS-SALD-001-cycle27 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end.
