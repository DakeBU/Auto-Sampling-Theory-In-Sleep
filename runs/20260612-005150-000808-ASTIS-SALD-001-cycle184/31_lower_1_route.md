# lower_1 route: normalized Brownian coordinate source law

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet.

Exact missing theorem boundary narrowed:
`hBrownianCoordinateGeneratorNormalizedLawDef`, the normalized-law source
definition exposed by the cycle-184 middle bridge for
`hBrownianCoordinateGeneratorSourceIntegralDef`.

Source anchors used:
`appendix.tex:958-996`, especially the EM update and frozen interpolation;
`appendix.tex:1170-1176`, where the Brownian increment is written as
`sigma_eta(t(s)) * sqrt(s - s_k) * xi` with `xi ~ N(0,I)`; and
`appendix.tex:1379-1387`, where the same interpolation is the source for the
conditional-law Fokker-Planck line.  The task-local paper-memory row is
`research-wiki/paper-contributions/SALD/unfinished_source_map.md` entry
`frozen-em-interpolation`.

## Classical route

For fixed `testRegular`, selected test `phi`, state `x`, and coordinate `i`,
introduce the normalized scalar Brownian coordinate random variable

```text
Z_i = <e_i,
  (hat X_s - X_k^eta - (s - s_k) * phi_{t_k}(X_k^eta))
    / (sigma_eta(t(s)) * sqrt(s - s_k))>
```

on the probability space carrying the frozen EM interpolation.  This is just
the coordinate of the normalized Brownian increment from
`eq:general_moving_target_SALD_frozen_interp`; no `sigma_eta^2 / 2` drift
coefficient is moved into the Brownian event field.

Define `normalizedCoordinateLaw phi x i` as the pushforward law
`Measure.map (scalarBrownianCoordinate phi x i) P`.  Define
`brownianCoordinateGenerator phi x i` as the sample-space expectation of the
paper source Taylor integrand evaluated at that scalar coordinate:

```text
brownianCoordinateGenerator phi x i
  = integral omega,
      sourceTaylorIntegrand phi x i
        (scalarBrownianCoordinate phi x i omega) dP
```

Then the desired law-space definition follows by Mathlib's map-integral
transport:

```text
integral z, sourceTaylorIntegrand phi x i z
    d(normalizedCoordinateLaw phi x i)
= integral omega,
    sourceTaylorIntegrand phi x i
      (scalarBrownianCoordinate phi x i omega) dP
```

using `MeasureTheory.integral_map`.  This route does not prove the pointwise
Taylor identity `hSourceTaylorIntegrandPointwise`, the normalized-remainder
limit `hRemainderGeneratorLimitDef`, or the domination package
`hRemainderMeas/hRemainderBound/hRemainderBoundInt`; those remain separate
Brownian/Ito leaves.

## Lower_2 theorem shape

The next compiled theorem should be a pushforward-law bridge, for example:

```lean
theorem selectedWeakTestBrownianCoordinateGeneratorNormalizedLawDefOfScalarPushforward
    {Omega Test E : Type*} [MeasurableSpace Omega]
    [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E]
    (P : MeasureTheory.Measure Omega)
    (scalarBrownianCoordinate :
      Test -> E -> Fin (Module.finrank Real E) -> Omega -> Real)
    (brownianCoordinateGenerator :
      Test -> E -> Fin (Module.finrank Real E) -> Real)
    (normalizedCoordinateLaw :
      Test -> E -> Fin (Module.finrank Real E) -> MeasureTheory.Measure Real)
    (sourceTaylorIntegrand :
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
    (hSourceTaylorIntegrandMeas :
      testRegular ->
        forall phi x i,
          MeasureTheory.AEStronglyMeasurable
            (sourceTaylorIntegrand phi x i)
            (normalizedCoordinateLaw phi x i))
    (hGeneratorPullbackDef :
      testRegular ->
        forall phi x i,
          brownianCoordinateGenerator phi x i =
            integral omega,
              sourceTaylorIntegrand phi x i
                (scalarBrownianCoordinate phi x i omega) dP) :
    testRegular ->
      forall phi x i,
        brownianCoordinateGenerator phi x i =
          integral z,
            sourceTaylorIntegrand phi x i z
              d(normalizedCoordinateLaw phi x i) := by
  intro htests phi x i
  have hfieldMap :
      MeasureTheory.AEStronglyMeasurable
        (sourceTaylorIntegrand phi x i)
        (MeasureTheory.Measure.map
          (scalarBrownianCoordinate phi x i) P) := by
    simpa [hNormalizedCoordinateLawDef htests phi x i]
      using hSourceTaylorIntegrandMeas htests phi x i
  calc
    brownianCoordinateGenerator phi x i =
        integral omega,
          sourceTaylorIntegrand phi x i
            (scalarBrownianCoordinate phi x i omega) dP :=
      hGeneratorPullbackDef htests phi x i
    _ =
        integral z,
          sourceTaylorIntegrand phi x i z
            d(normalizedCoordinateLaw phi x i) := by
      rw [hNormalizedCoordinateLawDef htests phi x i]
      exact (MeasureTheory.integral_map
        (hScalarMeas htests phi x i) hfieldMap).symm
```

Use the existing compiled consumer
`SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw`
after this theorem to recover `hBrownianCoordinateGeneratorSourceIntegralDef`.

Mathlib/local ingredients: `MeasureTheory.integral_map`, local
`SALD.selectedWeakTestBrownianCoordinateGeneratorSourceIntegralDefOfStdGaussianVectorLaw`,
`SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`, and
`SALD.selectedWeakTestNormalizedVarianceDefOfGaussianRealUnitLaw`.  No external
SLT theorem is imported, called, or marked formalized.

Lower_2-ready next block: implement the pushforward-law bridge above, or if the
sample-space symbols do not align with existing SALD parameters, record the
strictly smaller source-cited obligation consisting exactly of
`hScalarMeas`, `hNormalizedCoordinateLawDef`,
`hSourceTaylorIntegrandMeas`, and `hGeneratorPullbackDef`.
