Task: ASTIS-SALD-001 - Faithfully reproduce the original VA-SALD paper proofs
Cycle: 37
Role: middle
Run directory: runs/20260525-170636-313093-ASTIS-SALD-001-cycle37

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
Proof-closure sprint 2: Donsker--Varadhan: Translate `appendix.tex:73-79` and the cited DV result into a precise Lean interface or proof; if source-cited, keep status source-cited and use it as an explicit dependency only.
```

Recent trial memory:

```text
2026-05-25 16:51:59 middle/handoff queued gate=pass :: Cycle 36 middle compiled Gronwall global assembly under explicit Mathlib side conditions for appendix.tex:58-69, synchronized ledgers and tests, kept SALD.gronwallContract at obligation status, skipped source-index rebaseline because no source-anchor gap was found, and passed python3 tools/astis.py check.
2026-05-25 16:53:00 middle/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 17:02:19 lower/handoff queued gate=not-run :: Cycle 36 lower compiled continuous-data Gronwall wrapper for appendix.tex:47-71 and synchronized ledgers; gronwallContract remains obligation; ASTIS check passed.
2026-05-25 17:02:57 lower/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 17:05:19 reviewer/handoff queued gate=not-run :: Reviewer accepted cycle 36: ASTIS check passed; Gronwall assembly lemmas compile under explicit side conditions; full lem:gronwall remains obligation pending endpoint-safe differentiability/derivative-witness bridge; no fake closure, source drift, sign assumption, status promotion, SLT promotion, or source-index rebaseline needed.
2026-05-25 17:06:05 reviewer/build compiled gate=pass :: Cycle 36 reviewer mandatory gate: python3 tools/astis.py check passed.
2026-05-25 17:06:27 reviewer/attempt accepted gate=not-run :: External agent command exit code 0.
2026-05-25 17:06:36 reviewer/build compiled gate=pass :: Cycle build gate.
```

Shared dialogue board: `runs/20260525-170636-313093-ASTIS-SALD-001-cycle37/dialogue.md`

When finished, append a handoff:

```bash
python3 tools/astis.py agent-note 20260525-170636-313093-ASTIS-SALD-001-cycle37 --role middle --message "..."
python3 tools/astis.py trial-log --task ASTIS-SALD-001 --role middle --kind handoff --status queued --artifact runs/20260525-170636-313093-ASTIS-SALD-001-cycle37 --notes "..."
```

## Role Instructions

Maintain conversion windows, proof obligations, source indexes, SLT reuse audit, and lower packets. For SALD, read the TeX around the cycle focus and translate the paper proof into proof-producing Lean targets first; only add obligations when proof-producing code is genuinely blocked. Check the proof-closure order before planning: Gronwall, DV, LSI/KL/FI, forward-KL derivative, then EM interpolation Fokker--Planck. Before lower work, translate the relevant LaTeX proof step into Lean-facing declarations; after lower/reviewer work, translate accepted Lean declarations and remaining obligations back into Markdown/LaTeX notes. During this sprint, avoid broad rebaseline work and avoid systematic SLT/SDE library import until the source-cited theorem interfaces needed by the five closure targets are precise. Export the Overleaf-ready project article only at the end of a multi-hour batch.
