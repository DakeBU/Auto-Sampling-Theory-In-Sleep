# Cycle 207 Middle Formalizer Handoff

Classification: `narrows-source-cited-boundary`.

Packet type: illness-area refiner packet.

Exact boundary narrowed:

```text
sald.general_moving_target_discrete.em_interpolation_fp
  -> emInterpolationConditionalWeakFp
```

This handoff retires a repeat `hRemainderPullbackDef` assignment for this
cycle.  Cycle 206 already recorded `hRemainderPullbackDef` as the exact
source-contract gap below `hRemainderGeneratorLimitDef`; another same-shape
consumer or wrapper would be churn unless lower_2 first finds a reducible local
definition of `remainderGeneratorLimit`, `normalizedRemainder`, and
`scalarBrownianCoordinate`.

## Source Window

Source root: `/home/nitanda_sub/mark/repos/sald/paper`, excluding
`sald_version_2.tex`.

| Source lines | Paper step | Lean-facing role |
|---|---|---|
| `appendix.tex:983-996` | frozen EM interpolation `\hat X_s` | named-law path `hatRhoS s = Measure.map (hatX s) P` |
| `appendix.tex:1358-1365` | first KL derivative display | downstream consumer only |
| `appendix.tex:1368-1377` | frozen conditional drift `\bar b_{k,s}` | conditional-drift representative and regularity support |
| `appendix.tex:1379-1387` | weak Fokker--Planck equation for `\hat\rho_s` | active lower boundary `emInterpolationConditionalWeakFp` |

Lower-facing target shape:

```lean
emInterpolationConditionalWeakFp :
  forall phi, Admissible phi ->
    HasDerivAt
      (fun s => integral x, testEval phi x d(hatRhoS s))
      (-(driftDiv phi) + (sigmaEta ^ 2 / 2) * laplacian phi)
      s0
```

Equivalent source-sign formulations are acceptable only if they keep this same
paper object: the weak-test derivative of the conditional EM law with drift
contribution from `\bar b_{k,s}` and Brownian contribution
`(\sigma_\eta^2 / 2)\Delta`.

## Callable Local Interfaces

Use only compiled local ASTIS/Mathlib-backed declarations:

- `AutoSamplingTheory.lawMapIntegralHasDerivAtOfDominated`
- `AutoSamplingTheory.lawIntegralHasDerivAtOfMeasureMapEqAndDominated`
- `AutoSamplingTheory.condDistribIntegralNamedLawIntegral`
- `AutoSamplingTheory.condDistribIntegralNamedFieldRegularity`
- `SALD.generalMovingTargetDiscreteCondDistribCanonicalDriftRegularity`
- `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfCanonicalAeEq`
- `SALD.generalMovingTargetDiscreteCondDistribComponentWeakPairingOfIntegralAction`
- `SALD.generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfDominatedSplitGeneratorHandoff`
- `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorHandoff`
- `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorBarBActionHandoff`

No external SLT theorem is imported, called, queued, or needed for this packet.

## Lower Packets

`lower_1`: write exactly the classical route for
`emInterpolationConditionalWeakFp`.  Start from the frozen interpolation law,
use the paper conditional drift definition in `appendix.tex:1368-1377`, and
derive the weak-test Fokker--Planck source-sign identity in
`appendix.tex:1379-1387`.  Mention the KL derivative display only as a
downstream consumer.

`lower_2`: try exactly one non-wrapper compiled theorem by consuming the local
named-law dominated derivative handoff together with the existing conditional
drift and source-sign handoffs.  Do not reassign retired leaves
`hsampleInt`, `hsampleDerivMeas`, `hsampleDerivBound`, `hboundInt`,
`hpathDeriv`, `hderivValue`, `hdriftBarBAction`, raw `hpairMeas`, or
`hcanonicalBarBMeas`.

If no non-wrapper theorem can compile, record the strictly smaller
source-cited obligation:

```text
leaf=emInterpolationConditionalWeakFp
error_class=source_contract_gap_missing_conditional_fp_generator_definition
needed_shape=forall phi, Admissible phi -> HasDerivAt (fun s => integral x, testEval phi x d(hatRhoS s)) (-(driftDiv phi) + (sigmaEta^2/2) * laplacian phi) s0
source_lines=appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387;appendix.tex:983-996
blocked_by=need source-selected generator/weak-FP definition connecting the frozen interpolation law to the conditional drift and Brownian Laplacian after already compiled law-map, condDistrib, and retired path/domination leaves
```

`lower_3`: no separate technical-lemma/API scout is needed unless lower_2 finds
a precise missing Mathlib name while instantiating the local handoff.  Broad SLT
or SDE-library search is out of scope.

Reject source-Hessian replay, selected-line Taylor replay, endpoint/naming
replay, discharged barB wrapper reassignment, direct SLT dependency, broad
source-index work, project-article export, fake closure, and theorem-status
promotion.
