# TASK_TITLE

Task id: `TASK_ID`
Kind: `faithfulPaper | exploratoryProof | sourceAudit | proofExport | openProblemProposal`
Status: `planned`

## Goal

State the sampling/SDE theorem, proof block, or paper section to formalize.

## Source

- Paper or draft:
- Section/theorem/lemma/equation:
- Local source file:
- Excluded files:

## Lean Target

```lean
-- declaration names here
```

## Proof Obligations

- [ ] Source anchor is exact.
- [ ] State space and measures are named.
- [ ] KL/FI/LSI/PI assumptions are explicit.
- [ ] Diffusion, velocity, or discretization contract is explicit.
- [ ] Cited analytic results are in `research-wiki/cited-results/`.
- [ ] Build gate passes.

## Trial Logging

```bash
python3 tools/astis.py trial-log --task TASK_ID --role lower --kind attempt --status running --notes "..."
python3 tools/astis.py trial-summary
```

## Build Gate

```bash
python3 tools/astis.py check
```

