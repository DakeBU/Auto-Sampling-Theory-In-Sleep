# Cycle 191 Middle Packet: Source-Integral Scalar Pushforward

Classification: `discharges-supplied-hypothesis`.

Packet type: dynamic-leaf worker packet for the Brownian/Ito frozen backend.

Exact supplied hypothesis discharged:

```lean
hBrownianCoordinateGeneratorNormalizedLawDef
```

Target route:

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfScalarPushforwardAndStdGaussianVectorLaw
```

This route removes `hBrownianCoordinateGeneratorNormalizedLawDef` as a primitive
field inside `hBrownianCoordinateGeneratorSourceIntegralDef`.  It composes the
already compiled scalar-pushforward bridge

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward
```

with the already compiled standard-Gaussian coordinate-law bridge

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw
```

The resulting source-integral field depends on:

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hSourceTaylorIntegrandMeas
hGeneratorPullbackDef
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
```

Source anchors: `appendix.tex:958-970`, `appendix.tex:983-996`,
`appendix.tex:1161-1170`, and `appendix.tex:1379-1387`.

The weak-Fokker--Planck diffusion coefficient `sigma_eta^2/2` remains outside
this scalar coordinate-law leaf.  `hSourceHasHessian` and
`hSourceHessianBound` remain documented source-contract gaps, not active
proof targets.

Local facts used: the existing SALD scalar pushforward bridge, existing SALD
Gaussian coordinate-law bridge, and Mathlib Gaussian/map/stdOrthonormalBasis
infrastructure already imported by `AutoSamplingTheory/SALD.lean`.  No external
SLT file was imported, called, queued, or marked formalized.

Remaining exact Brownian/Ito backend after this packet:

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hSourceTaylorIntegrandMeas
hGeneratorPullbackDef
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
hSourceTaylorIntegrandSelectedIncrementDef
hSelectedIncrementEndpointDef
hSelectedEndpointCoordinateLineDef
hSelectedLineTaylorRawSplitDef
hSourceLinearTermTaylorDef
hScalarLineFirstCoeffDef
hSourceQuadraticTermTaylorDef
hScalarLineTaylorCoeffDef
hRemainderGeneratorLimitDef
hRemainderMeas
hRemainderBound
hRemainderBoundInt
```
