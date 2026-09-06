# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `31`

## Upper Decision

Priority check: current proof-closure order is (1) `lem:gronwall`,
(2) `lem:dv_variation`, (3) `eq:LSI-KL-FI`, (4) the forward-KL
Fokker--Planck/KL derivative identity, and (5) the Euler--Maruyama
interpolation Fokker--Planck backend.  Cycle 31 chooses item 1 only.

Objective: faithfully translate `appendix.tex:47-71` for `lem:gronwall` into
proof-producing Lean work, with the first lower slice on the integrating-factor
inequality in `appendix.tex:58-61`.

Mode discipline: `faithfulPaper`; keep the theorem statement fixed with
continuous `a_t,b_t`, differentiable `K_t` on `[0,t1]`, and
`dK_t/dt <= -a_t*K_t + b_t`.  Preserve the displayed factors
`exp(-int_0^t1 a)` and `exp(-int_t^t1 a)`, and do not add sign assumptions on
`a`, `b`, or `K`.

Non-goals: no source-index rebaseline unless reviewer finds a blocking anchor
gap; no DV, LSI/KL/FI, forward-KL derivative, EM interpolation, theorem
restatement, or Phase 2 API cleanup in this upper packet.

Lower packet: target `sald.gronwall.integrating_factor` through
`SALD.saldGronwallCandidateContract` and
`SALD.saldGronwallEndpointCalculusContract`.  First attempt a compiled real
algebra helper near `SALD.gronwallIntegratingFactorDerivativeInequalityScalar`:
from `I>0` and `K' <= -a*K+b`, prove
`a*I*K + I*K' <= I*b`, matching `appendix.tex:58-61`.  If that closes, proceed
to the narrowest endpoint-safe `HasDerivAt`/`HasDerivWithinAt` wrapper for
`I(t)=Real.exp (integral 0 t a)`.  If FTC/order integration is too large,
record only that precise backend obligation and keep `lem:gronwall` below
formalized.

Reviewer checklist: confirm the cycle stayed on `lem:gronwall`, did not add a
source-index rebaseline, did not change constants/signs/source hypotheses, did
not promote the full lemma without compiled proof, and passed
`python3 tools/astis.py check`.

## Middle Formalization State

## Lower Attempts

## Reviewer Findings

## Next Cycle Objective
