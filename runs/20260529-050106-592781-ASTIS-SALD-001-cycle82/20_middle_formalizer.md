Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 82
Role: middle
Run directory: runs/20260529-050106-592781-ASTIS-SALD-001-cycle82

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
Backend backfill 3: weak Fokker--Planck source signs: Continue the same EM backend: sharpen or prove the weak conditional Fokker--Planck source-sign statement with `-div` drift and `+(sigma_eta^2/2) Delta` diffusion terms under explicit hypotheses.
```

Recent trial memory:

```text
2026-05-29 04:41:15 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 04:48:44 middle/handoff queued gate=not-run :: Cycle 81 middle compiled supplied-hypothesis endpoint/conditional weak-FP readiness wrapper SALD.generalMovingTargetDiscreteEndpointConditionalWeakFpReadinessHandoff, synchronized ledgers, and passed source-index plus ASTIS check; analytic conditional law, weak FP, density/AC, KL derivative, theorem statuses, SLT import, and Lake dependency remain unpromoted.
2026-05-29 04:49:45 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 04:56:20 lower/handoff queued gate=not-run :: Cycle 81 lower compiled SALD.generalMovingTargetDiscreteEndpointMeasureMapWeakFpPrereqHandoff endpoint-only Measure.map-to-WeakFpPrereq wrapper for appendix.tex:1368-1377 and synchronized ledgers; source-index and ASTIS check passed; analytic conditional-law, weak FP, density/AC, KL derivative, theorem status, SLT import, and Lake dependency remain unpromoted.
2026-05-29 04:57:06 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 05:00:31 reviewer/handoff queued gate=pass :: Cycle 81 reviewer accepted. source-index ASTIS-SALD-001 and python3 tools/astis.py check passed; proof-diagnostics zero forbidden hits; endpoint-to-conditional EM backend focus preserved; no theorem, analytic backend, SLT, or Lake status promotion.
2026-05-29 05:00:57 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 05:01:06 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260529-050106-592781-ASTIS-SALD-001-cycle82/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260529-050106-592781-ASTIS-SALD-001-cycle82 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260529-050106-592781-ASTIS-SALD-001-cycle82 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD after cycle 69, read the TeX around the active EM conditional-law/Fokker--Planck focus and translate only that backend into lower-ready Lean declarations; avoid fresh theorem-route audits unless needed for source correctness. Before inventing an abstraction, inspect the local `lean-stat-learning-theory` reference for Mathlib measure/probability idioms that can be ported locally under this project's toolchain. Also follow the MathCode-inspired theorem-reuse discipline: search existing ASTIS declarations, conversion windows, proof obligations, and cited-result ledgers before creating a duplicate interface. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During this sprint, avoid broad rebaseline work, broad SLT/SDE library import, and lower packets outside the active EM backend unless reviewer found a blocker. Export the Overleaf-ready project article only at the end of a multi-hour batch.
