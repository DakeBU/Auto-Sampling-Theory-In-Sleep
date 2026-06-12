# Cycle 192 Lower_1 Route: Taylor Integral Source-Integral Discharge

Classification: `discharges-supplied-hypothesis`.

Packet type: dynamic-leaf proof-scout packet.

Exact supplied hypothesis discharged:

```lean
hBrownianCoordinateGeneratorSourceIntegralDef
```

inside the active target:

```lean
hBrownianCoordinateGeneratorTaylorIntegralDef
```

for the Brownian/Ito frozen-interpolation backend of
`sald.general_moving_target_discrete.em_interpolation_fp`.

## Source Anchors

- `appendix.tex:958-970`: discrete EM setup and normalized Brownian-coordinate
  context.
- `appendix.tex:983-996`: frozen interpolation
  `eq:general_moving_target_SALD_frozen_interp`.
- `appendix.tex:1161-1170`: normalized Gaussian increment representation.
- `appendix.tex:1379-1387`: weak Fokker--Planck Brownian diffusion line that
  consumes the scalar coordinate generator downstream.

The paper's `sigma_eta^2 / 2` weak-FP diffusion coefficient is not part of this
scalar normalized-coordinate leaf; it remains in the surrounding weak-FP action.

## Classical Proof Route

Fix `htests : testRegular`, a selected weak test `phi`, a state `x`, and a
coordinate `i`.  Let `e_i = stdOrthonormalBasis Real E i`.  The frozen
interpolation in `appendix.tex:983-996` represents the Brownian part of
`hat X_s - X_k^eta` through a normalized Gaussian vector increment.  The scalar
coordinate used by the one-dimensional Taylor argument is the pushforward of
that normalized vector along `y |-> inner Real e_i y`.

The already compiled scalar-pushforward bridge gives the first half of the
route.  From

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hSourceTaylorIntegrandMeas
hGeneratorPullbackDef
```

the theorem

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward
```

turns the sample-space definition of `brownianCoordinateGenerator` into the
integral of `sourceTaylorIntegrand` against `normalizedCoordinateLaw`.  This is
just the law-of-the-random-variable step, implemented by
`MeasureTheory.integral_map`.

The standard-Gaussian vector-law bridge gives the second half.  From

```lean
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
```

the theorem

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw
```

rewrites the scalar coordinate law as
`ProbabilityTheory.gaussianReal 0 (variance phi x i)`.  Composed with the
scalar-pushforward result, this is exactly the compiled theorem

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfScalarPushforwardAndStdGaussianVectorLaw
```

and produces a local proof of

```lean
testRegular ->
  forall phi x i,
    brownianCoordinateGenerator phi x i =
      integral (fun z => sourceTaylorIntegrand phi x i z)
        (ProbabilityTheory.gaussianReal 0 (variance phi x i))
```

without taking `hBrownianCoordinateGeneratorSourceIntegralDef` as a primitive
field.

Now feed this derived source-integral field into the existing raw selected-line
Taylor bridge

```lean
SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralRawTaylorAndTermDefs
```

together with the remaining source Taylor fields:

```lean
hSourceTaylorIntegrandRawDef
hSelectedLineTaylorRawSplitDef
hSourceLinearTermTaylorDef
hScalarLineFirstCoeffDef
hSourceQuadraticTermTaylorDef
hScalarLineTaylorCoeffDef
```

This bridge first rewrites `sourceTaylorIntegrand phi x i z` as the selected
line increment

```lean
selectedTest phi (x + z • e_i) - selectedTest phi x
```

then applies the raw one-dimensional Taylor split along
`q |-> selectedTest phi (x + q • e_i)`, then replaces the raw first and second
Taylor terms by the local names `linearCoeff` and `quadraticCoeff`.  Its
pointwise equality is converted to an a.e. equality under the Gaussian scalar
law, and `MeasureTheory.integral_congr_ae` gives the Taylor integral:

```lean
brownianCoordinateGenerator phi x i =
  integral
    (fun z =>
      linearCoeff phi x i * z +
        quadraticCoeff phi x i * z ^ 2 +
        normalizedRemainder phi x i z)
    (ProbabilityTheory.gaussianReal 0 (variance phi x i))
```

This is exactly `hBrownianCoordinateGeneratorTaylorIntegralDef`.

## Expected Lean Theorem Shape

Lower_2 should implement the bridge below, preferably in `AutoSamplingTheory/SALD.lean`
near the cycle-191 source-integral scalar-pushforward theorem and the cycle-189
raw Taylor bridge.

