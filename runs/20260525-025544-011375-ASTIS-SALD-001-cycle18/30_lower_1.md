Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 18
Role: lower
Run directory: runs/20260525-025544-011375-ASTIS-SALD-001-cycle18

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
2026-05-25 02:39:32 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 02:44:52 middle/handoff queued gate=not-run :: Cycle 17 middle source-to-Lean rebaseline added SALD.cycle17FirstAppendixMiddleAuditContract; lower target sald.gronwall.exponent_rewrite; source-index refreshed 24 declarations; check passed.
2026-05-25 02:45:16 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 02:51:59 lower/handoff queued gate=not-run :: Cycle 17 lower formalized scalar Gronwall exponent algebra via SALD.gronwallNegIntegralRewriteScalar and SALD.gronwallExpProductRewriteScalar; interval-integral additivity and integral congruence remain obligations; source-index refreshed 24 declarations and check passed.
2026-05-25 02:52:25 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 02:54:56 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 17: source-index refreshed 24 declarations and check passed; scalar Gronwall exponent rewrite sublemmas are formalized local algebra only, while interval-integral additivity/congruence, full Gronwall, DV, PI velocity backend, and LSI-to-KL/FI remain obligations/source-cited.
2026-05-25 02:55:34 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 02:55:44 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-025544-011375-ASTIS-SALD-001-cycle18/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-025544-011375-ASTIS-SALD-001-cycle18 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260525-025544-011375-ASTIS-SALD-001-cycle18 --notes "..."
```

## Role Instructions

Attempt one narrow Lean/source-index/proof-obligation task. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them.
