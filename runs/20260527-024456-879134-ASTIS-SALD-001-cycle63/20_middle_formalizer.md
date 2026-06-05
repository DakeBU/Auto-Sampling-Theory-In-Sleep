Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 63
Role: middle
Run directory: runs/20260527-024456-879134-ASTIS-SALD-001-cycle63

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

## Upper-Level Phase Judgment

At the start of every upper-agent cycle, explicitly write a short global
judgment with three decisions:

1. whether the previous cycle failed and must be recovered before new work;
2. whether Phase 1 theorem-skeleton translation is stable enough to begin
   cited-theory backfill;
3. which single lower packet best reduces the largest remaining proof risk.

For the next run, first recover the interrupted cycle-56 discrete
`thm:forward-KL-discrete` route: reuse the existing upper route, complete the
middle/lower/reviewer chain for the Gronwall/accumulated-error backend, and
keep all theorem statuses and slow analytic interfaces below `formalized`.
After a clean reviewer gate, upper may start narrow backfill of cited
measure-theory/SDE results, guided by the local Statistical Learning Theory in
Lean 4 material, but only one backend at a time.

## Acceptance Gate

```bash
python3 tools/astis.py source-index ASTIS-SALD-001
python3 tools/astis.py check
```
```

Cycle focus:

```text
Main skeleton sprint 5: unified and discrete general theorem: Wire `thm:unified-forward-KL` and `thm:general-moving-target-SALD-discrete` through the continuous/general skeletons and explicit source-cited interfaces; only after that, backfill one narrow measure-theory detail guided by local SLT material.
```

Recent trial memory:

```text
2026-05-27 02:28:11 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 02:34:48 middle/handoff queued gate=not-run :: Cycle 62 middle added the guided/general middle route audit for appendix.tex:619-951, wired it into Lean contracts/dependencies and Markdown ledgers, and left lower proof-producing work on sald.general_moving_target.kl_derivative over appendix.tex:765-884; source-index and mandatory check passed.
2026-05-27 02:35:19 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 02:41:51 lower/handoff queued gate=not-run :: Cycle 62 lower compiled SALD.generalMovingTargetKlDerivativeScaledResidualDisplayScalar for appendix.tex:813-835 and wired it through SALD.cycle62GuidedGeneralScaledResidualLowerObligation plus ASTIS.SALD.general_moving_target.cycle62_scaled_residual_lower; source-index and mandatory ASTIS check passed; continuous general analytic backends remain obligations.
2026-05-27 02:42:23 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 02:44:28 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 62. source-index ASTIS-SALD-001 and python3 tools/astis.py check passed; cycle-62 guided/general route preserves appendix.tex:619-951 source order, keeps prop:guided_path_residual and thm:general-moving-target-SALD contractOnly, records the appendix.tex:813-835 scaled residual scalar handoff as local algebra only, and leaves continuous KL derivative/FP, LSI, DV, Gronwall, pure contraction, and EM backends below formalized.
2026-05-27 02:44:47 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 02:44:56 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260527-024456-879134-ASTIS-SALD-001-cycle63/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260527-024456-879134-ASTIS-SALD-001-cycle63 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260527-024456-879134-ASTIS-SALD-001-cycle63 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and translate the paper theorem proof route into Lean-facing theorem skeletons and source-cited analytic interfaces first; only add isolated sublemmas when a theorem-level dependency is already wired. Check the skeleton-closure route before planning: analytic interfaces, forward-KL, discrete forward-KL, guided residual, general moving-target, unified forward-KL, then discrete general moving-target. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During this sprint, avoid broad rebaseline work and avoid systematic SLT/SDE library import until the SALD theorem skeletons consume the source-cited interfaces explicitly. Export the Overleaf-ready project article only at the end of a multi-hour batch.
