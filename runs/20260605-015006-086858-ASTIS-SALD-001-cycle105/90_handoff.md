# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `105`

## Upper Decision

Global phase judgment: cycle 104 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for single-backend
cited-theory backfill. The active lower packet remains
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; for cycle 105 the single packet that most reduces
proof risk is the KL/log-ratio no-mass raw derivative boundary at
`appendix.tex:1358-1366`.

Classification: `narrows-source-cited-boundary`.

Selected faithful-paper objective: keep
`thm:general-moving-target-SALD-discrete` and the local theorem statements
unchanged, and narrow the cycle-99 KL/log-ratio package to the exact no-mass
finite-KL `llr` differentiability theorem:
`SALD.GeneralMovingTargetDiscreteRawKlDerivativeNoMassAtFiniteKlLlr`.

Exact boundary narrowed: the old broad raw-KL hypothesis/package is not the
target. Lower should isolate or prove the no-mass display
`dK = partialS (MeasureTheory.llr hatRho tildePi) - targetTimeTerm` from
finite-KL `llr` regularity, endpoint-safe KL integral differentiation, and the
target-time integrability/formula. The mapped-law constant-test derivative is
already handled locally by
`SALD.generalMovingTargetDiscreteKlDerivativeWeakFpHandoffOfNoMassRawKlBoundaryAtFiniteKlLlrWithLogAction`;
cycle-88 admissibility closure and downstream weak-FP/IBP/FI remain separate.

Mode discipline: faithfulPaper only. Use the original source
`/home/nitanda_sub/mark/repos/sald/paper/appendix.tex:1358-1366`; do not use
`sald_version_2.tex`, alter signs/constants, or promote theorem status.

Non-goals: no broad theorem-route audit, no source-index rebaseline, no
general wrapper around `hklRaw`, no LSI/DV/Gronwall fallback, no SLT import or
Lake dependency change.

Local references: existing Lean declarations in `AutoSamplingTheory/SALD.lean`
for cycles 87, 88, 93, and 99; Mathlib
`InformationTheory.KullbackLeibler.Basic`,
`MeasureTheory.Measure.LogLikelihoodRatio`,
`Analysis.Calculus.ParametricIntegral`, and Bochner integral APIs. No new SLT
consultation is required unless lower needs proof-engineering style; if used,
SLT must remain a local reference only.

## Middle Formalization State

Middle should keep the conversion window/proof-DAG synchronized with the
already recorded cycle-99 table. The active row is the no-mass source-cited
package:
`ASTIS.SALD.cycle99.no_mass_raw_kl_derivative_at_finite_kl_llr`, source
`appendix.tex:1358-1366`, status `sourceCited`/obligation until a local
compiled theorem proves the package fields.

## Lower Attempts

Assign lower exactly one of these outcomes:

1. `discharges-supplied-hypothesis`: compile a local theorem proving the
   no-mass raw-KL package fields or removing one field from
   `SALD.GeneralMovingTargetDiscreteRawKlDerivativeNoMassAtFiniteKlLlr`.
2. `narrows-source-cited-boundary`: if full KL differentiability is too large,
   produce a smaller source-cited theorem with explicit imports/hypotheses,
   preferably separating endpoint-safe KL differentiation from the target-time
   derivative formula.
3. `rejected-wrapper-churn`: explicitly reject any proposal that only
   restates `hklRaw`, `hlog`, or the already compiled finite-KL/mass handoff.

## Reviewer Findings

Reviewer should reject hidden KL differentiability closure, any theorem-status
promotion, any dependence on `sald_version_2.tex`, any SLT/Lake import, and any
new wrapper that does not discharge or strictly narrow an existing supplied
hypothesis. Verify that the packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`.

## Next Cycle Objective

If lower cannot compile the no-mass package, continue with the smallest
named sub-boundary of
`SALD.GeneralMovingTargetDiscreteRawKlDerivativeNoMassAtFiniteKlLlr`:
endpoint-safe KL differentiation at `MeasureTheory.llr hatRho tildePi` or the
target-time derivative integrability/formula, but not both in a broad packet.
