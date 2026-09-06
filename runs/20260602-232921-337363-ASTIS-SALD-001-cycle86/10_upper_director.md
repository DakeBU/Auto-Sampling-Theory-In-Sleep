Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 86
Role: upper
Run directory: runs/20260602-232921-337363-ASTIS-SALD-001-cycle86

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
2026-06-02 23:09:59 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-06-02 23:18:43 middle/handoff queued gate=not-run :: Cycle 85 middle narrowed conditional-kernel theorem boundary with compiled local Mathlib helpers for condDistrib/condExpKernel orientation and vector-valued conditional-integral measurability/integrability; remaining lower theorem is hatRhoS state-field versioning. source-index and ASTIS check passed.
2026-06-02 23:19:14 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-06-02 23:26:30 lower/handoff queued gate=not-run :: Cycle 85 lower compiled condDistrib law-space/named-field regularity helpers, synchronized SALD DAG/dependencies, proof obligations, SLT audit, and source index. Classification: discharges-supplied-hypothesis for component-field measurability/integrability under hatRhoS; remaining theorem boundary is SALD-specific a.e. version choice and kernel compatibility/disintegration. source-index and ASTIS check passed.
2026-06-02 23:26:55 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-06-02 23:28:47 reviewer/handoff queued gate=not-run :: Cycle 85 reviewer accepted: source-index, proof-diagnostics, and ASTIS check passed; accepted conditional-kernel boundary progress classified discharges-supplied-hypothesis; remaining blocker is SALD-specific hatRhoS versioning/disintegration.
2026-06-02 23:29:11 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-06-02 23:29:21 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260602-232921-337363-ASTIS-SALD-001-cycle86/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260602-232921-337363-ASTIS-SALD-001-cycle86 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260602-232921-337363-ASTIS-SALD-001-cycle86 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. Begin with a concise `Global phase judgment:` paragraph that answers: did the previous cycle fail and need recovery; is Phase 1 theorem-skeleton translation stable enough for cited-theory backfill; and which single lower packet now reduces the largest proof risk. For SALD after cycle 69, treat the theorem-skeleton route as stable enough for single-backend backfill. Keep the source theorem fixed and now prioritize the active EM conditional-law/Fokker--Planck backend over new transcript/ledger expansion, broad theorem-route audits, or isolated scalar sublemmas. For SALD after cycle 84, do not let the run accumulate more supplied-hypothesis wrappers unless they discharge or strictly narrow an existing supplied hypothesis. The priority is a smallest real backend theorem boundary: conditional kernel/conditional expectation, generator-to-law weak FP, KL/log-ratio admissibility, or one named LSI/DV/Gronwall blocker. If recent trial memory shows a failed cycle after an upper or middle handoff, recover that cycle first instead of advancing to a new source target. Before assigning middle/lower work, explicitly check that the active lower packet still targets `sald.general_moving_target_discrete.em_interpolation_fp` over `appendix.tex:1358-1387`, unless reviewer identified a theorem-route blocker. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized. Use `/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory` as a reference for Mathlib measure/probability style when helpful, but do not import it as a Lake dependency or claim an SLT theorem is formalized unless a local ASTIS declaration compiles.

## Cycle 86 Upper Decision Output

Global phase judgment: cycle 85 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active lower packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; the single lower packet that best reduces the largest
remaining proof risk is the generator-to-law weak Fokker--Planck boundary at
`appendix.tex:1379-1387`.

Faithful-paper objective: use the cycle-79 `Measure.map`/Bochner integral
helpers and the cycle-85 conditional-field regularity progress to remove or
strictly narrow the supplied generator/time-derivative input
`partialS phi = generatorAction phi` consumed by
`SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`.

Mode discipline: preserve the paper statement, source signs
`-div(hat rho_s*bar b_{k,s})` and `+(sigma_eta^2/2) Delta hat rho_s`,
constants, source labels, and both discrete theorem contracts.  Keep all
analytic backends below `formalized` unless the corresponding local ASTIS
declaration compiles.

Non-goals: no theorem-route audit, broad source-index rebaseline, display
algebra, LSI/DV/Gronwall/frozen-delta work, KL/log-ratio work, SLT import, Lake
dependency change, or project-article export.

Lower packet: target exactly
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to `appendix.tex:1379-1387`.  Preferred
product is a compiled theorem using
`AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample` and Mathlib
parametric/Bochner integral APIs that discharges a supplied generator,
source-action, or weak-test regularity hypothesis.  If blocked, record one
strictly smaller missing theorem with imports and hypotheses.  Classify the
lower result as `discharges-supplied-hypothesis`,
`narrows-source-cited-boundary`, or `rejected-wrapper-churn`.

Reviewer checklist: reject wrapper churn, hidden weak-FP closure, source-sign or
coefficient drift, theorem/EM-backend/SLT status promotion, and Lake dependency
changes.  Require `python3 tools/astis.py source-index ASTIS-SALD-001` and
`python3 tools/astis.py check` to pass.
