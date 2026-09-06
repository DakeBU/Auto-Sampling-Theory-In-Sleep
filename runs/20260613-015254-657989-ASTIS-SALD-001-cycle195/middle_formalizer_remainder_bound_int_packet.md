# Cycle 195 Middle Formalizer Packet

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet for the Brownian/Ito frozen backend
feeding `sald.general_moving_target_discrete.em_interpolation_fp`.

Exact missing theorem boundary narrowed:

```lean
hRemainderBoundInt :
  testRegular ->
    forall phi x i,
      MeasureTheory.Integrable
        (fun z : Real => remainderBound phi x i z)
        (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i))
```

Cycle-195 lower target: reduce this Gaussian-law integrability hypothesis to
the normalized-coordinate-law hypothesis

```lean
hNormalizedRemainderBoundInt :
  testRegular ->
    forall phi x i,
      MeasureTheory.Integrable
        (fun z : Real => remainderBound phi x i z)
        (normalizedCoordinateLaw phi x i)
```

via a compiled local theorem tentatively named

```lean
SALD.selectedWeakTestRemainderBoundIntegrableOfStdGaussianVectorLaw
```

The proof should mirror the accepted cycle-194 transports
`SALD.selectedWeakTestRemainderMeasOfStdGaussianVectorLaw` and
`SALD.selectedWeakTestRemainderBoundOfStdGaussianVectorLaw`: derive
`normalizedCoordinateLaw phi x i = ProbabilityTheory.gaussianReal 0 1` from
`SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`, derive
`variance phi x i = 1` from
`SALD.selectedWeakTestNormalizedVarianceDefOfGaussianRealUnitLaw`, and finish
with equality transport/simpa for `MeasureTheory.Integrable`.

## Source Correspondence

Source anchors:

- `appendix.tex:958-970`: normalized Brownian coordinate setup.
- `appendix.tex:983-996`: frozen EM interpolation
  `eq:general_moving_target_SALD_frozen_interp`.
- `appendix.tex:1161-1170`: increment/coordinate moment control feeding the
  Taylor backend.
- `appendix.tex:1379-1387`: weak Fokker-Planck line that consumes the
  Brownian/Ito generator backend downstream.

This packet does not revisit `hSourceHasHessian` or `hSourceHessianBound`;
they remain documented source-contract gaps. It also does not create a
source-Hessian wrapper, a `testRegular` repackaging, a VP score-Hessian route,
an SLT dependency, or a broad theorem-route audit.

## Lower_1 Task

Write the natural-language proof route for exactly this ticket. Show that the
ambient measure in `hRemainderBoundInt` is definitionally/equality equivalent
to `normalizedCoordinateLaw phi x i` after applying the local normalized
coordinate-law and variance-one bridges. The only analytic object being
transported is `MeasureTheory.Integrable` for the already chosen
`remainderBound`.

Do not reprove measurability or domination; cycle 194 already supplied
`hRemainderMeas` and narrowed `hRemainderBound`.

## Lower_2 Task

Implement exactly one compiled theorem in `AutoSamplingTheory/SALD.lean`:

```lean
theorem selectedWeakTestRemainderBoundIntegrableOfStdGaussianVectorLaw
    {Test E : Type*} [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E] [MeasurableSpace E] [BorelSpace E]
    (variance : Test -> E -> Fin (Module.finrank Real E) -> NNReal)
    (normalizedVectorLaw : Test -> E -> MeasureTheory.Measure E)
    (normalizedCoordinateLaw :
      Test -> E -> Fin (Module.finrank Real E) -> MeasureTheory.Measure Real)
    (remainderBound :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (testRegular : Prop)
    (hNormalizedRemainderBoundInt :
      testRegular ->
        forall phi x i,
          MeasureTheory.Integrable
            (fun z : Real => remainderBound phi x i z)
            (normalizedCoordinateLaw phi x i))
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
        MeasureTheory.Integrable
          (fun z : Real => remainderBound phi x i z)
          (ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i))
```

If it compiles, expose it through
`AutoSamplingTheory/TechnicalLemmas/SALDExtracted.lean` and add a registry row
such as `sald.remainder-bound-integrable-gaussian-law` only after the gate
passes. If it does not compile, record the strictly smaller typed verifier
feedback rather than replacing the target with a wrapper.

## Reviewer Checklist

- `python3 tools/astis.py check` must pass.
- The result must be ASTIS-owned and compiled before any registry status says
  `formalized-local`.
- The boundary must strictly reduce `hRemainderBoundInt`; it cannot merely
  rename the same Gaussian-law hypothesis.
- No external SLT declaration is imported, called, queued, or marked
  formalized.
