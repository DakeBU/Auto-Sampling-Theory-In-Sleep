Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 47
Role: upper
Run directory: runs/20260526-040326-199166-ASTIS-SALD-001-cycle47

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
Main skeleton sprint 4: guided residual and general moving-target: Wire `prop:guided_path_residual` and `thm:general-moving-target-SALD` to the already named interfaces, matching `appendix.tex:619-951`; preserve the paper theorem statements and expose any missing analytic fact as a source-cited interface.
```

Recent trial memory:

```text
2026-05-26 03:46:41 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 03:52:44 middle/handoff queued gate=not-run :: Cycle 46 middle discrete forward-KL route audit added; source-index regenerated 103 declarations; python3 tools/astis.py check passed. Next lower target: sald.discrete_forward_kl.accumulated_error_bridge; EM conditional-FP, frozen-defect, LSI/KL/FI, DV, Gronwall, and residual exponent remain obligations/source-cited.
2026-05-26 03:53:17 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 04:00:05 lower/handoff queued gate=not-run :: Cycle 46 lower compiled discrete accumulated-error initial exponent split for thm:forward-KL-discrete; source-index regenerated; ASTIS check passed.
2026-05-26 04:00:27 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 04:02:57 reviewer/handoff queued gate=not-run :: Cycle 46 reviewer accepted: source-index regenerated 103 declarations and python3 tools/astis.py check passed. thm:forward-KL-discrete is still contractOnly; no fake closures or backend status promotions found. Next lower work should remain on sald.discrete_forward_kl.accumulated_error_bridge: endpoint rewrites, residual exponent monotonicity, barGamma/barDelta and A_alpha identifications, with EM FP/frozen-defect/DV/LSI/Gronwall still obligation/source-cited.
2026-05-26 04:03:17 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-26 04:03:26 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260526-040326-199166-ASTIS-SALD-001-cycle47/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260526-040326-199166-ASTIS-SALD-001-cycle47 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260526-040326-199166-ASTIS-SALD-001-cycle47 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and now prioritize theorem-level proof-skeleton closure over new transcript/ledger expansion or isolated scalar sublemmas. Before assigning middle/lower work, explicitly check that the five slow analytic backends have precise source-cited interfaces, then wire those interfaces into the theorem route: forward-KL, discrete forward-KL, guided residual, general moving-target, unified forward-KL, and discrete general moving-target. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized. Systematic measure-theory/SDE backfill guided by the local Statistical Learning Theory in Lean 4 material should begin only after the SALD theorem skeleton route is stable.
