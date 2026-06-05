# Agent Guide for Auto-Sampling-Theory-In-Sleep

This is a Lean-first SDE/Sampling proof project.  The repository is allowed to
contain theorem contracts and explicit proof obligations, but completed claims
must compile in Lean.

## Non-Negotiable Gate

```bash
python3 tools/astis.py check
```

The gate runs the Lake build and scans for fake proof closures.

## Operating Loop

1. Pick one task from `tasks/` or `AutoSamplingTheory/Automation.lean`.
2. Maintain a conversion window when translating between LaTeX, Markdown, and
   Lean.
3. Keep source labels indexed under `research-wiki/source-index/`.
4. Keep unproved analysis in `proof-obligations/` or
   `research-wiki/cited-results/`.
5. If using SLT results, update `research-wiki/cited-results/SLT_reuse_audit.md`
   with port status and version issues.
6. Run the gate.
7. Log serious attempts with `tools/astis.py trial-log`.

## Mode Discipline

`faithfulPaper` mode reproduces a paper.  Do not add assumptions, weaken the
statement, or replace the proof route without recording the exact source gap.

`exploratoryProof` mode validates active research.  Candidate proof routes can
compete, but success still requires a Lean-checkable target and reviewer audit.

## Review Discipline

Reject:

- `axiom`, `sorry`, `admit`, `Prop := True`, or `:= trivial` used to close math;
- hidden assumptions not present in the source proof;
- SLT/Mathlib dependencies marked as formalized before they build locally;
- faithful tasks that do not update source-to-Lean correspondence.
