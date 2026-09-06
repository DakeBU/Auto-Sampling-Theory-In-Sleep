# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `72`

## Upper Decision

Global phase judgment: cycle 71 passed reviewer/build and needs no recovery
before new work.  Phase 1 theorem-skeleton translation remains stable enough
for cited-theory backfill, so cycle 72 stays on the single shared EM
conditional-law/Fokker--Planck backend rather than reopening theorem-route
audits.  The single lower packet that now reduces the largest remaining proof
risk is the weak conditional Fokker--Planck source-sign statement for
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to `appendix.tex:1379-1387`: expose the
weak-test identity with drift contribution `-div(hat rho_s bar b_{k,s})` and
diffusion contribution `+(sigma_eta^2/2) Delta hat rho_s` under explicit
conditional-law, density, regularity, and test-function hypotheses.

Active-packet check: the target remains exactly
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`.  Cycle 70 supplied only named conditional-law and
conditional-drift regularity wrappers; cycle 71 supplied only endpoint-law to
conditional-kernel marginal compatibility.  Those are inputs to this packet,
not a reason to move to KL derivative handoff, theorem-route audit, display
algebra, Gronwall, DV, LSI, or source-index rebaseline.

Faithful objective: backfill only the source statement immediately after the
paper defines
`\bar b_{k,s}(x)=E[dot t_k c_{t_k}(X_k^eta)+(sigma_eta^2/2) nabla log pi_{t_k}(X_k^eta)|hat X_s=x]`.
The middle/lower handoff should make the weak FP claim precise in Lean-facing
terms before the later Laplacian split:
`partial_s hat rho_s = -div(hat rho_s bar b_{k,s}) + (sigma_eta^2/2) Delta hat rho_s`.
If the full analytic theorem is too large, keep it as a source-cited
obligation below `formalized`, but do not weaken the signs, remove the
`sigma_eta^2/2` coefficient, or replace the conditional drift by a free drift.

Mode discipline and non-goals: this remains `faithfulPaper`.  Do not change
theorem statements, constants, source labels, source-file scope, theorem
status, Lake dependencies, or SLT status.  Do not claim a regular conditional
law, disintegration theorem, density/absolute-continuity, weak FP theorem, KL
differentiation, integration by parts, LSI/KL/FI, DV, Gronwall, or downstream
theorem closure is formalized unless it compiles locally.  Do not assign
unrelated lower work while this backend remains open.

| Block | Interface | Dependencies | Lean declaration | Source anchor | Reused by | Status |
|---|---|---|---|---|---|---|
| Weak conditional FP source signs | State the weak-test Fokker--Planck identity whose distributional right side is `-div(hat rho_s bar b_{k,s}) + (sigma_eta^2/2) Delta hat rho_s`; keep drift sign negative and diffusion sign positive. | cycle-70 conditional-law/measurability contract; cycle-71 endpoint-to-conditional compatibility; cycle-69 source-sign coefficient wrapper; cycle-54 Laplacian regrouping wrapper | middle/lower should add or refine one narrow interface around `SALD.generalMovingTargetDiscreteConditionalFpSourceSignsHandoff` and `sald.general_moving_target_discrete.em_interpolation_fp`, e.g. `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignContract` if no existing declaration fits | `appendix.tex:1379-1387` within `appendix.tex:1358-1387` | `thm:forward-KL-discrete`; `thm:general-moving-target-SALD-discrete`; later KL-derivative handoff | obligation; only equality/sign packaging may become formalized |

## Middle Formalization State

Middle should keep the two-way Lean/Markdown/LaTeX synchronization narrow.
Inspect the existing declarations before adding a duplicate interface:
`SALD.generalMovingTargetDiscreteConditionalFpSourceSignsHandoff`,
`SALD.cycle69GeneralMovingTargetDiscreteEmFpSourceSignsLowerObligation`,
`SALD.generalMovingTargetDiscreteConditionalLawMeasurabilityContract`,
`SALD.generalMovingTargetDiscreteEndpointConditionalCompatibilityContract`,
`SALD.generalMovingTargetDiscreteEndpointConditionalCompatibilityOfJointMap`,
`SALD.generalMovingTargetDiscreteDerivativeSideConditionContract`, and
`sald.general_moving_target_discrete.em_interpolation_fp`.

The desired translation is a weak-test statement, not just the pointwise
display already recorded by cycle 69.  It should list the state space, test
class, time regularity of `s |-> int phi d hat rho_s`, integrability of
`bar b_{k,s}` against `hat rho_s`, density/AC requirements needed to mention
`Delta hat rho_s`, and the exact source coefficient
`sigma_eta^2/2`.  Middle should record any missing Mathlib theorem as a
single source-cited analytic obligation, not as a theorem assumption.

## Lower Attempts

Assigned lower packet: weak conditional Fokker--Planck source-sign statement
for the same EM backend.  Attempt one proof-producing Lean refinement before
adding ledger-only text.  Preferred shape: under explicit hypotheses giving a
weak-test FP identity for all admissible test functions and the coefficient
identity `sigmaCoeff = sigma_eta^2/2`, prove a small wrapper that feeds the
existing cycle-69 source-sign handoff while preserving the negative drift
divergence and positive diffusion Laplacian signs.

Acceptable fallback: if Mathlib distributional derivative, weak divergence,
or conditional-drift regularity infrastructure blocks proof work, add one
narrow obligation stating exactly the missing theorem: the EM interpolation law
with frozen conditional drift `bar b_{k,s}` satisfies the weak Fokker--Planck
identity against admissible tests with drift term `-div(hat rho_s bar b_{k,s})`
and diffusion term `+(sigma_eta^2/2) Delta hat rho_s`.  Keep it below
`formalized`.

## Reviewer Findings

Reviewer should check that all work still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, specifically the weak FP line
`appendix.tex:1379-1387`.  Reject any change that treats the cycle-70/71
wrappers as proving disintegration or regular conditional expectations, any
sign flip, any missing `sigma_eta^2/2` coefficient, any theorem-status
promotion, any SLT/Lake import, or any theorem-route/display detour.  Require
`python3 tools/astis.py source-index ASTIS-SALD-001` and
`python3 tools/astis.py check` to pass.

## Next Cycle Objective

If this packet is accepted, continue within the same backend with the
KL-derivative handoff from the weak FP identity: differentiate
`KL(hat rho_s || tilde pi_s)`, insert the weak FP identity, then pass only to
the source Laplacian split and integration-by-parts obligations needed before
the frozen/residual derivative side conditions.
