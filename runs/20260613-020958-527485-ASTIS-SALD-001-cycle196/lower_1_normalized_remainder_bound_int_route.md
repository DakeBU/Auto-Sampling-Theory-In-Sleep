# Cycle 196 lower_1 normalized-remainder bound integrability route

Classification: `narrows-source-cited-boundary`.

Packet type: dynamic-leaf worker packet.

Exact missing theorem boundary narrowed:

```lean
hNormalizedRemainderBoundInt :
  testRegular ->
    forall phi x i,
      MeasureTheory.Integrable
        (fun z : Real => remainderBound phi x i z)
        (normalizedCoordinateLaw phi x i)
```

Lower_1 narrows this to the smaller source-cited field

```lean
hNormalizedRemainderBoundDef :
  testRegular ->
    forall phi x i z,
      remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
```

together with the already established normalized scalar coordinate law

```lean
hNormalizedCoordinateLaw :
  testRegular ->
    forall phi x i,
      normalizedCoordinateLaw phi x i =
        ProbabilityTheory.gaussianReal (0 : Real) (1 : NNReal)
```

This packet is not a new law-transport wrapper.  Cycle 195 already transported
Gaussian-law `hRemainderBoundInt` to the normalized-coordinate-law side through
`SALD.selectedWeakTestRemainderBoundIntegrableOfStdGaussianVectorLaw`.  The
remaining local proof content is the source-side choice of the concrete
quadratic dominating bound.

## Source Anchors

- `appendix.tex:958-970`: the EM update uses iid standard Gaussian coordinates.
- `appendix.tex:983-996`: the frozen interpolation expresses the Brownian
  increment as the only stochastic part of the step.
- `appendix.tex:1161-1170`: the same increment is rewritten using
  `xi ~ N(0,I)`.
- `appendix.tex:1379-1387`: the weak-Fokker--Planck diffusion term reuses this
  frozen Brownian backend.

The source does not supply the selected weak-test Hessian regularity fields
`hSourceHasHessian` and `hSourceHessianBound`; those remain documented
source-contract gaps and are not used here.

## Classical Proof Route

Fix `htests : testRegular`, `phi`, `x`, and coordinate `i`.  By the normalized
coordinate-law source correspondence, the integration law is
`ProbabilityTheory.gaussianReal 0 1`.  By `hNormalizedRemainderBoundDef`, the
integrand `fun z => remainderBound phi x i z` is pointwise equal to the
quadratic scalar bound

```lean
fun z : Real => remainderBoundC phi x i * z ^ 2
```

under that standard Gaussian law.

The Gaussian moment part is already compiled locally:

```lean
SALD.gaussianRealSelectedTestLineSecondOrderQuadraticBoundIntegrable
  (1 : NNReal) (remainderBoundC phi x i)
```

which gives

```lean
MeasureTheory.Integrable
  (fun z : Real => remainderBoundC phi x i * z ^ 2)
  (ProbabilityTheory.gaussianReal (0 : Real) (1 : NNReal))
```

Transporting this statement by the two equalities above proves the desired
`hNormalizedRemainderBoundInt` instance.

## Lower_2-Ready Theorem

Implement exactly this bridge, or the nearest local file-style variant:

```lean
theorem selectedWeakTestNormalizedRemainderBoundIntOfQuadraticBound
    {Test E : Type*} [NormedAddCommGroup E] [InnerProductSpace Real E]
    [FiniteDimensional Real E]
    (normalizedCoordinateLaw :
      Test -> E -> Fin (Module.finrank Real E) -> MeasureTheory.Measure Real)
    (remainderBound :
      Test -> E -> Fin (Module.finrank Real E) -> Real -> Real)
    (remainderBoundC :
      Test -> E -> Fin (Module.finrank Real E) -> Real)
    (testRegular : Prop)
    (hNormalizedCoordinateLaw :
      testRegular ->
        forall phi x i,
          normalizedCoordinateLaw phi x i =
            ProbabilityTheory.gaussianReal (0 : Real) (1 : NNReal))
    (hNormalizedRemainderBoundDef :
      testRegular ->
        forall phi x i z,
          remainderBound phi x i z = remainderBoundC phi x i * z ^ 2) :
    testRegular ->
      forall phi x i,
        MeasureTheory.Integrable
          (fun z : Real => remainderBound phi x i z)
          (normalizedCoordinateLaw phi x i)
```

Suggested Lean proof skeleton:

```lean
by
  intro htests phi x i
  have hquad :
      MeasureTheory.Integrable
        (fun z : Real => remainderBoundC phi x i * z ^ 2)
        (ProbabilityTheory.gaussianReal (0 : Real) (1 : NNReal)) :=
    SALD.gaussianRealSelectedTestLineSecondOrderQuadraticBoundIntegrable
      (1 : NNReal) (remainderBoundC phi x i)
  have hfun :
      (fun z : Real => remainderBound phi x i z) =
        fun z : Real => remainderBoundC phi x i * z ^ 2 := by
    funext z
    exact hNormalizedRemainderBoundDef htests phi x i z
  simpa [hNormalizedCoordinateLaw htests phi x i, hfun] using hquad
```

If `simpa` does not unfold the function equality in the target, rewrite the
measure first with `rw [hNormalizedCoordinateLaw htests phi x i]`, then use
`simpa [hfun] using hquad`.

## Dependencies

Callable local ASTIS facts:

- `SALD.gaussianRealSelectedTestLineSecondOrderQuadraticBoundIntegrable`
- `SALD.selectedWeakTestRemainderBoundIntegrableOfStdGaussianVectorLaw`, only
  as already accepted downstream context, not as the theorem being repeated.
- `SALD.selectedWeakTestNormalizedCoordinateLawOfStdGaussianVectorLaw`, only if
  lower_2 chooses to derive `hNormalizedCoordinateLaw` from
  `hNormalizedVectorLaw` and `hCoordinateLawDef` instead of taking the direct
  field.

No external SLT declaration is callable, imported, or queued by this route.

## Remaining Boundary

After this bridge, `hNormalizedRemainderBoundInt` is no longer primitive.  The
remaining exact source-cited boundary is `hNormalizedRemainderBoundDef`, the
paper-to-Lean definition that the selected scalar remainder domination bound is
the quadratic function `remainderBoundC phi x i * z ^ 2`.

If lower_2 cannot locate a Lean-side source definition for `remainderBound`, it
should record the smaller ProofObligation with typed verifier feedback:

```text
leaf=hNormalizedRemainderBoundDef
error_class=missing-source-definition
needed_shape=remainderBound phi x i z = remainderBoundC phi x i * z ^ 2
source_lines=appendix.tex:983-996; appendix.tex:1161-1170; appendix.tex:1379-1387
```

