Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 23
Role: middle
Run directory: runs/20260525-045710-783991-ASTIS-SALD-001-cycle23

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
Discrete forward-KL theorem: `thm:forward-KL-discrete`, Euler--Maruyama interpolation, one-step defects, and accumulated error.
```

Recent trial memory:

```text
2026-05-25 04:45:36 middle/handoff queued gate=not-run :: Cycle 22 middle source-to-Lean map added: SALD.cycle22ForwardKlMiddleContract plus synchronized conversion window, proof-obligation ledger, SLT audit, and thm:forward-KL dependencies. Lower target remains SALD.forwardKlGronwallSideConditionContract / sald.forward_kl.gronwall_side_conditions, first sub-slice coefficient regularity and adjacent interval-integrability before SALD.gronwallExpProductRewriteIntegralCongr. Source-index refreshed 24 declarations; check passed.
2026-05-25 04:45:56 middle/build compiled gate=pass :: Cycle 22 middle mandatory gate: source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 04:46:13 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:53:37 lower/handoff queued gate=not-run :: Cycle 22 lower formalized SALD.forwardKlGronwallCoeffIntervalIntegrable, SALD.forwardKlGronwallCoeffAdjacentIntervalIntegrable, and SALD.forwardKlGronwallExpProductRewriteIntegralCongrOfPieces for the continuous forward-KL Gronwall side-condition bridge. Source-index refreshed; mandatory check passed. Remaining obligations: source piece regularity/integrability for dot{s}*C_LSI, alpha coefficient, b(t), endpoint rewrites, residual exponent monotonicity, DV/LSI/KL derivative/full Gronwall.
2026-05-25 04:54:13 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:56:26 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 22. Source-index refreshed 24 labels and mandatory check passed. Accepted only the compiled local coefficient interval-integrability and exponent-congruence assembly lemmas; continuous forward-KL theorem and analytic backends remain obligations/source-cited. No fake proof closures, sald_version_2.tex use, source-index drift, or SLT promotion found.
2026-05-25 04:57:02 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 04:57:10 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-045710-783991-ASTIS-SALD-001-cycle23/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-045710-783991-ASTIS-SALD-001-cycle23 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260525-045710-783991-ASTIS-SALD-001-cycle23 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and map each proof step to Lean, cited result, or obligation. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During Lean-heavy cycles, update conversion windows and ledgers first; export the Overleaf-ready project article only at the end of a multi-hour batch.
