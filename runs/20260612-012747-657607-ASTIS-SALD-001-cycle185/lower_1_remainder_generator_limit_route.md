Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf proof route, not an illness-area refiner.

Exact boundary narrowed: `hRemainderGeneratorLimitDef` for the
Brownian/Ito frozen backend under
`sald.general_moving_target_discrete.em_interpolation_fp`.

## Route

Treat `hRemainderGeneratorLimitDef` as an integral-definition and law-transport
leaf.  It should not be proved by the later dominated-convergence or vanishing
argument.  The theorem only identifies the scalar remainder contribution
`remainderGeneratorLimit phi x i` with the integral of
`normalizedRemainder phi x i` under the Gaussian law already assigned to the
normalized Brownian coordinate.

The source basis is the frozen interpolation at `appendix.tex:984-995`:
after freezing the drift and score at `s_k`, the only random increment in
the selected coordinate is the Brownian term
`sigma_eta (W_s - W_{s_k})`.  The normalization used in
`appendix.tex:1170-1176` rewrites this increment as a scalar coordinate of
`xi ~ N(0,I)`, with the deterministic drift contribution kept outside the
normalized coordinate.  The weak-Fokker--Planck use at
`appendix.tex:1379-1387` is downstream reuse of this Brownian/Ito backend; it
does not require proving the KL, FI, or integration-by-parts handoff in this
cycle.

Classically, fix `testRegular`, `phi`, `x`, and coordinate `i`.  First define
the remainder contribution on the actual normalized scalar Brownian-coordinate
law:

```lean
hRemainderGeneratorNormalizedLawDef :
  testRegular ->
    forall phi x i,
      remainderGeneratorLimit phi x i =
        ∫ z : Real, normalizedRemainder phi x i z ∂
          normalizedCoordinateLaw phi x i
```

This is the source-facing definition of the remainder generator.  It is a
sibling of the scalar-pushforward source definition that should later connect
`normalizedCoordinateLaw` to the frozen-interpolation sample space; it is not
the same target as the DCT leaves `hRemainderMeas`, `hRemainderBound`, and
`hRemainderBoundInt`.

Then reuse the already established normalized vector/coordinate law and
variance packaging:

```lean
hNormalizedVectorLaw :
  testRegular ->
    forall phi x, normalizedVectorLaw phi x = ProbabilityTheory.stdGaussian E

hCoordinateLawDef :
  testRegular ->
    forall phi x i,
      normalizedCoordinateLaw phi x i =
        (normalizedVectorLaw phi x).map
          (fun y : E => inner Real ((stdOrthonormalBasis Real E) i) y)

hVarianceDef :
  testRegular ->
    forall phi x i,
      (variance phi x i : Real) =
        ProbabilityTheory.variance (id : Real -> Real)
          (normalizedCoordinateLaw phi x i)
```

The local ASTIS law bridges give, for every selected coordinate,
`normalizedCoordinateLaw phi x i = gaussianReal 0 1` and then
`variance phi x i = 1`.  Rewriting the integral in
`hRemainderGeneratorNormalizedLawDef` along these two equalities yields

```lean
hRemainderGeneratorLimitDef :
  testRegular ->
    forall phi x i,
      remainderGeneratorLimit phi x i =
        ∫ z : Real, normalizedRemainder phi x i z ∂
          ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i)
```

No SLT import or upstream call is involved.  The proof is only measure-law
rewriting: use
`SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw` and
`SALD.selectedWeakTestNormalizedVarianceDefOfGaussianRealUnitLaw`, then close
by `rw`/`simpa` on the measure argument of the integral.  No Hessian source
field is needed, and `hSourceHasHessian` / `hSourceHessianBound` remain
documented source-contract gaps.

## Lower_2 Handoff

Implement one bridge with this shape:

```lean
theorem selectedWeakTestRemainderGeneratorLimitDefOfStdGaussianVectorLaw
    {Test E : Type*} [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E] [MeasurableSpace E] [BorelSpace E]
    (remainderGeneratorLimit : Test -> E -> Fin (Module.finrank Real E) -> Real)
    (variance : Test -> E -> Fin (Module.finrank Real E) -> NNReal)
    (normalizedVectorLaw : Test -> E -> MeasureTheory.Measure E)
    (normalizedCoordinateLaw :
      Test -> E -> Fin (Module.finrank Real E) -> MeasureTheory.Measure Real)
    (normalizedRemainder :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (testRegular : Prop)
    (hRemainderGeneratorNormalizedLawDef :
      testRegular ->
        forall phi x i,
          remainderGeneratorLimit phi x i =
            ∫ z : Real, normalizedRemainder phi x i z ∂
              normalizedCoordinateLaw phi x i)
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
          ∫ z : Real, normalizedRemainder phi x i z ∂
            ProbabilityTheory.gaussianReal (0 : Real) (variance phi x i)
```

This strictly smaller boundary leaves open the source-facing
`hRemainderGeneratorNormalizedLawDef` plus the normalized vector/coordinate law
and variance fields.  A later sibling packet should prove the scalar
pushforward/source definition of `hRemainderGeneratorNormalizedLawDef` from the
frozen interpolation.  The concrete remainder measurability, domination,
integrability, and DCT/vanishing work remains downstream.
