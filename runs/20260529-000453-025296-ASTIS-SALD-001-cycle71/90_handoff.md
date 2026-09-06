# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `71`

## Upper Decision

Global phase judgment: cycle 70 completed its conditional-law/measurability
backfill and needs no recovery before new work.  Phase 1 theorem-skeleton
translation is stable enough for cited-theory backfill, so this cycle stays in
the single shared EM backend instead of reopening theorem-route audits.  The
single lower packet with the largest remaining proof-risk reduction is
endpoint-law-to-conditional-law compatibility for
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`: connect the existing `Measure.map` endpoint/common
space bookkeeping to the conditional-law interface consumed by the weak
Fokker--Planck statement.

Active-packet check: the target remains exactly
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`.  Endpoint laws from `appendix.tex:1354-1357` and the
cycle-63 `Measure.map` helpers are inputs only; the lower packet must feed the
conditional-law/disintegration compatibility needed for the source drift line
`appendix.tex:1368-1377` and the weak FP line `appendix.tex:1379-1387`.

Faithful objective: backfill only the original paper's endpoint-to-conditional
compatibility layer for the frozen EM interpolation.  Middle/lower should make
explicit how the joint law of `(X_k^eta, hat X_s)` and its `hat X_s` marginal
match the `hat rho_s = Law(hat X_s)` interface already named in
`SALD.generalMovingTargetDiscreteConditionalLawMeasurabilityContract`, while
keeping regular conditional kernels, density/absolute-continuity, and the weak
Fokker--Planck theorem as obligations unless locally proved.

Mode discipline and non-goals: this remains `faithfulPaper`.  Do not change
theorem statements, constants, source labels, source-file scope, theorem
status, Lake dependencies, or SLT status.  Do not assign display algebra,
Gronwall/DV/LSI work, broad reusable APIs, source-index rebaseline, or a broad
theorem-route audit.  If a measure/disintegration theorem is too large, record
one precise source-cited interface below `formalized`.

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| EM endpoint-to-conditional compatibility | Joint `Measure.map` law and `hat X_s` marginal agree with the conditional kernel marginal used to define `bar b_{k,s}` | cycle-63 joint/marginal endpoint helpers; cycle-70 conditional-law contract | lower should add or refine one narrow handoff around `SALD.generalMovingTargetDiscreteConditionalLawMeasurabilityContract` | `appendix.tex:1358-1387`, especially `1368-1377` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete` | obligation, with only local equality wrappers eligible for `formalized` |

## Middle Formalization State

Middle should keep Lean/Markdown/LaTeX synchronization two-way but avoid broad
ledger expansion.  Translate the endpoint-to-conditional step into lower-ready
Lean-facing declarations by inspecting the current helpers:
`SALD.generalMovingTargetDiscreteEmJointEndpointMeasureMapOfNamedInterpolation`,
`SALD.generalMovingTargetDiscreteEmJointEndpointMarginalLawsOfNamedInterpolation`,
`SALD.generalMovingTargetDiscreteConditionalLawMeasurabilityContract`,
`SALD.generalMovingTargetDiscreteConditionalDriftContract`, and
`SALD.generalMovingTargetDiscreteNamedConditionalDriftRegularityOfComponents`.

The intended interface is narrow: a common probability space carries
`X_k^eta` and `hat X_s`; the joint pushforward law has `hat X_s` as its second
marginal; `hat rho_s` is the same marginal law; any supplied conditional
kernel/disintegration must be compatible with that joint law and marginal
before `bar b_{k,s}` is used in the weak FP equation.  This is compatibility
bookkeeping, not a proof of regular conditional probability existence.

## Lower Attempts

Assigned lower packet: endpoint-law-to-conditional-law compatibility for the
same EM backend.  Attempt one proof-producing Lean refinement before adding
ledger-only text.  Preferred shape: under explicit hypotheses giving the joint
law and marginal equality, prove a small wrapper that transports a supplied
conditional-kernel compatibility predicate from the `Measure.map` marginal to
the named `hat rho_s` marginal used by
`SALD.generalMovingTargetDiscreteConditionalLawMeasurabilityContract`.

Acceptable fallback: if Mathlib/disintegration infrastructure blocks the
proof, add one narrowly cited obligation stating exactly that the regular
conditional kernel for `X_k^eta` given `hat X_s` must disintegrate the joint law
with `hat rho_s` as its second marginal.  Keep the status below `formalized`
and do not claim the weak FP identity, density/AC, KL derivative, or theorem
closure.

## Reviewer Findings

Reviewer should check that all work still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387` and that endpoint-law `Measure.map` helpers are used
only as common-space/marginal bookkeeping.  Reject any hidden theorem
assumption, theorem-status promotion, new SLT/Lake dependency, source-label
change, or claim that regular conditional laws, density/AC, weak FP, KL
differentiation, LSI/KL/FI, DV, or Gronwall have been formalized.  Require
`python3 tools/astis.py source-index ASTIS-SALD-001` and
`python3 tools/astis.py check` to pass.

## Next Cycle Objective

If this packet is accepted, continue the same backend with the weak
conditional Fokker--Planck interface itself: state the source-signed weak-test
form that supplies the hypothesis consumed by the existing cycle-69 and
cycle-54 algebra wrappers, still below theorem-level formalization unless the
analytic theorem is locally compiled.
