# LeanMarathon Reference Notes

Reference:

- GitHub: https://github.com/YuanheZ/LeanMarathon
- arXiv: https://arxiv.org/abs/2606.05400
- Shared local clone: `/home/nitanda_sub/mark/repos/outer_repos/LeanMarathon`
- Shared local PDF: `/home/nitanda_sub/mark/repos/outer_papers/LeanMarathon-2606.05400.pdf`

ASTIS studies LeanMarathon as a Lean-specific long-horizon autoformalization
harness.  The systems are similar in that both need durable state across long
agent runs, source-fidelity review, proof-DAG memory, and deterministic build
gates.  They differ in deployment target: LeanMarathon is a GitHub/PR/CI/Slurm
blueprint-discharge system for LeanArchitect-style theorem files, while ASTIS
is a local plain-file sleep-run system for SDE/Sampling papers and active
research drafts.

## Absorbed Controls

- Blueprint as system of record: ASTIS now writes
  `research-wiki/blueprints/<task>.md` as the compact proof blueprint, plus
  `<task>-blueprint-status.md` and `.json` as the current control summary.
- Stage separation: ASTIS maps faithful transcript stabilization to Stage 1
  and post-transcript proof backfill to a Stage-2-like dynamic-leaf discharge.
- Dynamic leaf selection: upper must choose the next local proof packet from
  the current blocker/DAG state rather than reopening broad route audits.
- Illness-area refiner: when a defect affects a connected blocker region,
  middle must name that local region and lower must avoid unrelated edits.
- No-more/no-less target review: reviewer checks that work neither proves a
  weaker theorem nor adds unsupported extra scope.
- Deterministic gate: `python3 tools/astis.py check` remains the only progress
  authority, analogous to LeanMarathon's CI gate.

## ASTIS Controls Preserved

- EoH-style candidate populations: exploratory proof routes may be initialized,
  varied, selected, and archived under `candidate-populations/`, but only after
  an explicit Lean-checkable acceptance target exists.
- Learning-beyond-gradients style memory: trial logs, efficiency reports,
  negative caches, source-cited failed routes, and rejected directions stay
  visible across cycles.
- ARIS/auto-research-in-sleep style long windows and role loops:
  `launch-sald-6h` still runs a graceful upper/middle/lower/reviewer cycle and
  exports human-readable notes after the batch.
- Plain-file local reproducibility: ASTIS does not require GitHub PRs, Slurm,
  branch protection, or external MCP servers to iterate on a local paper.
- Sampling/SDE specificity: source anchors, KL/FI/LSI/PI contracts,
  Fokker--Planck and Euler--Maruyama proof obligations, and SLT reuse audits
  remain first-class.

LeanMarathon strengthens the control layer; it does not replace the search
memory, candidate-population, or four-agent harness inherited from the earlier
ASTIS/QBE automation lineage.  See `docs/attribution.md` for the full
comparison table.

## Practical Rule

Before the next long run, inspect:

```bash
python3 tools/astis.py blueprint-refresh ASTIS-SALD-001
python3 tools/astis.py write-context-pack ASTIS-SALD-001 --cycle <next>
```

Then launch only if the dynamic leaf or illness area is clear enough for the
lower agent to work locally without broad history replay.
