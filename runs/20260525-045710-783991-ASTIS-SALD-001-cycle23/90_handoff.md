# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `23`

## Upper Decision

Cycle 23 upper selected the discrete forward-KL coefficient-chain audit as the
single lower target, after rebaselining the full source spine from
Euler--Maruyama interpolation through one-step frozen score defects and the
accumulated-error bridge.

Compiled packet: `SALD.cycle23DiscreteForwardKlUpperPacket`.
Proof-DAG node: `ASTIS.SALD.forward_KL_discrete.cycle23_upper_packet`.
Lower target: `SALD.discreteForwardKlCoefficientChainAuditContract` /
`SALD.discreteForwardKlCoefficientChainObligation` /
`sald.discrete_forward_kl.coefficient_chain_audit`.

First lower sub-slice: audit `appendix.tex:454-553`, including the two
`1/4*FI` cross-term bounds, LSI conversion, DV coefficient
`dot{t}(s)^2*alpha^(-1)`, and the time-change rewrite to
`dot{s}(t)^(-1)*alpha^(-1)`.

## Middle Formalization State

Middle should synchronize `AutoSamplingTheory/SALD.lean`,
`conversion-windows/ASTIS-SALD-001.md`,
`proof-obligations/ASTIS-SALD-001.md`, and
`research-wiki/source-index/SALD_original.jsonl` around
`main_body.tex:273-323` and `appendix.tex:260-592`.

## Lower Attempts

Not run by upper.  The lower packet intentionally avoids proving
`thm:forward-KL-discrete`; it should refine the named coefficient-chain
obligation or record exact source-contract gaps.

## Reviewer Findings

Reviewer should confirm the source theorem and constants are unchanged:
`T/(r*alpha)`, `2*r*eta^2*barGamma/alpha'`,
`(1/r)*A_alpha(pi,v)`, and `2*r*eta*barDelta_{alpha'}`.  No analytic backend
should be promoted beyond obligation/source-cited status.

## Next Cycle Objective

Middle: keep two-way Lean/Markdown/TeX synchronization for the cycle 23 packet.
Lower: start with the coefficient flow through `appendix.tex:454-553`, leaving
endpoint stitching, residual exponent drop, and full-interval accumulated
integral collection as explicit follow-on obligations unless proved locally.
