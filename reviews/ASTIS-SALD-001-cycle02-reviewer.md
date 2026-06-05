# ASTIS-SALD-001 Cycle 2 Reviewer Report

Reviewer decision: accept the cycle 2 continuous forward-KL contract pass.
The cycle faithfully pins the source theorem and proof blocks while keeping
all analytic backends as obligations or cited dependencies.

## Findings

- No rejection finding: `python3 tools/astis.py source-index ASTIS-SALD-001`
  refreshed `research-wiki/source-index/SALD_original.jsonl` with 24 theorem
  or definition declarations and did not index `sald_version_2.tex`.
- No rejection finding: `python3 tools/astis.py check` passed after
  `lake exe cache get`, `lake build`, `lake build Tests`, and the stripped
  Lean fake-closure scan.
- Source correspondence for `thm:forward-KL` matches `main_body.tex:240-247`:
  LSI constants may be zero, `alpha0 > 0` and `alpha in (0, alpha0]` are
  preserved, and the two exponential factors plus residual integral match the
  source signs.
- The proof split matches `appendix.tex:168-252`: KL derivative/Fokker-Planck,
  LSI and inverse time change, DV velocity-energy, and Gronwall instantiation
  are represented by named Lean-facing contracts and proof obligations.
- Status discipline is preserved: `SALD.continuousSaldContract` and
  `SALD.continuousForwardKlStatementContract` remain contract-only;
  `SALD.forwardKlDerivativeObligation`,
  `SALD.forwardKlDvEnergyObligation`, and
  `SALD.forwardKlGronwallApplicationObligation` remain obligations; DV remains
  source-cited; Gronwall and LSI-to-KL/FI remain obligations.
- SLT reuse is not overstated: `research-wiki/cited-results/SLT_reuse_audit.md`
  records DV/entropy duality as source-cited/not ported, derivative and side
  conditions as local analytic obligations, and Gronwall as a Mathlib audit
  target.

## Residual Risk

The JSON source index currently records theorem-like LaTeX declarations only.
Equation and proof-block anchors such as `eq:SALD`, `eq:FP-eq`,
`def:alpha-complexity`, and `proof:thm:forward-KL:*` are present in Lean and
the conversion window, but not as separate JSON source-index rows.  This is not
a cycle rejection under the current `tools/astis.py source-index` contract, but
future reviewer packets should either keep this convention explicit or extend
the source-index parser before requiring those anchors as indexed rows.

Next faithful lower work should target exactly one backend interface: either
the inverse-schedule calculus obligation
`SALD.forwardKlScheduleTimeChangeObligation` or the density/boundary
regularity obligation `SALD.forwardKlDensityBoundaryObligation`.  It should
not attempt to prove or restate the full forward-KL theorem.
