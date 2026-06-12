# Cycle 190 lower_1 route: remainder-limit scalar-pushforward bridge

Classification: `discharges-supplied-hypothesis`.

Packet type: dynamic-leaf worker packet.

Exact supplied hypothesis discharged:

```lean
hRemainderGeneratorNormalizedLawDef
```

inside the source-facing `hRemainderGeneratorLimitDef` backend.

## Target theorem for lower_2

Implement one compiled local bridge:

```lean
SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw
```

Expected result:

```lean
testRegular ->
  forall phi x i,
    remainderGeneratorLimit phi x i =
      integral (fun z : Real => normalizedRemainder phi x i z)
        (ProbabilityTheory.gaussianReal 0 (variance phi x i))
```

The theorem should derive this directly from the scalar-pushforward source
fields:

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hNormalizedRemainderMeas
hRemainderPullbackDef
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
```

and should not require `hRemainderGeneratorNormalizedLawDef` as a supplied
hypothesis.

## Source route

Source anchors:

- `appendix.tex:958-970`: the EM step uses an iid standard Gaussian vector
  `xi_k ~ N(0, I_d)`.
- `appendix.tex:983-996`: the frozen interpolation has the Brownian increment
  term `sigma_eta (W_s - W_{s_k})`.
- `appendix.tex:1161-1170`: the same increment is written as a scaled standard
  Gaussian vector `sigma_eta(t(s)) * sqrt(s - s_k) * xi`.
- `appendix.tex:1379-1387`: the weak-Fokker--Planck diffusion term keeps the
  `sigma_eta^2 / 2` prefactor outside this scalar coordinate-law leaf.

Classically, for a fixed selected test `phi`, base point `x`, and coordinate
`i`, let `Z_i` be the normalized scalar Brownian coordinate obtained by
projecting the normalized vector increment onto the `i`th standard
orthonormal-basis direction.  The paper source gives two independent facts:

1. the law of `Z_i` is the pushforward of the frozen-interpolation sample law
   by the scalar-coordinate map;
2. the normalized vector increment is standard Gaussian, hence the coordinate
   law of `Z_i` is `N(0, 1)`.

The remainder contribution is first a sample-space expectation of
`normalizedRemainder phi x i (Z_i omega)`.  By the pushforward-law definition
and `integral_map`, this becomes the law-space integral under
`normalizedCoordinateLaw phi x i`.  Then the already compiled Gaussian
coordinate-law bridge rewrites that law to `gaussianReal 0 1`, and the
compiled variance bridge rewrites `variance phi x i` to `1`, yielding the
required integral under `gaussianReal 0 (variance phi x i)`.

## Lean route

The proof should be a direct composition:

1. Build the local intermediate value
   `hRemainderGeneratorNormalizedLawDef` by applying
   `SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward`
   to `P`, `scalarBrownianCoordinate`, `remainderGeneratorLimit`,
   `normalizedCoordinateLaw`, `normalizedRemainder`, `testRegular`,
   `hScalarMeas`, `hNormalizedCoordinateLawDef`,
   `hNormalizedRemainderMeas`, and `hRemainderPullbackDef`.

2. Feed that intermediate into
   `SALD.selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw`
   with `remainderGeneratorLimit`, `variance`, `normalizedVectorLaw`,
   `normalizedCoordinateLaw`, `normalizedRemainder`, `testRegular`,
   `hNormalizedVectorLaw`, `hCoordinateLawDef`, and `hVarianceDef`.

No new analytic theorem is needed.  The first bridge is exactly the
`MeasureTheory.integral_map` transport step; the second bridge reuses the
existing local SALD Gaussian coordinate-law and variance-packaging results.

## Hypotheses that remain open

This packet intentionally leaves the following as source-cited or technical
backend fields:

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hNormalizedRemainderMeas
hRemainderPullbackDef
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
hRemainderMeas
hRemainderBound
hRemainderBoundInt
```

It also leaves the selected weak-test Hessian source-contract fields frozen as
documented gaps:

```lean
hSourceHasHessian
hSourceHessianBound
```

No external SLT theorem is imported, called, queued as formalized, or used as a
runtime dependency.  The packet does not move the weak-FP
`sigma_eta^2 / 2` factor into the scalar event field and does not touch
source-Hessian wrappers, `testRegular` repackaging, VP score-Hessian
substitution, or `sald_version_2.tex`.

## Lower_2 handoff

Implement exactly one theorem/proof block:

```lean
theorem selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw
    {Omega Test E : Type*} [MeasurableSpace Omega]
    [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E] [MeasurableSpace E] [BorelSpace E]
    (P : MeasureTheory.Measure Omega)
    (scalarBrownianCoordinate :
      Test -> E -> Fin (Module.finrank Real E) -> Omega -> Real)
    (remainderGeneratorLimit :
      Test -> E -> Fin (Module.finrank Real E) -> Real)
    (variance : Test -> E -> Fin (Module.finrank Real E) -> NNReal)
    (normalizedVectorLaw : Test -> E -> MeasureTheory.Measure E)
    (normalizedCoordinateLaw :
      Test -> E -> Fin (Module.finrank Real E) -> MeasureTheory.Measure Real)
    (normalizedRemainder :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (testRegular : Prop)
    (hScalarMeas :
      testRegular ->
        forall phi x i,
          AEMeasurable (scalarBrownianCoordinate phi x i) P)
    (hNormalizedCoordinateLawDef :
      testRegular ->
        forall phi x i,
          normalizedCoordinateLaw phi x i =
            MeasureTheory.Measure.map
              (scalarBrownianCoordinate phi x i) P)
    (hNormalizedRemainderMeas :
      testRegular ->
        forall phi x i,
          MeasureTheory.AEStronglyMeasurable
            (normalizedRemainder phi x i)
            (normalizedCoordinateLaw phi x i))
    (hRemainderPullbackDef :
      testRegular ->
        forall phi x i,
          remainderGeneratorLimit phi x i =
            integral
              (fun omega : Omega =>
                normalizedRemainder phi x i
                  (scalarBrownianCoordinate phi x i omega)) P)
    (hNormalizedVectorLaw :
      testRegular ->
        forall phi x, normalizedVectorLaw phi x = ProbabilityTheory.stdGaussian E)
    (hCoordinateLawDef :
      testRegular ->
        forall phi x i,
          normalizedCoordinateLaw phi x i =
            (normalizedVectorLaw phi x).map
              (fun y : E => inner Real ((stdOrthonormalBasis Real E) i) y))
    (hVarianceDef :
      testRegular ->
        forall phi x i,
          (variance phi x i : Real) =
            ProbabilityTheory.variance (id : Real -> Real)
              (normalizedCoordinateLaw phi x i)) :
    testRegular ->
      forall phi x i,
        remainderGeneratorLimit phi x i =
          integral (fun z : Real => normalizedRemainder phi x i z)
            (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i))
```

Suggested proof body:

```lean
by
  exact
    selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw
      remainderGeneratorLimit variance normalizedVectorLaw
      normalizedCoordinateLaw normalizedRemainder testRegular
      (selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward
        P scalarBrownianCoordinate remainderGeneratorLimit
        normalizedCoordinateLaw normalizedRemainder testRegular
        hScalarMeas hNormalizedCoordinateLawDef hNormalizedRemainderMeas
        hRemainderPullbackDef)
      hNormalizedVectorLaw hCoordinateLawDef hVarianceDef
```
