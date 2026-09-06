# Cycle 190 Middle Packet: Selected-Increment Endpoint Bridge

Classification: `narrows-source-cited-boundary`.

Packet type: middle dynamic-leaf worker packet.

Exact boundary narrowed:

```lean
hSelectedIncrementCoordinateLineDef
```

Compiled local declarations:

```lean
SALD.selectedWeakTestSelectedIncrementCoordinateLineDefOfEndpointAndLineDef
SALD.selectedWeakTestSourceTaylorIntegrandRawDefOfSelectedIncrementEndpointAndLineDef
```

The old selected-increment coordinate-line field is reduced to:

```lean
hSelectedIncrementEndpointDef
hSelectedEndpointCoordinateLineDef
```

Source anchors: `appendix.tex:958-970`, `appendix.tex:983-996`,
`appendix.tex:1161-1170`, and `appendix.tex:1379-1387`.

Local dependencies used: existing SALD declarations and Mathlib
`stdOrthonormalBasis`/scalar-line notation already available in
`AutoSamplingTheory/SALD.lean`.

No external SLT theorem was consulted, imported, ported, called, queued, or
marked formalized.  No source-Hessian re-audit, VP score-Hessian substitution,
wrapper churn, `sald_version_2.tex`, or `sigma_eta^2/2` event-field move was
used.

Remaining exact Brownian/Ito backend:

```lean
hBrownianCoordinateGeneratorSourceIntegralDef
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
