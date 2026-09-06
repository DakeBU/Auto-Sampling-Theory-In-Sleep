# Open Problem Proposal

## Candidate Id

`ASTIS-XXX`

## Title

## Motivation

Which paper, draft, or proof obligation exposes this gap?

## Formal Target

What SDE, sampling, measure-theoretic, discretization, or concentration
statement should Lean certify?

## Acceptance Test

State the exact Lean artifact and build gate that would close the problem.

## References

- Paper/repository link:
- Source labels:

## Promotion Commands

```bash
python3 tools/astis.py trial-log --task TASK_ID --role reviewer --kind proposal --status queued --notes "promoted proof gap into open problem"
python3 tools/astis.py check
```

