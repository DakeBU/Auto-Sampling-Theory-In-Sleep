# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `97`

## Upper Decision

Global phase judgment: cycle 96 passed reviewer/build and needs no recovery;
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill; the single lower packet that best reduces proof risk remains
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to the canonical `condDistrib`/`condexp`
component generator identity behind `appendix.tex:1368-1377`.

Faithful-paper objective: discharge or strictly narrow the remaining
`hcanonical`-style premise consumed by
`SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfAeVersion`.
The lower target is one component only, `condC` or `condScore`: prove the weak
test-gradient pairing for the canonical conditional-integral field
`fun x => integral ... (condDistrib Xk hatXAtS P x)`, or record one exact
missing Mathlib theorem with imports and hypotheses.

Mode discipline: keep the source theorem fixed, preserve the paper constants
and signs in `appendix.tex:1368-1377`, and keep status below `formalized`
unless the local ASTIS declaration compiles.  SLT may be used only as a style
reference; do not add a Lake dependency or cite an SLT theorem as local fact.

Non-goals: no new wrappers around existing supplied hypotheses, no broad
theorem-route audit, no LSI/DV/Gronwall fallback, no display algebra, and no
divergence/no-boundary work unless the canonical conditional-integral theorem
is blocked by a named Mathlib/theory gap.

## Middle Formalization State

Middle should keep the conversion window, proof obligations, and Lean
dependency names synchronized with the cycle-96 DAG entries:
`SALD.cycle96GeneralMovingTargetDiscreteCondexpGeneratorPairingMiddleObligation`,
`SALD.cycle96GeneralMovingTargetDiscreteCondexpGeneratorPairingLowerObligation`,
and `SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfAeVersion`.
No source-index rebaseline is requested unless a blocking source-anchor defect
is found.

## Lower Attempts

Lower packet classification:

- `discharges-supplied-hypothesis` if one component generator-pairing premise
  is proved and removed from the downstream `barB` route.
- `narrows-source-cited-boundary` if the attempt records a smaller missing
  Mathlib/local theorem, with imports, variables, measurability/integrability
  hypotheses, named `hatRhoS = P.map hatXAtS`, and the exact weak-pairing
  conclusion.
- `rejected-wrapper-churn` for another a.e.-version handoff, another wrapper
  around `hcanonical`, or a theorem that merely repackages the cycle-95
  `barB` component assumptions.

## Reviewer Findings

Reviewer checklist:

- Reject fake closures: no `axiom`, `sorry`, `admit`, `Prop := True`, or
  `:= trivial` for math.
- Verify the packet still targets
  `sald.general_moving_target_discrete.em_interpolation_fp` over
  `appendix.tex:1358-1387`, with the active source lines
  `appendix.tex:1368-1377`.
- Accept only a compiled local proof of the canonical conditional-integral
  generator identity or a strictly smaller named missing theorem.
- Check no theorem/backend status promotion, source-label drift, sign/constant
  change, SLT import claim, or Lake dependency change.

## Next Cycle Objective

Send middle/lower at the canonical `condDistrib`/`condexp` component generator
pairing: turn Mathlib conditional kernel/conditional expectation orientation
for `X_k^eta | hat X_s` and `hatRhoS = Law(hat X_s)` into one weak
test-gradient component action consumed by the cycle-95 `barB` component
theorem.
