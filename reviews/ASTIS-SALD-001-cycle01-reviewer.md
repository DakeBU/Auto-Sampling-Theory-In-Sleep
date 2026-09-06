# ASTIS-SALD-001 Cycle 1 Reviewer Report

Reviewer decision: accept the cycle 1 source-index and first appendix
contract pass, with the analytic proof work still correctly recorded as
obligations or source-cited dependencies.

## Findings

- No rejection finding: `python3 tools/astis.py source-index ASTIS-SALD-001`
  refreshed `research-wiki/source-index/SALD_original.jsonl` with 24
  declarations and did not index `sald_version_2.tex`.
- No rejection finding: `python3 tools/astis.py check` passed after
  `lake exe cache get`, `lake build`, `lake build Tests`, and the stripped
  Lean fake-closure scan.
- Source correspondence is present for the cycle focus:
  `lem:gronwall`, `lem:dv_variation`, `def:PI`, and `eq:LSI-KL-FI` are
  anchored in `AutoSamplingTheory/SALD.lean`, the conversion window, and the
  proof-obligation ledger.
- Status discipline is preserved: Gronwall remains `ProofStatus.obligation`;
  DV remains `ProofStatus.sourceCited`; KL/FI/PI are contract-only vocabulary;
  LSI-to-KL/FI remains an obligation.
- SLT reuse status is not overstated: the audit keeps SLT as a reference/port
  candidate set and states that borrowed results must build locally before
  being marked formalized.

## Residual Risk

`SALD.saldGronwallCandidateContract` is still a contract-data interface, not a
compiled theorem.  The next faithful step should refine the endpoint-safe
closed-interval derivative formulation for the source phrase "differentiable
on `[0,t_1]`" before any downstream theorem is marked proved.
