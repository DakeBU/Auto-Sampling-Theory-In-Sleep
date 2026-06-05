Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 53
Role: reviewer
Run directory: runs/20260526-062835-739967-ASTIS-SALD-001-cycle53

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
Main skeleton sprint 5: unified and discrete general theorem: Wire `thm:unified-forward-KL` and `thm:general-moving-target-SALD-discrete` through the continuous/general skeletons and explicit source-cited interfaces; only after that, backfill one narrow measure-theory detail guided by local SLT material.
```

Recent trial memory:

```text
2026-05-26 06:12:25 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 06:17:43 middle/handoff queued gate=not-run :: Cycle 52 middle added SALD.cycle52GuidedGeneralSkeletonMiddleContract / SALD.cycle52GuidedGeneralSkeletonMiddleObligation and DAG node ASTIS.SALD.guided_general.cycle52_middle_route_audit; prop:guided_path_residual and thm:general-moving-target-SALD remain contractOnly, lower target sald.general_moving_target.kl_derivative appendix.tex:765-884, source-index regenerated, ASTIS check passed.
2026-05-26 06:18:12 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 06:26:06 lower/handoff queued gate=not-run :: Cycle 52 lower compiled the general moving-target derivative/DV scalar handoff through SALD.generalMovingTargetDerivativeDvGronwallCoefficientScalar, registered SALD.cycle52GuidedGeneralDerivativeDvLowerObligation and DAG node ASTIS.SALD.general_moving_target.cycle52_derivative_dv_lower, refreshed source-index, and passed python3 tools/astis.py check.
2026-05-26 06:26:28 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 06:28:14 reviewer/handoff queued gate=not-run :: Cycle 52 reviewer accepted: source-index regenerated 103 declarations and ASTIS check passed. Guided/general route and lower scalar derivative/DV handoff are source-anchored; theorem contracts remain contractOnly, analytic backends remain obligations/source-cited, and no fake closure, source drift, hidden assumption, SLT promotion, or backend promotion was found. Next lower target: sald.general_moving_target.kl_derivative over appendix.tex:765-884.
2026-05-26 06:28:26 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 06:28:35 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260526-062835-739967-ASTIS-SALD-001-cycle53/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260526-062835-739967-ASTIS-SALD-001-cycle53 --role reviewer --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role reviewer --kind handoff --status queued --artifact runs/20260526-062835-739967-ASTIS-SALD-001-cycle53 --notes "..."
```

## Role Instructions

Audit build gate, fake proof closures, source correspondence, cited results, and SLT port status. Reject contract drift, missing source anchors, or any claim marked proved without a compiled Lean declaration. Also check proof-skeleton discipline: reject cycles that only add rebaseline/ledger work or isolated scalar lemmas when the assigned proof target could have been wired into a theorem skeleton or precise source-cited analytic interface.