```lean
theorem selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfScalarPushforwardRawTaylorAndTermDefs
    {Omega Test E : Type*} [MeasurableSpace Omega]
    [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E] [MeasurableSpace E] [BorelSpace E]
    (P : MeasureTheory.Measure Omega)
    (selectedTest : Test -> E -> Real)
    (scalarBrownianCoordinate :
      Test -> E -> Fin (Module.finrank Real E) -> Omega -> Real)
    (brownianCoordinateGenerator :
      Test -> E -> Fin (Module.finrank Real E) -> Real)
    (variance : Test -> E -> Fin (Module.finrank Real E) -> NNReal)
    (normalizedVectorLaw : Test -> E -> MeasureTheory.Measure E)
    (normalizedCoordinateLaw :
      Test -> E -> Fin (Module.finrank Real E) -> MeasureTheory.Measure Real)
    (linearCoeff quadraticCoeff :
      Test -> E -> Fin (Module.finrank Real E) -> Real)
    (sourceLinearTerm sourceQuadraticTerm normalizedRemainder sourceTaylorIntegrand :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (testRegular : Prop)
    (hScalarMeas : ...)
    (hNormalizedCoordinateLawDef : ...)
    (hSourceTaylorIntegrandMeas : ...)
    (hGeneratorPullbackDef : ...)
    (hNormalizedVectorLaw : ...)
    (hCoordinateLawDef : ...)
    (hVarianceDef : ...)
    (hSourceTaylorIntegrandRawDef : ...)
    (hSelectedLineTaylorRawSplitDef : ...)
    (hSourceLinearTermTaylorDef : ...)
    (hScalarLineFirstCoeffDef : ...)
    (hSourceQuadraticTermTaylorDef : ...)
    (hScalarLineTaylorCoeffDef : ...) :
    testRegular ->
      forall phi x i,
        brownianCoordinateGenerator phi x i =
          integral
            (fun z : Real =>
              linearCoeff phi x i * z +
                quadraticCoeff phi x i * z ^ 2 +
                normalizedRemainder phi x i z)
            (ProbabilityTheory.gaussianReal 0 (variance phi x i)) := by
  have hSourceIntegral :
      testRegular ->
        forall phi x i,
          brownianCoordinateGenerator phi x i =
            integral (fun z : Real => sourceTaylorIntegrand phi x i z)
              (ProbabilityTheory.gaussianReal 0 (variance phi x i)) :=
    SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfScalarPushforwardAndStdGaussianVectorLaw
      P scalarBrownianCoordinate brownianCoordinateGenerator variance
      normalizedVectorLaw normalizedCoordinateLaw sourceTaylorIntegrand
      testRegular hScalarMeas hNormalizedCoordinateLawDef
      hSourceTaylorIntegrandMeas hGeneratorPullbackDef
      hNormalizedVectorLaw hCoordinateLawDef hVarianceDef
  exact
    SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralRawTaylorAndTermDefs
      selectedTest brownianCoordinateGenerator variance linearCoeff quadraticCoeff
      sourceLinearTerm sourceQuadraticTerm normalizedRemainder
      sourceTaylorIntegrand testRegular hSourceIntegral
      hSourceTaylorIntegrandRawDef hSelectedLineTaylorRawSplitDef
      hSourceLinearTermTaylorDef hScalarLineFirstCoeffDef
      hSourceQuadraticTermTaylorDef hScalarLineTaylorCoeffDef
```

The omitted hypothesis types should be copied verbatim from:

- `SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfScalarPushforwardAndStdGaussianVectorLaw`
- `SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralRawTaylorAndTermDefs`

## Remaining Boundary After The Bridge

After this theorem compiles, the Taylor integral ticket should no longer list
`hBrownianCoordinateGeneratorSourceIntegralDef` as a primitive supplied
hypothesis.  The remaining exact Brownian/Ito backend is:

```lean
hScalarMeas
hNormalizedCoordinateLawDef
hSourceTaylorIntegrandMeas
hGeneratorPullbackDef
hNormalizedVectorLaw
hCoordinateLawDef
hVarianceDef
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

`hSourceHasHessian` and `hSourceHessianBound` remain documented source-contract
gaps and are not active targets for this packet.

## Local Declarations Used

- `SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfScalarPushforwardAndStdGaussianVectorLaw`
- `SALD.selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward`
- `SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw`
- `SALD.selectedWeakTestBrownianCoordinateGeneratorTaylorIntegralDefOfSourceIntegralRawTaylorAndTermDefs`
- `MeasureTheory.integral_map` and the Mathlib Gaussian coordinate-law facts
  already encapsulated by the compiled local SALD bridges.

No direct external SLT declaration is imported, called, or queued by this
packet.
