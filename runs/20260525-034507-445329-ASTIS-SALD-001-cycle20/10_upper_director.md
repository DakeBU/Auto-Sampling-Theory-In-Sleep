Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 20
Role: upper
Run directory: runs/20260525-034507-445329-ASTIS-SALD-001-cycle20

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
Guided and general VA-SALD path: `prop:guided_path_residual`, `thm:general-moving-target-SALD`, `thm:unified-forward-KL`, and `thm:general-moving-target-SALD-discrete`.
```

Recent trial memory:

```text
2026-05-25 03:28:31 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 03:35:48 middle/handoff queued gate=not-run :: Cycle 19 middle added SALD.cycle19DiscreteForwardKlMiddleContract and SALD.cycle19DiscreteForwardKlAccumulatedErrorMiddleObligation for the discrete forward-KL accumulated-error bridge; lower target sald.discrete_forward_kl.residual_exponent_bound; conversion/proof-obligation/SLT ledgers synchronized; source-index refreshed 24 declarations and python3 tools/astis.py check passed.
2026-05-25 03:36:17 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 03:42:02 lower/handoff queued gate=not-run :: Cycle 19 lower formalized the scalar real-order and Real.exp monotonicity core for sald.discrete_forward_kl.residual_exponent_bound; ledgers synchronized; source-index refreshed 24 declarations; check passed.
2026-05-25 03:42:40 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 03:44:35 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 19 after source-index refresh and passing mandatory check. Cycle-19 lower formalized only SALD.discreteForwardKlResidualExponentBoundScalar and SALD.discreteForwardKlResidualExpBoundScalar; no theorem-level discrete forward-KL proof or analytic dependency was promoted.
2026-05-25 03:44:59 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 03:45:07 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-034507-445329-ASTIS-SALD-001-cycle20/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-034507-445329-ASTIS-SALD-001-cycle20 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-034507-445329-ASTIS-SALD-001-cycle20 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end.
