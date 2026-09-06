# Cycle 207 Middle Source-Correspondence Packet

Classification: `narrows-source-cited-boundary`.

Packet type: illness-area refiner packet.

Exact boundary narrowed:

```text
sald.general_moving_target_discrete.em_interpolation_fp
  -> emInterpolationConditionalWeakFp
```

This is not a new dynamic `hRemainderPullbackDef` worker packet.  Cycle 206
already accepted `hRemainderPullbackDef` as the exact source-contract gap below
`hRemainderGeneratorLimitDef`.

## Source Window

Source root: `/home/nitanda_sub/mark/repos/sald/paper`, excluding
`sald_version_2.tex`.

| Source lines | Paper object | Lean-facing object |
|---|---|---|
| `appendix.tex:1358-1365` | first KL derivative display; consumer of the weak-FP identity | `sald.general_moving_target_discrete.kl_derivative`, not part of the lower theorem for this packet |
| `appendix.tex:1368-1377` | frozen conditional drift field `bar b_{k,s}` | canonical/named conditional drift interfaces, especially `SALD.generalMovingTargetDiscreteCondDistribCanonicalDriftRegularity` and `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfCanonicalAeEq` |
| `appendix.tex:1379-1387` | Fokker--Planck equation for `hat rho_s` associated with the frozen interpolation | `emInterpolationConditionalWeakFp`: source-sign weak action for the conditional EM law |
| `appendix.tex:983-996` | frozen interpolation defining the EM path whose law is `hat rho_s` | law-map/named-law path input for weak derivative transport |

Lean-facing target shape for lower work:

```lean
emInterpolationConditionalWeakFp :
  forall phi, Admissible phi ->
    HasDerivAt
      (fun s => integral x, testEval phi x d(hatRhoS s))
      (-(driftDiv phi) + (sigmaEta ^ 2 / 2) * laplacian phi)
      s0
```

Equivalent source-sign formulations are acceptable only if they keep the same
paper object: the derivative of weak tests against the conditional EM law
equals the drift divergence contribution plus the Brownian Laplacian
contribution from `appendix.tex:1379-1387`.

## Local ASTIS/Mathlib Status

Callable compiled-local background:

- `AutoSamplingTheory.condDistribIntegralNamedLawIntegral`
- `AutoSamplingTheory.condDistribIntegralNamedFieldRegularity`
- `AutoSamplingTheory.lawMapIntegralHasDerivAtOfDominated`
- `AutoSamplingTheory.lawIntegralHasDerivAtOfMeasureMapEqAndDominated`
- `SALD.generalMovingTargetDiscreteCondDistribCanonicalDriftRegularity`
- `SALD.generalMovingTargetDiscreteCondDistribNamedDriftRegularityOfCanonicalAeEq`
- `SALD.generalMovingTargetDiscreteWeakConditionalFpNamedLawDerivativeOfDominatedSplitGeneratorHandoff`
- `SALD.generalMovingTargetDiscreteWeakConditionalFpSourceSignsOfSampleSplitGeneratorHandoff`

These declarations cover conditional-integral transport, named-law law-map
derivative transport, and existing weak-FP source-sign handoff structure.  No
external SLT theorem is callable, imported, queued, or needed for this packet.

Retired or out-of-scope leaves:

- Do not reassign `hRemainderPullbackDef`; cycle 206 already recorded it as a
  source-contract gap.
- Do not reassign `hsampleInt`, `hsampleDerivMeas`, `hsampleDerivBound`,
  `hboundInt`, `hpathDeriv`, `hderivValue`, `hdriftBarBAction`, raw
  `hpairMeas`, or `hcanonicalBarBMeas`; these are retired/discharged in the
  earlier weak-FP chain.
- Do not reopen `hSourceHasHessian` or `hSourceHessianBound`; they remain
  source-contract gaps and are not active proof targets.

## Lower-Ready Assignment

`lower_1`: write exactly the classical route for `emInterpolationConditionalWeakFp`.
Start from the frozen interpolation law `hat rho_s = Law(hat X_s)`, the
conditional drift definition in `appendix.tex:1368-1377`, and the weak-test
Fokker--Planck identity in `appendix.tex:1379-1387`.  Do not prove the KL
derivative display; only state how the weak-FP line supplies its first term.

`lower_2`: implement one compiled ASTIS-owned theorem if the existing local
interfaces suffice, preferably by consuming the named-law dominated derivative
handoff and the canonical conditional-drift/source-action interfaces.  If no
non-wrapper theorem can be compiled, record this strictly smaller source-cited
obligation:

```text
leaf=emInterpolationConditionalWeakFp
error_class=source_contract_gap_missing_conditional_fp_generator_definition
needed_shape=forall phi, Admissible phi -> HasDerivAt (fun s => integral x, testEval phi x d(hatRhoS s)) (-(driftDiv phi) + (sigmaEta^2/2) * laplacian phi) s0
source_lines=appendix.tex:1358-1365;appendix.tex:1368-1377;appendix.tex:1379-1387;appendix.tex:983-996
blocked_by=need source-selected generator/weak-FP definition connecting the frozen interpolation law to the conditional drift and Brownian Laplacian after already compiled law-map, condDistrib, and retired path/domination leaves
```

Reviewer checklist: run `python3 tools/astis.py check`; verify the packet is
strictly smaller than the whole `sald.general_moving_target_discrete.em_interpolation_fp`
backend; reject source-Hessian replay, selected-line Taylor replay, endpoint or
naming replay, direct SLT dependency, theorem-status promotion, and consumer
wrapper churn.
