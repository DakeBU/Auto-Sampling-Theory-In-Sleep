Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 26
Role: middle
Run directory: runs/20260525-060724-617119-ASTIS-SALD-001-cycle26

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
2026-05-25 05:56:33 middle/handoff queued gate=not-run :: Cycle 25 middle added SALD.cycle25FirstAppendixMiddleAuditContract plus sald.first_appendix.cycle25_pi_velocity_norm_middle for appendix.tex:96-129 PI velocity-norm lower map; synchronized conversion-window/proof-obligation/SLT ledgers and source dependencies. Source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 05:57:05 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 06:03:37 lower/handoff queued gate=not-run :: Cycle 25 lower compiled SALD.piVelocityNormMeanZeroH1UpperScalar and SALD.piVelocityNormBoundedFunctionalScalar for appendix.tex:104-129 PI velocity-norm scalar propagation, added SALD.cycle25PiVelocityNormLowerObligation, synchronized ledgers, refreshed source-index, and passed python3 tools/astis.py check. Remaining Sobolev/Riesz/weak-PDE analytic backends stay obligations.
2026-05-25 06:04:10 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 06:06:36 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 25: source-index refreshed 24 declarations; mandatory check passed; accepted only scalar PI velocity-norm local real-order sublemmas and synchronized obligations; full analytic PI/Riesz/weak-PDE/velocity bound plus Gronwall, DV, and LSI-to-KL/FI remain open; no fake closures, excluded source, contract drift, source-index drift, or SLT promotion found.
2026-05-25 06:07:00 reviewer/build compiled gate=pass :: Cycle 25 reviewer gate: python3 tools/astis.py source-index ASTIS-SALD-001 refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 06:07:16 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 06:07:24 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-060724-617119-ASTIS-SALD-001-cycle26/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-060724-617119-ASTIS-SALD-001-cycle26 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260525-060724-617119-ASTIS-SALD-001-cycle26 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and map each proof step to Lean, cited result, or obligation. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During Lean-heavy cycles, update conversion windows and ledgers first; export the Overleaf-ready project article only at the end of a multi-hour batch.
