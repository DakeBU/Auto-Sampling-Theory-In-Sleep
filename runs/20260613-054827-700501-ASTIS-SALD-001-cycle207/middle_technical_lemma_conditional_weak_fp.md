# Cycle 207 Middle Technical-Lemma Packet

Classification: `narrows-source-cited-boundary`.

Packet type: illness-area refiner packet.

Exact boundary narrowed:

```text
sald.general_moving_target_discrete.em_interpolation_fp
  -> emInterpolationConditionalWeakFp
```

This packet is not a new `hRemainderPullbackDef` worker packet.  Cycle 206
already recorded `hRemainderPullbackDef` as the source-contract gap below
`hRemainderGeneratorLimitDef`; repeating that route without a reducible local
definition would be wrapper churn.

## Source-Line Leaf

The active reusable-fact audit is for the conditional-law weak-Fokker--Planck
line:

- `appendix.tex:983-996`: frozen interpolation defining `hat X_s`.
- `appendix.tex:1358-1365`: KL derivative consumer, downstream only.
- `appendix.tex:1368-1377`: frozen conditional drift `bar b_{k,s}`.
- `appendix.tex:1379-1387`: weak-FP source-sign equation for `hat rho_s`.

Lean-facing lower target:

```text
emInterpolationConditionalWeakFp :
  forall phi, Admissible phi ->
    HasDerivAt
      (fun s => integral x, testEval phi x d(hatRhoS s))
      (-(driftDiv phi) + (sigmaEta ^ 2 / 2) * laplacian phi)
      s0
```

## Reusable Fact Classification

Compiled-local technical lemmas:

- `AutoSamplingTheory.TechnicalLemmas.Measure.lawMapIntegral`
- `AutoSamplingTheory.TechnicalLemmas.Measure.lawMapIntegralHasDerivAtOfDominated`
- `AutoSamplingTheory.TechnicalLemmas.Measure.lawIntegralHasDerivAtOfMeasureMapEqAndDominated`
- `AutoSamplingTheory.TechnicalLemmas.Measure.condDistribIntegralNamedLawIntegral`
- `AutoSamplingTheory.TechnicalLemmas.Measure.condDistribIntegralNamedFieldRegularity`

Compiled-local SALD handoffs:

- `SALD.generalMovingTargetDiscreteCondDistribCanonicalDriftRegularity`
- `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfCanonicalAeEq`
- `SALD.generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfDominatedSplitGeneratorHandoff`
- `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorHandoff`
- `SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfIntegralAction`
- `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorBarBActionHandoff`

Source-contract gap:

- `emInterpolationConditionalWeakFp`, if lower_2 cannot instantiate the
  compiled named-law dominated derivative handoff with the source-selected EM
  path derivative, conditional drift source action, and Brownian Laplacian
  source action.

Irrelevant for this packet:

- SLT Gaussian/Taylor/LSI/DV port candidates.  The current weak-FP generator
  theorem is a local analytic/SALD source-action boundary, not a reusable SLT
  concentration or entropy theorem.  No external SLT declaration is imported,
  called, queued, ported, or marked formalized.

## Lower-Ready Packet

`lower_1`: write only the classical route from the frozen interpolation and
conditional drift definition to the weak-FP law derivative.  Do not prove the
KL derivative display and do not reopen `hRemainderPullbackDef`.

`lower_2`: try exactly one non-wrapper compiled theorem by consuming the local
named-law dominated derivative handoff plus the existing conditional-drift and
source-sign handoffs.  If this cannot compile without restating an already
supplied source-action hypothesis, record:

```text
leaf=emInterpolationConditionalWeakFp
error_class=source_contract_gap_missing_conditional_fp_generator_definition
needed_shape=forall phi, Admissible phi -> HasDerivAt (fun s => integral x, testEval phi x d(hatRhoS s)) (-(driftDiv phi) + (sigmaEta^2/2) * laplacian phi) s0
source_lines=appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387;appendix.tex:983-996
blocked_by=need source-selected generator/weak-FP definition connecting the frozen interpolation law to the conditional drift and Brownian Laplacian after already compiled law-map, condDistrib, and retired path/domination leaves
```

Reject: source-Hessian replay, selected-line Taylor replay, endpoint/naming
replay, retired barB wrapper reassignment, direct SLT dependency, broad
source-index work, project-article export, fake closure, and theorem-status
promotion.
