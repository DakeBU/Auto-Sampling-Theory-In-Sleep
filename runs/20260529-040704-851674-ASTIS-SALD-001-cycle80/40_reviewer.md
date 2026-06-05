Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 80
Role: reviewer
Run directory: runs/20260529-040704-851674-ASTIS-SALD-001-cycle80

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

## Current 6h Priority: Single-Backend Backfill

The theorem-skeleton route is now stable enough to stop rotating broadly
through all theorem statements.  The next batch should backfill exactly one
shared analytic backend: the Euler--Maruyama interpolation conditional-law /
weak Fokker--Planck interface, especially
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`.

This backend has the highest leverage because it supports both
`thm:forward-KL-discrete` and
`thm:general-moving-target-SALD-discrete`.  Upper and middle agents should
avoid assigning lower work on unrelated theorem-route audits, display algebra,
or broad reusable APIs while this backend remains open.

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

Use `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory` as a
reference for Mathlib measure/probability style when useful, especially
`SLT/MeasureInfrastructure.lean`, `SLT/GaussianMeasure.lean`, and any reusable
integral/measure-map patterns.  Do not add it as a Lake dependency and do not
claim an SLT theorem is formalized unless the corresponding local ASTIS
declaration compiles under this project's toolchain.

## Upper-Level Phase Judgment

At the start of every upper-agent cycle, explicitly write a short global
judgment with three decisions:

1. whether the previous cycle failed and must be recovered before new work;
2. whether Phase 1 theorem-skeleton translation is stable enough to begin
   cited-theory backfill;
3. which single lower packet best reduces the largest remaining proof risk.

For the next run, cycle 56 recovery is already complete.  Start at cycle 70
with the EM conditional-law/Fokker--Planck backend.  The preferred lower
packets, in order, are:

1. conditional-law/measurability and named conditional drift interfaces;
2. endpoint-law-to-conditional-law compatibility;
3. weak conditional Fokker--Planck source-sign statement;
4. KL-derivative handoff from the weak FP identity;
5. only if blocked, a narrowly cited interface recording the missing Mathlib
   measure theorem.

## Acceptance Gate

```bash
python3 tools/astis.py source-index ASTIS-SALD-001
python3 tools/astis.py check
```
```

Cycle focus:

```text
Backend backfill 1: EM conditional-law interface: Focus only on `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`: conditional-law/measurability and named conditional drift interfaces. Use local `lean-stat-learning-theory` only as a Mathlib style reference; do not add it as a dependency.
```

Recent trial memory:

```text
2026-05-29 03:53:41 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 03:58:06 middle/handoff queued gate=not-run :: Cycle 79 middle added compiled/source-indexed source-map obligation SALD.cycle79GeneralMovingTargetDiscreteWeakFpGeneratorMeasureMiddleObligation and DAG id ASTIS.SALD.cycle79.middle_weak_fp_generator_measure_source_map for appendix.tex:1379-1387; conversion window, proof obligations, SLT reuse audit, theorem dependency lists, and dialogue updated; source-index and ASTIS check passed; no analytic/theorem status promotion.
2026-05-29 03:58:25 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 04:04:22 lower/handoff queued gate=not-run :: Cycle 79 lower compiled local Measure.map weak-test integral and supplied-derivative transport wrappers for the EM generator-to-law interface; docs synchronized; source-index and ASTIS check passed; full EM generator/weak-FP/KL analytic backend remains open.
2026-05-29 04:04:36 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 04:06:18 reviewer/handoff queued gate=not-run :: Cycle 79 reviewer accepted: source-index ASTIS-SALD-001 and python3 tools/astis.py check passed; no fake proof closures found in gate. Backend focus preserved on the EM weak generator-to-law Measure.map interface for appendix.tex:1379-1387; cycle79 interface is sourceCited, local lawMapIntegral wrappers compile under supplied hypotheses, theorem contracts stay contractOnly, and SLT remains reference-only/no import.
2026-05-29 04:06:55 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 04:07:04 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260529-040704-851674-ASTIS-SALD-001-cycle80/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260529-040704-851674-ASTIS-SALD-001-cycle80 --role reviewer --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role reviewer --kind handoff --status queued --artifact runs/20260529-040704-851674-ASTIS-SALD-001-cycle80 --notes "..."
```

## Role Instructions

Audit build gate, fake proof closures, source correspondence, cited results, and SLT port status. Reject contract drift, missing source anchors, or any claim marked proved without a compiled Lean declaration. Use the MathCode-inspired diagnostics policy: hidden `axiom`, `constant`, `postulate`, `sorry`, `admit`, `Prop := True`, or `:= trivial` closures are blocking defects, and proof statistics should be used to notice suspicious broad rewrites. Also check backend-focus discipline: reject cycles that only add rebaseline/ledger work, broad route audits, unrelated display algebra, or SLT import claims when the active EM conditional-law/Fokker--Planck backend could have been advanced.
