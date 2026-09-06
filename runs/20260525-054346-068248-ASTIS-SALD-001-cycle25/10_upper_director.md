Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 25
Role: upper
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
python3 tools/astis.py agent-note 20260525-054346-068248-ASTIS-SALD-001-cycle25 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260525-054346-068248-ASTIS-SALD-001-cycle25 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and prefer proof-obligation refinement over speculative theorem proving. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end.
