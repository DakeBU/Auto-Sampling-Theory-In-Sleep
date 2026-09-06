# Cycle 189 Coordinate Taylor Integral Raw-Term Route

Classification: `narrows-source-cited-boundary`.

Packet type: middle dynamic-leaf worker packet.

Exact boundary narrowed:

```lean
hBrownianCoordinateGeneratorTaylorIntegralDef
```

is reduced to the smaller source-cited package:

```lean
hBrownianCoordinateGeneratorSourceIntegralDef
hSourceTaylorIntegrandRawDef
hSelectedLineTaylorRawSplitDef
hSourceLinearTermTaylorDef
hScalarLineFirstCoeffDef
hSourceQuadraticTermTaylorDef
hScalarLineTaylorCoeffDef
```

Compiled declaration:

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralRawTaylorAndTermDefs
```

Classical route: `appendix.tex:984-995` defines the frozen EM Brownian
interpolation.  After the normalized coordinate convention from
`appendix.tex:958-970` and `appendix.tex:1170-1176`, the scalar Brownian
coordinate is `z`.  The source integral definition expresses
`brownianCoordinateGenerator` as the Gaussian integral of
`sourceTaylorIntegrand`.  The raw integrand field identifies that source
integrand with the selected weak-test increment along
`x + z • e_i`; the raw selected-line Taylor split expands that increment into
the first Taylor term, the order-two Taylor coefficient term, and
`normalizedRemainder`; the source linear/quadratic term fields plus coefficient
conventions rewrite those two Taylor terms to `linearCoeff * z` and
`quadraticCoeff * z ^ 2`.

Lean route: compose the already compiled bridges
`SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralAndAE`,
`SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegrandAEOfPointwise`,
`SALD.selectedWeakTestSourceTaylorIntegrandPointwiseOfLineTermDefs`,
`SALD.selectedWeakTestSourceTaylorIntegrandDefOfRawAndLineTaylorSplit`,
`SALD.selectedWeakTestSelectedLineTaylorSplitDefOfRawTaylorAndTermDefs`,
`SALD.selectedWeakTestSourceLinearTermDefOfScalarLineFirstCoeffDef`, and
`SALD.selectedWeakTestSourceQuadraticTermDefOfScalarLineTaylorCoeffDef`.

Remaining exact backend:

```lean
hBrownianCoordinateGeneratorSourceIntegralDef
hSourceTaylorIntegrandRawDef
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

`hSourceHasHessian` and `hSourceHessianBound` remain source-contract gaps.
No external SLT theorem was imported, called, ported, or marked formalized.
The weak-FP `sigma_eta^2/2` factor remains outside this Brownian event-field
identity at `appendix.tex:1379-1387`.
