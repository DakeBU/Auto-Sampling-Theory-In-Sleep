Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 21
Role: lower
Run directory: runs/20260525-040849-643035-ASTIS-SALD-001-cycle21

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
2026-05-25 03:59:18 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:05:22 lower/handoff queued gate=not-run :: Cycle 20 lower formalized the constant-schedule coefficient rewrite scalar core for sald.general_moving_target_discrete.gronwall_side_conditions: inverse-schedule square, doubled residual, Gamma, and Delta coefficient algebra. Ledgers synchronized; source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 04:05:42 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:07:58 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 20: source-index refreshed 24 declarations and python3 tools/astis.py check passed. Accepted only the compiled scalar coefficient algebra helpers for sald.general_moving_target_discrete.gronwall_side_conditions; theorem-level discrete general VA-SALD proof, Gronwall/display matching, endpoint stitching, coefficient regularity, DV, LSI-to-KL/FI, and KL derivative remain obligations/source-cited.
2026-05-25 04:08:13 reviewer/source-index indexed gate=not-run :: Reviewer refreshed source index for ASTIS-SALD-001; indexed 24 declarations before gate.
2026-05-25 04:08:19 reviewer/build compiled gate=pass :: Reviewer mandatory gate: python3 tools/astis.py check passed after source-index refresh.
2026-05-25 04:08:41 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:08:49 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-040849-643035-ASTIS-SALD-001-cycle21/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-040849-643035-ASTIS-SALD-001-cycle21 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260525-040849-643035-ASTIS-SALD-001-cycle21 --notes "..."
```

## Role Instructions

Attempt one narrow Lean/source-index/proof-obligation task. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them.
