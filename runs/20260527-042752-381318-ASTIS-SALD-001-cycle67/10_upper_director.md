Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 67
Role: upper
Run directory: runs/20260527-042752-381318-ASTIS-SALD-001-cycle67

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
Main skeleton sprint 4: guided residual and general moving-target: Wire `prop:guided_path_residual` and `thm:general-moving-target-SALD` to the already named interfaces, matching `appendix.tex:619-951`; preserve the paper theorem statements and expose any missing analytic fact as a source-cited interface.
```

Recent trial memory:

```text
2026-05-27 04:09:45 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 04:15:07 middle/handoff queued gate=not-run :: Cycle 66 middle added and wired SALD.cycle66DiscreteForwardKlSkeletonMiddleContract/Obligation plus ASTIS.SALD.forward_KL_discrete.cycle66_middle_route_audit for thm:forward-KL-discrete; synchronized conversion/proof-obligation/SLT ledgers; lower target remains sald.discrete_forward_kl.accumulated_error_bridge; source-index and mandatory check passed.
2026-05-27 04:15:39 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 04:24:36 lower/handoff queued gate=not-run :: Cycle 66 lower compiled SALD.discreteForwardKlMainDisplayBoundScalar and added SALD.cycle66DiscreteForwardKlAccumulatedDisplayLowerObligation for the discrete forward-KL accumulated-error bridge display wrapper; ledgers synchronized; source-index and mandatory ASTIS check passed; theorem and slow analytic interfaces remain below formalized.
2026-05-27 04:25:19 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 04:27:18 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 66: source-index and mandatory ASTIS check passed; discrete forward-KL route/source correspondence and status discipline validated; lower compiled only SALD.discreteForwardKlMainDisplayBoundScalar local scalar wrapper; slow analytic backends and thm:forward-KL-discrete remain below formalized.
2026-05-27 04:27:43 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-27 04:27:52 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260527-042752-381318-ASTIS-SALD-001-cycle67/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260527-042752-381318-ASTIS-SALD-001-cycle67 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260527-042752-381318-ASTIS-SALD-001-cycle67 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. Begin with a concise `Global phase judgment:` paragraph that answers: did the previous cycle fail and need recovery; is Phase 1 theorem-skeleton translation stable enough for cited-theory backfill; and which single lower packet now reduces the largest proof risk. For SALD, keep the source theorem fixed and now prioritize theorem-level proof-skeleton closure over new transcript/ledger expansion or isolated scalar sublemmas. If recent trial memory shows a failed cycle after an upper or middle handoff, recover that cycle first instead of advancing to a new source target. Before assigning middle/lower work, explicitly check that the five slow analytic backends have precise source-cited interfaces, then wire those interfaces into the theorem route: forward-KL, discrete forward-KL, guided residual, general moving-target, unified forward-KL, and discrete general moving-target. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized. Systematic measure-theory/SDE backfill guided by the local Statistical Learning Theory in Lean 4 material should begin only after the SALD theorem skeleton route is stable, and then only one backend at a time.
