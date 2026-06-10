# ASTIS Sleep-Run Guide

The normal repeated-cycle command is:

```bash
python3 tools/astis.py sleep-run ASTIS-SALD-001 --cycles 2 --lower-count 1 --dry-run
```

For long faithful-paper batches, use the graceful wall-clock runner:

```bash
python3 tools/astis.py sleep-run-window ASTIS-SALD-001 \
  --hours 6 \
  --lower-count 1 \
  --agent-cmd 'bash tools/astis_codex_faithful.sh {root} {prompt}' \
  --execute \
  --check-each-cycle \
  --after-latex
```

`sleep-run-window` checks the wall clock only before starting a new cycle.  Once
a cycle starts, upper, middle, lower, reviewer, and the optional build gate all
run to completion even if the nominal window expires.

The convenience launcher is:

```bash
python3 tools/astis.py launch-sald-6h
```

It starts the same graceful 6-hour SALD process under `nohup`, writes a PID
file, writes a log under `runs/logs/`, runs one lower worker per cycle, checks
each completed cycle, and refreshes the human-readable exports after the final
completed cycle.  This includes both the internal proof article under
`paper-notes/` and the external ASTIS technical-report snippets under
`/home/nitanda_sub/mark/repos/Auto_Proof_Papers/ASTIS`.  To disable this
batch-end writing pass for a proof-only run, use:

```bash
python3 tools/astis.py launch-sald-6h --no-after-latex
```

## Batch-End Writing Pass

The project article export is intentionally not done after every small lower
agent change.  During Lean-heavy cycles, middle maintains the conversion window
and proof-obligation ledger.  After the final reviewer gate, the writing pass
translates the accepted Lean state and remaining proof obligations into
Markdown/LaTeX for humans:

```bash
python3 tools/astis.py export-latex
```

`export-latex` also calls:

```bash
python3 tools/astis.py export-technical-report
```

The internal Overleaf-style proof-note entry point is:

```text
paper-notes/AutoLeanInSleepSampling/latex/main.tex
```

The external technical report snippets updated by each batch are:

```text
/home/nitanda_sub/mark/repos/Auto_Proof_Papers/ASTIS/sections/generated_run_status.tex
/home/nitanda_sub/mark/repos/Auto_Proof_Papers/ASTIS/sections/generated_middle_rules.tex
```

The generated snippets are explanatory projections.  Lean files, conversion
windows, proof obligations, and reviewer logs remain the source of truth.

## Monitoring

Use:

```bash
tail -f runs/logs/<run>.log
python3 tools/astis.py trial-summary
python3 tools/astis.py status
```

Do not kill a process just because the nominal 6-hour window has elapsed.  Let
the final cycle finish so that the dialogue board, trial log, reviewer gate,
and LaTeX export stay consistent.
