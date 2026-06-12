# Cycle 193 Middle Packet: Taylor Moment Scalar-Pushforward/Remainder Discharge

Classification: `discharges-supplied-hypothesis`.

Packet type: dynamic-leaf worker packet for the Brownian/Ito frozen backend
under `sald.general_moving_target_discrete.em_interpolation_fp`.

Exact supplied hypotheses discharged inside the Taylor moment decomposition
consumer:

```lean
hBrownianCoordinateGeneratorTaylorIntegralDef
hRemainderGeneratorLimitDef
```

Compiled declaration:

```lean
SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfScalarPushforwardRawTaylorAndDominatedRemainder
```

Proof route: derive `hBrownianCoordinateGeneratorTaylorIntegralDef` from the
cycle-192 scalar-pushforward/raw selected-line Taylor bridge, derive
`hRemainderGeneratorLimitDef` from the cycle-190 scalar-pushforward
normalized-remainder bridge, then feed both derived fields into the existing
dominated-remainder Taylor moment split.

Local declarations used:

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs
SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw
SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder
SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward
SALD.selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw
```

Source anchors: `appendix.tex:958-970`, `appendix.tex:983-996`,
`appendix.tex:1161-1170`, and `appendix.tex:1379-1387`.

Remaining exact backend:

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hSourceTaylorIntegrandMeas
hGeneratorPullbackDef
hNormalizedRemainderMeas
hRemainderPullbackDef
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
hSourceTaylorIntegrandRawDef
hSelectedLineTaylorRawSplitDef
hSourceLinearTermTaylorDef
hScalarLineFirstCoeffDef
hSourceQuadraticTermTaylorDef
hScalarLineTaylorCoeffDef
hRemainderMeas
hRemainderBound
hRemainderBoundInt
```

`hSourceHasHessian` and `hSourceHessianBound` remain documented
source-contract gaps.  No external SLT theorem was consulted, imported,
ported, called, queued, or marked formalized.  The weak-FP
`sigma_eta^2/2` coefficient stays outside the scalar Brownian event-field
identity, and `sald_version_2.tex` was not used.

