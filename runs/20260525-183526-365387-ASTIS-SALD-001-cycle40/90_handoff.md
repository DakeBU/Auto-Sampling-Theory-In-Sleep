# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `40`

## Upper Decision

Proof-closure order checked before assignment:

1. `lem:gronwall` has local assembly progress but remains an obligation.
2. `lem:dv_variation` has one-sided local consequences but the source
   Boucheron formula remains source-cited.
3. `eq:LSI-KL-FI` has scalar and finite-coordinate Fisher-chain progress, but
   the full density-test/vector/integral backend remains an obligation.
4. The forward-KL Fokker--Planck/KL derivative slice has source-shaped scalar
   handoffs from cycle 39, but analytic density, boundary, schedule, and KL
   derivative backends remain obligations.
5. This cycle therefore selects the requested EM interpolation
   Fokker--Planck backend for `appendix.tex:260-385`.

Objective: keep `thm:forward-KL-discrete` fixed and use the existing
cycle-35 EM spine for `appendix.tex:260-385`, now narrowing lower work to the
remaining analytic endpoint/conditional-drift interface behind
`sald.discrete_forward_kl.em_endpoint_laws`,
`sald.discrete_forward_kl.conditional_drift_density`, and
`sald.discrete_forward_kl.em_conditional_fokker_planck`.

Mode discipline:

- `faithfulPaper`; use only the original `/home/nitanda_sub/mark/repos/sald/paper`
  source, with `sald_version_2.tex` still excluded.
- Preserve the paper route: frozen EM interpolation, endpoint laws, conditional
  drift `bar b_{k,s}`, conditional-drift Fokker--Planck equation, Laplacian
  split relative to `tilde pi_s`, then KL derivative handoff.
- Keep theorem constants and assumptions unchanged: no change to `Gamma`,
  `Delta`, `barGamma`, `barDelta`, `alpha`, `alpha'`, `eta`, `r`, or the
  step-size condition.
- Keep endpoint laws, disintegration/conditional expectation, density,
  Fokker--Planck, Laplacian split, integration by parts, LSI, DV, and Gronwall
  below formalized status unless an exactly matching compiled local proof is
  added.

Non-goals:

- No source-index rebaseline this cycle; the cycle-39 reviewer found no
  blocking source-anchor defect.
- Do not restate or weaken `thm:forward-KL-discrete`.
- Do not move to the frozen Gamma/Delta defect, DV velocity bound, Gronwall
  accumulation, or accumulated-error bridge before this EM backend has a
  precise theorem interface.
- Do not import or mark an SLT `one_step_discretization` theorem as
  formalized; it remains at most a reference pattern.

Lower packet:

- First target a proof-producing Lean interface, not more ledger text:
  connect the existing endpoint-vector algebra to a law-level endpoint
  interface, or refine the regular conditional-law/measurability/density
  interface for `bar b_{k,s}`.
- If the conditional-drift Fokker--Planck theorem is too large to prove now,
  create a precise source-cited interface depending on
  `sald.discrete_forward_kl.conditional_drift_density` and keep its status
  below formalized.
- Reuse `SALD.discreteForwardKlEmInterpolationLeftEndpointVector`,
  `SALD.discreteForwardKlEmInterpolationRightEndpointVector`,
  `SALD.discreteForwardKlConditionalFpDivergenceDriftSplit`, and
  `SALD.discreteForwardKlConditionalFpLaplacianSplitHandoff` only as local
  algebra under explicit analytic premises.
- Middle must keep the Lean DAG, conversion window, proof obligations, and SLT
  audit synchronized with `appendix.tex:260-385`; defer polished article export
  and broad SDE/SLT migration.

Reviewer checklist:

- `SALD.discreteForwardKlProofDag` and
  `SALD.saldDependenciesForLabel "thm:forward-KL-discrete"` continue to route
  through the cycle-35 EM-FP packet and the endpoint, density, conditional-FP,
  and interpolation obligations.
- Any new theorem is either a compiling local algebra/measure interface under
  explicit hypotheses or a source-cited analytic interface below formalized
  status.
- No source-route drift, theorem-constant drift, hidden smoothness/density
  assumption, SLT status promotion, or fake proof closure appears.
- `python3 tools/astis.py check` passes.

## Middle Formalization State

## Lower Attempts

## Reviewer Findings

## Next Cycle Objective
