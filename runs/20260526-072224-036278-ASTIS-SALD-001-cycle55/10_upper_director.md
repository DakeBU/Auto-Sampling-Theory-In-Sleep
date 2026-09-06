Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 55
Role: upper
Run directory: runs/20260526-072224-036278-ASTIS-SALD-001-cycle55

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
Main skeleton sprint 2: continuous forward-KL: Wire the source-cited analytic interfaces into the faithful proof skeleton for `thm:forward-KL`, matching `main_body.tex:238-247` and `appendix.tex:164-252` without changing constants, statements, or source labels.
```

Recent trial memory:

```text
2026-05-26 07:05:48 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 07:10:50 middle/handoff queued gate=not-run :: Cycle 54 middle added cycle54 middle analytic-interface audit contract+obligation+DAG node, wired all six theorem contracts/dependency names, synchronized ledgers, source-index regenerated (103 declarations), ASTIS check passed; analytic backends stay obligation/source-cited; next lower target sald.general_moving_target_discrete.kl_derivative appendix.tex:1354-1387.
2026-05-26 07:11:15 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 07:19:37 lower/handoff queued gate=not-run :: Cycle 54 lower formalized the appendix.tex:1380-1387 sigma-weighted conditional-FP divergence algebra as SALD.generalMovingTargetDiscreteConditionalFpSigmaLaplacianSplitHandoff, wired SALD.cycle54GeneralMovingTargetDiscreteEmFpLowerObligation/DAG/dependencies/ledgers/conversion window, regenerated source-index, and passed python3 tools/astis.py check; analytic EM conditional drift, density/AC, weak FP, KL differentiation, mass conservation, integration by parts, endpoint stitching, LSI, DV, and Gronwall remain obligations.
2026-05-26 07:19:55 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 07:21:58 reviewer/handoff queued gate=not-run :: Cycle 54 reviewer accepted: source-index regenerated 103 declarations and python3 tools/astis.py check passed; cycle54 analytic ledgers are wired into all six theorem contracts; lower sigma split compiles only as algebra under explicit FP/Laplacian/divergence-linearity hypotheses; theorem skeletons remain contractOnly and analytic backends remain obligation/source-cited; no fake closure, source drift, hidden assumption, or SLT promotion found. Next lower target remains sald.general_moving_target_discrete.kl_derivative over appendix.tex:1354-1387 for common-space, regular conditional drift, density/AC, weak EM Fokker-Planck, KL differentiation, mass conservation, integration by parts, and endpoint stitching.
2026-05-26 07:22:14 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 07:22:24 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260526-072224-036278-ASTIS-SALD-001-cycle55/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260526-072224-036278-ASTIS-SALD-001-cycle55 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260526-072224-036278-ASTIS-SALD-001-cycle55 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and now prioritize theorem-level proof-skeleton closure over new transcript/ledger expansion or isolated scalar sublemmas. Before assigning middle/lower work, explicitly check that the five slow analytic backends have precise source-cited interfaces, then wire those interfaces into the theorem route: forward-KL, discrete forward-KL, guided residual, general moving-target, unified forward-KL, and discrete general moving-target. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized. Systematic measure-theory/SDE backfill guided by the local Statistical Learning Theory in Lean 4 material should begin only after the SALD theorem skeleton route is stable.
