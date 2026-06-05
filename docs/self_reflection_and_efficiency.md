# Self-Reflection And Efficiency Rules

ASTIS should spend long autonomous runs on proof progress, not on replaying
history.  The post-cycle-98 SALD state showed the main waste pattern:
upper/middle/lower/reviewer prompts repeatedly carried broad task contracts,
long trial memory, and broad theorem-route reminders even when the current
blocker was already narrow.

## Progress Metric

Every cycle must classify its main proof packet as exactly one of:

- `discharges-supplied-hypothesis`: a compiled local theorem removes an older
  supplied hypothesis.
- `narrows-source-cited-boundary`: the remaining theorem boundary is smaller,
  source-cited, and has explicit imports/hypotheses.
- `rejected-wrapper-churn`: the proposed work only restates an existing wrapper,
  broad ledger, broad route audit, or project-article task.

Reviewer treats unclassified cycles as inefficient even if `lake build` passes.
Build success is necessary; it is not a sufficient progress signal.

## Prompt Compression

For SALD cycles after cycle 84, `tools/astis.py` generates
`05_context_pack.md` in each run directory.  Agent prompts must use that compact
pack instead of replaying the full task file and raw trial history.

The compact pack contains:

- the fixed faithful-paper contract;
- the current reviewer blocker;
- recent high-signal handoffs only;
- local SLT/Mathlib reference targets;
- the LeanMarathon-inspired blueprint control state;
- retained LBG/EoH/ARIS memory boundaries: trial logs, negative cache,
  candidate populations for exploratory mode, and reviewer-agent handoffs;
- the self-reflection guard that every agent handoff must answer.

Use:

```bash
python3 tools/astis.py write-context-pack ASTIS-SALD-001 --cycle 99
```

before a manual run, and inspect the generated file if the next target is
unclear.

## LeanMarathon-Inspired Blueprint Control

ASTIS attributes and borrows LeanMarathon's Lean-specific control design:

- GitHub: https://github.com/YuanheZ/LeanMarathon
- arXiv: https://arxiv.org/abs/2606.05400

The adopted idea is not to turn ASTIS into a GitHub/Slurm PR system.  Instead,
ASTIS keeps the local sleep-run loop and adds a compact proof blueprint plus a
machine-readable control summary:

```bash
python3 tools/astis.py blueprint-refresh ASTIS-SALD-001
```

The generated `research-wiki/blueprints/ASTIS-SALD-001.md` plays the local
role of a LeanMarathon blueprint system-of-record snapshot.  The companion
`ASTIS-SALD-001-blueprint-status.md` and `.json` record the current dynamic
leaf candidate, the connected illness area if the blocker is a multi-node
defect, the latest reviewer blocker, recent packet classifications, and the
deterministic gate.

Cycle handoffs must now answer one additional question: is this a
dynamic-leaf worker packet or an illness-area refiner packet?  A worker packet
must stay inside the assigned local target/refinement region.  A refiner packet
must repair only the connected affected region and must classify the issue as
source drift or a genuine source gap.

## Retained Search And Agent Frame

LeanMarathon controls the proof blueprint, but ASTIS still relies on the older
automation frame:

- Learning Beyond Gradients style layered iteration keeps upper/middle/lower
  plus reviewer roles, `runs/trials.jsonl`, `runs/trials_summary.csv`,
  efficiency reports, negative caches, and rejected proof routes compact enough
  for later agents.
- EoH style population search is allowed only for `exploratoryProof` candidate
  routes under `candidate-populations/`; it is not allowed to mutate a
  `faithfulPaper` theorem.
- ARIS/QBE style upper/middle/lower/reviewer cycles remain the operational
  harness.  Reviewer is an independent role, not a decoration on the lower
  proof attempt.

## Efficiency Audit

Use:

```bash
python3 tools/astis.py efficiency-report --log runs/logs/<log>.log
```

or omit `--log` to inspect the latest SALD 6-hour log.  The report records:

- log size;
- detected cycles;
- token events and per-role token totals;
- packet classification counts;
- warnings for broad context replay and missing progress classification;
- the latest reviewer blocker.

The next 6-hour launch also writes the next-cycle compact context pack before
starting the background process and refreshes the proof blueprint plus its
control-state summary.

## Local SLT Reuse Protocol

ASTIS uses the local clone
`/home/nitanda_sub/mark/repos/RMFLD/lean-stat-learning-theory` as a
Mathlib-style proof engineering reference, not as a Lake dependency while the
toolchain mismatch remains.

Before inventing a new measure/probability interface, middle and lower should
consult:

- `SLT/EfronStein.lean` for conditional expectation and product-measure
  rewrites;
- `SLT/GaussianLSI/TensorizedGLSI.lean` for tensor/product and map-measure
  orientation;
- `SLT/GaussianMeasure.lean` and `SLT/SmallBallProb.lean` for `Measure.map`,
  integral, and Bochner-style proof idioms;
- `/home/nitanda_sub/mark/repos/RMFLD/Statistical Learning Theory in Lean 4
  Empirical Processes from Scratch` for the article-level methodology:
  state analytic hypotheses explicitly, separate background facts from local
  proof targets, and avoid overclaiming formalization status.

The correct borrowing pattern is:

1. search existing ASTIS declarations and ledgers;
2. inspect the local SLT file for a proof idiom or theorem shape;
3. port a small local statement if it compiles under ASTIS's toolchain;
4. otherwise record a source-cited `ProofObligation` with the exact missing
   theorem boundary.

## Current SALD Negative Cache

Do not spend another cycle on broad LSI/DV/Gronwall backfill unless the active
Euler--Maruyama backend is blocked by a named Mathlib/theory gap.  The current
high-priority blocker is:

- prove the concrete contraction bound;
- align `weakGradPairing` and `driftDiv` with the `hatRhoS` law integral;
- prove the no-boundary integration-by-parts theorem for `hatRhoS * barB`.

Broad source-index rebaseline, broad theorem-route audits, article export, and
new wrappers around the same assumptions are rejected unless they directly
close one of these items.

The current LeanMarathon-style dynamic leaf after the latest completed run is
read from `blueprint-refresh`; if it differs from this negative cache, the
generated proof blueprint takes precedence.
