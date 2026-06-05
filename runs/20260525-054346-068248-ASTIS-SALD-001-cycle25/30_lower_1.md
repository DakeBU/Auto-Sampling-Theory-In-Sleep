Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 25
Role: lower
Run directory: runs/20260525-054346-068248-ASTIS-SALD-001-cycle25

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
2026-05-25 05:28:10 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 05:34:53 middle/handoff queued gate=not-run :: Cycle 24 middle added the continuous general VA-SALD Gronwall side-condition middle packet and synchronized Lean/conversion-window/proof-obligation/SLT ledgers. Source-index refreshed 24 declarations; mandatory check passed.
2026-05-25 05:35:25 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 05:40:57 lower/handoff queued gate=not-run :: Cycle 24 lower compiled SALD.generalMovingTargetGronwallCoeffAdjacentIntervalIntegrable and SALD.generalMovingTargetGronwallExpProductRewriteIntegralCongrOfPieces for the continuous general VA-SALD Gronwall coefficient slice. Source-index refreshed 24 declarations; python3 tools/astis.py check passed. Remaining obligations: theorem-specific coefficient regularity/integrability for sigma-LSI, alpha, and residual b(t), endpoint rewrites, residual exponent monotonicity, pure contraction, full Gronwall, DV, LSI-to-KL/FI, KL derivative, and unified transport bridge.
2026-05-25 05:41:24 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 05:43:21 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 24: source-index refreshed 24 declarations; python3 tools/astis.py check passed; accepted only the local coefficient/interval-integrability wrappers for continuous general VA-SALD Gronwall coefficient slice; theorem-level analytic backends remain obligations; no fake proof closures, excluded-source use, contract drift, source-index drift, or SLT promotion found.
2026-05-25 05:43:37 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 05:43:46 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-054346-068248-ASTIS-SALD-001-cycle25/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-054346-068248-ASTIS-SALD-001-cycle25 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260525-054346-068248-ASTIS-SALD-001-cycle25 --notes "..."
```

## Role Instructions

Attempt one narrow Lean/source-index/proof-obligation task. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them.
