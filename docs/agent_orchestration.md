# Agent Orchestration

ASTIS uses the same plain-file discipline as the Quantum automation project:
role prompt decks live in `runs/<run-id>/`, a dialogue board lives beside them,
and trial memory is appended to `runs/trials.jsonl`.

Public Quantum reference:
https://github.com/DakeBU/Quantum-Computing-Block-Encoding/tree/wip/ghl2025-faithful-20260518-0201

MathCode workflow reference:
https://github.com/math-ai-org/mathcode

Design-lineage ledger:
`docs/attribution.md`

The roles are:

- `upper`: classify mode, choose one objective, select the active dynamic leaf
  or illness area, and compress memory.
- `middle`: maintain conversion windows, SLT reuse audit, obligations, and
  theorem-reuse searches before introducing duplicate interfaces; translate
  source LaTeX into Lean-facing packets and accepted Lean back into
  Markdown/LaTeX.
- `lower`: work on one Lean/proof/source-index target or one exploratory
  candidate route.
- `reviewer`: audit build, source correspondence, cited results, and hidden
  assumptions.  Use `python3 tools/astis.py proof-diagnostics` for lightweight
  proof-statistics and hidden-placeholder summaries when needed.

This four-role loop is part of the retained ARIS/Learning-Beyond-Gradients/QBE
automation frame.  In particular, ASTIS keeps the LBG-style idea that the
system improves through role-separated iterations over code, logs, summaries,
tests, and rejected directions; the reviewer remains a separate gatekeeper.
LeanMarathon adds the proof-blueprint control state, dynamic leaf discipline,
and illness-area refiner rule; it does not remove the trial memory, negative
cache, candidate-population, or reviewer-agent components.

Generate a dry prompt deck:

```bash
python3 tools/astis.py run-cycle ASTIS-SALD-001 --cycle 1 --lower-count 1
```

Generate repeated decks:

```bash
python3 tools/astis.py sleep-run ASTIS-SALD-001 --cycles 2 --lower-count 1 --dry-run
```

Run a graceful 6-hour SALD batch:

```bash
python3 tools/astis.py launch-sald-6h
```

The launcher does not use shell `timeout`; once a cycle begins, it lets the
upper/middle/lower/reviewer sequence and build gate finish.  The batch-end
writing pass is generated only after the final completed cycle.  It updates
the internal proof-note export under `paper-notes/AutoLeanInSleepSampling/`
and the external ASTIS technical-report snippets under
`/home/nitanda_sub/mark/repos/Auto_Proof_Papers/ASTIS`.

The middle agent owns this two-way conversion layer.  During proof search it
keeps conversion windows and obligations synchronized; at batch end it performs
the ARIS-style paper-writing pass that explains the latest Lean state,
remaining blocker, source anchors, and updated coordination rules in
Markdown/LaTeX.

See `docs/phase_and_agent_tasklist.md` for the two-phase faithful-paper
discipline and `docs/sleep_run_guide.md` for monitoring details.
