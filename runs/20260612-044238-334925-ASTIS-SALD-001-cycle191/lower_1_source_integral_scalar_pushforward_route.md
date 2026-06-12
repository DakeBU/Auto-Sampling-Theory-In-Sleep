# Cycle 191 Lower_1 Route: Source-Integral Scalar Pushforward

Classification: `discharges-supplied-hypothesis`.

Packet type: dynamic-leaf proof-scout packet for the Brownian/Ito frozen
backend.

Exact supplied hypothesis discharged:

```lean
hBrownianCoordinateGeneratorNormalizedLawDef
```

It is no longer a primitive input to
`hBrownianCoordinateGeneratorSourceIntegralDef`.  The lower_2 theorem should
derive it from the scalar Brownian coordinate pushforward fields and then feed
the derived law-integral identity into the standard-Gaussian coordinate-law
bridge.

Target theorem shape:

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfScalarPushforwardAndStdGaussianVectorLaw
```

Source anchors: `appendix.tex:958-970`, `appendix.tex:983-996`,
`appendix.tex:1161-1170`, and `appendix.tex:1379-1387`.

## Boundary

The old source-integral backend asks for

```lean
hBrownianCoordinateGeneratorNormalizedLawDef :
  testRegular ->
    forall phi x i,
      brownianCoordinateGenerator phi x i =
        integral (fun z =>
          sourceTaylorIntegrand phi x i z)
          (normalizedCoordinateLaw phi x i)
```

as a primitive supplied field.  The smaller source-cited package is:

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hSourceTaylorIntegrandMeas
hGeneratorPullbackDef
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
```

The conclusion needed by the source-integral bridge is:

```lean
testRegular ->
  forall phi x i,
    brownianCoordinateGenerator phi x i =
      integral (fun z =>
        sourceTaylorIntegrand phi x i z)
        (ProbabilityTheory.gaussianReal 0 (variance phi x i))
```

## Classical Route

Fix `htests : testRegular`, a selected test `phi`, state `x`, and coordinate
`i`.  Let `Z = scalarBrownianCoordinate phi x i` on the frozen-interpolation
sample space with law `P`.

1. The frozen interpolation in `appendix.tex:983-996`, together with the
   normalized Brownian increment in `appendix.tex:1161-1170`, supplies the
   scalar coordinate `Z`.  The source field `hNormalizedCoordinateLawDef`
   states that `normalizedCoordinateLaw phi x i` is `Measure.map Z P`, and
   `hScalarMeas` supplies the a.e. measurability needed by
   `MeasureTheory.integral_map`.

2. The source integrand is measurable under this scalar law by
   `hSourceTaylorIntegrandMeas`.  After rewriting
   `normalizedCoordinateLaw phi x i` by `hNormalizedCoordinateLawDef`, this is
   the exact integrability side condition for `integral_map`.

3. `hGeneratorPullbackDef` identifies `brownianCoordinateGenerator phi x i`
   with the sample-space integral of
   `sourceTaylorIntegrand phi x i (Z omega)`.  Applying
   `MeasureTheory.integral_map` in reverse converts that sample-space integral
   to the law-space integral under `normalizedCoordinateLaw phi x i`.  This is
   exactly the local bridge
   `SALD.selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward`.

4. The Gaussian packaging is separate.  The source Brownian increment has
   standard vector Gaussian law after normalization by `hNormalizedVectorLaw`.
   The coordinate law field `hCoordinateLawDef` rewrites the scalar coordinate
   law as the map of `ProbabilityTheory.stdGaussian E` through the
   `stdOrthonormalBasis` coordinate.  The existing local SALD bridge uses
   Mathlib Gaussian map facts to rewrite this coordinate law to
   `ProbabilityTheory.gaussianReal 0 1`.

5. The variance field `hVarianceDef`, through the existing local SALD variance
   bridge, rewrites `variance phi x i` to `1`, so the final integral has the
   paper-facing shape
   `ProbabilityTheory.gaussianReal 0 (variance phi x i)`.

Combining steps 3-5 gives the source-integral statement without taking
`hBrownianCoordinateGeneratorNormalizedLawDef` as an independent hypothesis.
The weak-Fokker--Planck diffusion coefficient `sigma_eta^2/2` from
`appendix.tex:1379-1387` stays outside this scalar law leaf.

## Lean Proof Route

Use the existing local SALD scalar-pushforward bridge:

```lean
selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward
  P scalarBrownianCoordinate brownianCoordinateGenerator
  normalizedCoordinateLaw sourceTaylorIntegrand testRegular
  hScalarMeas hNormalizedCoordinateLawDef hSourceTaylorIntegrandMeas
  hGeneratorPullbackDef
```

Then pass the result as the normalized-law hypothesis to:

```lean
selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw
  brownianCoordinateGenerator variance normalizedVectorLaw
  normalizedCoordinateLaw sourceTaylorIntegrand testRegular
```

with `hNormalizedVectorLaw`, `hCoordinateLawDef`, and `hVarianceDef`.

Expected proof body:

```lean
by
  exact
    selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw
      brownianCoordinateGenerator variance normalizedVectorLaw
      normalizedCoordinateLaw sourceTaylorIntegrand testRegular
      (selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward
        P scalarBrownianCoordinate brownianCoordinateGenerator
        normalizedCoordinateLaw sourceTaylorIntegrand testRegular
        hScalarMeas hNormalizedCoordinateLawDef hSourceTaylorIntegrandMeas
        hGeneratorPullbackDef)
      hNormalizedVectorLaw hCoordinateLawDef hVarianceDef
```

## Lower_2 Handoff

Implement exactly one theorem/proof block:

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfScalarPushforwardAndStdGaussianVectorLaw
```

The theorem should discharge `hBrownianCoordinateGeneratorNormalizedLawDef`
inside `hBrownianCoordinateGeneratorSourceIntegralDef` using only local SALD
declarations and Mathlib measure/Gaussian infrastructure already imported by
`AutoSamplingTheory/SALD.lean`.  No external SLT theorem should be imported,
called, queued, or marked formalized.

Remaining backend after this packet:

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

Rejected work for this packet: source-Hessian re-audit, `testRegular`
repackaging, VP score-Hessian substitution, wrapper churn, broad theorem-route
audit, `sald_version_2.tex`, and moving the `sigma_eta^2/2` weak-FP
coefficient into this scalar coordinate-law leaf.
