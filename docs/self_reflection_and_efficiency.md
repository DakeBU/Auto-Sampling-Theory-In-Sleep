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
- task-local paper contribution memory and unfinished source-line coverage;
- local ASTIS technical lemma memory and Mathlib reference targets;
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

## Technical Lemma Memory Protocol

ASTIS uses compiled local technical lemmas as the callable memory layer for
SDE/Sampling proof work.  External repositories such as
`/home/nitanda_sub/mark/repos/outer_repos/sampling_theory_sde/lean-stat-learning-theory`
are only source material for local ports and provenance records, not runtime
dependencies.

Before inventing a new measure/probability interface, middle and lower should
consult:

- `AutoSamplingTheory/TechnicalLemmas/Gaussian.lean` and
  `AutoSamplingTheory/TechnicalLemmas/Taylor.lean` for compiled local lemmas;
- `AutoSamplingTheory/TechnicalLemmas/Registry.lean` and
  `research-wiki/technical-lemma-memory/technical_lemma_registry.jsonl` for
  local lemma names, tags, and SALD uses;
- `research-wiki/technical-lemma-memory/SALD_remaining_map.md` for the current
  SALD leaf-to-lemma mapping;
- `research-wiki/technical-lemma-memory/SLT_port_queue.jsonl` for upstream
  theorem shapes that still require local ASTIS ports;
- `/home/nitanda_sub/mark/repos/outer_papers/sampling_theory_sde/Statistical Learning Theory in Lean 4 Empirical Processes from Scratch`
  for the article-level methodology:
  state analytic hypotheses explicitly, separate background facts from local
  proof targets, and avoid overclaiming formalization status.

The correct borrowing pattern is:

1. search existing ASTIS declarations, technical lemma memory, and ledgers;
2. inspect the local SLT file only for a proof idiom or theorem shape if no
   ASTIS lemma exists;
3. port a small local statement into `AutoSamplingTheory/TechnicalLemmas` if
   it compiles under ASTIS's toolchain;
4. otherwise record a source-cited `ProofObligation` with the exact missing
   theorem boundary.

## Paper Contribution Memory Protocol

Faithful-paper proof state must live separately from reusable technical lemma
memory.  For `ASTIS-SALD-001`, the task-local paper memory is:

```text
research-wiki/paper-memory/ASTIS-SALD-001/
```

The key file is:

```text
research-wiki/paper-memory/ASTIS-SALD-001/unfinished_source_map.md
```

It records the SALD-specific source line range, Lean boundary, status, and
next action for each unfinished paper contribution leaf.  Middle must consult
this file before assigning lower work.  Lower must name either one source-line
leaf from this file or one compiled technical lemma registry entry.  Reviewer
rejects a cycle if it claims completion while an active paper leaf is marked
`line-range-missing`.

At the end of a long run, the finalizer refreshes the paper memory, TODO,
Chinese summary, and technical-report snippets together.  This prevents a
cycle from looking successful in Lean while leaving humans unable to see which
SALD LaTeX lines remain unfinished.

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
