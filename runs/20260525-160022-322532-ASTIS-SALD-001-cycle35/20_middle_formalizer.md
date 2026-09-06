Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 35
Role: middle
Run directory: runs/20260525-160022-322532-ASTIS-SALD-001-cycle35

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
2026-05-25 15:49:38 middle/handoff queued gate=not-run :: Cycle 34 middle compiled SALD.forwardKlTimeChangedDerivativeBoundScalar for forward-KL appendix.tex:218-228 and synchronized SALD.cycle34ForwardKlDerivativeMiddleContract plus ledgers; source-index ASTIS-SALD-001 and ASTIS check passed.
2026-05-25 15:50:07 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 15:57:26 lower/handoff queued gate=not-run :: Cycle 34 lower proof-producing slice: added SALD.forwardKlTargetTransportYoungBoundScalar and SALD.forwardKlPostYoungDerivativeBoundOfCauchyScalar for appendix.tex:199-208 target-side Cauchy-Young bookkeeping; registered sald.forward_kl.cycle34_target_young_lower and kept analytic transport/Cauchy, KL derivative, LSI, time-change, DV, and Gronwall as obligations. source-index ASTIS-SALD-001 and python3 tools/astis.py check passed.
2026-05-25 15:57:51 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 15:59:40 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 34: source-index ASTIS-SALD-001 and python3 tools/astis.py check passed. Cycle 34 forward-KL scalar lemmas compile and are faithful to appendix.tex:168-228 without promoting analytic KL derivative, Fokker-Planck, integration by parts, target Cauchy, LSI, schedule time-change, DV, or Gronwall obligations; no fake closures or SLT drift found.
2026-05-25 15:59:59 reviewer/build compiled gate=pass :: Cycle 34 reviewer gate: source-index ASTIS-SALD-001 refreshed 103 declarations; python3 tools/astis.py check passed after Lake build and Tests build.
2026-05-25 16:00:13 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 16:00:22 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-160022-322532-ASTIS-SALD-001-cycle35/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-160022-322532-ASTIS-SALD-001-cycle35 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260525-160022-322532-ASTIS-SALD-001-cycle35 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and translate the paper proof into proof-producing Lean targets first; only add obligations when proof-producing code is genuinely blocked. Check the proof-closure order before planning: Gronwall, DV, LSI/KL/FI, forward-KL derivative, then EM interpolation Fokker--Planck. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During this sprint, avoid broad rebaseline work and avoid systematic SLT/SDE library import until the source-cited theorem interfaces needed by the five closure targets are precise. Export the Overleaf-ready project article only at the end of a multi-hour batch.
