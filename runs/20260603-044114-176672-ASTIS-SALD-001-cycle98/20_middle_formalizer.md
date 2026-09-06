Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 98
Role: middle
Run directory: runs/20260603-044114-176672-ASTIS-SALD-001-cycle98

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

## Post-Cycle-84 Closure Priority

Cycles 70--84 already produced a paper-ordered EM backend transcript and
several compiled local wrappers under supplied hypotheses.  The next run must
not keep adding wrappers that merely repackage the same assumptions.  The
priority is to discharge or sharply reduce the supplied hypotheses behind
`appendix.tex:1358-1387`.

Use the original paper proof and local Lean references as follows:

1. Conditional law and conditional expectation boundary:
   - Source: `appendix.tex:1368-1377`.
   - Lean target family: conditional kernel for `X_k^eta | hat X_s=x`, named
     `hat rho_s = Law(hat X_s)`, component conditional-integral fields, and
     measurability/integrability of `bar b_{k,s}`.
   - References: Mathlib `Probability.Kernel.CondDistrib`,
     `Probability.Kernel.Condexp`; local `lean-stat-learning-theory`
     `EfronStein.lean`, `TensorizedGLSI.lean`, and `Measure.map` orientation
     patterns as proof-engineering guides.
2. Generator-to-law weak Fokker--Planck boundary:
   - Source: `appendix.tex:1379-1387`.
   - Lean target family: weak-test `Measure.map` integral derivative,
     generator/time-derivative identity, and source signs
     `-div(hat rho_s * bar b_{k,s}) + (sigma_eta^2/2) Delta hat rho_s`.
   - References: Mathlib `Analysis/Calculus/ParametricIntegral`, Bochner
     integral APIs, and existing ASTIS `lawMapIntegral` wrappers.
3. KL/log-ratio boundary:
   - Source: `appendix.tex:1358-1366`.
   - Lean target family: KL differentiability, admissible log-ratio weak test,
     integration by parts, Fisher-information identification, and the handoff
     from weak-FP action to `dK`.
4. Theorem pressure test:
   - Once one supplied hypothesis is discharged or narrowed, try routing
     `thm:forward-KL-discrete` through the current EM, LSI, DV, and Gronwall
     interfaces to identify the next actual blocker.
5. Non-EM slow backend fallback:
   - Only if the EM backend is blocked by a named Mathlib/theory gap, use one
     cycle on the smallest LSI-to-KL/FI, DV, or Gronwall boundary needed for
     theorem closure, with `lean-stat-learning-theory` used as a local porting
     reference and not as a Lake dependency.

Each post-cycle-84 lower packet must be classified as one of:

- `discharges-supplied-hypothesis`;
- `narrows-source-cited-boundary`;
- `rejected-wrapper-churn`.

Reviewer must reject a new supplied-hypothesis wrapper unless it removes an
older supplied hypothesis, exposes a strictly smaller missing theorem, or
compiles a genuinely local proof using Mathlib/local SLT-style ingredients.

## Acceptance Gate

```bash
python3 tools/astis.py source-index ASTIS-SALD-001
python3 tools/astis.py check
```
```

Cycle focus:

```text
Post-84 closure 2: generator-to-law weak-FP boundary: Target `appendix.tex:1379-1387`: turn sample-path derivative plus `Measure.map`/Bochner integral transport into the weak generator-to-law Fokker--Planck statement.  Use existing cycle-79 `lawMapIntegral` helpers and Mathlib parametric-integral APIs; do not create another wrapper unless it removes a supplied hypothesis.
```

Recent trial memory:

```text
2026-06-03 04:17:13 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-06-03 04:29:12 middle/handoff queued gate=not-run :: Cycle 97 middle discharges-supplied-hypothesis: compiled condDistrib map-law disintegration/named-law integral theorem for appendix.tex:1368-1377; wired canonical condDistrib component pairing obligations and lower packet; source-index and astis check passed.
2026-06-03 04:29:41 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-06-03 04:37:51 lower/handoff queued gate=not-run :: Cycle 97 lower narrows-source-cited-boundary via SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfIntegralAction; raw hcanonical is reduced to paired-integrand integrability plus componentAction and weakGradPairing canonical definition alignment, with hfieldAe and hweakAeCongr explicit. Remaining blockers: condC/condScore definition/integrability facts and hatRhoS*barB divergence/no-boundary. source-index and astis check passed.
2026-06-03 04:38:20 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-06-03 04:40:42 reviewer/handoff queued gate=not-run :: Cycle 97 reviewer accepted gate=pass: source-index, proof-diagnostics, and astis check passed. Classified middle discharges-supplied-hypothesis for condDistrib map-law disintegration; lower narrows-source-cited-boundary via SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfIntegralAction. No fake closure, contract drift, status promotion, source/sign/constant change, SLT import, Lake dependency change, or sald_version_2 source drift found. Remaining blockers are paired-integrand integrability, componentAction/weakGradPairing definition alignment, hfieldAe/hweakAeCongr, and divergence/no-boundary for hatRhoS*barB.
2026-06-03 04:41:03 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-06-03 04:41:14 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260603-044114-176672-ASTIS-SALD-001-cycle98/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260603-044114-176672-ASTIS-SALD-001-cycle98 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260603-044114-176672-ASTIS-SALD-001-cycle98 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD after cycle 69, read the TeX around the active EM conditional-law/Fokker--Planck focus and translate only that backend into lower-ready Lean declarations; avoid fresh theorem-route audits unless needed for source correctness. For SALD after cycle 84, classify every lower packet as either `discharges-supplied-hypothesis`, `narrows-source-cited-boundary`, or `rejected-wrapper-churn`; lower-ready declarations should name the exact Mathlib/local theorem boundary and source line. Before inventing an abstraction, inspect the local `lean-stat-learning-theory` reference for Mathlib measure/probability idioms that can be ported locally under this project's toolchain. Also follow the MathCode-inspired theorem-reuse discipline: search existing ASTIS declarations, conversion windows, proof obligations, and cited-result ledgers before creating a duplicate interface. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During this sprint, avoid broad rebaseline work, broad SLT/SDE library import, and lower packets outside the active EM backend unless reviewer found a blocker. Export the Overleaf-ready project article only at the end of a multi-hour batch.
