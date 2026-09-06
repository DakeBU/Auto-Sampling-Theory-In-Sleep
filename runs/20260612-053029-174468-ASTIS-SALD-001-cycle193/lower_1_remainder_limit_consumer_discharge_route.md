# Cycle 193 Lower_1 Route: Remainder-Limit Consumer Discharge

Classification: `discharges-supplied-hypothesis`.

Packet type: dynamic-leaf proof-scout packet.

Exact supplied hypothesis discharged:

```lean
hRemainderGeneratorLimitDef
```

inside the Taylor moment decomposition consumer:

```lean
SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder
```

This packet is the one-ticket remainder-limit half of the cycle-193 Brownian/Ito
frozen backend.  It does not rework the already discharged
`hBrownianCoordinateGeneratorTaylorIntegralDef` route.

## Source Anchors

- `appendix.tex:958-970`: the Euler--Maruyama step uses an iid standard
  Gaussian vector `xi_k ~ N(0, I_d)`.
- `appendix.tex:983-996`: the frozen interpolation contains the Brownian
  increment term `sigma_eta (W_s - W_{s_k})`.
- `appendix.tex:1161-1170`: the same increment is represented as
  `sigma_eta(t(s)) * sqrt(s - s_k) * xi`, with `xi ~ N(0, I)`.
- `appendix.tex:1379-1387`: the weak Fokker--Planck diffusion coefficient
  `sigma_eta^2 / 2` stays in the surrounding PDE line, outside this normalized
  scalar-coordinate law leaf.

## Classical Proof Route

Fix `htests : testRegular`, a selected weak test `phi`, a state `x`, and a
coordinate `i`.  Let `e_i = stdOrthonormalBasis Real E i`.  The normalized
scalar Brownian coordinate is the projection of the normalized vector Gaussian
increment onto `e_i`; the diffusion scale and time-step factors are not part of
this normalized coordinate.

The source-facing remainder contribution is first a sample-space expectation:

```lean
remainderGeneratorLimit phi x i =
  integral
    (fun omega =>
      normalizedRemainder phi x i
        (scalarBrownianCoordinate phi x i omega)) P
```

The fields

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hNormalizedRemainderMeas
hRemainderPullbackDef
```

turn that sample-space expectation into the law-space integral under
`normalizedCoordinateLaw phi x i`.  In Lean this is exactly the compiled local
bridge

```lean
SALD.selectedWeakTestRemainderGeneratorNormalizedLawDefOfScalarPushforward
```

whose proof is the standard `MeasureTheory.integral_map` transport step with
the required measurability supplied by `hScalarMeas` and
`hNormalizedRemainderMeas`.

The fields

```lean
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
```

then identify the normalized coordinate law with the one-dimensional Gaussian
law used in the Taylor moment split.  This uses the already compiled local
Gaussian coordinate-law and variance packaging inside

```lean
SALD.selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw
```

Composing these two local SALD declarations gives

```lean
SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw
```

and yields the exact remainder definition needed by the consumer:

```lean
testRegular ->
  forall phi x i,
    remainderGeneratorLimit phi x i =
      integral (fun z : Real => normalizedRemainder phi x i z)
        (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i))
```

Finally, feed this derived `hRemainderGeneratorLimitDef` into

```lean
SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder
```

together with the still-explicit
`hBrownianCoordinateGeneratorTaylorIntegralDef`, `hRemainderMeas`,
`hRemainderBound`, and `hRemainderBoundInt`.  The dominated bridge derives
integrability of `normalizedRemainder` by `MeasureTheory.Integrable.mono'` and
then performs the existing Taylor moment integral split.  Thus the Taylor
moment consumer no longer needs `hRemainderGeneratorLimitDef` as a primitive
supplied hypothesis.

## Lower_2-Ready Theorem Shape

Implement exactly one theorem/proof block if the narrower single-hypothesis
consumer bridge is still desired:

```lean
theorem selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsDominatedRemainderAndRemainderLimitScalarPushforward
    {Omega Test E : Type*} [MeasurableSpace Omega]
    [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E] [MeasurableSpace E] [BorelSpace E]
    (P : MeasureTheory.Measure Omega)
    (scalarBrownianCoordinate :
      Test -> E -> Fin (Module.finrank Real E) -> Omega -> Real)
    (brownianCoordinateGenerator :
      Test -> E -> Fin (Module.finrank Real E) -> Real)
    (remainderGeneratorLimit :
      Test -> E -> Fin (Module.finrank Real E) -> Real)
    (variance : Test -> E -> Fin (Module.finrank Real E) -> NNReal)
    (normalizedVectorLaw : Test -> E -> MeasureTheory.Measure E)
    (normalizedCoordinateLaw :
      Test -> E -> Fin (Module.finrank Real E) -> MeasureTheory.Measure Real)
    (linearCoeff quadraticCoeff :
      Test -> E -> Fin (Module.finrank Real E) -> Real)
    (normalizedRemainder remainderBound :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (testRegular : Prop)
    (hBrownianCoordinateGeneratorTaylorIntegralDef :
      testRegular ->
        forall phi x i,
          brownianCoordinateGenerator phi x i =
            integral
              (fun z : Real =>
                linearCoeff phi x i * z +
                  quadraticCoeff phi x i * z ^ 2 +
                  normalizedRemainder phi x i z)
              (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i)))
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
              (normalizedCoordinateLaw phi x i))
    (hRemainderMeas :
      testRegular ->
        forall phi x i,
          MeasureTheory.AEStronglyMeasurable
            (fun z : Real => normalizedRemainder phi x i z)
            (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i)))
    (hRemainderBound :
      testRegular ->
        forall phi x i,
          ∀ᵐ z ∂ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i),
            ‖normalizedRemainder phi x i z‖ <= remainderBound phi x i z)
    (hRemainderBoundInt :
      testRegular ->
        forall phi x i,
          MeasureTheory.Integrable
            (fun z : Real => remainderBound phi x i z)
            (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i))) :
    testRegular ->
      forall phi x i,
        brownianCoordinateGenerator phi x i =
          linearCoeff phi x i *
              (integral (fun z : Real => z)
                (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i))) +
            quadraticCoeff phi x i *
              (integral (fun z : Real => z ^ 2)
                (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i))) +
            remainderGeneratorLimit phi x i := by
  have hRemainderDef :
      testRegular ->
        forall phi x i,
          remainderGeneratorLimit phi x i =
            integral (fun z : Real => normalizedRemainder phi x i z)
              (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i)) :=
    SALD.selectedWeakTestRemainderGeneratorLimitDefOfScalarPushforwardAndStdGaussianVectorLaw
      P scalarBrownianCoordinate remainderGeneratorLimit variance
      normalizedVectorLaw normalizedCoordinateLaw normalizedRemainder
      testRegular hScalarMeas hNormalizedCoordinateLawDef
      hNormalizedRemainderMeas hRemainderPullbackDef hNormalizedVectorLaw
      hCoordinateLawDef hVarianceDef
  exact
    SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder
      brownianCoordinateGenerator variance linearCoeff quadraticCoeff
      remainderGeneratorLimit normalizedRemainder remainderBound testRegular
      hBrownianCoordinateGeneratorTaylorIntegralDef hRemainderMeas
      hRemainderBound hRemainderBoundInt hRemainderDef
```

When implementing in Lean, copy the a.e. bound hypothesis type verbatim from
`SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfIntegralDefsAndDominatedRemainder`
to preserve the exact `∀ᵐ z ∂...` measure expression accepted in this file.

## Already Available Broader Integration Point

The current cycle also has the broader compiled bridge

```lean
SALD.selectedWeakTestFrozenScalarBrownianItoTaylorMomentDecompositionOfScalarPushforwardRawTaylorAndDominatedRemainder
```

which contains this remainder-limit subproof as its local `hRemainderDef` and
also derives `hBrownianCoordinateGeneratorTaylorIntegralDef` from the cycle-192
scalar-pushforward/raw-Taylor bridge.  If lower_2 chooses not to add the
narrower theorem above, the proof block to audit is exactly that local
`hRemainderDef` construction.

## Remaining Boundary After This Ticket

This packet intentionally leaves the following backend fields explicit:

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
source-contract gaps and are not active proof targets.  No external SLT theorem
is imported, called, queued, or marked formalized; no `testRegular`
repackaging, source-Hessian wrapper, VP score-Hessian substitution,
diffusion-coefficient move into the scalar event field, broad route audit, or
`sald_version_2.tex` use is part of this route.
