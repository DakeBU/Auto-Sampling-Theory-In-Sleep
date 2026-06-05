Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 12
Role: lower
Run directory: runs/20260524-231714-576974-ASTIS-SALD-001-cycle12

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
2026-05-24 22:58:57 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 23:06:15 middle/handoff queued gate=not-run :: Middle handoff: added cycle11 discrete forward-KL EM/defect/accumulation middle contract and obligation; synchronized Lean DAG, conversion window, proof obligations, SLT audit, source index; check passed.
2026-05-24 23:06:56 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 23:14:52 lower/handoff queued gate=not-run :: Lower handoff: added discrete forward-KL residual exponent bound obligation for appendix.tex lines 557-590 and main_body.tex lines 309-323; synchronized Lean contract, proof DAG, conversion window, proof obligations, SLT audit, and source index; check passed.
2026-05-24 23:15:17 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 23:16:55 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 11: source-index refreshed with 24 declarations; audited discrete forward-KL source correspondence, EM interpolation, one-step defect, DV witness, Gronwall/residual exponent/accumulated-error obligations, SLT reuse status, and fake-proof/build gate; check passed.
2026-05-24 23:17:07 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 23:17:14 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260524-231714-576974-ASTIS-SALD-001-cycle12/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-231714-576974-ASTIS-SALD-001-cycle12 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260524-231714-576974-ASTIS-SALD-001-cycle12 --notes "..."
```

## Role Instructions

Attempt one narrow Lean/source-index/proof-obligation task. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add or refine a ProofObligation and keep the build green.
