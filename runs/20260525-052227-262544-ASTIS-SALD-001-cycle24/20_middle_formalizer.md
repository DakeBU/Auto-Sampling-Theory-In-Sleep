Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 24
Role: middle
Run directory: runs/20260525-052227-262544-ASTIS-SALD-001-cycle24

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
2026-05-25 05:03:42 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 05:10:57 middle/handoff queued gate=not-run :: Cycle 23 middle added SALD.cycle23DiscreteForwardKlMiddleContract plus sald.discrete_forward_kl.cycle23_coefficient_chain_middle and proof-DAG node ASTIS.SALD.forward_KL_discrete.cycle23_middle_coefficient_chain. Lower target remains coefficient-chain audit, first sub-slice appendix.tex:454-553 with accumulated-error bridge kept separate. Source-index refreshed 24 declarations; python3 tools/astis.py check passed.
2026-05-25 05:11:29 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 05:18:49 lower/handoff queued gate=not-run :: Cycle 23 lower formalized SALD.discreteForwardKlTimeChangeSquareCoefficientRewriteScalar for the appendix.tex:526-553 scalar time-change coefficient rewrite and synchronized Lean/conversion-window/proof-obligation/SLT ledgers. Source-index refreshed; mandatory check passed. Remaining obligations: inverse-schedule calculus, dot{s} positivity/nonzero, coefficient integrability, frozen-defect, LSI, DV, Gronwall, endpoint stitching, residual exponent drop, accumulated-error collection.
2026-05-25 05:19:35 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 05:21:51 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 23. Source-index refreshed 24 declarations and python3 tools/astis.py check passed. Accepted only the scalar real-algebra time-change rewrite SALD.discreteForwardKlTimeChangeSquareCoefficientRewriteScalar; discrete forward-KL theorem and analytic backends remain obligations/source-cited. No fake proof closures, sald_version_2.tex use, source-index drift, contract drift, or SLT promotion found.
2026-05-25 05:22:18 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 05:22:27 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-052227-262544-ASTIS-SALD-001-cycle24/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-052227-262544-ASTIS-SALD-001-cycle24 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260525-052227-262544-ASTIS-SALD-001-cycle24 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and map each proof step to Lean, cited result, or obligation. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During Lean-heavy cycles, update conversion windows and ledgers first; export the Overleaf-ready project article only at the end of a multi-hour batch.
