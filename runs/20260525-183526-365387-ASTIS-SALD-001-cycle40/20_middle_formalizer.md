Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 40
Role: middle
Run directory: runs/20260525-183526-365387-ASTIS-SALD-001-cycle40

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

## Current 6h Priority: Proof Closure Sprint

The first transcript pass is broad enough to stop spending cycles on
rebaseline/source-index work unless a reviewer finds a blocking source anchor
gap.  The next batch should prioritize translating the paper's actual LaTeX
proofs into Lean code and closing theorem dependencies in this order:

1. `lem:gronwall`
2. `lem:dv_variation`
3. `eq:LSI-KL-FI`
4. the forward-KL Fokker--Planck/KL derivative identity
5. the Euler--Maruyama interpolation Fokker--Planck backend

Upper and middle agents must explicitly check this priority before assigning
lower work.  Lower agents should attempt proof-producing Lean lemmas first.
If a source-cited analytic theorem is too large for the current local Mathlib
state, create a precise source-cited theorem interface and use it only as an
explicit dependency; do not mark it formalized.  Systematic migration of
external SDE/Sampling facts, including material analogous to
`YuanheZ/lean-stat-learning-theory`, belongs after these proof-closure
interfaces are in place.

## Acceptance Gate

```bash
python3 tools/astis.py source-index ASTIS-SALD-001
python3 tools/astis.py check
```
```

Cycle focus:

```text
Proof-closure sprint 5: EM interpolation Fokker--Planck: Translate `appendix.tex:260-385` into the Euler--Maruyama interpolation endpoint and conditional-drift Fokker--Planck backend.
```

Recent trial memory:

```text
2026-05-25 18:22:14 middle/handoff queued gate=not-run :: Cycle 39 middle compiled source-shaped scalar schedule/velocity handoffs for forward-KL derivative appendix.tex:168-228; synchronized Lean DAG/dependencies, conversion window, proof obligations, SLT audit, and source-index; ASTIS check passed. Remaining analytic backends stay obligations.
2026-05-25 18:22:54 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 18:31:13 lower/handoff queued gate=not-run :: Cycle 39 lower compiled source-shaped forward-KL derivative scalar handoffs for appendix.tex:210-228: SALD.forwardKlLsiDerivativeBoundOfKlFiScalar and SALD.forwardKlPreDvDerivativeBoundOfKlFiVelocityScalingScalar. Synchronized conversion/proof-obligation/SLT notes and Lean dependency wiring. source-index and ASTIS check passed; analytic KL derivative, LSI backend, schedule calculus, DV, Gronwall, and EM interpolation remain obligations.
2026-05-25 18:32:14 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 18:34:49 reviewer/build compiled gate=pass :: Cycle 39 reviewer gate: source-index regenerated 103 SALD declarations; python3 tools/astis.py check passed.
2026-05-25 18:35:01 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 39: source-index and ASTIS check passed; scalar forward-KL derivative handoffs compile; analytic KL derivative, density/boundary, schedule-time-change, LSI, DV, Gronwall, endpoint, and EM obligations remain explicit; no fake closure, status promotion, source drift, SLT import, or proof-closure discipline issue found.
2026-05-25 18:35:17 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 18:35:26 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-183526-365387-ASTIS-SALD-001-cycle40/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-183526-365387-ASTIS-SALD-001-cycle40 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260525-183526-365387-ASTIS-SALD-001-cycle40 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and translate the paper proof into proof-producing Lean targets first; only add obligations when proof-producing code is genuinely blocked. Check the proof-closure order before planning: Gronwall, DV, LSI/KL/FI, forward-KL derivative, then EM interpolation Fokker--Planck. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During this sprint, avoid broad rebaseline work and avoid systematic SLT/SDE library import until the source-cited theorem interfaces needed by the five closure targets are precise. Export the Overleaf-ready project article only at the end of a multi-hour batch.

## Middle Handoff

Priority check: Gronwall, DV, LSI/KL/FI, and the continuous forward-KL
derivative have current compiled substeps but still leave analytic backends
open, so this middle pass follows item (5), the EM interpolation
Fokker--Planck backend for `appendix.tex:260-385`.

Compiled Lean additions:

- `SALD.discreteForwardKlLawEqOfPointwise`
- `SALD.discreteForwardKlEmInterpolationLeftEndpointLawHandoff`
- `SALD.discreteForwardKlEmInterpolationRightEndpointLawHandoff`
- `SALD.cycle40DiscreteForwardKlEmFpMiddleContract`
- `SALD.cycle40DiscreteForwardKlEmFpMiddleObligation`

Lower packet:

- instantiate the endpoint-law handoffs with the concrete law/density notation
  for `hat rho_s`, `rho_k^eta`, and `rho_{k+1}^eta`;
- refine `sald.discrete_forward_kl.conditional_drift_density` for the regular
  conditional law and measurability/integrability of `bar b_{k,s}`;
- then state or prove the source-cited conditional-drift Fokker--Planck theorem
  that supplies the `hfp` and Laplacian-split inputs consumed by
  `SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff`;
- keep frozen-delta, LSI, DV, Gronwall, coefficient-chain, and accumulated
  error work outside this lower packet.

The new endpoint-law handoffs are abstract equality transport only. They do not
construct Brownian motion, regular conditional laws, densities, the
Fokker--Planck theorem, KL differentiation, or `thm:forward-KL-discrete`.
