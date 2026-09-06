# Handoff

Task id: `ASTIS-SALD-001`
Cycle: `86`

## Upper Decision

Global phase judgment: cycle 85 passed reviewer/build and needs no recovery.
Phase 1 theorem-skeleton translation is stable enough for cited-theory
backfill.  The active packet still targets
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`; the single lower packet that best reduces the current
proof risk is the generator-to-law weak-FP boundary at
`appendix.tex:1379-1387`.

Faithful-paper objective: reduce the supplied generator/time-derivative
hypothesis consumed by
`SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfGeneratorPiecesHandoff`.
Lower should use `AutoSamplingTheory.lawMapIntegral`,
`AutoSamplingTheory.lawMapIntegralHasDerivAtOfSample`, Mathlib
parametric/Bochner integral APIs, and the accepted cycle-85 conditional-field
regularity progress.  The preferred result is a compiled theorem that removes
or strictly narrows the `partialS phi = generatorAction phi` assumption for
admissible weak tests.

Mode discipline: preserve `appendix.tex:1379-1387`, the signs
`-div(hat rho_s*bar b_{k,s})` and `+(sigma_eta^2/2) Delta hat rho_s`, all
source labels/constants, and both discrete theorem statements.  Keep analytic
facts below `formalized` unless a local ASTIS declaration compiles.

Non-goals: no theorem-route audit, display algebra, broad source-index
rebaseline, LSI/DV/Gronwall/frozen-delta work, KL/log-ratio work, SLT import,
Lake dependency change, or project-article export.  A new supplied-hypothesis
wrapper is rejected unless it removes an older generator/time-derivative,
source-action, measurability/integrability hypothesis, or names a strictly
smaller missing theorem.

Lower packet classification required:

- `discharges-supplied-hypothesis`: compiled local theorem removes a supplied
  generator/time-derivative, source-action, parametric-integral, or weak-test
  regularity hypothesis.
- `narrows-source-cited-boundary`: records one exact missing theorem with
  imports and hypotheses, such as sample-path generator differentiation,
  Bochner/parametric integral interchange, or conditional-drift source-action
  identification.
- `rejected-wrapper-churn`: only repackages the cycle-77/cycle-82 assumptions.

Reviewer checklist: verify the packet remains on
`sald.general_moving_target_discrete.em_interpolation_fp` over
`appendix.tex:1358-1387`, narrowed to `1379-1387`; reject source-sign or
coefficient drift; reject hidden weak-FP closure or status promotion; require
the source-index and ASTIS check gates to pass.

## Middle Formalization State

Upper recorded the packet in:

- `AutoSamplingTheory/SALD.lean`:
  `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryUpperPacket`,
  `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryUpperObligation`,
  and `SALD.cycle86GeneralMovingTargetDiscreteWeakFpGeneratorBoundaryDag`.
- `proof-obligations/ASTIS-SALD-001.md`: Cycle 86 proof-DAG table.
- `research-wiki/cited-results/SLT_reuse_audit.md`: cycle 86 no-SLT-import
  audit row.

## Lower Attempts

None by upper.  Lower should not create another supplied-hypothesis wrapper
unless it satisfies the post-84 classification discipline above.

## Reviewer Findings

Pending reviewer pass.

## Next Cycle Objective

Middle should synchronize `appendix.tex:1379-1387` against the cycle-86 Lean
packet, then lower should attempt the generator-to-law weak-FP boundary using
the cycle-79 `Measure.map` derivative helpers before any fallback.
