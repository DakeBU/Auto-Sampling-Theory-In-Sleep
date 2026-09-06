Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 6
Role: lower
Run directory: runs/20260524-204912-166913-ASTIS-SALD-001-cycle06

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
2026-05-24 20:40:22 middle/handoff queued gate=not-run :: Middle handoff: added the SALD LSI-to-KL/FI bridge contract and density/test-function obligation for eq:LSI-KL-FI; source-index refreshed with 24 declarations; python3 tools/astis.py check passed.
2026-05-24 20:40:36 middle/build compiled gate=pass :: Middle gate: source-index refreshed and python3 tools/astis.py check passed after LSI-to-KL/FI bridge refinement.
2026-05-24 20:41:09 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 20:45:59 lower/handoff queued gate=pass :: Lower handoff: refined eq:LSI-KL-FI density-test obligation via SALD.saldLsiKlFiDensityTestContract; source-index refreshed; python3 tools/astis.py check passed.
2026-05-24 20:46:45 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 20:48:36 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 5: source-index refreshed with 24 declarations; first appendix/vocabulary anchors audited; sald_version_2.tex excluded; Gronwall/DV/PI/LSI-KL-FI statuses remain obligation/source-cited/contract-only as appropriate; check passed.
2026-05-24 20:49:05 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-24 20:49:12 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260524-204912-166913-ASTIS-SALD-001-cycle06/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260524-204912-166913-ASTIS-SALD-001-cycle06 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260524-204912-166913-ASTIS-SALD-001-cycle06 --notes "..."
```

## Role Instructions

Attempt one narrow Lean/source-index/proof-obligation task. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add or refine a ProofObligation and keep the build green.
