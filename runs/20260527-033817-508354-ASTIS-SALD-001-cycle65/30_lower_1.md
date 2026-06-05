Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 65
Role: lower
Run directory: runs/20260527-033817-508354-ASTIS-SALD-001-cycle65

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
Main skeleton sprint 2: continuous forward-KL: Wire the source-cited analytic interfaces into the faithful proof skeleton for `thm:forward-KL`, matching `main_body.tex:238-247` and `appendix.tex:164-252` without changing constants, statements, or source labels.
```

Recent trial memory:

```text
2026-05-27 03:20:28 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 03:26:25 middle/handoff queued gate=not-run :: Cycle 64 middle interface audit added and wired; appendix.tex:1358-1387 lower packet sharpened; source-index and mandatory ASTIS check passed.
2026-05-27 03:26:56 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 03:35:01 lower/handoff queued gate=not-run :: Cycle 64 lower compiled SALD.generalMovingTargetDiscreteConditionalDriftLinearCombination and SALD.generalMovingTargetDiscreteConditionalDriftFieldOfLinearCombination, added the conditional-drift contract/obligation for appendix.tex:1368-1377, wired it into the cycle-64 dependencies and discrete general theorem route, and synchronized conversion/proof-obligation/SLT ledgers. Analytic conditional-law, density/AC, weak FP, KL derivative, theorem status, and SLT reuse remain below formalized. source-index and mandatory check passed.
2026-05-27 03:35:33 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 03:37:45 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 64 after source-index and mandatory ASTIS check passed. No fake proof closures found beyond policy strings. Cycle 64 keeps five slow analytic backends and six theorem skeletons below formalized; accepted formalized work is only local conditional-expectation linearity algebra for appendix.tex:1368-1377 under explicit supplied linearity hypotheses, with regular conditional law/density/weak FP/KL derivative/LSI/DV/Gronwall still obligations.
2026-05-27 03:38:08 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 03:38:17 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260527-033817-508354-ASTIS-SALD-001-cycle65/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260527-033817-508354-ASTIS-SALD-001-cycle65 --role lower --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role lower --kind handoff --status queued --artifact runs/20260527-033817-508354-ASTIS-SALD-001-cycle65 --notes "..."
```

## Role Instructions

Attempt one narrow theorem-skeleton or proof-producing Lean task before creating more ledger-only obligations. Do not change the theorem target. Do not add fake proof closures; if the analysis fact is not formalized, add a precise source-cited interface or refine a ProofObligation and keep the build green. In Phase 1 faithfulPaper mode, do not introduce broad library reorganizations or educational APIs unless upper/middle explicitly assign them.
