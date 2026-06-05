# ASTIS Proof Blueprints

These files are compact system-of-record snapshots for long-horizon Lean proof
automation tasks.

The design follows the useful LeanMarathon/QBE control pattern while adapting
it to SDE/Sampling papers:

- `ASTIS-SALD-001.md` is the human-facing proof blueprint for the active SALD
  faithful-paper reproduction.
- `ASTIS-SALD-001-blueprint-status.md` and `.json` are compact control-state
  summaries for prompts, context packs, and efficiency reports.

Refresh before long runs:

```bash
python3 tools/astis.py blueprint-refresh ASTIS-SALD-001
```
