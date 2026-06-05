---
name: astis-proof-export
description: Export accepted ASTIS Lean proof blocks into synchronized Markdown and LaTeX proof notes.
argument-hint: "[task id or paper key]"
---

# ASTIS Proof Export

Use this at the end of a faithful-paper batch or when a human-readable proof
document is needed.

## Cadence

Do not export after every small lower-agent update.  During a multi-hour
faithful-paper run, the middle agent keeps conversion windows and obligation
ledgers synchronized.  After the final upper/middle/lower/reviewer cycle has
finished and the reviewer gate has passed, run:

```bash
python3 tools/astis.py export-latex
```

This writes the larger Auto-Lean-in-Sleep Sampling Theory article and places
the current SALD faithful reproduction as an appendix case study.

## Required Artifacts

- `paper-notes/AutoLeanInSleepSampling/markdown/*.md`
- `paper-notes/AutoLeanInSleepSampling/latex/main.tex`
- `paper-notes/AutoLeanInSleepSampling/latex/sections/*.tex`
- `paper-notes/AutoLeanInSleepSampling/latex/figures/*.tex`

The LaTeX master file should compile in Overleaf with ordinary packages such as
`amsmath`, `amssymb`, `mathtools`, `hyperref`, `longtable`, and `tikz`.

## Required Content

For each accepted proof block, include:

1. Source anchor and Lean declaration name.
2. Definitions and assumptions used in the statement.
3. Mathematical theorem statement.
4. Proof explanation matching the Lean route.
5. Dependencies on previous proof blocks and cited results.
6. Remaining obligations.

## Rule

Do not mark an obligation as proved unless the Lean declaration exists and
`python3 tools/astis.py check` passed after it was added.

The SALD case export is not a replacement for the source paper.  It is the
human-readable proof map for the current Lean state, with all unproved analytic
ingredients left as explicit obligations.
