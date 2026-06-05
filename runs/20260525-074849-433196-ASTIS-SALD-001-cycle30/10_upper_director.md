Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 30
Role: upper
Run directory: runs/20260525-074849-433196-ASTIS-SALD-001-cycle30

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
2026-05-25 07:38:15 middle/handoff queued gate=not-run :: Cycle 29 middle added SALD.cycle29FirstAppendixMiddleAuditContract plus SALD.cycle29LsiKlFiDensityTestMiddleObligation / sald.lsi_kl_fi.cycle29_density_test_middle for main_body.tex:208-215 density-test bridge; synchronized conversion window, proof obligations, SLT audit, and first-DAG dependencies; source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 07:39:05 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 07:44:55 lower/handoff queued gate=not-run :: Cycle 29 lower formalized SALD.lsiKlFiCoefficientAuditScalar for the eq:LSI-KL-FI coefficient 2/C_LSI times 1/4 -> 1/(2*C_LSI), added SALD.cycle29LsiKlFiDensityTestLowerObligation, synchronized ledgers/source dependencies/tests, refreshed source-index, and passed python3 tools/astis.py check.
2026-05-25 07:45:20 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 07:47:54 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 29 after source-index refresh and passing python3 tools/astis.py check. Scope accepted: SALD.lsiKlFiCoefficientAuditScalar as scalar coefficient algebra only, with cycle29 source/proof/SLT ledgers synchronized; no analytic LSI-to-KL/FI closure or SLT import promoted.
2026-05-25 07:48:11 reviewer/build compiled gate=pass :: Cycle 29 reviewer build gate: source-index refreshed 24 declarations, then python3 tools/astis.py check passed.
2026-05-25 07:48:41 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 07:48:49 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-074849-433196-ASTIS-SALD-001-cycle30/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-074849-433196-ASTIS-SALD-001-cycle30 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-074849-433196-ASTIS-SALD-001-cycle30 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end.

## Cycle 30 Upper Decision

Objective: return to continuous `thm:forward-KL` and select the derivative-side
moving-target interface as the lower target.  This covers
`appendix.tex:168-228`: KL differentiation, mass conservation, SALD
Fokker--Planck integration by parts, slowed-target transport, target-side
integration by parts, Young's inequality, LSI handoff, and inverse-schedule
time change.

Mode discipline:

- `faithfulPaper`; use only `main_body.tex` and `appendix.tex` from the
  original source root, with `sald_version_2.tex` excluded.
- Keep `thm:forward-KL` and the terminal display in `main_body.tex:243-246`
  fixed.
- Treat density, boundary, inverse-schedule, LSI, DV, and Gronwall inputs as
  obligations or source-cited facts until compiled Lean proofs replace them.

Non-goals:

- do not prove or restate `thm:forward-KL`;
- do not replace the derivative -> LSI -> DV -> Gronwall route;
- do not reopen the cycle-26 DV witness or cycle-29 LSI density-test lower
  work except as dependencies;
- do not change the Young `1/2` coefficients or add theorem hypotheses.

Lower packet:

- target exactly `SALD.forwardKlDerivativeSideConditionContract` /
  `SALD.forwardKlDensityBoundaryObligation` /
  `sald.forward_kl.density_boundary_regular`;
- first sub-slice: `appendix.tex:168-185`, mass conservation, KL
  differentiation, SALD Fokker--Planck, integration by parts, and the `-FI`
  identification;
- second sub-slice if needed: `appendix.tex:187-208`, slowed-target transport,
  target-side integration by parts, and Young with exact `1/2` coefficients;
- leave `appendix.tex:218-228` time change as
  `sald.forward_kl.schedule_time_change` unless the first slice is finished.

Reviewer checklist:

- `SALD.forwardKlProofDag` contains
  `ASTIS.SALD.forward_KL.cycle30_derivative_side_upper` before derivative,
  DV, and Gronwall proof-search blocks.
- `SALD.saldDependenciesForLabel "thm:forward-KL"` includes
  `SALD.cycle30ForwardKlUpperPacket` and
  `sald.forward_kl.cycle30_derivative_side_upper`.
- `SALD.forwardKlDerivativeSideConditionContract` remains an obligation; no
  analytic backend is promoted and no theorem assumptions are added.
