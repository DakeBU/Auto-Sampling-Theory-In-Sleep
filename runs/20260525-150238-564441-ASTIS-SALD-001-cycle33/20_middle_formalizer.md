Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 33
Role: middle
Run directory: runs/20260525-150238-564441-ASTIS-SALD-001-cycle33

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
Proof-closure sprint 3: LSI/KL/FI: Translate `main_body.tex:202-215` into Lean proof-producing code for the LSI-to-KL/FI bridge, starting from density/test-function and coefficient sublemmas.
```

Recent trial memory:

```text
2026-05-25 14:44:48 upper/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 14:53:12 middle/handoff queued gate=not-run :: Cycle 32 middle added a compiled DV one-sided scalar bridge and middle source-to-Lean audit while keeping the full Donsker-Varadhan formula source-cited; source-index ASTIS-SALD-001 and python3 tools/astis.py check passed.
2026-05-25 14:53:45 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 14:59:27 lower/handoff queued gate=not-run :: Cycle 32 lower added compiled scalar DV supremum bridge AutoSamplingTheory.dvVariationalOneSidedFromSupremumScalar, synchronized SALD lower obligation plus conversion/proof/cited-result ledgers, kept lem:dv_variation sourceCited, and passed source-index plus python3 tools/astis.py check.
2026-05-25 14:59:55 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 15:02:11 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 32. source-index ASTIS-SALD-001 and python3 tools/astis.py check passed; lem:dv_variation remains Boucheron-source-cited with only scalar DV consequence bridges formalized and all analytic/admissibility witnesses explicit.
2026-05-25 15:02:29 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 15:02:38 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-150238-564441-ASTIS-SALD-001-cycle33/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-150238-564441-ASTIS-SALD-001-cycle33 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260525-150238-564441-ASTIS-SALD-001-cycle33 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and translate the paper proof into proof-producing Lean targets first; only add obligations when proof-producing code is genuinely blocked. Check the proof-closure order before planning: Gronwall, DV, LSI/KL/FI, forward-KL derivative, then EM interpolation Fokker--Planck. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During this sprint, avoid broad rebaseline work and avoid systematic SLT/SDE library import until the source-cited theorem interfaces needed by the five closure targets are precise. Export the Overleaf-ready project article only at the end of a multi-hour batch.
