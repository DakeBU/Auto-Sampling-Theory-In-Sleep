Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 83
Role: lower
Run directory: runs/20260529-053058-205434-ASTIS-SALD-001-cycle83

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
Backend backfill 4: KL derivative handoff from weak FP: Continue the same EM backend: connect the weak FP identity to the discrete KL-derivative handoff while keeping LSI, DV, Gronwall, and theorem statuses below formalized.
```

Recent trial memory:

```text
2026-05-29 05:09:50 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 05:20:16 middle/handoff queued gate=not-run :: Cycle 82 middle compiled readiness-to-generator-piece weak-FP source-sign bridge; synchronized ledgers; source-index and ASTIS check passed; analytic weak FP/conditional law/density/KL/theorem/SLT/Lake statuses remain unpromoted.
2026-05-29 05:20:47 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 05:27:53 lower/handoff queued gate=not-run :: Cycle 82 lower compiled SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpSourceSignsHandoff, synchronized ledgers, and passed source-index plus ASTIS check; analytic conditional law, weak FP, density/AC, KL derivative, theorem statuses, SLT import, and Lake dependency remain unpromoted.
2026-05-29 05:28:27 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 05:30:29 reviewer/handoff queued gate=not-run :: Cycle 82 reviewer accepted. source-index ASTIS-SALD-001 and ASTIS check passed; proof-diagnostics zero forbidden hits. Weak FP source-sign wrappers match appendix.tex:1379-1387 with negative drift-divergence and positive sigma_eta^2/2 Laplacian under supplied hypotheses; no theorem, analytic backend, SLT, or Lake promotion.
2026-05-29 05:30:49 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 05:30:58 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260529-053058-205434-ASTIS-SALD-001-cycle83/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260529-053058-205434-ASTIS-SALD-001-cycle83 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260529-053058-205434-ASTIS-SALD-001-cycle83 --notes "..."
```

## Role Instructions

Attempt one narrow proof-producing Lean task for the assigned active backend before creating more ledger-only obligations. Do not change the theorem target. Do not work on unrelated display algebra, route audits, or general API cleanup unless the upper/middle packet explicitly assigns it. Do not add fake proof closures; if the analysis fact is not formalized, add a precise source-cited interface or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them.
