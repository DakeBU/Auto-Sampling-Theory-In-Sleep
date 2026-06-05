# ASTIS Dashboard

## Status

- Active task: `ASTIS-SALD-001`
- Lean target: `AutoSamplingTheory/SALD.lean`
- Build gate: `python3 tools/astis.py check`

## Current Priorities

1. Faithfully index and translate the original VA-SALD paper proofs, excluding
   `sald_version_2.tex`.
2. Maintain an SLT reuse audit for Mathlib-based probability tools.
3. Create RMFLD exploratory proof-route memory without attempting large theorem
   proofs prematurely.
4. Preserve Phase 1 faithful-paper discipline before Phase 2 reusable API
   reorganization.
5. Keep the project-paper LaTeX export batch-based: update it after the final
   reviewer gate of a multi-hour run.
6. Adopt MathCode-style proof diagnostics where useful: theorem-reuse search
   before duplicate interfaces, hidden-assumption scans, placeholder scans,
   proof statistics, and subgoal decomposition as an internal work plan.

## First Commands

```bash
python3 tools/astis.py init
python3 tools/astis.py source-index ASTIS-SALD-001
python3 tools/astis.py source-index ASTIS-RMFLD-001
python3 tools/astis.py check
python3 tools/astis.py proof-diagnostics
python3 tools/astis.py launch-sald-6h
python3 tools/astis.py export-latex
```

Public automation reference:
https://github.com/DakeBU/Quantum-Computing-Block-Encoding/tree/wip/ghl2025-faithful-20260518-0201

MathCode workflow reference:
https://github.com/math-ai-org/mathcode
