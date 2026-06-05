Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 8
Role: lower
Run directory: runs/20260524-213637-927545-ASTIS-SALD-001-cycle08

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
2026-05-24 21:27:47 middle/handoff queued gate=not-run :: Middle handoff: added discrete forward-KL accumulated-error bridge contract/obligation for endpoint rewrites, linear-slowdown exponent split, residual-exponent bounding, and A_alpha/barGamma/barDelta collection; source-index refreshed; check passed.
2026-05-24 21:28:08 middle/build compiled gate=pass :: Middle gate: source-index refreshed with 24 declarations and python3 tools/astis.py check passed after discrete accumulated-error bridge refinement.
2026-05-24 21:28:42 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 21:33:02 lower/handoff queued gate=not-run :: Lower handoff: refined discrete forward-KL coefficient-chain audit with source-line and scalar side-condition ledgers; stitched-interval regularity is now a direct dependency; source-index refreshed; check passed.
2026-05-24 21:33:51 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 21:36:03 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 7: source-index refreshed with 24 declarations; audited discrete forward-KL EM interpolation, one-step Gamma/Delta coefficient chain, accumulated-error bridge, source anchors, fake-proof scan, and SLT reuse status; sald_version_2.tex remains excluded; all analytic steps remain obligations/source-cited; python3 tools/astis.py check passed.
2026-05-24 21:36:30 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 21:36:37 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260524-213637-927545-ASTIS-SALD-001-cycle08/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-213637-927545-ASTIS-SALD-001-cycle08 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260524-213637-927545-ASTIS-SALD-001-cycle08 --notes "..."
```

## Role Instructions

Attempt one narrow Lean/source-index/proof-obligation task. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add or refine a ProofObligation and keep the build green.
