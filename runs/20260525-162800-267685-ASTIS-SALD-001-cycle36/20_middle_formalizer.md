Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 36
Role: middle
Run directory: runs/20260525-162800-267685-ASTIS-SALD-001-cycle36

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
Proof-closure sprint 1: Gronwall: Translate `appendix.tex:47-71` into Lean proof-producing code for `lem:gronwall`; avoid another source-index rebaseline unless reviewer finds a blocking anchor gap.
```

Recent trial memory:

```text
2026-05-25 16:08:48 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 16:17:37 middle/handoff queued gate=not-run :: Cycle 35 middle added compiled endpoint-vector and divergence-regrouping algebra for appendix.tex:260-385 EM interpolation FP backend; synchronized conversion window, proof obligations, SLT audit, DAG/dependencies, and kept analytic endpoint/conditional-FP backends as obligations. source-index ASTIS-SALD-001 and ASTIS check passed.
2026-05-25 16:17:59 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 16:25:04 lower/handoff queued gate=not-run :: Cycle 35 lower compiled SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff for appendix.tex:357-385 and synchronized the cycle35 EM-FP lower obligation/DAG/docs; analytic conditional drift density, conditional-FP theorem, Laplacian chain rule, KL integration by parts, endpoint stitching, LSI, DV, Gronwall, and accumulated-error collection remain obligations. source-index ASTIS-SALD-001 and ASTIS check passed.
2026-05-25 16:25:31 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 16:27:35 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 35: source-index refreshed 103 declarations and ASTIS check passed. Cycle 35 EM interpolation endpoint/vector and conditional-FP regrouping Lean lemmas are local algebra only; analytic FP, density, endpoint-law, integration-by-parts, stitched regularity, LSI, DV, Gronwall, and accumulated-error dependencies remain obligations. No fake proof closure, source drift, SLT promotion, or theorem-constant change found.
2026-05-25 16:27:51 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 16:28:00 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-162800-267685-ASTIS-SALD-001-cycle36/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-162800-267685-ASTIS-SALD-001-cycle36 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260525-162800-267685-ASTIS-SALD-001-cycle36 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and translate the paper proof into proof-producing Lean targets first; only add obligations when proof-producing code is genuinely blocked. Check the proof-closure order before planning: Gronwall, DV, LSI/KL/FI, forward-KL derivative, then EM interpolation Fokker--Planck. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During this sprint, avoid broad rebaseline work and avoid systematic SLT/SDE library import until the source-cited theorem interfaces needed by the five closure targets are precise. Export the Overleaf-ready project article only at the end of a multi-hour batch.
