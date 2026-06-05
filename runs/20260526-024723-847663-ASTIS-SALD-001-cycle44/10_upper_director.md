Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 44
Role: upper
Run directory: runs/20260526-024723-847663-ASTIS-SALD-001-cycle44

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
2026-05-25 20:04:06 middle/handoff queued gate=not-run :: Cycle 43 middle compiled RN density normalization and entropy transport lemmas for LSI/KL/FI bridge; synced Lean/docs/SLT audit/source-index; check passed; full eq:LSI-KL-FI remains obligation pending admissibility/approximation and vector/integral Fisher chain rule.
2026-05-25 20:06:23 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 20:14:22 lower/handoff queued gate=not-run :: Cycle 43 lower compiled finite-coordinate integral Fisher-chain handoffs for main_body.tex:208-215; synced SALD lower obligation, conversion window, proof-obligation ledger, SLT audit, and Tests/Basic; source-index ASTIS-SALD-001 and python3 tools/astis.py check passed; eq:LSI-KL-FI/probability.lsi_to_kl_fi remain obligations with vector-gradient equivalence, zero-density Sobolev handling, sqrt-test admissibility/approximation, and finite theorem-level KL/FI interfaces open.
2026-05-25 20:14:42 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 20:17:23 reviewer/handoff queued gate=not-run :: Cycle 43 reviewer accepted: source-index ASTIS-SALD-001 passed/regenerated 103 declarations and python3 tools/astis.py check passed. main_body.tex:202-215 source anchor is preserved; cycle 43 compiled sublemmas do not promote eq:LSI-KL-FI/probability.lsi_to_kl_fi. No fake proof closures, contract drift, hidden assumptions, source drift, SLT promotion, or proof-closure discipline issue found.
2026-05-25 20:18:15 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 20:18:24 reviewer/build compiled gate=pass :: Cycle build gate.
2026-05-25 20:18:24 upper/compression accepted gate=not-run :: Graceful sleep window completed 13 cycle(s); final cycle was not interrupted.
```

Shared dialogue board: `runs/20260526-024723-847663-ASTIS-SALD-001-cycle44/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260526-024723-847663-ASTIS-SALD-001-cycle44 --role upper --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role upper --kind handoff --status queued --artifact runs/20260526-024723-847663-ASTIS-SALD-001-cycle44 --notes "..."
```

## Role Instructions

Choose one faithful-paper objective, mode discipline, non-goals, lower packet, and reviewer checklist. For SALD, keep the source theorem fixed and now prioritize theorem-level proof-skeleton closure over new transcript/ledger expansion or isolated scalar sublemmas. Before assigning middle/lower work, explicitly check that the five slow analytic backends have precise source-cited interfaces, then wire those interfaces into the theorem route: forward-KL, discrete forward-KL, guided residual, general moving-target, unified forward-KL, and discrete general moving-target. Do not spend the cycle on source-index rebaseline unless reviewer found a blocking source-anchor defect. Faithful work has two phases: Phase 1 is a complete source-to-Lean transcript with exact constants and obligations; Phase 2, only after the transcript is complete, reorganizes reusable APIs for teaching, later SDE/Sampling papers, and exploratoryProof mode. Require middle to keep two-way Lean/Markdown/LaTeX synchronization, but defer polished project-article export to the batch end. If a cited analytic theorem is too large to prove now, require a precise source-cited interface and keep its status below formalized. Systematic measure-theory/SDE backfill guided by the local Statistical Learning Theory in Lean 4 material should begin only after the SALD theorem skeleton route is stable.
