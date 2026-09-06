---
name: astis-open-problem
description: Promote a persistent SDE/Sampling formalization gap into a precise open problem proposal.
argument-hint: "[task id or obligation id]"
---

# ASTIS Open Problem

Use this when a proof obligation is too broad for the current task but is
important enough to track as a reusable research infrastructure target.

## Proposal Requirements

- exact theorem or interface to formalize;
- source papers or draft anchors;
- downstream ASTIS tasks that would use it;
- expected Mathlib or SLT dependencies;
- acceptance test as a Lean declaration and build gate.

Use `templates/OPEN_PROBLEM_PROPOSAL_TEMPLATE.md` and log the promotion with:

```bash
python3 tools/astis.py trial-log --task TASK_ID --role reviewer --kind proposal --status queued --notes "..."
```

