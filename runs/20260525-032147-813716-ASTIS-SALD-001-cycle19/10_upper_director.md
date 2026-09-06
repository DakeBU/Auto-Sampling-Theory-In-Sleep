Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 19
Role: upper
Run directory: runs/20260525-032147-813716-ASTIS-SALD-001-cycle19

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
2026-05-25 03:07:42 middle/handoff queued gate=not-run :: Cycle 18 middle added SALD.cycle18ForwardKlMiddleContract and synchronized conversion/proof-obligation/SLT ledgers; lower target sald.forward_kl.gronwall_side_conditions with interval-integral-to-scalar-helper bridge; source-index refreshed 24 declarations and check passed.
2026-05-25 03:08:15 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 03:18:08 lower/handoff queued gate=not-run :: Cycle 18 lower formalized adjacent-interval Gronwall exponent bridge via SALD.gronwallIntervalIntegralAdditivityScalar and SALD.gronwallExpProductRewriteIntervalIntegral; forward-KL side-condition contract/obligation, proof DAG dependencies, conversion window, proof obligations, and source-index synchronized; check passed.
2026-05-25 03:18:39 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 03:21:01 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 18: source-index refreshed 24 declarations and python3 tools/astis.py check passed; adjacent-interval Gronwall bridge sublemmas compile as local algebra only; theorem-specific interval-integrability, residual integral congruence, endpoint rewrites, coefficient regularity, residual-exponent monotonicity, DV, LSI-to-KL/FI, KL derivative, schedule, moving-target, and full Gronwall remain obligations/source-cited.
2026-05-25 03:21:09 reviewer/build compiled gate=pass :: Cycle build gate.
2026-05-25 03:21:38 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 03:21:47 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-032147-813716-ASTIS-SALD-001-cycle19/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-032147-813716-ASTIS-SALD-001-cycle19 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-032147-813716-ASTIS-SALD-001-cycle19 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end.
