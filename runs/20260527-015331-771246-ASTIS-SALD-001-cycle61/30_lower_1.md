Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 61
Role: lower
Run directory: runs/20260527-015331-771246-ASTIS-SALD-001-cycle61

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
Main skeleton sprint 3: discrete forward-KL: Wire the theorem-level interfaces into `thm:forward-KL-discrete`, matching `main_body.tex:299-323` and `appendix.tex:260-592`; use source-cited EM/Fokker--Planck interfaces explicitly instead of proving them from scratch in this cycle.
```

Recent trial memory:

```text
2026-05-27 01:43:29 middle/handoff queued gate=not-run :: Cycle 60 middle audit added SALD.cycle60ForwardKlSkeletonMiddleContract / SALD.cycle60ForwardKlSkeletonMiddleObligation and ASTIS.SALD.forward_KL.cycle60_middle_route_audit, wired continuous thm:forward-KL to the post-cycle-59 route, kept lower packet on sald.forward_kl.kl_derivative over appendix.tex:168-228, synchronized ledgers, source-index passed, ASTIS check passed.
2026-05-27 01:43:47 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 01:49:52 lower/handoff queued gate=not-run :: Cycle 60 lower compiled raw KL-derivative scalar wrapper for thm:forward-KL: from raw split with mass term plus supplied mass conservation, first-term -FI, target Cauchy, LSI, velocity scaling, and inverse schedule inputs to the t-time pre-DV inequality; analytic backends remain obligations; source-index and ASTIS check passed.
2026-05-27 01:50:45 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 01:53:05 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 60: source-index refreshed with 103 declarations; python3 tools/astis.py check passed. thm:forward-KL skeleton wiring matches main_body.tex:238-247 and appendix.tex:164-252, theorem remains contractOnly, slow interfaces remain obligation/source-cited, no fake closures or SLT overpromotion found; next risk remains sald.forward_kl.kl_derivative appendix.tex:168-228.
2026-05-27 01:53:13 reviewer/build accepted gate=not-run :: Cycle 60 reviewer build gate: source-index refreshed with 103 declarations and mandatory python3 tools/astis.py check passed after review handoff.
2026-05-27 01:53:22 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 01:53:31 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260527-015331-771246-ASTIS-SALD-001-cycle61/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260527-015331-771246-ASTIS-SALD-001-cycle61 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260527-015331-771246-ASTIS-SALD-001-cycle61 --notes "..."
```

## Role Instructions

Attempt one narrow theorem-skeleton or proof-producing Lean task before creating more ledger-only obligations. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add a precise source-cited interface or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them.
