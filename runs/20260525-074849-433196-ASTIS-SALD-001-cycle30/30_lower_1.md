Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 30
Role: lower
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
python3 tools/astis.py agent-note 20260525-074849-433196-ASTIS-SALD-001-cycle30 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260525-074849-433196-ASTIS-SALD-001-cycle30 --notes "..."
```

## Role Instructions

Attempt one narrow Lean/source-index/proof-obligation task. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them.
