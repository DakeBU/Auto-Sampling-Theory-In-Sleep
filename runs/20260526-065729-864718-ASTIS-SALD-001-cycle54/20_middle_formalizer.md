Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 54
Role: middle
Run directory: runs/20260526-065729-864718-ASTIS-SALD-001-cycle54

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

## Current 6h Priority: Main Proof Skeleton Closure

The first transcript pass is broad enough to stop spending cycles on isolated
scalar sublemmas.  The next batch should translate the paper proofs at theorem
level first: introduce or sharpen precise source-cited analytic interfaces for
the missing slow backends, wire them into the faithful theorem proof DAG, and
only then backfill local measure-theory or SDE details.

The required source-cited analytic interfaces are:

1. `lem:gronwall`, with endpoint-safe differentiability/FTC assumptions.
2. `lem:dv_variation`, with common-space, absolute-continuity, finite-KL, and
   finite-log-mgf assumptions.
3. `eq:LSI-KL-FI`, with density, zero-set convention, admissible test,
   entropy identity, and Fisher chain-rule assumptions.
4. The continuous forward-KL Fokker--Planck/KL derivative identity.
5. The Euler--Maruyama interpolation Fokker--Planck endpoint/conditional-law
   backend.

After those interfaces are explicit, close the faithful theorem skeletons in
this order without changing the paper statements, constants, or source labels:

1. `thm:forward-KL`
2. `thm:forward-KL-discrete`
3. `prop:guided_path_residual`
4. `thm:general-moving-target-SALD`
5. `thm:unified-forward-KL`
6. `thm:general-moving-target-SALD-discrete`

These theorem skeletons may remain `contractOnly` or depend on
`sourceCited`/`obligation` analytic interfaces; they must not be marked
`formalized` unless every analytic dependency is compiled locally.  The point
of this six-hour run is to finish the SALD paper proof translation route, not
to solve all background analysis from scratch.

Only after the theorem skeletons and source-cited interfaces are stable should
upper and middle agents begin systematic backfill of measure-theory details,
using `/home/nitanda_sub/mark/repos/RMFLD/Statistical Learning Theory in Lean 4
Empirical Processes from Scratch` and `YuanheZ/lean-stat-learning-theory` as
guides for Gaussian concentration, entropy duality, Poincare/log-Sobolev, and
one-step discretization ports.

## Acceptance Gate

```bash
python3 tools/astis.py source-index ASTIS-SALD-001
python3 tools/astis.py check
```
```

Cycle focus:

```text
Main skeleton sprint 1: analytic interface ledger: Create or sharpen the five source-cited analytic interfaces needed by the SALD proof route: Gronwall, DV, LSI-to-KL/FI, continuous forward-KL Fokker--Planck/KL derivative, and EM interpolation Fokker--Planck. Keep every unproved backend below formalized status.
```

Recent trial memory:

```text
2026-05-26 06:44:36 middle/handoff queued gate=not-run :: Cycle 53 middle added cycle53 unified/discrete route audit contract+obligation+DAG node, wired downstream theorem contracts/dependency lists, synchronized ledgers, source-index regenerated, ASTIS check passed; next lower target sald.general_moving_target_discrete.kl_derivative appendix.tex:1354-1387.
2026-05-26 06:44:55 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 06:54:41 lower/handoff queued gate=not-run :: Cycle 53 lower compiled discrete general derivative/DV scalar handoff through SALD.generalMovingTargetDiscreteDerivativeDvTimeChangedScalar, registered cycle53 lower obligation/DAG, refreshed source-index, and passed python3 tools/astis.py check; analytic EM conditional-FP/KL derivative, LSI, DV witness, stitched schedule, and Gronwall remain obligations.
2026-05-26 06:55:08 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 06:56:49 reviewer/build accepted gate=not-run :: Cycle 53 reviewer acceptance gate: source-index regenerated 103 declarations and python3 tools/astis.py check passed.
2026-05-26 06:57:05 reviewer/handoff queued gate=not-run :: Cycle 53 reviewer accepted: source-index regenerated 103 declarations and ASTIS check passed; theorem skeletons remain contractOnly, analytic backends remain obligations/source-cited, cycle53 Measure.map endpoint-law and scalar derivative/DV handoffs compile under explicit hypotheses, no fake closure/source drift/hidden assumption/SLT promotion found. Next lower target: sald.general_moving_target_discrete.kl_derivative appendix.tex:1354-1387.
2026-05-26 06:57:20 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 06:57:29 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260526-065729-864718-ASTIS-SALD-001-cycle54/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260526-065729-864718-ASTIS-SALD-001-cycle54 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260526-065729-864718-ASTIS-SALD-001-cycle54 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and translate the paper theorem proof route into Lean-facing theorem skeletons and source-cited analytic interfaces first; only add isolated sublemmas when a theorem-level dependency is already wired. Check the skeleton-closure route before planning: analytic interfaces, forward-KL, discrete forward-KL, guided residual, general moving-target, unified forward-KL, then discrete general moving-target. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During this sprint, avoid broad rebaseline work and avoid systematic SLT/SDE library import until the SALD theorem skeletons consume the source-cited interfaces explicitly. Export the Overleaf-ready project article only at the end of a multi-hour batch.
