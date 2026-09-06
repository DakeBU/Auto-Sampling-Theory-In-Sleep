Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 59
Role: reviewer
Run directory: runs/20260527-005716-895855-ASTIS-SALD-001-cycle59

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
Main skeleton sprint 1: analytic interface ledger: Create or sharpen the five source-cited analytic interfaces needed by the SALD proof route: Gronwall, DV, LSI-to-KL/FI, continuous forward-KL Fokker--Planck/KL derivative, and EM interpolation Fokker--Planck. Keep every unproved backend below formalized status.
```

Recent trial memory:

```text
2026-05-27 00:40:12 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 00:46:22 middle/handoff queued gate=not-run :: Cycle 58 middle route audit completed: wired cycle58 middle contract/obligation and DAG node for unified/discrete general route; lower packet remains sald.general_moving_target_discrete.gronwall_side_conditions over appendix.tex:1573-1600; source-index and ASTIS check passed.
2026-05-27 00:46:33 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 00:53:24 lower/handoff queued gate=not-run :: Cycle 58 lower added SALD.generalMovingTargetDiscretePointwiseGronwallInputOfPostDvTimeChanged as a compiled pointwise Gronwall-input wrapper for appendix.tex:1573-1600, wired it into the discrete general Gronwall side-condition route, synchronized notes, and passed source-index plus ASTIS check.
2026-05-27 00:53:56 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 00:56:30 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 58: source-index refreshed, ASTIS check passed, no fake closures/source drift/status overpromotion/SLT promotion found; remaining lower risk is sald.general_moving_target_discrete.gronwall_side_conditions over appendix.tex:1573-1600.
2026-05-27 00:57:07 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 00:57:16 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260527-005716-895855-ASTIS-SALD-001-cycle59/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260527-005716-895855-ASTIS-SALD-001-cycle59 --role reviewer --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role reviewer --kind handoff --status queued --artifact runs/20260527-005716-895855-ASTIS-SALD-001-cycle59 --notes "..."
```

## Role Instructions

Audit build gate, fake proof closures, source correspondence, cited results, and SLT port status. Reject contract drift, missing source anchors, or any claim marked proved without a compiled Lean declaration. Also check proof-skeleton discipline: reject cycles that only add rebaseline/ledger work or isolated scalar lemmas when the assigned proof target could have been wired into a theorem skeleton or precise source-cited analytic interface.
