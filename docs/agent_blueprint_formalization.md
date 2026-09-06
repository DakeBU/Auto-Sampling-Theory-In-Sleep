# Agent Blueprint Formalization Notes

ASTIS treats the agent workflow as an object that can be audited, and later
formalized, separately from the sampling/SDE theorem being proved.

## Goedel-Architect Similar Pattern

[arXiv:2606.06468](https://arxiv.org/abs/2606.06468) motivates using a
dependency DAG as the system of record.  ASTIS applies this to source theorem
leaves, probability/SDE technical lemmas, Mathlib portability gaps, and rejected
routes.  Solved leaves should be preserved; failed leaves should be classified
as wrong statement, missing dependency, proof too hard, or stale route.

## Lean4Agent Similar Pattern

[arXiv:2606.06523](https://arxiv.org/abs/2606.06523) motivates verifying the
workflow itself.  ASTIS can later model the upper/middle/lower/reviewer loop as
Lean data:

- structural checks: required agents and artifact edges exist;
- semantic checks: every lower task has a source theorem, preconditions, and a
  precise postcondition;
- trajectory checks: failed technical-lemma routes are recorded and not
  reassigned unchanged.

This process model does not prove sampling theorems.  It checks orchestration
discipline; `python3 tools/astis.py check` and Lean theorem statements remain
the mathematical authority.
