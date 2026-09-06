Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 75
Role: upper
Run directory: runs/20260529-015453-735157-ASTIS-SALD-001-cycle75

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
2026-05-29 01:34:54 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 01:42:25 middle/handoff queued gate=not-run :: Cycle 74 middle added conditional-kernel source-to-Lean map for appendix.tex:1368-1377 via SALD.cycle74GeneralMovingTargetDiscreteMeasureInterfaceMiddleObligation/DAG; synced conversion window, proof obligations, and SLT audit; source-index and python3 tools/astis.py check passed; EM weak-FP/KL backend remains obligation/source-cited.
2026-05-29 01:42:52 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 01:51:22 lower/handoff queued gate=not-run :: Cycle 74 lower compiled supplied-kernel regularity handoff for conditional-law backend; source-index and check passed; condExpKernel/condDistrib construction and weak-FP/KL analytic backends remain obligations.
2026-05-29 01:52:03 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 01:54:24 reviewer/handoff queued gate=not-run :: Cycle 74 reviewer accepted: source-index ASTIS-SALD-001 and python3 tools/astis.py check passed; conditional-kernel measure interface remains sourceCited, theorem contracts remain contractOnly, no fake closures/source drift/status promotion/SLT import claim; EM weak FP and KL derivative backends remain obligations.
2026-05-29 01:54:44 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 01:54:53 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260529-015453-735157-ASTIS-SALD-001-cycle75/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260529-015453-735157-ASTIS-SALD-001-cycle75 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260529-015453-735157-ASTIS-SALD-001-cycle75 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. Begin with a concise `Global phase judgment:` paragraph that answers: did the previous cycle fail and need recovery; is Phase 1 theorem-skeleton translation stable enough for cited-theory backfill; and which single lower packet now reduces the largest proof risk. For SALD after cycle 69, treat the theorem-skeleton route as stable enough for single-backend backfill. Keep the source theorem fixed and now prioritize the active EM conditional-law/Fokker--Planck backend over new transcript/ledger expansion, broad theorem-route audits, or isolated scalar sublemmas. If recent trial memory shows a failed cycle after an upper or middle handoff, recover that cycle first instead of advancing to a new source target. Before assigning middle/lower work, explicitly check that the active lower packet still targets `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`, unless reviewer identified a theorem-route blocker. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized. Use `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory` as a reference for Mathlib measure/probability style when helpful, but do not import it as a Lake dependency or claim an SLT theorem is formalized unless a local ASTIS declaration compiles.
