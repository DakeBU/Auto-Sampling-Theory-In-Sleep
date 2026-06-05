Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 78
Role: upper
Run directory: runs/20260529-031713-481583-ASTIS-SALD-001-cycle78

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
2026-05-29 02:54:32 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 03:05:32 middle/handoff queued gate=not-run :: Cycle 77 middle compiled generator-level weak FP source-sign handoff SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorHandoff; source-index and ASTIS check passed; weak FP/generator theorem remains obligation.
2026-05-29 03:06:06 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 03:14:11 lower/handoff queued gate=not-run :: Cycle 77 lower compiled SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff for appendix.tex:1379-1387, splitting the supplied generator source expansion into drift and diffusion actions while preserving -div drift and +(sigma_eta^2/2) Delta diffusion; source-index ASTIS-SALD-001 and python3 tools/astis.py check passed; actual EM generator/conditional-law/density/KL/LSI/DV/Gronwall backends remain obligations.
2026-05-29 03:15:00 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 03:16:51 reviewer/handoff queued gate=not-run :: Cycle 77 reviewer accepted: source-index and check passed; compiled local generator/source-sign wrappers preserve weak FP signs under supplied hypotheses; no fake closures/source drift/status promotion/SLT import/Lake dependency change; EM analytic backend and theorem closures remain obligations.
2026-05-29 03:17:04 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-29 03:17:13 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260529-031713-481583-ASTIS-SALD-001-cycle78/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260529-031713-481583-ASTIS-SALD-001-cycle78 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260529-031713-481583-ASTIS-SALD-001-cycle78 --notes "..."
```

## Upper Cycle 78 Handoff

Global phase judgment: cycle 77 passed reviewer/build and needs no recovery;
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill; the single lower packet that best reduces the remaining proof risk
is the KL-derivative handoff from the cycle-77 generator-level weak conditional
Fokker--Planck source signs, still inside
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`.

Objective: connect the supplied generator/time-derivative and split
drift/diffusion source-action hypotheses to `eq:general_KL_derivative_0_discrete`
at the admissible log-ratio test, without changing the paper statement,
constants, signs, or source labels.

Lower packet: target
`SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfGeneratorPieces` /
`SALD.cycle78GeneralMovingTargetDiscreteKlDerivativeGeneratorLowerObligation` /
`sald.general_moving_target_discrete.cycle78_kl_derivative_generator_lower`.
The compiled scope is only equality composition under explicit hypotheses.

Non-goals: no generator theorem, weak FP theorem, density/AC, log-ratio
admissibility, KL differentiation theorem, integration-by-parts, LSI/KL/FI,
DV, Gronwall, theorem-status promotion, SLT import, or source-index rebaseline
beyond the required acceptance command.

Reviewer checklist: confirm the active packet remains
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; the new wrapper is local equality bookkeeping only;
`thm:forward-KL-discrete` and `thm:general-moving-target-SALD-discrete` remain
`contractOnly`; source-index and `python3 tools/astis.py check` pass.

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. Begin with a concise `Global phase judgment:` paragraph that answers: did the previous cycle fail and need recovery; is Phase 1 theorem-skeleton translation stable enough for cited-theory backfill; and which single lower packet now reduces the largest proof risk. For SALD after cycle 69, treat the theorem-skeleton route as stable enough for single-backend backfill. Keep the source theorem fixed and now prioritize the active EM conditional-law/Fokker--Planck backend over new transcript/ledger expansion, broad theorem-route audits, or isolated scalar sublemmas. If recent trial memory shows a failed cycle after an upper or middle handoff, recover that cycle first instead of advancing to a new source target. Before assigning middle/lower work, explicitly check that the active lower packet still targets `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`, unless reviewer identified a theorem-route blocker. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized. Use `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory` as a reference for Mathlib measure/probability style when helpful, but do not import it as a Lake dependency or claim an SLT theorem is formalized unless a local ASTIS declaration compiles.
