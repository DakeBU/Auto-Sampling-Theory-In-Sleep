# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `41`

## Upper Decision

Priority check before middle/lower assignment: (1) `lem:gronwall` is still the
active proof-closure target, despite cycle 36 local assembly helpers; (2)
`lem:dv_variation`; (3) `eq:LSI-KL-FI`; (4) the continuous forward-KL
Fokker--Planck/KL derivative identity; and (5) the EM interpolation
Fokker--Planck backend remain later in the queue.  No reviewer reported a
blocking source-anchor defect, so this cycle should not rebaseline the source
index.

Objective: faithfully close the remaining `appendix.tex:47-71` Gronwall bridge
from the source assumptions, "continuous `a_t,b_t` and differentiable `K_t` on
`[0,t_1]`", to the compiled Lean Gronwall display.  Middle/lower should first
try proof-producing Lean around `SALD.gronwallIntegratingFactorBoundOfContinuousData`
and the endpoint-safe derivative or absolute-continuity interface needed to
remove the extra continuous derivative witness.  If Mathlib cannot support the
full source statement this cycle, record one precise source-cited calculus
interface and keep `SALD.gronwallContract` at `ProofStatus.obligation`.

Mode discipline: `faithfulPaper`, Phase 1 only.  Use the original
`/home/nitanda_sub/mark/repos/sald/paper/appendix.tex`; `sald_version_2.tex`
stays out of scope.  Preserve the source signs and constants:
`dK/dt <= -a_t*K_t + b_t`,
`exp(-int_0^t1 a) * K_0`, and
`int_0^t1 exp(-int_t^t1 a) * b_t dt`.  Do not add sign, monotonicity, or
smoothness assumptions to downstream theorem statements.

Non-goals: no source-index rebaseline, no DV/LSI/forward-KL/EM proof search,
no polished article export, no external Gronwall replacement, and no promotion
of `sald.gronwall.integrating_factor`, `sald.gronwall.endpoint_calculus`, or
`sald.gronwall.exponent_rewrite` beyond their compiled-helper/obligation
status unless the full source-shaped Lean theorem builds.

Lower packet: target exactly `SALD.saldGronwallCandidateContract`,
`SALD.saldGronwallEndpointCalculusContract`,
`SALD.saldGronwallExponentRewriteContract`, `SALD.gronwallAnalyticObligation`,
`SALD.gronwallEndpointCalculusObligation`, and
`SALD.gronwallExponentRewriteObligation`.  Keep two-way synchronization among
`AutoSamplingTheory/SALD.lean`, `conversion-windows/ASTIS-SALD-001.md`,
`proof-obligations/ASTIS-SALD-001.md`, and the LaTeX source window.  Prefer a
compiled bridge from differentiability-on-interval/absolute-continuity data to
`SALD.gronwallIntegratingFactorBoundOfContinuousData`; otherwise create one
narrow source-cited interface with exact hypotheses.

Reviewer checklist: verify no hidden assumptions on `a`, `b`, or `K`; no
source drift from `appendix.tex:47-71`; no fake closure (`axiom`, `sorry`,
`admit`, `Prop := True`, or `:= trivial`); `SALD.gronwallContract` remains an
obligation unless a compiled theorem proves the exact display; and
`python3 tools/astis.py check` passes.

## Middle Formalization State

## Lower Attempts

## Reviewer Findings

## Next Cycle Objective
