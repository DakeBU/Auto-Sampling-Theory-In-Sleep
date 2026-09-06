# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `2`

## Upper Decision

Pin `thm:forward-KL` in faithful-paper mode before proof search.  The source
statement is fixed at `main_body.tex:240-247`, with proof route
`appendix.tex:166-252`; `sald_version_2.tex` remains out of scope.

Compiled Lean-facing additions:

- `SALD.continuousForwardKlStatementContract` records the exact moving-target
  assumptions, alpha-complexity condition, terminal KL bound shape, and proof
  steps.
- `SALD.forwardKlDerivativeObligation`,
  `SALD.forwardKlDvEnergyObligation`, and
  `SALD.forwardKlGronwallApplicationObligation` split the source proof into
  lowerable obligations.
- `SALD.continuousSaldContract` now carries LSI, DV, Gronwall, KL-derivative,
  DV-energy, and Gronwall-instantiation dependencies without marking any as
  formalized.

Lower packet: refine the KL derivative obligation for `appendix.tex:166-225`
into an endpoint- and boundary-condition-aware Lean interface.  Preserve the
source inequality and record any missing schedule regularity or density
smoothness as a source gap.

Reviewer checklist: verify source statement/proof anchors, theorem exponent
shape, dependency statuses (`sourceCited`/`obligation`), and absence of fake
proof closures.

## Middle Formalization State

Middle refined the continuous forward-KL proof chain into compiled contract
data and synchronized the paper window:

- Added source anchors for `eq:SALD`, `eq:FP-eq`, `def:alpha-complexity`, and
  the three appendix proof blocks for derivative, DV-energy, and Gronwall.
- Added `SALD.saldAlphaComplexityContract`,
  `SALD.forwardKlDerivativeCandidateContract`,
  `SALD.forwardKlDvEnergyCandidateContract`,
  `SALD.forwardKlGronwallInstantiationContract`, and
  `SALD.forwardKlProofDag`.
- Updated `proof-obligations/ASTIS-SALD-001.md` with the middle audit:
  inverse-schedule regularity, density/differentiation/IBP conditions,
  finite-log-mgf DV witness, and Gronwall regularity remain obligations.
- Updated `research-wiki/cited-results/SLT_reuse_audit.md`: DV/entropy-duality
  remains source-cited/not ported; derivative and Gronwall are local/Mathlib
  proof obligations, not SLT formalizations.

## Lower Attempts

Recommended lower packet: refine only
`SALD.forwardKlDerivativeCandidateContract` for `appendix.tex:168-228` into a
narrow Lean-facing statement.  Preserve the source inequality
`dK/dt <= -dot{s}(t)*C_LSI(t)*K(t)
+ (1/2)*dot{s}(t)^(-1)*||v_t||_{L2(rho_{s(t)})}^2` and expose schedule,
density, and boundary assumptions as obligations.

Lower refinement completed:

- Added `SALD.forwardKlDerivativeSideConditionContract` as compiled contract
  data for the implicit density, boundary, mass-conservation, Cauchy--Young,
  and inverse-schedule side conditions in `appendix.tex:168-228`.
- Added `SALD.forwardKlDensityBoundaryObligation` and
  `SALD.forwardKlScheduleTimeChangeObligation`, and made
  `SALD.forwardKlDerivativeObligation` depend on them.
- Synced `conversion-windows/ASTIS-SALD-001.md`,
  `proof-obligations/ASTIS-SALD-001.md`, and
  `research-wiki/cited-results/SLT_reuse_audit.md`.

## Reviewer Findings

Reviewer accepted cycle 2.  The source index was refreshed with 24 source
declarations and still excludes `sald_version_2.tex`; `python3 tools/astis.py
check` passed after Lake build, Tests build, and fake-closure scan.

The continuous forward-KL statement in
`SALD.continuousForwardKlStatementContract` matches
`main_body.tex:240-247`, including `alpha in (0, alpha0]`, the two exponential
factors, and the residual alpha-complexity integral.  The proof DAG and
candidate contracts match the appendix split at derivative/Fokker-Planck
(`appendix.tex:168-228`), DV velocity-energy (`appendix.tex:230-241`), and
Gronwall (`appendix.tex:244-252`).

No analytic claim was promoted to `formalized`.  DV remains source-cited,
Gronwall and LSI-to-KL/FI remain obligations, and the derivative, density and
boundary, inverse-schedule, DV-energy, and Gronwall-instantiation blocks remain
named proof obligations.  The SLT audit keeps entropy duality as
source-cited/not ported and does not mark any SLT result as locally built.

Residual reviewer note: the JSON source index currently records theorem-like
LaTeX declarations only.  Equation and proof-block anchors such as `eq:SALD`,
`eq:FP-eq`, `def:alpha-complexity`, and `proof:thm:forward-KL:*` are anchored
in Lean and the conversion window, but not emitted as separate JSON rows by the
current source-index parser.

## Next Cycle Objective

Lower should work on one backend interface only: either
`SALD.forwardKlScheduleTimeChangeObligation` for inverse-schedule calculus, or
`SALD.forwardKlDensityBoundaryObligation` for density, mass conservation,
differentiation-under-the-integral, and integration-by-parts side conditions.
Do not restate `thm:forward-KL`, merge exponent factors, replace DV, or mark
any analytic backend formalized before a compiled Lean declaration exists.
